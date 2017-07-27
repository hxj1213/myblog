package com.hxj.entity;

import java.util.Date;

/**
 * Created by hxj on 17-7-25.
 */
public class Comment {

    private int id;
    private int entried_id;
    private int postuser_id;
    private String content;
    private Date posted_on;

    public Comment() {
    }

    public Comment(int entried_id, int postuser_id,String content,Date posted_on) {
        this.entried_id = entried_id;
        this.postuser_id = postuser_id;
        this.content = content;
        this.posted_on = posted_on;
    }

    public Comment(int id, int entried_id, int postuser_id,String content,Date posted_on) {
        this.id = id;
        this.entried_id = entried_id;
        this.postuser_id = postuser_id;
        this.content = content;
        this.posted_on = posted_on;
    }

    public int getId() {
        return id;
    }

    public int getEntried_id() {
        return entried_id;
    }

    public int getPostuser_id() {
        return postuser_id;
    }

    public Date getPosted_on() {
        return posted_on;
    }

    public void setId(int id) {
        this.id = id;
    }

    public void setEntried_id(int entried_id) {
        this.entried_id = entried_id;
    }

    public void setPostuser_id(int postuser_id) {
        this.postuser_id = postuser_id;
    }

    public void setPosted_on(Date posted_on) {
        this.posted_on = posted_on;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    @Override
    public String toString() {
        return "Comment{" +
                "id=" + id +
                ", entried_id=" + entried_id +
                ", postuser_id=" + postuser_id +
                ", posted_on=" + posted_on +
                '}';
    }
}
