package com.gec.dao;

import com.gec.domain.RoleMenu;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface MenuDao {

    public List<RoleMenu> getRoleMenus(String roleId);


}
