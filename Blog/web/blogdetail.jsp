<%--
  Created by IntelliJ IDEA.
  User: hxj
  Date: 17-7-24
  Time: 下午1:49
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" import="java.util.Date" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<html>
  <head>
    <title>主页面</title>
      <style>
          i{
              color:red;
          }
          img.deleteCommentBtn:active{
              box-shadow: 1px 1px 15px #cccccc;
          }
          img.commentPageBtn:active{
              opacity: 0.7;
          }
          img.current{
              opacity: 0.7;
          }
      </style>
    <script src="static/js/jquery.js"></script>
  </head>
  <body style="margin: 0px">

  <div id="fixContainer" style="z-index:1;background-color:#ccc;filter:alpha(opacity=70);opacity:0.7;position:absolute;top:0px;left:0px;display:none"></div>
  <div style="margin-left: 50px;margin-top: 20px">
      <div style="text-align: right;padding-right: 10px;position: absolute;left: 500px"><span id="goBlogList"><a href="javascript:;">返回列表页面</a></span>&nbsp;&nbsp;&nbsp;<span id="loginOut"><a href="javascript:;">退出</a></span></div>
      <div><h3 style="display: inline">标题：<span id="titleSpan">${requestScope.blog.title}</span></h3></div>
      <c:set var="userId" value="${requestScope.blog.user_id}" scope="page"></c:set>
      <p>发帖人：${requestScope.blog.uname}</p>
      <p>发帖时间：${requestScope.blog.posted_on}</p>
      <p>帖子内容：</p>
      <textarea id="blogContentArea" readonly style="width: 600px;border: solid 1px #cccccc;padding: 10px">${requestScope.blog.content}</textarea>

      <div>
          <h3>评论内容</h3>
          <div id="commentContatiner" style="width:600px;position:relative;margin-top: 10px"></div>
      </div>
      <div><h3>添加评论</h3></div>
      <div>
          <textarea id="commentContentArea" style="width: 400px;border: solid 1px #cccccc;padding: 10px"></textarea><i></i><br>
          <button id="addCommentBtn" lang="${sessionScope.id}" style="width: 80px;background: blue;color: white;font-weight: bold;border: solid 2px blue;padding-top: 5px;padding-bottom: 5px">发帖</button>
      </div>
  </div>
      <div class="tabInfo" id="loginPage" style="z-index:1;display:none;background:white;border: solid 1px #cccccc;box-shadow:1px 1px 15px #cccccc;width: 280px;padding:30px;position: absolute;top: 200px;left: 300px">
          <div style="color: brown;font-size: 12px;padding-bottom: 10px">您尚未登录，请先登录</div>
          <div><span>用户名</span><input type="text" name="uname"><i></i></div>
          <div><span>密&nbsp;&nbsp;码</span><input type="password" name="passw"><i></i></div>
          <div><input type="checkbox">&nbsp;保存用户名和密码</div>
          <div><input type="button" value="登录" id="loginSure"><input type="button" value="重置" id="loginReset"></div>
      </div>
  <script>

      /*
       *  请求评论内容
       */
      function getCommentList(pageNow) {

          $.ajax({
              type:'POST',
              url:'${pageContext.request.contextPath}/commentServlet',
              data:{what:'list',pageNow:pageNow,blogId:${requestScope.blog.id},userId:${requestScope.blog.user_id}},
              success:function(resultData) {
                  $("#commentContatiner").html(resultData);
              }
          });
      }

      getCommentList(1);

      /*
       *
       * login module
       *
       */
      $("input[name='uname']").focus(function () {
          $(this).next().html('')
      })
      $("input[type='password']").focus(function () {
          $(this).next().html('')
      })

      $("#loginSure").click(function () {

          var uname = $("#loginPage input[name='uname']").val().trim();
          var passw = $("#loginPage input[name='passw']").val().trim();

          if(uname==null || uname==""){
              $("#loginPage input[name='uname']").next().html('必填');
              return false
          }
          if(passw==null || passw==""){
              $("#loginPage input[name='passw']").next().html('必填');
              return false
          }
          $.ajax({
              type:'POST',
              url:'${pageContext.request.contextPath}/userServlet',
              data:{what:'login',uname:uname,passw:passw},
              success:function (resultData) {
                  if(resultData=="success"){

                      var userId = $("#addCommentBtn").attr('lang');
                      addComment(userId);

                  }else if(resultData=="passerror"){

                      $("#loginPage input[name='passw']").next().html('密码错误');

                  }else if(resultData=="usererror"){

                      $("#loginPage input[name='uname']").next().html('用户不存在');

                  }
              }
          })

      });

      function editTitle() {
          var title = $("#titleSpan").html();
          $("#titleSpan").replaceWith("<input id='titleInput' type='text' name='title' onblur='editTitle2()' value='"+title+"'>");
          $("#titleTip").html('填写新的标题')
      }

      function editTitle2() {
          var title = $("#titleInput").val();
          if(title==null || title==""){
              alert("必须填写新标题");
              return false
          }
          $("#titleInput").replaceWith("<span id='titleSpan' ondblclick='editTitle()'>"+title+"</span>");
          $("#titleTip").html('双击标题进行修改')
      }

      $("#titleSpan").dblclick(function () {
          if(${requestScope.blog.user_id==sessionScope.id}) {
              editTitle()
          }
      });

      function updateBlog() {
          console.log('--------updateBlog----come--in---------')
          var userId = $("#addCommentBtn").attr('lang');
          console.log("userId="+userId)
          if(userId==""){
              $("#fixContainer").css("width",document.body.clientWidth);
              $("#fixContainer").css("height",document.body.clientHeight);
              $("#fixContainer").css("display","block");
              $("#loginPage").css("display","block");
              return false
          }

          console.log('--------updateBlog----start-----------')

          var title = $("#titleSpan").html();
          if(title==null || title==""){
              title = $("#titleInput").val();
          }
          var content = $("#blogContentArea").val().trim();

          if(content==null || content==""){
              alert("内容不可为空")
              return false;
          }

          var user_id = ${requestScope.blog.user_id};
          var id = ${requestScope.blog.id};
          console.log(user_id)
          $.ajax({
              type:'POST',
              url:'${pageContext.request.contextPath}/blogServlet',
              data:{what:'update',id:id,user_id:user_id,content:content,title:title},
              success:function (resultData) {
                  console.log('updateBlog----resultData---'+resultData)
                  location.reload();
              }
          })
      }

      if(${requestScope.blog.user_id==sessionScope.id}){
          $("#blogContentArea").removeAttr('readonly');
          $("#blogContentArea").after("<br><button id='updateBtn' onclick='updateBlog()' style='width: 80px;background: blue;color: white;font-weight: bold;border: solid 2px blue;padding-top: 5px;padding-bottom: 5px'>确认修改</button>");
          $("#titleSpan").parent().after("<span style='font-size: 12px;color: #cccccc;margin-left: 10px' id='titleTip'>双击标题进行修改</span>")
      }

      $("#commentContentArea").focus(function () {
          $(this).next().html('')
      })

      function addComment(userId) {
          var content = $("#commentContentArea").val().trim();
          var entriesId = ${requestScope.blog.id};

          if(content==null || content==""){
              $("#commentContentArea").next().html('必填')
              return false
          }

          var params = "what=addComment&userId="+userId+"&content="+content+"&entriesId="+entriesId

          $.ajax({
              type:'POST',
              url:'${pageContext.request.contextPath}/blogServlet',
              data:params,
              success:function (resultdata) {
                  window.location.href = "${pageContext.request.contextPath}/blogServlet?what=findById&blog_id="+entriesId;
              }
          })
      }

      $("#addCommentBtn").click(function () {
          console.log('-------addComment-----comein-----------')
          var userId = $(this).attr('lang');
          if(userId==""){
              $("#fixContainer").css("width",document.body.clientWidth);
              $("#fixContainer").css("height",document.body.clientHeight);
              $("#fixContainer").css("display","block");
              $("#loginPage").css("display","block");
          }else{
              addComment(userId)
          }
      });
      
      function deleteComment(commentId) {
          $.ajax({
              type:'POST',
              url:'${pageContext.request.contextPath}/blogServlet',
              data:{what:'deleteComment',commentId:commentId},
              success:function (resultData) {
                  var entriesId = ${requestScope.blog.id};
                  window.location.href = "${pageContext.request.contextPath}/blogServlet?what=findById&blog_id="+entriesId;
              }
          })
      }

      /***********
       *
       * 返回列表页面
       *
       ************/
      $("#goBlogList").click(function () {
         window.location.href = "${pageContext.request.contextPath}/index.jsp";
      });

      /***********
       * 退出登录
       * ********/
      function logOut() {
          $.ajax({
              type:'POST',
              url:'${pageContext.request.contextPath}/userServlet',
              data:{what:'logout'},
              success:function (resultData) {
                  window.location.href = "${pageContext.request.contextPath}/login.jsp"
              }
          })
      }
      $("#loginOut").click(function () {
          logOut()
      })


  </script>
  </body>
</html>
