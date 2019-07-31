package com.oaec.ssm.service.Impl;

import com.oaec.ssm.mapper.UserMapper;
import com.oaec.ssm.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.HashMap;
import java.util.Map;

@Service("/userService")
public class UserServiceImpl implements UserService {

    @Autowired
    private UserMapper userMapper;

    @Override
    public Map<String, Object> login(String username, String password) {
        Map<String, Object> map = userMapper.query(username, password,null);
        if(map == null) {
            //登录失败，用户名不存在
            map = new HashMap<>();
            map.put("error", "用户名不存在");
        }else {
            if(map.get("password").equals(password)) {
                //登录成功
                return map;
            }else {
                //登录失败，密码错误
                map.clear();
                map.put("error", "密码错误");
            }
        }
        return map;
    }
    @Override
    public Map<String, Object> register(String username, String password, String tel){
        Map<String, Object> map1 = userMapper.query(username,null,null);
        Map<String, Object> map = new HashMap<>();
        if (map1 == null){
            boolean b = userMapper.doInsert(username, password,tel) == 1;
            if(b){
                //添加成功
                map.put("success","注册成功");
            }else {
                //添加失败
                map.put("error","error:注册失败");
            }
            return map;
        }else{
            map.put("error","error:用户名错误");
        }
        return map;
    }

    @Override
    public Map<String, Object> queryByUsername(String username) {

        Map<String, Object> map = userMapper.query(username,null,null);
        if(map == null){
            //可以添加
            map = new HashMap<>();
            map.put("success",true);
        }else{
            //不可以添加，已有此用户名
            map.clear();
            map.put("error","用户名已存在");
        }
        return map;
    }

    @Override
    public Map<String, Object> queryByTel(String tel) {
        return userMapper.query(null,null,tel);
    }

    @Override
    public Boolean editPassword(Integer userId, String password) {
        return userMapper.editPassword(userId,password) == 1;
    }

    @Override
    public Boolean modityPhoto(Integer userId, String path) {
        return userMapper.modityPhoto(userId,path) == 1;
    }

}