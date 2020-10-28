package cn.euct.settings.dao;

import cn.euct.settings.domain.User;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface UserDao {
    public User loginUse(@Param("loginAct")String loginAct, @Param("loginPwd") String loginPwd);

    public List<User> getUser();
}
