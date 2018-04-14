<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title>주소 검색 / 면적 확인</title>
    <link rel="stylesheet" href="common.css">
</head>
<body>
<input type="hidden" id="scale" value="${scale}">
<input type="hidden" id="efficiencyRate" value="${efficiencyRate}">
<input type="hidden" id="powerTime" value="${powerTime}">
<input type="hidden" id="powerDay" value="${powerDay}">
<input type="hidden" id="smpUnit" value="${smpUnit}">
<input type="hidden" id="recUnit" value="${recUnit}">
<input type="hidden" id="weight" value="${weight}">
<input type="hidden" id="smpRate" value="${smpRate}">
<input type="hidden" id="insuranceRate" value="${insuranceRate}">
<input type="hidden" id="maintenanceUnit" value="${maintenanceUnit}">
<input type="hidden" id="profit" value="${profit}">
<input type="hidden" id="unitPrice" value="${unitPrice}">
<input type="hidden" id="totalInvestment" value="${totalInvestment}">
<input type="hidden" id="myCapital" value="${myCapital}">
<input type="hidden" id="loan" value="${loan}">
<input type="hidden" id="loanPercent" value="${loanPercent}">
<input type="hidden" id="repayPeriod" value="${repayPeriod}">
<input type="hidden" id="drawingPolygon" value="${drawingPolygon}">

<table class="layoutTable">
    <tr>
        <td rowspan="2" width="220px">
            월평균 수익 : <input type="text" name="netIncomeMonthDisplay" id="netIncomeMonthDisplay" value="" class="wDisplay" readonly> <br/>
            년평균 수익 : <input type="text" name="netIncomeYearDisplay" id="netIncomeYearDisplay" value="" class="wDisplay" readonly> <br/>
            평균 수익율 : <input type="text" name="netIncomeRaiteDisplay" id="netIncomeRaiteDisplay" value="" class="wDisplay" readonly>%
        </td>
        <td>
            <div id="map" style="width:100%;height:400px;"></div>
        </td>
    </tr>
    <tr>
        <td>
            <div class="chartjs-wrapper">
                <canvas id="myChart"></canvas>
            </div>
        </td>
    </tr>
</table>
<br/>
<button type="button" onclick="calculationBasis(this.value)" value="show">산출근거</button>
<button type="button" onclick="window.print()">인쇄하기</button>
<p/>

<table id="calculateCostTable" style="display:none ">
    <tr class="tHead">
        <th>구분</th>
        <th colspan="3">수입</th>
        <th colspan="4">지출</th>
        <th></th>
        <th colspan="2">수익총계</th>
    </tr>
    <tr class="tHead">
        <th rowspan="2">연차</th>
        <th rowspan="2">연간전력생산량</th>
        <th>SMP</th>
        <th rowspan="2">연수익</th>
        <th rowspan="2">유지보수비</th>
        <th rowspan="2">보험료</th>
        <th rowspan="2">원금상환</th>
        <th rowspan="2">이자</th>
        <th rowspan="2">상환후잔액</th>
        <th rowspan="2">순수익</th>
        <th rowspan="2">수익률(%)</th>
    </tr>
    <tr class="tHead">
        <th>REC</th>
    </tr>
</table>


