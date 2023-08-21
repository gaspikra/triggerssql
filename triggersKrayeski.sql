use hoteles;
create table precio_total_alquiler(
    id int not null,
    cantidad_dias int not null,
    precio_final decimal(10, 2) not null
);
DELIMITER //
CREATE TRIGGER monetizacion AFTER INSERT ON estadia
FOR EACH ROW
BEGIN
    DECLARE cantidad_dias INT;
    DECLARE costo_total DECIMAL(10, 2);
    SELECT DATEDIFF(NEW.retiro, NEW.arribo) INTO cantidad_dias;
    SELECT h.precio INTO costo_total
    FROM habitaciones AS h
    WHERE h.numero_hab = NEW.nro_hab;
    INSERT INTO precio_total_alquiler (id, cantidad_dias, precio_final)
    VALUES (NEW.id, cantidad_dias, cantidad_dias * costo_total);
END;
//
DELIMITER ;

DELIMITER //
CREATE TRIGGER verificar_disponibilidad BEFORE INSERT ON estadia
FOR EACH ROW
BEGIN
    DECLARE num_ocupadas INT;
    SELECT COUNT(*) INTO num_ocupadas
    FROM habitaciones 
    WHERE NEW.nro_hab=numero_hab
    AND estado='ocupadas';
END;
//
DELIMITER ;


