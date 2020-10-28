package cn.euct.workbench.dao;

import cn.euct.settings.domain.User;
import cn.euct.workbench.domain.Activity;

import java.util.List;
import java.util.Map;

public interface ActivityDao {
     int saveUser(Activity activity);

    int getTotalByCondition(Map<String, Object> map);

    List<Activity> getActivityByCondition(Map<String, Object> map);

    int delectActivity(String[] ids);

    Activity getById(String id);

    int update(Activity activity);

    Activity detail(String id);
}
