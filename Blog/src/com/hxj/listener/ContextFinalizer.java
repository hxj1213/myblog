package com.hxj.listener; /**
 * Created by hxj on 17-7-27.
 */

import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;
import javax.servlet.annotation.WebListener;
import javax.servlet.http.HttpSessionAttributeListener;
import javax.servlet.http.HttpSessionEvent;
import javax.servlet.http.HttpSessionListener;
import javax.servlet.http.HttpSessionBindingEvent;
import java.sql.Driver;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.Enumeration;

@WebListener()
public class ContextFinalizer implements ServletContextListener{

    public ContextFinalizer() {
    }

    public void contextInitialized(ServletContextEvent sce) {
    }

    public void contextDestroyed(ServletContextEvent sce) {
        Enumeration<Driver> drivers = DriverManager.getDrivers();
        Driver d = null;
        while (drivers.hasMoreElements()) {
            try {
                d = drivers.nextElement();
                DriverManager.deregisterDriver(d);
                //LOGGER.warn(String.format("Driver %s deregistered", d));
            }
            catch (SQLException ex) {
                //LOGGER.warn(String.format("Error deregistering driver %s", d), ex);
            }
        }
//        try {
//            AbandonedConnectionCleanupThread.shutdown();
//        }
//        catch (InterruptedException e) {
//           // logger.warn("SEVERE problem cleaning up: " + e.getMessage());
//            e.printStackTrace();
//        }
//    }
    }
}
