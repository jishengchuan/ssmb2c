package com.oaec.ssm.mapper;

import org.apache.ibatis.annotations.Param;

import java.util.List;
import java.util.Map;

public interface AddressMapper {
    //查询
    List<Map<String,Object>> query(@Param("userId") Integer userId,@Param("addressId") Integer addressId);
    //添加地址
    int doInsert(Map<String, Object> param);
    //修改地址
    int doUpdate(Map<String, Object> param);
    //删除地址
    int doDelete(Integer addressId);
}
