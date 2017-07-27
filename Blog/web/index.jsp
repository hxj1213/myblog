<%--
  Created by IntelliJ IDEA.
  User: hxj
  Date: 17-7-24
  Time: 下午1:49
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" import="java.util.Date" %>
<html>
  <head>
    <title>主页面</title>
    <style>

        /**********预设样式*********/

        #newblogPage{
            display: none;
        }
        i{
            color: red;
            margin-left: 5px;
        }

        #blogContainer{
            width: 800px;
        }

        /**********表格样式*********/

        table{
            width: 800px;
        }
        table,table td,table th{
            border: solid 1px #cccccc;
        }


        /**********分页样式*********/
        div.pageDiv{
            position:relative;margin-top:10px;padding:0 12px;
        }
        div.pageMessage{
            position:absolute;left:250px;top:25px;
            color: darkgrey;
        }
        div.pageMessage span{
            color: blue;
            font-weight: bold;
            font-size: 14px;
        }
        div.pageDiv ul{
            list-style-type: none;
            position:absolute;right:12px;top:0;
        }
        div.pageDiv li.pageItem{
            float: left;
            width: 30px;
            height: 30px;
            border: solid 1px #cccccc;
            text-align: center;
            line-height: 30px;
            border-radius: 5px 5px;
        }

        div.pageDiv li.current{
            background: ghostwhite;
        }

        div.pageDiv li.pageItem a{
            display: block;
            text-decoration: none;
            outline: none;
            color: blue;
            font-weight: bold;
            font-size: 14px;
        }

        div.pageDiv li.current a{
            color: #cccccc;
        }

        div.pageDiv li.pageItem a:active{
            color: #cccccc;
        }

        .newBlogToggle{
            clear: both;
            margin-top: 30px;
        }

    </style>
    <script src="static/js/jquery.js"></script>
  </head>
  <body>
    <div>欢迎你:${sessionScope.username}&nbsp;&nbsp;当前时间为:<span id="curr_time"></span>&nbsp;&nbsp;<span id="loginOut"><a href="javascript:;">退出</a></span></div>
    <h2><a>Home</a></h2>

    <div id="blogContainer"></div>

    <h2 onclick="newblogPageToggle()" class="newBlogToggle"><a href="javascript:;">New Blog</a></h2>

    <!-- 新建博客 -->
    <div id="newblogPage">
        <form id="addBlogForm">
            <input type="hidden" value="${sessionScope.id}" name="userId">
            <label>标题</label><br><input type="text" name="title"><i></i><br>
            <label>内容</label><br><textarea name="content"></textarea><i></i><br>
            <input type="button" value="提交" id="addBlogBtn">
        </form>
    </div>

  <script>

      function setCurtime() {
          var date = new Date();
          var dateStr = date.getFullYear()+"-"+(date.getMonth()+1)+"-"+date.getDate()+" "+date.getHours()+":"+date.getMinutes()+":"+date.getSeconds()
          $("#curr_time").html(dateStr)
      }

      function newblogPageToggle() {
          $("#newblogPage").toggle();
      }

      function getBlogList(pageNum) {
          $.ajax({
              type:'GET',
              url:'${pageContext.request.contextPath}/blogServlet',
              data:{what:'list',pageNum:pageNum},
              success:function(resultData){
                  $("#blogContainer").html(resultData)
              }
          });
      }

      /*******删除模块********/
      function deleteBlog(blogId) {
        $.ajax({
            type:'POST',
            url:'${pageContext.request.contextPath}/blogServlet',
            data:{what:'delete',blogId:blogId},
            success:function (resultData) {
                getBlogList(1)
            }
        })
      }

      $("body").ready(function () {

          getBlogList(1)

          setCurtime();
          setInterval(function(){setCurtime()},1000);

          /*
           * add Blog module
           */

          $("#addBlogForm input[name='title']").focus(function () {
              $(this).next().html('')
          })

          $("#addBlogForm textarea[name='content']").focus(function () {
              $(this).next().html('')
          })

          $("#addBlogBtn").click(function () {

              console.log('--------addBlog-----start------')

              var userId = $("#addBlogForm input[name='userId']").val();

              if(userId==""){
                  alert("请先登录")
                  return false
              }

              var title = $("#addBlogForm input[name='title']").val();
              var content = $("#addBlogForm textarea[name='content']").val();

              if(title==null || title==""){
                  $("#addBlogForm input[name='title']").next().html('必填')
                  return false
              }

              if(content==null || content==""){
                  $("#addBlogForm textarea[name='content']").next().html('必填');
                  return false
              }

              console.log('--------addBlog-----request------')
              $.ajax({
                  type:'POST',
                  url:"${pageContext.request.contextPath}/blogServlet?what=add",
                  data:{title:title,content:content},
                  success:function (resultData) {
                      alert(resultData)
                      if("nosession"==resultData){
                          window.location.href = "${pageContext.request.contextPath}/login.jsp";
                          return;
                      }
                      $("#addBlogForm input[name='title']").val('');
                      $("#addBlogForm textarea[name='content']").val('');
                      $("#newblogPage").css("display","none");
                      getBlogList(1)
                  }

              })
          })

      })

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
