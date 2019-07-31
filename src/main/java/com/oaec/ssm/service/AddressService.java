package com.oaec.ssm.service;

import java.util.List;
import java.util.Map;

public interface AddressService {

    List<Map<String, Object>> queryByUserId(Integer userId);

    Map<String, Object> queryByAddressId(Integer addressId);

    boolean doInsert(Map<String, Object> address);

    boolean doUpdate(Map<String, Object> address);

    boolean doDelete(Integer addressId);
}
