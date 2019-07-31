package com.oaec.ssm.interceptors;

import com.oaec.ssm.service.NavService;
import org.apache.ibatis.plugin.Intercepts;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.web.servlet.HandlerInterceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.List;
import java.util.Map;

@Component
public class NavInterceptor implements HandlerInterceptor {

    @Autowired
    private NavService navService;

    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
        //查询导航中需要的分类
        List<Map<String,Object>> nav = navService.getNav();
        //将查询到的nav存在request中
        request.setAttribute("nav",nav);
        return true;
    }
}
