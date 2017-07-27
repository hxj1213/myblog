<%--
  Created by IntelliJ IDEA.
  User: hxj
  Date: 17-7-26
  Time: 下午2:03
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<ul style="width:550px;list-style-type: none;font-size: 14px;color:darkgrey">
    <c:forEach items="${requestScope.pb.datas}" var="comment">
        <li style="width: 550px;">
            <div style="border: solid 1px #cccccc;width:500px;padding-left: 10px">
                <c:if test="${requestScope.userId==sessionScope.id || comment.postuser_id==sessionScope.id}">
                    <img src="static/images/delete.png" align="right" onclick="deleteComment(${comment.id})">
                </c:if>
                <p>评论人:${comment.uname}&nbsp;&nbsp;&nbsp;&nbsp;评论时间:${comment.posted_on}</p>
                <p>评论内容:${comment.content}</p>
            </div>
        </li>
    </c:forEach>
</ul>
<c:if test="${requestScope.pb.totalPages>1}">
<div style="position: absolute;top:50px;right: 0px">
    <ul style="list-style-type: none">
        <li><a href="javascript:;" style="outline: none"><img class="commentPageBtn ${requestScope.pb.pageNow==1?'current':''}" onclick="getComment(${requestScope.pb.pageNow-1})" src="static/images/up.png"></a></li>
        <li><a href="javascript:;" style="outline: none"><img class="commentPageBtn ${requestScope.pb.pageNow==requestScope.pb.totalPages?'current':''}" onclick="getComment(${requestScope.pb.pageNow+1})" src="static/images/down.png"></a></li>
    </ul>
</div>
</c:if>
<script>

    function getComment(pageNow) {
        if(pageNow<1 || pageNow>${requestScope.pb.totalPages}){
            return false;
        }
        getCommentList(pageNow)
    }

</script>
