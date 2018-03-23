<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title>주소 검색 / 면적 확인</title>
    <style>
        /*면적표시구역*/
        .info {
            position: relative;
            top: 5px;
            left: 5px;
            border-radius: 6px;
            border: 1px solid #ccc;
            border-bottom: 2px solid #ddd;
            font-size: 12px;
            padding: 5px;
            background: #fff;
            list-style: none;
            margin: 0;
        }

        .info:nth-of-type(n) {
            border: 0;
            box-shadow: 0px 1px 2px #888;
        }

        .info .label {
            display: inline-block;
            width: 50px;
        }

        /*면적표시숫자*/
        .number {
            font-weight: bold;
            color: #00a0e9;
        }

        /*화면구성*/
        body {
            font-size: 12px;
        }

        table {
            text-align: center;
            width: 100%;
        }

        input {
            font-size: 12px;
            text-align: right;
            height: 20px;
            margin: 0px;
            padding: 0px;
        }

        tr, td {
            padding: 0;
            margin: 0;
            background: #E7E5E6;
        }

        .w80 {
            width: 100%;
            height: 100% !important;
            border: none;
            background-color: transparent;
        }

        .changeField {
            background: yellow !important;
        }
    </style>

</head>
<body>
<br>
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


<table cellspacing="0" cellpadding="0" border="1px" id="calculateCostTable">
    <tr>
        <th>구분</th>
        <th colspan="3">수입</th>
        <th colspan="4">지출</th>
        <th></th>
        <th colspan="2">수익총계</th>
    </tr>
    <tr>
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
    <tr>
        <th>REC</th>
    </tr>
