package cn.euct.workbench.service.impl;

import cn.euct.vo.PagingVo;
import cn.euct.workbench.dao.ActivityDao;
import cn.euct.workbench.dao.ActivityRemarkDao;
import cn.euct.workbench.domain.Activity;
import cn.euct.workbench.service.ActivityService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Map;

@Service
public class ActivityServiceImpl implements ActivityService {

    @Autowired
    private ActivityDao activityDao;

    @Autowired
    private ActivityRemarkDao activityRemarkDao;

    @Override
    public boolean saveUser(Activity activity) {
        int count = activityDao.saveUser(activity);
        boolean fla=true;
        if (count!=1){
            fla=false;
        }
        return fla;
    }

    @Override
    public PagingVo<Activity> pageList(Map<String, Object> map) {
        int total=activityDao.getTotalByCondition(map);
        List<Activity> list=activityDao.getActivityByCondition(map);
        PagingVo<Activity> vo=new PagingVo<>();
        vo.setTotal(total);
        vo.setDataList(list);
        return vo;
    }

    @Override
    public boolean delectActivaty(String[] ids) {
        boolean flag=true;
        //查询出需要删除的条数
        int count1=activityRemarkDao.getCountRemark(ids);
        //删除备注返回受到影响的条数（实际删除的条数）
        int count2=activityRemarkDao.deleteRemart(ids);
        if (count1!=count2){
            flag=false;
        }
        //删除市场活动
        int count3=activityDao.delectActivity(ids);
        return flag;
    }

    @Override
    public Activity getById(String id) {

        return activityDao.getById(id);
    }

    @Override
    public boolean update(Activity activity) {
        int count = activityDao.update(activity);
        boolean fla=true;
        if (count!=1){
            fla=false;
        }
        return fla;
    }
}
