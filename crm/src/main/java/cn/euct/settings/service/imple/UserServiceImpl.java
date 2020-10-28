package cn.euct.settings.service.imple;

import cn.euct.exception.LoginException;
import cn.euct.settings.dao.UserDao;
import cn.euct.settings.domain.User;
import cn.euct.settings.service.UserService;
import cn.euct.utils.DateTimeUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class UserServiceImpl implements UserService {

    @Autowired
    private UserDao userDao;

    @Override
    public List<User> findUser() {

        return  userDao.getUser();
    }

    @Override
    public User login(String loginAct, String loginPwd,String ip) throws LoginException {

        User user = userDao.loginUse(loginAct, loginPwd);
        if (user==null){
            throw new LoginException("密码错误");
        }
        //如果程序能够成功执行到该行，说明账号密码正确
        //继续向下验证

        //验证失效时间
        String expireTime=user.getExpireTime();
        String currentTime= DateTimeUtil.getSysTime();
        if (expireTime.compareTo(currentTime)<0){
            throw  new LoginException("账号已失效");
        }

        //判断锁定状态
        String lockState=user.getLockState();
        if ("0".equals(lockState)){
            throw new LoginException("账号已锁");
        }

        //判断ip地址
        String allowIps=user.getAllowIps();
        if (!allowIps.contains(ip)){
            throw new LoginException("ip地址受限");
        }
        return user;
    }
}
