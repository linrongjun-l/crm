package cn.euct.interceptor;

import cn.euct.settings.domain.User;
import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class LoginInterceptor implements HandlerInterceptor {
    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
        System.out.println("------------------拦截器开始");
        String url = request.getRequestURI();
        System.out.println("----------------ip"+url);
        if (url.indexOf("/login.jsp")>0||url.indexOf("/login.do")>0){
            return true;
        }
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");
        if (user!=null){
            System.out.println("-----not null -----");
            return  true;
        }
       /* request.setAttribute("msg","没有登录");*/
        System.out.println("mmmmmmmmmmm");
        response.sendRedirect("/crm/login.jsp");
        return false;
    }

    @Override
    public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler, ModelAndView modelAndView) throws Exception {

    }

    @Override
    public void afterCompletion(HttpServletRequest request, HttpServletResponse response, Object handler, Exception ex) throws Exception {

    }
}
