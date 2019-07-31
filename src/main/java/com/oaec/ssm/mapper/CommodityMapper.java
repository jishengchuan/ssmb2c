package com.oaec.ssm.mapper;

import org.apache.ibatis.annotations.Param;

import java.util.List;
import java.util.Map;

public interface CommodityMapper {

    int getCountAll();

    List<Map<String,Object>> query(Map<String,Object> param);


    List<Map<String,Object>> queryBySaleOrStock(@Param("sale") String sale,@Param("stock") String stock,@Param("cid") Integer cid);

    //修改商品库存和销量
    int updateStockAndSale(@Param("cid") Integer cid,@Param("quantity") Integer quantity);

}
