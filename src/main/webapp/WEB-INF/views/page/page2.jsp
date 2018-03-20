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
<input type="text" id="scale" value="${scale}">scale
<input type="text" id="powerTime" value="${powerTime}">powerTime
<input type="text" id="powerDay" value="${powerDay}">powerDay
<input type="text" id="smpUnit" value="${smpUnit}">smpUnit
<input type="text" id="recUnit" value="${recUnit}">recUnit
<input type="text" id="weight" value="${weight}">weight
<input type="text" id="smpRate" value="${weight}">weight
<input type="text" id="smpInclination" value="${smpInclination}">smpInclination
<input type="text" id="unitPrice" value="${unitPrice}">unitPrice
<input type="text" id="totalInvestment" value="${totalInvestment}">totalInvestment
<input type="text" id="myCapital" value="${myCapital}">myCapital
<input type="text" id="loan" value="${loan}">loan
<input type="text" id="loanPercent" value="${loanPercent}">loanPercent
<input type="text" id="repayPeriod" value="${repayPeriod}">repayPeriod
<input type="text" id="maintanenceUnit" value="${maintanenceUnit}">maintanenceUnit


<table cellspacing="0" cellpadding="0" border="1px" id="calculateCostTable">
    <tr>
        <th rowspan="2">구분</th>
        <th colspan="2">수입</th>
        <th colspan="4">지출</th>
        <th colspan="2">수익총계</th>
    </tr>
    <tr>
        <th width="10%">연간전력생산량</th>
        <th width="10%">연수익</th>
        <th width="10%">유지보수비</th>
        <th width="10%">원금상환</th>
        <th width="10%">이자</th>
        <th width="10%">상환후잔액</th>
        <th width="10%">순수익</th>
        <th width="10%">수익률(%)</th>
    </tr>
</table>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script>
    $(document).ready(function () {
        calculateCostTable();
    });

    function calculateCostTable() {
        var total = 0;
        var annualPower = 0;
        for (var i = 0; i < 20; i++) {
            if (i = 0) {
                annualPower = $('#scale').val() * $('#powerTime').val() * $('#powerDay').val();
                $("#calculateCostTable").append("<tr>" +
                    "<td>" + (i + 1) + "</td>" +
                    "<td>" + annualPower + "</td>" +
                    "<td></td>" +
                    "<td></td>" +
                    "<td></td>" +
                    "<td></td>" +
                    "<td></td>" +
                    "<td></td>" +
                    "<td></td>" +
                    "</tr>");
            } else {
                annualPower = annualPower * 0.995;
                $("#calculateCostTable").append("<tr>" +
                    "<td>" + (i + 1) + "</td>" +
                    "<td>" + annualPower + "</td>" +
                    "<td></td>" +
                    "<td></td>" +
                    "<td></td>" +
                    "<td></td>" +
                    "<td></td>" +
                    "<td></td>" +
                    "<td></td>" +
                    "</tr>");
            }
        }
        $("#calculateCostTable").append("<tr>" +
            "<td></td>" +
            "<td></td>" +
            "<td></td>" +
            "<td></td>" +
            "<td></td>" +
            "<td></td>" +
            "<td></td>" +
            "<td></td>" +
            "</tr>");
        $("#calculateCostTable").append("<tr>" +
            "<td></td>" +
            "<td></td>" +
            "<td></td>" +
            "<td></td>" +
            "<td></td>" +
            "<td></td>" +
            "<td></td>" +
            "<td></td>" +
            "</tr>");

        $("#calculateCostTable").append("<tr><td colspan='9'></td></tr>");


        $("#calculateCostTable").append("<tr>" +
            "<th>&nbsp;</th>" +
            "<th>매출액</th>" +
            "<th>원금상환</th>" +
            "<th>유지보수비</th>" +
            "<th>&nbsp;</th>" +
            "<th>이자</th>" +
            "<th>&nbsp;</th>" +
            "<th>순수익</th>" +
            "<th>수익율</th>" +
            "</tr>");
        $("#calculateCostTable").append("<tr>" +
            "<th>&nbsp;</th>" +
            "<th>매출액</th>" +
            "<th>원금상환</th>" +
            "<th>유지보수비</th>" +
            "<th>&nbsp;</th>" +
            "<th>이자</th>" +
            "<th>&nbsp;</th>" +
            "<th>순수익</th>" +
            "<th>수익율</th>" +
            "</tr>");
        $("#calculateCostTable").append("<tr>" +
            "<td>" + (i + 1) + "</td>" +
            "<td colspan='8'>" + i + " test</td>" +
            "</tr>");
        $("#calculateCostTable").append("<tr>" +
            "<td>" + (i + 1) + "</td>" +
            "<td colspan='8'>" + i + " test</td>" +
            "</tr>");

    }
</script>
</body>
</html>