</table>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script>
    $(document).ready(function () {
        calculateCostTable();
    });

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
        var leftBalance = loan;
        var profit = $('#profit').val();
        var interest = 0;
        var totalInterest = 0;
        var netIncome = 0;
        var totalInvestment = $('#totalInvestment').val();
        var profitRate = 0;

        for (var i = 0; i < duration; i++) {
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
                profitRate = netIncome / totalInvestment * 100;
                $("#calculateCostTable").append("<tr>" +
                    "<td rowspan='2'>" + (i + 1) + "</td>" +
                    "<td rowspan='2'>" + numberWithCommas(annualPower) + "</td>" +
                    "<td>" + numberWithCommas(smp) + "</td>" +
                    "<td rowspan='2'>" + numberWithCommas(annualProfit) + "</td>" +
                    "<td rowspan='2'>" + numberWithCommas(maintenance) + "</td>" +
                    "<td rowspan='2'>" + numberWithCommas(insuranceFee) + "</td>" +
                    "<td rowspan='2'></td>" +
                    "<td rowspan='2'>" + numberWithCommas(interest) + "</td>" +
                    "<td rowspan='2'>" + numberWithCommas(leftBalance) + "</td>" +
                    "<td rowspan='2'>" + numberWithCommas(netIncome) + "</td>" +
                    "<td rowspan='2'>" + numberWithCommas(profitRate) + "</td>" +
                    "</tr>");
                $("#calculateCostTable").append("<tr>" +
                    "<td>" + numberWithCommas(rec) + "</td>" +
                    "</tr>");
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
                payback = loan / repayPeriod;
                repayPeriod --;
                loan -= payback;
                leftBalance -= payback;
                interest = (leftBalance + payback) * profit /100;
                totalInterest += interest;
                netIncome = annualProfit - maintenance - payback - interest;
                profitRate = netIncome / totalInvestment * 100;
                $("#calculateCostTable").append("<tr>" +
                    "<td rowspan='2'>" + (i + 1) + "</td>" +
                    "<td rowspan='2'>" + numberWithCommas(annualPower) + "</td>" +
                    "<td>" + numberWithCommas(smp) + "</td>" +
                    "<td rowspan='2'>" + numberWithCommas(annualProfit) + "</td>" +
                    "<td rowspan='2'>" + numberWithCommas(maintenance) + "</td>" +
                    "<td rowspan='2'>" + numberWithCommas(insuranceFee) + "</td>" +
                    "<td rowspan='2'>" + numberWithCommas(payback) + "</td>" +
                    "<td rowspan='2'>" + numberWithCommas(interest) + "</td>" +
                    "<td rowspan='2'>" + numberWithCommas(leftBalance) + "</td>" +
                    "<td rowspan='2'>" + numberWithCommas(netIncome) + "</td>" +
                    "<td rowspan='2'>" + numberWithCommas(profitRate) + "</td>" +
                    "</tr>");
                $("#calculateCostTable").append("<tr>" +
                    "<td>" + numberWithCommas(rec) + "</td>" +
                    "</tr>");
            }
        }
        $("#calculateCostTable").append("<tr>" +
            "<td>연평균</td>" +
            "<td>" + numberWithCommas(totalAnnualPower / duration) + "</td>" +
            "<td></td>" +
            "<td>" + numberWithCommas(totalAnnualProfit / duration) + "</td>" +
            "<td>" + numberWithCommas(totalMaintenance / duration) + "</td>" +
            "<td>" + numberWithCommas(totalInsuranceFee / duration) + "</td>" +
            "<td>" + numberWithCommas(totalPayback / repayPeriod2) + "</td>" +
            "<td>" + numberWithCommas(0 / duration) + "</td>" +
            "<td>" + numberWithCommas(0 / duration) + "</td>" +
            "<td>" + numberWithCommas(0 / duration) + "</td>" +
            "<td>" + numberWithCommas(0 / duration) + "</td>" +
            "</tr>");
        $("#calculateCostTable").append("<tr>" +
            "<td>누계합계</td>" +
            "<td>" + numberWithCommas(totalAnnualPower) + "</td>" +
            "<td></td>" +
            "<td>" + numberWithCommas(totalAnnualProfit) + "</td>" +
            "<td>" + numberWithCommas(totalMaintenance) + "</td>" +
            "<td>" + numberWithCommas(totalInsuranceFee) + "</td>" +
            "<td>" + numberWithCommas(totalPayback) + "</td>" +
            "<td>" + numberWithCommas(0) + "</td>" +
            "<td>" + numberWithCommas(0) + "</td>" +
            "<td>" + numberWithCommas(0) + "</td>" +
            "<td>" + numberWithCommas(0) + "</td>" +
            "</tr>");

        $("#calculateCostTable").append("<tr><td colspan='11'>&nbsp;</td></tr>");


        $("#calculateCostTable").append("<tr>" +
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
            "<td>1달</td>" +
            "<td>" + numberWithCommas(0 / duration / 12) + "</td>" +
            "<td>" + numberWithCommas(0 / duration / 12) + "</td>" +
            "<td></td>" +
            "<td></td>" +
            "<td></td>" +
            "<td></td>" +
            "<td></td>" +
            "<td></td>" +
            "<td></td>" +
            "<td rowspan='3'>%</td>" +
            "</tr>");
        $("#calculateCostTable").append("<tr>" +
            "<td>1년</td>" +
            "<td>" + numberWithCommas(0 / duration) + "</td>" +
            "<td>" + numberWithCommas(0 / duration) + "</td>" +
            "<td></td>" +
            "<td></td>" +
            "<td></td>" +
            "<td></td>" +
            "<td></td>" +
            "<td></td>" +
            "<td></td>" +
            "</tr>");
        $("#calculateCostTable").append("<tr>" +
            "<td>20년</td>" +
            "<td>" + numberWithCommas(0) + "</td>" +
            "<td>" + numberWithCommas(0) + "</td>" +
            "<td></td>" +
            "<td></td>" +
            "<td></td>" +
            "<td></td>" +
            "<td></td>" +
            "<td></td>" +
            "<td></td>" +
            "</tr>");
    }

    function numberWithCommas(cellValue) {
        if (cellValue == null || cellValue === '' || cellValue === 'undefined' || isNaN(cellValue) ) return 0;
        cellValue = Math.round(cellValue);
        return cellValue.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
    }

</script>
</body>
</html>