package com.example.twproject.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class PageController {
    @GetMapping("/page1")
    public String page1(Model model)
    {
        model.addAttribute("apiKeyDaum", "e12af9afb1526adcd0f898407bb25bfb");
        model.addAttribute("apiKeyVworld", "E60BEDC5-C3EE-3B5F-98D5-9166F94EB492");
        return "page/page1";
    }
}
