--liquibase formatted sql
--changeset deyvid:1
CREATE TABLE clientes (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    correo VARCHAR(100)
);

--changeset iliana:2
INSERT INTO clientes (nombre, correo)
VALUES ('Carlos Pérez', 'carlos@correo.com');

--changeset iliana:3
CREATE TABLE pedidos (
    id INT AUTO_INCREMENT PRIMARY KEY,
    cliente_id INT NOT NULL,
    fecha DATE NOT NULL,
    total DECIMAL(10,2),
    CONSTRAINT fk_cliente
        FOREIGN KEY (cliente_id)
        REFERENCES clientes(id)
);

--changeset deyvid:4
INSERT INTO pedidos (cliente_id, fecha, total)
VALUES 
    (1, '2025-10-05', 250.00),
    (1, '2025-10-06', 175.50);

--changeset deyvid:5
ALTER TABLE pedidos
ADD COLUMN estado VARCHAR(20) DEFAULT 'pendiente' AFTER total;

--changeset iliana:6
CREATE INDEX idx_fecha_pedidos
ON pedidos (fecha);

--changeset iliana:7
UPDATE pedidos
SET estado = 'entregado'
WHERE id = 1;

--rollback UPDATE pedidos SET estado = 'pendiente' WHERE id = 1;