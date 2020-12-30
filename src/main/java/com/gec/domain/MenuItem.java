package com.gec.domain;

public class MenuItem {
    private String itemId; // {ps} 子菜单 ID
    private String itemName; // {ps} 子菜单名称
    private String urlLink; // {ps} 映射地址
    private String visible; // {ps} 可见性

    public MenuItem(String itemId, String itemName, String urlLink, String visible) {
        this.itemId = itemId;
        this.itemName = itemName;
        this.urlLink = urlLink;
        this.visible = visible;
    }

    public String getItemId() {
        return itemId;
    }

    public void setItemId(String itemId) {
        this.itemId = itemId;
    }

    public String getItemName() {
        return itemName;
    }

    public void setItemName(String itemName) {
        this.itemName = itemName;
    }

    public String getUrlLink() {
        return urlLink;
    }

    public void setUrlLink(String urlLink) {
        this.urlLink = urlLink;
    }

    public String getVisible() {
        return visible;
    }

    public void setVisible(String visible) {
        this.visible = visible;
    }

    @Override
    public String toString() {
        return "MenuItem [itemId=" + itemId + ", itemName=" + itemName + ", urlLink=" + urlLink + ", visible=" + visible
                + "]";
    }
}
