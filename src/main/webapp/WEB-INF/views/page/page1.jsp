<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title>주소 검색 / 면적 확인</title>
    <link rel="stylesheet" href="common.css">
</head>
<body>

<form action="./page2" id="basicValues" method="post">
    <input type="hidden" name="sample5_address" id="sample5_address">
    <input type="hidden" name="sigunguCode" id="sigunguCode">
    <input type="hidden" name="liCode" id="liCode">
    <input type="hidden" name="emdCode" id="emdCode">
    <input type="hidden" name="dongliNm" id="dongliNm">
    <input type="hidden" name="lang" id="lang">
    <input type="hidden" name="long" id="long">
    <input type="hidden" name="drawingPolygon" id="drawingPolygon">
    <input type="hidden" name="powerDay" value="365">

    <div class="top">
        <div class="area">
            <div id="inputtext">
                <input type="text" name="address" id="address" value="" onclick="sample5_execDaumPostcode()" readonly></div>
            <div id="inputbutton">
                <input type="button" onclick="sample5_execDaumPostcode()" value="주소 검색"></div>
        </div>

        <div class="area2">
            <div id="areatitle">면적기준</div>
            <div id="arearadio">
                <input type="radio" name="type" value="sgg" onclick="getType(this)"> 시/군/구
                <input type="radio" name="type" value="emd" onclick="getType(this)"> 읍/면/동
                <input type="radio" name="type" value="li" id="typeLi" onclick="getType(this)"> 리
            </div>
        </div>
    </div>

    <br/>

    <div id="map" style="width:100%;height:400px;"></div>

    <br/>

    <div class="contents">
        
            <div class="sec1">
                <ul>
                    <li>지번구역 면적</li>
                    <li><input text="text" id="polyAreaMeterPeang" name="polyAreaMeterPeang" value="" onkeyup="calculatePolyAreaMeterPeang(this)">평</li>
                    <li><input type="text" id="polyAreaMeter" name="polyAreaMeter" value="" onkeyup="calculatePolyAreaMeter(this)">㎡</li>
                </ul>

                <ul>
                    <li>마우스선택 면적</li>
                    <li><input text="text" id="polyPathPeang" name="polyPathPeang" value="" onkeyup="calculatePolyPathPeang(this)">평</li>
                    <li><input type="text" id="polyPathMeter" name="polyPathMeter" value="" onkeyup="calculatePolyPathMeter(this)">㎡</li>
                </ul>
            </div>
            <span class="sectitle">기본조건</span>
            <div class="sec2">                
                <ul class="field00">
                    <li>총면적</li><li>설치용량</li><li>REC단가</li><li>REC가중치</li><li class="lastli">SMP단가</li>
                </ul>
                <ul class="inputtext">
                    <li></li>
                    <li><input type="text" name="scale" id="scale" value="" onkeyup="calculateTable();calculateComma(this)">kw</li>
                    <li><input type="text" name="recUnit" id="recUnit" value="115" onkeyup="calculateTable()">원</li>
                    <li><input type="text" name="weight" value="1.5" onkeyup="calculateTable()">배</li>
                    <li><input type="text" name="smpUnit" id="smpUnit" value="95" onkeyup="calculateTable()">원</li>
                            
                </ul>
                

            </div>
            <span class="sectitle">발전조건</span>
            <div class="sec3">                
                <ul class="field00">
                    <li>일평균 발전시간</li><li>연간 효율저감률</li><li>SMP상승률</li><li>유지보수</li><li>보험료</li>                
                </ul>
                <ul class="inputtext">
                    <li><input type="text" name="powerTime" value="3.6">시간</li>
                    <li><input type="text" name="efficiencyRate" id="efficiencyRate" value="0.50" onkeyup="calculateTable()">%</li>
                    <li><input type="text" name="smpRate" value="1">%</li>
                    <li><input type="text" name="maintenanceUnit" value="0.30">%</li>
                    <li><input type="text" name="insuranceRate" id="insuranceRate" value="0.23" onkeyup="calculateTable()">%</li>
                </ul>
               
            </div>
            <span class="sectitle">자금조건</span>
            <div class="sec4">                
                <ul class="field00">
                    <li>총공사비</li><li>설치단가</li><li>금융대출</li><li>자기자본</li><li>금융이율</li><li>상환기간</li>                
                </ul>
                <ul class="inputtext">
                    <li><input type="text" name="totalInvestment" id="totalInvestment" value="0" onkeyup="calculateComma(this)">원</li>
                    <li><input type="text" name="unitPrice" id="unitPrice" value="1,500,000" onkeyup="calculateTable();calculateComma(this)">원</li>
                    <li><input type="text" name="loanPercent" id="loanPercent" value="90" onkeyup="calculateTable()">%
                        <input type="text" name="loan" id="loan" value="0" onkeyup="calculateComma(this)">원</li>
                    <li><input type="text" name="myCapital" id="myCapital" value="0" onkeyup="calculateComma(this)">원</li>
                    <li><input type="text" name="profit" id="profit" value="4.7" onkeyup="calculateTable()">%</li>
                    <li><input type="text" name="repayPeriod" value="15" onkeyup="calculateTable()">년</li>
                </ul>
               
            </div>

        </div>

       

        <div class="nextpage"><input type="button" id="nextPage" value="수익성 계산"></div>
    

