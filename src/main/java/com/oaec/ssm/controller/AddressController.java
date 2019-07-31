package com.oaec.ssm.controller;

import com.oaec.ssm.service.AddressService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.io.PrintWriter;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
public class AddressController {

    @Autowired
    private AddressService addressService;

    @GetMapping("/address")
    public String address(HttpServletRequest request, Model model){
        HttpSession session = request.getSession();
        Map<String,Object> user = (Map<String, Object>) session.getAttribute("user");
        int userId = Integer.parseInt(user.get("users_id").toString());
        List<Map<String, Object>> address = addressService.queryByUserId(userId);
        model.addAttribute("address",address);
        return "address";
    }

    @GetMapping("/updateAddress")
    public String update(Integer aid,Model model){
        if (aid != null){
            Map<String, Object> address = addressService.queryByAddressId(aid);
            model.addAttribute("address",address);
        }
        return "updateaddress";
    }

    @PutMapping(value = "/updateAddress", produces = "application/json;charset=utf-8")
    @ResponseBody
    public String submit(String addressee,String tel,String address,String aid,HttpServletRequest req){
        //获取用户编号
        HttpSession session = req.getSession();
        Map<String,Object> user = (Map<String, Object>) session.getAttribute("user");
        int users_id = Integer.parseInt(user.get("users_id").toString());
        //为地址赋值
        HashMap<String, Object> map = new HashMap<>();
        map.put("addressee",addressee);
        map.put("tel",tel);
        map.put("address",address);
        map.put("users_id",users_id);
        boolean b = false;
        if (aid != null){
            map.put("address_id",aid);
            b = addressService.doUpdate(map);
            System.out.println("b = " + b);
        }else {
            b = addressService.doInsert(map);
        }
        return "{\"success\":"+b+"}";
    }

    @PutMapping(value = "/del",produces = "application/json;charset=utf-8")
    @ResponseBody
    public String del(Integer aid){
        boolean b = addressService.doDelete(aid);
        return "{\"success\":"+b+"}";
    }
}
