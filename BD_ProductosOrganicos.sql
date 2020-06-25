Create database ProductosOrganicos


--Creacion de las tablas relacionadas a los usuarios (Cliente y Administrador)

Create table Rol(
idrol int identity(1,1) not null primary key,
nombreRol varchar(50) not null
)
go

Create table Usuario(
idUsuario int identity(1,1) not null primary key,
nombre varchar(50) not null,
apellido varchar(50) not null,
telefono varchar(9) not null,
direccion varchar(100) not null,
dni int not null,
fecIngreso datetime not null,
idrol int not null references Rol,
correo varchar(50) not null,
contraseña varchar(20) not null
)
go

Insert into rol (nombreRol)
	values('Administrador')

Insert into Usuario (nombre, apellido, telefono, direccion, dni, fecIngreso, idrol, correo, contraseña)
	values('ALBERTO','Alfaro',956854125, 'calle caceres 1520', 25142526, GETDATE(), 1, 'kathia@gmail.com','mimi')


Create table Cliente(
idcliente int identity(1,1) not null primary key,
nombreCliente varchar(50) not null,
apellidoCliente varchar(50) not null,
dirCliente varchar(100) not null,
distrito varchar(50) not null,
telefonoCliente varchar(9) not null,
correo varchar(50) not null,
contraseña varchar(20) not null
)
go


--Creacion de las tablas relacionadas al Producto

Create table Pais(
idpais int not null primary key,
nombrePais varchar(50) not null
)
go

Create table Proveedor(
idproveedor int  identity not null primary key,
nombreProveedor varchar(50) not null,
dirProveedor varchar(50) not null,
numTelefono varchar(9) not null,
correoProveedor varchar(50) not null,
idpais int not null references Pais,
ruc int not null
)
go

Create table Categoria(
idcategoria int identity not null primary key,
nombreCategoria varchar(50) not null,
descripcion varchar(100) not null
)
go

Create table Producto(
idproducto  int identity not null primary key,
nombreProducto varchar(50) not null,
descripcion varchar(300) not null,
idcategoria int not null references Categoria,
precioUnidad decimal not null,
stock int not null,
idproveedor int not null references Proveedor

)
go

Insert into Pais(idpais, nombrePais)
	values(3,'Peru');

Insert into Proveedor(nombreProveedor,dirProveedor,numTelefono,correoProveedor,idpais,ruc)
	values('Gloria','Av. Lima 1528',956854125, 'ventas@gloria.com', 1, 1215426325)


Insert into Categoria(nombreCategoria,descripcion)
	values('Lacteos','Derivados de la leche')

Insert Producto(nombreProducto,descripcion,idcategoria,precioUnidad,stock,idproveedor,Activo)
	values('Leche','Leche de Soya',1,50,500,1,1)


--Creacion de las tablas relacionadas a la compra de la tienda virtual

Create table PedidosCabe(
idpedidocabe int identity(1,1) not null primary key,
idcliente int not null references Cliente,
fechaPedida datetime not null,
fechaEntrega datetime not null,
fechaEnvio datetime not null,
pedidoscabecol varchar(45) not null
)
go

Create table PedidosDeta(
idpedido int identity(1,1) not null primary key,
idproducto int not null references Producto,
precioUnidad decimal not null,
cantidad int not null,
descuento varchar(45) not null
)
go

Alter table Producto
add Activo bit
go

Update Producto Set Activo = 1
go


-- Procedimientos Almacenados Listados
-- Listado Productos, Proveedor, Categorias, Pais

Create Proc usp_Producto_Listar
As
Begin
	Select * from Producto where Activo = 1
End
go

Create Proc usp_Categoria_Listar
As
Begin
	Select * from Categoria 
End
go

Create Proc usp_Proveedor_Listar
As
Begin
	Select * from Proveedor 
End
go

Create Proc usp_Pais_Listar
As
Begin
	Select * from Pais 
End
go

-- Listado Usuario, Cliente, Rol

Create Proc usp_Usuario_Listar
As
Begin
	Select * from Usuario
End
go

Create Proc usp_Cliente_Listar
As
Begin
	Select * from Cliente
End
go

Create Proc usp_Rol_Listar
As
Begin
	Select * from Rol
End
go

-- Procedimientos Almacenados Insertar
-- Listado Productos, Usuario, Cliente

Create Proc usp_Producto_Insertar
@nombreProducto varchar(50),
@descripcion varchar(300),
@idcategoria int,
@precioUnidad decimal,
@stock int,
@idproveedor int
As
Begin
	Insert into Producto(nombreProducto,descripcion,idcategoria,precioUnidad,stock,idproveedor,Activo)
	values(@nombreProducto,@descripcion,@idcategoria,@precioUnidad,@stock,@idproveedor,1)
