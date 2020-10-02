--- Drop and Re-create all schemas first ---



-- SCHEMA: loe --

DROP TABLE IF EXISTS  loe."loe_by_play";
DROP TABLE IF EXISTS  loe."loe_by_play_op";

DROP SCHEMA IF EXISTS  loe;

CREATE SCHEMA loe
    AUTHORIZATION rseg_user;

GRANT ALL ON SCHEMA loe TO rseg_user;

GRANT USAGE ON SCHEMA loe TO rseg_prism;


-- SCHEMA: transportation --

DROP TABLE IF EXISTS  transportation."tport_by_play";
DROP TABLE IF EXISTS  transportation."tport_by_play_op";

DROP SCHEMA IF EXISTS  transportation;

CREATE SCHEMA transportation
    AUTHORIZATION rseg_user;

GRANT ALL ON SCHEMA transportation TO rseg_user;

GRANT USAGE ON SCHEMA transportation TO rseg_prism;


-- SCHEMA: ngl --

DROP TABLE IF EXISTS  ngl."ngl_by_region";
DROP TABLE IF EXISTS  ngl."ngl_by_play";
DROP TABLE IF EXISTS  ngl."proc_fee_by_play_op";

DROP SCHEMA IF EXISTS  ngl;

CREATE SCHEMA ngl
    AUTHORIZATION rseg_user;

GRANT ALL ON SCHEMA ngl TO rseg_user;

GRANT USAGE ON SCHEMA ngl TO rseg_prism;


-- SCHEMA: mapping --

DROP TABLE IF EXISTS  mapping."mapping_by_play";
DROP TABLE IF EXISTS  mapping."mapping_by_play_op";
DROP TABLE IF EXISTS  mapping."mapping_by_state_county";
DROP TABLE IF EXISTS  mapping."mapping_by_region";

DROP SCHEMA IF EXISTS  mapping;

CREATE SCHEMA mapping
    AUTHORIZATION rseg_user;

GRANT ALL ON SCHEMA mapping TO rseg_user;

GRANT USAGE ON SCHEMA mapping TO rseg_prism;

--- Create all tables ---

-- Table: loe."loe_by_play" --
CREATE TABLE loe."loe_by_play"
(
    aurora_id text COLLATE pg_catalog."default" NOT NULL,
    "playName" text COLLATE pg_catalog."default" NOT NULL,
    "regionName" text COLLATE pg_catalog."default" NOT NULL,
    "minResult" double precision NOT NULL,
    "maxResult" double precision NOT NULL,
    CONSTRAINT "play_inputs_pkey" PRIMARY KEY (aurora_id)
)
WITH (
    OIDS = FALSE
)
TABLESPACE pg_default;

ALTER TABLE loe."loe_by_play"
    OWNER to rseg_user;

GRANT ALL ON TABLE loe."loe_by_play" TO rseg_prism;

GRANT ALL ON TABLE loe."loe_by_play" TO rseg_user;


-- Table: loe."loe_by_play_op" --
CREATE TABLE loe."loe_by_play_op"
(
    aurora_id text COLLATE pg_catalog."default" NOT NULL,
    "playName" text COLLATE pg_catalog."default" NOT NULL,
    ticker text COLLATE pg_catalog."default" NOT NULL,
    "liquidPercent" double precision NOT NULL,
    "grossVarLOE" double precision NOT NULL,
    "includeInReg" boolean NOT NULL,
    CONSTRAINT "play_op_inputs_pkey" PRIMARY KEY (aurora_id)
)
WITH (
    OIDS = FALSE
)
TABLESPACE pg_default;

ALTER TABLE loe."loe_by_play_op"
    OWNER to rseg_user;

GRANT ALL ON TABLE loe."loe_by_play_op" TO rseg_prism;

GRANT ALL ON TABLE loe."loe_by_play_op" TO rseg_user;


-- Table: transportation."tport_by_play" --
CREATE TABLE transportation."tport_by_play"
(
    aurora_id text COLLATE pg_catalog."default" NOT NULL,
    "playName" text COLLATE pg_catalog."default" NOT NULL,
    "regionName" text COLLATE pg_catalog."default" NOT NULL,
    "minResult" double precision NOT NULL,
    "maxResult" double precision NOT NULL,
    CONSTRAINT "tport_by_play_pkey" PRIMARY KEY (aurora_id)
)
WITH (
    OIDS = FALSE
)
TABLESPACE pg_default;

