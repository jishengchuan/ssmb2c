package com.oaec.ssm.controller;

import com.alibaba.fastjson.JSON;
import com.oaec.ssm.service.UserService;
import com.oaec.ssm.util.SmsApiHttpSendTest;
import com.sun.org.apache.xpath.internal.operations.Mod;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpRequest;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.io.*;
import java.util.HashMap;
import java.util.Map;
import java.util.UUID;


@Controller
public class UserController {

    @Autowired
    private UserService userService;

    @GetMapping("/login")
    public String login(){
        return "login";
    }

    //ResponseBody不会转发重定向，直接返回字符串
    @PostMapping(value = "/login", produces = "application/json;charset=utf-8")
    @ResponseBody
    public String doLogin(String username, String password, String uri, HttpServletRequest request, HttpSession session){
        Map<String, Object> login = userService.login(username, password);
        if (login.containsKey("error")){
            return JSON.toJSONString(login);
        }
        session.setAttribute("user",login);
        Map<String, Object> map = new HashMap<>();
        map.put("success",true);
        if (uri != null){
            //contextPath:/ssmb2c
            String contextPath = request.getContextPath();
            uri = uri.replace(contextPath, "");
            map.put("uri",uri);
        }
        return JSON.toJSONString(map);
    }

    @GetMapping("/register")
    public String register(){
        return "register";
    }


    @PostMapping(value = "/register",produces = "application/json;charset=utf-8")
    @ResponseBody
    public String doRegister(String username,String password,String tel,String codes,HttpServletRequest request){
        Object code0 = request.getSession().getAttribute("codes");
        String code1 = "";
        if (code0 != null){
            code1 = code0.toString();
        }
        //设置contenType
        if(!"".equals(username) && !"".equals(password) && !"".equals(tel)){
            if(code1.equals(codes)){
                Map<String, Object> register = userService.register(username, password,tel);
                if(register.containsKey("error")){
                   return JSON.toJSONString(register);
                }else {
                    Map<String, Object> login = userService.login(username, password);
                    System.out.println("login = " + login);
                    request.getSession().setAttribute("user",login);
                    return "{\"success\":true}";
                }
            }else {
                System.out.println("验证码错误");
                return "{\"error\":\"error:验证码错误\"}";
            }
        }else {
            System.out.println("信息不完整");
            return "{\"error\":\"error:信息不完整\"}";
        }
    }

    @GetMapping("logout")
    public String logout(HttpServletRequest request){
        request.getSession().invalidate();
        return "redirect:/index";
    }

    @GetMapping(value = "/checkUsername",produces = "application/json;charset=utf-8")
    @ResponseBody
    public String checkUsername(String username){
        Map<String, Object> map = userService.queryByUsername(username);
        if(map.containsKey("error")){
            map.put("result",false);
        }
        if (map.containsKey("success")){
            map.put("result",true);
        }
        return JSON.toJSONString(map);
    }

    @GetMapping("/find")
    public String find(){
        return "forget";
    }

    @PostMapping(value = "/find",produces = "application/json;charset=utf-8")
    @ResponseBody
    public String doFind(String tel,String code,String p1,String p2,HttpSession session){
        if (tel != null){
            Map<String, Object> map = userService.queryByTel(tel);
            if (map != null){
                session.setAttribute("tel",tel);
                return "{\"success\":true}";
            }else {
                return "{\"success\":false}";
            }
        }
        if (code != null){
            Object code0 = session.getAttribute("codes");
            String code1 = code0.toString();
            if (code.equals(code1)){
                return "{\"success\":true}";
            }
        }
        if (p1 != null){
            if (p1.equals(p2)){
                Object tel0 = session.getAttribute("tel");
                String tel1 = tel0.toString();
                Map<String, Object> map1 = userService.queryByTel(tel1);
                Boolean users_id = userService.editPassword(Integer.parseInt(map1.get("users_id").toString()), p2);
                if (users_id){
                    Map<String, Object> users = userService.login(map1.get("users_name").toString(), p1);
                    session.setAttribute("user",users);

                }
                return "{\"success\":"+users_id+"}";
            }
        }
        return "{\"success\":false}";
    }

