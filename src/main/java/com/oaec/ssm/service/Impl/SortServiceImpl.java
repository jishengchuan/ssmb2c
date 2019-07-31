package com.oaec.ssm.service.Impl;


import com.oaec.ssm.mapper.SortMapper;
import com.oaec.ssm.service.SortService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.Map;

@Service("/sortService")
public class SortServiceImpl implements SortService {

    @Autowired
    private SortMapper sortMapper;

    @Override
    public Map<String, Object> queryBySid(Integer  sid) {
        return sortMapper.queryBySid(sid);
    }
}
