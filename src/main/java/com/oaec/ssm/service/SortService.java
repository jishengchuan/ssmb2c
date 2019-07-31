package com.oaec.ssm.service;

import java.util.Map;

public interface SortService {
    //根据id查询分类
    Map<String, Object> queryBySid(Integer sid);
}
