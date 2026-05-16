-- ============================================
-- 02_tables_independent.sql
-- Tables with no foreign key dependencies
-- ============================================

CREATE TABLE public.academic_year (
  "year" int4 NOT NULL,
  is_active bool DEFAULT false NOT NULL,
  CONSTRAINT newtable_pk PRIMARY KEY (year)
);

CREATE UNIQUE INDEX single_active_academic_year
  ON public.academic_year USING btree (is_active)
  WHERE (is_active = true);

CREATE TABLE public.appointment_exam (
  id serial4 NOT NULL,
  appointed_date date NOT NULL,
  created_at timestamp DEFAULT now() NOT NULL,
  approved_at timestamp NULL,
  CONSTRAINT appointment_exam_pk PRIMARY KEY (id)
);

CREATE TABLE public."assignment" (
  id serial4 NOT NULL,
  title varchar NOT NULL,
  description text NULL,
  download_path varchar NULL,
  created_at timestamp DEFAULT now() NOT NULL,
  assignment_id int4 NOT NULL,
  is_active bool NULL,
  CONSTRAINT assignment_pk PRIMARY KEY (id)
);

CREATE TABLE public.company (
  id serial4 NOT NULL,
  "name" varchar NOT NULL,
  active bool DEFAULT true NULL,
  created_at timestamp DEFAULT now() NOT NULL,
  name_english varchar NULL,
  CONSTRAINT company_pk PRIMARY KEY (id),
  CONSTRAINT company_unique UNIQUE (name)
);

CREATE TABLE public.forms (
  id serial4 NOT NULL,
  forms_name varchar NOT NULL,
  forms_description text NULL,
  created_at timestamp DEFAULT now() NOT NULL,
  current_revision varchar DEFAULT '1'::character varying NOT NULL,
  is_active bool DEFAULT true NOT NULL,
  CONSTRAINT forms_pk PRIMARY KEY (id)
);

CREATE TABLE public.major (
  id serial4 NOT NULL,
  faculty varchar NULL,
  department varchar NULL,
  major varchar NULL,
  created timestamp DEFAULT now() NOT NULL,
  description text NULL,
  CONSTRAINT major_pk PRIMARY KEY (id),
  CONSTRAINT major_unique UNIQUE (faculty, department, major)
);

CREATE TABLE public."user" (
  id serial4 NOT NULL,
  email varchar NOT NULL,
  "password" varchar NULL,
  "role" public."user_role" NULL,
  is_active bool DEFAULT true NOT NULL,
  created_at timestamp DEFAULT now() NOT NULL,
  firstname varchar NOT NULL,
  lastname varchar NOT NULL,
  prefixname varchar NOT NULL,
  image text NULL,
  phone varchar NULL,
  CONSTRAINT user_pk PRIMARY KEY (id),
  CONSTRAINT user_unique UNIQUE (email)
);