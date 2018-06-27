package com.example.twproject.Controller;

import com.example.twproject.Service.MapService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;

import java.util.Map;
@RestController
public class MapController {
    @Autowired
    private MapService mapService;

    @GetMapping("/address")
    public ModelAndView getAddress(@RequestParam String query, @RequestParam String page, @RequestParam String size) throws Exception{
        String appKey = "c3a90c7e6e6a3797a6f5a2959d446066";
        ModelAndView mv = new ModelAndView("page/address");

        Map<String, Object> result = mapService.getAddress(query, appKey, page, size);
        Map<String, Object> meta = (Map<String, Object>) result.get("meta");
        Integer totalCount = (Integer) meta.get("total_count");

        mv.addObject("result", result.get("documents"));
        mv.addObject("meta", result.get("meta"));
        mv.addObject("query", query);
        mv.addObject("curPage", page);
        mv.addObject("total_count", Math.ceil(totalCount/ Integer.parseInt(size)));

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
