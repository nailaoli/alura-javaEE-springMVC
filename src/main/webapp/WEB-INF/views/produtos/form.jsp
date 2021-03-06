<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="security"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="s"%>
<!DOCTYPE html>
<html>

<head>
	<meta charset="UTF-8">

	<c:url value="/resources/css" var="cssPath" />

	<link rel="stylesheet" href="${cssPath}/bootstrap.min.css">

	<style type="text/css">
		body {
			padding: 60px 0px;
		}
	</style>

	<title>Livros de Programação - Casa do Código</title>
</head>

<body>
		<nav class="navbar fixed-top navbar-expand-xl navbar-dark bg-dark">
		<div class="container">
			<div class="navbar-header">
				<button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarText" aria-controls="navbarText" aria-expanded="false">
					<span class="navbar-toggler-icon"></span>
				</button>
				<a class="navbar-brand" href="${s:mvcUrl('HC#index').build() }">Casa do Código</a>
			</div>

			<div class="collapse navbar-collapse" id="navbarText">
				<ul class="navbar-nav mr-auto">
					<li class="nav-item"><a class="nav-link" href="${s:mvcUrl('PC#listar').build() }">Lista de Produtos</a></li>
					<li class="nav-item"><a class="nav-link" href="${s:mvcUrl('PC#form').build() }">Cadastro de Produtos</a></li>
				</ul>

				<ul class="nav navbar-nav navbar-right">
					<li class="nav-item"><a href="<c:url value='/logout'/>"> <security:authentication property="principal" var="usuario" /> Usuário: ${usuario.username} (sair)
					</a></li>
				</ul>

			</div>
			<!-- /.navbar-collapse -->
		</div>
	</nav>
	
	
	
	<div class="container">
		<h1>Cadastro de Produto</h1>
		<form:form action="${pageContext.request.contextPath}/produtos/cadastraProduto" method="POST" commandName="produto"
			enctype="multipart/form-data">
			<div class="form-group">
				<label>Título</label>
				<form:input path="titulo" cssClass="form-control" value="${titulo }"/>
				<form:errors path="titulo" />
			</div>
			<div class="form-group">
				<label>Descrição</label>
				<form:textarea path="descricao" cssClass="form-control" />
				<form:errors path="descricao"  value="${descricao }"/>
			</div>
			<div class="form-group">
				<label>Categoria</label>
				<select name="categoria" class="form-control">
				<option value="selecione">Selecione</option>
					<c:forEach items="${categorias}" var="cat" varStatus="status">
							<c:choose>
								<c:when test="${produto.categoria == cat }">
									<option value="${cat}" selected>${cat}</option>	
								</c:when>
								<c:when test="${produto.categoria != cat}">
									<option value="${cat}">${cat}</option>	
								</c:when>
							</c:choose>
						</c:forEach>
					</select>
			</div>
			
			
			<div class="form-group">
				<label>Páginas</label>
				<form:input path="paginas" cssClass="form-control" />
				<form:errors path="paginas" value="${paginas }" />
			</div>
			<div class="form-group">
				<label>Data de Lançamento</label>
				<form:input path="dataLancamento" cssClass="form-control" />
				<form:errors path="dataLancamento" value="${dataLancamento }"/>
			</div>
			<c:forEach items="${tipos}" var="tipoPreco" varStatus="status">
				<div class="form-group">
					<label>Preço ${tipoPreco}</label>
					<form:input path="precos[${status.index}].valor" cssClass="form-control" value="${precos[index].valor}"/>
					<form:hidden path="precos[${status.index}].tipo" value="${tipoPreco}" />
				</div>
			</c:forEach>
			<div class="form-group">
				<label>URL da capa</label>
				<form:input path="sumario" cssClass="form-control" value="${sumario }"/>
				<form:errors path="sumario" />
			</div>
				<c:if test="${produto.id != null}">
					<div class="form-group">
						<input type="submit" class="btn btn-primary" value="Atualizar">
						<input type="hidden" name="id" value="${produto.id}">
					</div>
				</c:if>
				
				<c:if test="${produto.id == null}">
					<div class="form-group">
						<input type="submit" class="btn btn-primary" value="Cadastrar">
					</div>
				</c:if>

		</form:form>
	</div>
</body>

</html>