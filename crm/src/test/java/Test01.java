import cn.euct.settings.domain.User;
import cn.euct.settings.service.UserService;
import cn.euct.settings.service.imple.UserServiceImpl;
import cn.euct.vo.PagingVo;
import cn.euct.workbench.dao.ActivityDao;
import cn.euct.workbench.domain.Activity;
import cn.euct.workbench.service.ActivityService;
import org.junit.Test;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class Test01 {
    @Test
    public void test01(){
        ApplicationContext applicationContext=new ClassPathXmlApplicationContext("applicationContext.xml");
        UserService dao= (UserService) applicationContext.getBean("userServiceImpl");
        List<User> user = dao.findUser();
        for (User s:user){
            System.out.println(s.getName()+"----"+s.getId());
        }
    }


    @Test
    public void test02(){
        ApplicationContext applicationContext=new ClassPathXmlApplicationContext("applicationContext.xml");
        /*ActivityService dao= (ActivityService) applicationContext.getBean("cn.euct.workbench.dao.ActivityDao");*/
       ActivityDao dao= (ActivityDao) applicationContext.getBean("activityDao");


        Map<String ,Object> map=new HashMap<>();
        map.put("name","");
        map.put("owner","");
        map.put("startDate","");
        map.put("endDate","");
        map.put("paginSize",2);
        map.put("skipNo",0);
       /* PagingVo<Activity> activityPagingVo = dao.pageList(map);
        List<Activity> dataList = activityPagingVo.getDataList();
        for (Activity s:dataList){
            System.out.println("----------"+s);
        }

        System.out.println(activityPagingVo.getTotal()+"==============");*/
/*
        List<Activity> activityByCondition = dao.getActivityByCondition(map);
        for (Activity s:activityByCondition){
            System.out.println("----------"+s);
        }*/

        int totalByCondition = dao.getTotalByCondition(map);
        System.out.println(totalByCondition);
    }

    @Test
    public void test03(){
        ApplicationContext applicationContext=new ClassPathXmlApplicationContext("applicationContext.xml");
        /*ActivityService dao= (ActivityService) applicationContext.getBean("cn.euct.workbench.dao.ActivityDao");*/
        ActivityDao dao= (ActivityDao) applicationContext.getBean("activityDao");


        Map<String ,Object> map=new HashMap<>();
        map.put("name","跳舞");
        map.put("owner","");
        map.put("startDate","");
        map.put("endDate","");
        map.put("paginSize",2);
        map.put("skipNo",0);

        List<Activity> activityByCondition = dao.getActivityByCondition(map);
        for (Activity s:activityByCondition){
            System.out.println("----------"+s.getName());
        }


    }
}
