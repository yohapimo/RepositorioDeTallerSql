-- -----------------------------------------------------
-- Creamos la Base de Datos tienda 
-- Usamos la Base de Datos tienda
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS tienda DEFAULT CHARACTER SET utf8;
USE tienda;

-- -----------------------------------------------------
-- Tabla ventas_tienda 
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS store_sale (
  id_store_sale INT NOT NULL AUTO_INCREMENT,
  date_store_sale DATE NULL,
  product_name VARCHAR(25) NOT NULL,
  sold_units INT NOT NULL,
  total DECIMAL NOT NULL,
  PRIMARY KEY (id_store_sale)
  )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Tabla cliente
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS customer (
  id_customer INT NOT NULL AUTO_INCREMENT,
  store_sale_id_store_sale INT NULL,
  document_type VARCHAR(4) NOT NULL,
  document_number VARCHAR(12) NOT NULL,
  PRIMARY KEY (id_customer),
  INDEX fk_customer_store_sale1_idx (store_sale_id_store_sale ASC) VISIBLE,
  CONSTRAINT fk_customer_store_sale1
    FOREIGN KEY (store_sale_id_store_sale)
    REFERENCES store_sale (id_store_sale)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
    )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Tabla proveedor
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS provider (
  id_provider INT NOT NULL AUTO_INCREMENT,
  name VARCHAR(20) NOT NULL,
  last_name VARCHAR(20) NOT NULL,
  PRIMARY KEY (id_provider)
  )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Tabla producto
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS product (
  id_product INT NOT NULL AUTO_INCREMENT,
  provider_id_provider INT NULL,
  name_product VARCHAR(45) NOT NULL,
  price_product DOUBLE NOT NULL,
  units_store INT NOT NULL,
  PRIMARY KEY (id_product),
  INDEX fk_product_provider1_idx (provider_id_provider ASC) VISIBLE,
  CONSTRAINT fk_product_provider1
    FOREIGN KEY (provider_id_provider)
    REFERENCES provider (id_provider)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
    )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Tabla product_has_store_sale
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS product_has_store_sale (
  product_id_product INT NOT NULL,
  store_sale_id_store_sale INT NOT NULL,
  INDEX fk_product_has_store_sale_store_sale1_idx (store_sale_id_store_sale ASC) VISIBLE,
  CONSTRAINT fk_product_has_store_sale_product1
    FOREIGN KEY (product_id_product)
    REFERENCES product (id_product)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT fk_product_has_store_sale_store_sale1
    FOREIGN KEY (store_sale_id_store_sale)
    REFERENCES store_sale (id_store_sale)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
    )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Tabla vendedor
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS seller (
  id_seller INT NOT NULL AUTO_INCREMENT,
  name VARCHAR(20) NOT NULL,
  last_name VARCHAR(45) NOT NULL,
  PRIMARY KEY (id_seller)
  )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Tabla product_has_seller
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS product_has_seller (
  product_id_product INT NOT NULL,
  seller_id_seller INT NOT NULL,
  INDEX fk_product_has_seller_seller1_idx (seller_id_seller ASC) VISIBLE,
  CONSTRAINT fk_product_has_seller_product1
    FOREIGN KEY (product_id_product)
    REFERENCES product (id_product)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT fk_product_has_seller_seller1
    FOREIGN KEY (seller_id_seller)
    REFERENCES seller (id_seller)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
    )
ENGINE = InnoDB;

-- -----------------------------------------------------
-- Insertamos datos a la tabla cliente
-- -----------------------------------------------------
INSERT INTO customer (document_type, document_number) VALUES ('cc', '1125456981');
INSERT INTO customer (document_type, document_number) VALUES ('ti', '1154892542');
INSERT INTO customer (document_type, document_number) VALUES ('cc', '1112548793');
INSERT INTO customer (document_type, document_number) VALUES ('cc', '1230564814');
INSERT INTO customer (document_type, document_number) VALUES ('ti', '1965879445');
INSERT INTO customer (document_type, document_number) VALUES ('cc', '1023456896');
INSERT INTO customer (document_type, document_number) VALUES ('cc', '1125456987');

-- -----------------------------------------------------
-- Insertamos datos a la tabla producto
-- -----------------------------------------------------
INSERT INTO product (name_product, price_product, units_store) VALUES ('jabón', 5000, 90);
INSERT INTO product (name_product, price_product, units_store) VALUES ('arroz', 2500, 80);
INSERT INTO product (name_product, price_product, units_store) VALUES ('panela', 1500, 65);
INSERT INTO product (name_product, price_product, units_store) VALUES ('naranjas', 6000, 90);
INSERT INTO product (name_product, price_product, units_store) VALUES ('limones', 3000, 20);
INSERT INTO product (name_product, price_product, units_store) VALUES ('fresas', 8000, 24);
INSERT INTO product (name_product, price_product, units_store) VALUES ('queso', 11000, 95);
INSERT INTO product (name_product, price_product, units_store) VALUES ('platano', 10000, 50);
INSERT INTO product (name_product, price_product, units_store) VALUES ('café', 9000, 100);
INSERT INTO product (name_product, price_product, units_store) VALUES ('pasta', 6500, 75);

-- ------------------------------------------------------------------------

-- -----------------------------------------------------
-- Insertamos datos a la proveedor
-- -----------------------------------------------------
INSERT INTO provider (name, last_name) VALUES ('juan', 'topo');

-- -----------------------------------------------------
-- Insertamos datos a la tabla vendedor
-- -----------------------------------------------------
INSERT INTO seller (name, last_name) VALUES ('pedro', 'castillo');


-- -----------------------------------------------------
-- Insertamos datos a la tabla ventas de la tienda
-- -----------------------------------------------------
INSERT INTO store_sale (date_store_sale, product_name, sold_units, total) VALUES (now(), 'panela', '10', (1500*10));
INSERT INTO store_sale (date_store_sale, product_name, sold_units, total) VALUES (now(), 'queso', '50', (11000*50));
INSERT INTO store_sale (date_store_sale, product_name, sold_units, total) VALUES (now(), 'limones', '15', (3000*15));
INSERT INTO store_sale (date_store_sale, product_name, sold_units, total) VALUES (now(), 'pasta', '45', (6500*45));
INSERT INTO store_sale (date_store_sale, product_name, sold_units, total) VALUES (now(), 'arroz', '55', (2500*55));
INSERT INTO store_sale (date_store_sale, product_name, sold_units, total) VALUES (now(), 'jabón', '70', (5000*70));


-- -----------------------------------------------------
-- Se realiza consulta de productos vendidos
-- con tipo de documento y cédula
-- -----------------------------------------------------
SELECT product_id_product
FROM product_has_store_sale
WHERE product_id_product = '1';
SELECT product_name FROM store_sale;


-- -----------------------------------------------------
-- Se consulta producto por medio de nombre y proveedor
-- -----------------------------------------------------
SELECT name_product 
FROM product
WHERE provider_id_provider = 1