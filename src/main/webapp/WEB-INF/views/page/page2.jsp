<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix = "c" uri = "http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix = "fmt" uri = "http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title>주소 검색 / 면적 확인</title>
    <link rel="stylesheet" href="common.css">
    <style type="text/css">

	@media print {

		@page {

			size:auto;

			margin-top:2.5cm;

			margin-right:2cm;

			margin-bottom:1.5cm;

			margin-left:2cm;

		}

		html, body { border:0; margin:0; padding:0; }

		#printable { display:block; }

		#non-printable { display:none; }

		div .breakhere { width:auto;height;0px;page-break-before:always;line-height:0px; }

	}

</style>
</head>
<body>
    
<h1>태양광 발전소 수익성 시뮬레이션</h1>
<form>
    
     <div class="area3">
        <div id="areatitle3">주소</div>
         <input id="address" value="${address}"> </div>
    <input type="hidden" id="powerDay" value="${powerDay}">
    <input type="hidden" id="drawingPolygon" value="${drawingPolygon}">

    <div id="map" style="width:100%;height:300px;"></div>
<div class="contents">
        
            <div class="sec1">
                <ul>
                    <li>지번구역 면적</li>
                    <li><input text="text" id="polyAreaMeterPeang" name="polyAreaMeterPeang" value="${polyAreaMeterPeang}" onkeyup="calculatePolyAreaMeterPeang(this)">평</li>
                    <li><input type="text" id="polyAreaMeter" name="polyAreaMeter" value="${polyAreaMeter}" onkeyup="calculatePolyAreaMeter(this)">㎡</li>
                </ul>

                <ul>
                    <li>마우스선택 면적</li>
                    <li><input text="text" id="polyPathPeang" name="polyPathPeang" value="${polyPathPeang}" onkeyup="calculatePolyPathPeang(this)">평</li>
                    <li><input type="text" id="polyPathMeter" name="polyPathMeter" value="${polyPathMeter}" onkeyup="calculatePolyPathMeter(this)">㎡</li>
                </ul>
            </div>
            <span class="sectitle">기본조건</span>
            <div class="sec2">                
                <ul class="field00">
                    <li>총면적</li><li>설치용량</li><li>REC단가</li><li>REC가중치</li><li>SMP단가</li>
                </ul>
                <ul class="inputtext">
                    <li><input type="text" id="polyPathMeter" name="polyPathMeter" value="" onkeyup="calculatePolyPathMeter(this)">㎡</li>
                    <li><input type="text" name="scale" id="scale" value="<fmt:formatNumber value="${scale}" type="number"/>" readonly>kw</li>
                    <li><input type="text" name="recUnit" id="recUnit" value="<fmt:formatNumber value="${recUnit}" type="number"/>" readonly>원</li>
                    <li><input type="text" name="weight" id="weight" value="${weight}" readonly>배</li>
                    <li><input type="text" name="smpUnit" id="smpUnit" value="<fmt:formatNumber value="${smpUnit}" type="number"/>">원</li>
                            
                </ul>
                

            </div>
            <span class="sectitle">발전조건</span>
            <div class="sec3">                
                <ul class="field00">
                    <li>일평균 발전시간</li><li>연간 효율저감률</li><li>SMP상승률</li><li>유지보수</li><li>보험료</li>                
                </ul>
                <ul class="inputtext">
                    <li><input type="text" name="powerTime" id="powerTime" value="${powerTime}" readonly>시간</li>
                    <li><input type="text" name="efficiencyRate" id="efficiencyRate" value="${efficiencyRate}">%</li>
                    <li><input type="text" name="smpRate" id="smpRate" value="${smpRate}" readonly>%</li>
                    <li><input type="text" name="maintenanceUnit" id="maintenanceUnit" value="${maintenanceUnit}" readonly>%</li>
                    <li><input type="text" name="insuranceRate" id="insuranceRate" value="${insuranceRate}" readonly>%</li>
                </ul>
               
            </div>
            <span class="sectitle">자금조건</span>
            <div class="sec4">                
                <ul class="field00">
                    <li>총공사비</li><li>설치단가</li><li>금융대출</li><li>자기자본</li><li>금융이율</li><li>상환기간</li>                
                </ul>
                <ul class="inputtext">
                    <li><input type="text" name="totalInvestment" id="totalInvestment" value="<fmt:formatNumber value="${totalInvestment}" type="number"/>" readonly>원</li>
                    <li><input type="text" name="unitPrice" id="unitPrice" value="<fmt:formatNumber value="${unitPrice}" type="number"/>" >원</li>
                    <li><input type="text" name="loanPercent" id="loanPercent" value="${loanPercent}">%
                        <input type="text" name="loan" id="loan" value="<fmt:formatNumber value="${loan}" type="number"/>" readonly>원</li>
                    <li><input type="text" name="myCapital" id="myCapital" value="<fmt:formatNumber value="${myCapital}" type="number"/>" readonly>원</li>
                    <li><input type="text" name="profit" id="profit" value="${profit}">%</li>
                    <li><input type="text" name="repayPeriod" id="repayPeriod" value="${repayPeriod}" readonly>년</li>
                </ul>
               
            </div>
    
    <span class="sectitle">수익성 검토</span>
        <div class="sec5">
            <ul class="field00">
                 <li><span>설치용량</span></li><li><span>연평균 수익</span></li><li><span>월평균 수익</span></li><li><span>수익률</span></li>
            </ul>
            <ul class="inputtext">
                <li><input type="text" name="scale" id="scale" value="<fmt:formatNumber value="${scale}" type="number"/>" readonly>kw</li>
                <li><input type="text" name="netIncomeYearDisplay" id="netIncomeYearDisplay" value="" class="wDisplay" readonly="">원</li>
                <li><input type="text" name="netIncomeMonthDisplay" id="netIncomeMonthDisplay" value="" class="wDisplay" readonly="">원</li>
                <li><input type="text" name="netIncomeRaiteDisplay" id="netIncomeRaiteDisplay" value="" class="wDisplay" readonly="">%</li>
                
            </ul>
        
        </div>
    <br>
    <%--<div class="chartjs-wrapper"  style="display:none ">--%>
            <%--<canvas id="myChart"></canvas>--%>
        <%--</div>--%>
    <div class="chartjs-wrapper"  style="display:none ">
        <canvas id="myChart2"></canvas>
    </div>
    <br>
    <div id="page2button">
   <div class="button show">
     <button type="button" onclick="calculationBasis(this.value)" value="show">산출근거</button>
   </div> 
   <div class="button print">
      <button type="button" onclick="window.print()">인쇄하기</button>
    </div>
    <div class="button back">
      <button type="button" onclick="history.back(-1)">뒤로가기</button>
    </div>
    </div>
        </div>