End
go


Create Proc usp_Usuario_Insertar
@nombre varchar(50),
@apellido varchar(50),
@telefono varchar(9),
@direccion varchar (100),
@dni int,
@idrol int,
@correo varchar(50),
@contraseña varchar(20)
As
Begin
	Insert into Usuario(nombre,apellido,telefono,direccion,dni,fecIngreso,idrol,correo,contraseña)
	values(@nombre,@apellido,@telefono,@direccion,@dni,GETDATE(),@idrol,@correo,@contraseña)
End
go

EXEC usp_Cliente_Insertar 'alberto', 'Guanilo','av cerro de pasco 1523','comas','956235658','alberto@gmail','mupi'
go

Create Proc usp_Cliente_Insertar
@nombreCliente varchar(50),
@apellidoCliente varchar(50),
@dirCliente varchar(100),
@distrito varchar (50),
@telefonoCliente varchar(9),
@correo varchar(50),
@contraseña varchar(20)

As
Begin
	Insert into Cliente(nombreCliente,apellidoCliente,dirCliente,distrito,telefonoCliente,correo,contraseña)
	values(@nombreCliente,@apellidoCliente,@dirCliente,@distrito,@telefonoCliente,@correo,@contraseña)
End
go

-- Procedimientos Almacenados Actualizar
-- Listado Productos, Usuario, Cliente

Create Proc usp_Producto_Actualizar
@idProducto int,
@nombreProducto varchar(50),
@descripcion varchar(300),
@idcategoria int,
@precioUnidad decimal,
@stock int,
@idproveedor int
As
Begin
	Update Producto
		set	nombreProducto=@nombreProducto,
			descripcion=@descripcion,
			idcategoria=@idcategoria,
			precioUnidad=@precioUnidad,
			stock=@stock,
			idproveedor=@idproveedor

	where	idproducto=@idProducto
End
go


Create Proc usp_Usuario_Actualizar
@idUsuario int,
@nombre varchar(50),
@apellido varchar(50),
@telefono varchar(9),
@direccion varchar (100),
@dni int,
@idrol int,
@correo varchar(50),
@contraseña varchar(20)
As
Begin
	Update Usuario
		set	nombre=@nombre,
			apellido=@apellido,
			telefono=@telefono,
			direccion=@direccion,
			dni=@dni,
			idrol=@idrol,
			correo=@correo,
			contraseña=@contraseña

	where	idUsuario=@idUsuario
End
go

Create Proc usp_Cliente_Update
@idCliente int,
@nombreCliente varchar(50),
@apellidoCliente varchar(50),
@dirCliente varchar(100),
@distrito varchar (50),
@telefonoCliente varchar(9),
@correo varchar(50),
@contraseña varchar(20)
As
Begin
	Update Cliente
		set	nombreCliente=@nombreCliente,
			apellidoCliente=@apellidoCliente,
			dirCliente=@dirCliente,
			distrito=@distrito,
			telefonoCliente=@telefonoCliente,
			correo=@correo,
			contraseña=@contraseña

	where	idcliente=@idCliente
End
go

-- Procedimientos Almacenados Eliminar
-- Listado Productos, Usuario, Cliente

Create Proc usp_Producto_Eliminar
@idProducto int
As
IF EXISTS (SELECT * FROM Producto WHERE idproducto = @idProducto)
BEGIN
       DELETE FROM Producto WHERE idproducto = @idProducto
END
go

Create Proc usp_Usuario_Eliminar
@idUsuario int
AS
IF EXISTS (SELECT * FROM Usuario WHERE idUsuario = @idUsuario)
BEGIN
       DELETE FROM Usuario WHERE idUsuario = @idUsuario
END
go

Create Proc usp_Cliente_Eliminar
@idCliente int
AS
IF EXISTS (SELECT * FROM Cliente WHERE idcliente = @idCliente)
BEGIN
       DELETE FROM Cliente WHERE idcliente = @idCliente
END
go

Create Proc usp_Producto_Datos
@IdProducto int
As
Begin
	Select * from Producto Where idproducto=@IdProducto And Activo = 1
End
go

Create Proc usp_Usuario_Datos
@IdUsuario int
As
Begin
	Select * from Usuario Where idUsuario=@IdUsuario
End
go

Create Proc usp_Cliente_Datos
@IdCliente int
As
Begin
	Select * from Cliente Where idcliente=@IdCliente
End
go
