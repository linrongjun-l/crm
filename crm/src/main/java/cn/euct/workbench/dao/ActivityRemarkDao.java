package cn.euct.workbench.dao;

import cn.euct.workbench.domain.ActivityRemark;

import java.util.List;

public interface ActivityRemarkDao {


    int getCountRemark(String[] ids);

    int deleteRemart(String[] ids);

    List<ActivityRemark> getRemark(String activityId);

    int removeRemart(String remarkId);

    int saveRemark(ActivityRemark ar);

    int updateRemark(ActivityRemark ar);
}
