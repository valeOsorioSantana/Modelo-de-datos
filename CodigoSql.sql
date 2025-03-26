-- Crear tabla 'usuario'
CREATE TABLE usuario (
    id SERIAL PRIMARY KEY,
    uuid UUID,
    typedocument VARCHAR(255),
    name VARCHAR(255),
    lastname VARCHAR(255),
    phone VARCHAR(255),
    email VARCHAR(255),
    password VARCHAR(255),
    profileInfo TEXT,
    create_at TIMESTAMP,
    updated_at TIMESTAMP,
    delete_at TIMESTAMP
);

-- Crear tabla 'evento'
CREATE TABLE evento (
    id SERIAL PRIMARY KEY,
    name VARCHAR(255),
    date DATE,
    entryOptions TEXT,
    location VARCHAR(255),
    category VARCHAR(255),
    description TEXT,
    organizer_id INTEGER REFERENCES usuario(id),
    reminders TEXT
);

-- Crear tabla 'calendario'
CREATE TABLE calendario (
    id SERIAL PRIMARY KEY,
    name VARCHAR(255),
    evento_id INTEGER REFERENCES evento(id),
    date DATE,
    entryOptions TEXT,
    location VARCHAR(255),
    category VARCHAR(255),
    description TEXT,
    reminders TEXT
);

-- Crear tabla 'favoritos'
CREATE TABLE favoritos (
    id SERIAL PRIMARY KEY,
    usuario_id INTEGER REFERENCES usuario(id),
    evento_id INTEGER REFERENCES evento(id)
);

-- Crear tabla 'tickets'
CREATE TABLE tickets (
    id SERIAL PRIMARY KEY,
    usuario_id INTEGER REFERENCES usuario(id),
    evento_id INTEGER REFERENCES evento(id),
    ticketType VARCHAR(255),
    entryOptions TEXT,
    price DECIMAL,
    purchaseDate DATE,
    status VARCHAR(255)
);

-- Crear tabla 'pagos'
CREATE TABLE pagos (
    id SERIAL PRIMARY KEY,
    ticket_id INTEGER REFERENCES tickets(id),
    evento_id INTEGER REFERENCES evento(id),
    method VARCHAR(255),
    amount DECIMAL,
    paymentDate DATE,
    status VARCHAR(255)
);

-- Crear tabla 'compartir'
CREATE TABLE compartir (
    id SERIAL PRIMARY KEY,
    usuario_id INTEGER REFERENCES usuario(id),
    evento_id INTEGER REFERENCES evento(id),
    status VARCHAR(255)
);

-- Crear tabla 'comentar'
CREATE TABLE comentar (
    id SERIAL PRIMARY KEY,
    usuario_id INTEGER REFERENCES usuario(id),
    evento_id INTEGER REFERENCES evento(id),
    commentText TEXT,
    rating INTEGER,
    commentDate DATE
);

-- Crear tabla 'organizers'
CREATE TABLE organizers (
    id SERIAL PRIMARY KEY,
    name VARCHAR(255),
    contactInfo TEXT,
    usuario_id INTEGER REFERENCES usuario(id),
    evento_id INTEGER REFERENCES evento(id),
    position INTEGER,
    status VARCHAR(255),
    descriptionsessions TEXT
);

-- Crear tabla 'personalizacion'
CREATE TABLE personalizacion (
    id SERIAL PRIMARY KEY,
    username VARCHAR(255),
    personalize TEXT,
    recommended TEXT,
    usuario_id INTEGER REFERENCES usuario(id),
    evento_id INTEGER REFERENCES evento(id),
    theme VARCHAR(255),
    font_size VARCHAR(255),
    notifications BOOLEAN,
    recomendaciones_eventos BOOLEAN,
    seguir_intereses BOOLEAN
);

-- Crear tabla 'patrocinios'
CREATE TABLE patrocinios (
    id SERIAL PRIMARY KEY,
    organizador_id INTEGER REFERENCES usuario(id),
    acuerdos BOOLEAN,
    info_sponsor TEXT,
    interaccion_sponsor BOOLEAN,
    reporte_metricas BOOLEAN
);

-- Crear tabla 'comunicacion'
CREATE TABLE comunicacion (
    id SERIAL PRIMARY KEY,
    organizador_id INTEGER REFERENCES usuario(id),
    recordatorios_eventos BOOLEAN,
    cambios_eventos BOOLEAN,
    mensajes_asistentes BOOLEAN,
    comunicacion_bi BOOLEAN
);

-- Crear tabla 'analisis_datos'
CREATE TABLE analisis_datos (
    id SERIAL PRIMARY KEY,
    asistencia_eventos INTEGER,
    participacion_eventos INTEGER,
    tendencias TEXT,
    informes TEXT,
    mejora_experiencia BOOLEAN
);

-- Crear tabla 'seguridad_privacidad'
CREATE TABLE seguridad_privacidad (
    id SERIAL PRIMARY KEY,
    privacidad BOOLEAN,
    consentimiento BOOLEAN
);

