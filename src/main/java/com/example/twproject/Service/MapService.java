package com.example.twproject.Service;

import com.example.twproject.Util.HttpUtil;
import org.apache.http.NameValuePair;
import org.apache.http.message.BasicNameValuePair;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;
@Service
public class MapService {
    public Map<String, Object> getAddress(String query, String appKey, String page, String size) throws Exception{
        Map<String, Object> resultMap = null;
        String url = "https://dapi.kakao.com/v2/local/search/address.json".trim();
        List<NameValuePair> listParam = new ArrayList<NameValuePair>();
        listParam.add(new BasicNameValuePair("query", query));
        listParam.add(new BasicNameValuePair("page", page));
        listParam.add(new BasicNameValuePair("size", size));
        try{
            resultMap = HttpUtil.getHttpWithHeaders(url, listParam, appKey);
        }catch (Exception e){
            e.printStackTrace();
        }

        return resultMap;
    }

    public Map<String, Object> getCoordinates(String x, String y, String appKey) throws Exception{
        Map<String, Object> resultMap = null;
        String url = "http://api.vworld.kr/req/data?key="+appKey+"&domain=localhost&service=data&version=2.0&request=getfeature&format=json&size=100&page=1&data=LP_PA_CBND_BUBUN&geometry=true&attribute=true&crs=EPSG:4326&geomfilter=POINT("+x+"%20"+y+")".trim();
        List<NameValuePair> listParam = new ArrayList<NameValuePair>(); ;

        try{
            resultMap = HttpUtil.getHttpWithHeaders(url, listParam, "");
        }catch (Exception e){
            e.printStackTrace();
        }

        return resultMap;
    }
}