</form>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>
<script src="http://dapi.kakao.com/v2/maps/sdk.js?appkey=${apiKeyDaum}&libraries=services"></script>
<script>
    function replaceAllComma(value) {
        return value.split(',').join('');
    }

    function numberWithCommas(cellValue) {
        if (cellValue == null || cellValue === '' || cellValue === 'undefined') return 0;
        return cellValue.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
    }

    function calculateTable() {
    	
        //총투자비 = 설치용량 * 설치단가
        $('#totalInvestment').val(numberWithCommas(replaceAllComma($('#scale').val()) * replaceAllComma($('#unitPrice').val())));
        //자기자본 = 총투자비 - 금융대출
        $('#loan').val(numberWithCommas(replaceAllComma($('#totalInvestment').val()) * replaceAllComma($('#loanPercent').val()) / 100));
        //금융대출 = 총투자비 * 대출비율
        $('#myCapital').val(numberWithCommas(replaceAllComma($('#totalInvestment').val()) - replaceAllComma($('#loan').val())));

        $('#smpUnit').val(numberWithCommas(replaceAllComma($('#smpUnit').val())));
        $('#recUnit').val(numberWithCommas(replaceAllComma($('#recUnit').val())));
    };

    function calculateComma(that) {
        $(that).val(numberWithCommas(replaceAllComma($(that).val())));
    }

    function calculateScale() {
        //설치용량 계산
        var scale = 0;
        if(replaceAllComma($('#polyPathPeang').val()) > 0 ) {
            scale = Math.round(replaceAllComma($('#polyPathPeang').val()) / 5);  //마우스(평) polyPathPeang
        } else {
            scale = Math.round(replaceAllComma($('#polyAreaMeterPeang').val()) / 5); //지역(평) polyAreaMeterPeang
        }
        $('#scale').val(numberWithCommas(scale));
        calculateTable();
    }

    /////////////
    $('#polyAreaMeter').val("");
    $('#polyAreaMeterPeang').val("");
    var mapContainer = document.getElementById('map'), // 지도를 표시할 div
        mapOption = {
            center: new daum.maps.LatLng(37.537187, 127.005476), // 지도의 중심좌표
            level: 6 // 지도의 확대 레벨
        };

    //지도를 미리 생성
    var map = new daum.maps.Map(mapContainer, mapOption);
    //주소-좌표 변환 객체를 생성
    var geocoder = new daum.maps.services.Geocoder();
    //마커를 미리 생성
    var marker = new daum.maps.Marker({
        //       position: new daum.maps.LatLng(37.537187, 127.005476),
        map: map
    });
    initPolygonPath(map);

    function sample5_execDaumPostcode() {
        new daum.Postcode({
            oncomplete: function (data) {
                // 지도검색 결과값 return
                $('#address').val(data.address);
                $('#sigunguCode').val(data.sigunguCode);
                $('#liCode').val(data.bcode);
                $('#emdCode').val(data.bcode.substr(0, 8));
                $('#dongliNm').val(data.bname2);

                if (data.bname2.slice(-1) != '리') {
                    $("#typeLi").attr('disabled', true);
                } else {
                    $("#typeLi").attr('disabled', false);
                }

                // 각 주소의 노출 규칙에 따라 주소를 조합한다.
                // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
                var fullAddr = data.address; // 최종 주소 변수
                var extraAddr = ''; // 조합형 주소 변수

                // 기본 주소가 도로명 타입일때 조합한다.
                if (data.addressType === 'R') {
                    //법정동명이 있을 경우 추가한다.
                    if (data.bname !== '') {
                        extraAddr += data.bname;
                    }
                    // 건물명이 있을 경우 추가한다.
                    if (data.buildingName !== '') {
                        extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                    }
                    // 조합형주소의 유무에 따라 양쪽에 괄호를 추가하여 최종 주소를 만든다.
                    fullAddr += (extraAddr !== '' ? ' (' + extraAddr + ')' : '');
                }
                // 주소 정보를 해당 필드에 넣는다.
                document.getElementById("sample5_address").value = fullAddr;
                // 주소로 상세 정보를 검색
                geocoder.addressSearch(data.address, function (results, status) {
                    // 정상적으로 검색이 완료됐으면
                    if (status === daum.maps.services.Status.OK) {
                        var result = results[0]; //첫번째 결과의 값을 활용

                        $('#map').html('');
                        var map = new daum.maps.Map(mapContainer, mapOption); // 지도를 생성합니다
                        // 해당 주소에 대한 좌표를 받아서
                        var coords = new daum.maps.LatLng(result.y, result.x);
                        $('#lang').val(result.y);
                        $('#long').val(result.x);

                        // 지도를 보여준다.
                        mapContainer.style.display = "block";
                        map.relayout();

                        // 지도 중심을 변경한다.
                        map.setCenter(coords);
                        // 마커를 결과값으로 받은 위치로 옮긴다.
                        marker.setPosition(coords)
                        marker.setMap(map);

                        $('#polyAreaMeter').val("");
                        $('#polyAreaMeterPeang').val("");
                    }
                });
            }
        }).open();
    }

    // 다각형을 구성하는 좌표 배열입니다. 이 좌표들을 이어서 다각형을 표시합니다

    var key = "${apiKeyVworld}";
    var domain = "http://localhost";
    var url = "";

    function getType(that) {
        if ($('#address').val().length > 0) console.log('Get Polipath'); else return;
        var url_gu = 'http://api.vworld.kr/req/data?service=data&version=2.0&request=getfeature&key=' + key + '&format=json&errorformat=json&size=10&page=1&data=LT_C_ADSIGG_INFO&attrfilter=sig_cd%3Alike%3A' + $('#sigunguCode').val() + '&columns=sig_cd%2Cfull_nm%2Csig_kor_nm%2Csig_eng_nm%2Cag_geom&geometry=true&attribute=true&crs=epsg%3A4326&domain=' + domain;
        var url_dong = 'http://api.vworld.kr/req/data?service=data&version=2.0&request=getfeature&key=' + key + '&format=json&errorformat=json&size=10&page=1&data=LT_C_ADEMD_INFO&attrfilter=emdcd%3Alike%3A' + $('#emdCode').val() + '%7Cemd_cd%3Alike%3A' + $('#emdCode').val() + '&columns=emd_cd%2Cfull_nm%2Cemd_kor_nm%2Cemd_eng_nm%2Cag_geom&geometry=true&attribute=true&crs=epsg%3A4326&domain=' + domain;
        var url_li = 'http://api.vworld.kr/req/data?service=data&version=2.0&request=getfeature&key=' + key + '&format=json&errorformat=json&size=10&page=1&data=LT_C_ADRI_INFO&attrfilter=emdcd%3Alike%3A' + $('#emdCode').val() + '%7Cli_cd%3Alike%3A' + $('#liCode').val() + '&columns=li_cd%2Cfull_nm%2Cli_kor_nm%2Cli_eng_nm%2Cag_geom&geometry=true&attribute=true&crs=epsg%3A4326&domain=' + domain;

        type = $(that).val();

        if (type == 'emd') {
            console.log('검색: 읍면동');
            url = url_dong;
        } else if (type == 'li') {
            console.log('검색: 리');
            url = url_li;
        } else {
            console.log('검색: 시군구');
            url = url_gu;
        }
        getArea();
    }

    function getArea() {
        var polygonPath = new Array();
        $.ajax({
            type: 'GET',
            url: url,
            dataType: 'jsonp',
            success: function (data) {
                $.each(data.response.result.featureCollection.features[0].geometry.coordinates[0][0], function () {
                    polygonPath.push(new daum.maps.LatLng(this[1], this[0]));
                })
                // 마커가 지도 위에 표시되도록 설정합니다
                var map = new daum.maps.Map(mapContainer, mapOption); // 지도를 생성합니다
                var coords = new daum.maps.LatLng($('#lang').val(), $('#long').val());
                map.setCenter(coords);
                marker.setPosition(coords)
                marker.setMap(map);
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
                getDrawingPolygon(polygon.getPath());
                //마우스 면적 초기화
                $('#polyPathMeter').val('');
                $('#polyPathPeang').val('');
                //면적계산
                var area = Math.round(polygon.getArea()).toString().replace(/\B(?=(\d{3})+(?!\d))/g, ","); // 다각형의 총면적을 계산합니다
                $('#polyAreaMeter').val(area);
                $('#polyAreaMeterPeang').val((Math.round(polygon.getArea() * 30.25) / 100).toString().replace(/\B(?=(\d{3})+(?!\d))/g, ","));
                calculateScale();
                initPolygonPath(map);
            },
            cache: false,
            error: function (jqXHR, testStatus, errorThrown) {
                //
            }
        });
    }

    function initPolygonPath(map) {
        var drawingFlag = false; // 다각형이 그려지고 있는 상태를 가지고 있을 변수입니다
        var drawingPolygon; // 그려지고 있는 다각형을 표시할 다각형 객체입니다
        var polygon; // 그리기가 종료됐을 때 지도에 표시할 다각형 객체입니다
        var areaOverlay; // 다각형의 면적정보를 표시할 커스텀오버레이 입니다

        // 마우스 클릭 이벤트가 발생하고나면 drawingFlag가 그려지고 있는 상태인 ture 값으로 바뀝니다
        // 그려지고 있는 상태인 경우 drawingPolygon 으로 그려지고 있는 다각형을 지도에 표시합니다
        // 마우스 오른쪽 클릭 이벤트가 발생하면 drawingFlag가 그리기가 종료된 상태인 false 값으로 바뀌고
        // polygon 으로 다 그려진 다각형을 지도에 표시합니다

        // 지도에 마우스 클릭 이벤트를 등록합니다
        // 지도를 클릭하면 다각형 그리기가 시작됩니다 그려진 다각형이 있으면 지우고 다시 그립니다
        daum.maps.event.addListener(map, 'click', function (mouseEvent) {
            // 마우스로 클릭한 위치입니다
            var clickPosition = mouseEvent.latLng;
            // 지도 클릭이벤트가 발생했는데 다각형이 그려지고 있는 상태가 아니면
            if (!drawingFlag) {
                // 상태를 true로, 다각형을 그리고 있는 상태로 변경합니다
                drawingFlag = true;
                // 지도 위에 다각형이 표시되고 있다면 지도에서 제거합니다
                if (polygon) {
                    polygon.setMap(null);
                    polygon = null;
                }
                // 지도 위에 면적정보 커스텀오버레이가 표시되고 있다면 지도에서 제거합니다
                if (areaOverlay) {
                    areaOverlay.setMap(null);
                    areaOverlay = null;
                }
                // 그려지고 있는 다각형을 표시할 다각형을 생성하고 지도에 표시합니다
                drawingPolygon = new daum.maps.Polygon({
                    map: map, // 다각형을 표시할 지도입니다
                    path: [clickPosition], // 다각형을 구성하는 좌표 배열입니다 클릭한 위치를 넣어줍니다
                    strokeWeight: 3, // 선의 두께입니다
                    strokeColor: '#00a0e9', // 선의 색깔입니다
                    strokeOpacity: 1, // 선의 불투명도입니다 0에서 1 사이값이며 0에 가까울수록 투명합니다
                    strokeStyle: 'solid', // 선의 스타일입니다
                    fillColor: '#00a0e9', // 채우기 색깔입니다
                    fillOpacity: 0.2 // 채우기 불투명도입니다
                });
                // 그리기가 종료됐을때 지도에 표시할 다각형을 생성합니다
                polygon = new daum.maps.Polygon({
                    path: [clickPosition], // 다각형을 구성하는 좌표 배열입니다 클릭한 위치를 넣어줍니다
                    strokeWeight: 3, // 선의 두께입니다
                    strokeColor: '#00a0e9', // 선의 색깔입니다
                    strokeOpacity: 1, // 선의 불투명도입니다 0에서 1 사이값이며 0에 가까울수록 투명합니다
                    strokeStyle: 'solid', // 선의 스타일입니다
                    fillColor: '#00a0e9', // 채우기 색깔입니다
                    fillOpacity: 0.2 // 채우기 불투명도입니다
                });
            } else { // 다각형이 그려지고 있는 상태이면
                // 그려지고 있는 다각형의 좌표에 클릭위치를 추가합니다
                // 다각형의 좌표 배열을 얻어옵니다
                var drawingPath = drawingPolygon.getPath();
                // 좌표 배열에 클릭한 위치를 추가하고
                drawingPath.push(clickPosition);
                // 다시 다각형 좌표 배열을 설정합니다
                drawingPolygon.setPath(drawingPath);
                // 그리기가 종료됐을때 지도에 표시할 다각형의 좌표에 클릭 위치를 추가합니다
                // 다각형의 좌표 배열을 얻어옵니다
                var path = polygon.getPath();
                // 좌표 배열에 클릭한 위치를 추가하고
                path.push(clickPosition);
                // 다시 다각형 좌표 배열을 설정합니다
                polygon.setPath(path);
            }
        });

        // 지도에 마우스무브 이벤트를 등록합니다
        // 다각형을 그리고있는 상태에서 마우스무브 이벤트가 발생하면 그려질 다각형의 위치를 동적으로 보여주도록 합니다
        daum.maps.event.addListener(map, 'mousemove', function (mouseEvent) {
            // 지도 마우스무브 이벤트가 발생했는데 다각형을 그리고있는 상태이면
            if (drawingFlag) {
                // 마우스 커서의 현재 위치를 얻어옵니다
                var mousePosition = mouseEvent.latLng;
                // 그려지고있는 다각형의 좌표배열을 얻어옵니다
                var path = drawingPolygon.getPath();
                // 마우스무브로 추가된 마지막 좌표를 제거합니다
                if (path.length > 1) {
                    path.pop();
                }
                // 마우스의 커서 위치를 좌표 배열에 추가합니다
                path.push(mousePosition);
                // 그려지고 있는 다각형의 좌표를 다시 설정합니다
                drawingPolygon.setPath(path);
            }
        });

        // 지도에 마우스 오른쪽 클릭 이벤트를 등록합니다
        // 다각형을 그리고있는 상태에서 마우스 오른쪽 클릭 이벤트가 발생하면 그리기를 종료합니다
        daum.maps.event.addListener(map, 'rightclick', function (mouseEvent) {
            // 지도 오른쪽 클릭 이벤트가 발생했는데 다각형을 그리고있는 상태이면
            if (drawingFlag) {
                // 그려지고있는 다각형을  지도에서 제거합니다
                drawingPolygon.setMap(null);
                drawingPolygon = null;
                // 클릭된 죄표로 그릴 다각형의 좌표배열을 얻어옵니다
                var path = polygon.getPath();
                // 다각형을 구성하는 좌표의 개수가 3개 이상 이면
                getDrawingPolygon(path);
                if (path.length > 2) {
                    // 지도에 다각형을 표시합니다
                    polygon.setMap(map);
                    var area = Math.round(polygon.getArea()); // 다각형의 총면적을 계산합니다
                    var polyPathMeter = area.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
                    var polyPathPeang = (Math.round(area * 30.25) / 100).toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
                    content = '<div class="info">총면적 <span class="number"> ' + polyPathMeter + '</span> m<sup>2</sup> / <span class="number"> ' + polyPathPeang + '</span>평</div>'; // 커스텀오버레이에 추가될 내용입니다
                    $('#polyPathMeter').val(polyPathMeter);
                    $('#polyPathPeang').val(polyPathPeang);
                    calculateScale();
                    // 면적정보를 지도에 표시합니다
                    areaOverlay = new daum.maps.CustomOverlay({
                        map: map, // 커스텀오버레이를 표시할 지도입니다
                        content: content,  // 커스텀오버레이에 표시할 내용입니다
                        xAnchor: 0,
                        yAnchor: 0,
                        position: path[path.length - 1]  // 커스텀오버레이를 표시할 위치입니다. 위치는 다각형의 마지막 좌표로 설정합니다
                    });
                } else {
                    // 다각형을 구성하는 좌표가 2개 이하이면 다각형을 지도에 표시하지 않습니다
                    polygon = null;
                }
                // 상태를 false로, 그리지 않고 있는 상태로 변경합니다
                drawingFlag = false;
            }
        });
    }

    // 다각형 지도의 포인트 위치 가져오기
    function getDrawingPolygon(polygonPath) {
        $('#drawingPolygon').val(polygonPath);
    }

    $("#nextPage").click(function () {
        //if(!$('#drawingPolygon').val()) {
        //    alert( "마우스로 구역을 선택해주세요." );
        //    return;
        //}
        
         
        if($("#polyAreaMeterPeang").val() == "" && $("#polyAreaMeter").val() == "" && $("#polyPathPeang").val() == "" && $("#polyPathMeter").val() == ""){
        	alert('면적을 입력 또는 선택해 주세요');
        	return false;
        	
        }
        
        if($("#scale").val() == "" || $("#scale").val() == "0"){
        	alert('설치용량값이 존재하지 않습니다. 다시 확인해 주세요');
        	return false;
        }
        $("#basicValues").submit();
    });

    function calculatePolyAreaMeterPeang (that) {
        // $('#polyPathPeang').val('');
        // $('#polyPathMeter').val('');
        calculateScale();

        var value = replaceAllComma($(that).val());
        $('#polyAreaMeter').val((Math.round((value * 1000) / 30.25) / 10).toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",")); //㎡
        $('#polyAreaMeterPeang').val(value.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ","));
    }

    function calculatePolyAreaMeter (that) {
        // $('#polyPathPeang').val('');
        // $('#polyPathMeter').val('');
        calculateScale();

        var value = replaceAllComma($(that).val());
        $('#polyAreaMeterPeang').val((Math.round((value * 1000) / 30.25) / 10).toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",")); //㎡
        $('#polyAreaMeter').val(value.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ","));
    }

    function calculatePolyPathPeang (that) {
        // $('#polyAreaMeterPeang').val('');
        // $('#polyAreaMeter').val('');
        calculateScale();

        var value = replaceAllComma($(that).val());
        $('#polyPathMeter').val((Math.round((value * 1000) / 30.25) / 10).toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",")); //㎡
        $('#polyPathPeang').val(value.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ","));
    }

    function calculatePolyPathMeter (that) {
        // $('#polyAreaMeterPeang').val('');
        // $('#polyAreaMeter').val('');
        calculateScale();

        var value = replaceAllComma($(that).val());
        $('#polyPathPeang').val((Math.round(value * 30.25) / 100).toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",")); //평
        $('#polyPathMeter').val(value.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ","));
    }
</script>
</body>
</html>

