package com.oaec.ssm.service.Impl;

import com.github.pagehelper.PageHelper;
import com.oaec.ssm.mapper.CommodityMapper;
import com.oaec.ssm.service.CommodityService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service("commodityService")
public class CommodityServiceImpl implements CommodityService {

    @Autowired
    private CommodityMapper commodityMapper;

    @Override
    public List<Map<String,Object>> query(String name, String sid,String bid, String desc,Integer page) {
        Map<String, Object> map = new HashMap<>();
        map.put("name",name);
        map.put("sid",sid);
        map.put("bid",bid);
        map.put("desc",desc);
        //开始分页
        if (page!=null){
            PageHelper.startPage(page,5);
        }
        return commodityMapper.query(map);
    }


    @Override
    public Map<String,Object> queryByCid(Integer cid) {
        return commodityMapper.queryBySaleOrStock(null,null,cid).get(0);
    }

    @Override
    public List<Map<String, Object>> querySaleAndStock(String sale, String stock,Integer page) {
        if (page != null){
            PageHelper.startPage(page,3);
        }
        return commodityMapper.queryBySaleOrStock(sale,stock,null);
    }

    @Override
    public Map<String, Object> queryCidByStock(Integer cid) {
        return commodityMapper.queryBySaleOrStock(null,null,cid).get(0);
    }

}
