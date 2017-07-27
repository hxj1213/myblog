package com.hxj.page;

import com.hxj.entity.Blog;
import org.apache.commons.dbutils.QueryRunner;
import org.apache.commons.dbutils.handlers.BeanListHandler;
import org.apache.commons.dbutils.handlers.MapListHandler;
import org.apache.commons.dbutils.handlers.ScalarHandler;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

/**
 * Created by hxj on 17-7-24.
 */
public class PageUtils {

    public static  <T> void getByPage(QueryRunner qr,String basesql,PageBean<T> pb, Class clazz){
        String total_sql = "select count(*) from ("+basesql+") tb ";
        System.out.println("total_sql:"+total_sql);
        try {
            Long totalRows = qr.query(total_sql,new ScalarHandler<Long>());
            pb.setTotalRows(totalRows.intValue());
        } catch (SQLException e) {
            e.printStackTrace();
        }

        if(pb.getPageNow()>pb.getTotalPages()){
            pb.setPageNow(pb.getTotalPages());
        }

        if(pb.getPageNow()<1){
            pb.setPageNow(1);
        }

        int startIndex = (pb.getPageNow()-1)*pb.getPageCount();
        String data_sql = "select * from ("+basesql+") tb limit ?,?";
        System.out.println("data_sql:"+data_sql);
        try {
            List<T> datas = qr.query(data_sql,new BeanListHandler<T>(clazz),startIndex,pb.getPageCount());
            System.out.println("datas:"+datas);
            pb.setDatas(datas);
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public static void getByPage(QueryRunner qr,PageBean<Map<String,Object>> pb,String basesql){
        String total_sql = "select count(*) from ("+basesql+") tb ";
        System.out.println("total_sql:"+total_sql);
        try {
            Long totalRows = qr.query(total_sql,new ScalarHandler<Long>());
            pb.setTotalRows(totalRows.intValue());
        } catch (SQLException e) {
            e.printStackTrace();
        }

        if(pb.getPageNow()>pb.getTotalPages()){
            pb.setPageNow(pb.getTotalPages());
        }

        if(pb.getPageNow()<1){
            pb.setPageNow(1);
        }

        int startIndex = (pb.getPageNow()-1)*pb.getPageCount();
        String data_sql = "select * from ("+basesql+" order by id desc ) tb limit ?,?";
        System.out.println("data_sql:"+data_sql);
        try {
            List<Map<String,Object>> datas = qr.query(data_sql,new MapListHandler(),startIndex,pb.getPageCount());
            System.out.println("datas:"+datas);
            pb.setDatas(datas);
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

}
