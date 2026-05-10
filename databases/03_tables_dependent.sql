-- ============================================
-- 03_tables_dependent.sql
-- Tables with foreign key dependencies
-- ============================================

CREATE TABLE public.advisor (
  id serial4 NOT NULL,
  user_id int4 NOT NULL,
  major_id int4 NULL,
  CONSTRAINT advisor_pk PRIMARY KEY (id),
  CONSTRAINT advisor_unique UNIQUE (user_id),
  CONSTRAINT advisor_major_fk FOREIGN KEY (major_id) REFERENCES public.major(id),
  CONSTRAINT advisor_user_fk FOREIGN KEY (user_id) REFERENCES public."user"(id)
);

CREATE TABLE public.appointment_visit (
  id serial4 NOT NULL,
  appointed_date date NOT NULL,
  created_at timestamp DEFAULT now() NOT NULL,
  approved_at timestamp NULL,
  is_completed bool DEFAULT false NOT NULL,
  advisor_id int4 NOT NULL,
  CONSTRAINT appointment_visit_pk PRIMARY KEY (id),
  CONSTRAINT appointment_visit_advisor_fk FOREIGN KEY (advisor_id) REFERENCES public.advisor(id)
);

CREATE TABLE public.assignment_submission (
  id serial4 NOT NULL,
  user_id int4 NOT NULL,
  upload_path varchar NOT NULL,
  created_at timestamp DEFAULT now() NOT NULL,
  assignment_id int4 NOT NULL,
  CONSTRAINT assignment_submission_pk PRIMARY KEY (id),
  CONSTRAINT assignment_submission_assignment_fk FOREIGN KEY (user_id) REFERENCES public."assignment"(id),
  CONSTRAINT assignment_submission_user_fk FOREIGN KEY (user_id) REFERENCES public."user"(id)
);

CREATE TABLE public.committee (
  id serial4 NOT NULL,
  user_id int4 NOT NULL,
  CONSTRAINT committee_pk PRIMARY KEY (id),
  CONSTRAINT committee_unique UNIQUE (user_id),
  CONSTRAINT committee_user_fk FOREIGN KEY (user_id) REFERENCES public."user"(id)
);

CREATE TABLE public.company_branch (
  id serial4 NOT NULL,
  company_id int4 NOT NULL,
  branch_name varchar NOT NULL,
  address text NOT NULL,
  subdistrict varchar NOT NULL,
  district varchar NOT NULL,
  province varchar NOT NULL,
  postal_code varchar NOT NULL,
  latitude varchar NOT NULL,
  longitude varchar NOT NULL,
  is_headquarter bool DEFAULT false NOT NULL,
  CONSTRAINT company_branch_pk PRIMARY KEY (id),
  CONSTRAINT company_branch_company_fk FOREIGN KEY (company_id) REFERENCES public.company(id) ON UPDATE CASCADE
);

CREATE TABLE public.contact (
  id serial4 NOT NULL,
  branch_id int4 NOT NULL,
  email varchar NULL,
  phone varchar NULL,
  department varchar NULL,
  job_title varchar NULL,
  created_at timestamp DEFAULT now() NOT NULL,
  prefixname varchar NOT NULL,
  firstname varchar NOT NULL,
  lastname varchar NOT NULL,
  CONSTRAINT contact_pk PRIMARY KEY (id),
  CONSTRAINT contact_company_branch_fk FOREIGN KEY (branch_id) REFERENCES public.company_branch(id)
);

CREATE TABLE public.exam_committee (
  id serial4 NOT NULL,
  appointment_id int4 NOT NULL,
  committee_id int4 NOT NULL,
  CONSTRAINT exam_committee_pk PRIMARY KEY (id),
  CONSTRAINT exam_committee_appointment_exam_fk FOREIGN KEY (appointment_id) REFERENCES public.appointment_exam(id),
  CONSTRAINT exam_committee_committee_fk FOREIGN KEY (committee_id) REFERENCES public.committee(id)
);

CREATE TABLE public.forms_question (
  id serial4 NOT NULL,
  forms_id int4 NOT NULL,
  created_at timestamp DEFAULT now() NOT NULL,
  question varchar NOT NULL,
  is_required bool NOT NULL,
  input_type varchar NOT NULL,
  input_min int4 NULL,
  input_max int4 NULL,
  "order" int4 NULL,
  description varchar NULL,
  CONSTRAINT forms_question_pk PRIMARY KEY (id),
  CONSTRAINT forms_question_forms_fk FOREIGN KEY (forms_id) REFERENCES public.forms(id)
);

