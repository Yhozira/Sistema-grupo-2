CREATE DATABASE IF NOT EXISTS tienda;

USE tienda;

-- Tabla: categorias
CREATE TABLE IF NOT EXISTS categorias (
  idCategoria INT NOT NULL AUTO_INCREMENT,
  nombreCategoria VARCHAR(100) DEFAULT NULL,
  estadoCategoria INT DEFAULT NULL,
  PRIMARY KEY (idCategoria)
);

-- Tabla: proveedores
CREATE TABLE IF NOT EXISTS proveedores (
  idProveedor INT NOT NULL AUTO_INCREMENT,
  nombreCompania VARCHAR(100) DEFAULT NULL,
  nombreContacto VARCHAR(100) DEFAULT NULL,
  direccion VARCHAR(200) DEFAULT NULL,
  telefono VARCHAR(24) DEFAULT NULL,
  estadoProvedores INT DEFAULT NULL,
  PRIMARY KEY (idProveedor)
);

-- Tabla: productos
CREATE TABLE IF NOT EXISTS productos (
  idProducto INT NOT NULL AUTO_INCREMENT,
  SerieProducto VARCHAR(300) DEFAULT NULL,
  ImagenProducto VARCHAR(300) DEFAULT NULL,
  nombreProducto VARCHAR(300) DEFAULT NULL,
  idProveedor INT  NOT NULL,
  idCategoria INT  NOT NULL,
  precioUnidad DECIMAL(10,2) DEFAULT NULL,
  stock DECIMAL(5,2) DEFAULT NULL,
  categoriaProducto VARCHAR(20) DEFAULT NULL,
  estadoProducto INT DEFAULT NULL,
  PRIMARY KEY (idProducto),
  KEY fk_proveedor (idProveedor),
  KEY fk_categoria (idCategoria),
  CONSTRAINT fk_proveedor FOREIGN KEY (idProveedor) REFERENCES proveedores (idProveedor),
  CONSTRAINT fk_categoria FOREIGN KEY (idCategoria) REFERENCES categorias (idCategoria)
);

-- Tabla: clientes
CREATE TABLE IF NOT EXISTS clientes (
  idCliente INT(5) NOT NULL AUTO_INCREMENT,
  nombre VARCHAR(100) DEFAULT NULL,
  direccion VARCHAR(200) DEFAULT NULL,
  telefono VARCHAR(29) DEFAULT NULL,
  estadoCliente INT DEFAULT NULL,
  PRIMARY KEY (idCliente)
);

-- Tabla: empleados
CREATE TABLE IF NOT EXISTS empleados (
  idEmpleado INT NOT NULL  AUTO_INCREMENT,
  apellido VARCHAR(60) DEFAULT NULL,
  nombre VARCHAR(40) DEFAULT NULL,
  direccion VARCHAR(200) DEFAULT NULL,
  usuario VARCHAR(20) DEFAULT NULL,
  contraseña VARCHAR(20) DEFAULT NULL,
  correo VARCHAR(50) DEFAULT NULL,
  estadoEmpleado INT DEFAULT NULL,
  PRIMARY KEY (idEmpleado)
);

-- Tabla: pedido (antes llamada boleta)
CREATE TABLE IF NOT EXISTS pedido (
  idPedido INT NOT NULL  AUTO_INCREMENT,
  idCliente INT(5) NOT NULL  ,
  idEmpleado INT NOT NULL  ,
  formaPago VARCHAR(10) DEFAULT NULL,  -- Añadida columna formaPago
  fechaHora DATETIME DEFAULT CURRENT_TIMESTAMP,  -- Añadida columna fechaHora
  monto DECIMAL(10,2) DEFAULT NULL,
  igv DECIMAL(10,2) DEFAULT NULL,
  estadoPedido INT DEFAULT NULL,
  PRIMARY KEY (idPedido),
  KEY fk_pedido_cliente (idCliente),
  KEY fk_pedido_empleado (idEmpleado),
  CONSTRAINT fk_pedido_cliente FOREIGN KEY (idCliente) REFERENCES clientes (idCliente),
  CONSTRAINT fk_pedido_empleado FOREIGN KEY (idEmpleado) REFERENCES empleados (idEmpleado)
);

-- Tabla: detallesPedidos
CREATE TABLE IF NOT EXISTS detallesPedidos (
  idPedido INT NOT NULL  AUTO_INCREMENT,
  idProducto INT NOT NULL  ,
  idBoleta INT NOT NULL  ,
  precioUnidad DECIMAL(10,2) DEFAULT NULL,
  cantidad INT DEFAULT NULL,
  estadoDetalle INT DEFAULT NULL,
  PRIMARY KEY (idPedido),
  KEY fk_detalle_pedido_producto (idProducto),
  KEY fk_detalle_pedido_boleta (idBoleta),
  CONSTRAINT fk_detalle_pedido_producto FOREIGN KEY (idProducto) REFERENCES productos (idProducto),
  CONSTRAINT fk_detalle_pedido_boleta FOREIGN KEY (idBoleta) REFERENCES pedido (idPedido)
);
