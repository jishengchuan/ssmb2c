package com.oaec.ssm.service.Impl;

import com.oaec.ssm.mapper.QuotMapper;
import com.oaec.ssm.service.QuotService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Map;

@Service("/quotService")
public class QuotServiceImpl implements QuotService {

    @Autowired
    private QuotMapper quotMapper;

    @Override
    public Map<String, Object> randQuot() {
        List<Map<String, Object>> list = quotMapper.queryAllQuot();
        int size = list.size();
        int random =(int) (Math.random() * 1000) % size;
        for (int i = 0; i < size; i++){
            if(i == random){
                return list.get(i);
            }
        }
        return null;
    }
}
