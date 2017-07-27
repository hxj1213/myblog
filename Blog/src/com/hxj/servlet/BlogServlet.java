package com.hxj.servlet;

import com.hxj.dao.BlogDao;
import com.hxj.dao.CommentDao;
import com.hxj.entity.Blog;
import com.hxj.entity.Comment;
import com.hxj.page.PageBean;
import org.json.JSONObject;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.Date;
import java.util.Map;

/**
 * Created by hxj on 17-7-24.
 */
public class BlogServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        BlogDao blogDao = new BlogDao();
        CommentDao commentDao = new CommentDao();

        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");
        PrintWriter pw = response.getWriter();

        String what = request.getParameter("what");
        if("add".equals(what)){

           String title = request.getParameter("title");
           String content = request.getParameter("content");
           String id = request.getSession().getAttribute("id").toString();
           System.out.println(title+"   "+content);
           blogDao.save(new Blog(title,content,new Date(),Integer.parseInt(id)));

        }else if("update".equals(what)){

            String id = request.getParameter("id");
            String title = request.getParameter("title");
            String content = request.getParameter("content");
            String user_id = request.getSession().getAttribute("id").toString();
            System.out.println(title+"   "+content);
            blogDao.update(new Blog(Integer.parseInt(id),title,content,new Date(),Integer.parseInt(user_id)));

        } else if("delete".equals(what)){

           String blogId = request.getParameter("blogId");
           System.out.println("您要删除"+blogId);
           blogDao.delete(blogId);

        }else if("list".equals(what)){
            System.out.println("-------BlogServlet--------list---------------");
            PageBean<Map<String,Object>> pb = new PageBean<>();

            String pageNum = request.getParameter("pageNum");
            pb.setPageNow(Integer.parseInt(pageNum));

            blogDao.getByPage(pb);
            request.setAttribute("pb",pb);
            request.getRequestDispatcher("/bloglist.jsp").forward(request,response);

        }else if("findById".equals(what)){

            String blogId = request.getParameter("blog_id");
            Map<String,Object> blog = blogDao.findById(blogId);
            request.setAttribute("blog",blog);

            request.getRequestDispatcher("/blogdetail.jsp").forward(request,response);

        }else if("addComment".equals(what)){

            String userId = request.getParameter("userId");
            String content = request.getParameter("content");
            String entriesId = request.getParameter("entriesId");

            Comment comment = new Comment(Integer.parseInt(entriesId),Integer.parseInt(userId),content,new Date());
            commentDao.save(comment);

        }else if("deleteComment".equals(what)){

            String commentId = request.getParameter("commentId");
            System.out.println("您要删除"+commentId);
            commentDao.delete(commentId);

        }
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doPost(request,response);
    }
}