<br>
            
     <div style="page-break-before: always;" >           
     <table id="calculateCostTable" style="display:none ">
        <tr class="tHead">
            <th>구분</th>
            <th colspan="3" style="background-color: #d6eaff">수입</th>
            <th colspan="4" style="background-color: #ffd6d6">지출</th>
            <th rowspan="3">상환후잔액</th>
            <th colspan="2" style="background-color: #fffed6">수익총계</th>
        </tr>
        <tr class="tHead">
            <th rowspan="2">연차</th>
            <th rowspan="2" style="background-color: #d6eaff">연간전력생산량</th>
            <th style="background-color: #d6eaff">SMP</th>
            <th rowspan="2" style="background-color: #d6eaff">연수익</th>
            <th rowspan="2" style="background-color: #ffd6d6">유지보수비</th>
            <th rowspan="2" style="background-color: #ffd6d6">보험료</th>
            <th rowspan="2" style="background-color: #ffd6d6">원금상환</th>
            <th rowspan="2" style="background-color: #ffd6d6">이자</th>            
            <th rowspan="2" style="background-color: #fffed6">순수익</th>
            <th rowspan="2" style="background-color: #fffed6">수익률(%)</th>
        </tr>
        <tr class="tHead">
            <th style="background-color:#d6eaff">REC</th>
        </tr>
    </table>
</div>
    <br/>
    <p/>



