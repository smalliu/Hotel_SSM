package com.gec.domain;

import java.util.HashSet;
import java.util.Set;

public class Menu {
    private String menuId;
    private String menuName;
    private Set<MenuItem> menuItems = new HashSet<MenuItem>();

    public Menu(String menuId, String menuName) {
        this.menuId = menuId;
        this.menuName = menuName;
    }

    // {ps} 添加一个菜单项到 Set<MenuItem> 集合中.
    public void addMenuItem(MenuItem mi) {
        this.menuItems.add(mi);
    }

    public String getMenuId() {
        return menuId;
    }

    public void setMenuId(String menuId) {
        this.menuId = menuId;
    }

    public String getMenuName() {
        return menuName;
    }

    public void setMenuName(String menuName) {
        this.menuName = menuName;
    }

    public Set<MenuItem> getMenuItems() {
        return menuItems;
    }

    @Override
    public String toString() {
        return "Menu [menuId=" + menuId + ", menuName=" + menuName + "]";
    }

}
