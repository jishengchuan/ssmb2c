package com.oaec.ssm.service.Impl;


import com.oaec.ssm.mapper.AddressMapper;
import com.oaec.ssm.service.AddressService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Map;

@Service("/addressService")
public class AddressServiceImpl implements AddressService {

    @Autowired
    private AddressMapper addressMapper;
    @Override
    public List<Map<String, Object>> queryByUserId(Integer userId) {
        return addressMapper.query(userId,null);
    }

    @Override
    public Map<String, Object> queryByAddressId(Integer addressId) {
        return addressMapper.query(null,addressId).get(0);
    }

    @Override
    public boolean doInsert(Map<String, Object> address) {
        return addressMapper.doInsert(address) == 1;
    }

    @Override
    public boolean doUpdate(Map<String, Object> address) {
        return addressMapper.doUpdate(address) == 1;
    }

    @Override
    public boolean doDelete(Integer addressId) {
        return addressMapper.doDelete(addressId) == 1;
    }
}
