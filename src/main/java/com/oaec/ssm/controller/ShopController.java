package com.oaec.ssm.controller;

import com.alibaba.fastjson.JSON;
import com.oaec.ssm.mapper.AddressMapper;
import com.oaec.ssm.service.AddressService;
import com.oaec.ssm.service.ShopService;
import com.sun.org.apache.xpath.internal.operations.Mod;
import org.omg.PortableInterceptor.INACTIVE;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
public class ShopController {

    @Autowired
    private ShopService shopService;
    @Autowired
    private AddressService addressService;

    @GetMapping("/shop")
    public String shop(HttpServletRequest request, Model model){
        HttpSession session = request.getSession();
        Map<String, Object> user = (Map<String, Object>) session.getAttribute("user");
        int userId = Integer.parseInt(user.get("users_id").toString());
        List<Map<String, Object>> commodities = shopService.getShopCommidties(userId);
        model.addAttribute("commodities",commodities);
        return "shop";
    }

    @GetMapping(value = "/add2shop",produces = "application/json;charset=utf-8")
    @ResponseBody
    public String add2Shop(String cid, String quantity,HttpServletRequest request){
        HttpSession session = request.getSession();
        Map<String, Object> user = (Map<String, Object>) session.getAttribute("user");
        int userId = Integer.parseInt(user.get("users_id").toString());
        int cids = Integer.parseInt(cid);
        int quantities = Integer.parseInt(quantity);
        boolean b = shopService.addShop(userId, cids, quantities);
        return "{\"success\":"+b+"}";
    }

    @GetMapping(value = "/shopTotal",produces = "application/json;charset=utf-8")
    @ResponseBody
    public String shopTotal(HttpServletRequest request,Integer[] cid){
        HttpSession session = request.getSession();
        Map<String, Object> user = (Map<String, Object>) session.getAttribute("user");
        int userId = Integer.parseInt(user.get("users_id").toString());
        Map<String, Object> total = shopService.getTotal(userId, cid);
        return JSON.toJSONString(total);
    }

    @GetMapping(value = "/updateQuantity",produces = "application/json;charset=utf-8")
    @ResponseBody
    public String updateQuantity(HttpServletRequest request,String cid,String action,String quantity){
        HttpSession session = request.getSession();
        Map<String, Object> user = (Map<String, Object>) session.getAttribute("user");
        int userId = Integer.parseInt(user.get("users_id").toString());
        int stock = shopService.updateQuantity(action, Integer.parseInt(quantity), userId, Integer.parseInt(cid));
        Double price = shopService.queryCommodityPrice(userId, Integer.parseInt(cid));
        Map<String,Object> map = new HashMap<>();
        map.put("success",stock == 1);
        map.put("stock",stock);
        map.put("price",price);
        return JSON.toJSONString(map);
    }

    @GetMapping("/instanceCheckout")
    public String instanceCheckout(Integer quantity,Integer cid,HttpServletRequest request,Model model){
        HttpSession session = request.getSession();
        Map<String, Object> user = (Map<String, Object>) session.getAttribute("user");
        int userId = Integer.parseInt(user.get("users_id").toString());
        shopService.addShop(userId,cid,quantity);
        List<Map<String, Object>> address = addressService.queryByUserId(userId);
        model.addAttribute("address",address);
        Integer[] cids = {cid};
        List<Map<String, Object>> commodities = shopService.getCommodities4Checkout(userId, cids);
        model.addAttribute("commodities",commodities);
        Map<String, Object> total = shopService.getTotal(userId, cids);
        model.addAttribute("total",total);
        return "checkout";
    }

    @GetMapping(value = "/shopDelete",produces = "application/json;charset=utf-8")
    @ResponseBody
    public String shopDel(Integer cid,HttpSession session){
        Map<String,Object> user = (Map<String,Object>) session.getAttribute("user");
        int users_id = Integer.parseInt(user.get("users_id").toString());
        boolean delete = shopService.delete(users_id, cid);
        return "{\"success\":"+delete+"}";
    }
}
