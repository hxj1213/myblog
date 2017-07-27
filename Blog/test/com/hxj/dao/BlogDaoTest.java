package com.hxj.dao;

import com.hxj.entity.Blog;
import com.hxj.page.PageBean;
import org.json.JSONObject;
import org.junit.Test;

import java.util.Date;
import java.util.Map;

import static org.junit.Assert.*;

/**
 * Created by hxj on 17-7-24.
 */
public class BlogDaoTest {

    BlogDao blogDao = new BlogDao();

    @Test
    public void save() throws Exception {
        Blog blog = new Blog("java学习心得","收获很大，非常开心",new Date(),1);
        blogDao.save(blog);
        blog = new Blog("python学习心得","python小巧且功能强大",new Date(),1);
        blogDao.save(blog);
    }

    @Test
    public void update() throws Exception {
    }

    @Test
    public void delete() throws Exception {
    }

    @Test
    public void findById() throws Exception {
        Map<String,Object> map = blogDao.findById("1");
        System.out.println(map);

        JSONObject jsonObject = new JSONObject(map);

        System.out.println(jsonObject);
    }

    @Test
    public void getByPage() throws Exception {

//        PageBean<Blog> pb = new PageBean<Blog>();
//        blogDao.getByPage(pb);
//        System.out.println(pb);

        PageBean<Map<String,Object>> pb = new PageBean<>();
        blogDao.getByPage(pb);
        System.out.println(pb);
        System.out.println(pb.getDatas());
    }

    @Test
    public void getByPage1() throws Exception {
        CommentDao commentDao = new CommentDao();
        PageBean<Map<String,Object>> pb = new PageBean<>();
        commentDao.findByEntriesId(pb,"1");
        System.out.println(pb);
        System.out.println(pb.getDatas());
    }

}