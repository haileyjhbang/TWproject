package com.example.twproject.controller;

import com.example.twproject.Service.MapService;
import com.example.twproject.Util.HttpUtil;
import org.apache.http.client.HttpClient;
import org.apache.http.impl.client.HttpClientBuilder;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;

import java.util.List;
import java.util.Map;
@RestController
public class MapController {
    @Autowired
    private MapService mapService;

    @GetMapping("/address")
    public ModelAndView getAddress(@RequestParam String query) throws Exception{
        String appKey = "c3a90c7e6e6a3797a6f5a2959d446066";
        ModelAndView mv = new ModelAndView("page/address");

        Map<String, Object> result = mapService.getAddress(query, appKey);

        mv.addObject("result", result.get("documents"));
        mv.addObject("meta", result.get("meta"));
        return mv;
    }
    @GetMapping("/coordinates")
    public Map<String, Object> getCooredinates(@RequestParam String x, @RequestParam String y) throws Exception{
        String appKey = "E60BEDC5-C3EE-3B5F-98D5-9166F94EB492";

        Map<String, Object> result = mapService.getCoordinates(x, y, appKey);
        System.out.println(result.toString());
        return result;
    }
}
