package com.oaec.ssm.service;

import com.sun.org.apache.xpath.internal.operations.Bool;

import java.awt.print.Book;
import java.util.Map;

public interface UserService {
    /**
     * 用户登录
     * @param username 用户名
     * @param password 密码
     * @return
     */
    Map<String, Object> login(String username, String password);

    Map<String, Object> register(String username, String password, String tel);

    Map<String, Object> queryByUsername(String username);

    Map<String,Object> queryByTel(String tel);

    Boolean editPassword(Integer userId, String password);

    Boolean modityPhoto(Integer userId, String path);
}
