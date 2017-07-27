package com.hxj.entity;

/**
 * Created by hxj on 17-7-24.
 */
public class User {

    private int id;
    private String uname;
    private String passw;

    public User() {
    }

    public User(String uname, String passw) {
        this.uname = uname;
        this.passw = passw;
    }

    public User(int id,String uname, String passw) {
        this.id = id;
        this.uname = uname;
        this.passw = passw;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getId() {
        return id;
    }

    public String getUname() {
        return uname;
    }

    public String getPassw() {
        return passw;
    }

    public void setUname(String uname) {
        this.uname = uname;
    }

    public void setPassw(String passw) {
        this.passw = passw;
    }

    @Override
    public String toString() {
        return "User{" +
                "uname='" + uname + '\'' +
                ", passw='" + passw + '\'' +
                '}';
    }
}
