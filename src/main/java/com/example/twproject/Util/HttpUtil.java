package com.example.twproject.Util;

import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.ObjectMapper;
import org.apache.http.HttpResponse;
import org.apache.http.NameValuePair;
import org.apache.http.client.HttpClient;
import org.apache.http.client.methods.HttpGet;
import org.apache.http.client.utils.URLEncodedUtils;
import org.apache.http.impl.client.HttpClientBuilder;
import org.json.JSONObject;
import sun.misc.IOUtils;


import java.net.URLEncoder;
import java.util.List;
import java.util.Map;

public class HttpUtil {
    public static Map<String, Object> getHttpWithHeaders(String url, List<NameValuePair> urlParameters, String header) throws Exception {
        HttpClient client = HttpClientBuilder.create().build();

        if (!url.endsWith("?")) {
            url += "?";
        }

        url += URLEncodedUtils.format(urlParameters, "UTF-8");
        HttpGet get = new HttpGet(url);
        if (header.length() > 0) {
            get.setHeader("Authorization", "KakaoAK " + header);
        }
        get.setHeader("accept", "application/json");
        get.setHeader("Content-Type", "application/json;charset-UTF-8");

        HttpResponse response = client.execute(get);

        ObjectMapper mapper = new ObjectMapper();
        Map<String, Object> resultMap = mapper.readValue(response.getEntity().getContent(), new TypeReference<Map<String, Object>>() {
        });

        return resultMap;
    }
}