CREATE TABLE public.forms_submission (
  id serial4 NOT NULL,
  forms_id int4 NOT NULL,
  user_id int4 NULL,
  "token" varchar NULL,
  submitted_at timestamp NOT NULL,
  CONSTRAINT forms_submission_pk PRIMARY KEY (id),
  CONSTRAINT forms_submission_forms_fk FOREIGN KEY (forms_id) REFERENCES public.forms(id),
  CONSTRAINT forms_submission_user_fk FOREIGN KEY (user_id) REFERENCES public."user"(id)
);

CREATE TABLE public.staff (
  id serial4 NOT NULL,
  user_id int4 NOT NULL,
  CONSTRAINT staff_pk PRIMARY KEY (id),
  CONSTRAINT staff_unique UNIQUE (user_id),
  CONSTRAINT staff_user_fk FOREIGN KEY (user_id) REFERENCES public."user"(id)
);

CREATE TABLE public.student (
  id serial4 NOT NULL,
  user_id int4 NOT NULL,
  student_number int4 NOT NULL,
  "year" int4 NULL,
  gpax float4 NULL,
  major_id int4 NULL,
  academic_year int4 NOT NULL,
  CONSTRAINT student_gpax_check CHECK (((gpax >= (0.00)::double precision) AND (gpax <= (4.00)::double precision))),
  CONSTRAINT student_pk PRIMARY KEY (id),
  CONSTRAINT student_unique UNIQUE (student_number),
  CONSTRAINT student_unique_1 UNIQUE (user_id),
  CONSTRAINT student_academic_year_fk FOREIGN KEY ("year") REFERENCES public.academic_year("year"),
  CONSTRAINT student_major_fk FOREIGN KEY (major_id) REFERENCES public.major(id),
  CONSTRAINT student_user_fk FOREIGN KEY (user_id) REFERENCES public."user"(id) ON UPDATE CASCADE
);

CREATE TABLE public.forms_answer (
  id serial4 NOT NULL,
  submission_id int4 NOT NULL,
  question_id int4 NOT NULL,
  answer varchar NOT NULL,
  subanswer varchar NULL,
  CONSTRAINT forms_answer_pk PRIMARY KEY (id),
  CONSTRAINT forms_answer_forms_question_fk FOREIGN KEY (question_id) REFERENCES public.forms_question(id),
  CONSTRAINT forms_answer_forms_submission_fk FOREIGN KEY (submission_id) REFERENCES public.forms_submission(id)
);

CREATE TABLE public.internship (
  id serial4 NOT NULL,
  student_id int4 NOT NULL,
  branch_id int4 NOT NULL,
  start_date date NOT NULL,
  end_date date NOT NULL,
  hr_contact int4 NOT NULL,
  mentor_contact int4 NULL,
  academic_year int4 NOT NULL,
  recipient_name varchar NULL,
  email_sent timestamp NULL,
  company_replied timestamp NULL,
  status public."internship_status" NOT NULL,
  created_at timestamp DEFAULT now() NOT NULL,
  position_title varchar NOT NULL,
  CONSTRAINT internship_pk PRIMARY KEY (id),
  CONSTRAINT internship_academic_year_fk FOREIGN KEY (academic_year) REFERENCES public.academic_year("year"),
  CONSTRAINT internship_company_branch_fk FOREIGN KEY (branch_id) REFERENCES public.company_branch(id),
  CONSTRAINT internship_contact_fk FOREIGN KEY (hr_contact) REFERENCES public.contact(id),
  CONSTRAINT internship_contact_fk_1 FOREIGN KEY (mentor_contact) REFERENCES public.contact(id),
  CONSTRAINT internship_student_fk FOREIGN KEY (student_id) REFERENCES public.student(id)
);

CREATE TABLE public.visit_group (
  id serial4 NOT NULL,
  appointment_id int4 NOT NULL,
  internship_id int4 NOT NULL,
  CONSTRAINT visit_group_pk PRIMARY KEY (id),
  CONSTRAINT visit_group_unique UNIQUE (internship_id),
  CONSTRAINT visit_group_appointment_visit_fk FOREIGN KEY (appointment_id) REFERENCES public.appointment_visit(id),
  CONSTRAINT visit_group_internship_fk FOREIGN KEY (internship_id) REFERENCES public.internship(id)
);

CREATE TABLE public.exam_group (
  id serial4 NOT NULL,
  appointment_id int4 NOT NULL,
  internship_id int4 NOT NULL,
  CONSTRAINT exam_group_pk PRIMARY KEY (id),
  CONSTRAINT exam_group_unique UNIQUE (internship_id),
  CONSTRAINT exam_group_appointment_exam_fk FOREIGN KEY (appointment_id) REFERENCES public.appointment_exam(id),
  CONSTRAINT exam_group_internship_fk FOREIGN KEY (internship_id) REFERENCES public.internship(id)
);