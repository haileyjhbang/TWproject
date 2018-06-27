<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html>
<head>
    <link rel="stylesheet" href="common.css">
</head>
<body>

<input type="hidden" id="query" value="${query}">
<div id="addressCandidates">
    <c:forEach items='${result}' var='itemList' varStatus="loop">
        <ul>
            <li id="addr_${loop.index}">
                <a onclick="getAddressIndex(${loop.index})" href="#">${itemList.address_name}</a>
            </li>
            <input type="hidden" id="x_${loop.index}" value="${itemList.x}">
            <input type="hidden" id="y_${loop.index}" value="${itemList.y}">

        </ul>
    </c:forEach>
    <c:forEach var="i" begin="1" end='${total_count+1}'>
        <c:if test="${i == curPage}">
            ${i}
        </c:if>
        <c:if test="${i != curPage}">
            <a href="javascript:void(0)" onclick="getAddress(${i})">${i}</a>
        </c:if>
        <c:if test="${i != total_count+1}">
            |
        </c:if>
    </c:forEach>
</div>

<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script>
    function getAddressIndex(ind) {
        var x = $('#x_' + ind).val();
        var y = $('#y_' + ind).val();
        var addr = $('#addr_' + ind)[0].innerText;

        $("#inputAddress", opener.document).val(addr);
        $(opener.location).attr("href", "javascript:setArea(" + x + ", " + y + ");");
    }

    function getAddress(pgae) {
        var query = $('#query').val();
        var url = "/address";
        var size = 10;
        location.href = encodeURI(url + "?query=" + query + "&page=" + pgae + "&size=" + size);
    }
</script>
</body>
</html>
