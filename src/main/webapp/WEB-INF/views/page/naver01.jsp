<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, user-scalable=no">
    <title>간단한 지도 표시하기</title>
    <script type="text/javascript" src="jquery/jquery-2.2.3.min.js"></script>
    <script type="text/javascript" src="https://openapi.map.naver.com/openapi/v3/maps.js?clientId=HfHdPCELZyId0hZ9QySl&submodules=geocoder"></script>
</head>
<body>
<input type="text" id="address" />
<div id="map" style="width:100%;height:600px;"></div>

<script>
var map = new naver.maps.Map("map", {
    center: new naver.maps.LatLng(37.3595316, 127.1052133),
    mapTypeControl: true
});

var infoWindow = new naver.maps.InfoWindow({
    anchorSkew: true
});

map.setCursor('pointer');

// search by tm128 coordinate
function searchCoordinateToAddress(latlng) {
    var tm128 = naver.maps.TransCoord.fromLatLngToTM128(latlng);

    infoWindow.close();

    naver.maps.Service.reverseGeocode({
        location: tm128,
        coordType: naver.maps.Service.CoordType.TM128
    }, function(status, response) {
        if (status === naver.maps.Service.Status.ERROR) {
            return alert('Something Wrong!');
        }

        var items = response.result.items,
            htmlAddresses = [];

        for (var i=0, ii=items.length, item, addrType; i<ii; i++) {
            item = items[i];
            addrType = item.isRoadAddress ? '[도로명 주소]' : '[지번 주소]';

            htmlAddresses.push((i+1) +'. '+ addrType +' '+ item.address);
            htmlAddresses.push('&nbsp&nbsp&nbsp -> '+ item.point.x +','+ item.point.y);
        }

        infoWindow.setContent([
                '<div style="padding:10px;min-width:200px;line-height:150%;">',
                '<h4 style="margin-top:5px;">검색 좌표 : '+ response.result.userquery +'</h4><br />',
                htmlAddresses.join('<br />'),
                '</div>'
            ].join('\n'));

        infoWindow.open(map, latlng);
    });
}

// result by latlng coordinate
function searchAddressToCoordinate(address) {
    naver.maps.Service.geocode({
        address: address
    }, function(status, response) {
        if (status === naver.maps.Service.Status.ERROR) {
            return alert('Something Wrong!');
        }

        var item = response.result.items[0],
            addrType = item.isRoadAddress ? '[도로명 주소]' : '[지번 주소]',
            point = new naver.maps.Point(item.point.x, item.point.y);

        infoWindow.setContent([
                '<div style="padding:10px;min-width:200px;line-height:150%;">',
                '<h4 style="margin-top:5px;">검색 주소 : '+ response.result.userquery +'</h4><br />',
                addrType +' '+ item.address +'<br />',
                '&nbsp&nbsp&nbsp -> '+ point.x +','+ point.y,
                '</div>'
            ].join('\n'));


        map.setCenter(point);
        infoWindow.open(map, point);
    });
}

function initGeocoder() {
    map.addListener('click', function(e) {
        searchCoordinateToAddress(e.coord);
    });

    $('#address').on('keydown', function(e) {
        var keyCode = e.which;

        if (keyCode === 13) { // Enter Key
            searchAddressToCoordinate($('#address').val());
        }
    });

    $('#submit').on('click', function(e) {
        e.preventDefault();
        searchAddressToCoordinate($('#address').val());
    });
    searchAddressToCoordinate('정자동 178-1');
}

naver.maps.onJSContentLoaded = initGeocoder;
</script>
</body>
</html>


