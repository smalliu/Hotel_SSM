package com.gec.dao;

import com.gec.domain.Role;
import com.gec.domain.User;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository("UserDao")
public interface UserDao {

    /**
     * 根据用户名获取用户
     *
     * @param account
     * @return
     */
    public User getUserByAccount(String account);


    /**
     * 获取全部用户信息
     *
     * @return
     */
    public List<User> getUserList();

    /**
     * 根据用户id删除用户
     *
     * @param id 角色id
     * @return
     */
    public void delUserById(String id);

    /**
     * 根据用户Id获取用户
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
