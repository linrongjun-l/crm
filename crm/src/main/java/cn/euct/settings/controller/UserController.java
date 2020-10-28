package cn.euct.settings.controller;

import cn.euct.settings.domain.User;
import cn.euct.settings.service.UserService;
import cn.euct.utils.MD5Util;
import cn.euct.utils.PrintJson;
import org.apache.ibatis.annotations.Param;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpRequest;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
public class UserController {

    @Autowired
    private UserService userService;

    @RequestMapping("/settings/use/login.do")
    @ResponseBody
    public  void login(String loginAct, String loginPwd, HttpSession session, HttpServletRequest request, HttpServletResponse response){
        System.out.println("userController");
        //将密码装换成MD5格式
        loginPwd= MD5Util.getMD5(loginPwd);
        //接收ip地址
        String ip=request.getRemoteAddr();
//        System.out.println("----------ip---"+ip);



        try {

            User user = userService.login(loginAct, loginPwd, ip);
            session.setAttribute("user",user);

            PrintJson.printJsonFlag(response,true);
        }catch (Exception e){

            e.printStackTrace();
            //throw e.getCause();
            String msg=e.getMessage();
            Map<String,Object> map =new HashMap<>();
            map.put("success",false);
            map.put("msg",msg);
            PrintJson.printJsonObj(response,map);
        }
    }

}