<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.7.2/Chart.min.js"></script>
<script src="http://dapi.kakao.com/v2/maps/sdk.js?appkey=${apiKeyDaum}&libraries=services"></script>
<script>
    var labels = new Array();
    var barDataset = new Array();
    var lineDataset = new Array();

    $(document).ready(function () {
        setMap();
        calculateCostTable();
        drawChart();
    });

    function setMap() {
        if(!$('#drawingPolygon').val()) $('#drawingPolygon').val('(36.503296, 127.271260)');

        var centerLat = 0;
        var centerLng = 0;
        var polygonPath = new Array();
        var drawingPolygonData = $('#drawingPolygon').val().split('),(');
        var point;
        $.each(drawingPolygonData, function (i) {
            point = drawingPolygonData[i].split(' ').join('').split('(').join('').split(')').join('').split(',');

            // 다각형을 구성하는 좌표 배열입니다. 이 좌표들을 이어서 다각형을 표시합니다
            polygonPath[i] = new daum.maps.LatLng(point[0]*1, point[1]*1);

            centerLat += point[0]*1;
            centerLng += point[1]*1;
        });

        centerLat = centerLat/drawingPolygonData.length;
        centerLng = centerLng/drawingPolygonData.length;

        var mapContainer = document.getElementById('map'), // 지도를 표시할 div
            mapOption = {
                center: new daum.maps.LatLng(centerLat, centerLng), // 지도의 중심좌표
                level: 6 // 지도의 확대 레벨
            };

        //지도를 미리 생성
        var map = new daum.maps.Map(mapContainer, mapOption);

        // 지도에 표시할 다각형을 생성합니다
        var polygon = new daum.maps.Polygon({
            path: polygonPath, // 그려질 다각형의 좌표 배열입니다
            strokeWeight: 2, // 선의 두께입니다
            strokeColor: '#39DE2A', // 선의 색깔입니다
            strokeOpacity: 0.8, // 선의 불투명도 입니다 1에서 0 사이의 값이며 0에 가까울수록 투명합니다
            strokeStyle: 'longdash', // 선의 스타일입니다
            fillColor: '#A2FF99', // 채우기 색깔입니다
            fillOpacity: 0.4 // 채우기 불투명도 입니다
        });

        // 지도에 다각형을 표시합니다
        polygon.setMap(map);
    }

    function calculateCostTable() {
        var duration = 20;
        var annualPower = 0;
        var totalAnnualPower = 0;
        var smpUnit = 0;
        var smp = 0;
        var recUnit = $('#recUnit').val();
        var weight = $('#weight').val();
        var rec = 0;
        var annualProfit = 0;
        var totalAnnualProfit = 0;
        var maintenanceUnit = $('#maintenanceUnit').val();
        var maintenance = 0;
        var totalMaintenance = 0;
        var insuranceRate = $('#insuranceRate').val();
        var insuranceFee = 0;
        var totalInsuranceFee = 0;
        var loan = $('#loan').val();
        var repayPeriod = $('#repayPeriod').val();
        var repayPeriod2 = repayPeriod;
        var payback = 0;
        var totalPayback = loan;
        var interestCount = 1;
        var leftBalance = loan;
        var profit = $('#profit').val();
        var interest = 0;
        var totalInterest = 0;
        var netIncome = 0;
        var totalNetIncome = 0;
        var totalInvestment = $('#totalInvestment').val();
        var profitRate = 0;

        for (var i = 0; i < duration; i++) {
            labels[i] = i + 1;
            if (i == 0) {
                annualPower = $('#scale').val() * $('#powerTime').val() * $('#powerDay').val();
                totalAnnualPower += annualPower;
                smpUnit = $('#smpUnit').val() * 1;
                smp = annualPower * smpUnit;
                rec = recUnit * weight * annualPower;
                annualProfit = smp + rec;
                totalAnnualProfit += annualProfit;
                maintenance = annualProfit * maintenanceUnit / 100 * 12;
                totalMaintenance += maintenance;
                insuranceFee = annualProfit * insuranceRate / 100 * 12;
                totalInsuranceFee += insuranceFee;
                leftBalance = loan;
                interest = loan * profit / 100;
                totalInterest += interest;
                netIncome = annualProfit - maintenance - interest;
                totalNetIncome += netIncome;
                profitRate = netIncome / totalInvestment * 100;
                $("#calculateCostTable").append("<tr>" +
                    "<th rowspan='2'>" + (i + 1) + "</th>" +
                    "<td rowspan='2'>" + numberWithCommas(annualPower) + "</td>" +
                    "<td>" + numberWithCommas(smp) + "</td>" +
                    "<td rowspan='2'>" + numberWithCommas(annualProfit) + "</td>" +
                    "<td rowspan='2'>" + numberWithCommas(maintenance) + "</td>" +
                    "<td rowspan='2'>" + numberWithCommas(insuranceFee) + "</td>" +
                    "<td rowspan='2'></td>" +
                    "<td rowspan='2'>" + numberWithCommas(interest) + "</td>" +
                    "<td rowspan='2'>" + numberWithCommas(leftBalance) + "</td>" +
                    "<td rowspan='2'>" + numberWithCommas(netIncome) + "</td>" +
                    "<td rowspan='2'>" + numberWithCommas(profitRate) + "%</td>" +
                    "</tr>");
                $("#calculateCostTable").append("<tr>" +
                    "<td>" + numberWithCommas(rec) + "</td>" +
                    "</tr>");
                barDataset[i] = Math.round(netIncome); //순수익
                lineDataset[i] = Math.round(annualProfit); //연수익
            } else {
                annualPower = annualPower * 0.995;
                totalAnnualPower += annualPower;
                smpUnit = smpUnit + (smpUnit * $('#smpRate').val() / 100);
                smp = annualPower * smpUnit;
                rec = recUnit * weight * annualPower;
                annualProfit = smp + rec;
                totalAnnualProfit += annualProfit;
                maintenance = annualProfit * maintenanceUnit / 100 * 12;
                totalMaintenance += maintenance;
                insuranceFee = annualProfit * insuranceRate / 100 * 12;
                totalInsuranceFee += insuranceFee;
                payback = checkNumber(loan / repayPeriod);
                repayPeriod--;
                loan -= payback;
                leftBalance -= payback;
                interest = checkNumber((leftBalance + payback) * profit / 100);
                totalInterest += interest;
                if (interest > 0) interestCount++;
                netIncome = annualProfit - maintenance - payback - interest;
                totalNetIncome += netIncome;
                profitRate = netIncome / totalInvestment * 100;
                $("#calculateCostTable").append("<tr>" +
                    "<th rowspan='2'>" + (i + 1) + "</th>" +
                    "<td rowspan='2'>" + numberWithCommas(annualPower) + "</td>" +
                    "<td>" + numberWithCommas(smp) + "</td>" +
                    "<td rowspan='2'>" + numberWithCommas(annualProfit) + "</td>" +
                    "<td rowspan='2'>" + numberWithCommas(maintenance) + "</td>" +
                    "<td rowspan='2'>" + numberWithCommas(insuranceFee) + "</td>" +
                    "<td rowspan='2'>" + numberWithCommas(payback) + "</td>" +
                    "<td rowspan='2'>" + numberWithCommas(interest) + "</td>" +
                    "<td rowspan='2'>" + numberWithCommas(leftBalance) + "</td>" +
                    "<td rowspan='2'>" + numberWithCommas(netIncome) + "</td>" +
                    "<td rowspan='2'>" + numberWithCommas(profitRate) + "%</td>" +
                    "</tr>");
                $("#calculateCostTable").append("<tr>" +
                    "<td>" + numberWithCommas(rec) + "</td>" +
                    "</tr>");
                barDataset[i] = Math.round(netIncome);
                lineDataset[i] = Math.round(annualProfit);
            }
        }
        $("#calculateCostTable").append("<tr class='tHead'>" +
            "<th>연평균</th>" +
            "<td>" + numberWithCommas(totalAnnualPower / duration) + "</td>" +
            "<td>" + numberWithCommas(totalAnnualProfit / duration) + "</td>" +
            "<td>" + numberWithCommas(totalAnnualProfit / duration) + "</td>" +
            "<td>" + numberWithCommas(totalMaintenance / duration) + "</td>" +
            "<td>" + numberWithCommas(totalInsuranceFee / duration) + "</td>" +
            "<td>" + numberWithCommas(totalPayback / repayPeriod2) + "</td>" +
            "<td>" + numberWithCommas(totalInterest / interestCount) + "</td>" +
            "<td></td>" +
            "<td>" + numberWithCommas(totalNetIncome / duration) + "</td>" +
            "<td>" + numberWithCommas(totalNetIncome / duration / totalInvestment * 100) + "%</td>" +
            "</tr>");
        $("#calculateCostTable").append("<tr class='tHead'>" +
            "<th>누계합계</th>" +
            "<td>" + numberWithCommas(totalAnnualPower) + "</td>" +
            "<td>" + numberWithCommas(totalAnnualProfit) + "</td>" +
            "<td>" + numberWithCommas(totalAnnualProfit) + "</td>" +
            "<td>" + numberWithCommas(totalMaintenance) + "</td>" +
            "<td>" + numberWithCommas(totalInsuranceFee) + "</td>" +
            "<td>" + numberWithCommas(totalPayback) + "</td>" +
            "<td>" + numberWithCommas(totalInterest) + "</td>" +
            "<td></td>" +
            "<td>" + numberWithCommas(totalNetIncome) + "</td>" +
            "<td></td>" +
            "</tr>");

        $("#calculateCostTable").append("<tr><td colspan='11'>&nbsp;</td></tr>");

        $("#calculateCostTable").append("<tr class='tHead'>" +
            "<th>&nbsp;</th>" +
            "<th>매출액</th>" +
            "<th>원금상환</th>" +
            "<th>&nbsp;</th>" +
            "<th>유지보수비</th>" +
            "<th>보험료</th>" +
            "<th>&nbsp;</th>" +
            "<th>이자</th>" +
            "<th>&nbsp;</th>" +
            "<th>순수익</th>" +
            "<th>수익율</th>" +
            "</tr>");
        $("#calculateCostTable").append("<tr>" +
            "<th>1달</th>" +
            "<td>" + numberWithCommas(totalAnnualProfit / duration / 12) + "</td>" +
            "<td>" + numberWithCommas(totalPayback / duration / 12) + "</td>" +
            "<td></td>" +
            "<td>" + numberWithCommas(totalMaintenance / duration / 12) + "</td>" +
            "<td>" + numberWithCommas(totalInsuranceFee / duration / 12) + "</td>" +
            "<td></td>" +
            "<td>" + numberWithCommas(totalInterest / duration / 12) + "</td>" +
            "<td></td>" +
            "<td>" + numberWithCommas(totalNetIncome / duration / 12) + "</td>" +
            "<td rowspan='3'>" + numberWithCommas(totalNetIncome / duration / totalInvestment * 100) + "%</td>" +
            "</tr>");
        $('#netIncomeMonthDisplay').val(numberWithCommas(totalNetIncome / duration / 12));
        $('#netIncomeRaiteDisplay').val(numberWithCommas(totalNetIncome / duration / totalInvestment * 100));
        $("#calculateCostTable").append("<tr>" +
            "<th>1년</th>" +
            "<td>" + numberWithCommas(totalAnnualProfit / duration) + "</td>" +
            "<td>" + numberWithCommas(totalPayback / duration) + "</td>" +
            "<td></td>" +
            "<td>" + numberWithCommas(totalMaintenance / duration) + "</td>" +
            "<td>" + numberWithCommas(totalInsuranceFee / duration) + "</td>" +
            "<td></td>" +
            "<td>" + numberWithCommas(totalInterest / duration) + "</td>" +
            "<td></td>" +
            "<td>" + numberWithCommas(totalNetIncome / duration) + "</td>" +
            "</tr>");
        $('#netIncomeYearDisplay').val(numberWithCommas(totalNetIncome / duration));
        $("#calculateCostTable").append("<tr>" +
            "<th>20년</th>" +
            "<td>" + numberWithCommas(totalAnnualProfit) + "</td>" +
            "<td>" + numberWithCommas(totalPayback) + "</td>" +
            "<td></td>" +
            "<td>" + numberWithCommas(totalMaintenance) + "</td>" +
            "<td>" + numberWithCommas(totalInsuranceFee) + "</td>" +
            "<td></td>" +
            "<td>" + numberWithCommas(totalInterest) + "</td>" +
            "<td></td>" +
            "<td>" + numberWithCommas(totalNetIncome) + "</td>" +
            "</tr>");
    }

    // 천단위 콤마(,) 표시 및 소숫점 이하 반올림 처리
    function numberWithCommas(cellValue) {
        if (cellValue == null || cellValue === '' || cellValue === 'undefined') return 0;
        return Math.round(cellValue).toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
    }

    // Value가 0 이하일 경우 0으로 처리
    function checkNumber(value) {
        if (isNaN(value)) return 0; else return value;
    }

    function calculationBasis(type) {
        $('#calculateCostTable').toggle();
    }

    // 그래프
    function drawChart() {
        new Chart($("#myChart"), {
            "type": "bar",
            "data": {
                "labels": labels, // x-axis
                "datasets": [{
                    "label": "순수익",
                    "data": barDataset,
                    "borderColor": "rgb(255, 99, 132)",
                    "backgroundColor": "rgba(255, 99, 132, 0.2)"
                }, {
                    "label": "연수익",
                    "data": lineDataset,
                    "type": "line",
                    "fill": false,
                    "borderColor": "rgb(54, 162, 235)"
                }]
            },
            "options": {
                tooltips: {
                    mode: 'label',
                    callbacks: {
                        label: function(tooltipItem, data) {
                            return tooltipItem.yLabel.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ","); }, },
                },
                "scales": {
                    "xAxes":[{
                        scaleLabel: {
                            display: true,
                            labelString: '연차(년)'
                        }
                    }],
                    "yAxes": [{
                        scaleLabel: {
                            display: true,
                            labelString: '매출액(원)'
                        },
                        ticks: {
                            beginAtZero:true,
                            userCallback: function(value, index, values) {
                                value = value.toString();
                                value = value.split(/(?=(?:...)*$)/);
                                value = value.join(',');
                                return value;
                            }
                        }
                    }]
                }
            }
        });
    }
</script>
</body>
</html>