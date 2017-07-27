package com.hxj.dao;

import org.junit.Test;
import com.hxj.entity.User;

/**
 * Created by hxj on 17-7-24.
 */
public class UserDaoTest {
    @Test
    public void login() throws Exception {
        User user = new User("admin","admin123");
        UserDao userDao = new UserDao();
        String result = userDao.login(user);
        System.out.println("登录结果:"+result);
    }

}