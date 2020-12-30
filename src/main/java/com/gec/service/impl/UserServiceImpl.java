package com.gec.service.impl;

import com.gec.dao.MenuDao;
import com.gec.dao.UserDao;
import com.gec.domain.*;
import com.gec.service.UserService;
import com.gec.vo.UserVo;
import com.github.pagehelper.Page;
import com.github.pagehelper.PageHelper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;


import java.util.*;

@Service("UserService")
public class UserServiceImpl implements UserService {

    @Autowired
    private UserDao userDao;

    @Autowired
    private MenuDao menuDao;

    @Override
    public User doLogin(User user) {
        System.out.println("{debug} UserServlet.doLogin()");
        //{ps} 从数据库中获取一个 User 对象, 根据 Account 名
        User daoUser = userDao.getUserByAccount(user.getAccount());
        //{1} 查询数据库不一定查到记录
        if (daoUser != null) {  //{ps} 不为空, 意味着有数据。
            String pass1 = user.getPassword();
            String pass2 = daoUser.getPassword();
            //{ps} 比对一下密码
            if (pass1.equals(pass2)) {
                //{ps} 返回一个 User 对象 [查出来的]
                return daoUser;
            }
        }
        return null;
    }

    @Override
    public Map<String, Menu> getRoleMenus(String roleId) {
        //1、获取菜单
        List<RoleMenu> roleMenus = menuDao.getRoleMenus(roleId);
        //2、解析菜单
        Map<String, Menu> menuMap = parseList(roleMenus);

        return menuMap;
    }

    @Override
    public PageBean<UserVo> getAllUser(PageBean page) {

        //当前的页数
        int curPage = (page.getPage() <= 0) ? 1 : page.getPage();
        //每页的大小
        int pageSize = (page.getLimit() <= 0) ? 10 : page.getLimit();
        //1、执行分页
        Page<Object> objectPage = PageHelper.startPage(curPage, pageSize, true);
        //2、获取所有用户(分页)
        List<User> userList = userDao.getUserList();

        //3、获取总记录数
        int recCnt = (int) objectPage.getTotal();

        //4、数据类型转换
        List<UserVo> userVos = transform(userList);
        //5、将数据存入分页bean
        PageBean<UserVo> pageBean = new PageBean();

        pageBean.setCount(recCnt);
        pageBean.setList(userVos);

        return pageBean;
    }

    /**
     * 删除用户
     *
     * @param id
     */
    @Override
    public void delUserById(String id) {
        userDao.delUserById(id);
    }

    @Override
    public User getUserById(String id) {
        User user = userDao.getUserById(id);
        return user;

    }

    /**
     * 更新用户
     *
     * @param user
     */
    @Override
    public void updateUser(User user) {
        userDao.updateUser(user);
    }

    /**
     * 新增用户
     *
     * @param user
     * @return
     */
    @Override
    public void insertUser(User user) {
        //生成随机的主键
        String uuid = UUID.randomUUID().toString();
        user.setId(uuid.replace("-", ""));
        userDao.insertUser(user);
    }

    private Map<String, Menu> parseList(List<RoleMenu> list) {
        Map<String, Menu> menuMap = new HashMap();
        //{a} 迭代列表, 把里面的数据拆解出来。
        for (RoleMenu roleMenu : list) {
            String menuId = roleMenu.getMenuId();
            //{b} 根据 menuId 从 Map 中取出 Menu 对象。
            Menu mu = menuMap.get(menuId);
            if (mu == null) {
                //{c} 如果不存在对象, 则创建之
                mu = new Menu(menuId,
                        roleMenu.getMenuName());
                menuMap.put(menuId, mu);
            }
            //{d} 创建一个 MenuItem 对象(用的是列表的数据)
            MenuItem mi = new MenuItem(
                    roleMenu.getItemId(), roleMenu.getItemName(),
                    roleMenu.getUrlLink(), roleMenu.getVisible());
            //{e} 把 mi 对象添加到  Menu 中
            mu.addMenuItem(mi);
        }
        return menuMap;
    }

    /**
     * 进行持久化对象与显示对象转换
     *
     * @param userList
     * @return
     */
    private List<UserVo> transform(List<User> userList) {
        List<UserVo> userVos = new ArrayList();

        for (User user : userList) {
            UserVo userVo = new UserVo();
            userVo.setId(user.getId());
            userVo.setAccount(user.getAccount());
            userVo.setNickName(user.getNickName());
            userVo.setNo(user.getNo());
            userVo.setSex(user.getSex());
            userVo.setRoleName(user.getRole().getRoleName());
            userVo.setCreateDate(user.getCreateDate());
            userVos.add(userVo);
        }
        return userVos;
    }
}
