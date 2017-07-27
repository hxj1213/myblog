package com.hxj.servlet;

import com.hxj.dao.UserDao;
import com.hxj.entity.User;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;

/**
 * Created by hxj on 17-7-24.
 */
public class UserServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        UserDao userDao = new UserDao();

        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");

        String what = request.getParameter("what");

        PrintWriter pw = response.getWriter();

        if("login".equals(what)){
            System.out.println("-------UserServlet-------login--------");
            String uname = request.getParameter("uname");
            String passw = request.getParameter("passw");

            User user = new User(uname,passw);

            String result = userDao.login(user);

            if("success".equals(result)){
                request.getSession().setAttribute("id",user.getId());
                request.getSession().setAttribute("username",uname);
            }

            pw.write(result);
            pw.close();

        }else if("logout".equals(what)){
            System.out.println("-------UserServlet-------logout--------");
            request.getSession().removeAttribute("id");
            request.getSession().removeAttribute("username");
        }
        else if("register".equals(what)){
            System.out.println("-------UserServlet-------register--------");

            String uname = request.getParameter("uname");
            String passw = request.getParameter("passw");

            System.out.println(uname+"    "+passw);

            User user = new User(uname,passw);
            String result = null;
            try {
                result = userDao.register(user);
                System.out.println(result);
            } catch (SQLException e) {
                e.printStackTrace();
                result = "error";
            }

            pw.write(result);
            pw.close();

        }

    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.sendRedirect(this.getServletContext().getContextPath()+"/login.jsp");
    }
}
