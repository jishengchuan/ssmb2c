package com.oaec.ssm.service.Impl;


import com.oaec.ssm.mapper.SortMapper;
import com.oaec.ssm.service.NavService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Map;

@Service("/navService")
public class NavServicrImpl implements NavService {

    //业务层：依赖数据层
    @Autowired
    private SortMapper sortMapper;

    @Override
    public List<Map<String,Object>> getNav() {
        return sortMapper.queryNav();
    }
}