ALTER TABLE transportation."tport_by_play"
    OWNER to rseg_user;

GRANT ALL ON TABLE transportation."tport_by_play" TO rseg_prism;

GRANT ALL ON TABLE transportation."tport_by_play" TO rseg_user;


-- Table: transportation."tport_by_play_op" --
CREATE TABLE transportation."tport_by_play_op"
(
    aurora_id text COLLATE pg_catalog."default" NOT NULL,
    ticker text COLLATE pg_catalog."default" NOT NULL,
    "playName" text COLLATE pg_catalog."default" NOT NULL,
    "liquidPercent" double precision NOT NULL,
    "grossTransportation" double precision NOT NULL,
    "includeInReg" boolean NOT NULL,
    CONSTRAINT "tport_by_playop_pkey" PRIMARY KEY (aurora_id)
)
WITH (
    OIDS = FALSE
)
TABLESPACE pg_default;

ALTER TABLE transportation."tport_by_play_op"
    OWNER to rseg_user;

GRANT ALL ON TABLE transportation."tport_by_play_op" TO rseg_prism;

GRANT ALL ON TABLE transportation."tport_by_play_op" TO rseg_user;


-- Table: ngl."ngl_by_play" --
CREATE TABLE ngl."ngl_by_play"
(
    aurora_id text COLLATE pg_catalog."default" NOT NULL,
    "playName" text COLLATE pg_catalog."default" NOT NULL,
    composition text COLLATE pg_catalog."default" NOT NULL,
    "nglYield" double precision NOT NULL,
    "gasShrink" double precision NOT NULL,
    "rangeStart" double precision NOT NULL,
    "rangeEnd" double precision NOT NULL,
    "isStartIncl" boolean NOT NULL,
    "isEndIncl" boolean NOT NULL,
    "procFee" double precision NOT NULL,
    CONSTRAINT "play_proc_costs_pkey" PRIMARY KEY (aurora_id)
)
WITH (
    OIDS = FALSE
)
TABLESPACE pg_default;

ALTER TABLE ngl."ngl_by_play"
    OWNER to rseg_user;

GRANT ALL ON TABLE ngl."ngl_by_play" TO rseg_prism;

GRANT ALL ON TABLE ngl."ngl_by_play" TO rseg_user;


-- Table: ngl."ngl_by_region" --
CREATE TABLE ngl."ngl_by_region"
(
    aurora_id text COLLATE pg_catalog."default" NOT NULL,
    "regionName" text COLLATE pg_catalog."default" NOT NULL,
    composition text COLLATE pg_catalog."default" NOT NULL,
    "nglYield" double precision NOT NULL,
    "gasShrink" double precision NOT NULL,
    "rangeStart" double precision NOT NULL,
    "rangeEnd" double precision NOT NULL,
    "isStartIncl" boolean NOT NULL,
    "isEndIncl" boolean NOT NULL,
    "procFee" double precision NOT NULL,
    CONSTRAINT "proc_costs_pkey" PRIMARY KEY (aurora_id)
)
WITH (
    OIDS = FALSE
)
TABLESPACE pg_default;

ALTER TABLE ngl."ngl_by_region"
    OWNER to rseg_user;

GRANT ALL ON TABLE ngl."ngl_by_region" TO rseg_prism;

GRANT ALL ON TABLE ngl."ngl_by_region" TO rseg_user;


-- Table: ngl."proc_fee_by_play_op" --
CREATE TABLE ngl."proc_fee_by_play_op"
(
    aurora_id text COLLATE pg_catalog."default" NOT NULL,
    "playName" text COLLATE pg_catalog."default" NOT NULL,
    ticker text COLLATE pg_catalog."default" NOT NULL,
    composition text COLLATE pg_catalog."default" NOT NULL,
    "procFee" double precision NOT NULL,
    CONSTRAINT "proc_fee_by_play_op_pkey" PRIMARY KEY (aurora_id)
)
WITH (
    OIDS = FALSE
)
TABLESPACE pg_default;

ALTER TABLE ngl."proc_fee_by_play_op"
    OWNER to rseg_user;

GRANT ALL ON TABLE ngl."proc_fee_by_play_op" TO rseg_prism;

GRANT ALL ON TABLE ngl."proc_fee_by_play_op" TO rseg_user;


