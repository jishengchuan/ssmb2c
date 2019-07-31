package com.oaec.ssm.service;

import java.util.List;
import java.util.Map;

public interface CommodityService {

    //商品检索
    List<Map<String,Object>> query(String name, String sid, String bid, String desc,Integer page);
    //根据商品id检索
    Map<String,Object> queryByCid(Integer cid);
    //销售库存排行榜
    List<Map<String,Object>> querySaleAndStock(String sale, String stock,Integer page);
    //查询库存
    Map<String,Object> queryCidByStock(Integer cid);

}
