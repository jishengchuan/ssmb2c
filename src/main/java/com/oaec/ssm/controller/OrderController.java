package com.oaec.ssm.controller;

import com.oaec.ssm.mapper.AddressMapper;
import com.oaec.ssm.mapper.ShopMapper;
import com.oaec.ssm.service.AddressService;
import com.oaec.ssm.service.OrderService;
import com.oaec.ssm.service.ShopService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.util.List;
import java.util.Map;

@Controller
public class OrderController {

    @Autowired
    private OrderService orderService;
    @Autowired
    private AddressService addressService;
    @Autowired
    private ShopService shopService;

    @GetMapping("/order")
    public String order(HttpServletRequest requestuest, Model model){
        HttpSession session = requestuest.getSession();
        Map<String,Object> user = (Map<String, Object>) session.getAttribute("user");
        int userId = Integer.parseInt(user.get("users_id").toString());
        List<Map<String, Object>> orders = orderService.getOrders(userId);
        model.addAttribute("orders",orders);
        return "order";
    }

    @GetMapping("/checkout")
    public String checkout(Integer[] cid,HttpServletRequest request,Model model){
        HttpSession session = request.getSession();
        Map<String,Object> user = (Map<String, Object>) session.getAttribute("user");
        int users_id = Integer.parseInt(user.get("users_id").toString());
        //查询收货地址
        List<Map<String, Object>> address = addressService.queryByUserId(users_id);
        //查询要结算的商品
        List<Map<String, Object>> commodities = shopService.getCommodities4Checkout(users_id, cid);
        //查询统计
        Map<String, Object> total = shopService.getTotal(users_id, cid);
        model.addAttribute("total",total);
        model.addAttribute("address",address);
        model.addAttribute("commodities",commodities);
        return "checkout";
    }

    @GetMapping(value = "/submit",produces = "application/json;charset=utf-8")
    @ResponseBody
    public String submit(Integer[] cid,Integer aid,HttpServletRequest request){
        HttpSession session = request.getSession();
        Map<String,Object> user = (Map<String, Object>) session.getAttribute("user");
        int users_id = Integer.parseInt(user.get("users_id").toString());
        boolean submit = orderService.submit(users_id, aid, cid);
        return "{\"success\":"+submit+"}";
    }
}
