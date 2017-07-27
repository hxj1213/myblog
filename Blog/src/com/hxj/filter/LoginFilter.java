package com.hxj.filter;

import javax.servlet.*;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;

/**
 * Created by hxj on 17-7-25.
 */
public class LoginFilter implements Filter {
    public void destroy() {
    }

    public void doFilter(ServletRequest req, ServletResponse resp, FilterChain chain) throws ServletException, IOException {

        HttpServletRequest request = (HttpServletRequest)req;
        HttpServletResponse response = (HttpServletResponse)resp;

        String method = request.getMethod();
        String uri = request.getRequestURI();
        System.out.println("method:"+method+"   uri:"+uri);

        if(uri.contains("login.jsp")){
            chain.doFilter(req, resp);
        }else{

            Object id = request.getSession().getAttribute("id");
            System.out.println(id);
            if(id!=null && !"".equals(id)){
                System.out.println("------session is here and go------");
                chain.doFilter(req, resp);
            }else{
                if("GET".equalsIgnoreCase(method)){
                    response.sendRedirect(request.getServletContext().getContextPath()+"/login.jsp");
                }else{
                    PrintWriter pw = response.getWriter();
                    pw.write("nosession");
                    pw.close();
                }
            }
        }

    }

    public void init(FilterConfig config) throws ServletException {

    }

}
