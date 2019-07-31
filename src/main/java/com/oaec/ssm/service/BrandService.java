package com.oaec.ssm.service;

import java.util.List;
import java.util.Map;

public interface BrandService {
    //根据分类id，查询分类中的品牌
    List<Map<String,Object>> queryBySid(String sid);
    //根据品牌id查询
    Map<String, Object> queryByBid(Integer bid);
}