-- Table: mapping."mapping_by_play" --
CREATE TABLE mapping."mapping_by_play"
(
    "rrOilPercent" double precision NOT NULL,
    "rrGasPercent" double precision NOT NULL,
    "rrNglPercent" double precision NOT NULL,
    aurora_id text COLLATE pg_catalog."default" NOT NULL,
    "playName" text COLLATE pg_catalog."default" NOT NULL,
    "oilDifferential" double precision NOT NULL,
    "gasDifferential" double precision NOT NULL,
    "nglDifferential" double precision NOT NULL,
    "oilDifferentialPercent" double precision NOT NULL,
    "gasDifferentialPercent" double precision NOT NULL,
    "nglDifferentialPercent" double precision NOT NULL,
    "fixedLoe" double precision,
    CONSTRAINT "royalty_by_play_pkey" PRIMARY KEY (aurora_id)
)
WITH (
    OIDS = FALSE
)
TABLESPACE pg_default;

ALTER TABLE mapping."mapping_by_play"
    OWNER to rseg_user;

GRANT ALL ON TABLE mapping."mapping_by_play" TO rseg_prism;

GRANT ALL ON TABLE mapping."mapping_by_play" TO rseg_user;


-- Table: mapping."mapping_by_play_op" --
CREATE TABLE mapping."mapping_by_play_op"
(
    aurora_id text COLLATE pg_catalog."default" NOT NULL,
    "playName" text COLLATE pg_catalog."default" NOT NULL,
    ticker text COLLATE pg_catalog."default" NOT NULL,
    "rrOilPercent" double precision NOT NULL,
    "rrGasPercent" double precision NOT NULL,
    "rrNglPercent" double precision NOT NULL,
    "oilDifferential" double precision NOT NULL,
    "gasDifferential" double precision NOT NULL,
    "nglDifferential" double precision NOT NULL,
    "oilDifferentialPercent" double precision NOT NULL,
    "gasDifferentialPercent" double precision NOT NULL,
    "nglDifferentialPercent" double precision NOT NULL,
    "fixedLoe" double precision,
    CONSTRAINT "mapping_by_play_op_pkey" PRIMARY KEY (aurora_id)
)
WITH (
    OIDS = FALSE
)
TABLESPACE pg_default;

ALTER TABLE mapping."mapping_by_play_op"
    OWNER to rseg_user;

GRANT ALL ON TABLE mapping."mapping_by_play_op" TO rseg_prism;

GRANT ALL ON TABLE mapping."mapping_by_play_op" TO rseg_user;


-- Table: mapping."mapping_by_region" --
CREATE TABLE mapping."mapping_by_region"
(
    "regionName" text COLLATE pg_catalog."default" NOT NULL,
    "rrOilPercent" double precision NOT NULL,
    "rrGasPercent" double precision NOT NULL,
    "rrNglPercent" double precision NOT NULL,
    aurora_id text COLLATE pg_catalog."default" NOT NULL,
    "oilDifferential" double precision NOT NULL,
    "gasDifferential" double precision NOT NULL,
    "nglDifferential" double precision NOT NULL,
    "oilDifferentialPercent" double precision NOT NULL,
    "gasDifferentialPercent" double precision NOT NULL,
    "nglDifferentialPercent" double precision NOT NULL,
    "fixedLoe" double precision,
    CONSTRAINT "royalty_by_region_pkey" PRIMARY KEY (aurora_id)
)
WITH (
    OIDS = FALSE
)
TABLESPACE pg_default;

ALTER TABLE mapping."mapping_by_region"
    OWNER to rseg_user;

GRANT ALL ON TABLE mapping."mapping_by_region" TO rseg_prism;

GRANT ALL ON TABLE mapping."mapping_by_region" TO rseg_user;


-- Table: mapping."mapping_by_state_county" --
CREATE TABLE mapping."mapping_by_state_county"
(
    aurora_id text COLLATE pg_catalog."default" NOT NULL,
    state text COLLATE pg_catalog."default" NOT NULL,
    county text COLLATE pg_catalog."default" NOT NULL,
    "sTaxOilPercent" double precision NOT NULL,
    "sTaxGasPercent" double precision NOT NULL,
    "sTaxNglPercent" double precision NOT NULL,
    CONSTRAINT "mapping_by_state_county_pkey" PRIMARY KEY (aurora_id)
)
WITH (
    OIDS = FALSE
)
TABLESPACE pg_default;

ALTER TABLE mapping."mapping_by_state_county"
    OWNER to rseg_user;

GRANT ALL ON TABLE mapping."mapping_by_state_county" TO rseg_prism;

GRANT ALL ON TABLE mapping."mapping_by_state_county" TO rseg_user;
