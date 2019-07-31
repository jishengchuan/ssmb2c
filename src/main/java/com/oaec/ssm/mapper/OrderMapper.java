package com.oaec.ssm.mapper;

import org.apache.ibatis.annotations.Param;

import java.util.List;
import java.util.Map;

public interface OrderMapper {
    //根据编号查订单
    List<Map<String ,Object>> queryByUserId(Integer userId);
    //根据订单查商品
    List<Map<String ,Object>> queryCommodityByOrderId(Integer orderId);
    //查询订单总金额
    Double getTotalPrice(Integer ordersId);
    //订单主表插入
    /*int doInsert(@Param("userId") Integer userId,@Param("addressId") Integer addressId,@Param("orderId")Integer orderId);*/
    int doInsert(Map<String,Object> param);
    //订单明细表插入数据
    int doInsertDetail(Map<String,Object> param);
}
