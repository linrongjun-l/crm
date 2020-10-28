package cn.euct.settings.service;

import cn.euct.exception.LoginException;
import cn.euct.settings.domain.User;



import java.util.List;

public interface UserService {
public List<User> findUser();
public User login(String loginAct, String loginPwd,String ip) throws LoginException;
}
