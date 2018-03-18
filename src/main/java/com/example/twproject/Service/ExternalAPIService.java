package com.example.twproject.Service;

import org.springframework.stereotype.Service;

import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLEncoder;
import java.io.BufferedReader;
import java.io.IOException;

@Service
public class ExternalAPIService {

    public String smp1hToday(String areaCd) throws IOException {
        String apikeyData = "XTSoVaSY8ZdBTu1gWRipZfcIHFWor00z4lMphA7IrORMwFCNa80cOhqBH1pNmnRxosn0JtO8Fq%2B0p%2BJ%2FYee1MA%3D%3D";

        StringBuilder urlBuilder = new StringBuilder("https://openapi.kpx.or.kr/openapi/smp1hToday/getSmp1hToday"); /*URL*/
        urlBuilder.append("?" + URLEncoder.encode("ServiceKey", "UTF-8") + "=" + apikeyData); /*Service Key*/
        urlBuilder.append("&" + URLEncoder.encode("areaCd", "UTF-8") + "=" + URLEncoder.encode(areaCd, "UTF-8")); /*육지:1 제주:9*/
        URL url = new URL(urlBuilder.toString());
        HttpURLConnection conn = (HttpURLConnection) url.openConnection();
        conn.setRequestMethod("GET");
        conn.setRequestProperty("Content-type", "application/json");
        System.out.println("Response code: " + conn.getResponseCode());
        BufferedReader rd;
        if (conn.getResponseCode() >= 200 && conn.getResponseCode() <= 300) {
            rd = new BufferedReader(new InputStreamReader(conn.getInputStream()));
        } else {
            rd = new BufferedReader(new InputStreamReader(conn.getErrorStream()));
        }

        StringBuilder sb = new StringBuilder();
        String line;
        while ((line = rd.readLine()) != null) {
            sb.append(line);
        }
        rd.close();
        conn.disconnect();
        return sb.toString();
    }

}
