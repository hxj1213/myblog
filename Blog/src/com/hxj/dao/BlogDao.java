package com.hxj.dao;

import com.hxj.entity.Blog;
import com.hxj.page.PageBean;
import com.hxj.page.PageUtils;
import com.hxj.util.JdbcUtils;
import org.apache.commons.dbutils.QueryRunner;
import org.apache.commons.dbutils.handlers.*;

import java.sql.Connection;
import java.sql.SQLException;
import java.util.List;
import java.util.Map;

/**
 * Created by hxj on 17-7-21.
 */
public class BlogDao {

    private QueryRunner qr = new QueryRunner(JdbcUtils.getDataSource());

    public void save(Blog blog){

        String sql = "insert into entries(title,content,posted_on,user_id) values(?,?,?,?)";

        try {
           int result =  qr.update(sql,blog.getTitle(),blog.getContent(),blog.getPosted_on(),blog.getUser_id());
           System.out.println("添加："+result);
        } catch (SQLException e) {
            e.printStackTrace();
        }

    }

    public void update(Blog blog){

        String sql = "update entries set title=?,content=?,posted_on=? where id=?";

        try {
            int result =  qr.update(sql,blog.getTitle(),blog.getContent(),blog.getPosted_on(),blog.getId());
            System.out.println("修改："+result);
        } catch (SQLException e) {
            e.printStackTrace();
        }

    }

    public void delete(String id){
        Connection conn = null;
        try {
            conn = JdbcUtils.getDataSource().getConnection();

            conn.setAutoCommit(false);

            String sql = "delete from  entries where id=?";
            int result =  qr.update(conn,sql,id);
            System.out.println("删除："+result);

            sql = "delete from comment where entries_id=?";
            result = qr.update(conn,sql,id);
            System.out.println("根据博客id删除："+result);

            conn.commit();
        } catch (SQLException e) {
            e.printStackTrace();
            try {
                if(conn!=null){
                   conn.rollback();
                }
            } catch (SQLException e1) {
                e1.printStackTrace();
            }
        }
    }

    public Map<String,Object> findById(String id){

        String sql = "select *,(select uname from users where id=user_id) uname from entries where id=?";

        try {
            Map<String,Object> result =  qr.query(sql,new MapHandler(),id);
            System.out.println("根据id查询："+result);
            return result;
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return null;
    }

    public void getByPage(PageBean<Map<String,Object>> pb){

        String basesql = " select et.*,ut.uname from entries et INNER JOIN users ut on et.user_id=ut.id ";

        if(pb.getConditions()!=null){
            basesql+=pb.getConditions().toString();
        }

        PageUtils.getByPage(qr,pb,basesql);
    }


}
