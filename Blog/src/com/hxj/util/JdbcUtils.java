package com.hxj.util;

import com.mchange.v2.c3p0.ComboPooledDataSource;

import javax.sql.DataSource;

/**
 * Created by hxj on 17-7-24.
 */
public class JdbcUtils {

   private static final DataSource dataSource = new ComboPooledDataSource();

   public static DataSource getDataSource(){
       return dataSource;
   }

}
