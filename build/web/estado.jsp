<%-- 
    Document   : Estado
    Created on : 05/12/2021
    Author     : Caio Alexandre
--%>
<!--importação dos pacotes-->

<%@page import="java.sql.*"%>
<%@page import="com.mysql.jdbc.Driver"%>
<%@page import="util.Conexao"%> 

<html>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css" integrity="sha384-Vkoo8x4CGsO3+Hhxv8T/Q5PaXtkKtu6ug5TOeNV6gBiFeWPGFN9MuhOf23Q9Ifjh" crossorigin="anonymous">
    <script src="https://code.jquery.com/jquery-3.4.1.slim.min.js" integrity="sha384-J6qa4849blE2+poT4WnyKhv5vZF5SrPo0iEjwBvKU7imGFAV0wwj1yYfoRSJoZ+n" crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js" integrity="sha384-Q6E9RHvbIyZFJoft+2mJbHaEWldlvI9IOYy5n3zV9zzTtmI3UksdQRVvoxMfooAo" crossorigin="anonymous"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/js/bootstrap.min.js" integrity="sha384-wfSDF2E50Y2D1uUdj0O3uMBJnjuUD4Ih7YwaYd1iqfktj0Uod8GCExl3Og8ifwB6" crossorigin="anonymous"></script>
    <link rel="stylesheet"href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.11.2/css/all.css">
    <link href="css/estilo.css" rel="stylesheet">

    <!--declaração de variável-->
    <%
        Statement st = null;
        ResultSet rs = null;
    %>

    <%@page contentType="text/html" pageEncoding="UTF-8"%>
    <!DOCTYPE html>

    <nav class="navbar navbar-expand-lg navbar-light bg-light">
        <a class="navbar-brand" href="#">Navbar</a>
        <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
        </button>

        <div class="collapse navbar-collapse" id="navbarSupportedContent">
            <ul class="navbar-nav mr-auto">
                <li class="nav-item">
                    <a class="nav-link" href="usuario.jsp">Cadastro de Usuário</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="produto.jsp">Cadastro Produto</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="funcionario.jsp">Cadastro Funcionário</a>
                </li>
                <li class="nav-item active">
                    <a class="nav-link" href="estado.jsp">Cadastro Estado <span class="sr-only">(current)</span></a>
                </li>
            </ul>

        </div>
    </nav>


    <!--Tabela Mostrar Usuários Cadastros -->
    <div class="container">
        <div class="row mt-4 mb-4">
                        
            <a type="button" class="btn-info btn-sm" href="estado.jsp?funcao=novo">
                Novo Estado
            </a>
            
            <form class="form-inline my-2 my-lg-0 text-right direita" method="post">
                <input class="form-control from-control-sm mr-sm-2" type="search" name="txtbuscar" placeholder="Buscar por Nome" aria-label="Search">
                <button class="btn btn-outline-info btn-sm my-2 my-sm-0" type="submit" name="btn-buscar">Buscar</button>
            </form>
        </div>

        <table class="table table-striped table-sm">
            <thead>
                <tr>
                    <th scope="col">Nome</th>
                    <th scope="col">Sigla</th>
                    <th scope="col">Ações</th>
                </tr>
            </thead>

            <tbody>
                <!--Método para realizar uma pesquisa-->
                <%
                    try {
                        st = new Conexao().conectar().createStatement();
                        if (request.getParameter("btn-buscar") != null) {
                            String buscar = '%' + request.getParameter("txtbuscar") + '%';
                            rs = st.executeQuery("SELECT * FROM estado WHERE nome LIKE '" + buscar + "'");
                        } else {
                            rs = st.executeQuery("SELECT * FROM estado"); //preencher tabela
                        }
                        while (rs.next()) {


                %>
                <tr>
                    <td><%= rs.getString(2)%></td>
                    <td><%= rs.getString(3)%></td>
                    <td>
                        <a href="estado.jsp?funcao=editar&id=<%= rs.getString(1)%>"class="text-info" ><i class="fas fa-pencil-alt"></i></a>
                        <a href="estado.jsp?funcao=excluir&id=<%= rs.getString(1)%>"class="text-danger"><i class="fas fa-user-times"></i></a>
                    </td>
                </tr>
                <%   }
                    } catch (Exception e) {
                        out.print(e);

                    }
                %>
            </tbody>
        </table>
    </div>
