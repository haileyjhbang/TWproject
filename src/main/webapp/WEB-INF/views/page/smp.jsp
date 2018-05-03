<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
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

        ul {
            margin: 0;
            padding: 0;
            list-style-type: none;
            position: relative;
            display: table;
        }

        li {
            box-sizing: border-box;
            float: left;
            margin: 0;
            padding: 1px;
            position: relative;
        }
    </style>

        <link rel="stylesheet" href="common.css">
    <link rel="stylesheet" href="animate.min.css">
<script>
    
    $.fn.extend({
  animateCss: function(animationName, callback) {
    var animationEnd = (function(el) {
      var animations = {
        animation: 'animationend',
        OAnimation: 'oAnimationEnd',
        MozAnimation: 'mozAnimationEnd',
        WebkitAnimation: 'webkitAnimationEnd',
      };

      for (var t in animations) {
        if (el.style[t] !== undefined) {
          return animations[t];
        }
      }
    })(document.createElement('div'));

    this.addClass('animated ' + animationName).one(animationEnd, function() {
      $(this).removeClass('animated ' + animationName);

      if (typeof callback === 'function') callback();
    });

    return this;
  },
});
    
    
  
    </script>


</head>
<body>
<div class="hidden">
    <ul>
        <li>
            <table id="land">
                <caption>
                    육지
                </caption>
                <thead>
                <tr>
                    <th width="100px" colspan="2">TRADE DAY/HOUR</th>
                    <th width="80px">SMP</th>
                </tr>
                </thead>
                <c:set var="land_total" value="0"/>
                <c:forEach items='${modelLand}' var='itemList'>
                    <tr>
                        <td>${itemList.tradeDay}</td>
                        <td>${itemList.tradeHour} </td>
                        <td>${itemList.smp}</td>
                    </tr>
                    <c:set var="land_total" value="${land_total + itemList.smp}"/>
                </c:forEach>
            </table>
        </li>
        <li>
            <table id="jeju">
                <caption>
                    제주
                </caption>
                <thead>
                <tr>
                    <th width="100px" colspan="2">TRADE DAY/HOUR</th>
                    <th width="80px">SMP</th>
                </tr>
                </thead>
                <c:set var="jeju_total" value="0"/>
                <c:forEach items='${modelJeju}' var='itemList'>
                    <tr>
                        <td>${itemList.tradeDay}</td>
                        <td>${itemList.tradeHour} </td>
                        <td>${itemList.smp}</td>
                    </tr>
                    <c:set var="jeju_total" value="${jeju_total + itemList.smp}"/>
                </c:forEach>
            </table>
        </li>
         <li>
            <c:set var="meanLand" value="${land_total / fn:length(modelLand)}"/>
            <fmt:formatNumber var="meanLand"
                              value="${meanLand}"
                              maxFractionDigits="2"/>
            <fmt:formatNumber var="meanJeju"
                              value="${jeju_total / fn:length(modelJeju)}"
                              maxFractionDigits="2"/>

            <fmt:parseDate pattern="yyyyMMdd" value="${modelJeju[0].tradeDay}" var="date"/></li>
    </ul></div>

    
    <div class="smp">
    <ul>       
        <li class="todaysmp">오늘의 SMP<br>${modelJeju[0].tradeDay}</li>    
        <ul class="data"><li class="title1">육지</li> <li class="data1 animated infinite flash">${meanLand}</li></ul>
        <ul class="data"><li class="title2">제주</li> <li class="data2 animated infinite flash">${meanJeju}</li></ul>
    </ul></div>

</body>
</html>