package com.gec.controller;

import com.alibaba.fastjson.JSONObject;
import com.gec.domain.PageBean;
import com.gec.domain.User;
import com.gec.service.UserService;
import com.gec.vo.UserVo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@Controller
@RequestMapping("/Admin")
public class AdminController {

    @Autowired
    private UserService userService;

    /**
     * 跳转用户列表
     *
     * @return
     */
    @RequestMapping("/viewUserList")
    protected String viewUserList() {
        return "/admin/userList";
    }

    /**
     * 跳转新增用户
     *
     * @return
     */
    @RequestMapping("/viewAddUser")
    protected String viewAddUser() {
        return "admin/adduser";
    }

    /**
     * 获取用户列表
     *
     * @param page
     * @return
     */
    @RequestMapping(value = "/userList", produces = {"application/json;charset=UTF-8"})
    @ResponseBody
    public String list(PageBean page) {
        PageBean<UserVo> pBean = userService.getAllUser(page);

        //{ps} 将 PageBean 转为  LayUI 要求的数据格式。
        JSONObject jsObj = new JSONObject();
        jsObj.put("code", "0");
        jsObj.put("msg", "");
        jsObj.put("count", pBean.getCount());
        jsObj.put("data", pBean.getJsArray());

        return jsObj.toJSONString();
    }


    /**
     * 根据用户id获取用户
     *
     * @param user
     * @return
     * @throws ServletException
     * @throws IOException
     */
    @RequestMapping(value = "/getUser", produces = "application/json;charset=UTF-8")
    @ResponseBody
    protected String getUser(User user)
            throws ServletException, IOException {
        User svUser = userService.getUserById(user.getId());
        JSONObject jsObj = new JSONObject();
        jsObj.put("result", "success");
        jsObj.put("user", svUser);
        return jsObj.toJSONString();
    }

    /**
     * 更新用户
     *
     * @param user
     * @return
     */
    @RequestMapping(value = "/updateUser", produces = {"application/json;charset=UTF-8"})
    //表示该方法的返回结果直接写入 HTTP response body 中，一般在异步获取数据时使用【也就是AJAX】
    @ResponseBody
    protected String updateUser(User user) {
        JSONObject jsObj = new JSONObject();
        userService.updateUser(user);
        jsObj.put("result", "success");
        return jsObj.toJSONString();
    }


    /**
     * 删除用户
     *
     * @param uesr
     * @return
     */
    @RequestMapping("/delUser")
    public String delUserById(User uesr) {
        JSONObject jsonObject = new JSONObject();
        userService.delUserById(uesr.getId());
        jsonObject.put("result", "success");
        System.out.println("删除用户成功。。。。。");
        return jsonObject.toJSONString();
    }


    /**
     * 新增用户
     *
     * @return
     */
    @RequestMapping(value = "/insertUser", produces = {"application/json;charset=UTF-8"})
    @ResponseBody
    protected String insertUser(User user) {
        JSONObject jsObj = new JSONObject();
        userService.insertUser(user);
        jsObj.put("result", "success");
        return jsObj.toJSONString();
    }
}
