<%--
  Created by IntelliJ IDEA.
  User: hxj
  Date: 17-7-24
  Time: 下午1:49
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" pageEncoding="UTF-8" contentType="text/html;UTF-8" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jstl/fmt" prefix="fmt"%>
<table cellspacing="0" cellpadding="5px">
  <tr><th>编号</th><th>标题</th><th>发布人</th><th>发布时间</th><th>删除</th></tr>
  <c:forEach items="${requestScope.pb.datas}" var="blog" varStatus="vs">
    <tr>
      <td>${vs.count}</td>
      <td class="viewDetail" lang="${blog.id}"><a href="javascript:;">${blog.title}</a></td>
      <td>${blog.uname}</td>
      <td>${blog.posted_on}</td>
      <td onclick="deleteBlog(${blog.id})">
        <c:if test="${sessionScope.id==blog.user_id}">
            <a href="javascript:;">删除</a>
        </c:if>
      </td>
    </tr>
  </c:forEach>
</table>
<div class="pageDiv">
    <div class="pageMessage">
        共 <span>${requestScope.pb.totalRows}</span> 条记录，当前显示第 <span id="pageNowSpan">${requestScope.pb.pageNow}</span> 页
    </div>
    <ul>
        <li onclick="getBlog(${requestScope.pb.pageNow-1})" class="pageItem ${requestScope.pb.pageNow==1?'current':''}"><a href="javascript:;">&lt;</a></li>
        <c:forEach begin="1" end="${requestScope.pb.totalPages}" var="pageNum">
            <li onclick="getBlog(${pageNum})" class="pageItem ${requestScope.pb.pageNow==pageNum?'current':''}"><a href="javascript:;">${pageNum}</a></li>
        </c:forEach>
        <li onclick="getBlog(${requestScope.pb.pageNow+1})" class="pageItem ${requestScope.pb.pageNow==requestScope.pb.totalPages?'current':''}"><a href="javascript:;">&gt;</a></li>
    </ul>
</div>
<script>

    $(".viewDetail").click(function () {
        var blog_id = $(this).attr('lang');
        window.location.href = "${pageContext.request.contextPath}/blogServlet?what=findById&blog_id="+blog_id;
        /*$.ajax({
            type:'POST',
            url:'{pageContext.request.contextPath}/blogServlet?what=findById',
            data:{blog_id:blog_id},
            success:function (resultData) {
                alert(resultData)
                console.log(resultData)
            }
        })*/
    })

    function getBlog(pageNum) {
        var pageNow = $("#pageNowSpan").html();
        if(pageNum==pageNow){
            return false
        }
        getBlogList(pageNum)
    }

</script>
