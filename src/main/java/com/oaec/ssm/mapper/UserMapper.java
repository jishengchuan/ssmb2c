package com.oaec.ssm.mapper;

import org.apache.ibatis.annotations.Param;

import java.util.Map;

public interface UserMapper {

    Map<String,Object> query(@Param("username") String username,@Param("password") String password,@Param("tel") String tel);

    /**
     * 用户注册
     * @param username 用户名
     * @param password 密码
     * @return
     */
    int doInsert(@Param("username") String username,@Param("password") String password,@Param("tel") String tel);

    int editPassword(@Param("userId") Integer userId,@Param("password") String password);

    int modityPhoto(@Param("userId") Integer userId,@Param("path") String path);
}
