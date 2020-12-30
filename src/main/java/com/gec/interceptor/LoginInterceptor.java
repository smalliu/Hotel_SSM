package com.gec.interceptor;

import com.gec.domain.User;
import org.springframework.web.servlet.HandlerInterceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

public class LoginInterceptor implements HandlerInterceptor {

    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws IOException {

        //获取请求的URL:去除http:localhost:8080这部分剩下的
        String uri = request.getRequestURI();
        System.out.println("拦截器测试：" + uri);
        //url：除了login.jsp是可以公开访问的，其他的URL都进行拦截控制
        if (uri.indexOf("/login") >= 0) {
            return true;
        }
        //获取session
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");
        //判断session中是否有用户数据，如果有，则返回true，继续向下执行
        if (user != null) {
            return true;
        }
        //不符合条件的给出提示信息，并转发到登录页面
        //request.setAttribute("message", "您还没有登录，请先登录！");
        response.sendRedirect(request.getContextPath() + "/login.jsp?errCode=noLogin");
        return false;
    }
}
