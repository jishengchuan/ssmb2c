package com.oaec.ssm.service.Impl;


import com.oaec.ssm.mapper.AddressMapper;
import com.oaec.ssm.mapper.CommodityMapper;
import com.oaec.ssm.mapper.OrderMapper;
import com.oaec.ssm.mapper.ShopMapper;
import com.oaec.ssm.service.OrderService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service("/orderService")
public class OrderServiceImpl implements OrderService {

    @Autowired
    private OrderMapper orderMapper;
    @Autowired
    private AddressMapper addressDapper;
    @Autowired
    private ShopMapper shopMapper;
    @Autowired
    private CommodityMapper commodityMapper;

    @Override
    public List<Map<String, Object>> getOrders(Integer userId) {
        //根据用户编号查询用户所有订单
        List<Map<String, Object>> orders = orderMapper.queryByUserId(userId);
        //查询订单对应的地址
        for (Map<String, Object> order : orders) {
            //1.获取地址编号
            int address_id = Integer.parseInt(order.get("address_id").toString());
            //2.查询订单对应的地址
            Map<String, Object> address = addressDapper.query(null,address_id).get(0);
            order.put("address",address);
            //3.查询订单的总价钱
            int orders_id = Integer.parseInt(order.get("orders_id").toString());
            Double totalPrice = orderMapper.getTotalPrice(orders_id);
            order.put("totalPrice",totalPrice);
            //4.查询出订单对应的商品
            List<Map<String, Object>> commodities = orderMapper.queryCommodityByOrderId(orders_id);
            order.put("commodities",commodities);
        }
        return orders;
    }

    @Override
    public boolean submit(Integer userId, Integer aid, Integer[] cids) {
        int result = 0;
        //1.向订单主表插入数据
        Map<String,Object> param = new HashMap<>();
        param.put("orderId",null);
        param.put("userId",userId);
        param.put("addressId",aid);
        System.out.println("param = " + param);
        orderMapper.doInsert(param);
        System.out.println("param = " + param);
        for (Integer commodityId : cids) {
            //查询当前编号的商品信息
            Map<String, Object> commodity = shopMapper.queryByUserIdAndCommodityId(userId, commodityId);
            //2.向订单明细表插入数据
            commodity.put("orders_id",param.get("orderId"));
            result += orderMapper.doInsertDetail(commodity);
            //3.在购物车中删除此商品
            result += shopMapper.doDelete(userId,commodityId);
            //4.修改库存和销量
            int quantity = Integer.parseInt(commodity.get("quantity").toString());
            result += commodityMapper.updateStockAndSale(commodityId,quantity);
        }
        if (result > 0){
            return true;
        }
        return false;
    }
}
