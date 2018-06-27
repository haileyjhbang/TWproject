package com.example.twproject.Controller;

import com.example.twproject.Service.ExternalAPIService;
import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.ObjectMapper;
import org.json.JSONObject;
import org.json.XML;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;

import javax.servlet.http.HttpServletRequest;
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
        JSONObject xmlJSONObjLand = null;
        try {
            String resLand = externalAPIService.smp1hToday("1");

            System.out.println("externalAPIService.smp1hToday: " + resLand);

            try {
                xmlJSONObjLand = XML.toJSONObject(resLand);
            } catch (Exception e) {
                return "redirect:page1";
            }
        } catch (IOException e) {
            e.printStackTrace();
        }

        model.addAttribute("smpUnitBefore", formatSmp(xmlJSONObjLand));
        model.addAttribute("apiKeyDaum", "e12af9afb1526adcd0f898407bb25bfb");
        model.addAttribute("apiKeyVworld", "E60BEDC5-C3EE-3B5F-98D5-9166F94EB492");
        return "page/page1";
    }

    @GetMapping("/newPage1")
    public String newPage1(Model model) {
        JSONObject xmlJSONObjLand = null;
        try {
            String resLand = externalAPIService.smp1hToday("1");
            System.out.println("externalAPIService.smp1hToday: " + resLand);

            try {
                xmlJSONObjLand = XML.toJSONObject(resLand);
            } catch (Exception e) {
                return "redirect:newPage1";
            }
        } catch (IOException e) {
            e.printStackTrace();
        }

        model.addAttribute("smpUnitBefore", formatSmp(xmlJSONObjLand));
        model.addAttribute("apiKeyDaum", "e12af9afb1526adcd0f898407bb25bfb");
        model.addAttribute("apiKeyVworld", "E60BEDC5-C3EE-3B5F-98D5-9166F94EB492");
        return "page/newPage1";
    }

    @GetMapping("/smp")
    public String smp(Model model) {
        try {
            String resLand = externalAPIService.smp1hToday("1");
            String resJeju = externalAPIService.smp1hToday("9");

            System.out.println("externalAPIService.smp1hToday: " + resLand);
            System.out.println("externalAPIService.smp1hToday: " + resJeju);

            JSONObject xmlJSONObjLand;
            JSONObject xmlJSONObjJeju;
            try {
                xmlJSONObjLand = XML.toJSONObject(resLand);
                xmlJSONObjJeju = XML.toJSONObject(resJeju);
            } catch (Exception e) {
                return "redirect:smp";
            }

        /*    String xmlJSONObjString = xmlJSONObj.toString();

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
*/
//            System.out.println("### dataResponse=" + dataResponse);
//            System.out.println("### body=" + body);
//            System.out.println("### items=" + items);
//            System.out.println("### itemList=" + itemList);

            model.addAttribute("modelJeju", formatSmp(xmlJSONObjJeju));
            model.addAttribute("modelLand", formatSmp(xmlJSONObjLand));
        } catch (IOException e) {
            e.printStackTrace();
        }
        return "page/smp";
    }

    @PostMapping("/page2")
    public String page2(
            HttpServletRequest request,
            Model model
    ) {
        model.addAttribute("apiKeyDaum", "e12af9afb1526adcd0f898407bb25bfb");
        model.addAttribute("apiKeyVworld", "E60BEDC5-C3EE-3B5F-98D5-9166F94EB492");

        model.addAttribute("scale", request.getParameter("scale").replaceAll(",",""));
        model.addAttribute("efficiencyRate", request.getParameter("efficiencyRate").replaceAll(",",""));
        model.addAttribute("powerTime", request.getParameter("powerTime").replaceAll(",",""));
        model.addAttribute("powerDay", request.getParameter("powerDay").replaceAll(",",""));
        model.addAttribute("smpUnit", request.getParameter("smpUnit").replaceAll(",",""));
        model.addAttribute("recUnit", request.getParameter("recUnit").replaceAll(",",""));
        model.addAttribute("weight", request.getParameter("weight").replaceAll(",",""));
        model.addAttribute("smpRate", request.getParameter("smpRate").replaceAll(",",""));
        model.addAttribute("insuranceRate", request.getParameter("insuranceRate").replaceAll(",",""));
        model.addAttribute("maintenanceUnit", request.getParameter("maintenanceUnit").replaceAll(",",""));
        model.addAttribute("profit", request.getParameter("profit").replaceAll(",",""));
        model.addAttribute("unitPrice", request.getParameter("unitPrice").replaceAll(",",""));
        model.addAttribute("totalInvestment", request.getParameter("totalInvestment").replaceAll(",",""));
        model.addAttribute("myCapital", request.getParameter("myCapital").replaceAll(",",""));
        model.addAttribute("loan", request.getParameter("loan").replaceAll(",",""));
        model.addAttribute("loanPercent", request.getParameter("loanPercent").replaceAll(",",""));
        model.addAttribute("repayPeriod", request.getParameter("repayPeriod").replaceAll(",",""));
        model.addAttribute("drawingPolygon", request.getParameter("drawingPolygon"));

        model.addAttribute("polyAreaMeterPeang", request.getParameter("polyAreaMeterPeang"));
        model.addAttribute("polyAreaMeter", request.getParameter("polyAreaMeter"));
        model.addAttribute("polyPathPeang", request.getParameter("polyPathPeang"));
        model.addAttribute("polyPathMeter", request.getParameter("polyPathMeter"));

        model.addAttribute("address", request.getParameter("address"));
        model.addAttribute("type", request.getParameter("type"));

        return "page/page2";
    }

    static List<Map<String, Object>> formatSmp(JSONObject json){
        List<Map<String, Object>> itemList = null;
        try{
       //     org.json.JSONObject xmlJSONObj = XML.toJSONObject(json);
            String xmlJSONObjString = json.toString();

            ObjectMapper objectMapper = new ObjectMapper();
            Map<String, Object> map = new HashMap<>();
            map = objectMapper.readValue(xmlJSONObjString, new TypeReference<Map<String, Object>>() {
            });
            Map<String, Object> dataResponse = (Map<String, Object>) map.get("response");
            Map<String, Object> body = (Map<String, Object>) dataResponse.get("body");
            Map<String, Object> items = null;

            items = (Map<String, Object>) body.get("items");
            itemList = (List<Map<String, Object>>) items.get("item");
        } catch (IOException e) {
            e.printStackTrace();
        }
    return itemList;

    }
    
    @GetMapping("/naver01")
    public String naver01(Model model) {
        return "page/naver01";
    }

}
