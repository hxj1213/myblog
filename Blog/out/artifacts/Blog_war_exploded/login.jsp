<%--
  Created by IntelliJ IDEA.
  User: hxj
  Date: 17-7-24
  Time: 下午1:49
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
  <head>
    <title>登录页面</title>
    <style>

      body{
        margin: 0;
      }

      #container{
        width: 400px;
        height: 300px;
        background:aliceblue;
        box-shadow: 1px 1px 15px #ccc;
      }

      .tabTop{
          background: paleturquoise;
          height: 50px;
      }

      .tabTop div{
          width: 200px;
          float: left;
          text-align:center;
          line-height: 50px;
          color: cornflowerblue;
          font-weight: bold;
          font-size: 18px;
      }

      .tabTop .active{
          background: deepskyblue;
          color: white;
      }

      .tabInfo{
          padding-top: 45px;
          padding-left: 80px;
          color:cornflowerblue;
      }

      .tabInfo div{
          margin-top: 5px;
      }

      .tabInfo input[name]{
          width: 168px;
          height: 38px;
          border:solid 1px #cccccc;
          margin-left: 10px;
          padding-left: 5px;
          color: #cccccc;
          font-size: 16px;
      }
      .tabInfo input[type='button']{
          width: 100px;
          height: 30px;
          border:solid 1px royalblue;
          color: #ffffff;
          font-size: 16px;
          background: royalblue;
          margin-top: 10px;
          margin-right: 40px;
      }

      #registerPage{
          display: none;
      }

      i{
          color: red;
          padding-left: 10px;
      }

    </style>
    <script src="static/js/jquery.js"></script>
  </head>
  <body>
    <div id="container">
        <div class="tabTop"><div class="active" id="loginActive">用户登录</div><div id="registerActive">用户注册</div></div>
        <div class="tabInfo" id="loginPage">
            <div><span>用户名</span><input type="text" name="uname"><i></i></div>
            <div><span>密&nbsp;&nbsp;码</span><input type="password" name="passw"><i></i></div>
            <div><input type="checkbox">&nbsp;保存用户名和密码</div>
            <div><input type="button" value="登录" id="loginSure"><input type="button" value="重置" id="loginReset"></div>
        </div>
        <div class="tabInfo" id="registerPage">
            <div><span>用&nbsp;户&nbsp;名</span><input type="text" name="uname"><i></i></div>
            <div><span>密&nbsp;&nbsp;&nbsp;&nbsp;码</span><input type="password" name="passw"><i></i></div>
            <div><span>确认密码</span><input type="password" name="repassw"><i></i></div>
            <div><input type="button" value="注册" id="registerSure"><input type="button" value="重置" id="registerReset"></div>
        </div>
    </div>

  <script type="text/javascript">

      $("body").ready(function () {
          var width = document.body.clientWidth ;
          var height = document.body.clientHeight;
          var cw = $("#container").css("width");
          var cwight = cw.substring(0,cw.length-2);
          var ch = $("#container").css("height");
          var cheight = ch.substring(0,ch.length-2);

          $("#container").css("margin-top",(height-cheight)/2);
          $("#container").css("margin-left",(width-cwight)/2);

          function registerActive() {
              $("#loginPage").css("display","none");
              $("#registerPage").css("display","block");
              $("#loginActive").removeAttr("class");
              $("#registerActive").attr("class","active");
          }

          $("#registerActive").click(function () {
              registerActive()
          });

          function loginActive() {
              $("#registerPage").css("display","none");
              $("#loginPage").css("display","block");
              $("#registerActive").removeAttr("class");
              $("#loginActive").attr("class","active");
          }

          $("#loginActive").click(function () {
              loginActive();
          });

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
              alert(uname+"----------"+passw);
              $.ajax({
                  type:'POST',
                  url:'${pageContext.request.contextPath}/userServlet',
                  data:{what:'login',uname:uname,passw:passw},
                  success:function (resultData) {
                      if(resultData=="success"){

                          window.location.href = "${pageContext.request.contextPath}/index.jsp";

                      }else if(resultData=="passerror"){

                          $("#loginPage input[name='passw']").next().html('密码错误');

                      }else if(resultData=="usererror"){

                          $("#loginPage input[name='uname']").next().html('用户不存在');

                      }
                  }
              })

          })

          /*
          *
          * register module
          *
          */
          $("#registerSure").click(function () {

              var uname = $("#registerPage input[name='uname']").val().trim();
              var passw = $("#registerPage input[name='passw']").val().trim();
              var repassw = $("#registerPage input[name='repassw']").val().trim();

              if(uname==null || uname==""){
                  $("#registerPage input[name='uname']").next().html('必填');
                  return false
              }
              if(passw==null || passw==""){
                  $("#registerPage input[name='passw']").next().html('必填');
                  return false
              }
              if(repassw==null || repassw==""){
                  $("#registerPage input[name='repassw']").next().html('必填');
                  return false
              }

              if(passw!=repassw){
                  $("#registerPage input[name='repassw']").next().html('必须和密码相同');
                  return false
              }

              $.ajax({
                  type:'POST',
                  url:'${pageContext.request.contextPath}/userServlet',
                  data:{what:'register',uname:uname,passw:passw},
                  success:function (resultData) {
                      if(resultData=="success"){

                          $("#loginPage input[name='uname']").val(uname);
                          $("#loginPage input[name='passw']").val(passw);

                          loginActive();

                          $("#registerPage input[name='uname']").val('');
                          $("#registerPage input[name='passw']").val('');
                          $("#registerPage input[name='repassw']").val('');

                      }else if(resultData=="repeat"){
                          $("#registerPage input[name='uname']").next().html('已存在');
                      }else if(resultData=="error"){
                          alert("注册失败，请重试")
                      }
                  }
              })
          })

      })

  </script>
  </body>
</html>
