package com.example.twproject.controller;

import com.example.twproject.Service.ExternalAPIService;
import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.ObjectMapper;
import org.json.XML;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
public class PageController {

    @Autowired
    private ExternalAPIService externalAPIService;

    @GetMapping("/")
    public String main(Model model) {
        return "index";
    }

    @GetMapping("/page1")
    public String page1(Model model) {
        model.addAttribute("apiKeyDaum", "e12af9afb1526adcd0f898407bb25bfb");
        model.addAttribute("apiKeyVworld", "E60BEDC5-C3EE-3B5F-98D5-9166F94EB492");
        return "page/page1";
    }

    @GetMapping("/page2/areaCd/{areaCd}")
    public String page2(
            @PathVariable String areaCd,
            Model model
    ) {
        try {
            String res = externalAPIService.smp1hToday(areaCd);

            org.json.JSONObject xmlJSONObj = XML.toJSONObject(res);
            String xmlJSONObjString = xmlJSONObj.toString();

            ObjectMapper objectMapper = new ObjectMapper();
            Map<String, Object> map = new HashMap<>();
            map = objectMapper.readValue(xmlJSONObjString, new TypeReference<Map<String, Object>>() {
            });
            Map<String, Object> dataResponse = (Map<String, Object>) map.get("response");
            Map<String, Object> body = (Map<String, Object>) dataResponse.get("body");
            Map<String, Object> items = null;
            List<Map<String, Object>> itemList = null;

            items = (Map<String, Object>) body.get("items");
            itemList = (List<Map<String, Object>>) items.get("item");

//            System.out.println("### dataResponse=" + dataResponse);
//            System.out.println("### body=" + body);
//            System.out.println("### items=" + items);
//            System.out.println("### itemList=" + itemList);

            model.addAttribute("model", itemList);
        } catch (IOException e) {
            e.printStackTrace();
        }
        return "page/page2";
    }
}
