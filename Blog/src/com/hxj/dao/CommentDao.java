package com.hxj.dao;

import com.hxj.entity.Comment;
import com.hxj.page.PageBean;
import com.hxj.page.PageUtils;
import com.hxj.util.JdbcUtils;
import org.apache.commons.dbutils.QueryRunner;
import org.apache.commons.dbutils.handlers.MapHandler;
import org.apache.commons.dbutils.handlers.MapListHandler;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

/**
 * Created by hxj on 17-7-25.
 */
public class CommentDao {

    private QueryRunner qr = new QueryRunner(JdbcUtils.getDataSource());

    public void save(Comment comment){
        String sql = "insert into comment(entries_id,postuser_id,content,posted_on) values(?,?,?,?)";
        try {
            int i = qr.update(sql,comment.getEntried_id(),comment.getPostuser_id(),comment.getContent(),comment.getPosted_on());
            System.out.println("添加："+i);
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public void update(Comment comment){
        String sql = "update comment set entries_id=?,postuser_id=?,content=?,posted_on=? where id=?";
        try {
            int i = qr.update(sql,comment.getEntried_id(),comment.getPostuser_id(),comment.getContent(),comment.getPosted_on(),comment.getId());
            System.out.println("修改："+i);
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public void delete(String id){
        String sql = "delete from comment where id=?";
        try {
            int i = qr.update(sql,id);
            System.out.println("删除："+i);
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public void deleteByEntriesId(String entriesId){
        String sql = "delete from comment where entries_id=?";
        try {
            int i = qr.update(sql,entriesId);
            System.out.println("根据博客id删除："+i);
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public void findByEntriesId(PageBean<Map<String,Object>> pb,String entriesId){
        String basesql = "select basetb.*,users.uname from (select * from comment where entries_id="+entriesId+") basetb INNER JOIN users on basetb.postuser_id=users.id";
        if(pb.getConditions()!=null){
            basesql+=pb.getConditions().toString();
        }
        PageUtils.getByPage(qr,pb,basesql);
    }

}
