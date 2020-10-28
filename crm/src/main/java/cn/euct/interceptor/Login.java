package cn.euct.interceptor;

import cn.euct.settings.domain.User;

import javax.servlet.*;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

public class Login implements Filter {


    @Override
    public void init(FilterConfig filterConfig) throws ServletException {

    }

    @Override
    public void doFilter(ServletRequest servletRequest, ServletResponse servletResponse, FilterChain filterChain) throws IOException, ServletException {
        System.out.println("过滤");


        HttpServletRequest request= (HttpServletRequest) servletRequest;
        HttpServletResponse response= (HttpServletResponse) servletResponse;

        String path=request.getRequestURI();

        System.out.println(path);

        if (path.indexOf("/login.jsp")>=0||path.indexOf("/settings/use/login.do")>=0){
            System.out.println("====放行====");

            filterChain.doFilter(servletRequest,servletResponse);
        }else {
            HttpSession session = request.getSession();
            User user = (User) session.getAttribute("user");
            if (user !=null){
                System.out.println(user+"123456");
                System.out.println("++++not null++++++");

                filterChain.doFilter(servletRequest,servletResponse);
            }else {
                System.out.println("**************"+request.getContextPath());
                /*request.getRequestDispatcher("/login.jsp").forward(request,response);*/
                response.sendRedirect("/crm/login.jsp");
            }
        }



    }

    @Override
    public void destroy() {

    }


}
