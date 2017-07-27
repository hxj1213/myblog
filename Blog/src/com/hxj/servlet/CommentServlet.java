package com.hxj.servlet;

import com.hxj.dao.BlogDao;
import com.hxj.dao.CommentDao;
import com.hxj.page.PageBean;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.Map;

/**
 * Created by hxj on 17-7-25.
 */
public class CommentServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        BlogDao blogDao = new BlogDao();
        CommentDao commentDao = new CommentDao();

        String what = request.getParameter("what");

        if("list".equals(what)){

            System.out.println("-----CommentServlet------list--------");

            String blogId = request.getParameter("blogId");
            String pageNow = request.getParameter("pageNow");
            String userId = request.getParameter("userId");
            System.out.println(blogId+"      "+pageNow);
            PageBean<Map<String,Object>> pb = new PageBean<>();
            if(pageNow!=null || !"".equals(pageNow)){
                pb.setPageNow(Integer.parseInt(pageNow));
            }
            pb.setPageCount(2);
            commentDao.findByEntriesId(pb,blogId);
            request.setAttribute("pb",pb);
            request.setAttribute("userId",userId);
            System.out.println(pb);

            request.getRequestDispatcher("/commentlist.jsp").forward(request,response);
        }

    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doPost(request,response);
    }
}