-- Crear tabla 'analisis_sistema'
CREATE TABLE analisis_sistema (
    id SERIAL PRIMARY KEY,
    informe_analisis TEXT,
    diagrama_requerimientos TEXT,
    backlog TEXT
);

-- Crear tabla 'diseno_software'
CREATE TABLE diseno_software (
    id SERIAL PRIMARY KEY,
    diagrama_flujo TEXT,
    diagrama_ER TEXT,
    wireframes TEXT,
    plantilla TEXT
);

-- Crear tabla 'soporte'
CREATE TABLE soporte (
    id SERIAL PRIMARY KEY,
    chatbot BOOLEAN,
    encuestas_satisfaccion BOOLEAN
);

-- Relaciones de claves foráneas (FK)
ALTER TABLE organizers ADD CONSTRAINT fk_organizers_evento FOREIGN KEY (evento_id) REFERENCES evento(id);
ALTER TABLE calendario ADD CONSTRAINT fk_calendario_evento FOREIGN KEY (evento_id) REFERENCES evento(id);
ALTER TABLE favoritos ADD CONSTRAINT fk_favoritos_usuario FOREIGN KEY (usuario_id) REFERENCES usuario(id);
ALTER TABLE favoritos ADD CONSTRAINT fk_favoritos_evento FOREIGN KEY (evento_id) REFERENCES evento(id);
ALTER TABLE tickets ADD CONSTRAINT fk_tickets_usuario FOREIGN KEY (usuario_id) REFERENCES usuario(id);
ALTER TABLE tickets ADD CONSTRAINT fk_tickets_evento FOREIGN KEY (evento_id) REFERENCES evento(id);
ALTER TABLE pagos ADD CONSTRAINT fk_pagos_ticket FOREIGN KEY (ticket_id) REFERENCES tickets(id);
ALTER TABLE pagos ADD CONSTRAINT fk_pagos_evento FOREIGN KEY (evento_id) REFERENCES evento(id);
ALTER TABLE compartir ADD CONSTRAINT fk_compartir_usuario FOREIGN KEY (usuario_id) REFERENCES usuario(id);
ALTER TABLE compartir ADD CONSTRAINT fk_compartir_evento FOREIGN KEY (evento_id) REFERENCES evento(id);
ALTER TABLE comentar ADD CONSTRAINT fk_comentar_usuario FOREIGN KEY (usuario_id) REFERENCES usuario(id);
ALTER TABLE comentar ADD CONSTRAINT fk_comentar_evento FOREIGN KEY (evento_id) REFERENCES evento(id);
ALTER TABLE organizers ADD CONSTRAINT fk_organizers_usuario FOREIGN KEY (usuario_id) REFERENCES usuario(id);
ALTER TABLE personalizacion ADD CONSTRAINT fk_personalizacion_usuario FOREIGN KEY (usuario_id) REFERENCES usuario(id);
ALTER TABLE personalizacion ADD CONSTRAINT fk_personalizacion_evento FOREIGN KEY (evento_id) REFERENCES evento(id);
ALTER TABLE patrocinios ADD CONSTRAINT fk_patrocinios_organizador FOREIGN KEY (organizador_id) REFERENCES usuario(id);
ALTER TABLE patrocinios ADD CONSTRAINT fk_patrocinios_evento FOREIGN KEY (evento_id) REFERENCES evento(id);
ALTER TABLE comunicacion ADD CONSTRAINT fk_comunicacion_organizador FOREIGN KEY (organizador_id) REFERENCES usuario(id);
ALTER TABLE analisis_datos ADD CONSTRAINT fk_analisis_datos_evento FOREIGN KEY (evento_id) REFERENCES evento(id);
ALTER TABLE analisis_datos ADD CONSTRAINT fk_analisis_datos_usuario FOREIGN KEY (usuario_id) REFERENCES usuario(id);
ALTER TABLE seguridad_privacidad ADD CONSTRAINT fk_seguridad_privacidad_usuario FOREIGN KEY (usuario_id) REFERENCES usuario(id);
ALTER TABLE seguridad_privacidad ADD CONSTRAINT fk_seguridad_privacidad_evento FOREIGN KEY (evento_id) REFERENCES evento(id);
ALTER TABLE analisis_sistema ADD CONSTRAINT fk_analisis_sistema_usuario FOREIGN KEY (usuario_id) REFERENCES usuario(id);
ALTER TABLE analisis_sistema ADD CONSTRAINT fk_analisis_sistema_evento FOREIGN KEY (evento_id) REFERENCES evento(id);
ALTER TABLE diseno_software ADD CONSTRAINT fk_diseno_software_usuario FOREIGN KEY (usuario_id) REFERENCES usuario(id);
ALTER TABLE soporte ADD CONSTRAINT fk_soporte_usuario FOREIGN KEY (usuario_id) REFERENCES usuario(id);