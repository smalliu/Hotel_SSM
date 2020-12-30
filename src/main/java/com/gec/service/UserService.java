package com.gec.service;

import com.gec.domain.Menu;
import com.gec.domain.PageBean;
import com.gec.domain.User;
import com.gec.vo.UserVo;

import java.util.Map;

public interface UserService {
    /**
     * 登录业务
     *
     * @param user
     * @return
     */
    public User doLogin(User user);

    /**
     * 获取角色菜单
     *
     * @param roleId
     * @return
     */
    public Map<String, Menu> getRoleMenus(String roleId);


    /**
     * 获取全部用户信息（可分页）
     *
     * @param page
     * @return
     */
    public PageBean<UserVo> getAllUser(PageBean page);

    /**
     * 删除用户
     *
     * @param id
     */
    public void delUserById(String id);

    /**
     * 根据用户id获取用户
     *
     * @param id
     * @return
     */
    public User getUserById(String id);

    /**
     * 更新用户
     *
     * @param user
     * @return
     */
    public void updateUser(User user);

    /**
     * 新增用户
     *
     * @param user
     * @return
     */
    public void insertUser(User user);
}
