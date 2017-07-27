package com.hxj.dao;

import com.hxj.entity.User;
import com.hxj.util.JdbcUtils;
import org.apache.commons.dbutils.QueryRunner;
import org.apache.commons.dbutils.handlers.ArrayHandler;
import org.apache.commons.dbutils.handlers.ArrayListHandler;
import org.apache.commons.dbutils.handlers.ScalarHandler;

import java.sql.SQLException;
import java.util.Arrays;

/**
 * Created by hxj on 17-7-24.
 */
public class UserDao {

    private QueryRunner qr = new QueryRunner(JdbcUtils.getDataSource());

    public String login(User user){
        String sql = "select id,passw from users where uname=?";

        try {
           Object[] results =  qr.query(sql,new ArrayHandler(),user.getUname());
           System.out.println("---login---"+Arrays.toString(results));

           if(results!=null && results.length>0){
               String password = results[1].toString();
               System.out.println("password:"+password+"    "+(user.getPassw().equals(password)));
               if(user.getPassw().equals(password)){
                   System.out.println("成功");
                   user.setId(Integer.parseInt(results[0].toString()));
                   return "success";
               }else{
                    return "passerror";
               }
           }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return "usererror";

    }

    public String register(User user) throws SQLException{
        System.out.println("------UserDao---register----"+user.getUname());
        String sql = "select passw from users where uname=?";
        String idL =  qr.query(sql,new ScalarHandler<>(),user.getUname());
        System.out.println(idL);
        if(idL!=null){
            System.out.println("用户名重复");
            return "repeat";
        }
        sql = "insert into users(uname,passw) values(?,?)";
        int i = qr.update(sql,user.getUname(),user.getPassw());
        System.out.println("注册"+i);
        return "success";
    }

}
