<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <title></title>
    <style>
        table {
            border: 1px solid #444444;
            border-collapse: collapse;
        }
        th {
            border: 1px solid #444444;
            text-align: center;
        }
        td {
            border: 1px solid #444444;
            text-align: right;
            padding: 0 3px;
        }
    </style>
    <script>
    </script>
</head>
<body>
<table>
    <tr>
        <th width="100px" colspan="2">TRADE DAY/HOUR</th>
        <th width="80px">SMP</th>
    </tr>
    <c:forEach items='${model}' var='itemList'>
        <tr>
            <td>${itemList.tradeDay}</td>
            <td>${itemList.tradeHour} </td>
            <td>${itemList.smp}</td>
        </tr>
    </c:forEach>
</table>
</body>
</html>