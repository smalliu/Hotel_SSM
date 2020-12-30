package com.gec.controller;

import com.alibaba.fastjson.JSONObject;
import com.gec.domain.Menu;
import com.gec.domain.PageBean;
import com.gec.domain.User;

import com.gec.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.context.ContextLoader;
import org.springframework.web.context.WebApplicationContext;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.util.Map;

@Controller
@RequestMapping("/User")
public class UserController {

    @Autowired
    private UserService userService;

    //用户登录
    @RequestMapping("/login")
    public String login(User user, HttpServletRequest req,
                        HttpServletResponse resp) {
        System.out.println("{UserController} 成功访问了 login();");
        System.out.println("UserController user = " + user);
        //1、前端传输的账号密码 默认是 “”
        User svUser = userService.doLogin(user);
        String result = "";
        if (svUser != null) {
            HttpSession session = req.getSession();//{ps} 获取session
            session.setAttribute("user", svUser);
            // {ps} 获取 用户菜单, 只有角色菜单不存在时
            // 才从数据库索取, 并放入应用程序域。。
            makeMenu(svUser.getRoleId());
            result = "index";
        } else {
            result = "redirect:/login.jsp?errCode=1";
        }

        return result;
    }

    //获取菜单
    private void makeMenu(String roleId) {
        // Spring MVC 获取ServletContext
        WebApplicationContext webApplicationContext = ContextLoader.getCurrentWebApplicationContext();
        ServletContext context = webApplicationContext.getServletContext();
        String KEY = "menu_" + roleId;
        Map<String, Menu> menuMap = (Map) context.getAttribute(KEY);
        //{ps} 只要  menuMap 不存在，我才要做事 ..
        if (menuMap == null) {
            //{ps} 这里从数据库中得到了角色的菜单 ..
            menuMap = userService.getRoleMenus(roleId);
            //{ps} 得到后, 存入 context 域
            context.setAttribute(KEY, menuMap);
        }
    }

    /**
     * 退出登录
     *
     * @param user
     * @param req
     * @param resp
     * @return
     */
    @RequestMapping("/logout")
    public String logout(User user, HttpServletRequest req,
                         HttpServletResponse resp) {
        System.out.println("{UserController} 成功访问了 login();");


        HttpSession session = req.getSession();
        //清除session
        session.invalidate();
        //加上/的重定向就会回到根目录
        return "redirect:/login.jsp";
    }

}
