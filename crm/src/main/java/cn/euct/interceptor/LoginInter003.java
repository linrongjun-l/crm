package cn.euct.interceptor;


import cn.euct.settings.domain.User;

import javax.servlet.*;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

public class LoginInter003 implements Filter {
    @Override
    public void init(FilterConfig filterConfig) throws ServletException {

    }

    @Override
    public void doFilter(ServletRequest servletRequest, ServletResponse servletResponse, FilterChain filterChain) throws IOException, ServletException {
        HttpServletResponse response= (HttpServletResponse) servletResponse;
        HttpServletRequest request= (HttpServletRequest) servletRequest;

        String path=request.getRequestURI();
        if (path.indexOf("login.jsp")>=0 || path.indexOf("/settings/use/login.do")>=0){
            filterChain.doFilter(request,response);
        }

        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");
        if (user!=null){
            filterChain.doFilter(servletRequest,servletResponse);
        }else {
            response.sendRedirect(request.getContextPath()+"/login.jsp");
        }
    }

    @Override
    public void destroy() {

    }
}
