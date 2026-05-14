-- ============================================
-- 01_enums.sql
-- ENUM Types
-- ============================================

CREATE TYPE public."internship_status" AS ENUM (
  'awaiting_recheck',
  'awaiting_response',
  'employed',
  'awaiting_edit'
);

CREATE TYPE public."user_role" AS ENUM (
  'student',
  'staff',
  'advisor',
  'mentor',
  'hr'
);