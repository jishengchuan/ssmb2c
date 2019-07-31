package com.oaec.ssm.interceptors;

import org.springframework.stereotype.Component;
import org.springframework.web.servlet.HandlerInterceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@Component
public class LoginInterceptor implements HandlerInterceptor {

    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
        HttpSession session = request.getSession();
        if (session.getAttribute("user") == null){
            //获取拦截地址
            String requestURI = request.getRequestURI();
            if (requestURI.contains("add2shop")){
                String cid = request.getParameter("cid");
                if (cid != null){
                    requestURI = requestURI.replace("add2shop", "xiangqing")+"?cid="+cid;
                }else{
                    requestURI = requestURI.replace("add2shop", "list");
                }

            }
            response.sendRedirect(request.getContextPath()+"/login?uri="+requestURI);
            return false;
        }else {
            return true;
        }
    }
}
