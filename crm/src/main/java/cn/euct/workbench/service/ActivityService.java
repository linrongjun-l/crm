package cn.euct.workbench.service;


import cn.euct.vo.PagingVo;
import cn.euct.workbench.domain.Activity;
import cn.euct.workbench.domain.ActivityRemark;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Map;

@Service
public interface ActivityService {
     boolean saveUser(Activity activity);

    PagingVo<Activity> pageList(Map<String, Object> map);

    boolean delectActivaty(String[] ids);

    Activity getById(String id);

    boolean update(Activity activity);

    Activity detail(String id);

   List<ActivityRemark> getRemark(String activityId);

    boolean delectRemark(String remarkId);

    boolean saveRemark(ActivityRemark ar);

    boolean updateRemark(ActivityRemark ar);
}
