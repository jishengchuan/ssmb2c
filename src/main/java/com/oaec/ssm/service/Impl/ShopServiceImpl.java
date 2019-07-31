package com.oaec.ssm.service.Impl;


import com.oaec.ssm.mapper.CommodityMapper;
import com.oaec.ssm.mapper.ShopMapper;
import com.oaec.ssm.service.CommodityService;
import com.oaec.ssm.service.ShopService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service("/shopService")
public class ShopServiceImpl implements ShopService {

    @Autowired
    private ShopMapper shopMapper;
    @Autowired
    private CommodityService commodityService;

    @Override
    public List<Map<String,Object>> getShopCommidties(Integer userId) {
        return shopMapper.queryByUserId(userId);
    }

    @Override
    public boolean addShop(Integer userId, Integer commodityId, Integer quantity) {
        //查询当前用户购物车中是否存在当前商品
        Map<String, Object> shop = shopMapper.queryByUserIdAndCommodityId(userId, commodityId);
        Map<String, Object> param = new HashMap<>();
        param.put("userId",userId);
        param.put("commodityId",commodityId);
        param.put("quantity",quantity);
        int result = 0;
        if (shop == null){
            //没有添加商品
            //返回值是影响的行数
            result = shopMapper.doInsert(param);
        }else {
            //有，修改数量
            result = shopMapper.updateQuantity(param);
        }
        return result == 1;
    }

    @Override
    public boolean delete(Integer userId, Integer commodityId) {
        return shopMapper.doDelete(userId,commodityId) == 1;
    }

    @Override
    public int updateQuantity(String action, Integer quantity, Integer userId, Integer commodityId) {
        int result = 0;
        Map<String, Object> map = commodityService.queryCidByStock(commodityId);
        int stock = Integer.parseInt(map.get("stock").toString());
        if (stock > quantity){
            if("add".equals(action)){
                result = shopMapper.editQuantity(userId, quantity,commodityId);
            }
            if ("sub".equals(action)){
                result = shopMapper.editQuantity(userId, quantity,commodityId);
            }
            if ("".equals(action)) {
                result = shopMapper.editQuantity(userId, quantity,commodityId);
            }
            return result;
        }else {
            return stock;
        }
    }

    @Override
    public Double queryCommodityPrice(Integer userId, Integer commodityId) {
        //获取购买价格
        List<Map<String, Object>> shops = shopMapper.queryByUserId(userId);
        Map<String, Object> commodity = new HashMap<>();
        for (Map<String, Object> shop : shops) {
            String commodity_id = shop.get("commodity_id").toString();
            int i = Integer.parseInt(commodity_id);
            if (i == commodityId){
                commodity = shop;
                break;
            }
        }
        String commdoity_price = commodity.get("commodity_price").toString();
        double price = Double.parseDouble(commdoity_price);
        //获取购买数量
        Map<String, Object> map = shopMapper.queryByUserIdAndCommodityId(userId, commodityId);
        String quantity = map.get("quantity").toString();
        int quantities = Integer.parseInt(quantity);
        return (price*quantities);
    }

    @Override
    public Map<String, Object> getTotal(Integer userId, Integer[] commodityIds) {
        return shopMapper.queryTotal(userId,commodityIds);
    }

    @Override
    public List<Map<String, Object>> getCommodities4Checkout(Integer userId, Integer[] commodityIds) {
        return shopMapper.queryCommodity4Checkout(userId,commodityIds);
    }


}
