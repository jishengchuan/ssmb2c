package com.oaec.ssm.controller;

import com.alibaba.fastjson.JSON;
import com.github.pagehelper.Page;
import com.github.pagehelper.PageHelper;
import com.oaec.ssm.service.BrandService;
import com.oaec.ssm.service.CommodityService;
import com.oaec.ssm.service.QuotService;
import com.oaec.ssm.service.SortService;
import org.omg.PortableInterceptor.INACTIVE;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.List;
import java.util.Map;

@Controller
public class CommodityController {

    @Autowired
    private CommodityService commodityService;
    @Autowired
    private BrandService brandService;
    @Autowired
    private QuotService quotService;
    @Autowired
    private SortService sortService;

    @GetMapping("/index")
    public String index(String sid, Model model){
        String bid = (int) ((Math.random() * 9 + 1) * 10000) % 3 + 1 + 1000 + "";
        List<Map<String, Object>> query = commodityService.query(null, null, bid, null, null);
        model.addAttribute("list",query);
        Map<String, Object> quot = quotService.randQuot();
        model.addAttribute("quot",quot);
        List<Map<String, Object>> brands = brandService.queryBySid(sid);
        model.addAttribute("brands",brands);
        return "index";
    }

    @GetMapping("/list")
    public String list(String name, String sid, String bid, String desc, @RequestParam(required = false,defaultValue = "1") Integer page, Model model){
        List<Map<String, Object>> query = commodityService.query(name, sid, bid, desc,page);
        model.addAttribute("list",query);
        List<Map<String, Object>> brands = brandService.queryBySid(sid);
        model.addAttribute("brands",brands);
        //判断query是否是Page类是子类或者子类实例
        if(query instanceof Page){
            Page commodityPage = (Page) query;
            //当前页数
            int pageNum = commodityPage.getPageNum();
            //总页数
            int pages = commodityPage.getPages();
            model.addAttribute("pageNum",pageNum);
            model.addAttribute("pages",pages);
        }
        return "list";
    }

    @GetMapping("/xiangqing")
    public String Xiangqing(String name, String sid, String bid, Integer cid,String desc, Model model){
        List<Map<String, Object>> query = commodityService.query(name, sid, bid, desc, null);
        model.addAttribute("list",query);
        Map<String, Object> commodity = commodityService.queryByCid(cid);
        model.addAttribute("commodity",commodity);
        Map<String, Object> sort = sortService.queryBySid(Integer.parseInt(commodity.get("sort_id").toString()));
        model.addAttribute("sort",sort);
        Map<String, Object> brand = brandService.queryByBid(Integer.parseInt(commodity.get("brand_id").toString()));
        model.addAttribute("brand",brand);
        return "xiangqing";
    }

    @GetMapping("/bangdan")
    public String bangdan(String sale,String stock,@RequestParam(required = false,defaultValue = "1")Integer page,Model model){
        List<Map<String, Object>> list = commodityService.querySaleAndStock(sale, stock, page);
        if(list instanceof Page){
            Page commodityPage = (Page) list;
            System.out.println("commodityPage = " + commodityPage);
            //当前页数
            int pageNum = commodityPage.getPageNum();
            //总页数
            int pages = commodityPage.getPages();
            model.addAttribute("pageNum",pageNum);
            model.addAttribute("pages",pages);
        }
        model.addAttribute("list",list);
        return "bangdan";
    }

    @GetMapping(value = "/stock",produces = "application/json;charset=utf-8")
    @ResponseBody
    public String  stock(Integer cid,Model model){
        Map<String, Object> stock = commodityService.queryCidByStock(cid);
        model.addAttribute("stock",stock);
        return JSON.toJSONString(stock);
    }
}
