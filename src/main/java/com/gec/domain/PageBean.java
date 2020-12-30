package com.gec.domain;

import com.alibaba.fastjson.JSONArray;

import java.util.List;

public class PageBean<T> {
    private int count = 0; //{ps} 总记录数
    private int page = 0; //{ps} 当前页码
    private int limit = 1; //{ps} 页码大小
    private List<T> list; //{ps} 数据列表
    private JSONArray jsArray; //{ps} json数组

    //作用：list===>JSONArray
    public void setList(List<T> list) {
        jsArray = new JSONArray();
        for (T t : list) {
            jsArray.add(t);
        }
        this.list = list;
        this.jsArray = jsArray;
    }

    public int getCount() {
        return count;
    }

    public void setCount(int count) {
        this.count = count;
    }

    public int getPage() {
        return page;
    }

    public void setPage(int page) {
        this.page = page;
    }

    public int getLimit() {
        return limit;
    }

    public void setLimit(int limit) {
        this.limit = limit;
    }

    public JSONArray getJsArray() {
        return jsArray;
    }

    public void setJsArray(JSONArray jsArray) {
        this.jsArray = jsArray;
    }

    public List<T> getList() {
        return list;
    }

    @Override
    public String toString() {
        return "PageBean [count=" + count + ", page=" + page + ", limit=" + limit + ", list=" + list + ", jsArray="
                + jsArray + "]";
    }

}
