package cn.euct.workbench.controller;

import cn.euct.settings.domain.User;
import cn.euct.settings.service.UserService;
import cn.euct.utils.DateTimeUtil;
import cn.euct.utils.PrintJson;
import cn.euct.utils.UUIDUtil;
import cn.euct.vo.PagingVo;
import cn.euct.workbench.domain.Activity;
import cn.euct.workbench.service.ActivityService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
public class ActivatyControllor {
    @Autowired
    private UserService userService;

    @Autowired
    private ActivityService activityService;
    //市场活动创建模态创口中查询所有者
    @RequestMapping("/workbeanch/activity/getuserlist.do")
    @ResponseBody
    public List<User> getUserList(){
        List<User> user = userService.findUser();
        return user;
    }

    //市场活动添加操作
    @RequestMapping("/workbeanch/activity/saveuser.do")
    @ResponseBody
    public  void saveuser(Activity activity, HttpSession session, HttpServletRequest request, HttpServletResponse response){
        System.out.println("执行市场活动添加");
        //创建id
        String id= UUIDUtil.getUUID();
        //市场活动添加时间
        String createTime= DateTimeUtil.getSysTime();
        //市场活动添加人
        String createBy=((User)session.getAttribute("user")).getName();

        activity.setId(id);
        activity.setCreateTime(createTime);
        activity.setCreateBy(createBy);

        boolean fla = activityService.saveUser(activity);
        PrintJson.printJsonFlag(response,fla);
        System.out.println("endendend avtivity");

    }

    //市场活动获取活动记录和查询
    @RequestMapping("/workbeanch/activity/paginlist.do")
    @ResponseBody
    public PagingVo<Activity> paginList(
           Integer paginNo,
           Integer paginSize,
           String name,
           String owner,
           String startDate,
           String endDate,
           HttpServletRequest request,
           HttpServletResponse response){

        Integer skipNo=(paginNo-1)*paginSize;
        Map<String ,Object> map=new HashMap<>();
        map.put("name",name);
        map.put("owner",owner);
        map.put("startDate",startDate);
        map.put("endDate",endDate);
        map.put("paginSize",paginSize);
        map.put("skipNo",skipNo);

       PagingVo<Activity> vo = activityService.pageList(map);
        return vo;
    }
    //市场活动删除操作
    @RequestMapping("/workbeanch/activity/deleteactivity.do")
    @ResponseBody
    public void delectAciticity( HttpServletResponse response,HttpServletRequest request){

        String[] idss= request.getParameterValues("id");
       if (idss.length>0){
           for (int i = 0; i < idss.length; i++) {
               System.out.println("==============="+idss[i]);
           }
       }

        boolean flag=activityService.delectActivaty(idss);
        PrintJson.printJsonFlag(response,flag);
    }

    //修改模态窗口
    @RequestMapping("/workbeanch/activity/getUserlistAndActivity.do")
    @ResponseBody
    public Map<String,Object> getUserlistAndActivity(String id){
        System.out.println("///////////////////////////////////"+id);
        System.out.println("修改模态窗口");
        //取User表中的数据
        List<User> userList= userService.findUser();
        //获取一条Avicii记录
        Activity activity=activityService.getById(id);
        //前端需要Ulist 和 activity 所以需要打包
        Map<String,Object> map=new HashMap<String ,Object>();
        map.put("uList",userList);
        map.put("activaty",activity);
        return map;
    }

    //修改活动添加操作
    @RequestMapping("/workbeanch/activity/update.do")
    @ResponseBody
    public  void update(Activity activity, HttpSession session, HttpServletRequest request, HttpServletResponse response){
        System.out.println("执行市场活动修改");

        //市场活动修改时间
        String editTime= DateTimeUtil.getSysTime();
        //市场活动添加人
        String editBy=((User)session.getAttribute("user")).getName();

        activity.setEditTime(editTime);
        activity.setEndDate(editTime);

        boolean fla = activityService.update(activity);
        PrintJson.printJsonFlag(response,fla);
        System.out.println("endendend avtivity");

    }
}