    @PostMapping(value = "/photo",produces = "application/json;charset=utf-8")
    public String editPhoto(HttpServletRequest request, @RequestParam(value = "file", required = false)MultipartFile file) throws IOException {
        System.out.println("file = " + file);
        System.out.println(file.getName());//参数名
        System.out.println(file.getOriginalFilename());//文件名
        System.out.println(file.getSize());//文件大小
        InputStream is = file.getInputStream();
        UUID uuid = UUID.randomUUID();
        System.out.println("uuid = " + uuid);
        String realPath1 = request.getServletContext().getRealPath("/static/image");
        String realPath = "D:"+File.separator+"IdeaProjecs"+File.separator+"ssmb2c"+File.separator+"src"+File.separator+"main"+File.separator+"webapp"+File.separator+"static"+File.separator+"image";
        System.out.println("realPath1 = " + realPath1);
        String savePath = "static/image/"+uuid + file.getOriginalFilename().substring(file.getOriginalFilename().lastIndexOf("."));
        File files = new File(realPath + File.separator + uuid + file.getOriginalFilename().substring(file.getOriginalFilename().lastIndexOf(".")));
        File file1 = new File(realPath1 + File.separator + uuid + file.getOriginalFilename().substring(file.getOriginalFilename().lastIndexOf(".")));
        File parentFile = files.getParentFile();
        if (!parentFile.exists()){
            parentFile.mkdirs();
        }
        FileOutputStream fileOutputStream = new FileOutputStream(files);
        FileOutputStream fileOutputStream1 = new FileOutputStream(file1);
        //缓冲区
        byte[] bytes = new byte[128];
        int len = 1; //保存每次读取的长度
        //3.开始读
        while ((len = is.read(bytes)) != -1){
            fileOutputStream.write(bytes,0,bytes.length);
            fileOutputStream1.write(bytes,0,bytes.length);
        }
        //4.释放资源
        is.close();
        fileOutputStream.close();
        fileOutputStream1.close();
        Map<String,Object> user = (Map<String, Object>) request.getSession().getAttribute("user");
        Boolean users_id = userService.modityPhoto(Integer.parseInt(user.get("users_id").toString()), savePath);
        if (users_id){
            Map<String, Object> login = userService.login(user.get("users_name").toString(), user.get("password").toString());
            request.getSession().setAttribute("user",login);
            return "redirect:/address";
        }else {
            return "redirect:/address";
        }
    }

    @PostMapping(value = "/orderPhoto",produces = "application/json;charset=utf-8")
    public String orderPhoto(HttpServletRequest request, @RequestParam(value = "file", required = false)MultipartFile file) throws IOException {
        System.out.println("file = " + file);
        System.out.println(file.getName());//参数名
        System.out.println(file.getOriginalFilename());//文件名
        System.out.println(file.getSize());//文件大小
        InputStream is = file.getInputStream();
        UUID uuid = UUID.randomUUID();
        System.out.println("uuid = " + uuid);
        String realPath1 = request.getServletContext().getRealPath("/static/image");
        String realPath = "D:"+File.separator+"IdeaProjecs"+File.separator+"ssmb2c"+File.separator+"src"+File.separator+"main"+File.separator+"webapp"+File.separator+"static"+File.separator+"image";
        System.out.println("realPath1 = " + realPath1);
        String savePath = "static/image/"+uuid + file.getOriginalFilename().substring(file.getOriginalFilename().lastIndexOf("."));
        File files = new File(realPath + File.separator + uuid + file.getOriginalFilename().substring(file.getOriginalFilename().lastIndexOf(".")));
        File file1 = new File(realPath1 + File.separator + uuid + file.getOriginalFilename().substring(file.getOriginalFilename().lastIndexOf(".")));
        File parentFile = files.getParentFile();
        if (!parentFile.exists()){
            parentFile.mkdirs();
        }
        FileOutputStream fileOutputStream = new FileOutputStream(files);
        FileOutputStream fileOutputStream1 = new FileOutputStream(file1);
        //缓冲区
        byte[] bytes = new byte[128];
        int len = 1; //保存每次读取的长度
        //3.开始读
        while ((len = is.read(bytes)) != -1){
            fileOutputStream.write(bytes,0,bytes.length);
            fileOutputStream1.write(bytes,0,bytes.length);
        }
        //4.释放资源
        is.close();
        fileOutputStream.close();
        fileOutputStream1.close();
        Map<String,Object> user = (Map<String, Object>) request.getSession().getAttribute("user");
        Boolean users_id = userService.modityPhoto(Integer.parseInt(user.get("users_id").toString()), savePath);
        if (users_id){
            Map<String, Object> login = userService.login(user.get("users_name").toString(), user.get("password").toString());
            request.getSession().setAttribute("user",login);
            return "redirect:/order";
        }else {
            return "redirect:/order";
        }
    }

    private SmsApiHttpSendTest am = new SmsApiHttpSendTest();

    @GetMapping(value = "/getCodes",produces = "application/json;charset=utf-8")
    @ResponseBody
    public String getCodes(String tel,String getcode,HttpServletRequest request,HttpSession session){
        if ("1".equals(getcode)){
            tel = request.getSession().getAttribute("tel").toString();
        }
        String rod = "";
        try {
            rod = am.execute(tel);
        }catch (Exception e){
            e.printStackTrace();
        }
        Map<String, Object> map = new HashMap<>();
        if (!"".equals(rod)){
            map.put("code",rod);
            map.put("success",true);
            session.setAttribute("codes",rod);
        }
        System.out.println("rod = " + rod);
        return JSON.toJSONString(map);
    }



}
