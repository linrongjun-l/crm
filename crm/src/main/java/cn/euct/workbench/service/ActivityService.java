package cn.euct.workbench.service;


import cn.euct.vo.PagingVo;
import cn.euct.workbench.domain.Activity;
import org.springframework.stereotype.Service;

import java.util.Map;

@Service
public interface ActivityService {
     boolean saveUser(Activity activity);

    PagingVo<Activity> pageList(Map<String, Object> map);

    boolean delectActivaty(String[] ids);

    Activity getById(String id);

    boolean update(Activity activity);
}
