package com.hxj.entity;

import java.util.Date;

/**
 * Created by hxj on 17-7-21.
 */
public class Blog {
    private int id;
    private String title;
    private String content;
    private Date posted_on;
    private int user_id;

    public Blog() {
    }

    public Blog(String title, String content,Date posted_on,int user_id) {
        this.title = title;
        this.content = content;
        this.posted_on = posted_on;
        this.user_id = user_id;
    }

    public Blog(int id, String title, String content, Date posted_on,int user_id) {
        this.id = id;
        this.title = title;
        this.content = content;
        this.posted_on = posted_on;
        this.user_id = user_id;
    }

    public int getId() {
        return id;
    }

    public String getTitle() {
        return title;
    }

    public String getContent() {
        return content;
    }

    public Date getPosted_on() {
        return posted_on;
    }

    public void setId(int id) {
        this.id = id;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public void setPosted_on(Date posted_on) {
        this.posted_on = posted_on;
    }

    public int getUser_id() {
        return user_id;
    }

    public void setUser_id(int user_id) {
        this.user_id = user_id;
    }

    @Override
    public String toString() {
        return "Blog{" +
                "id=" + id +
                ", title='" + title + '\'' +
                ", content='" + content + '\'' +
                ", posted_on=" + posted_on +
                '}';
    }
}
