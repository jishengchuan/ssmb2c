package com.oaec.ssm.mapper;

import org.apache.ibatis.annotations.Param;

import java.util.List;
import java.util.Map;

public interface ShopMapper {
    //根据用户编号查询用户的购物车中的商品
    List<Map<String,Object>> queryByUserId(Integer userId);

    //int doInsert(Integer userId,Integer commodityId, Integer quantity);
    /**
     * 添加商品到购物车（数据层方法需要多个参数，一般用map）
     * @param
     * @return
     */
    int doInsert(Map<String,Object> param);

    //查询购物车中的商品
    Map<String,Object> queryByUserIdAndCommodityId(@Param("userId") Integer userId,@Param("commodityId") Integer commodityId);

    //更新数量
    int updateQuantity(Map<String,Object> param);

    //购物车中商品删除
    int doDelete(@Param("userId") Integer userId,@Param("commodityId") Integer commodityId);

    //修改数量
    int editQuantity(@Param("userId") Integer userId,@Param("quantity") Integer quantity,@Param("commodityId") Integer commodityId);

    // 查询总价
    Map<String, Object> queryTotal(@Param("userId") Integer userId,@Param("commodityIds") Integer[] commodityIds);

    List<Map<String, Object>> queryCommodity4Checkout(@Param("userId") Integer userId,@Param("commodityIds") Integer[] commodityIds);

}
