package com.oaec.ssm.service;

import java.util.List;
import java.util.Map;

public interface ShopService {

    //查询指定用户的购物车中的商品
    List<Map<String,Object>> getShopCommidties(Integer userId);

    //添加商品到购物车
    boolean addShop(Integer userId, Integer commodityId, Integer quantity);

    /**
     * 购物车中商品的删除
     * @param userId
     * @param commodityId
     * @return
     */
    boolean delete(Integer userId, Integer commodityId);

    /**
     * 修改购物车中的数量
     * @param action add 加
     * @param userId
     * @param commodityId
     * @return
     */
    int updateQuantity(String action, Integer quantity, Integer userId, Integer commodityId);

    /**
     * 计算单个商品价格*数量
     * @param userId
     * @param commodityId
     * @return
     */
    Double queryCommodityPrice(Integer userId, Integer commodityId);

    /**
     * 计算购物车中商品
     * @param userId
     * @param commodityIds
     * @return
     */
    Map<String, Object> getTotal(Integer userId, Integer[] commodityIds);

    List<Map<String, Object>> getCommodities4Checkout(Integer userId, Integer[] commodityIds);

}