</body>

<!-- Modal - Formulário para cadastro de estado-->
<form>
    <div class="modal fade" id="exampleModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <!--Método para preencher as textbox para atualização-->
                    <%
                        String titulo = "";
                        String btn = "";
                        String idy = "";
                        String nomey = "";
                        String siglay = "";
                        if (request.getParameter("funcao") != null && request.getParameter("funcao").equals("editar")) {
                            titulo = "Editar Estado";
                            btn = "btn-editar";
                            idy = request.getParameter("id");
                            try {
                                st = new Conexao().conectar().createStatement();
                                rs = st.executeQuery("SELECT * FROM estado WHERE id = '" + idy + "' ");
                                while (rs.next()) {
                                    nomey = rs.getString(2);
                                    siglay = rs.getString(3);
                                }
                            } catch (Exception e) {
                                out.print(e);
                            }
                        } else {
                            titulo = "Inserir Estado";
                            btn = "btn-salvar";
                        }
                    %>


                    <h5 class="modal-title" id="exampleModalLabel"><%=titulo%></h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                        
                    </button>
                </div>
                <div class="modal-body">
                    <label for="codigo" class="text-info">Codigo:</label><br>
                    <input value="<%=idy%>"type="text" name="txtcodigo" id="username" class="form-control" >

                    <label for="name" class="text-info">Nome:</label><br>
                    <input value="<%=nomey%>"type="text" name="txtnome" id="username" class="form-control">

                    <label for="sigla" class="text-info">Sigla:</label><br>
                    <input value="<%=siglay%>" type="text" name="txtsigla" id="sigla" class="form-control">
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-dismiss="modal">Fechar</button>
                    <button type="submit" name="<%=btn%>" class="btn btn-primary"><%=titulo%></button>
                </div>
            </div>
        </div>
    </div>
</form>
                
<!--Método para salvar o dados-->
<%    if (request.getParameter("btn-salvar") != null) {
        String nome = request.getParameter("txtnome");
        String sigla = request.getParameter("txtsigla");

        st = new Conexao().conectar().createStatement();
        try {
            st.executeUpdate("INSERT INTO estado (nome, sigla) VALUES('" + nome + "','" + sigla + "')");
            response.sendRedirect("estado.jsp");
        } catch (Exception e) {
            
        }
    }
%>

<!--Método para atualização do dados-->
<%    if (request.getParameter("btn-editar") != null) {
        String nome = request.getParameter("txtnome");
        String sigla = request.getParameter("txtsigla");
        String id = request.getParameter("txtcodigo");

        st = new Conexao().conectar().createStatement();
        
        try {
            st.executeUpdate("UPDATE estado SET nome= '" + nome + "', sigla= '" + sigla + "' WHERE id='" + id + "'");
            response.sendRedirect("estado.jsp");
        } catch (Exception e) {
        }

    }
%>

<!--Método para excluir  do dados-->
<%
    if (request.getParameter("funcao") != null && request.getParameter("funcao").equals("excluir")) {
        String id = request.getParameter("id");

        try {

            st = new Conexao().conectar().createStatement();

            st.executeUpdate("DELETE FROM estado where id = '" + id + "'");
            response.sendRedirect("estado.jsp");

        } catch (Exception e) {
            out.print(e);
        }

    }


%>

<!--Função para editar o cadastro-->
<%    if (request.getParameter("funcao") != null && request.getParameter("funcao").equals("editar")) {
        out.print("<script>$('#exampleModal').modal('show');</script>");

    }
%>

<!--Função para um novo cadastro-->
<%
    if (request.getParameter("funcao") != null && request.getParameter("funcao").equals("novo")) {
        out.print("<script>$('#exampleModal').modal('show');</script>");

    }
%>