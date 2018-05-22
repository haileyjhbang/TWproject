<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix = "c" uri = "http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix = "fmt" uri = "http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html>
<head>
    <link rel="stylesheet" href="common.css">
</head>
<body>
<div id="addressCandidates" class="sec1">
    <c:forEach items='${result}' var='itemList' varStatus="loop">
        <ul >
            <li id="addr_${loop.index}">
                <a onclick="getAddressIndex(${loop.index})" href="#">${itemList.address_name}</a>
            </li>
            <input type="hidden" id="x_${loop.index}" value="${itemList.x}">
            <input type="hidden" id="y_${loop.index}" value="${itemList.y}">

        </ul>
    </c:forEach>
</div>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script>
  function getAddressIndex(ind){
      var x = $('#x_' + ind).val();
      var y = $('#y_' + ind).val();
      var addr = $('#addr_' + ind)[0].innerText;

      window.opener.document.getElementById('inputAddress').value = addr;
/*      window.opener.document.getElementById('selectedX').value = x;
      window.opener.document.getElementById('selectedY').value = y;*/
      //window.opener.getPoligonCoordinates(x, y);
      window.opener.setArea(x, y);
      // window.close();

  }

</script>
</body>
</html>
