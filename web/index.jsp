<%-- 
    Document   : index
    Created on : 29/11/2021, 08:40:49
    Author     : Usuário
--%>

<%@page import="java.sql.*"%>
<%@page import="com.mysql.jdbc.Driver"%>
<%@page import="util.Conexao"%> 

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <link href="//maxcdn.bootstrapcdn.com/bootstrap/4.1.1/css/bootstrap.min.css" rel="stylesheet" id="bootstrap-css">
        <script src="//maxcdn.bootstrapcdn.com/bootstrap/4.1.1/js/bootstrap.min.js"></script>
        <script src="//cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
        <link href="css/login.css" rel="stylesheet">
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <!------ Include the above in your HEAD tag ---------->


        <!--declaração de variável-->
        <%
            Statement st = null;
            ResultSet rs = null;

        %>

    </head>
    <body>

        <div id="login">
            <h3 class="text-center text-white pt-5">Login form</h3>
            <div class="container">
                <div id="login-row" class="row justify-content-center align-items-center">
                    <div id="login-column" class="col-md-6">
                        <div id="login-box" class="col-md-12">
                            <form id="login-form" class="form" action="" method="post">
                                <h3 class="text-center text-info">Login</h3>
                                <div class="form-group">
                                    <label for="username" class="text-info">Usuário:</label><br>
                                    <input type="text" name="txtusuario" id="username" class="form-control">
                                </div>
                                <div class="form-group">
                                    <label for="password" class="text-info">Senha</label><br>
                                    <input type="text" name="txtsenha" id="password" class="form-control">
                                </div>
                                <div class="form-group">
                                    <label for="remember-me" class="text-info"><span>Remember me</span> <span><input id="remember-me" name="remember-me" type="checkbox"></span></label><br>
                                    <input type="submit" name="submit" class="btn btn-info btn-md" value="submit">
                                </div>
                                <div id="register-link" class="text-right">
                                    <a href="#" class="text-info">Register here</a>
                                </div>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </body>

</html>

<!--Construção do código de Java-->

<%      String usuario = request.getParameter("txtusuario");
    String senha = request.getParameter("txtsenha");
    String nomeUsuario = "";
    String user = "", pass = "";
    int i = 0;
    try {
        st = new Conexao().conectar().createStatement();
        rs = st.executeQuery("Select *from usuarios where usuario='" + usuario + "' and senha='" + senha + "'");
        while (rs.next()) {
            user = rs.getString(3);
            pass = rs.getString(4);
            nomeUsuario = rs.getString(2);
            rs.last();

        }
    } catch (Exception e) {
        out.print(e);
    }
    if (usuario == null || senha == null) {
        out.println("Preenche os Dados");
    } else {

        if (usuario.equals(user) && senha.equals(pass)) {
            session.setAttribute("nomeUsuario", nomeUsuario);

            response.sendRedirect("usuario.jsp");

        } else {
            out.println("Dados Incorretos");

        }
    }


%>