</form>
    
    
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.7.2/Chart.min.js"></script>
<script src="http://dapi.kakao.com/v2/maps/sdk.js?appkey=${apiKeyDaum}&libraries=services"></script>
<script>
    var labels = new Array();
    var barDataset = new Array();
    var lineDataset = new Array();

    var labels2 = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12];
    var capaDataset = [
        [2.03, 2.79, 3.52, 4.38, 4.73, 4.47, 3.32, 3.59, 3.58, 3.10, 2.07, 1.76],
        [2.26, 2.98, 3.73, 4.64, 5.06, 4.89, 4.03, 4.07, 3.77, 3.20, 2.26, 1.99],
        [2.28, 3.06, 3.84, 4.78, 5.16, 4.91, 4.09, 4.24, 3.88, 3.38, 2.34, 1.98],
        [2.24, 2.97, 3.82, 4.77, 5.11, 4.70, 4.11, 4.27, 3.90, 3.49, 2.42, 1.99],
        [2.51, 3.17, 3.87, 4.74, 5.06, 4.70, 4.17, 4.17, 3.70, 3.44, 2.57, 2.30],
        [1.45, 2.34, 3.44, 4.63, 5.13, 4.71, 4.91, 4.61, 3.80, 3.38, 2.21, 1.51]
    ];

    $(document).ready(function () {
        setMap();
        calculateCostTable();
        // drawChart();
        drawChart2();
        $('input').prop('readonly', true);
    });

    function setMap() {
        if (!$('#drawingPolygon').val()) $('#drawingPolygon').val('(36.503296, 127.271260)');

        var centerLat = 0;
        var centerLng = 0;
        var polygonPath = new Array();
        var drawingPolygonData = $('#drawingPolygon').val().split('),(');
        var point;
        $.each(drawingPolygonData, function (i) {
            point = drawingPolygonData[i].split(' ').join('').split('(').join('').split(')').join('').split(',');

            // 다각형을 구성하는 좌표 배열입니다. 이 좌표들을 이어서 다각형을 표시합니다
            polygonPath[i] = new daum.maps.LatLng(point[0] * 1, point[1] * 1);

            centerLat += point[0] * 1;
            centerLng += point[1] * 1;
        });

        centerLat = centerLat / drawingPolygonData.length;
        centerLng = centerLng / drawingPolygonData.length;

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
        var recUnit = replaceAllComma($('#recUnit').val());
        var weight = replaceAllComma($('#weight').val());
        var rec = 0;
        var annualProfit = 0;
        var totalAnnualProfit = 0;
        var maintenanceUnit = replaceAllComma($('#maintenanceUnit').val());
        var maintenance = 0;
        var totalMaintenance = 0;
        var insuranceRate = replaceAllComma($('#insuranceRate').val());
        var insuranceFee = 0;
        var totalInsuranceFee = 0;
        var loan = replaceAllComma($('#loan').val());
        var repayPeriod = replaceAllComma($('#repayPeriod').val());
        var repayPeriod2 = repayPeriod;
        var payback = 0;
        var totalPayback = loan;
        var interestCount = 1;
        var leftBalance = loan;
        var profit = replaceAllComma($('#profit').val());
        var interest = 0;
        var totalInterest = 0;
        var netIncome = 0;
        var totalNetIncome = 0;
        var totalInvestment = replaceAllComma($('#totalInvestment').val());
        var profitRate = 0;

        for (var i = 0; i < duration; i++) {
            labels[i] = i + 1;
            if (i == 0) {
                annualPower = replaceAllComma($('#scale').val()) * replaceAllComma($('#powerTime').val()) * replaceAllComma($('#powerDay').val());
                totalAnnualPower += annualPower;
                smpUnit = replaceAllComma($('#smpUnit').val()) * 1;
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
                console.log("1 =" + netIncome);
                console.log("2 =" + totalInvestment);
                $("#calculateCostTable").append("<tr>" +
                    "<th rowspan='2'>" + (i + 1) + "</th>" +
                    "<td rowspan='2' style='background-color: #d6eaff' >" + numberWithCommas(annualPower) + "</td>" +
                    "<td style='background-color: #d6eaff'>" + numberWithCommas(smp) + "</td>" +
                    "<td rowspan='2' style='background-color: #d6eaff'>" + numberWithCommas(annualProfit) + "</td>" +
                    "<td rowspan='2' style='background-color: #ffd6d6'>" + numberWithCommas(maintenance) + "</td>" +
                    "<td rowspan='2' style='background-color: #ffd6d6'>" + numberWithCommas(insuranceFee) + "</td>" +
                    "<td rowspan='2' style='background-color: #ffd6d6'></td>" +
                    "<td rowspan='2' style='background-color: #ffd6d6'>" + numberWithCommas(interest) + "</td>" +
                    "<td rowspan='2'>" + numberWithCommas(leftBalance) + "</td>" +
                    "<td rowspan='2' style='background-color: #fffed6'>" + numberWithCommas(netIncome) + "</td>" +
                    "<td rowspan='2' style='background-color: #fffed6'>" + numberWithCommas(profitRate) + "%</td>" +
                    "</tr>");
                $("#calculateCostTable").append("<tr>" +
                    "<td style='background-color: #d6eaff'>" + numberWithCommas(rec) + "</td>" +
                    "</tr>");
                barDataset[i] = Math.round(netIncome); //순수익
                lineDataset[i] = Math.round(annualProfit); //연수익
            } else {
                annualPower = annualPower * 0.995;
                totalAnnualPower += annualPower;
                smpUnit = smpUnit + (smpUnit * replaceAllComma($('#smpRate').val()) / 100);
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
                    "<td rowspan='2' style='background-color: #d6eaff'>" + numberWithCommas(annualPower) + "</td>" +
                    "<td style='background-color: #d6eaff'>" + numberWithCommas(smp) + "</td>" +
                    "<td rowspan='2' style='background-color: #d6eaff'>" + numberWithCommas(annualProfit) + "</td>" +
                    "<td rowspan='2' style='background-color: #ffd6d6'>" + numberWithCommas(maintenance) + "</td>" +
                    "<td rowspan='2' style='background-color: #ffd6d6'>" + numberWithCommas(insuranceFee) + "</td>" +
                    "<td rowspan='2' style='background-color: #ffd6d6'>" + numberWithCommas(payback) + "</td>" +
                    "<td rowspan='2' style='background-color: #ffd6d6'>" + numberWithCommas(interest) + "</td>" +
                    "<td rowspan='2'>" + numberWithCommas(leftBalance) + "</td>" +
                    "<td rowspan='2' style='background-color: #fffed6'>" + numberWithCommas(netIncome) + "</td>" +
                    "<td rowspan='2' style='background-color: #fffed6'>" + numberWithCommas(profitRate) + "%</td>" +
                    "</tr>");
                $("#calculateCostTable").append("<tr>" +
                    "<td style='background-color: #d6eaff'>" + numberWithCommas(rec) + "</td>" +
                    "</tr>");
                barDataset[i] = Math.round(netIncome);
                lineDataset[i] = Math.round(annualProfit);
            }
        }
        $("#calculateCostTable").append("<tr class='tHead'>" +
            "<th>연평균</th>" +
            "<td style='background-color: #d6eaff'>" + numberWithCommas(totalAnnualPower / duration) + "</td>" +
            "<td style='background-color: #d6eaff'>" + numberWithCommas(totalAnnualProfit / duration) + "</td>" +
            "<td style='background-color: #d6eaff'>" + numberWithCommas(totalAnnualProfit / duration) + "</td>" +
            "<td style='background-color: #ffd6d6'>" + numberWithCommas(totalMaintenance / duration) + "</td>" +
            "<td style='background-color: #ffd6d6'>" + numberWithCommas(totalInsuranceFee / duration) + "</td>" +
            "<td style='background-color: #ffd6d6'>" + numberWithCommas(totalPayback / repayPeriod2) + "</td>" +
            "<td style='background-color: #ffd6d6'>" + numberWithCommas(totalInterest / interestCount) + "</td>" +
            "<td></td>" +
            "<td style='background-color: #fffed6'>" + numberWithCommas(totalNetIncome / duration) + "</td>" +
            "<td style='background-color: #fffed6'>" + numberWithCommas(totalNetIncome / duration / totalInvestment * 100) + "%</td>" +
            "</tr>");
        $("#calculateCostTable").append("<tr class='tHead'>" +
            "<th>누계합계</th>" +
            "<td style='background-color: #d6eaff'>" + numberWithCommas(totalAnnualPower) + "</td>" +
            "<td style='background-color: #d6eaff'>" + numberWithCommas(totalAnnualProfit) + "</td>" +
            "<td style='background-color: #d6eaff'>" + numberWithCommas(totalAnnualProfit) + "</td>" +
            "<td style='background-color: #ffd6d6'>" + numberWithCommas(totalMaintenance) + "</td>" +
            "<td style='background-color: #ffd6d6'>" + numberWithCommas(totalInsuranceFee) + "</td>" +
            "<td style='background-color: #ffd6d6'>" + numberWithCommas(totalPayback) + "</td>" +
            "<td style='background-color: #ffd6d6'>" + numberWithCommas(totalInterest) + "</td>" +
            "<td></td>" +
            "<td style='background-color: #fffed6'>" + numberWithCommas(totalNetIncome) + "</td>" +
            "<td style='background-color: #fffed6'></td>" +
            "</tr>");

        $("#calculateCostTable").append("<tr><td colspan='11'>&nbsp;</td></tr>");

        $("#calculateCostTable").append("<tr class='tHead' style='background: #39587a;' >" +
            "<th>&nbsp;</th>" +
            "<th style='color:#fff;'>매출액</th>" +
            "<th style='color:#fff;'>원금상환</th>" +
            "<th>&nbsp;</th>" +
            "<th style='color:#fff;'>유지보수비</th>" +
            "<th style='color:#fff;'>보험료</th>" +
            "<th>&nbsp;</th>" +
            "<th style='color:#fff;'>이자</th>" +
            "<th>&nbsp;</th>" +
            "<th style='color:#fff;'>순수익</th>" +
            "<th style='color:#fff;'>수익율</th>" +
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
        $('#netIncomeMonthDisplay').val(numberWithCommas(Math.floor(totalNetIncome / duration / 12 / 1000) * 1000));
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
        $('#netIncomeYearDisplay').val(numberWithCommas(Math.floor(totalNetIncome / duration / 1000) * 1000));
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

    function replaceAllComma(value) {
        return value.split(',').join('');
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
        $('.chartjs-wrapper').toggle();
        
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
                        label: function (tooltipItem, data) {
                            return tooltipItem.yLabel.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
                        },
                    },
                },
                "scales": {
                    "xAxes": [{
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
                            beginAtZero: true,
                            userCallback: function (value, index, values) {
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

    function drawChart2() {
        var scale = replaceAllComma($('#scale').val());
        for (var i = 0; i < capaDataset.length; i++) {
            for (var j = 0; j < capaDataset[i].length; j++) {
                capaDataset[i][j] = capaDataset[i][j] * scale;
            }
        }

        new Chart($("#myChart2"), {
            "type": "line",
            "data": {
                "labels": labels2, // x-axis
                "datasets": [{
                    "label": "서울/경기",
                    "data": capaDataset[0],
                    "type": "line",
                    "fill": false,
                    "borderColor": "rgb(110, 10, 110)"
                }, {
                    "label": "강원도",
                    "data": capaDataset[1],
                    "type": "line",
                    "fill": false,
                    "borderColor": "rgb(20, 120, 120)"
                }, {
                    "label": "충청도",
                    "data": capaDataset[2],
                    "type": "line",
                    "fill": false,
                    "borderColor": "rgb(130, 130, 30)"
                }, {
                    "label": "전라도",
                    "data": capaDataset[3],
                    "type": "line",
                    "fill": false,
                    "borderColor": "rgb(140, 40, 40)"
                }, {
                    "label": "경상도",
                    "data": capaDataset[4],
                    "type": "line",
                    "fill": false,
                    "borderColor": "rgb(50, 150, 50)"
                }, {
                    "label": "제주도",
                    "data": capaDataset[5],
                    "type": "line",
                    "fill": false,
                    "borderColor": "rgb(60, 60, 160)"
                }
                ]
            },
            "options": {
                tooltips: {
                    mode: 'label',
                    callbacks: {
                        label: function (tooltipItem, data) {
                            return tooltipItem.yLabel.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
                        },
                    },
                },
                "scales": {
                    "xAxes": [{
                        scaleLabel: {
                            display: true,
                            labelString: '월'
                        }
                    }],
                    "yAxes": [{
                        scaleLabel: {
                            display: true,
                            labelString: '발전용량(kw)'
                        },
                        ticks: {
                            beginAtZero: true,
                            userCallback: function (value, index, values) {
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

    function calculatePolyAreaMeterPeang (that) {
        $('#polyPathPeang').val('');
        $('#polyPathMeter').val('');

        var value = replaceAllComma($(that).val());
        $('#polyAreaMeter').val((Math.round((value * 1000) / 30.25) / 10).toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",")); //㎡
        $('#polyAreaMeterPeang').val(value.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ","));
    }

    function calculatePolyAreaMeter (that) {
        $('#polyPathPeang').val('');
        $('#polyPathMeter').val('');

        var value = replaceAllComma($(that).val());
        $('#polyAreaMeterPeang').val((Math.round((value * 1000) / 30.25) / 10).toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",")); //㎡
        $('#polyAreaMeter').val(value.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ","));
    }

    function calculatePolyPathPeang (that) {
        $('#polyAreaMeterPeang').val('');
        $('#polyAreaMeter').val('');

        var value = replaceAllComma($(that).val());
        $('#polyPathMeter').val((Math.round((value * 1000) / 30.25) / 10).toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",")); //㎡
        $('#polyPathPeang').val(value.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ","));
    }

    function calculatePolyPathMeter (that) {
        $('#polyAreaMeterPeang').val('');
        $('#polyAreaMeter').val('');

        var value = replaceAllComma($(that).val());
        $('#polyPathPeang').val((Math.round(value * 30.25) / 100).toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",")); //평
        $('#polyPathMeter').val(value.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ","));
    }

</script>
</body>
</html>
