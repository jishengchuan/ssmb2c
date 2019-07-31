package com.oaec.ssm.mapper;

import java.util.List;
import java.util.Map;

public interface SortMapper {
    /**
     * 导航：查询至少有一个商品的分类
     * @return
     */
    List<Map<String,Object>> queryNav();

    //根据id查询分类
    Map<String, Object > queryBySid(Integer sid);
}
