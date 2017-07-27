package com.hxj.page;

import java.util.List;

/**
 * Created by hxj on 17-7-24.
 */
public class PageBean<T>{

    private int pageNow = 1;
    private int pageCount = 5;
    private int totalRows;
    private int totalPages;
    private List<T> datas;
    private Condition conditions;

    public int getPageNow() {
        return pageNow;
    }

    public int getPageCount() {
        return pageCount;
    }

    public int getTotalRows() {
        return totalRows;
    }

    public int getTotalPages() {
        if(totalRows%pageCount==0){
            totalPages = totalRows/pageCount;
        }else{
            totalPages = totalRows/pageCount+1;
        }
        return totalPages;
    }

    public List<T> getDatas() {
        return datas;
    }

    public Condition getConditions() {
        return conditions;
    }

    public void setPageNow(int pageNow) {
        this.pageNow = pageNow;
    }

    public void setPageCount(int pageCount) {
        this.pageCount = pageCount;
    }

    public void setTotalRows(int totalRows) {
        this.totalRows = totalRows;
    }

    public void setTotalPages(int totalPages) {
        this.totalPages = totalPages;
    }

    public void setDatas(List<T> datas) {
        this.datas = datas;
    }

    public void setConditions(Condition conditions) {
        this.conditions = conditions;
    }

    @Override
    public String toString() {
        return "PageBean{" +
                "pageNow=" + pageNow +
                ", pageCount=" + pageCount +
                ", totalRows=" + totalRows +
                ", totalPages=" + totalPages +
                '}';
    }
}
