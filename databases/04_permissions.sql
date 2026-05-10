-- ============================================
-- 04_permissions.sql
-- Owner & Grant permissions for all tables
-- ============================================

ALTER TABLE public.academic_year OWNER TO wil;
ALTER TABLE public.appointment_exam OWNER TO wil;
ALTER TABLE public."assignment" OWNER TO wil;
ALTER TABLE public.company OWNER TO wil;
ALTER TABLE public.forms OWNER TO wil;
ALTER TABLE public.major OWNER TO wil;
ALTER TABLE public."user" OWNER TO wil;
ALTER TABLE public.advisor OWNER TO wil;
ALTER TABLE public.appointment_visit OWNER TO wil;
ALTER TABLE public.assignment_submission OWNER TO wil;
ALTER TABLE public.committee OWNER TO wil;
ALTER TABLE public.company_branch OWNER TO wil;
ALTER TABLE public.contact OWNER TO wil;
ALTER TABLE public.exam_committee OWNER TO wil;
ALTER TABLE public.forms_question OWNER TO wil;
ALTER TABLE public.forms_submission OWNER TO wil;
ALTER TABLE public.staff OWNER TO wil;
ALTER TABLE public.student OWNER TO wil;
ALTER TABLE public.forms_answer OWNER TO wil;
ALTER TABLE public.internship OWNER TO wil;
ALTER TABLE public.visit_group OWNER TO wil;
ALTER TABLE public.exam_group OWNER TO wil;

GRANT ALL ON TABLE public.academic_year TO wil;
GRANT ALL ON TABLE public.appointment_exam TO wil;
GRANT ALL ON TABLE public."assignment" TO wil;
GRANT ALL ON TABLE public.company TO wil;
GRANT ALL ON TABLE public.forms TO wil;
GRANT ALL ON TABLE public.major TO wil;
GRANT ALL ON TABLE public."user" TO wil;
GRANT ALL ON TABLE public.advisor TO wil;
GRANT ALL ON TABLE public.appointment_visit TO wil;
GRANT ALL ON TABLE public.assignment_submission TO wil;
GRANT ALL ON TABLE public.committee TO wil;
GRANT ALL ON TABLE public.company_branch TO wil;
GRANT ALL ON TABLE public.contact TO wil;
GRANT ALL ON TABLE public.exam_committee TO wil;
GRANT ALL ON TABLE public.forms_question TO wil;
GRANT ALL ON TABLE public.forms_submission TO wil;
GRANT ALL ON TABLE public.staff TO wil;
GRANT ALL ON TABLE public.student TO wil;
GRANT ALL ON TABLE public.forms_answer TO wil;
GRANT ALL ON TABLE public.internship TO wil;
GRANT ALL ON TABLE public.visit_group TO wil;
GRANT ALL ON TABLE public.exam_group TO wil;

GRANT ALL ON SCHEMA public TO pg_database_owner;