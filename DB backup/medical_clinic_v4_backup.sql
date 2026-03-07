--
-- PostgreSQL database dump
--

\restrict 9WbhatwXflEpGH8kRYCS0ieth8VgU8RbNdzrXheJ3alKvPdgw44Yaad0iE3RUF6

-- Dumped from database version 14.20 (Ubuntu 14.20-0ubuntu0.22.04.1)
-- Dumped by pg_dump version 14.20 (Ubuntu 14.20-0ubuntu0.22.04.1)

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: uuid-ossp; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS "uuid-ossp" WITH SCHEMA public;


--
-- Name: EXTENSION "uuid-ossp"; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON EXTENSION "uuid-ossp" IS 'generate universally unique identifiers (UUIDs)';


--
-- Name: AccountRequestStatus; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE public."AccountRequestStatus" AS ENUM (
    'PENDING',
    'APPROVED',
    'REJECTED'
);


--
-- Name: AccountRequestType; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE public."AccountRequestType" AS ENUM (
    'CREATE_ACCOUNT',
    'ADD_CREDIT',
    'ADD_DEPOSIT',
    'RETURN_MONEY'
);


--
-- Name: AccountStatus; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE public."AccountStatus" AS ENUM (
    'PENDING',
    'VERIFIED',
    'REJECTED'
);


--
-- Name: AccountTransactionType; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE public."AccountTransactionType" AS ENUM (
    'DEPOSIT',
    'PAYMENT',
    'USAGE',
    'DEDUCTION',
    'ADJUSTMENT',
    'DEBT'
);


--
-- Name: AccountType; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE public."AccountType" AS ENUM (
    'ADVANCE',
    'CREDIT',
    'NONE',
    'BOTH'
);


--
-- Name: AdmissionStatus; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE public."AdmissionStatus" AS ENUM (
    'PENDING_PAYMENT',
    'ADMITTED',
    'DISCHARGED',
    'CANCELLED'
);


--
-- Name: AppointmentStatus; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE public."AppointmentStatus" AS ENUM (
    'SCHEDULED',
    'ARRIVED',
    'IN_PROGRESS',
    'COMPLETED',
    'CANCELLED',
    'NO_SHOW'
);


--
-- Name: AppointmentType; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE public."AppointmentType" AS ENUM (
    'CONSULTATION',
    'FOLLOW_UP'
);


--
-- Name: BatchOrderType; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE public."BatchOrderType" AS ENUM (
    'LAB',
    'RADIOLOGY',
    'MIXED',
    'DENTAL',
    'PROCEDURE'
);


--
-- Name: BedStatus; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE public."BedStatus" AS ENUM (
    'AVAILABLE',
    'OCCUPIED',
    'MAINTENANCE',
    'CLEANING'
);


--
-- Name: BillingStatus; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE public."BillingStatus" AS ENUM (
    'PENDING',
    'PAID',
    'PENDING_INSURANCE',
    'INSURANCE_CLAIMED',
    'EMERGENCY_PENDING',
    'REJECTED',
    'REFUNDED',
    'PARTIALLY_PAID'
);


--
-- Name: BillingType; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE public."BillingType" AS ENUM (
    'REGULAR',
    'EMERGENCY',
    'CARD_ACTIVATION',
    'ACCOMMODATION'
);


--
-- Name: BloodType; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE public."BloodType" AS ENUM (
    'A_PLUS',
    'A_MINUS',
    'B_PLUS',
    'B_MINUS',
    'AB_PLUS',
    'AB_MINUS',
    'O_PLUS',
    'O_MINUS',
    'UNKNOWN'
);


--
-- Name: CardStatus; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE public."CardStatus" AS ENUM (
    'ACTIVE',
    'INACTIVE',
    'EXPIRED'
);


--
-- Name: CardType; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE public."CardType" AS ENUM (
    'GENERAL',
    'DERMATOLOGY'
);


--
-- Name: CashSessionStatus; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE public."CashSessionStatus" AS ENUM (
    'ACTIVE',
    'CLOSED',
    'RESET'
);


--
-- Name: CertificateStatus; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE public."CertificateStatus" AS ENUM (
    'ACTIVE',
    'EXPIRED',
    'CANCELLED'
);


--
-- Name: DepositStatus; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE public."DepositStatus" AS ENUM (
    'PENDING',
    'CONFIRMED',
    'VERIFIED'
);


--
-- Name: DiagnosisStatus; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE public."DiagnosisStatus" AS ENUM (
    'ACTIVE',
    'RESOLVED',
    'RULED_OUT'
);


--
-- Name: DiagnosisType; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE public."DiagnosisType" AS ENUM (
    'CLINICAL',
    'CONFIRMED',
    'SUSPECTED'
);


--
-- Name: DispensedStatus; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE public."DispensedStatus" AS ENUM (
    'DISPENSED',
    'NOT_AVAILABLE',
    'PARTIAL_DISPENSED'
);


--
-- Name: ExpenseCategory; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE public."ExpenseCategory" AS ENUM (
    'OFFICE_SUPPLIES',
    'MEDICAL_SUPPLIES',
    'MAINTENANCE',
    'UTILITIES',
    'FOOD_BEVERAGE',
    'TRANSPORTATION',
    'STAFF_LOAN',
    'OTHER'
);


--
-- Name: Gender; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE public."Gender" AS ENUM (
    'MALE',
    'FEMALE',
    'OTHER'
);


--
-- Name: ImageType; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE public."ImageType" AS ENUM (
    'BEFORE',
    'AFTER',
    'OTHER'
);


--
-- Name: InsuranceServiceType; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE public."InsuranceServiceType" AS ENUM (
    'CONSULTATION',
    'LAB_TEST',
    'RADIOLOGY',
    'MEDICATION',
    'PROCEDURE',
    'NURSE_SERVICE',
    'OTHER'
);


--
-- Name: InsuranceTransactionStatus; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE public."InsuranceTransactionStatus" AS ENUM (
    'PENDING',
    'SUBMITTED',
    'APPROVED',
    'COLLECTED',
    'REJECTED'
);


--
-- Name: InvestigationCategory; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE public."InvestigationCategory" AS ENUM (
    'LAB',
    'RADIOLOGY'
);


--
-- Name: LoanSettlementMethod; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE public."LoanSettlementMethod" AS ENUM (
    'INSTANT_PAID',
    'FROM_PAYROLL'
);


--
-- Name: LoanStatus; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE public."LoanStatus" AS ENUM (
    'PENDING',
    'APPROVED',
    'DENIED',
    'GIVEN',
    'SETTLED',
    'SETTLEMENT_ACCEPTED',
    'REPAID'
);


--
-- Name: MaritalStatus; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE public."MaritalStatus" AS ENUM (
    'SINGLE',
    'MARRIED',
    'DIVORCED',
    'WIDOWED'
);


--
-- Name: MedicineCategory; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE public."MedicineCategory" AS ENUM (
    'TABLETS',
    'CAPSULES',
    'INJECTIONS',
    'SYRUPS',
    'OINTMENTS',
    'DROPS',
    'INHALERS',
    'PATCHES',
    'INFUSIONS'
);


--
-- Name: NurseServiceStatus; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE public."NurseServiceStatus" AS ENUM (
    'PENDING',
    'IN_PROGRESS',
    'COMPLETED',
    'CANCELLED',
    'DEFERRED'
);


--
-- Name: OrderStatus; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE public."OrderStatus" AS ENUM (
    'UNPAID',
    'PAID',
    'BLOCKED_BY_BILL',
    'QUEUED',
    'IN_PROGRESS',
    'COMPLETED',
    'CANCELLED',
    'VERIFIED',
    'DEFERRED'
);


--
-- Name: PatientStatus; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE public."PatientStatus" AS ENUM (
    'Active',
    'Inactive',
    'Completed'
);


--
-- Name: PatientType; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE public."PatientType" AS ENUM (
    'REGULAR',
    'VIP',
    'EMERGENCY',
    'INSURANCE'
);


--
-- Name: PaymentType; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE public."PaymentType" AS ENUM (
    'CASH',
    'BANK',
    'INSURANCE',
    'CHARITY',
    'CREDIT'
);


--
-- Name: PharmacyInvoiceType; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE public."PharmacyInvoiceType" AS ENUM (
    'DOCTOR_PRESCRIPTION',
    'WALK_IN_SALE'
);


--
-- Name: PhotoType; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE public."PhotoType" AS ENUM (
    'BEFORE',
    'AFTER'
);


--
-- Name: QueueType; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE public."QueueType" AS ENUM (
    'CONSULTATION',
    'RESULTS_REVIEW'
);


--
-- Name: Role; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE public."Role" AS ENUM (
    'ADMIN',
    'OWNER',
    'BILLING_OFFICER',
    'PHARMACY_BILLING_OFFICER',
    'CARE_COORDINATOR',
    'CMO',
    'CLINICAL_RESEARCH_COORDINATOR',
    'DIETITIAN',
    'DOCTOR',
    'HOSPITAL_MANAGER',
    'HR_OFFICER',
    'IT_SUPPORT',
    'LAB_TECHNICIAN',
    'MEDICAL_RECORDS_OFFICER',
    'NURSE',
    'PATIENT',
    'PHARMACY_OFFICER',
    'PHARMACIST',
    'RADIOLOGIST',
    'RECEPTIONIST',
    'SECURITY_STAFF',
    'SOCIAL_WORKER'
);


--
-- Name: ServiceCategory; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE public."ServiceCategory" AS ENUM (
    'CONSULTATION',
    'LAB',
    'RADIOLOGY',
    'MEDICATION',
    'PROCEDURE',
    'NURSE',
    'DENTAL',
    'CONTINUOUS_INFUSION',
    'EMERGENCY',
    'DIAGNOSTIC',
    'TREATMENT',
    'OTHER',
    'NURSE_WALKIN',
    'EMERGENCY_DRUG',
    'MATERIAL_NEEDS',
    'DOCTOR_WALKIN',
    'ACCOMMODATION'
);


--
-- Name: TempUnit; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE public."TempUnit" AS ENUM (
    'C',
    'F'
);


--
-- Name: TransactionType; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE public."TransactionType" AS ENUM (
    'PAYMENT_RECEIVED',
    'REFUND_GIVEN',
    'CASH_ADJUSTMENT',
    'OTHER'
);


--
-- Name: VirtualQueueStatus; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE public."VirtualQueueStatus" AS ENUM (
    'PENDING',
    'PROCESSING',
    'COMPLETED',
    'CANCELLED'
);


--
-- Name: VisitStatus; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE public."VisitStatus" AS ENUM (
    'WAITING_FOR_TRIAGE',
    'TRIAGED',
    'WAITING_FOR_DOCTOR',
    'IN_DOCTOR_QUEUE',
    'UNDER_DOCTOR_REVIEW',
    'SENT_TO_LAB',
    'SENT_TO_RADIOLOGY',
    'SENT_TO_BOTH',
    'RETURNED_WITH_RESULTS',
    'AWAITING_LAB_RESULTS',
    'AWAITING_RADIOLOGY_RESULTS',
    'AWAITING_RESULTS_REVIEW',
    'DIRECT_COMPLETE',
    'SENT_TO_PHARMACY',
    'WAITING_FOR_NURSE_SERVICE',
    'NURSE_SERVICES_ORDERED',
    'NURSE_SERVICES_COMPLETED',
    'DENTAL_SERVICES_ORDERED',
    'EMERGENCY_QUEUE',
    'IN_PROGRESS',
    'COMPLETED',
    'CANCELLED',
    'PROCEDURE_SERVICES_ORDERED',
    'PROCEDURE_SERVICES_COMPLETED'
);


SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: AccountDeposit; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public."AccountDeposit" (
    id text NOT NULL,
    "accountId" text NOT NULL,
    "patientId" text NOT NULL,
    amount double precision NOT NULL,
    "paymentMethod" public."PaymentType" NOT NULL,
    "bankName" text,
    "transNumber" text,
    notes text,
    "depositedById" text NOT NULL,
    "createdAt" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


--
-- Name: AccountRequest; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public."AccountRequest" (
    id text NOT NULL,
    "accountId" text,
    "patientId" text NOT NULL,
    "requestType" public."AccountRequestType" NOT NULL,
    "accountType" public."AccountType",
    amount double precision,
    "paymentMethod" public."PaymentType",
    "bankName" text,
    "transNumber" text,
    notes text,
    status public."AccountRequestStatus" DEFAULT 'PENDING'::public."AccountRequestStatus" NOT NULL,
    "requestedById" text NOT NULL,
    "verifiedById" text,
    "verifiedAt" timestamp(3) without time zone,
    "rejectionReason" text,
    "createdAt" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "updatedAt" timestamp(3) without time zone NOT NULL
);


--
-- Name: AccountTransaction; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public."AccountTransaction" (
    id text NOT NULL,
    "accountId" text NOT NULL,
    "patientId" text NOT NULL,
    type public."AccountTransactionType" NOT NULL,
    amount double precision NOT NULL,
    "balanceBefore" double precision NOT NULL,
    "balanceAfter" double precision NOT NULL,
    notes text,
    description text,
    "billingId" text,
    "visitId" integer,
    "processedById" text NOT NULL,
    "createdAt" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "subAccount" text
);


--
-- Name: Admission; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public."Admission" (
    id text NOT NULL,
    "patientId" text NOT NULL,
    "bedId" text NOT NULL,
    "visitId" integer,
    "admittedById" text NOT NULL,
    "startDate" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "expectedEndDate" timestamp(3) without time zone NOT NULL,
    "actualEndDate" timestamp(3) without time zone,
    status public."AdmissionStatus" DEFAULT 'ADMITTED'::public."AdmissionStatus" NOT NULL,
    notes text,
    "createdAt" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "updatedAt" timestamp(3) without time zone NOT NULL,
    "billingId" text
);


--
-- Name: AdmissionService; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public."AdmissionService" (
    id text NOT NULL,
    "admissionId" text NOT NULL,
    "serviceId" text NOT NULL,
    "orderedById" text NOT NULL,
    quantity integer DEFAULT 1 NOT NULL,
    "unitPrice" double precision NOT NULL,
    "totalPrice" double precision NOT NULL,
    status text DEFAULT 'PENDING'::text NOT NULL,
    "billingId" text,
    notes text,
    "createdAt" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "updatedAt" timestamp(3) without time zone NOT NULL
);


--
-- Name: Appointment; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public."Appointment" (
    id integer NOT NULL,
    "patientId" text NOT NULL,
    "doctorId" text NOT NULL,
    "appointmentDate" timestamp(3) without time zone NOT NULL,
    "appointmentTime" text NOT NULL,
    type public."AppointmentType" DEFAULT 'CONSULTATION'::public."AppointmentType" NOT NULL,
    status public."AppointmentStatus" DEFAULT 'SCHEDULED'::public."AppointmentStatus" NOT NULL,
    duration text,
    notes text,
    reason text,
    "createdById" text NOT NULL,
    "lastDiagnosedBy" text,
    "visitId" integer,
    "createdAt" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "updatedAt" timestamp(3) without time zone NOT NULL
);


--
-- Name: Appointment_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public."Appointment_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: Appointment_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public."Appointment_id_seq" OWNED BY public."Appointment".id;


--
-- Name: Assignment; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public."Assignment" (
    id integer NOT NULL,
    "patientId" text NOT NULL,
    "doctorId" text NOT NULL,
    status text DEFAULT 'Pending'::text NOT NULL,
    "createdAt" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "updatedAt" timestamp(3) without time zone NOT NULL
);


--
-- Name: Assignment_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public."Assignment_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: Assignment_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public."Assignment_id_seq" OWNED BY public."Assignment".id;


--
-- Name: AuditLog; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public."AuditLog" (
    id integer NOT NULL,
    "userId" text,
    action text NOT NULL,
    entity text NOT NULL,
    "entityId" integer NOT NULL,
    details text NOT NULL,
    ip text,
    "userAgent" text,
    "createdAt" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


--
-- Name: AuditLog_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public."AuditLog_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: AuditLog_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public."AuditLog_id_seq" OWNED BY public."AuditLog".id;


--
-- Name: BankDeposit; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public."BankDeposit" (
    id text NOT NULL,
    "sessionId" text NOT NULL,
    amount double precision NOT NULL,
    "bankName" text NOT NULL,
    "accountNumber" text,
    "depositDate" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "receiptImage" text,
    "transactionNumber" text,
    notes text,
    status public."DepositStatus" DEFAULT 'PENDING'::public."DepositStatus" NOT NULL,
    "depositedById" text NOT NULL,
    "createdAt" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "updatedAt" timestamp(3) without time zone NOT NULL
);


--
-- Name: BatchOrder; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public."BatchOrder" (
    id integer NOT NULL,
    "visitId" integer NOT NULL,
    "patientId" text NOT NULL,
    "doctorId" text NOT NULL,
    type public."BatchOrderType" NOT NULL,
    status public."OrderStatus" DEFAULT 'UNPAID'::public."OrderStatus" NOT NULL,
    instructions text,
    result text,
    "additionalNotes" text,
    "createdAt" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "updatedAt" timestamp(3) without time zone NOT NULL,
    "isDeferred" boolean DEFAULT false NOT NULL
);


--
-- Name: BatchOrderService; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public."BatchOrderService" (
    id integer NOT NULL,
    "batchOrderId" integer NOT NULL,
    "serviceId" text NOT NULL,
    "investigationTypeId" integer,
    instructions text,
    result text,
    status public."OrderStatus" DEFAULT 'UNPAID'::public."OrderStatus" NOT NULL,
    "isWaived" boolean DEFAULT false NOT NULL,
    "waivedBy" text,
    "waivedAt" timestamp(3) without time zone,
    "createdAt" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "updatedAt" timestamp(3) without time zone NOT NULL,
    "customPrice" double precision
);


--
-- Name: BatchOrderService_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public."BatchOrderService_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: BatchOrderService_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public."BatchOrderService_id_seq" OWNED BY public."BatchOrderService".id;


--
-- Name: BatchOrder_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public."BatchOrder_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: BatchOrder_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public."BatchOrder_id_seq" OWNED BY public."BatchOrder".id;


--
-- Name: Bed; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public."Bed" (
    id text NOT NULL,
    name text NOT NULL,
    code text NOT NULL,
    price double precision NOT NULL,
    type text,
    status public."BedStatus" DEFAULT 'AVAILABLE'::public."BedStatus" NOT NULL,
    "createdAt" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "updatedAt" timestamp(3) without time zone NOT NULL
);


--
-- Name: BillPayment; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public."BillPayment" (
    id text NOT NULL,
    "billingId" text NOT NULL,
    "patientId" text NOT NULL,
    amount double precision NOT NULL,
    type public."PaymentType" NOT NULL,
    "bankName" text,
    "transNumber" text,
    "insuranceId" text,
    notes text,
    "createdAt" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "updatedAt" timestamp(3) without time zone NOT NULL
);


--
-- Name: Billing; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public."Billing" (
    id text NOT NULL,
    "patientId" text NOT NULL,
    "visitId" integer,
    "insuranceId" text,
    "totalAmount" double precision NOT NULL,
    status public."BillingStatus" DEFAULT 'PENDING'::public."BillingStatus" NOT NULL,
    "billingType" public."BillingType" DEFAULT 'REGULAR'::public."BillingType" NOT NULL,
    notes text,
    "createdAt" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "updatedAt" timestamp(3) without time zone NOT NULL,
    discount double precision DEFAULT 0 NOT NULL,
    "isDeferred" boolean DEFAULT false NOT NULL,
    "paidAmount" double precision DEFAULT 0 NOT NULL
);


--
-- Name: BillingService; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public."BillingService" (
    id text NOT NULL,
    "billingId" text NOT NULL,
    "serviceId" text NOT NULL,
    quantity integer DEFAULT 1 NOT NULL,
    "unitPrice" double precision NOT NULL,
    "totalPrice" double precision NOT NULL,
    "createdAt" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


--
-- Name: CardActivation; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public."CardActivation" (
    id integer NOT NULL,
    "patientId" text NOT NULL,
    "activatedById" text NOT NULL,
    "activatedAt" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "expiresAt" timestamp(3) without time zone NOT NULL,
    "billingId" text,
    notes text,
    "createdAt" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


--
-- Name: CardActivation_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public."CardActivation_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: CardActivation_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public."CardActivation_id_seq" OWNED BY public."CardActivation".id;


--
-- Name: CashExpense; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public."CashExpense" (
    id text NOT NULL,
    "sessionId" text NOT NULL,
    amount double precision NOT NULL,
    category public."ExpenseCategory" NOT NULL,
    description text NOT NULL,
    vendor text,
    "receiptImage" text,
    "recordedById" text NOT NULL,
    "createdAt" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


--
-- Name: CashTransaction; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public."CashTransaction" (
    id text NOT NULL,
    "sessionId" text NOT NULL,
    type public."TransactionType" NOT NULL,
    amount double precision NOT NULL,
    description text NOT NULL,
    "paymentMethod" public."PaymentType" NOT NULL,
    "billingId" text,
    "patientId" text,
    "processedById" text NOT NULL,
    "createdAt" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


--
-- Name: CompoundIngredient; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public."CompoundIngredient" (
    id integer NOT NULL,
    "compoundPrescriptionId" integer NOT NULL,
    "ingredientName" text NOT NULL,
    strength double precision NOT NULL,
    unit text NOT NULL,
    "isManualEntry" boolean DEFAULT false NOT NULL,
    cost double precision,
    "sortOrder" integer DEFAULT 0 NOT NULL
);


--
-- Name: CompoundIngredient_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public."CompoundIngredient_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: CompoundIngredient_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public."CompoundIngredient_id_seq" OWNED BY public."CompoundIngredient".id;


--
-- Name: CompoundPrescription; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public."CompoundPrescription" (
    id integer NOT NULL,
    "visitId" integer NOT NULL,
    "patientId" text NOT NULL,
    "doctorId" text NOT NULL,
    "formulationType" text NOT NULL,
    "baseType" text,
    "customBase" text,
    quantity integer NOT NULL,
    "quantityUnit" text NOT NULL,
    "frequencyType" text,
    "frequencyValue" text,
    "durationValue" double precision,
    "durationUnit" text,
    instructions text,
    "storageInstructions" text,
    warnings text,
    "pharmacyNotes" text,
    "totalCost" double precision,
    "referenceNumber" text NOT NULL,
    "preparedBy" text,
    "preparedAt" timestamp(3) without time zone,
    "expiryDate" timestamp(3) without time zone,
    "createdAt" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "updatedAt" timestamp(3) without time zone NOT NULL
);


--
-- Name: CompoundPrescription_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public."CompoundPrescription_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: CompoundPrescription_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public."CompoundPrescription_id_seq" OWNED BY public."CompoundPrescription".id;


--
-- Name: ContinuousInfusion; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public."ContinuousInfusion" (
    id integer NOT NULL,
    "medicationOrderId" integer NOT NULL,
    "startDate" timestamp(3) without time zone NOT NULL,
    "endDate" timestamp(3) without time zone NOT NULL,
    "dailyDose" text NOT NULL,
    frequency text,
    days integer NOT NULL,
    status public."OrderStatus" DEFAULT 'UNPAID'::public."OrderStatus" NOT NULL,
    "createdAt" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "updatedAt" timestamp(3) without time zone NOT NULL
);


--
-- Name: ContinuousInfusion_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public."ContinuousInfusion_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: ContinuousInfusion_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public."ContinuousInfusion_id_seq" OWNED BY public."ContinuousInfusion".id;


--
-- Name: CustomMedication; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public."CustomMedication" (
    id text NOT NULL,
    "doctorId" text NOT NULL,
    name text NOT NULL,
    "genericName" text,
    "dosageForm" text NOT NULL,
    strength text NOT NULL,
    quantity text,
    route text,
    instructions text,
    "frequencyPeriod" text,
    "durationPeriod" text,
    category text,
    "createdAt" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "updatedAt" timestamp(3) without time zone NOT NULL,
    "atcCode" text,
    "deletedAt" timestamp(3) without time zone,
    "dosageFormCategory" text,
    "durationText" text,
    "durationUnit" text,
    "durationValue" double precision,
    "frequencyText" text,
    "frequencyType" text,
    "frequencyUnit" text,
    "frequencyValue" double precision,
    "isDeleted" boolean DEFAULT false NOT NULL,
    "normalizedName" text,
    "routeCode" text,
    "rxnormCode" text,
    "snomedCode" text,
    "strengthText" text
);


--
-- Name: DailyCashSession; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public."DailyCashSession" (
    id text NOT NULL,
    "sessionDate" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "startTime" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "endTime" timestamp(3) without time zone,
    "startingCash" double precision DEFAULT 0 NOT NULL,
    "totalReceived" double precision DEFAULT 0 NOT NULL,
    "totalExpenses" double precision DEFAULT 0 NOT NULL,
    "totalBankDeposit" double precision DEFAULT 0 NOT NULL,
    "endingCash" double precision,
    status public."CashSessionStatus" DEFAULT 'ACTIVE'::public."CashSessionStatus" NOT NULL,
    "isReset" boolean DEFAULT false NOT NULL,
    "createdById" text NOT NULL,
    "resetById" text,
    "resetAt" timestamp(3) without time zone,
    "createdAt" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "updatedAt" timestamp(3) without time zone NOT NULL
);


--
-- Name: DentalPhoto; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public."DentalPhoto" (
    id text NOT NULL,
    "visitId" integer NOT NULL,
    "patientId" text NOT NULL,
    "doctorId" text NOT NULL,
    "photoType" public."PhotoType" NOT NULL,
    "filePath" text NOT NULL,
    "fileName" text NOT NULL,
    "fileSize" integer,
    "mimeType" text NOT NULL,
    description text,
    "uploadedAt" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "uploadedBy" text NOT NULL
);


--
-- Name: DentalProcedureCompletion; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public."DentalProcedureCompletion" (
    id integer NOT NULL,
    "batchOrderId" integer NOT NULL,
    "batchOrderServiceId" integer NOT NULL,
    "visitId" integer NOT NULL,
    "patientId" text NOT NULL,
    "doctorId" text NOT NULL,
    "completedAt" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    notes text,
    "createdAt" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "updatedAt" timestamp(3) without time zone NOT NULL
);


--
-- Name: DentalProcedureCompletion_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public."DentalProcedureCompletion_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: DentalProcedureCompletion_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public."DentalProcedureCompletion_id_seq" OWNED BY public."DentalProcedureCompletion".id;


--
-- Name: DentalRecord; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public."DentalRecord" (
    id integer NOT NULL,
    "patientId" text NOT NULL,
    "visitId" integer,
    "doctorId" text,
    "toothId" integer,
    conditions text[],
    surfaces text[],
    "eruptionStart" integer,
    "eruptionEnd" integer,
    "rootCompletion" integer,
    "toothChart" jsonb,
    "painFlags" jsonb,
    "gumCondition" text,
    "oralHygiene" text,
    "treatmentPlan" jsonb,
    notes text,
    "createdAt" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "updatedAt" timestamp(3) without time zone NOT NULL
);


--
-- Name: DentalRecord_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public."DentalRecord_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: DentalRecord_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public."DentalRecord_id_seq" OWNED BY public."DentalRecord".id;


--
-- Name: Department; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public."Department" (
    id integer NOT NULL,
    name text NOT NULL,
    description text,
    "createdAt" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "updatedAt" timestamp(3) without time zone NOT NULL
);


--
-- Name: Department_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public."Department_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: Department_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public."Department_id_seq" OWNED BY public."Department".id;


--
-- Name: DetailedLabResult; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public."DetailedLabResult" (
    id text NOT NULL,
    "labOrderId" integer NOT NULL,
    "serviceId" integer,
    "templateId" text NOT NULL,
    results jsonb NOT NULL,
    status public."OrderStatus" DEFAULT 'UNPAID'::public."OrderStatus" NOT NULL,
    "verifiedBy" text,
    "verifiedAt" timestamp(3) without time zone,
    "additionalNotes" text,
    "createdAt" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "updatedAt" timestamp(3) without time zone NOT NULL
);


--
-- Name: DiagnosisNotes; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public."DiagnosisNotes" (
    id text NOT NULL,
    "visitId" integer NOT NULL,
    "patientId" text NOT NULL,
    "doctorId" text NOT NULL,
    "chiefComplaint" text,
    "historyOfPresentIllness" text,
    "pastMedicalHistory" text,
    "allergicHistory" text,
    "physicalExamination" text,
    "investigationFindings" text,
    "assessmentAndDiagnosis" text,
    "treatmentPlan" text,
    "treatmentGiven" text,
    "medicationIssued" text,
    additional text,
    prognosis text,
    "createdAt" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "updatedAt" timestamp(3) without time zone NOT NULL,
    "updatedBy" text
);


--
-- Name: Disease; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public."Disease" (
    id text NOT NULL,
    code text NOT NULL,
    name text NOT NULL,
    category text,
    "isReportable" boolean DEFAULT false NOT NULL,
    "reportFrequency" text,
    "createdAt" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "updatedAt" timestamp(3) without time zone NOT NULL
);


--
-- Name: DispenseLog; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public."DispenseLog" (
    id integer NOT NULL,
    "orderId" integer NOT NULL,
    "patientId" text NOT NULL,
    "pharmacyId" text NOT NULL,
    quantity integer NOT NULL,
    notes text,
    "createdAt" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


--
-- Name: DispenseLog_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public."DispenseLog_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: DispenseLog_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public."DispenseLog_id_seq" OWNED BY public."DispenseLog".id;


--
-- Name: DispensedMedicine; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public."DispensedMedicine" (
    id integer NOT NULL,
    "pharmacyInvoiceId" text NOT NULL,
    "medicationOrderId" integer,
    "medicationCatalogId" text,
    status public."DispensedStatus" NOT NULL,
    name text,
    "dosageForm" text,
    strength text,
    quantity integer,
    "unitPrice" double precision,
    notes text,
    "dispensedAt" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "dispensedBy" text
);


--
-- Name: DispensedMedicine_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public."DispensedMedicine_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: DispensedMedicine_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public."DispensedMedicine_id_seq" OWNED BY public."DispensedMedicine".id;


--
-- Name: DoctorWalkInOrder; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public."DoctorWalkInOrder" (
    id integer NOT NULL,
    "patientId" text NOT NULL,
    "serviceId" text NOT NULL,
    "doctorId" text,
    instructions text,
    notes text,
    status public."OrderStatus" DEFAULT 'UNPAID'::public."OrderStatus" NOT NULL,
    "billingId" text,
    "completedAt" timestamp(3) without time zone,
    "createdAt" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "updatedAt" timestamp(3) without time zone NOT NULL,
    "visitId" integer
);


--
-- Name: DoctorWalkInOrder_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public."DoctorWalkInOrder_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: DoctorWalkInOrder_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public."DoctorWalkInOrder_id_seq" OWNED BY public."DoctorWalkInOrder".id;


--
-- Name: EmergencyDrugOrder; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public."EmergencyDrugOrder" (
    id integer NOT NULL,
    "visitId" integer,
    "patientId" text NOT NULL,
    "doctorId" text,
    "serviceId" text NOT NULL,
    quantity integer DEFAULT 1 NOT NULL,
    instructions text,
    notes text,
    status public."OrderStatus" DEFAULT 'UNPAID'::public."OrderStatus" NOT NULL,
    "billingId" text,
    "completedAt" timestamp(3) without time zone,
    "createdAt" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "updatedAt" timestamp(3) without time zone NOT NULL,
    "dosageForm" text,
    duration text,
    "durationPeriod" text,
    frequency text,
    "frequencyPeriod" text,
    route text,
    strength text
);


--
-- Name: EmergencyDrugOrder_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public."EmergencyDrugOrder_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: EmergencyDrugOrder_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public."EmergencyDrugOrder_id_seq" OWNED BY public."EmergencyDrugOrder".id;


--
-- Name: File; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public."File" (
    id integer NOT NULL,
    "patientId" text NOT NULL,
    path text NOT NULL,
    type text NOT NULL,
    "accessLog" text[],
    "labOrderId" integer,
    "radiologyOrderId" integer,
    "batchOrderId" integer,
    "createdAt" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "updatedAt" timestamp(3) without time zone NOT NULL
);


--
-- Name: File_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public."File_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: File_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public."File_id_seq" OWNED BY public."File".id;


--
-- Name: Insurance; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public."Insurance" (
    id text NOT NULL,
    name text NOT NULL,
    code text NOT NULL,
    "contactInfo" text,
    "isActive" boolean DEFAULT true NOT NULL,
    "createdAt" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "updatedAt" timestamp(3) without time zone NOT NULL
);


--
-- Name: InsuranceTransaction; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public."InsuranceTransaction" (
    id text NOT NULL,
    "insuranceId" text NOT NULL,
    "patientId" text NOT NULL,
    "visitId" integer,
    "serviceType" public."InsuranceServiceType" NOT NULL,
    "serviceId" text,
    "serviceName" text NOT NULL,
    "serviceCode" text,
    "medicationId" text,
    "medicationName" text,
    "unitPrice" double precision NOT NULL,
    "totalAmount" double precision NOT NULL,
    quantity integer DEFAULT 1 NOT NULL,
    status public."InsuranceTransactionStatus" DEFAULT 'PENDING'::public."InsuranceTransactionStatus" NOT NULL,
    "claimNumber" text,
    "transactionNumber" text,
    "serviceDate" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "claimDate" timestamp(3) without time zone,
    "collectedDate" timestamp(3) without time zone,
    notes text,
    "receiptPath" text,
    "createdById" text,
    "collectedById" text,
    "createdAt" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "updatedAt" timestamp(3) without time zone NOT NULL
);


--
-- Name: InternationalMedicalCertificate; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public."InternationalMedicalCertificate" (
    id text NOT NULL,
    "certificateNo" text NOT NULL,
    "certificateDate" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "patientId" text NOT NULL,
    "doctorId" text NOT NULL,
    "visitId" integer,
    "passportNo" text,
    "hasPreviousDisease" boolean DEFAULT false NOT NULL,
    "previousDiseaseDetails" text,
    "hasCurrentMedicalComplains" boolean DEFAULT false NOT NULL,
    "currentMedicalComplainsDetails" text,
    height text,
    weight text,
    bp text,
    "bloodGroup" text,
    heent text DEFAULT 'Normal'::text,
    chest text DEFAULT 'Normal'::text,
    cvs text DEFAULT 'Normal'::text,
    abdomen text DEFAULT 'Normal'::text,
    cns text DEFAULT 'Normal'::text,
    "chestXRay" text DEFAULT 'Normal'::text,
    hiv text DEFAULT 'Negative'::text,
    hbsag text DEFAULT 'Negative'::text,
    vdrl text DEFAULT 'Negative'::text,
    hcv text DEFAULT 'Negative'::text,
    hcg text DEFAULT 'Negative'::text,
    "fbsRbs" text DEFAULT 'Negative'::text,
    "finalAssessment" text DEFAULT 'FIT'::text,
    "directoryName" text,
    status public."CertificateStatus" DEFAULT 'ACTIVE'::public."CertificateStatus" NOT NULL,
    "createdAt" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "updatedAt" timestamp(3) without time zone NOT NULL
);


--
-- Name: Inventory; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public."Inventory" (
    id integer NOT NULL,
    name text NOT NULL,
    quantity integer NOT NULL,
    category public."MedicineCategory",
    "dosageForm" text,
    strength text,
    "expiryDate" timestamp(3) without time zone,
    supplier text,
    price double precision,
    "serviceId" text,
    "createdAt" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "updatedAt" timestamp(3) without time zone NOT NULL
);


--
-- Name: Inventory_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public."Inventory_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: Inventory_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public."Inventory_id_seq" OWNED BY public."Inventory".id;


--
-- Name: InvestigationType; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public."InvestigationType" (
    id integer NOT NULL,
    name text NOT NULL,
    price double precision NOT NULL,
    category public."InvestigationCategory" NOT NULL,
    "serviceId" text,
    "createdAt" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "updatedAt" timestamp(3) without time zone NOT NULL
);


--
-- Name: InvestigationType_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public."InvestigationType_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: InvestigationType_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public."InvestigationType_id_seq" OWNED BY public."InvestigationType".id;


--
-- Name: LabOrder; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public."LabOrder" (
    id integer NOT NULL,
    "visitId" integer,
    "patientId" text NOT NULL,
    "doctorId" text,
    "typeId" integer NOT NULL,
    instructions text,
    result text,
    "additionalNotes" text,
    status public."OrderStatus" DEFAULT 'UNPAID'::public."OrderStatus" NOT NULL,
    "isWalkIn" boolean DEFAULT false NOT NULL,
    "billingId" text,
    "createdAt" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "updatedAt" timestamp(3) without time zone NOT NULL
);


--
-- Name: LabOrder_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public."LabOrder_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: LabOrder_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public."LabOrder_id_seq" OWNED BY public."LabOrder".id;


--
-- Name: LabResult; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public."LabResult" (
    id text NOT NULL,
    "orderId" integer NOT NULL,
    "testTypeId" integer NOT NULL,
    "resultText" text,
    "additionalNotes" text,
    status public."OrderStatus" DEFAULT 'UNPAID'::public."OrderStatus" NOT NULL,
    "createdAt" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "updatedAt" timestamp(3) without time zone NOT NULL
);


--
-- Name: LabResultFile; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public."LabResultFile" (
    id text NOT NULL,
    "resultId" text NOT NULL,
    "fileUrl" text NOT NULL,
    "fileName" text,
    "fileType" text,
    "uploadedAt" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "uploadedBy" text
);


--
-- Name: LabTest; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public."LabTest" (
    id text NOT NULL,
    name text NOT NULL,
    code text,
    category text NOT NULL,
    description text,
    price double precision NOT NULL,
    unit text DEFAULT 'UNIT'::text,
    "groupId" text,
    "displayOrder" integer DEFAULT 0 NOT NULL,
    "isActive" boolean DEFAULT true NOT NULL,
    "createdAt" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "updatedAt" timestamp(3) without time zone NOT NULL,
    "createdBy" text,
    "updatedBy" text,
    "serviceId" text
);


--
-- Name: LabTestGroup; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public."LabTestGroup" (
    id text NOT NULL,
    name text NOT NULL,
    category text NOT NULL,
    description text,
    "displayOrder" integer DEFAULT 0 NOT NULL,
    "isActive" boolean DEFAULT true NOT NULL,
    "createdAt" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "updatedAt" timestamp(3) without time zone NOT NULL,
    "createdBy" text,
    "updatedBy" text
);


--
-- Name: LabTestOrder; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public."LabTestOrder" (
    id text NOT NULL,
    "labTestId" text NOT NULL,
    "batchOrderId" integer,
    "visitId" integer,
    "patientId" text NOT NULL,
    "doctorId" text,
    instructions text,
    status public."OrderStatus" DEFAULT 'UNPAID'::public."OrderStatus" NOT NULL,
    "isWalkIn" boolean DEFAULT false NOT NULL,
    "billingId" text,
    "createdAt" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "updatedAt" timestamp(3) without time zone NOT NULL
);


--
-- Name: LabTestResult; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public."LabTestResult" (
    id text NOT NULL,
    "orderId" text NOT NULL,
    "testId" text NOT NULL,
    results jsonb NOT NULL,
    "additionalNotes" text,
    status public."OrderStatus" DEFAULT 'UNPAID'::public."OrderStatus" NOT NULL,
    "verifiedBy" text,
    "verifiedAt" timestamp(3) without time zone,
    "createdAt" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "updatedAt" timestamp(3) without time zone NOT NULL,
    "processedBy" text
);


--
-- Name: LabTestResultField; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public."LabTestResultField" (
    id text NOT NULL,
    "testId" text NOT NULL,
    "fieldName" text NOT NULL,
    label text NOT NULL,
    "fieldType" text NOT NULL,
    unit text,
    "normalRange" text,
    options jsonb,
    "isRequired" boolean DEFAULT false NOT NULL,
    "displayOrder" integer DEFAULT 0 NOT NULL,
    "createdAt" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "updatedAt" timestamp(3) without time zone NOT NULL
);


--
-- Name: LabTestResultFile; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public."LabTestResultFile" (
    id text NOT NULL,
    "resultId" text NOT NULL,
    "fileUrl" text NOT NULL,
    "fileName" text,
    "fileType" text,
    "uploadedAt" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "uploadedBy" text
);


--
-- Name: LabTestTemplate; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public."LabTestTemplate" (
    id text NOT NULL,
    name text NOT NULL,
    category text NOT NULL,
    description text,
    fields jsonb NOT NULL,
    "isActive" boolean DEFAULT true NOT NULL,
    "createdAt" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "updatedAt" timestamp(3) without time zone NOT NULL
);


--
-- Name: Loan; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public."Loan" (
    id text NOT NULL,
    "staffId" text NOT NULL,
    "requestedAmount" double precision NOT NULL,
    "approvedAmount" double precision,
    status public."LoanStatus" DEFAULT 'PENDING'::public."LoanStatus" NOT NULL,
    reason text,
    notes text,
    "requestedAt" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "reviewedAt" timestamp(3) without time zone,
    "approvedAt" timestamp(3) without time zone,
    "deniedAt" timestamp(3) without time zone,
    "givenAt" timestamp(3) without time zone,
    "reviewedById" text,
    "givenById" text,
    "expenseId" text,
    "settlementMethod" public."LoanSettlementMethod" DEFAULT 'INSTANT_PAID'::public."LoanSettlementMethod" NOT NULL,
    "settledAt" timestamp(3) without time zone,
    "settledById" text,
    "settledAmount" double precision,
    "settlementAcceptedAt" timestamp(3) without time zone,
    "settlementAcceptedById" text,
    "settlementAcceptedAmount" double precision,
    "createdAt" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "updatedAt" timestamp(3) without time zone NOT NULL
);


--
-- Name: MaterialNeedsOrder; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public."MaterialNeedsOrder" (
    id integer NOT NULL,
    "visitId" integer,
    "patientId" text NOT NULL,
    "nurseId" text,
    "serviceId" text NOT NULL,
    quantity integer DEFAULT 1 NOT NULL,
    instructions text,
    notes text,
    status public."OrderStatus" DEFAULT 'UNPAID'::public."OrderStatus" NOT NULL,
    "billingId" text,
    "completedAt" timestamp(3) without time zone,
    "createdAt" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "updatedAt" timestamp(3) without time zone NOT NULL
);


--
-- Name: MaterialNeedsOrder_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public."MaterialNeedsOrder_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: MaterialNeedsOrder_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public."MaterialNeedsOrder_id_seq" OWNED BY public."MaterialNeedsOrder".id;


--
-- Name: MedicalCertificate; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public."MedicalCertificate" (
    id text NOT NULL,
    "certificateNo" text NOT NULL,
    "patientId" text NOT NULL,
    "doctorId" text NOT NULL,
    "visitId" integer,
    "certificateDate" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "restStartDate" timestamp(3) without time zone,
    "restEndDate" timestamp(3) without time zone,
    "totalDays" integer,
    diagnosis text NOT NULL,
    treatment text,
    recommendations text,
    status public."CertificateStatus" DEFAULT 'ACTIVE'::public."CertificateStatus" NOT NULL,
    "createdAt" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "updatedAt" timestamp(3) without time zone NOT NULL,
    "appointmentDate" timestamp(3) without time zone
);


--
-- Name: MedicalHistory; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public."MedicalHistory" (
    id integer NOT NULL,
    "patientId" text NOT NULL,
    "visitId" integer,
    "doctorId" text,
    "visitUid" text,
    "visitDate" timestamp(3) without time zone,
    "completedDate" timestamp(3) without time zone,
    details text NOT NULL,
    diagnosis text,
    "diagnosisDetails" text,
    instructions text,
    "finalNotes" text,
    "needsAppointment" boolean DEFAULT false NOT NULL,
    "appointmentId" integer,
    "createdAt" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "updatedAt" timestamp(3) without time zone NOT NULL
);


--
-- Name: MedicalHistory_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public."MedicalHistory_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: MedicalHistory_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public."MedicalHistory_id_seq" OWNED BY public."MedicalHistory".id;


--
-- Name: MedicationCatalog; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public."MedicationCatalog" (
    id text NOT NULL,
    name text NOT NULL,
    "genericName" text,
    "dosageForm" text NOT NULL,
    strength text NOT NULL,
    category public."MedicineCategory" NOT NULL,
    "unitPrice" double precision NOT NULL,
    "availableQuantity" integer NOT NULL,
    "minimumStock" integer NOT NULL,
    unit text,
    "packSize" integer,
    manufacturer text,
    "createdAt" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "updatedAt" timestamp(3) without time zone NOT NULL,
    description text,
    "isRetailOnly" boolean DEFAULT false NOT NULL
);


--
-- Name: MedicationOrder; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public."MedicationOrder" (
    id integer NOT NULL,
    "visitId" integer NOT NULL,
    "patientId" text NOT NULL,
    "doctorId" text NOT NULL,
    "medicationCatalogId" text,
    name text NOT NULL,
    "genericName" text,
    "dosageForm" text NOT NULL,
    strength text NOT NULL,
    quantity text,
    "quantityNumeric" double precision,
    unit text,
    duration text,
    instructions text,
    "additionalNotes" text,
    category text,
    type text,
    "unitPrice" double precision,
    status public."OrderStatus" DEFAULT 'UNPAID'::public."OrderStatus" NOT NULL,
    "createdAt" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "updatedAt" timestamp(3) without time zone NOT NULL,
    route text,
    "isDeferred" boolean DEFAULT false NOT NULL,
    "atcCode" text,
    "calculatedQuantity" double precision,
    "dosageFormCategory" text,
    "durationText" text,
    "durationUnit" text,
    "durationValue" double precision,
    "finalQuantity" double precision,
    "frequencyText" text,
    "frequencyType" text,
    "frequencyUnit" text,
    "frequencyValue" double precision,
    "normalizedName" text,
    "quantityOverridden" boolean DEFAULT false NOT NULL,
    "routeCode" text,
    "rxnormCode" text,
    "snomedCode" text,
    "strengthText" text
);


--
-- Name: MedicationOrder_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public."MedicationOrder_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: MedicationOrder_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public."MedicationOrder_id_seq" OWNED BY public."MedicationOrder".id;


--
-- Name: NurseAdministration; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public."NurseAdministration" (
    id integer NOT NULL,
    "continuousInfusionId" integer NOT NULL,
    "administeredById" text,
    "administeredAt" timestamp(3) without time zone,
    "scheduledFor" timestamp(3) without time zone NOT NULL,
    notes text,
    "createdAt" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "updatedAt" timestamp(3) without time zone NOT NULL,
    completed boolean DEFAULT false NOT NULL
);


--
-- Name: NurseAdministration_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public."NurseAdministration_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: NurseAdministration_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public."NurseAdministration_id_seq" OWNED BY public."NurseAdministration".id;


--
-- Name: NurseServiceAssignment; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public."NurseServiceAssignment" (
    id integer NOT NULL,
    "visitId" integer NOT NULL,
    "serviceId" text NOT NULL,
    "assignedNurseId" text NOT NULL,
    "assignedById" text NOT NULL,
    status public."NurseServiceStatus" DEFAULT 'PENDING'::public."NurseServiceStatus" NOT NULL,
    notes text,
    "orderType" text DEFAULT 'TRIAGE_ORDERED'::text,
    "isWaived" boolean DEFAULT false NOT NULL,
    "waivedBy" text,
    "waivedAt" timestamp(3) without time zone,
    "completedAt" timestamp(3) without time zone,
    "createdAt" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "updatedAt" timestamp(3) without time zone NOT NULL,
    "customPrice" double precision
);


--
-- Name: NurseServiceAssignment_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public."NurseServiceAssignment_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: NurseServiceAssignment_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public."NurseServiceAssignment_id_seq" OWNED BY public."NurseServiceAssignment".id;


--
-- Name: NurseWalkInOrder; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public."NurseWalkInOrder" (
    id integer NOT NULL,
    "patientId" text NOT NULL,
    "serviceId" text NOT NULL,
    "nurseId" text,
    instructions text,
    notes text,
    status public."OrderStatus" DEFAULT 'UNPAID'::public."OrderStatus" NOT NULL,
    "billingId" text,
    "completedAt" timestamp(3) without time zone,
    "createdAt" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "updatedAt" timestamp(3) without time zone NOT NULL,
    "visitId" integer
);


--
-- Name: NurseWalkInOrder_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public."NurseWalkInOrder_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: NurseWalkInOrder_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public."NurseWalkInOrder_id_seq" OWNED BY public."NurseWalkInOrder".id;


--
-- Name: Patient; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public."Patient" (
    id text NOT NULL,
    name text NOT NULL,
    dob timestamp(3) without time zone,
    gender public."Gender",
    type public."PatientType" NOT NULL,
    mobile text,
    email text,
    address text,
    "emergencyContact" text,
    "bloodType" public."BloodType",
    "maritalStatus" public."MaritalStatus",
    status public."PatientStatus" DEFAULT 'Active'::public."PatientStatus" NOT NULL,
    "insuranceId" text,
    "cardStatus" public."CardStatus" DEFAULT 'INACTIVE'::public."CardStatus" NOT NULL,
    "cardActivatedAt" timestamp(3) without time zone,
    "cardExpiryDate" timestamp(3) without time zone,
    "createdAt" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "updatedAt" timestamp(3) without time zone NOT NULL,
    kebele text,
    region text,
    woreda text,
    zone text,
    "cardType" public."CardType" DEFAULT 'GENERAL'::public."CardType" NOT NULL,
    "nationalId" text,
    age integer
);


--
-- Name: PatientAccount; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public."PatientAccount" (
    id text NOT NULL,
    "patientId" text NOT NULL,
    "accountType" public."AccountType" NOT NULL,
    status public."AccountStatus" DEFAULT 'PENDING'::public."AccountStatus" NOT NULL,
    balance double precision DEFAULT 0 NOT NULL,
    "totalDeposited" double precision DEFAULT 0 NOT NULL,
    "totalUsed" double precision DEFAULT 0 NOT NULL,
    "debtOwed" double precision DEFAULT 0 NOT NULL,
    "totalDebtPaid" double precision DEFAULT 0 NOT NULL,
    "verifiedById" text,
    "verifiedAt" timestamp(3) without time zone,
    "rejectionReason" text,
    "createdAt" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "updatedAt" timestamp(3) without time zone NOT NULL,
    "creditLimit" double precision DEFAULT 0 NOT NULL
);


--
-- Name: PatientAttachedImage; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public."PatientAttachedImage" (
    id text NOT NULL,
    "visitId" integer NOT NULL,
    "patientId" text NOT NULL,
    "doctorId" text,
    "fileName" text NOT NULL,
    "filePath" text NOT NULL,
    "fileSize" integer NOT NULL,
    "mimeType" text NOT NULL,
    description text,
    "uploadedAt" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "uploadedBy" text NOT NULL
);


--
-- Name: PatientDiagnosis; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public."PatientDiagnosis" (
    id text NOT NULL,
    "visitId" integer NOT NULL,
    "patientId" text NOT NULL,
    "doctorId" text NOT NULL,
    "diseaseId" text NOT NULL,
    type public."DiagnosisType" DEFAULT 'CLINICAL'::public."DiagnosisType" NOT NULL,
    status public."DiagnosisStatus" DEFAULT 'ACTIVE'::public."DiagnosisStatus" NOT NULL,
    "isPrimary" boolean DEFAULT true NOT NULL,
    notes text,
    "createdAt" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "updatedAt" timestamp(3) without time zone NOT NULL
);


--
-- Name: PatientGallery; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public."PatientGallery" (
    id text NOT NULL,
    "patientId" text NOT NULL,
    "visitId" integer NOT NULL,
    "imageType" public."ImageType" NOT NULL,
    "filePath" text NOT NULL,
    description text,
    "uploadedById" text NOT NULL,
    "createdAt" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


--
-- Name: PharmacyInvoice; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public."PharmacyInvoice" (
    id text NOT NULL,
    "patientId" text,
    "visitId" integer,
    "invoiceNumber" text,
    "totalAmount" double precision NOT NULL,
    status public."BillingStatus" DEFAULT 'PENDING'::public."BillingStatus" NOT NULL,
    type public."PharmacyInvoiceType" DEFAULT 'DOCTOR_PRESCRIPTION'::public."PharmacyInvoiceType" NOT NULL,
    "paymentMethod" public."PaymentType",
    "insuranceId" text,
    notes text,
    "createdBy" text,
    "processedBy" text,
    "processedAt" timestamp(3) without time zone,
    "createdAt" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "updatedAt" timestamp(3) without time zone NOT NULL
);


--
-- Name: PharmacyInvoiceItem; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public."PharmacyInvoiceItem" (
    id text NOT NULL,
    "pharmacyInvoiceId" text NOT NULL,
    "medicationOrderId" integer,
    "medicationCatalogId" text,
    name text NOT NULL,
    "dosageForm" text NOT NULL,
    strength text NOT NULL,
    quantity integer NOT NULL,
    "unitPrice" double precision NOT NULL,
    "totalPrice" double precision NOT NULL,
    notes text,
    "createdAt" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "updatedAt" timestamp(3) without time zone NOT NULL
);


--
-- Name: RadiologyOrder; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public."RadiologyOrder" (
    id integer NOT NULL,
    "visitId" integer,
    "patientId" text NOT NULL,
    "doctorId" text,
    "typeId" integer NOT NULL,
    instructions text,
    result text,
    status public."OrderStatus" DEFAULT 'UNPAID'::public."OrderStatus" NOT NULL,
    "isWalkIn" boolean DEFAULT false NOT NULL,
    "billingId" text,
    "createdAt" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "updatedAt" timestamp(3) without time zone NOT NULL
);


--
-- Name: RadiologyOrder_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public."RadiologyOrder_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: RadiologyOrder_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public."RadiologyOrder_id_seq" OWNED BY public."RadiologyOrder".id;


--
-- Name: RadiologyResult; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public."RadiologyResult" (
    id text NOT NULL,
    "orderId" integer,
    "batchOrderId" integer,
    "testTypeId" integer NOT NULL,
    "resultText" text,
    "additionalNotes" text,
    status public."OrderStatus" DEFAULT 'UNPAID'::public."OrderStatus" NOT NULL,
    "createdAt" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "updatedAt" timestamp(3) without time zone NOT NULL,
    findings text,
    conclusion text
);


--
-- Name: RadiologyResultFile; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public."RadiologyResultFile" (
    id text NOT NULL,
    "resultId" text NOT NULL,
    "fileUrl" text NOT NULL,
    "fileName" text,
    "fileType" text,
    "uploadedAt" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "uploadedBy" text
);


--
-- Name: RadiologyTemplate; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public."RadiologyTemplate" (
    id text NOT NULL,
    "investigationTypeId" integer NOT NULL,
    "findingsTemplate" text,
    "conclusionTemplate" text,
    "isActive" boolean DEFAULT true NOT NULL,
    "createdAt" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "updatedAt" timestamp(3) without time zone NOT NULL,
    "createdBy" text,
    "updatedBy" text
);


--
-- Name: Referral; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public."Referral" (
    id text NOT NULL,
    "patientId" text NOT NULL,
    "doctorId" text NOT NULL,
    "visitId" integer,
    "referralReason" text NOT NULL,
    diagnosis text NOT NULL,
    "facilityName" text NOT NULL,
    "doctorDetails" text NOT NULL,
    urgency text DEFAULT 'NORMAL'::text NOT NULL,
    status text DEFAULT 'PENDING'::text NOT NULL,
    "clinicalHistory" text,
    "physicalExam" text,
    "labInvestigation" text,
    imaging text,
    "treatmentGiven" text,
    region text,
    zone text,
    woreda text,
    kebele text,
    "createdAt" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "updatedAt" timestamp(3) without time zone NOT NULL
);


--
-- Name: Service; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public."Service" (
    id text NOT NULL,
    code text NOT NULL,
    name text NOT NULL,
    category public."ServiceCategory" NOT NULL,
    price double precision NOT NULL,
    unit text DEFAULT 'UNIT'::text,
    description text,
    "isActive" boolean DEFAULT true NOT NULL,
    "createdAt" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "updatedAt" timestamp(3) without time zone NOT NULL,
    "isVariablePrice" boolean DEFAULT false NOT NULL,
    "maxPrice" double precision,
    "minPrice" double precision
);


--
-- Name: SystemSettings; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public."SystemSettings" (
    id text NOT NULL,
    key text NOT NULL,
    value text NOT NULL,
    description text,
    "updatedById" text,
    "updatedAt" timestamp(3) without time zone NOT NULL,
    "createdAt" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


--
-- Name: Tooth; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public."Tooth" (
    id integer NOT NULL,
    number integer NOT NULL,
    "eruptionStart" integer,
    "eruptionEnd" integer,
    "rootCompletion" integer
);


--
-- Name: Tooth_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public."Tooth_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: Tooth_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public."Tooth_id_seq" OWNED BY public."Tooth".id;


--
-- Name: User; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public."User" (
    id text NOT NULL,
    fullname text NOT NULL,
    username text NOT NULL,
    password text NOT NULL,
    email text,
    phone text,
    role public."Role" NOT NULL,
    "licenseNumber" text,
    availability boolean DEFAULT true NOT NULL,
    "isActive" boolean DEFAULT true NOT NULL,
    "consultationFee" double precision,
    "waiveConsultationFee" boolean DEFAULT false NOT NULL,
    "passwordChangedAt" timestamp(3) without time zone,
    "createdAt" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "updatedAt" timestamp(3) without time zone NOT NULL,
    qualifications text[]
);


--
-- Name: VirtualQueue; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public."VirtualQueue" (
    id text NOT NULL,
    name text NOT NULL,
    phone text NOT NULL,
    "patientId" text,
    status public."VirtualQueueStatus" DEFAULT 'PENDING'::public."VirtualQueueStatus" NOT NULL,
    priority integer DEFAULT 3 NOT NULL,
    notes text,
    "createdAt" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "updatedAt" timestamp(3) without time zone NOT NULL,
    "processedAt" timestamp(3) without time zone,
    "processedBy" text
);


--
-- Name: Visit; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public."Visit" (
    id integer NOT NULL,
    "visitUid" text NOT NULL,
    "patientId" text NOT NULL,
    "createdById" text,
    "suggestedDoctorId" text,
    date timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    status public."VisitStatus" DEFAULT 'WAITING_FOR_TRIAGE'::public."VisitStatus" NOT NULL,
    "queueType" public."QueueType" DEFAULT 'CONSULTATION'::public."QueueType" NOT NULL,
    "isEmergency" boolean DEFAULT false NOT NULL,
    notes text,
    diagnosis text,
    "diagnosisDetails" text,
    instructions text,
    "assignmentId" integer,
    "completedAt" timestamp(3) without time zone,
    "createdAt" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "updatedAt" timestamp(3) without time zone NOT NULL,
    outcome text
);


--
-- Name: Visit_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public."Visit_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: Visit_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public."Visit_id_seq" OWNED BY public."Visit".id;


--
-- Name: VitalSign; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public."VitalSign" (
    id integer NOT NULL,
    "patientId" text NOT NULL,
    "visitId" integer,
    "bloodPressure" text,
    temperature double precision,
    "tempUnit" public."TempUnit" DEFAULT 'C'::public."TempUnit" NOT NULL,
    "heartRate" integer,
    "respirationRate" integer,
    height double precision,
    weight double precision,
    bmi double precision,
    "oxygenSaturation" integer,
    condition text,
    notes text,
    "painScoreRest" integer,
    "painScoreMovement" integer,
    "sedationScore" integer,
    "gcsEyes" integer,
    "gcsVerbal" integer,
    "gcsMotor" integer,
    "bloodPressureSystolic" integer,
    "bloodPressureDiastolic" integer,
    "chiefComplaint" text,
    "historyOfPresentIllness" text,
    "onsetOfSymptoms" text,
    "durationOfSymptoms" text,
    "severityOfSymptoms" text,
    "associatedSymptoms" text,
    "relievingFactors" text,
    "aggravatingFactors" text,
    "generalAppearance" text,
    "headAndNeck" text,
    "cardiovascularExam" text,
    "respiratoryExam" text,
    "abdominalExam" text,
    extremities text,
    "neurologicalExam" text,
    "createdAt" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "updatedAt" timestamp(3) without time zone NOT NULL,
    "recordedByRole" text DEFAULT 'NURSE'::text NOT NULL
);


--
-- Name: VitalSign_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public."VitalSign_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: VitalSign_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public."VitalSign_id_seq" OWNED BY public."VitalSign".id;


--
-- Name: _prisma_migrations; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public._prisma_migrations (
    id character varying(36) NOT NULL,
    checksum character varying(64) NOT NULL,
    finished_at timestamp with time zone,
    migration_name character varying(255) NOT NULL,
    logs text,
    rolled_back_at timestamp with time zone,
    started_at timestamp with time zone DEFAULT now() NOT NULL,
    applied_steps_count integer DEFAULT 0 NOT NULL
);


--
-- Name: Appointment id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."Appointment" ALTER COLUMN id SET DEFAULT nextval('public."Appointment_id_seq"'::regclass);


--
-- Name: Assignment id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."Assignment" ALTER COLUMN id SET DEFAULT nextval('public."Assignment_id_seq"'::regclass);


--
-- Name: AuditLog id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."AuditLog" ALTER COLUMN id SET DEFAULT nextval('public."AuditLog_id_seq"'::regclass);


--
-- Name: BatchOrder id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."BatchOrder" ALTER COLUMN id SET DEFAULT nextval('public."BatchOrder_id_seq"'::regclass);


--
-- Name: BatchOrderService id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."BatchOrderService" ALTER COLUMN id SET DEFAULT nextval('public."BatchOrderService_id_seq"'::regclass);


--
-- Name: CardActivation id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."CardActivation" ALTER COLUMN id SET DEFAULT nextval('public."CardActivation_id_seq"'::regclass);


--
-- Name: CompoundIngredient id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."CompoundIngredient" ALTER COLUMN id SET DEFAULT nextval('public."CompoundIngredient_id_seq"'::regclass);


--
-- Name: CompoundPrescription id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."CompoundPrescription" ALTER COLUMN id SET DEFAULT nextval('public."CompoundPrescription_id_seq"'::regclass);


--
-- Name: ContinuousInfusion id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."ContinuousInfusion" ALTER COLUMN id SET DEFAULT nextval('public."ContinuousInfusion_id_seq"'::regclass);


--
-- Name: DentalProcedureCompletion id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."DentalProcedureCompletion" ALTER COLUMN id SET DEFAULT nextval('public."DentalProcedureCompletion_id_seq"'::regclass);


--
-- Name: DentalRecord id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."DentalRecord" ALTER COLUMN id SET DEFAULT nextval('public."DentalRecord_id_seq"'::regclass);


--
-- Name: Department id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."Department" ALTER COLUMN id SET DEFAULT nextval('public."Department_id_seq"'::regclass);


--
-- Name: DispenseLog id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."DispenseLog" ALTER COLUMN id SET DEFAULT nextval('public."DispenseLog_id_seq"'::regclass);


--
-- Name: DispensedMedicine id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."DispensedMedicine" ALTER COLUMN id SET DEFAULT nextval('public."DispensedMedicine_id_seq"'::regclass);


--
-- Name: DoctorWalkInOrder id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."DoctorWalkInOrder" ALTER COLUMN id SET DEFAULT nextval('public."DoctorWalkInOrder_id_seq"'::regclass);


--
-- Name: EmergencyDrugOrder id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."EmergencyDrugOrder" ALTER COLUMN id SET DEFAULT nextval('public."EmergencyDrugOrder_id_seq"'::regclass);


--
-- Name: File id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."File" ALTER COLUMN id SET DEFAULT nextval('public."File_id_seq"'::regclass);


--
-- Name: Inventory id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."Inventory" ALTER COLUMN id SET DEFAULT nextval('public."Inventory_id_seq"'::regclass);


--
-- Name: InvestigationType id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."InvestigationType" ALTER COLUMN id SET DEFAULT nextval('public."InvestigationType_id_seq"'::regclass);


--
-- Name: LabOrder id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."LabOrder" ALTER COLUMN id SET DEFAULT nextval('public."LabOrder_id_seq"'::regclass);


--
-- Name: MaterialNeedsOrder id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."MaterialNeedsOrder" ALTER COLUMN id SET DEFAULT nextval('public."MaterialNeedsOrder_id_seq"'::regclass);


--
-- Name: MedicalHistory id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."MedicalHistory" ALTER COLUMN id SET DEFAULT nextval('public."MedicalHistory_id_seq"'::regclass);


--
-- Name: MedicationOrder id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."MedicationOrder" ALTER COLUMN id SET DEFAULT nextval('public."MedicationOrder_id_seq"'::regclass);


--
-- Name: NurseAdministration id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."NurseAdministration" ALTER COLUMN id SET DEFAULT nextval('public."NurseAdministration_id_seq"'::regclass);


--
-- Name: NurseServiceAssignment id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."NurseServiceAssignment" ALTER COLUMN id SET DEFAULT nextval('public."NurseServiceAssignment_id_seq"'::regclass);


--
-- Name: NurseWalkInOrder id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."NurseWalkInOrder" ALTER COLUMN id SET DEFAULT nextval('public."NurseWalkInOrder_id_seq"'::regclass);


--
-- Name: RadiologyOrder id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."RadiologyOrder" ALTER COLUMN id SET DEFAULT nextval('public."RadiologyOrder_id_seq"'::regclass);


--
-- Name: Tooth id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."Tooth" ALTER COLUMN id SET DEFAULT nextval('public."Tooth_id_seq"'::regclass);


--
-- Name: Visit id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."Visit" ALTER COLUMN id SET DEFAULT nextval('public."Visit_id_seq"'::regclass);


--
-- Name: VitalSign id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."VitalSign" ALTER COLUMN id SET DEFAULT nextval('public."VitalSign_id_seq"'::regclass);


--
-- Data for Name: AccountDeposit; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public."AccountDeposit" (id, "accountId", "patientId", amount, "paymentMethod", "bankName", "transNumber", notes, "depositedById", "createdAt") FROM stdin;
8c41707e-a719-4931-b960-3e80de9bb37a	cdf10248-847c-4301-b92e-7bf9a87c570b	PAT-2026-123	1000	CASH	\N	\N	\N	45aa0bdd-f1a9-4fbe-8125-358e94cba160	2026-02-26 20:50:28.668
e4711cd5-8616-4481-898c-46f7ec5196f7	cdf10248-847c-4301-b92e-7bf9a87c570b	PAT-2026-123	300	CASH	\N	\N	Debt installment payment	45aa0bdd-f1a9-4fbe-8125-358e94cba160	2026-02-26 21:10:19.698
\.


--
-- Data for Name: AccountRequest; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public."AccountRequest" (id, "accountId", "patientId", "requestType", "accountType", amount, "paymentMethod", "bankName", "transNumber", notes, status, "requestedById", "verifiedById", "verifiedAt", "rejectionReason", "createdAt", "updatedAt") FROM stdin;
\.


--
-- Data for Name: AccountTransaction; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public."AccountTransaction" (id, "accountId", "patientId", type, amount, "balanceBefore", "balanceAfter", notes, description, "billingId", "visitId", "processedById", "createdAt", "subAccount") FROM stdin;
6877dcac-f6d2-44fa-9012-6073293d1df3	cdf10248-847c-4301-b92e-7bf9a87c570b	PAT-2026-123	DEBT	1580	0	1580	Debt added from billing 4859bb9d-9193-4401-aed9-28704cad74a0	Unpaid balance from billing #4859bb9d	4859bb9d-9193-4401-aed9-28704cad74a0	1	45aa0bdd-f1a9-4fbe-8125-358e94cba160	2026-02-26 20:34:26.935	CREDIT
03e7c048-960c-4428-a1cf-548165246d18	cdf10248-847c-4301-b92e-7bf9a87c570b	PAT-2026-123	PAYMENT	1000	1580	580	Payment returned to clear debt	\N	\N	\N	45aa0bdd-f1a9-4fbe-8125-358e94cba160	2026-02-26 20:50:28.696	CREDIT
a763f7ca-323a-42b2-b2bc-b5716d488799	cdf10248-847c-4301-b92e-7bf9a87c570b	PAT-2026-123	PAYMENT	300	580	280	Debt installment payment	\N	\N	\N	45aa0bdd-f1a9-4fbe-8125-358e94cba160	2026-02-26 21:10:19.715	CREDIT
8e2eff9b-0ab1-4de1-9228-e08eb15e481d	cdf10248-847c-4301-b92e-7bf9a87c570b	PAT-2026-123	DEBT	300	280	580	Debt added from billing c9a6d937-715d-4e16-a194-36b9c56575b3	Unpaid balance from billing #c9a6d937	c9a6d937-715d-4e16-a194-36b9c56575b3	1	45aa0bdd-f1a9-4fbe-8125-358e94cba160	2026-02-26 21:33:44.356	CREDIT
\.


--
-- Data for Name: Admission; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public."Admission" (id, "patientId", "bedId", "visitId", "admittedById", "startDate", "expectedEndDate", "actualEndDate", status, notes, "createdAt", "updatedAt", "billingId") FROM stdin;
\.


--
-- Data for Name: AdmissionService; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public."AdmissionService" (id, "admissionId", "serviceId", "orderedById", quantity, "unitPrice", "totalPrice", status, "billingId", notes, "createdAt", "updatedAt") FROM stdin;
\.


--
-- Data for Name: Appointment; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public."Appointment" (id, "patientId", "doctorId", "appointmentDate", "appointmentTime", type, status, duration, notes, reason, "createdById", "lastDiagnosedBy", "visitId", "createdAt", "updatedAt") FROM stdin;
\.


--
-- Data for Name: Assignment; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public."Assignment" (id, "patientId", "doctorId", status, "createdAt", "updatedAt") FROM stdin;
1	PAT-2026-123	093cba71-ff80-4568-8969-f93c80ec0cf9	Pending	2026-02-26 13:59:48.467	2026-02-26 13:59:48.467
2	PAT-2026-128	093cba71-ff80-4568-8969-f93c80ec0cf9	Pending	2026-03-04 04:24:38.309	2026-03-04 04:24:38.309
3	PAT-2026-127	1f85b788-1c79-4c9f-b540-ad1bca75ff19	Pending	2026-03-04 22:04:48.96	2026-03-04 22:04:48.96
4	PAT-2026-127	093cba71-ff80-4568-8969-f93c80ec0cf9	Pending	2026-03-05 09:03:27.03	2026-03-05 09:03:27.03
5	PAT-2026-129	093cba71-ff80-4568-8969-f93c80ec0cf9	Pending	2026-03-07 03:35:34.559	2026-03-07 03:35:34.559
6	PAT-2026-129	093cba71-ff80-4568-8969-f93c80ec0cf9	Pending	2026-03-07 03:35:34.559	2026-03-07 03:35:34.559
\.


--
-- Data for Name: BankDeposit; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public."BankDeposit" (id, "sessionId", amount, "bankName", "accountNumber", "depositDate", "receiptImage", "transactionNumber", notes, status, "depositedById", "createdAt", "updatedAt") FROM stdin;
\.


--
-- Data for Name: BatchOrder; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public."BatchOrder" (id, "visitId", "patientId", "doctorId", type, status, instructions, result, "additionalNotes", "createdAt", "updatedAt", "isDeferred") FROM stdin;
1	1	PAT-2026-123	093cba71-ff80-4568-8969-f93c80ec0cf9	LAB	COMPLETED	Lab tests ordered by doctor	\N	\N	2026-02-26 16:14:35.049	2026-02-26 16:18:08.696	f
2	1	PAT-2026-123	093cba71-ff80-4568-8969-f93c80ec0cf9	DENTAL	PAID	\N	\N	\N	2026-02-26 20:32:50.604	2026-02-26 20:42:31.149	f
3	1	PAT-2026-123	093cba71-ff80-4568-8969-f93c80ec0cf9	LAB	QUEUED	Lab tests ordered by doctor	\N	\N	2026-03-03 06:21:23.884	2026-03-03 06:41:50.482	f
4	1	PAT-2026-123	093cba71-ff80-4568-8969-f93c80ec0cf9	LAB	QUEUED	Lab tests ordered by doctor	\N	\N	2026-03-03 06:22:19.087	2026-03-03 06:41:50.482	f
6	1	PAT-2026-123	093cba71-ff80-4568-8969-f93c80ec0cf9	PROCEDURE	PAID	\N	\N	\N	2026-03-03 06:24:08.332	2026-03-03 06:41:50.482	f
5	1	PAT-2026-123	093cba71-ff80-4568-8969-f93c80ec0cf9	LAB	COMPLETED	Lab tests ordered by doctor	\N	\N	2026-03-03 06:22:58.876	2026-03-04 10:30:40.334	f
9	2	PAT-2026-128	093cba71-ff80-4568-8969-f93c80ec0cf9	LAB	QUEUED	Lab tests ordered by doctor	\N	\N	2026-03-04 11:56:50.695	2026-03-04 12:43:05.656	f
10	2	PAT-2026-128	093cba71-ff80-4568-8969-f93c80ec0cf9	LAB	QUEUED	Lab tests ordered by doctor	\N	\N	2026-03-04 12:18:05.526	2026-03-04 12:43:05.656	f
11	2	PAT-2026-128	093cba71-ff80-4568-8969-f93c80ec0cf9	LAB	QUEUED	Lab tests ordered by doctor	\N	\N	2026-03-04 12:42:57.828	2026-03-04 12:43:05.656	f
12	2	PAT-2026-128	093cba71-ff80-4568-8969-f93c80ec0cf9	RADIOLOGY	PAID	Radiology tests ordered by doctor	\N	\N	2026-03-04 18:07:06.301	2026-03-04 23:40:49.793	f
7	1	PAT-2026-123	093cba71-ff80-4568-8969-f93c80ec0cf9	LAB	QUEUED	Lab tests ordered by doctor	\N	\N	2026-03-03 06:44:11.223	2026-03-06 23:11:23.495	f
8	1	PAT-2026-123	093cba71-ff80-4568-8969-f93c80ec0cf9	LAB	QUEUED	Lab tests ordered by doctor	\N	\N	2026-03-03 08:25:49.975	2026-03-06 23:11:23.495	f
14	2	PAT-2026-128	093cba71-ff80-4568-8969-f93c80ec0cf9	LAB	QUEUED	Lab tests ordered by doctor	\N	\N	2026-03-06 23:13:36.845	2026-03-06 23:13:47.27	f
13	2	PAT-2026-128	093cba71-ff80-4568-8969-f93c80ec0cf9	PROCEDURE	COMPLETED	\N	\N	\N	2026-03-04 23:27:42.913	2026-03-07 00:30:32.506	f
\.


--
-- Data for Name: BatchOrderService; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public."BatchOrderService" (id, "batchOrderId", "serviceId", "investigationTypeId", instructions, result, status, "isWaived", "waivedBy", "waivedAt", "createdAt", "updatedAt", "customPrice") FROM stdin;
1	2	3f5da570-ee41-401b-90e7-f940af71652c	\N	\N	\N	PAID	f	\N	\N	2026-02-26 20:32:50.604	2026-02-26 20:34:26.956	1500
2	2	d9c83637-a7cf-4280-a45c-059d25780db5	\N	\N	\N	UNPAID	f	\N	\N	2026-02-26 20:34:55.437	2026-02-26 20:34:55.437	1500
3	2	9f2b8113-651f-4fb4-9ce7-ecad4042c6ee	\N	\N	\N	UNPAID	f	\N	\N	2026-02-26 20:42:31.137	2026-02-26 20:42:31.137	\N
4	6	8f314fd1-be41-49b7-a5c3-1fd600988ee7	\N	\N	\N	PAID	f	\N	\N	2026-03-03 06:24:08.332	2026-03-03 06:41:50.482	\N
5	6	0ab83526-9e53-4dab-9029-568c62959ceb	\N	\N	\N	PAID	f	\N	\N	2026-03-03 06:24:08.332	2026-03-03 06:41:50.482	\N
6	12	907e9fd6-af1d-477e-a8a3-2ebc17a45e53	41	Radiology test: Ultrasound - Abdomen	\N	PAID	f	\N	\N	2026-03-04 18:07:06.301	2026-03-04 18:07:23.242	\N
8	12	6fe4b74f-36ed-4f8f-b28c-9e045e07acda	43	Radiology test: Obstetric Ultrasound	\N	UNPAID	f	\N	\N	2026-03-04 23:27:52.722	2026-03-04 23:27:52.722	\N
7	13	0ab83526-9e53-4dab-9029-568c62959ceb	\N	\N	\N	COMPLETED	f	\N	\N	2026-03-04 23:27:42.913	2026-03-04 23:38:03.977	\N
9	13	03b55355-5dfd-40c7-865a-040e683a2f63	\N	\N	\N	UNPAID	f	\N	\N	2026-03-06 23:24:00.443	2026-03-06 23:24:00.443	\N
10	13	91345ec8-5b95-4d92-8082-d202a229dffc	\N	\N	\N	UNPAID	f	\N	\N	2026-03-06 23:24:00.459	2026-03-06 23:24:00.459	\N
11	13	9440874e-c28e-40ca-88d8-1b23e481507c	\N	\N	\N	UNPAID	f	\N	\N	2026-03-07 00:30:32.479	2026-03-07 00:30:32.479	\N
12	13	4c37eaaf-7f3c-491d-85d5-f1f1071044d5	\N	\N	\N	UNPAID	f	\N	\N	2026-03-07 00:30:32.499	2026-03-07 00:30:32.499	\N
\.


--
-- Data for Name: Bed; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public."Bed" (id, name, code, price, type, status, "createdAt", "updatedAt") FROM stdin;
cc3206cd-92c7-4ffd-b193-9ccd3d65ddec	Private Room 201	PR-201	4500	PRIVATE	OCCUPIED	2026-02-08 20:11:24.407	2026-02-08 21:16:10.049
d47d1c29-7d97-422c-bfb1-5c3f57a27457	Ward 1 - Bed B	W1-B	1500	GENERAL	OCCUPIED	2026-02-08 20:11:24.404	2026-02-09 18:06:21.032
888a339c-afc2-473b-b060-881a228f1637	ICU Bed 1	ICU-1	8000	ICU	OCCUPIED	2026-02-08 20:11:24.409	2026-02-22 10:25:30.213
\.


--
-- Data for Name: BillPayment; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public."BillPayment" (id, "billingId", "patientId", amount, type, "bankName", "transNumber", "insuranceId", notes, "createdAt", "updatedAt") FROM stdin;
13b86c7e-cbc5-4688-b863-a66d9248b14f	565f7ac3-3383-4435-8bd6-ccc0a100a99b	PAT-2026-123	150	CASH	\N	\N	\N	\N	2026-02-26 16:14:52.391	2026-02-26 16:14:52.391
c6bae8bf-485e-4a7d-8253-9d697ab061e3	4859bb9d-9193-4401-aed9-28704cad74a0	PAT-2026-123	100	CASH	\N	\N	\N	Partial payment	2026-02-26 20:34:26.935	2026-02-26 20:34:26.935
fee88234-6355-433c-acc2-cb9048517c81	4859bb9d-9193-4401-aed9-28704cad74a0	PAT-2026-123	1580	CREDIT	\N	\N	\N	Converted to debt/credit	2026-02-26 20:34:26.935	2026-02-26 20:34:26.935
9627d4db-e90b-4674-901c-2ceac99a2b22	c9a6d937-715d-4e16-a194-36b9c56575b3	PAT-2026-123	0	CASH	\N	\N	\N	Partial payment	2026-02-26 21:33:44.356	2026-02-26 21:33:44.356
a40e6761-4d66-4c95-8271-ce7d7f337ae8	c9a6d937-715d-4e16-a194-36b9c56575b3	PAT-2026-123	300	CREDIT	\N	\N	\N	Converted to debt/credit	2026-02-26 21:33:44.356	2026-02-26 21:33:44.356
c9388f5a-3d4e-4691-9509-e6eefc599763	2d814428-f385-46b5-97e8-d083d36f1613	PAT-2026-123	2625	CASH	\N	\N	\N	\N	2026-03-03 06:41:50.463	2026-03-03 06:41:50.463
3ee80d72-173f-42ae-a27e-cc7f16d79d96	4d599aa8-8d80-4378-ba85-9b75423ff398	PAT-2026-128	100	CASH	\N	\N	\N	\N	2026-03-04 04:21:31.493	2026-03-04 04:21:31.493
481d94dd-947c-439f-8db6-b8efbacaa880	43c12a4a-283c-4a51-9fac-f9934456157e	PAT-2026-127	100	CASH	\N	\N	\N	\N	2026-03-04 12:18:18.796	2026-03-04 12:18:18.796
2e4d820f-4bf7-45f4-bd36-5b0f39ac7889	f35553db-dafa-4124-90b2-9fcde72fcab0	PAT-2026-128	580	CASH	\N	\N	\N	\N	2026-03-04 12:43:05.614	2026-03-04 12:43:05.614
06dc505b-4017-47fa-91a8-368fe8587759	10bcf069-1dc7-495a-8c08-34eeb0b5b0db	PAT-2026-128	400	CASH	\N	\N	\N	\N	2026-03-04 18:07:23.22	2026-03-04 18:07:23.22
a87ea8e7-86a8-45a9-86c5-47b2540794e1	d06f4a3e-392f-4a6a-ba38-fd6bfbcb7dbe	PAT-2026-128	1920	CASH	\N	\N	\N	\N	2026-03-04 23:37:23.969	2026-03-04 23:37:23.969
c44d0d7d-0e88-4add-8c3d-ff4ba1e1dcdc	f9440a07-3755-4fa5-bf83-68323aef694b	PAT-2026-128	1030	CASH	\N	\N	\N	\N	2026-03-04 23:41:15.888	2026-03-04 23:41:15.888
7ea98616-f0d1-4593-8eac-4f1d01e4a364	de1ca327-967c-412f-87f6-49d6ba0dc2cf	PAT-2026-123	3100	CASH	\N	\N	\N	\N	2026-03-06 23:11:23.466	2026-03-06 23:11:23.466
18b30bf5-b64c-4257-a518-5f5662ca6931	638d2d44-b5e2-4d6d-853b-7ba449454b81	PAT-2026-128	50	CASH	\N	\N	\N	\N	2026-03-06 23:13:47.236	2026-03-06 23:13:47.236
96b84ebc-ab61-4785-a727-60e4f48417ec	c1246272-2802-49ee-851a-aeee53ec5a27	PAT-2026-128	2150	CASH	\N	\N	\N	\N	2026-03-06 23:24:12.137	2026-03-06 23:24:12.137
261cbb06-9f8b-4949-849a-ee62389d1f9b	797281fa-fd7c-4e53-b5bb-30c3225de465	PAT-2026-129	100	CASH	\N	\N	\N	\N	2026-03-06 23:26:45.73	2026-03-06 23:26:45.73
694f5149-1bce-49bc-a421-ab87aad3d1c5	331f4fc5-2c0e-483e-8ca2-0444255da0f6	PAT-2026-130	100	CASH	\N	\N	\N	\N	2026-03-06 23:26:48.544	2026-03-06 23:26:48.544
2b97c195-c97c-460e-99b0-f12686ffb8da	9d3dc6be-6610-4b0f-b0ac-4e1746bba2c3	PAT-2026-135	200	CASH	\N	\N	\N	\N	2026-03-07 00:06:24.571	2026-03-07 00:06:24.571
b8fa1edb-d542-44d3-a2a4-306cbb6a5ac8	b536c6f1-9988-4786-88f4-22836ef851cb	PAT-2026-134	100	CASH	\N	\N	\N	\N	2026-03-07 00:06:26.945	2026-03-07 00:06:26.945
9b6cb29d-231b-45bf-95ee-8792fdc1cb5b	fe69fa5e-e226-49c6-b0fb-55e203a3097d	PAT-2026-128	1650	CASH	\N	\N	\N	\N	2026-03-07 00:30:43.88	2026-03-07 00:30:43.88
8bd0e832-8f1e-4fcb-8ccc-abf7b655f076	c5562a1d-6812-497b-91ad-c2e3fc979684	PAT-2026-133	100	CASH	\N	\N	\N	\N	2026-03-07 01:38:26.577	2026-03-07 01:38:26.577
4a189327-e51c-4566-bbd0-ff4980b17174	f7db5075-e975-4f8c-b8ce-7f6514814291	NURSE-20260307-001	160	CASH	\N	\N	\N	\N	2026-03-07 02:17:23.06	2026-03-07 02:17:23.06
f794dcbb-8bf7-4a45-a7ee-78e49e5ee777	b666fc6c-2ecf-4837-baa9-1fce494a3f07	LAB-20260307-001	275	CASH	\N	\N	\N	\N	2026-03-07 02:17:26.731	2026-03-07 02:17:26.731
07d0c428-cdb9-4332-9be1-b43fed029bc3	0c6dba6a-2bce-4eb3-a5ea-e2724b524b0c	LAB-20260307-003	525	CASH	\N	\N	\N	\N	2026-03-07 03:03:19.608	2026-03-07 03:03:19.608
\.


--
-- Data for Name: Billing; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public."Billing" (id, "patientId", "visitId", "insuranceId", "totalAmount", status, "billingType", notes, "createdAt", "updatedAt", discount, "isDeferred", "paidAmount") FROM stdin;
4d599aa8-8d80-4378-ba85-9b75423ff398	PAT-2026-128	2	\N	100	PAID	REGULAR	REGULAR patient card registration	2026-03-04 04:21:20.938	2026-03-04 04:21:31.536	0	f	100
565f7ac3-3383-4435-8bd6-ccc0a100a99b	PAT-2026-123	1	\N	150	PAID	REGULAR	Diagnostics billing	2026-02-26 16:14:35.088	2026-02-26 16:14:52.426	0	f	150
638d2d44-b5e2-4d6d-853b-7ba449454b81	PAT-2026-128	2	\N	50	PAID	REGULAR	Diagnostics billing	2026-03-06 23:13:36.889	2026-03-06 23:13:47.262	0	f	50
c1246272-2802-49ee-851a-aeee53ec5a27	PAT-2026-128	2	\N	2150	PAID	REGULAR	Procedures: dipo provera, Implanole removal, abscess drainage large	2026-03-06 23:24:00.502	2026-03-06 23:24:12.166	0	f	2150
43c12a4a-283c-4a51-9fac-f9934456157e	PAT-2026-127	3	\N	100	PAID	REGULAR	REGULAR patient card registration	2026-03-01 02:17:29.27	2026-03-04 12:18:18.88	0	f	100
f35553db-dafa-4124-90b2-9fcde72fcab0	PAT-2026-128	2	\N	580	PAID	REGULAR	Diagnostics billing	2026-03-04 11:56:50.737	2026-03-04 12:43:05.646	0	f	580
4859bb9d-9193-4401-aed9-28704cad74a0	PAT-2026-123	1	\N	1680	PAID	REGULAR	Doctor ordered: Bandage/Dressing Change; Doctor ordered: Injection Administration + Dental services: CBCT Scan (Dental) (×1)	2026-02-26 20:17:44.743	2026-02-26 20:34:26.952	0	f	1680
bb64b9e0-61b9-495c-805d-8e9e8d6a89ea	PAT-2026-123	1	\N	2500	PAID	REGULAR	DEFERRED_CONNECTED: Crown Placement (×1) - covered by existing credit/payment	2026-02-26 20:34:55.48	2026-02-26 20:34:55.48	0	t	2500
fe69fa5e-e226-49c6-b0fb-55e203a3097d	PAT-2026-128	2	\N	1650	PAID	REGULAR	Procedures: Foreign Body Removal, implant insertion, Implanole removal	2026-03-07 00:30:32.53	2026-03-07 00:30:43.901	0	f	1650
10bcf069-1dc7-495a-8c08-34eeb0b5b0db	PAT-2026-128	2	\N	400	PAID	REGULAR	Combined diagnostics billing - lab and radiology	2026-03-04 18:07:06.355	2026-03-04 18:07:23.235	0	f	400
c9a6d937-715d-4e16-a194-36b9c56575b3	PAT-2026-123	1	\N	300	PAID	REGULAR	Dental services: Dental Cleaning (×1)	2026-02-26 20:42:31.157	2026-02-26 21:33:44.409	0	f	300
797281fa-fd7c-4e53-b5bb-30c3225de465	PAT-2026-129	4	\N	100	PAID	REGULAR	REGULAR patient card registration	2026-03-06 23:25:55.776	2026-03-06 23:26:45.816	0	f	100
d06f4a3e-392f-4a6a-ba38-fd6bfbcb7dbe	PAT-2026-128	2	\N	1920	PAID	REGULAR	Procedures: abscess drainage large + Diagnostics services	2026-03-04 23:27:42.937	2026-03-04 23:37:24.003	0	f	1920
2d814428-f385-46b5-97e8-d083d36f1613	PAT-2026-123	1	\N	2625	PAID	REGULAR	Diagnostics billing + Procedures: Abscess Drainage, abscess drainage large	2026-03-03 06:21:23.898	2026-03-03 06:41:50.479	0	f	2625
c5562a1d-6812-497b-91ad-c2e3fc979684	PAT-2026-133	8	\N	100	PAID	REGULAR	REGULAR patient card registration	2026-03-06 23:55:15.426	2026-03-07 01:38:26.612	0	f	100
331f4fc5-2c0e-483e-8ca2-0444255da0f6	PAT-2026-130	5	\N	100	PAID	REGULAR	REGULAR patient card registration	2026-03-06 23:26:19.56	2026-03-06 23:26:48.618	0	f	100
64e47ed2-7912-4b48-a754-7711492fc878	PAT-2026-131	\N	\N	100	PENDING	REGULAR	REGULAR patient card registration	2026-03-06 23:50:27.255	2026-03-06 23:50:27.255	0	f	0
8d3c5df0-59f8-40e3-a5f2-1e56b766c96f	PAT-2026-132	\N	\N	100	PENDING	REGULAR	REGULAR patient card registration	2026-03-06 23:52:43.536	2026-03-06 23:52:43.536	0	f	0
f9440a07-3755-4fa5-bf83-68323aef694b	PAT-2026-128	2	\N	1030	PAID	REGULAR	Emergency drug: adernalin 1ml; Material needs: Alcohol Wipes (Pack) + Diagnostics services; Doctor ordered: Temperature Check (Walk-in), Urinary Catheterization	2026-03-04 23:40:35.711	2026-03-04 23:41:15.918	0	f	1030
de1ca327-967c-412f-87f6-49d6ba0dc2cf	PAT-2026-123	1	\N	3100	PAID	REGULAR	Diagnostics billing	2026-03-03 06:44:11.239	2026-03-06 23:11:23.487	0	f	3100
9d3dc6be-6610-4b0f-b0ac-4e1746bba2c3	PAT-2026-135	6	\N	200	PAID	REGULAR	REGULAR patient card registration (DERMATOLOGY)	2026-03-07 00:06:11.585	2026-03-07 00:06:24.605	0	f	200
f7db5075-e975-4f8c-b8ce-7f6514814291	NURSE-20260307-001	\N	\N	160	PAID	REGULAR	Walk-in nurse service order	2026-03-07 02:17:07.849	2026-03-07 02:17:23.077	0	f	160
b536c6f1-9988-4786-88f4-22836ef851cb	PAT-2026-134	7	\N	100	PAID	REGULAR	REGULAR patient card registration (GENERAL)	2026-03-07 00:05:51.535	2026-03-07 00:06:27.001	0	f	100
b666fc6c-2ecf-4837-baa9-1fce494a3f07	LAB-20260307-001	\N	\N	275	PAID	REGULAR	Walk-in lab order	2026-03-07 02:16:34.565	2026-03-07 02:17:26.757	0	f	275
0c6dba6a-2bce-4eb3-a5ea-e2724b524b0c	LAB-20260307-003	\N	\N	525	PAID	REGULAR	Walk-in lab order	2026-03-07 03:03:12.641	2026-03-07 03:03:19.621	0	f	525
14d0d5a0-09d0-4eba-8964-e60631e17f69	PAT-2026-123	1	\N	450	PENDING	REGULAR	Emergency drug: ceftraxon 1gr; Emergency drug: cimtidin 200mg	2026-03-07 04:02:11.453	2026-03-07 04:02:11.485	0	f	0
\.


--
-- Data for Name: BillingService; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public."BillingService" (id, "billingId", "serviceId", quantity, "unitPrice", "totalPrice", "createdAt") FROM stdin;
47172bd9-4c0d-49ef-8d2f-a4a43741837c	565f7ac3-3383-4435-8bd6-ccc0a100a99b	0fe08c72-72ef-447d-8879-07e29effa8d3	1	150	150	2026-02-26 16:14:35.106
bafa587c-b807-4591-a735-2fac3398d362	4859bb9d-9193-4401-aed9-28704cad74a0	34e86984-f8e7-4e53-af10-063dd0b81be8	1	100	100	2026-02-26 20:17:44.743
ca2660f7-6d0e-42b5-8fbe-6df3cbb9276d	4859bb9d-9193-4401-aed9-28704cad74a0	b79e70ef-806a-4f08-b395-0b0fa16dc853	1	80	80	2026-02-26 20:31:35.135
7eff8c2c-76d8-4d8e-b61d-eb409a809099	4859bb9d-9193-4401-aed9-28704cad74a0	3f5da570-ee41-401b-90e7-f940af71652c	1	1500	1500	2026-02-26 20:32:50.808
77fa25c5-866b-4db5-858b-7f0c04791809	bb64b9e0-61b9-495c-805d-8e9e8d6a89ea	d9c83637-a7cf-4280-a45c-059d25780db5	1	2500	2500	2026-02-26 20:34:55.48
f34ce458-4244-4857-84be-03d758f3b59f	c9a6d937-715d-4e16-a194-36b9c56575b3	9f2b8113-651f-4fb4-9ce7-ecad4042c6ee	1	300	300	2026-02-26 20:42:31.157
ccf6f1f8-135d-4cea-88b9-70762677ea6e	43c12a4a-283c-4a51-9fac-f9934456157e	0a5a276d-e8a7-4ac1-a235-2b1b1192250f	1	100	100	2026-03-01 02:17:29.273
22b753ae-92d3-4bc3-b635-5e3d002578a9	2d814428-f385-46b5-97e8-d083d36f1613	3566536f-f272-4574-a8ab-513df7f9e597	1	400	400	2026-03-03 06:22:19.111
a5031d83-0ad0-4623-91d9-f18ba015bfac	2d814428-f385-46b5-97e8-d083d36f1613	22eedf04-fddd-4023-a109-114495c9e1e9	1	125	125	2026-03-03 06:22:19.114
b4fb82a9-3b10-4bd5-bbcb-f8af287d0eec	2d814428-f385-46b5-97e8-d083d36f1613	8f314fd1-be41-49b7-a5c3-1fd600988ee7	1	600	600	2026-03-03 06:24:08.388
a4db2356-8f50-4167-bbf4-e0dbe1f407a7	2d814428-f385-46b5-97e8-d083d36f1613	0ab83526-9e53-4dab-9029-568c62959ceb	1	1500	1500	2026-03-03 06:24:08.391
fb45c6fe-d623-4c4d-8b39-8b4bc450f1b1	de1ca327-967c-412f-87f6-49d6ba0dc2cf	fc89be43-0f24-4580-87c8-f0c15fdce005	1	1500	1500	2026-03-03 08:25:50.026
8c113d15-bab1-41b2-8819-7be5d3b9b0eb	de1ca327-967c-412f-87f6-49d6ba0dc2cf	080d52da-cc95-414c-a14c-008863579360	1	50	50	2026-03-03 08:25:50.037
05351779-b0e7-4df3-aeca-59bc1ab6ae50	4d599aa8-8d80-4378-ba85-9b75423ff398	0a5a276d-e8a7-4ac1-a235-2b1b1192250f	1	100	100	2026-03-04 04:21:20.943
e16c497a-5cc3-47af-805b-cf0454e54ab0	f35553db-dafa-4124-90b2-9fcde72fcab0	0f4eeaba-9421-439a-ae57-4a1daa0caedc	1	250	250	2026-03-04 11:56:50.746
ff2d377f-4131-4f51-ae71-cd967ead2cc5	f35553db-dafa-4124-90b2-9fcde72fcab0	d32b6a47-2e50-46bb-be57-cd3bb5c45dca	1	250	250	2026-03-04 11:56:50.748
2ff93922-09b7-441f-94eb-0c7737639a4f	f35553db-dafa-4124-90b2-9fcde72fcab0	44cca180-f38a-42d4-b037-dc59cda1a186	1	80	80	2026-03-04 12:42:57.864
671ba54f-18b8-4538-839f-8f55f55de595	10bcf069-1dc7-495a-8c08-34eeb0b5b0db	907e9fd6-af1d-477e-a8a3-2ebc17a45e53	1	400	400	2026-03-04 18:07:06.355
84e9ef21-3b84-4474-8eb7-197201e2390f	d06f4a3e-392f-4a6a-ba38-fd6bfbcb7dbe	0ab83526-9e53-4dab-9029-568c62959ceb	1	1500	1500	2026-03-04 23:27:42.937
3da03ae0-61b9-49b3-882f-caec918e3b39	d06f4a3e-392f-4a6a-ba38-fd6bfbcb7dbe	6fe4b74f-36ed-4f8f-b28c-9e045e07acda	1	420	420	2026-03-04 23:27:52.792
47e76ca0-d657-4da6-bbf2-3c20271db246	f9440a07-3755-4fa5-bf83-68323aef694b	4596a8dc-cb6f-4111-acf7-2f97f2daa51a	1	300	300	2026-03-04 23:40:35.711
368d07b8-5130-45a6-a832-44f36a695d75	f9440a07-3755-4fa5-bf83-68323aef694b	69a3246e-38ac-4ae7-b89b-1ecc24d1e92e	1	50	50	2026-03-04 23:40:41.113
0c6603fc-ae14-46d8-98f9-e420636be8f9	f9440a07-3755-4fa5-bf83-68323aef694b	907e9fd6-af1d-477e-a8a3-2ebc17a45e53	1	400	400	2026-03-04 23:40:49.838
347acc33-ca8d-4e36-845f-c7f983ed1280	f9440a07-3755-4fa5-bf83-68323aef694b	af26fc2a-3fe5-4085-a203-4f1ab0a10cfb	1	30	30	2026-03-04 23:41:06.934
e8d60c68-63d8-4d2f-b88a-439a80c354d9	f9440a07-3755-4fa5-bf83-68323aef694b	246000c3-27b3-41d6-9572-11e3808dbcc0	1	250	250	2026-03-04 23:41:06.934
73d784d0-c87c-4024-a2f5-590eacd05b24	638d2d44-b5e2-4d6d-853b-7ba449454b81	c526a802-11d4-441e-aa7e-867d20244d4f	1	50	50	2026-03-06 23:13:36.91
4e438aee-5fe8-475e-ae96-6a7de070c21a	c1246272-2802-49ee-851a-aeee53ec5a27	0ab83526-9e53-4dab-9029-568c62959ceb	1	1500	1500	2026-03-06 23:24:00.502
0c369ccd-6e81-41e0-b23c-326b793073ce	c1246272-2802-49ee-851a-aeee53ec5a27	03b55355-5dfd-40c7-865a-040e683a2f63	1	150	150	2026-03-06 23:24:00.502
0ef16c62-ccf9-4555-b90c-019cac41c5d5	c1246272-2802-49ee-851a-aeee53ec5a27	91345ec8-5b95-4d92-8082-d202a229dffc	1	500	500	2026-03-06 23:24:00.502
045b9861-affa-4423-9175-ef3b4ba73f78	797281fa-fd7c-4e53-b5bb-30c3225de465	0a5a276d-e8a7-4ac1-a235-2b1b1192250f	1	100	100	2026-03-06 23:25:55.782
f9f1d826-9ed2-45d9-a476-c3ffa2b6e330	331f4fc5-2c0e-483e-8ca2-0444255da0f6	0a5a276d-e8a7-4ac1-a235-2b1b1192250f	1	100	100	2026-03-06 23:26:19.565
a32ec4fd-350a-4607-92d0-cbb449e2d30e	64e47ed2-7912-4b48-a754-7711492fc878	0a5a276d-e8a7-4ac1-a235-2b1b1192250f	1	100	100	2026-03-06 23:50:27.258
ed0fbbd8-701d-47b5-b09d-c7800525e90c	8d3c5df0-59f8-40e3-a5f2-1e56b766c96f	0a5a276d-e8a7-4ac1-a235-2b1b1192250f	1	100	100	2026-03-06 23:52:43.54
d6c56cd3-cc4c-4e8a-a4bc-6463e5925a94	c5562a1d-6812-497b-91ad-c2e3fc979684	0a5a276d-e8a7-4ac1-a235-2b1b1192250f	1	100	100	2026-03-06 23:55:15.429
d2cccfb4-ed35-4395-9488-4657c0b7e877	b536c6f1-9988-4786-88f4-22836ef851cb	0a5a276d-e8a7-4ac1-a235-2b1b1192250f	1	100	100	2026-03-07 00:05:51.538
6532bda4-e583-46ca-bc50-5a091962e60e	9d3dc6be-6610-4b0f-b0ac-4e1746bba2c3	d6b22240-5eb4-497f-82f8-7978c910d3c0	1	200	200	2026-03-07 00:06:11.587
c79f107f-5ada-4326-9c6d-36927bb24813	fe69fa5e-e226-49c6-b0fb-55e203a3097d	9440874e-c28e-40ca-88d8-1b23e481507c	1	400	400	2026-03-07 00:30:32.53
c9d35faa-6f3b-4bde-a23e-9a9de8b703e9	fe69fa5e-e226-49c6-b0fb-55e203a3097d	91345ec8-5b95-4d92-8082-d202a229dffc	1	500	500	2026-03-07 00:30:32.53
adacecb9-7bc7-4c56-a9b5-516551438c33	fe69fa5e-e226-49c6-b0fb-55e203a3097d	4c37eaaf-7f3c-491d-85d5-f1f1071044d5	1	750	750	2026-03-07 00:30:32.53
4c25e99e-b691-4724-a728-e9efd690b064	b666fc6c-2ecf-4837-baa9-1fce494a3f07	22eedf04-fddd-4023-a109-114495c9e1e9	1	125	125	2026-03-07 02:16:34.565
24958408-8597-4d2f-a7c2-fa3e4dec7f07	b666fc6c-2ecf-4837-baa9-1fce494a3f07	66f5dc69-e9c2-4c46-9e20-ebeb319a629d	1	150	150	2026-03-07 02:16:34.565
e1176dd5-58a6-4e71-af14-d172b2a0ab00	f7db5075-e975-4f8c-b8ce-7f6514814291	314fd0ec-8a69-454c-9c6e-5c5f4b71126f	1	100	100	2026-03-07 02:17:07.849
b221ce59-175d-4875-8d33-4fc8df37773e	f7db5075-e975-4f8c-b8ce-7f6514814291	5160e0b7-0e04-4532-8823-4cdae4841417	1	60	60	2026-03-07 02:17:07.849
130cc1fc-2fa4-42bf-9708-d84bcfd28e1c	0c6dba6a-2bce-4eb3-a5ea-e2724b524b0c	22eedf04-fddd-4023-a109-114495c9e1e9	1	125	125	2026-03-07 03:03:12.641
e79f8309-ab45-419c-bef6-972c6e10e0fb	0c6dba6a-2bce-4eb3-a5ea-e2724b524b0c	3566536f-f272-4574-a8ab-513df7f9e597	1	400	400	2026-03-07 03:03:12.641
abd9bbcb-5de2-4fb8-abf2-6a1e132389ac	14d0d5a0-09d0-4eba-8964-e60631e17f69	7999d55e-285c-493c-9367-ee25456a9ce2	1	200	200	2026-03-07 04:02:11.453
86b708a3-3c70-4dd4-847d-ca6f99efd584	14d0d5a0-09d0-4eba-8964-e60631e17f69	abf3fc5d-d052-4c46-a421-1347cb995556	1	250	250	2026-03-07 04:02:11.481
\.


--
-- Data for Name: CardActivation; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public."CardActivation" (id, "patientId", "activatedById", "activatedAt", "expiresAt", "billingId", notes, "createdAt") FROM stdin;
1	PAT-2026-128	45aa0bdd-f1a9-4fbe-8125-358e94cba160	2026-03-04 04:21:31.52	2026-04-03 04:21:31.52	4d599aa8-8d80-4378-ba85-9b75423ff398	Initial card registration	2026-03-04 04:21:31.525
2	PAT-2026-127	45aa0bdd-f1a9-4fbe-8125-358e94cba160	2026-03-04 12:18:18.837	2026-04-03 12:18:18.837	43c12a4a-283c-4a51-9fac-f9934456157e	Initial card registration	2026-03-04 12:18:18.849
3	PAT-2026-129	45aa0bdd-f1a9-4fbe-8125-358e94cba160	2026-03-06 23:26:45.767	2026-04-05 23:26:45.767	797281fa-fd7c-4e53-b5bb-30c3225de465	Initial card registration	2026-03-06 23:26:45.784
4	PAT-2026-130	45aa0bdd-f1a9-4fbe-8125-358e94cba160	2026-03-06 23:26:48.582	2026-04-05 23:26:48.582	331f4fc5-2c0e-483e-8ca2-0444255da0f6	Initial card registration	2026-03-06 23:26:48.593
5	PAT-2026-135	45aa0bdd-f1a9-4fbe-8125-358e94cba160	2026-03-07 00:06:24.589	2026-04-06 00:06:24.589	9d3dc6be-6610-4b0f-b0ac-4e1746bba2c3	Initial card registration	2026-03-07 00:06:24.594
6	PAT-2026-134	45aa0bdd-f1a9-4fbe-8125-358e94cba160	2026-03-07 00:06:26.975	2026-04-06 00:06:26.975	b536c6f1-9988-4786-88f4-22836ef851cb	Initial card registration	2026-03-07 00:06:26.984
7	PAT-2026-133	192e9573-7cd6-4c43-992b-09ea2e3c3a3d	2026-03-07 01:38:26.595	2026-04-06 01:38:26.595	c5562a1d-6812-497b-91ad-c2e3fc979684	Initial card registration	2026-03-07 01:38:26.602
\.


--
-- Data for Name: CashExpense; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public."CashExpense" (id, "sessionId", amount, category, description, vendor, "receiptImage", "recordedById", "createdAt") FROM stdin;
\.


--
-- Data for Name: CashTransaction; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public."CashTransaction" (id, "sessionId", type, amount, description, "paymentMethod", "billingId", "patientId", "processedById", "createdAt") FROM stdin;
7061c0d1-2743-44bb-9565-7d45eb1bed5f	7fed8b9f-5ca6-4845-9f78-6bc0e4b15c2a	PAYMENT_RECEIVED	150	Payment from mirakel yohanse (PAT-2026-123) - Blood Film (BF)	CASH	565f7ac3-3383-4435-8bd6-ccc0a100a99b	PAT-2026-123	45aa0bdd-f1a9-4fbe-8125-358e94cba160	2026-02-26 16:14:52.482
a52ce072-eaf6-4709-8527-7e7a19295956	7fed8b9f-5ca6-4845-9f78-6bc0e4b15c2a	PAYMENT_RECEIVED	100	Payment from mirakel yohanse (PAT-2026-123) - Bandage/Dressing Change, Injection Administration, CBCT Scan (Dental)	CASH	4859bb9d-9193-4401-aed9-28704cad74a0	PAT-2026-123	45aa0bdd-f1a9-4fbe-8125-358e94cba160	2026-02-26 20:34:26.967
f13a17db-a713-4ea9-b7d3-2e3f897ac833	7fed8b9f-5ca6-4845-9f78-6bc0e4b15c2a	PAYMENT_RECEIVED	1000	Credit payment from mirakel yohanse - Debt clearance	CASH	\N	\N	45aa0bdd-f1a9-4fbe-8125-358e94cba160	2026-02-26 20:50:28.709
40f740b8-2519-4684-8416-d075dbc88268	7fed8b9f-5ca6-4845-9f78-6bc0e4b15c2a	PAYMENT_RECEIVED	300	Credit payment from mirakel yohanse - Debt clearance	CASH	\N	\N	45aa0bdd-f1a9-4fbe-8125-358e94cba160	2026-02-26 21:10:19.721
1eef55ef-9306-4b34-8cdd-cd233f5d3669	270bf46e-da6e-45b5-8e0b-ac6b302af7e7	PAYMENT_RECEIVED	2625	Payment from mirakel yohanse (PAT-2026-123) - Complete Blood Count (CBC), ESR, Abscess Drainage, abscess drainage large	CASH	2d814428-f385-46b5-97e8-d083d36f1613	PAT-2026-123	45aa0bdd-f1a9-4fbe-8125-358e94cba160	2026-03-03 06:41:50.496
8f59f995-2f90-4246-8baf-f07aa4592a08	bea2bab0-1aa5-4069-a39a-f265bb6ce19b	PAYMENT_RECEIVED	100	Payment from Hayder Aman Temam (PAT-2026-128) - Patient Card Registration	CASH	4d599aa8-8d80-4378-ba85-9b75423ff398	PAT-2026-128	45aa0bdd-f1a9-4fbe-8125-358e94cba160	2026-03-04 04:21:31.547
77a86368-0229-4089-833c-5c715c09b2e8	bea2bab0-1aa5-4069-a39a-f265bb6ce19b	PAYMENT_RECEIVED	100	Payment from Hayder Aman Temam (PAT-2026-127) - Patient Card Registration	CASH	43c12a4a-283c-4a51-9fac-f9934456157e	PAT-2026-127	45aa0bdd-f1a9-4fbe-8125-358e94cba160	2026-03-04 12:18:18.897
d5473e74-a02b-4f9f-8e2c-267a40834d52	bea2bab0-1aa5-4069-a39a-f265bb6ce19b	PAYMENT_RECEIVED	580	Payment from Hayder Aman Temam (PAT-2026-128) - H. pylori Antibody (Serology), H. pylori Antigen (Stool Test), KOH Preparation	CASH	f35553db-dafa-4124-90b2-9fcde72fcab0	PAT-2026-128	45aa0bdd-f1a9-4fbe-8125-358e94cba160	2026-03-04 12:43:05.689
4701dcef-f2cc-451d-a3b4-38a9392e8072	bea2bab0-1aa5-4069-a39a-f265bb6ce19b	PAYMENT_RECEIVED	400	Payment from Hayder Aman Temam (PAT-2026-128) - Abdominal Ultrasound	CASH	10bcf069-1dc7-495a-8c08-34eeb0b5b0db	PAT-2026-128	45aa0bdd-f1a9-4fbe-8125-358e94cba160	2026-03-04 18:07:23.275
e5c8d590-6139-405c-ac0c-f8bf369e1d6a	6dffb62d-7c1b-4659-af50-26509b4966ad	PAYMENT_RECEIVED	1920	Payment from Hayder Aman Temam (PAT-2026-128) - abscess drainage large, Obstetric Ultrasound	CASH	d06f4a3e-392f-4a6a-ba38-fd6bfbcb7dbe	PAT-2026-128	45aa0bdd-f1a9-4fbe-8125-358e94cba160	2026-03-04 23:37:24.057
c2377e7e-12da-4282-9f28-25a5ba8a1440	6dffb62d-7c1b-4659-af50-26509b4966ad	PAYMENT_RECEIVED	1030	Payment from Hayder Aman Temam (PAT-2026-128) - adernalin 1ml, Alcohol Wipes (Pack), Abdominal Ultrasound, Temperature Check (Walk-in), Urinary Catheterization	CASH	f9440a07-3755-4fa5-bf83-68323aef694b	PAT-2026-128	45aa0bdd-f1a9-4fbe-8125-358e94cba160	2026-03-04 23:41:15.983
bc7d7812-1a0b-4c54-8330-4428bf8b315d	8751233d-4117-497b-b046-2bc60fe466a9	PAYMENT_RECEIVED	3100	Payment from mirakel yohanse (PAT-2026-123) - HbA1c, Fasting Blood Glucose	CASH	de1ca327-967c-412f-87f6-49d6ba0dc2cf	PAT-2026-123	45aa0bdd-f1a9-4fbe-8125-358e94cba160	2026-03-06 23:11:23.527
50f802be-2757-4bac-b897-0972957f9bd8	8751233d-4117-497b-b046-2bc60fe466a9	PAYMENT_RECEIVED	50	Payment from Hayder Aman Temam (PAT-2026-128) - Sample Examination	CASH	638d2d44-b5e2-4d6d-853b-7ba449454b81	PAT-2026-128	45aa0bdd-f1a9-4fbe-8125-358e94cba160	2026-03-06 23:13:47.297
92650674-73cb-4079-88e0-5a1349cfb634	8751233d-4117-497b-b046-2bc60fe466a9	PAYMENT_RECEIVED	2150	Payment from Hayder Aman Temam (PAT-2026-128) - abscess drainage large, dipo provera, Implanole removal	CASH	c1246272-2802-49ee-851a-aeee53ec5a27	PAT-2026-128	45aa0bdd-f1a9-4fbe-8125-358e94cba160	2026-03-06 23:24:12.188
1c8ccdda-991b-4077-b925-f882deed605f	8751233d-4117-497b-b046-2bc60fe466a9	PAYMENT_RECEIVED	100	Payment from Hanan Aman Temam (PAT-2026-129) - Patient Card Registration	CASH	797281fa-fd7c-4e53-b5bb-30c3225de465	PAT-2026-129	45aa0bdd-f1a9-4fbe-8125-358e94cba160	2026-03-06 23:26:45.834
5a158eb2-2bff-4042-abc5-bdb0a5356e43	8751233d-4117-497b-b046-2bc60fe466a9	PAYMENT_RECEIVED	100	Payment from jsdhfb (PAT-2026-130) - Patient Card Registration	CASH	331f4fc5-2c0e-483e-8ca2-0444255da0f6	PAT-2026-130	45aa0bdd-f1a9-4fbe-8125-358e94cba160	2026-03-06 23:26:48.632
f9da4844-e9f3-41d8-a06b-05922b4db999	8751233d-4117-497b-b046-2bc60fe466a9	PAYMENT_RECEIVED	200	Payment from a (PAT-2026-135) - Dermatology Patient Card Registration	CASH	9d3dc6be-6610-4b0f-b0ac-4e1746bba2c3	PAT-2026-135	45aa0bdd-f1a9-4fbe-8125-358e94cba160	2026-03-07 00:06:24.611
46a3fb69-34e6-4772-b88c-0d690d865e08	8751233d-4117-497b-b046-2bc60fe466a9	PAYMENT_RECEIVED	100	Payment from a (PAT-2026-134) - Patient Card Registration	CASH	b536c6f1-9988-4786-88f4-22836ef851cb	PAT-2026-134	45aa0bdd-f1a9-4fbe-8125-358e94cba160	2026-03-07 00:06:27.014
9e918923-3f6e-4d25-b229-15d661999e33	8751233d-4117-497b-b046-2bc60fe466a9	PAYMENT_RECEIVED	1650	Payment from Hayder Aman Temam (PAT-2026-128) - Foreign Body Removal, Implanole removal, implant insertion	CASH	fe69fa5e-e226-49c6-b0fb-55e203a3097d	PAT-2026-128	45aa0bdd-f1a9-4fbe-8125-358e94cba160	2026-03-07 00:30:43.913
752066c9-a88f-4c25-bb27-4a07ec1f4160	90d24882-05f9-4255-b432-d958989ed881	PAYMENT_RECEIVED	100	Payment from hanof Aman Temam (PAT-2026-133) - Patient Card Registration	CASH	c5562a1d-6812-497b-91ad-c2e3fc979684	PAT-2026-133	192e9573-7cd6-4c43-992b-09ea2e3c3a3d	2026-03-07 01:38:26.619
28903f1f-3a53-42cf-b989-51f0b3449564	8751233d-4117-497b-b046-2bc60fe466a9	PAYMENT_RECEIVED	160	Payment from Hanan Aman Temam (NURSE-20260307-001) - Bandage/Dressing (Walk-in), Blood Glucose Test (Walk-in)	CASH	f7db5075-e975-4f8c-b8ce-7f6514814291	NURSE-20260307-001	45aa0bdd-f1a9-4fbe-8125-358e94cba160	2026-03-07 02:17:23.086
4bfe1ba7-d512-4281-bb64-c0b85b0109fd	8751233d-4117-497b-b046-2bc60fe466a9	PAYMENT_RECEIVED	275	Payment from sdf (LAB-20260307-001) - ESR, Blood Group & Rh	CASH	b666fc6c-2ecf-4837-baa9-1fce494a3f07	LAB-20260307-001	45aa0bdd-f1a9-4fbe-8125-358e94cba160	2026-03-07 02:17:26.786
e8cfc62a-24bf-412e-b0ca-04642244fe3e	90d24882-05f9-4255-b432-d958989ed881	PAYMENT_RECEIVED	525	Payment from as (LAB-20260307-003) - ESR, Complete Blood Count (CBC)	CASH	0c6dba6a-2bce-4eb3-a5ea-e2724b524b0c	LAB-20260307-003	192e9573-7cd6-4c43-992b-09ea2e3c3a3d	2026-03-07 03:03:19.632
\.


--
-- Data for Name: CompoundIngredient; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public."CompoundIngredient" (id, "compoundPrescriptionId", "ingredientName", strength, unit, "isManualEntry", cost, "sortOrder") FROM stdin;
1	1	Clobetasol	0.05	%	t	\N	0
2	1	Salicylic Acid	5	%	t	\N	1
6	3	dyvclo	2	%	t	\N	0
7	4	as	2	%	f	\N	0
\.


--
-- Data for Name: CompoundPrescription; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public."CompoundPrescription" (id, "visitId", "patientId", "doctorId", "formulationType", "baseType", "customBase", quantity, "quantityUnit", "frequencyType", "frequencyValue", "durationValue", "durationUnit", instructions, "storageInstructions", warnings, "pharmacyNotes", "totalCost", "referenceNumber", "preparedBy", "preparedAt", "expiryDate", "createdAt", "updatedAt") FROM stdin;
1	1	PAT-2026-123	093cba71-ff80-4568-8969-f93c80ec0cf9	CREAM	CREAM_BASE	\N	30	G	TWICE_DAILY	\N	5	WEEKS	Apply in affected areas 	ROOM_TEMP	\N	\N	\N	CPD-MM6Z3JOT-61AG	\N	\N	\N	2026-02-28 23:49:30.607	2026-02-28 23:49:30.607
3	1	PAT-2026-123	093cba71-ff80-4568-8969-f93c80ec0cf9	CREAM	OINTMENT_BASE	\N	30	G	TWICE_DAILY	\N	5	WEEKS	ertyui	COOL	\N	\N	\N	CPD-MM736V2O-NI4L	\N	\N	\N	2026-03-01 01:44:03.794	2026-03-01 01:44:03.794
4	2	PAT-2026-128	093cba71-ff80-4568-8969-f93c80ec0cf9	CREAM	\N	\N	30	G	TWICE_DAILY	\N	2	WEEKS	\N	PROTECT_LIGHT	\N	\N	\N	CPD-MMCOM63U-DIJK	\N	\N	\N	2026-03-04 23:42:40.749	2026-03-04 23:42:40.749
\.


--
-- Data for Name: ContinuousInfusion; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public."ContinuousInfusion" (id, "medicationOrderId", "startDate", "endDate", "dailyDose", frequency, days, status, "createdAt", "updatedAt") FROM stdin;
\.


--
-- Data for Name: CustomMedication; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public."CustomMedication" (id, "doctorId", name, "genericName", "dosageForm", strength, quantity, route, instructions, "frequencyPeriod", "durationPeriod", category, "createdAt", "updatedAt", "atcCode", "deletedAt", "dosageFormCategory", "durationText", "durationUnit", "durationValue", "frequencyText", "frequencyType", "frequencyUnit", "frequencyValue", "isDeleted", "normalizedName", "routeCode", "rxnormCode", "snomedCode", "strengthText") FROM stdin;
c279cb02-517a-41af-b595-875fd78de54c	093cba71-ff80-4568-8969-f93c80ec0cf9	Paractamol	Paractamol	Tablet	450 mg	2	\N	\N	\N	\N	\N	2026-02-26 14:01:11.891	2026-02-26 14:01:11.891	\N	\N	ORAL_SOLID	7 Days	DAYS	7	Twice Daily	TWICE_DAILY	times	\N	f	paractamol	ORAL	\N	\N	\N
\.


--
-- Data for Name: DailyCashSession; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public."DailyCashSession" (id, "sessionDate", "startTime", "endTime", "startingCash", "totalReceived", "totalExpenses", "totalBankDeposit", "endingCash", status, "isReset", "createdById", "resetById", "resetAt", "createdAt", "updatedAt") FROM stdin;
7fed8b9f-5ca6-4845-9f78-6bc0e4b15c2a	2026-02-26 16:14:52.472	2026-02-26 16:14:52.474	\N	0	0	0	0	\N	ACTIVE	f	45aa0bdd-f1a9-4fbe-8125-358e94cba160	\N	\N	2026-02-26 16:14:52.474	2026-02-26 16:14:52.474
4a31f0c5-f7dd-47f7-8131-5839d37b3f84	2026-02-26 21:01:15.713	2026-02-26 21:01:15.716	\N	0	0	0	0	\N	ACTIVE	f	45aa0bdd-f1a9-4fbe-8125-358e94cba160	\N	\N	2026-02-26 21:01:15.716	2026-02-26 21:01:15.716
add5cc97-0723-41aa-a53c-65034c876cde	2026-02-26 21:01:15.718	2026-02-26 21:01:15.72	\N	0	0	0	0	\N	ACTIVE	f	45aa0bdd-f1a9-4fbe-8125-358e94cba160	\N	\N	2026-02-26 21:01:15.72	2026-02-26 21:01:15.72
270bf46e-da6e-45b5-8e0b-ac6b302af7e7	2026-03-03 06:41:50.493	2026-03-03 06:41:50.494	\N	0	0	0	0	\N	ACTIVE	f	45aa0bdd-f1a9-4fbe-8125-358e94cba160	\N	\N	2026-03-03 06:41:50.494	2026-03-03 06:41:50.494
bea2bab0-1aa5-4069-a39a-f265bb6ce19b	2026-03-04 04:21:31.542	2026-03-04 04:21:31.543	\N	0	0	0	0	\N	ACTIVE	f	45aa0bdd-f1a9-4fbe-8125-358e94cba160	\N	\N	2026-03-04 04:21:31.543	2026-03-04 04:21:31.543
6dffb62d-7c1b-4659-af50-26509b4966ad	2026-03-04 23:37:24.049	2026-03-04 23:37:24.051	\N	0	0	0	0	\N	ACTIVE	f	45aa0bdd-f1a9-4fbe-8125-358e94cba160	\N	\N	2026-03-04 23:37:24.051	2026-03-04 23:37:24.051
8751233d-4117-497b-b046-2bc60fe466a9	2026-03-06 22:40:12.895	2026-03-06 22:40:12.898	\N	0	0	0	0	\N	ACTIVE	f	45aa0bdd-f1a9-4fbe-8125-358e94cba160	\N	\N	2026-03-06 22:40:12.898	2026-03-06 22:40:12.898
beb34371-5505-4591-8ee1-7db78c13e553	2026-03-06 22:40:12.896	2026-03-06 22:40:12.901	\N	0	0	0	0	\N	ACTIVE	f	45aa0bdd-f1a9-4fbe-8125-358e94cba160	\N	\N	2026-03-06 22:40:12.901	2026-03-06 22:40:12.901
90d24882-05f9-4255-b432-d958989ed881	2026-03-07 01:32:59.348	2026-03-07 01:32:59.351	\N	0	0	0	0	\N	ACTIVE	f	192e9573-7cd6-4c43-992b-09ea2e3c3a3d	\N	\N	2026-03-07 01:32:59.351	2026-03-07 01:32:59.351
e4a29ea9-d235-45cb-9efe-0c224bf3a64c	2026-03-07 01:32:59.352	2026-03-07 01:32:59.354	\N	0	0	0	0	\N	ACTIVE	f	192e9573-7cd6-4c43-992b-09ea2e3c3a3d	\N	\N	2026-03-07 01:32:59.354	2026-03-07 01:32:59.354
\.


--
-- Data for Name: DentalPhoto; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public."DentalPhoto" (id, "visitId", "patientId", "doctorId", "photoType", "filePath", "fileName", "fileSize", "mimeType", description, "uploadedAt", "uploadedBy") FROM stdin;
\.


--
-- Data for Name: DentalProcedureCompletion; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public."DentalProcedureCompletion" (id, "batchOrderId", "batchOrderServiceId", "visitId", "patientId", "doctorId", "completedAt", notes, "createdAt", "updatedAt") FROM stdin;
\.


--
-- Data for Name: DentalRecord; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public."DentalRecord" (id, "patientId", "visitId", "doctorId", "toothId", conditions, surfaces, "eruptionStart", "eruptionEnd", "rootCompletion", "toothChart", "painFlags", "gumCondition", "oralHygiene", "treatmentPlan", notes, "createdAt", "updatedAt") FROM stdin;
\.


--
-- Data for Name: Department; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public."Department" (id, name, description, "createdAt", "updatedAt") FROM stdin;
\.


--
-- Data for Name: DetailedLabResult; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public."DetailedLabResult" (id, "labOrderId", "serviceId", "templateId", results, status, "verifiedBy", "verifiedAt", "additionalNotes", "createdAt", "updatedAt") FROM stdin;
\.


--
-- Data for Name: DiagnosisNotes; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public."DiagnosisNotes" (id, "visitId", "patientId", "doctorId", "chiefComplaint", "historyOfPresentIllness", "pastMedicalHistory", "allergicHistory", "physicalExamination", "investigationFindings", "assessmentAndDiagnosis", "treatmentPlan", "treatmentGiven", "medicationIssued", additional, prognosis, "createdAt", "updatedAt", "updatedBy") FROM stdin;
15297a05-b83d-4a40-a1ff-3704b74c9971	2	PAT-2026-128	093cba71-ff80-4568-8969-f93c80ec0cf9	bro is doenasd												2026-03-04 23:24:41.129	2026-03-05 21:31:19.764	093cba71-ff80-4568-8969-f93c80ec0cf9
52fea78d-7a01-4951-9cf5-d5ef525c3e90	1	PAT-2026-123	093cba71-ff80-4568-8969-f93c80ec0cf9	<p>hold on fuckin idiot</p>	clock it				Investigation findings for mirakel yohanse indicate							2026-02-26 19:56:46.87	2026-03-07 03:39:38.084	093cba71-ff80-4568-8969-f93c80ec0cf9
\.


--
-- Data for Name: Disease; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public."Disease" (id, code, name, category, "isReportable", "reportFrequency", "createdAt", "updatedAt") FROM stdin;
9b4f526e-0e85-4361-bf50-3858bee2d534	AFP	Acute Flaccid Paralysis (Polio)	Communicable	t	IMMEDIATE	2026-02-08 10:59:29.827	2026-02-08 10:59:29.827
dfac1366-1480-4bf6-9059-d836e2480700	ANT	Anthrax	Communicable	t	IMMEDIATE	2026-02-08 10:59:29.833	2026-02-08 10:59:29.833
6f65c2ef-a5f2-43a5-b96b-c13ca03ca7b1	AVI	Avian Human Influenza	Communicable	t	IMMEDIATE	2026-02-08 10:59:29.837	2026-02-08 10:59:29.837
1f8be747-5cd8-447a-8058-d50f8d7a1ca0	CHO	Cholera	Communicable	t	IMMEDIATE	2026-02-08 10:59:29.839	2026-02-08 10:59:29.839
8ba75c56-a30d-4570-aea6-04bfa88fc557	GUI	Dracunculiasis (Guinea Worm Disease)	NTD	t	IMMEDIATE	2026-02-08 10:59:29.841	2026-02-08 10:59:29.841
492b8cd3-3694-4eaa-8e10-a8737d0db043	MEA	Measles	Communicable	t	IMMEDIATE	2026-02-08 10:59:29.844	2026-02-08 10:59:29.844
682e1515-f725-4b80-ae6c-6a57f9599207	NTE	Neonatal Tetanus	Communicable	t	IMMEDIATE	2026-02-08 10:59:29.846	2026-02-08 10:59:29.846
1065bb82-0b43-46da-bcfd-faebe8f6c184	H1N1	Pandemic Influenza A (H1N1)	Communicable	t	IMMEDIATE	2026-02-08 10:59:29.85	2026-02-08 10:59:29.85
83301dbf-0eb9-4b4a-8e0d-b491e4c82b0c	RAB	Rabies	NTD	t	IMMEDIATE	2026-02-08 10:59:29.854	2026-02-08 10:59:29.854
fb13829c-24f9-4f6a-b867-77cf08f86c77	SARS	Severe Acute Respiratory Syndrome (SARS)	Communicable	t	IMMEDIATE	2026-02-08 10:59:29.857	2026-02-08 10:59:29.857
862007ce-38dc-4ce7-a396-522506cb3cb8	SMA	Smallpox	Communicable	t	IMMEDIATE	2026-02-08 10:59:29.859	2026-02-08 10:59:29.859
7bf352b2-0452-4db8-91da-6f7f8999eeec	VHF	Viral Hemorrhagic Fever	Communicable	t	IMMEDIATE	2026-02-08 10:59:29.861	2026-02-08 10:59:29.861
fec60cb3-d845-4034-828a-13392a794ff9	YEL	Yellow Fever	Communicable	t	IMMEDIATE	2026-02-08 10:59:29.864	2026-02-08 10:59:29.864
98243ea8-835b-4dea-93da-65f0bf7e460f	DYS	Dysentery	Communicable	t	WEEKLY	2026-02-08 10:59:29.868	2026-02-08 10:59:29.868
74830a85-ea9c-40d1-94a8-23a3635c3f42	MAL_PF	Malaria (P. falciparum)	Vector-borne	t	WEEKLY	2026-02-08 10:59:29.871	2026-02-08 10:59:29.871
5360cd39-3d88-4765-88ba-847c07776942	MAL_PV	Malaria (P. vivax)	Vector-borne	t	WEEKLY	2026-02-08 10:59:29.873	2026-02-08 10:59:29.873
3d5ab822-25e9-4ed4-90dc-f0846db5f00a	MAL_CLI	Malaria (Clinical)	Vector-borne	t	WEEKLY	2026-02-08 10:59:29.875	2026-02-08 10:59:29.875
882f4c95-b590-465f-a806-6dd440072222	NUT_SAM	Severe Acute Malnutrition	Nutritional	t	WEEKLY	2026-02-08 10:59:29.876	2026-02-08 10:59:29.876
7f0906ef-35b4-4116-b067-b2cb67e088f4	MEN	Meningitis	Communicable	t	WEEKLY	2026-02-08 10:59:29.878	2026-02-08 10:59:29.878
25d8d76f-8a3f-4e7e-950d-7f6488c22d50	REL	Relapsing Fever	Communicable	t	WEEKLY	2026-02-08 10:59:29.881	2026-02-08 10:59:29.881
a217cb29-a6c2-4ae5-97a8-d24bcd6e4496	TYP	Typhoid Fever	Communicable	t	WEEKLY	2026-02-08 10:59:29.885	2026-02-08 10:59:29.885
490aebda-a1c8-4d3c-ae06-371698417b62	TYS	Epidemic Typhus	Communicable	t	WEEKLY	2026-02-08 10:59:29.887	2026-02-08 10:59:29.887
41d74f9d-86db-4244-8d45-7f22c4eafd09	PNE	Pneumonia	Respiratory	f	NONE	2026-02-08 10:59:29.889	2026-02-08 10:59:29.889
24f50238-994d-4331-95aa-ab680021a341	URI	Acute Upper Respiratory Infection	Respiratory	f	NONE	2026-02-08 10:59:29.891	2026-02-08 10:59:29.891
7cc4f5d4-b2ae-4e47-8fc1-0eace0b2458e	UTI	Urinary Tract Infection	Genitourinary	f	NONE	2026-02-08 10:59:29.892	2026-02-08 10:59:29.892
5f6c8c60-c8d6-4514-9c7d-3c0489a68655	GAS	Gastritis / PUD	Digestive	f	NONE	2026-02-08 10:59:29.895	2026-02-08 10:59:29.895
633beefc-c2e1-4498-8628-65eaca571fb0	HTN	Hypertension	NCD	f	NONE	2026-02-08 10:59:29.898	2026-02-08 10:59:29.898
6a1f6790-cfcb-4e2d-895c-93e9e00e19b6	DM	Diabetes Mellitus	NCD	f	NONE	2026-02-08 10:59:29.901	2026-02-08 10:59:29.901
e6de9849-4c90-4470-a435-072b992bb18c	AST	Asthma	NCD	f	NONE	2026-02-08 10:59:29.904	2026-02-08 10:59:29.904
f4b2f1b6-fbd0-4fe1-8255-68a61fa47de3	TB_PUL	Tuberculosis (Pulmonary)	Communicable	f	NONE	2026-02-08 10:59:29.906	2026-02-08 10:59:29.906
c09f39f0-f6b0-4777-b25d-7acf2d47cf7d	TB_EP	Tuberculosis (Extra-pulmonary)	Communicable	f	NONE	2026-02-08 10:59:29.907	2026-02-08 10:59:29.907
b462d987-fc05-48fe-abdf-8f90949e8205	HIV	HIV/AIDS	Communicable	f	NONE	2026-02-08 10:59:29.909	2026-02-08 10:59:29.909
4c6b07ee-089b-40df-b07a-69417077b5d7	DIA_WD	Diarrhea with Dehydration	Communicable	f	NONE	2026-02-08 10:59:29.914	2026-02-08 10:59:29.914
89d93d48-06a0-428b-aa20-9eab0e95987d	DIA_NOD	Diarrhea without Dehydration	Communicable	f	NONE	2026-02-08 10:59:29.918	2026-02-08 10:59:29.918
961e37f0-06fc-407a-9cd1-6391eea44495	IP	Intestinal Parasites	Communicable	f	NONE	2026-02-08 10:59:29.921	2026-02-08 10:59:29.921
374b15c1-bf16-4d3a-99ac-22cf47b724d9	SKI	Skin Infection	Dermatological	f	NONE	2026-02-08 10:59:29.925	2026-02-08 10:59:29.925
2b1a3f25-d664-4602-bacb-dac4ac66379f	DEN	Dental Caries	Dental	f	NONE	2026-02-08 10:59:29.928	2026-02-08 10:59:29.928
f6024728-cf16-42fb-8ab4-5718bbad7211	EYE	Eye Infection / Conjunctivitis	Ophthalmological	f	NONE	2026-02-08 10:59:29.93	2026-02-08 10:59:29.93
b9563e11-2491-45d0-bb88-5dd726106aa6	EAR	Otitis Media / Ear Infection	ENT	f	NONE	2026-02-08 10:59:29.935	2026-02-08 10:59:29.935
85327cf5-fcf2-4b41-89ac-3674ad5d58f9	TON	Tonsillitis	Respiratory	f	NONE	2026-02-08 10:59:29.937	2026-02-08 10:59:29.937
aea682a6-efdd-44e8-ab3c-0dc9eb08bc01	BRO	Bronchitis	Respiratory	f	NONE	2026-02-08 10:59:29.939	2026-02-08 10:59:29.939
c0e5e2d8-7a25-4380-8136-0f0108b5a248	ANE	Anemia	Nutritional	f	NONE	2026-02-08 10:59:29.941	2026-02-08 10:59:29.941
86250192-603b-469d-a64e-2721a2a01351	RHE	Rheumatism / Joint Pain	Musculoskeletal	f	NONE	2026-02-08 10:59:29.943	2026-02-08 10:59:29.943
0a6fa521-83f6-43a5-bdce-0f71bd32574b	TRA	Trauma / Injury	Injury	f	NONE	2026-02-08 10:59:29.944	2026-02-08 10:59:29.944
3e3a1c46-52ae-4fdf-91b0-4b3b0f20bfb9	CUSTOM-1772600856047	hglo	Other	f	\N	2026-03-04 05:07:36.096	2026-03-04 05:07:36.096
7e4357c2-5c0a-4d74-89b3-9a2bb4479c94	CUSTOM-1772854575237	hadye r	Other	f	\N	2026-03-07 03:36:15.281	2026-03-07 03:36:15.281
\.


--
-- Data for Name: DispenseLog; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public."DispenseLog" (id, "orderId", "patientId", "pharmacyId", quantity, notes, "createdAt") FROM stdin;
\.


--
-- Data for Name: DispensedMedicine; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public."DispensedMedicine" (id, "pharmacyInvoiceId", "medicationOrderId", "medicationCatalogId", status, name, "dosageForm", strength, quantity, "unitPrice", notes, "dispensedAt", "dispensedBy") FROM stdin;
\.


--
-- Data for Name: DoctorWalkInOrder; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public."DoctorWalkInOrder" (id, "patientId", "serviceId", "doctorId", instructions, notes, status, "billingId", "completedAt", "createdAt", "updatedAt", "visitId") FROM stdin;
\.


--
-- Data for Name: EmergencyDrugOrder; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public."EmergencyDrugOrder" (id, "visitId", "patientId", "doctorId", "serviceId", quantity, instructions, notes, status, "billingId", "completedAt", "createdAt", "updatedAt", "dosageForm", duration, "durationPeriod", frequency, "frequencyPeriod", route, strength) FROM stdin;
1	2	PAT-2026-128	093cba71-ff80-4568-8969-f93c80ec0cf9	4596a8dc-cb6f-4111-acf7-2f97f2daa51a	1			PAID	f9440a07-3755-4fa5-bf83-68323aef694b	\N	2026-03-04 23:40:35.683	2026-03-04 23:41:15.929	Injection		days				
2	1	PAT-2026-123	093cba71-ff80-4568-8969-f93c80ec0cf9	7999d55e-285c-493c-9367-ee25456a9ce2	1			UNPAID	14d0d5a0-09d0-4eba-8964-e60631e17f69	\N	2026-03-07 04:02:11.433	2026-03-07 04:02:11.459	Injection		days				
3	1	PAT-2026-123	093cba71-ff80-4568-8969-f93c80ec0cf9	abf3fc5d-d052-4c46-a421-1347cb995556	1			UNPAID	14d0d5a0-09d0-4eba-8964-e60631e17f69	\N	2026-03-07 04:02:11.476	2026-03-07 04:02:11.491	Injection		days				
\.


--
-- Data for Name: File; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public."File" (id, "patientId", path, type, "accessLog", "labOrderId", "radiologyOrderId", "batchOrderId", "createdAt", "updatedAt") FROM stdin;
\.


--
-- Data for Name: Insurance; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public."Insurance" (id, name, code, "contactInfo", "isActive", "createdAt", "updatedAt") FROM stdin;
6729cb4e-d8d4-4b4a-a481-4572012bbeb3	Ethiopian Insurance Corporation	EIC001	Insurance Manager - +251-11-123-4567 - insurance@ethioinsurance.com - Addis Ababa, Ethiopia	t	2026-01-04 10:11:24.245	2026-01-04 10:11:24.245
1816b2da-82e9-46bf-9d43-210fbbf5bb30	Test Insurance	TEST001	Test Manager - +251-11-987-6543 - test@testinsurance.et - Addis Ababa, Ethiopia	t	2026-01-04 10:11:24.249	2026-01-04 10:11:24.249
\.


--
-- Data for Name: InsuranceTransaction; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public."InsuranceTransaction" (id, "insuranceId", "patientId", "visitId", "serviceType", "serviceId", "serviceName", "serviceCode", "medicationId", "medicationName", "unitPrice", "totalAmount", quantity, status, "claimNumber", "transactionNumber", "serviceDate", "claimDate", "collectedDate", notes, "receiptPath", "createdById", "collectedById", "createdAt", "updatedAt") FROM stdin;
\.


--
-- Data for Name: InternationalMedicalCertificate; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public."InternationalMedicalCertificate" (id, "certificateNo", "certificateDate", "patientId", "doctorId", "visitId", "passportNo", "hasPreviousDisease", "previousDiseaseDetails", "hasCurrentMedicalComplains", "currentMedicalComplainsDetails", height, weight, bp, "bloodGroup", heent, chest, cvs, abdomen, cns, "chestXRay", hiv, hbsag, vdrl, hcv, hcg, "fbsRbs", "finalAssessment", "directoryName", status, "createdAt", "updatedAt") FROM stdin;
\.


--
-- Data for Name: Inventory; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public."Inventory" (id, name, quantity, category, "dosageForm", strength, "expiryDate", supplier, price, "serviceId", "createdAt", "updatedAt") FROM stdin;
\.


--
-- Data for Name: InvestigationType; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public."InvestigationType" (id, name, price, category, "serviceId", "createdAt", "updatedAt") FROM stdin;
41	Ultrasound - Abdomen	400	RADIOLOGY	907e9fd6-af1d-477e-a8a3-2ebc17a45e53	2026-03-04 17:49:08.756	2026-03-04 17:49:08.756
42	Ultrasound - Pelvis	380	RADIOLOGY	7e1929db-ce87-4893-a5d7-7436921f7961	2026-03-04 17:49:08.768	2026-03-04 17:49:08.768
43	Obstetric Ultrasound	420	RADIOLOGY	6fe4b74f-36ed-4f8f-b28c-9e045e07acda	2026-03-04 17:49:08.771	2026-03-04 17:49:08.771
44	Thyroid Ultrasound	350	RADIOLOGY	3caa3c4b-3362-4a74-9312-42d0ef9998e0	2026-03-04 17:49:08.774	2026-03-04 17:49:08.774
45	Breast Ultrasound	380	RADIOLOGY	36b747ef-6db2-4b5a-82fe-8a8ff20c427a	2026-03-04 17:49:08.779	2026-03-04 17:49:08.779
46	Doppler Ultrasound	450	RADIOLOGY	f67ac081-581d-4018-a4d4-e96efd7c5924	2026-03-04 17:49:08.782	2026-03-04 17:49:08.782
\.


--
-- Data for Name: LabOrder; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public."LabOrder" (id, "visitId", "patientId", "doctorId", "typeId", instructions, result, "additionalNotes", status, "isWalkIn", "billingId", "createdAt", "updatedAt") FROM stdin;
\.


--
-- Data for Name: LabResult; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public."LabResult" (id, "orderId", "testTypeId", "resultText", "additionalNotes", status, "createdAt", "updatedAt") FROM stdin;
\.


--
-- Data for Name: LabResultFile; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public."LabResultFile" (id, "resultId", "fileUrl", "fileName", "fileType", "uploadedAt", "uploadedBy") FROM stdin;
\.


--
-- Data for Name: LabTest; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public."LabTest" (id, name, code, category, description, price, unit, "groupId", "displayOrder", "isActive", "createdAt", "updatedAt", "createdBy", "updatedBy", "serviceId") FROM stdin;
5ce52030-2492-49a6-9250-271d209a3686	ESR	ESR001	Hematology	ESR test	125	mm/hr	\N	8	t	2026-01-04 17:40:03.529	2026-01-10 13:08:18.392	\N	\N	22eedf04-fddd-4023-a109-114495c9e1e9
71c0f60a-fb2e-47dd-bbd0-938064f34093	AFB Sputum (Spot–Morning–Spot)	AFB001	Microbiology	Acid-Fast Bacilli Sputum Examination - Three samples (Spot-Morning-Spot)	300	UNIT	\N	1	t	2026-01-15 14:02:23.289	2026-01-15 14:07:29.112	\N	\N	3e9e842d-bb68-41ac-9847-a636ad0478dc
f1a6a422-829f-48c8-bbe8-82582cf86c43	Red Cell Indices (MCV, MCH, MCHC)	RCI001	Hematology	\N	100	UNIT	943a3cb3-619c-4288-89f7-c9d51da85866	6	f	2026-01-04 17:40:03.51	2026-01-10 21:40:34.454	\N	\N	06516f0d-b079-4c75-b285-4340cfdd218a
b0cef63b-68c5-4865-81ab-f9304e078387	Complete Blood Count (CBC)	CBC001	Hematology	Complete Blood Count (CBC) - Comprehensive hematology panel including Hemoglobin, Hematocrit, RBC, WBC, Platelets, Indices, and Differential	400	UNIT	\N	0	t	2026-01-06 19:25:38.066	2026-01-10 21:40:34.485	\N	\N	3566536f-f272-4574-a8ab-513df7f9e597
a9fd508f-bb4e-4447-8ff7-cbe1f37dc9a9	ALP	ALP001	Blood Chemistry	\N	300	UNIT	9dee0001-5855-4d38-97ec-2ddb4274bc54	3	t	2026-01-04 17:40:03.684	2026-01-05 16:52:53.705	\N	\N	7c44bbba-11a1-4019-a32b-8d0631f979e2
6c919999-d2c2-44f1-bdca-8dd0fbd0beff	Reticulocyte Count	RET001	Hematology	\N	200	UNIT	\N	10	f	2026-01-04 17:40:03.54	2026-01-07 21:41:54.076	\N	\N	7e831762-a1c0-4871-8d73-7ad1035ac85f
9f0aff24-2e7c-4a38-b463-55922b488692	AST	AST001	Blood Chemistry	\N	200	UNIT	9dee0001-5855-4d38-97ec-2ddb4274bc54	2	t	2026-01-04 17:40:03.68	2026-01-05 16:56:50.688	\N	\N	feb3c98e-405c-4ef8-9279-972c9bc23292
a7840826-dc05-475a-a1ea-5ace0f0006e5	Albumin	ALB001	Blood Chemistry	\N	200	UNIT	9dee0001-5855-4d38-97ec-2ddb4274bc54	7	t	2026-01-04 17:40:03.703	2026-01-05 16:57:05.239	\N	\N	9029c940-95cf-417a-845b-684aa0a1870e
2ad23d3a-0c8c-4006-8268-bf7e093c5ef4	Clotting Time (CT)	CT001	Hematology	\N	30	UNIT	\N	12	f	2026-01-04 17:40:03.549	2026-01-07 21:41:54.081	\N	\N	811e0f9c-9811-4a02-bc57-3cf927b7f86d
faeadd1d-e600-4835-ae04-0d23ba54f9e9	Creatinine	CREA001	Blood Chemistry	\N	200	UNIT	80a107b4-3846-42c0-ab83-3f1a3a50e1a2	1	t	2026-01-04 17:40:03.707	2026-01-05 16:58:28.328	\N	\N	ff3c6949-2169-4f4b-843c-a35050ea3dfa
797d78de-63c6-4428-b377-5d02ae4018e1	HBsAg	HBSAG001	Serology	\N	200	UNIT	bca5d5f8-52b4-4825-8bdc-802154dff90e	3	t	2026-01-04 17:40:03.618	2026-01-05 17:00:56.722	\N	\N	b4b52af5-56f4-4a32-b399-00e291211995
83c8787e-e308-4d5f-871e-7582f0d0fb00	Direct Bilirubin	DBIL001	Blood Chemistry	\N	200	UNIT	9dee0001-5855-4d38-97ec-2ddb4274bc54	5	t	2026-01-04 17:40:03.694	2026-01-05 16:58:57.062	\N	\N	ceaabd0b-6175-4207-8539-95f79372bf04
526f5e17-addd-4321-be08-d580f9237e2d	HCG (Quantitative)	HCG002	Serology	\N	70	UNIT	bca5d5f8-52b4-4825-8bdc-802154dff90e	12	t	2026-01-04 17:40:03.63	2026-01-05 17:01:34.032	\N	\N	3e5a4280-4b80-4054-a478-5b90d296606c
2f373e76-31e7-4da2-8cdc-386287ce6241	HCV Antibody	HCV001	Serology	\N	150	UNIT	bca5d5f8-52b4-4825-8bdc-802154dff90e	8	t	2026-01-04 17:40:03.652	2026-01-05 17:02:06.41	\N	\N	a03e2576-be51-4916-9f8a-3869c12b1927
f0af6cc9-63e3-4e52-9b71-87c4e5a6d256	Bleeding Time (BT)	BT001	Hematology	\N	300	UNIT	\N	11	f	2026-01-04 17:40:03.544	2026-01-07 21:41:54.069	\N	\N	315e3397-2295-4f4a-ada9-0345ff64e196
1f69db42-462b-4ee6-b357-f92adafc274a	Urinalysis	URINE001	Urinalysis	\N	100	UNIT	\N	1	t	2026-01-04 17:40:03.561	2026-01-04 17:40:03.561	\N	\N	5b08e652-9ad2-4fb4-bee9-be6cca21d6df
a0c2e6af-5844-4258-a4c3-1fa8fb97ddc0	HCG (Qualitative)	HCG001	Serology	\N	40	UNIT	bca5d5f8-52b4-4825-8bdc-802154dff90e	5	t	2026-01-04 17:40:03.626	2026-01-04 17:40:03.626	\N	\N	717ff15c-c231-404c-81c9-d3986794bc0e
4e5de39d-7705-4130-a2ea-29eb2bae4768	ASO Titer	ASO001	Serology	\N	50	UNIT	bca5d5f8-52b4-4825-8bdc-802154dff90e	7	t	2026-01-04 17:40:03.648	2026-01-04 17:40:03.648	\N	\N	cd1a235d-b538-4975-abe2-db3f4fd4bc35
33a71531-d853-48be-98cc-4118d39ebf7d	VDRL	VDRL001	Serology	\N	50	UNIT	bca5d5f8-52b4-4825-8bdc-802154dff90e	9	t	2026-01-04 17:40:03.657	2026-01-04 17:40:03.657	\N	\N	f1d0308f-18ce-4422-b2e6-9d9c5789580c
82fd708c-713c-449c-baa3-8d083394f669	ALT	ALT001	Blood Chemistry	\N	40	UNIT	9dee0001-5855-4d38-97ec-2ddb4274bc54	1	t	2026-01-04 17:40:03.676	2026-01-04 17:40:03.676	\N	\N	8674ef39-46e0-410d-8486-7faf18fc162a
eccc85ba-0a40-4498-941c-8eb676c8be34	RPR	RPR001	Serology	\N	150	UNIT	bca5d5f8-52b4-4825-8bdc-802154dff90e	2	t	2026-01-04 17:40:03.613	2026-01-05 17:04:38.531	\N	\N	e22c7ff5-7dbe-48ce-85e8-c40072e75c82
3dde3c15-548f-4cba-af38-7a7cfda874e7	RTD (Rapid Test Device)	RTD001	Serology	\N	200	UNIT	bca5d5f8-52b4-4825-8bdc-802154dff90e	13	t	2026-01-04 17:40:03.635	2026-01-05 17:05:01.338	\N	\N	cfcbcca0-d8e2-4bb0-b9fc-bb36618cbe4a
1d902667-d1ec-4148-ab5a-cea63c9d9f2d	Rheumatoid Factor (RF)	RF001	Serology	\N	200	UNIT	bca5d5f8-52b4-4825-8bdc-802154dff90e	6	t	2026-01-04 17:40:03.642	2026-01-05 17:06:17.642	\N	\N	159ec24b-db04-42fe-b04f-82dcb0ddd4bb
b953925e-247c-4b12-8d2c-15c5060bc268	Stool Examination	STOOL001	Stool Examination	\N	100	UNIT	\N	1	t	2026-01-04 17:40:03.588	2026-01-05 17:15:51.177	\N	\N	95abafe1-60f8-47a0-8f8d-837c6a24158c
6a5fea3e-39ec-42b4-ae0c-b9af7a361c10	Total Bilirubin	TBIL001	Blood Chemistry	\N	200	UNIT	9dee0001-5855-4d38-97ec-2ddb4274bc54	4	t	2026-01-04 17:40:03.689	2026-01-05 17:16:43.44	\N	\N	e39f3fa0-9183-4eca-822f-66e165b1727e
0be41e49-0dd2-4982-b13c-efa7a397a0da	Total Protein	TP001	Blood Chemistry	\N	200	UNIT	9dee0001-5855-4d38-97ec-2ddb4274bc54	6	t	2026-01-04 17:40:03.699	2026-01-05 17:17:59.556	\N	\N	d8d13311-7d4c-4654-9dfe-be65c61f0d64
c870197e-8a4b-4a84-95f9-b0d1b44af2fb	HIV Test 	HIV001	Serology	\N	300	UNIT	bca5d5f8-52b4-4825-8bdc-802154dff90e	4	t	2026-01-04 17:40:03.622	2026-01-05 17:31:46.275	\N	\N	a96bbe21-f849-47cc-ba89-526c526c3c32
ec0979c0-90a0-4065-afc0-7720567ba00c	WBC Count	WBC001	Hematology	\N	50	UNIT	943a3cb3-619c-4288-89f7-c9d51da85866	4	f	2026-01-04 17:40:03.499	2026-01-10 21:40:34.431	\N	\N	ee1a55f9-5798-4501-a96b-b68bfa6f5fba
246218b6-ce36-4afb-acae-889cc68fcfd0	Platelet Count	PLT001	Hematology	\N	50	UNIT	943a3cb3-619c-4288-89f7-c9d51da85866	5	f	2026-01-04 17:40:03.504	2026-01-10 21:40:34.443	\N	\N	d769d862-0483-4fa3-93a0-208d11e57838
e199ac78-4531-476e-8287-a036aa1b517f	WBC Differential	WBCD001	Hematology	\N	50	UNIT	943a3cb3-619c-4288-89f7-c9d51da85866	7	f	2026-01-04 17:40:03.518	2026-01-10 21:40:34.465	\N	\N	73b76ddf-5006-43f3-b4ea-3b85b096a162
32917792-a432-4614-8002-41ac62b30350	Hemoglobin (Hb)	HB001	Hematology	\N	50	UNIT	943a3cb3-619c-4288-89f7-c9d51da85866	1	f	2026-01-04 17:40:03.48	2026-01-10 21:40:34.474	\N	\N	8cab7249-e261-4f00-bac4-cc651185cccb
a9272d05-9091-4703-bda3-e567b58ddad0	Blood Group & Rh	BGRH001	Hematology	Blood Group & Rh test	150	UNIT	\N	9	t	2026-01-04 17:40:03.534	2026-01-13 17:12:35.535	\N	\N	66f5dc69-e9c2-4c46-9e20-ebeb319a629d
75d9a240-970f-455f-8a12-1e4ea8e8c2eb	Hematocrit (HCT)	HCT001	Hematology	\N	50	UNIT	943a3cb3-619c-4288-89f7-c9d51da85866	2	f	2026-01-04 17:40:03.488	2026-01-10 21:40:34.407	\N	\N	2c2a8d83-6e64-44fd-a000-0629117811a3
28ecf5d6-b1f3-4126-a942-8d0734fe7f18	Weil-Felix Test	WEIL001	Serology	\N	100	UNIT	bca5d5f8-52b4-4825-8bdc-802154dff90e	11	t	2026-01-04 17:40:03.668	2026-02-08 14:44:49.967	\N	\N	a51af10c-f0a1-4141-8dbc-bf5c61612368
79041707-e133-44da-ad4a-999aed280c02	RBC Count	RBC001	Hematology	\N	50	UNIT	943a3cb3-619c-4288-89f7-c9d51da85866	3	f	2026-01-04 17:40:03.494	2026-01-10 21:40:34.419	\N	\N	53da0ecc-dd5c-4238-aa63-60524a4a0b71
6e1d4804-7935-4ff5-a1c0-986d15aa7444	BUN	BUN001	Blood Chemistry	\N	200	UNIT	80a107b4-3846-42c0-ab83-3f1a3a50e1a2	2	t	2026-01-04 17:40:03.71	2026-01-05 16:57:17.744	\N	\N	b441fc6b-5d8b-4e68-b733-84fa97ad40e2
49b105e5-3c6c-44fe-8415-387d9ae49481	Fasting Blood Glucose	FBG001	Blood Chemistry	\N	50	UNIT	\N	10	t	2026-01-04 17:40:03.746	2026-01-05 16:59:31.154	\N	\N	080d52da-cc95-414c-a14c-008863579360
332e5db0-e535-44a0-9ae8-c88837328c88	Free T3 (Triiodothyronine)	FT3001	Blood Chemistry	\N	1000	UNIT	3238469d-1e3f-4f04-b9a8-1d5a1d6177d9	2	t	2026-01-04 17:40:03.739	2026-01-05 16:59:51.111	\N	\N	b3c29400-cfc3-446a-a9bc-9930800dcca0
e4dfd400-45c5-4a58-98b6-5639d02f9506	Free T4 (Thyroxine)	FT4001	Blood Chemistry	\N	1000	UNIT	3238469d-1e3f-4f04-b9a8-1d5a1d6177d9	3	t	2026-01-04 17:40:03.742	2026-01-05 17:00:10.69	\N	\N	79fc6dd1-824d-4674-8756-0bade8e40c66
15107b86-b9b5-4366-aade-80f67c38ea7b	HDL Cholesterol	HDL001	Blood Chemistry	\N	500	UNIT	31300afd-83b3-4b66-9c27-4dbfca7ac0cf	2	t	2026-01-04 17:40:03.722	2026-01-05 17:02:30.652	\N	\N	8ef29156-931b-4860-8452-341896d14f66
a14e5ff4-c65c-4ffa-81ce-cf6ce56a4d1f	HbA1c	HBA1C001	Blood Chemistry	\N	1500	UNIT	\N	12	t	2026-01-04 17:40:03.755	2026-01-05 17:02:54.104	\N	\N	fc89be43-0f24-4580-87c8-f0c15fdce005
2f3252e6-cb7a-4fb7-9838-36e2099f2957	LDL Cholesterol	LDL001	Blood Chemistry	\N	500	UNIT	31300afd-83b3-4b66-9c27-4dbfca7ac0cf	3	t	2026-01-04 17:40:03.726	2026-01-05 17:02:26.43	\N	\N	bbb8d749-dbbe-4ffc-a677-9432a6f9e47c
f2e38bde-9795-485c-be70-3639799186cd	Random Blood Glucose	RBG001	Blood Chemistry	\N	70	UNIT	\N	11	t	2026-01-04 17:40:03.751	2026-01-05 17:05:39.872	\N	\N	43dd343b-914d-42ee-96dc-53dc07295796
7c5fbccc-ef0f-444b-bbaf-4a61641e7dc4	TSH (Thyroid Stimulating Hormone)	TSH001	Blood Chemistry	\N	1000	UNIT	3238469d-1e3f-4f04-b9a8-1d5a1d6177d9	1	t	2026-01-04 17:40:03.734	2026-01-05 17:16:23.139	\N	\N	fb1ca7cb-c0c5-4e95-abd8-ec61a3e6cb71
77518a51-37f3-4441-b72c-9ea7cb7f26d8	Total Cholesterol	CHOL001	Blood Chemistry	\N	200	UNIT	31300afd-83b3-4b66-9c27-4dbfca7ac0cf	1	t	2026-01-04 17:40:03.718	2026-01-05 17:17:06.696	\N	\N	46e4a5f2-7577-4591-a808-04c222702954
7ab91833-adad-4c86-84d8-f792925e318d	Triglycerides	TG001	Blood Chemistry	\N	200	UNIT	31300afd-83b3-4b66-9c27-4dbfca7ac0cf	4	t	2026-01-04 17:40:03.729	2026-01-05 17:17:38.214	\N	\N	6f3030f4-ab3b-43e6-b589-0317829c5d88
2102701e-32e8-4f4f-9319-feb233c06dda	Uric Acid	UA001	Blood Chemistry	\N	200	UNIT	80a107b4-3846-42c0-ab83-3f1a3a50e1a2	3	t	2026-01-04 17:40:03.714	2026-01-05 17:19:20.23	\N	\N	477b0189-f851-4cb3-a9c9-a99b7d1b136b
0684c2cf-8c69-406c-86e6-a39012d2cd2a	Widal Test	WIDAL001	Serology	\N	100	UNIT	bca5d5f8-52b4-4825-8bdc-802154dff90e	1	t	2026-01-04 17:40:03.605	2026-02-08 14:44:49.957	\N	\N	2c17dcec-b981-4bc5-b4eb-729d2944be89
335353da-bc1b-419c-b04d-e6cca18a78a1	Blood Film	PBF001	Hematology	\N	150	UNIT	\N	13	t	2026-01-04 17:40:03.553	2026-02-08 14:44:49.988	\N	\N	cc6d7bcf-b48c-4684-897a-eb79a75a7485
8b8c5630-ea8a-4ea0-aa68-4ba51411df0a	Blood Film for Malaria	PICT001	Hematology	\N	150	UNIT	\N	10	t	2026-01-04 17:40:03.663	2026-02-26 16:16:39.68	\N	\N	0fe08c72-72ef-447d-8879-07e29effa8d3
c55af77e-3783-4f9c-8e40-87f029eda2be	ANA (Antinuclear Antibody)	ANA001	Serology	Antinuclear antibody test for autoimmune disorders	250	UNIT	\N	100	t	2026-03-02 11:12:51.248	2026-03-02 11:12:51.248	\N	\N	\N
b1d6df5d-0c3a-4a3b-b5b5-c83d69f19118	H. pylori Antibody (Serology)	HPYLORIAB001	Serology	H. pylori antibody serology test	250	UNIT	bca5d5f8-52b4-4825-8bdc-802154dff90e	0	t	2026-01-07 21:22:16.396	2026-01-10 13:06:03.797	\N	\N	0f4eeaba-9421-439a-ae57-4a1daa0caedc
3e79e05b-8a3a-492c-bc46-1803a00d0eeb	Sample Examination	SMPL001	Microbiology	General specimen examination and registration	50	UNIT	\N	1	t	2026-03-02 11:12:51.225	2026-03-02 11:12:51.225	\N	\N	c526a802-11d4-441e-aa7e-867d20244d4f
3833e492-b226-4c72-a764-a514a0f72e00	KOH Preparation	KOH001	Microbiology	Potassium hydroxide preparation for fungal examination	80	UNIT	\N	2	t	2026-03-02 11:12:51.235	2026-03-02 11:12:51.235	\N	\N	44cca180-f38a-42d4-b037-dc59cda1a186
250c941f-35e8-4bbb-8751-ff7ebed6fe16	Gram Stain	GRAM001	Microbiology	Gram staining for bacterial identification	100	UNIT	\N	3	t	2026-03-02 11:12:51.237	2026-03-02 11:12:51.237	\N	\N	910251a6-6950-4b53-b628-a1b291057ae3
2ac46b62-4484-45db-ad1f-4587f0892bb2	AFB (Ziehl–Neelsen) - 3 Day	AFB003	Microbiology	Acid-fast bacilli smear for tuberculosis (3-day protocol)	150	UNIT	\N	4	t	2026-03-02 11:12:51.241	2026-03-02 11:12:51.241	\N	\N	7556ef8a-9592-464c-ad23-0ed7b02a5acf
78e7aacd-227f-4eaf-8573-3728b20ed1c7	T. vaginalis Wet Mount	TVAG001	Microbiology	Trichomonas vaginalis wet mount examination	70	UNIT	\N	5	t	2026-03-02 11:12:51.243	2026-03-02 11:12:51.243	\N	\N	1085e5c8-4d75-463e-a9aa-4df8143a769f
be4e41bf-4221-4869-a81b-74098cab6e85	H. pylori Antigen (Stool Test)	HPYLORIAG001	Serology	H. pylori Antigen detection in stool sample	250	UNIT	bca5d5f8-52b4-4825-8bdc-802154dff90e	0	t	2026-01-07 21:22:16.384	2026-03-07 04:06:57.149	\N	\N	d32b6a47-2e50-46bb-be57-cd3bb5c45dca
\.


--
-- Data for Name: LabTestGroup; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public."LabTestGroup" (id, name, category, description, "displayOrder", "isActive", "createdAt", "updatedAt", "createdBy", "updatedBy") FROM stdin;
bca5d5f8-52b4-4825-8bdc-802154dff90e	Serology Panel	Serology	Infectious disease markers panel	1	t	2026-01-04 17:40:03.465	2026-01-04 17:40:03.465	\N	\N
9dee0001-5855-4d38-97ec-2ddb4274bc54	Liver Function Tests (LFT)	Blood Chemistry	Liver function panel	1	t	2026-01-04 17:40:03.467	2026-01-04 17:40:03.467	\N	\N
80a107b4-3846-42c0-ab83-3f1a3a50e1a2	Kidney Function Tests (KFT)	Blood Chemistry	Kidney function panel	2	t	2026-01-04 17:40:03.47	2026-01-04 17:40:03.47	\N	\N
31300afd-83b3-4b66-9c27-4dbfca7ac0cf	Lipid Profile	Blood Chemistry	Lipid panel	3	t	2026-01-04 17:40:03.472	2026-01-04 17:40:03.472	\N	\N
3238469d-1e3f-4f04-b9a8-1d5a1d6177d9	Thyroid Function Tests	Blood Chemistry	Complete thyroid hormone panel	4	t	2026-01-04 17:40:03.475	2026-01-04 17:40:03.475	\N	\N
943a3cb3-619c-4288-89f7-c9d51da85866	Complete Blood Count (CBC)	Hematology	Complete blood count panel	1	f	2026-01-04 17:40:03.462	2026-01-10 21:40:34.478	\N	\N
bfd5463e-d78b-4046-9570-432a4ee47e48	Microbiology	Microbiology	Microbiology tests	10	t	2026-01-15 14:02:23.287	2026-01-15 14:02:23.287	\N	\N
\.


--
-- Data for Name: LabTestOrder; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public."LabTestOrder" (id, "labTestId", "batchOrderId", "visitId", "patientId", "doctorId", instructions, status, "isWalkIn", "billingId", "createdAt", "updatedAt") FROM stdin;
76ac5a2c-580a-4476-87da-6c7f80027e30	8b8c5630-ea8a-4ea0-aa68-4ba51411df0a	1	1	PAT-2026-123	093cba71-ff80-4568-8969-f93c80ec0cf9	Lab test: Blood Film (BF)	COMPLETED	f	565f7ac3-3383-4435-8bd6-ccc0a100a99b	2026-02-26 16:14:35.066	2026-02-26 16:18:08.682
7f46e017-71e8-4bde-b060-6664086bb0de	b1d6df5d-0c3a-4a3b-b5b5-c83d69f19118	9	2	PAT-2026-128	093cba71-ff80-4568-8969-f93c80ec0cf9	Lab test: H. pylori Antibody (Serology)	COMPLETED	f	f35553db-dafa-4124-90b2-9fcde72fcab0	2026-03-04 11:56:50.707	2026-03-04 16:26:14.065
0c73d18a-1970-4a4d-8f0e-0b55cc26c767	3833e492-b226-4c72-a764-a514a0f72e00	7	1	PAT-2026-123	093cba71-ff80-4568-8969-f93c80ec0cf9	Lab test: KOH Preparation	PAID	f	de1ca327-967c-412f-87f6-49d6ba0dc2cf	2026-03-03 06:44:11.234	2026-03-06 23:11:23.495
5538eeeb-8dc8-46c7-adfc-00414eac9943	a14e5ff4-c65c-4ffa-81ce-cf6ce56a4d1f	8	1	PAT-2026-123	093cba71-ff80-4568-8969-f93c80ec0cf9	Lab test: HbA1c	PAID	f	de1ca327-967c-412f-87f6-49d6ba0dc2cf	2026-03-03 08:25:49.988	2026-03-06 23:11:23.495
b8e1f17d-cfef-4504-a74e-1f09a11e0fc1	49b105e5-3c6c-44fe-8415-387d9ae49481	8	1	PAT-2026-123	093cba71-ff80-4568-8969-f93c80ec0cf9	Lab test: Fasting Blood Glucose	PAID	f	de1ca327-967c-412f-87f6-49d6ba0dc2cf	2026-03-03 08:25:49.997	2026-03-06 23:11:23.495
f94ddb70-4eba-40fe-8782-a4cbae749b2a	2ac46b62-4484-45db-ad1f-4587f0892bb2	3	1	PAT-2026-123	093cba71-ff80-4568-8969-f93c80ec0cf9	Lab test: AFB (Ziehl–Neelsen) - 3 Day	PAID	f	2d814428-f385-46b5-97e8-d083d36f1613	2026-03-03 06:21:23.887	2026-03-03 06:41:50.482
6d14c4b9-28a7-4325-95a2-34172f5d424c	78e7aacd-227f-4eaf-8573-3728b20ed1c7	3	1	PAT-2026-123	093cba71-ff80-4568-8969-f93c80ec0cf9	Lab test: T. vaginalis Wet Mount	PAID	f	2d814428-f385-46b5-97e8-d083d36f1613	2026-03-03 06:21:23.892	2026-03-03 06:41:50.482
e81f0b48-2b70-41a2-9a5c-2ac02e713760	b0cef63b-68c5-4865-81ab-f9304e078387	4	1	PAT-2026-123	093cba71-ff80-4568-8969-f93c80ec0cf9	Lab test: Complete Blood Count (CBC)	PAID	f	2d814428-f385-46b5-97e8-d083d36f1613	2026-03-03 06:22:19.098	2026-03-03 06:41:50.482
6fb0a633-b425-457f-990e-a1d23f57a6e0	5ce52030-2492-49a6-9250-271d209a3686	4	1	PAT-2026-123	093cba71-ff80-4568-8969-f93c80ec0cf9	Lab test: ESR	PAID	f	2d814428-f385-46b5-97e8-d083d36f1613	2026-03-03 06:22:19.102	2026-03-03 06:41:50.482
292a6d1c-9766-4897-a402-203543e70de4	250c941f-35e8-4bbb-8751-ff7ebed6fe16	5	1	PAT-2026-123	093cba71-ff80-4568-8969-f93c80ec0cf9	Lab test: Gram Stain	PAID	f	2d814428-f385-46b5-97e8-d083d36f1613	2026-03-03 06:22:58.887	2026-03-03 06:41:50.482
bb88546d-79d4-4931-9ad0-b4a88d6cc0ba	3e79e05b-8a3a-492c-bc46-1803a00d0eeb	5	1	PAT-2026-123	093cba71-ff80-4568-8969-f93c80ec0cf9	Lab test: Sample Examination	PAID	f	2d814428-f385-46b5-97e8-d083d36f1613	2026-03-03 06:22:58.893	2026-03-03 06:41:50.482
9e706990-d554-405d-806a-16f69d32b22a	3833e492-b226-4c72-a764-a514a0f72e00	11	2	PAT-2026-128	093cba71-ff80-4568-8969-f93c80ec0cf9	Lab test: KOH Preparation	COMPLETED	f	f35553db-dafa-4124-90b2-9fcde72fcab0	2026-03-04 12:42:57.837	2026-03-04 16:25:27.884
81a3bee1-4be7-40bd-a4e5-e45d2f5f1f9f	78e7aacd-227f-4eaf-8573-3728b20ed1c7	10	2	PAT-2026-128	093cba71-ff80-4568-8969-f93c80ec0cf9	Lab test: T. vaginalis Wet Mount	COMPLETED	f	f35553db-dafa-4124-90b2-9fcde72fcab0	2026-03-04 12:18:05.537	2026-03-04 16:25:36.681
d4ab6c18-505b-4963-bb8a-6dc61e5bd82c	2ac46b62-4484-45db-ad1f-4587f0892bb2	9	2	PAT-2026-128	093cba71-ff80-4568-8969-f93c80ec0cf9	Lab test: AFB (Ziehl–Neelsen) - 3 Day	COMPLETED	f	f35553db-dafa-4124-90b2-9fcde72fcab0	2026-03-04 11:56:50.727	2026-03-04 16:26:00.162
9b9360bc-85d2-407c-bf36-ebc20c164879	be4e41bf-4221-4869-a81b-74098cab6e85	9	2	PAT-2026-128	093cba71-ff80-4568-8969-f93c80ec0cf9	Lab test: H. pylori Antigen (Stool Test)	COMPLETED	f	f35553db-dafa-4124-90b2-9fcde72fcab0	2026-03-04 11:56:50.717	2026-03-04 16:26:08.311
3178cb17-6e35-4130-81ff-041709ae6807	3e79e05b-8a3a-492c-bc46-1803a00d0eeb	14	2	PAT-2026-128	093cba71-ff80-4568-8969-f93c80ec0cf9	Lab test: Sample Examination	PAID	f	638d2d44-b5e2-4d6d-853b-7ba449454b81	2026-03-06 23:13:36.864	2026-03-06 23:13:47.27
8228b918-b741-42e9-8167-6bab25b3afaf	5ce52030-2492-49a6-9250-271d209a3686	\N	\N	LAB-20260307-001	\N		COMPLETED	t	b666fc6c-2ecf-4837-baa9-1fce494a3f07	2026-03-07 02:16:34.577	2026-03-07 02:20:07.947
6e931216-275e-45ee-bc9c-9e757408e703	a9272d05-9091-4703-bda3-e567b58ddad0	\N	\N	LAB-20260307-001	\N		COMPLETED	t	b666fc6c-2ecf-4837-baa9-1fce494a3f07	2026-03-07 02:16:34.572	2026-03-07 02:20:15.116
0a2e2957-87a4-44ba-868c-a60240626b39	b0cef63b-68c5-4865-81ab-f9304e078387	\N	\N	LAB-20260307-003	\N		PAID	t	0c6dba6a-2bce-4eb3-a5ea-e2724b524b0c	2026-03-07 03:03:12.647	2026-03-07 03:03:19.627
72796719-f78e-4e1b-8b8b-04c813b69a7a	5ce52030-2492-49a6-9250-271d209a3686	\N	\N	LAB-20260307-003	\N		PAID	t	0c6dba6a-2bce-4eb3-a5ea-e2724b524b0c	2026-03-07 03:03:12.652	2026-03-07 03:03:19.627
\.


--
-- Data for Name: LabTestResult; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public."LabTestResult" (id, "orderId", "testId", results, "additionalNotes", status, "verifiedBy", "verifiedAt", "createdAt", "updatedAt", "processedBy") FROM stdin;
279f7e47-1713-4632-b9b7-e554cbfd3e54	76ac5a2c-580a-4476-87da-6c7f80027e30	8b8c5630-ea8a-4ea0-aa68-4ba51411df0a	{"result": "Reactive"}	\N	COMPLETED	b818dc1d-4c36-4815-85ae-f50ad493cfe3	2026-02-26 16:18:08.661	2026-02-26 16:15:18.423	2026-02-26 16:18:08.662	\N
8e2009da-bfa9-49ad-860a-68d04e897d40	9e706990-d554-405d-806a-16f69d32b22a	3833e492-b226-4c72-a764-a514a0f72e00	{"result": "Hyphae seen", "specimen_type": "Nail clipping"}	\N	COMPLETED	b818dc1d-4c36-4815-85ae-f50ad493cfe3	2026-03-04 16:25:27.859	2026-03-04 16:25:27.861	2026-03-04 16:25:27.861	b818dc1d-4c36-4815-85ae-f50ad493cfe3
eca392df-80a9-41ce-be58-c77c0b6224ae	81a3bee1-4be7-40bd-a4e5-e45d2f5f1f9f	78e7aacd-227f-4eaf-8573-3728b20ed1c7	{"result": "Not seen", "pus_cells": "Many"}	\N	COMPLETED	b818dc1d-4c36-4815-85ae-f50ad493cfe3	2026-03-04 16:25:36.663	2026-03-04 16:25:36.665	2026-03-04 16:25:36.665	b818dc1d-4c36-4815-85ae-f50ad493cfe3
701b06d3-7fb4-4c10-b90b-cb306f14f9d3	d4ab6c18-505b-4963-bb8a-6dc61e5bd82c	2ac46b62-4484-45db-ad1f-4587f0892bb2	{"afb_day1": "1+", "afb_day2": "Scanty", "afb_day3": "1+", "final_interpretation": "Negative for AFB"}	\N	COMPLETED	b818dc1d-4c36-4815-85ae-f50ad493cfe3	2026-03-04 16:26:00.143	2026-03-04 16:26:00.144	2026-03-04 16:26:00.144	b818dc1d-4c36-4815-85ae-f50ad493cfe3
6391a4a6-cf49-40aa-814d-f6cac076ec02	9b9360bc-85d2-407c-bf36-ebc20c164879	be4e41bf-4221-4869-a81b-74098cab6e85	{"consistency": "Watery"}	\N	COMPLETED	b818dc1d-4c36-4815-85ae-f50ad493cfe3	2026-03-04 16:26:08.291	2026-03-04 16:26:08.293	2026-03-04 16:26:08.293	b818dc1d-4c36-4815-85ae-f50ad493cfe3
8b08d5fd-e620-4350-acef-f2caff0be9f7	7f46e017-71e8-4bde-b060-6664086bb0de	b1d6df5d-0c3a-4a3b-b5b5-c83d69f19118	{"antibody_type": "IgG & IgM"}	\N	COMPLETED	b818dc1d-4c36-4815-85ae-f50ad493cfe3	2026-03-04 16:26:14.054	2026-03-04 16:26:14.055	2026-03-04 16:26:14.055	b818dc1d-4c36-4815-85ae-f50ad493cfe3
fb80a148-8f14-4452-a0eb-878c5ec19369	8228b918-b741-42e9-8167-6bab25b3afaf	5ce52030-2492-49a6-9250-271d209a3686	{"result": "0", "reference_range": "0"}	\N	COMPLETED	b818dc1d-4c36-4815-85ae-f50ad493cfe3	2026-03-07 02:20:07.922	2026-03-07 02:20:07.923	2026-03-07 02:20:07.923	b818dc1d-4c36-4815-85ae-f50ad493cfe3
fee26ab8-77ae-4a37-9e31-c1b6b0f4ec7b	6e931216-275e-45ee-bc9c-9e757408e703	a9272d05-9091-4703-bda3-e567b58ddad0	{"rh": "Negative", "bloodGroup": "A"}	\N	COMPLETED	b818dc1d-4c36-4815-85ae-f50ad493cfe3	2026-03-07 02:20:15.097	2026-03-07 02:20:15.099	2026-03-07 02:20:15.099	b818dc1d-4c36-4815-85ae-f50ad493cfe3
\.


--
-- Data for Name: LabTestResultField; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public."LabTestResultField" (id, "testId", "fieldName", label, "fieldType", unit, "normalRange", options, "isRequired", "displayOrder", "createdAt", "updatedAt") FROM stdin;
94d8b58a-0600-47b9-a901-9b061977b624	8b8c5630-ea8a-4ea0-aa68-4ba51411df0a	result	Result	select	\N	\N	["Negative", "Positive"]	t	1	2026-02-26 16:16:39.669	2026-02-26 16:16:39.669
ee94f4b3-828c-4bde-bfe9-82aa491711fb	8b8c5630-ea8a-4ea0-aa68-4ba51411df0a	species	Species (if Positive)	multiselect	\N	\N	["Plasmodium falciparum", "Plasmodium vivax", "Plasmodium ovale", "Plasmodium malariae", "Mixed infection", "Species not identified"]	f	2	2026-02-26 16:16:39.669	2026-02-26 16:16:39.669
ec2a2c73-5402-498a-85c6-f3c6b9236199	8b8c5630-ea8a-4ea0-aa68-4ba51411df0a	parasite_density	Parasite Density	select	\N	\N	["1+", "2+", "3+", "4+"]	f	3	2026-02-26 16:16:39.669	2026-02-26 16:16:39.669
6477356d-c3ec-4ab7-9962-d28df697ab37	8b8c5630-ea8a-4ea0-aa68-4ba51411df0a	remark	Remark	textarea	\N	\N	null	f	4	2026-02-26 16:16:39.669	2026-02-26 16:16:39.669
157b5d26-9dc0-43a6-94e4-eeb650aa2146	be4e41bf-4221-4869-a81b-74098cab6e85	antibody_type	Antibody Type	select	\N	\N	["IgG", "IgM", "IgG & IgM"]	t	1	2026-03-07 04:06:57.149	2026-03-07 04:06:57.149
a8573f1a-2d6a-4870-af2b-3a1a710e4df2	be4e41bf-4221-4869-a81b-74098cab6e85	result	Result	select	\N	Negative	["Negative", "Positive", "Strongly Reactive"]	t	2	2026-03-07 04:06:57.149	2026-03-07 04:06:57.149
df355e64-eb8b-4b49-8869-724eb920fd6e	be4e41bf-4221-4869-a81b-74098cab6e85	remarks	Remarks	textarea	\N	\N	null	f	3	2026-03-07 04:06:57.149	2026-03-07 04:06:57.149
df424120-2fe4-4ab9-b2f7-9ea7d40d8691	3e79e05b-8a3a-492c-bc46-1803a00d0eeb	sample_type	Sample Type	select	\N	\N	["Sputum", "Urine", "Stool", "Vaginal swab", "Urethral swab", "Wound swab", "Pus", "Blood", "Other"]	t	1	2026-03-02 11:12:51.229	2026-03-02 11:12:51.229
23cc4ce4-5b18-4fa2-a9ff-97ebab1e1ef3	3e79e05b-8a3a-492c-bc46-1803a00d0eeb	macroscopic	Macroscopic Appearance	text	\N	\N	\N	f	2	2026-03-02 11:12:51.229	2026-03-02 11:12:51.229
0881fbf8-4ad4-43f7-9fd8-cac89938d29d	3e79e05b-8a3a-492c-bc46-1803a00d0eeb	collection_date	Collection Date	date	\N	\N	\N	t	3	2026-03-02 11:12:51.229	2026-03-02 11:12:51.229
0003717b-d249-4caf-a4e0-2883f289e0ea	3e79e05b-8a3a-492c-bc46-1803a00d0eeb	remarks	Remarks	textarea	\N	\N	\N	f	4	2026-03-02 11:12:51.229	2026-03-02 11:12:51.229
2c1fd76c-7e24-4479-9ca8-96135c685122	3833e492-b226-4c72-a764-a514a0f72e00	specimen_type	Specimen Type	select	\N	\N	["Skin scraping", "Nail clipping", "Hair", "Vaginal swab"]	t	1	2026-03-02 11:12:51.236	2026-03-02 11:12:51.236
05d25f80-8aa1-4f3e-b534-06af28948b55	3833e492-b226-4c72-a764-a514a0f72e00	result	Result	select	\N	\N	["Fungal elements not seen", "Yeast cells seen", "Budding yeast seen", "Hyphae seen", "Pseudohyphae seen"]	t	2	2026-03-02 11:12:51.236	2026-03-02 11:12:51.236
6280bc7b-c619-4ad3-a966-ddd52e064bd3	3833e492-b226-4c72-a764-a514a0f72e00	remark	Remark	textarea	\N	\N	\N	f	3	2026-03-02 11:12:51.236	2026-03-02 11:12:51.236
2ea434e0-7e1f-44d7-bf01-36a133235bea	250c941f-35e8-4bbb-8751-ff7ebed6fe16	specimen_type	Specimen Type	select	\N	\N	["Sputum", "Vaginal swab", "Urethral swab", "Wound swab", "Pus", "Other"]	t	1	2026-03-02 11:12:51.238	2026-03-02 11:12:51.238
dd7673f8-01a8-46f7-aa07-76fefb6ab229	250c941f-35e8-4bbb-8751-ff7ebed6fe16	gram_reaction	Gram Reaction	select	\N	\N	["No organism seen", "Gram-positive cocci", "Gram-negative cocci", "Gram-positive bacilli", "Gram-negative bacilli", "Mixed organisms"]	t	2	2026-03-02 11:12:51.238	2026-03-02 11:12:51.238
5249dffa-fc14-4be7-8e6b-7ab06c580fc3	250c941f-35e8-4bbb-8751-ff7ebed6fe16	pus_cells	Pus Cells	select	\N	\N	["Few", "Moderate", "Many"]	t	3	2026-03-02 11:12:51.238	2026-03-02 11:12:51.238
8d8c0efa-6f8b-4a7b-af89-b9cd3c5f6be9	250c941f-35e8-4bbb-8751-ff7ebed6fe16	epithelial_cells	Epithelial Cells	select	\N	\N	["Few", "Moderate", "Many"]	t	4	2026-03-02 11:12:51.238	2026-03-02 11:12:51.238
fb94ba7e-b54b-4b8f-a293-bbca8e26a643	250c941f-35e8-4bbb-8751-ff7ebed6fe16	remark	Remark	textarea	\N	\N	\N	f	5	2026-03-02 11:12:51.238	2026-03-02 11:12:51.238
082e2e4e-6929-4a7d-9652-1b664bca2369	2ac46b62-4484-45db-ad1f-4587f0892bb2	afb_day1	AFB – Day 1	select	\N	\N	["Negative", "Scanty", "1+", "2+", "3+"]	t	1	2026-03-02 11:12:51.241	2026-03-02 11:12:51.241
de19ecea-026c-402e-96ba-c405fa72c790	2ac46b62-4484-45db-ad1f-4587f0892bb2	afb_day2	AFB – Day 2	select	\N	\N	["Negative", "Scanty", "1+", "2+", "3+"]	t	2	2026-03-02 11:12:51.241	2026-03-02 11:12:51.241
d707cc67-865e-4f39-949e-b6cc02f1c316	2ac46b62-4484-45db-ad1f-4587f0892bb2	afb_day3	AFB – Day 3	select	\N	\N	["Negative", "Scanty", "1+", "2+", "3+"]	t	3	2026-03-02 11:12:51.241	2026-03-02 11:12:51.241
5eb896b6-20f9-4ed8-8a14-b5b0e626df13	2ac46b62-4484-45db-ad1f-4587f0892bb2	final_interpretation	Final Interpretation	select	\N	\N	["Negative for AFB", "Positive for AFB"]	t	4	2026-03-02 11:12:51.241	2026-03-02 11:12:51.241
1507cc29-4779-4664-b99c-6f842b0549ac	2ac46b62-4484-45db-ad1f-4587f0892bb2	remarks	Remarks	textarea	\N	\N	\N	f	5	2026-03-02 11:12:51.241	2026-03-02 11:12:51.241
00d97f01-7a73-4b90-8196-0b6cd425dd22	78e7aacd-227f-4eaf-8573-3728b20ed1c7	result	Result	select	\N	\N	["Not seen", "Motile Trichomonas seen"]	t	1	2026-03-02 11:12:51.245	2026-03-02 11:12:51.245
9bbc6b0c-52a3-4889-8d4a-b88251033205	78e7aacd-227f-4eaf-8573-3728b20ed1c7	pus_cells	Pus Cells	select	\N	\N	["Few", "Moderate", "Many"]	t	2	2026-03-02 11:12:51.245	2026-03-02 11:12:51.245
fa879aac-f455-419d-adbf-a54885d4eb60	78e7aacd-227f-4eaf-8573-3728b20ed1c7	remark	Remark	textarea	\N	\N	\N	f	3	2026-03-02 11:12:51.245	2026-03-02 11:12:51.245
42bfbf39-c366-41b0-9544-be8c945e6833	c55af77e-3783-4f9c-8e40-87f029eda2be	method	Method	select	\N	\N	["Rapid test", "ELISA"]	f	1	2026-03-02 11:12:51.251	2026-03-02 11:12:51.251
fd868e00-2540-4f4f-87a7-b228010ea64e	c55af77e-3783-4f9c-8e40-87f029eda2be	result	Result	select	\N	\N	["Negative", "Positive"]	t	2	2026-03-02 11:12:51.251	2026-03-02 11:12:51.251
518e109c-6e37-4e48-8435-d96a9ced7251	c55af77e-3783-4f9c-8e40-87f029eda2be	titer	Titer (if Positive)	text	\N	\N	\N	f	3	2026-03-02 11:12:51.251	2026-03-02 11:12:51.251
b1f084b1-fbf9-4080-aa71-d3bff5e5bd7d	c55af77e-3783-4f9c-8e40-87f029eda2be	pattern	Pattern	select	\N	\N	["Homogeneous", "Speckled", "Nucleolar", "Centromere", "Not specified"]	f	4	2026-03-02 11:12:51.251	2026-03-02 11:12:51.251
856d533b-89a6-4343-82c9-fa7f8c31c18d	c55af77e-3783-4f9c-8e40-87f029eda2be	remark	Remark	textarea	\N	\N	\N	f	5	2026-03-02 11:12:51.251	2026-03-02 11:12:51.251
6196e933-1d60-4890-99ca-e6fcbdc8140f	a14e5ff4-c65c-4ffa-81ce-cf6ce56a4d1f	value	HbA1c (%)	number	%	<5.7	null	t	1	2026-01-04 17:40:03.757	2026-01-04 17:40:03.757
073ba4b8-ea40-4731-9f87-2c4a2fbdb10a	32917792-a432-4614-8002-41ac62b30350	value	Hemoglobin (g/dL)	number	g/dL	M: 13.5–17.5, F: 12.0–15.5	null	t	1	2026-01-04 17:40:03.484	2026-01-04 17:40:03.484
9f4d7a10-0aa2-40b1-b7eb-666ea3344ec7	b0cef63b-68c5-4865-81ab-f9304e078387	hemoglobin	Hemoglobin (Hb)	number	g/dL	12.1-17.2	null	t	1	2026-01-10 21:40:34.491	2026-01-10 21:40:34.491
a460779c-b3f6-460a-aa7a-89f5a6723d33	79041707-e133-44da-ad4a-999aed280c02	value	RBC Count (million/µL)	number	million/µL	M: 4.5–5.9, F: 4.1–5.1	null	t	1	2026-01-04 17:40:03.496	2026-01-04 17:40:03.496
4978b214-d392-4026-9dc3-e7471b4a0139	ec0979c0-90a0-4065-afc0-7720567ba00c	value	WBC Count (/µL)	number	/µL	4,000–11,000	null	t	1	2026-01-04 17:40:03.501	2026-01-04 17:40:03.501
7d812945-8f03-483c-a961-28d8a3bf30b3	246218b6-ce36-4afb-acae-889cc68fcfd0	value	Platelet Count (/µL)	number	/µL	150,000–450,000	null	t	1	2026-01-04 17:40:03.506	2026-01-04 17:40:03.506
a8b805b1-6219-4181-b2d3-e3f494b2bf00	f1a6a422-829f-48c8-bbe8-82582cf86c43	mcv	MCV (fL)	number	fL	80–100	null	t	1	2026-01-04 17:40:03.512	2026-01-04 17:40:03.512
ce62defe-cc33-49a1-a5f9-b688ef5eb6dc	f1a6a422-829f-48c8-bbe8-82582cf86c43	mch	MCH (pg)	number	pg	27–31	null	t	2	2026-01-04 17:40:03.514	2026-01-04 17:40:03.514
3d0b2d1b-1843-43cf-b398-704df20062bc	f1a6a422-829f-48c8-bbe8-82582cf86c43	mchc	MCHC (g/dL)	number	g/dL	32–36	null	t	3	2026-01-04 17:40:03.516	2026-01-04 17:40:03.516
aa3b8190-d022-4c9b-a1dd-733c77fe68a2	e199ac78-4531-476e-8287-a036aa1b517f	neutrophils	Neutrophils (%)	number	%	40–70	null	t	1	2026-01-04 17:40:03.52	2026-01-04 17:40:03.52
d1272d61-80f7-4e30-8035-db4c00177b1b	e199ac78-4531-476e-8287-a036aa1b517f	lymphocytes	Lymphocytes (%)	number	%	20–40	null	t	2	2026-01-04 17:40:03.522	2026-01-04 17:40:03.522
fc0a8004-e435-42da-99f3-7ea8531e59e2	e199ac78-4531-476e-8287-a036aa1b517f	monocytes	Monocytes (%)	number	%	2–8	null	t	3	2026-01-04 17:40:03.523	2026-01-04 17:40:03.523
62c5a22c-45fe-446d-87cf-9bb37633c1fc	e199ac78-4531-476e-8287-a036aa1b517f	eosinophils	Eosinophils (%)	number	%	1–4	null	t	4	2026-01-04 17:40:03.525	2026-01-04 17:40:03.525
96413ac1-b427-48f7-9fb1-b111603e5c8c	e199ac78-4531-476e-8287-a036aa1b517f	basophils	Basophils (%)	number	%	0.5–1	null	t	5	2026-01-04 17:40:03.526	2026-01-04 17:40:03.526
aa995bdb-79ac-48ab-b058-7f9c0d63ec39	b0cef63b-68c5-4865-81ab-f9304e078387	hematocrit	Hematocrit (HCT/PCV)	number	%	36.1-50.3	null	t	2	2026-01-10 21:40:34.491	2026-01-10 21:40:34.491
49b24baf-f925-4b6e-827c-10fe83744733	a9272d05-9091-4703-bda3-e567b58ddad0	bloodGroup	Blood Group	select	\N	\N	["A", "B", "AB", "O"]	t	1	2026-01-04 17:40:03.536	2026-01-04 17:40:03.536
be43a798-1f95-4458-b426-7657f3750a5b	a9272d05-9091-4703-bda3-e567b58ddad0	rh	Rh Factor	select	\N	\N	["Positive", "Negative"]	t	2	2026-01-04 17:40:03.538	2026-01-04 17:40:03.538
88770468-c4c4-4992-bfb0-0af3697f5fbc	6c919999-d2c2-44f1-bdca-8dd0fbd0beff	value	Reticulocyte Count (%)	number	%	0.5–2.5	null	t	1	2026-01-04 17:40:03.542	2026-01-04 17:40:03.542
be399f7f-ace5-4ce8-b10f-2d87211e7219	f0af6cc9-63e3-4e52-9b71-87c4e5a6d256	value	Bleeding Time (minutes)	number	min	2–9	null	t	1	2026-01-04 17:40:03.546	2026-01-04 17:40:03.546
1789fbcb-4d74-43cb-b168-f10171b81cd6	2ad23d3a-0c8c-4006-8268-bf7e093c5ef4	value	Clotting Time (minutes)	number	min	2–8	null	t	1	2026-01-04 17:40:03.55	2026-01-04 17:40:03.55
a201d071-c517-4359-9486-f2c1256155da	b0cef63b-68c5-4865-81ab-f9304e078387	rbc	Red Blood Cell Count (RBC)	number	×10⁶/µL	4.2-6.1	null	t	3	2026-01-10 21:40:34.491	2026-01-10 21:40:34.491
4e991506-0c49-43a1-b472-ea7bd2e5b296	b0cef63b-68c5-4865-81ab-f9304e078387	wbc	White Blood Cell Count (WBC)	number	×10³/µL	4.5-11.0	null	t	4	2026-01-10 21:40:34.491	2026-01-10 21:40:34.491
88a81c98-f7dd-4a6d-a192-df613a893967	b0cef63b-68c5-4865-81ab-f9304e078387	lymph_num	Lymphocyte Number (Lymph#)	number	×10³/µL	1.0-4.8	null	f	5	2026-01-10 21:40:34.491	2026-01-10 21:40:34.491
d224c56d-ded4-4f3a-8d66-c113beaec552	b0cef63b-68c5-4865-81ab-f9304e078387	mid_num	Mid-range Cell Number (Mid#)	number	×10³/µL	0.1-1.0	null	f	6	2026-01-10 21:40:34.491	2026-01-10 21:40:34.491
5ca392bc-26f5-4f0c-8c84-4043ba01a965	b0cef63b-68c5-4865-81ab-f9304e078387	gran_num	Granulocyte Number (Gran#)	number	×10³/µL	1.8-7.7	null	f	7	2026-01-10 21:40:34.491	2026-01-10 21:40:34.491
2d7e3484-1402-4540-8997-b044be326582	b0cef63b-68c5-4865-81ab-f9304e078387	platelets	Platelets (Plt)	number	×10³/µL	150-450	null	t	8	2026-01-10 21:40:34.491	2026-01-10 21:40:34.491
1005d936-9518-4bad-8a14-b4de35960f3e	b0cef63b-68c5-4865-81ab-f9304e078387	mcv	Mean Corpuscular Volume (MCV)	number	fL	80-100	null	f	9	2026-01-10 21:40:34.491	2026-01-10 21:40:34.491
bb2b1194-a011-4394-a52b-216272e24593	b0cef63b-68c5-4865-81ab-f9304e078387	mch	Mean Corpuscular Hemoglobin (MCH)	number	pg	27-33	null	f	10	2026-01-10 21:40:34.491	2026-01-10 21:40:34.491
80f66f99-268d-4bb5-9954-c031bd778a3c	b0cef63b-68c5-4865-81ab-f9304e078387	mchc	Mean Corpuscular Hemoglobin Concentration (MCHC)	number	g/dL	32-36	null	f	11	2026-01-10 21:40:34.491	2026-01-10 21:40:34.491
939ab8ed-1fa9-4efe-92a1-31717776803c	b0cef63b-68c5-4865-81ab-f9304e078387	rdw_cv	Red Cell Distribution Width - CV (RDW-CV)	number	%	11.5-14.5	null	f	12	2026-01-10 21:40:34.491	2026-01-10 21:40:34.491
c0e5ada2-47d4-4bb5-b3ef-19caa2133740	b0cef63b-68c5-4865-81ab-f9304e078387	rdw_sd	Red Cell Distribution Width - SD (RDW-SD)	number	fL	39-46	null	f	13	2026-01-10 21:40:34.491	2026-01-10 21:40:34.491
ec137688-151c-4662-bb7f-f07a47afc9f2	b0cef63b-68c5-4865-81ab-f9304e078387	mpv	Mean Platelet Volume (MPV)	number	fL	7.5-11.5	null	f	14	2026-01-10 21:40:34.491	2026-01-10 21:40:34.491
cc962965-a550-44f9-84ce-7da9d40951b7	b0cef63b-68c5-4865-81ab-f9304e078387	pdw	Platelet Distribution Width (PDW)	number	fL	9.0-17.0	null	f	15	2026-01-10 21:40:34.491	2026-01-10 21:40:34.491
0928a7de-9538-4d63-a0be-5bc999d8638d	c870197e-8a4b-4a84-95f9-b0d1b44af2fb	remarks	Remarks (only if Reactive)	textarea	\N	\N	null	f	2	2026-01-07 21:22:16.017	2026-01-07 21:22:16.017
3358dc79-b67c-456d-af80-0a7f84e92e41	a0c2e6af-5844-4258-a4c3-1fa8fb97ddc0	result	Result	select	\N	Negative	["Positive", "Negative"]	t	1	2026-01-07 21:22:16.034	2026-01-07 21:22:16.034
73492d8a-6bed-40ec-b5d3-402000a919c3	a0c2e6af-5844-4258-a4c3-1fa8fb97ddc0	remarks	Remarks	textarea	\N	\N	null	f	2	2026-01-07 21:22:16.034	2026-01-07 21:22:16.034
e937dbe2-0b1d-4c08-b94a-f13b56aa99ab	526f5e17-addd-4321-be08-d580f9237e2d	result	Result	select	\N	Negative	["Positive", "Negative"]	t	1	2026-01-07 21:22:16.041	2026-01-07 21:22:16.041
f02492c3-49f9-4136-a853-be7a40a20930	526f5e17-addd-4321-be08-d580f9237e2d	remarks	Remarks	textarea	\N	\N	null	f	2	2026-01-07 21:22:16.041	2026-01-07 21:22:16.041
76a4bd17-1124-4e93-badf-c9118632eb9c	b953925e-247c-4b12-8d2c-15c5060bc268	consistency	Consistency	select	\N	\N	["Formed", "Semi-formed", "Loose", "Watery", "Hard"]	t	1	2026-01-07 21:22:16.056	2026-01-07 21:22:16.056
4fb80b92-7607-44d2-927d-646bb317842c	b953925e-247c-4b12-8d2c-15c5060bc268	blood	Blood	select	\N	No	["Yes", "No"]	t	2	2026-01-07 21:22:16.056	2026-01-07 21:22:16.056
9260a3c3-2371-4943-8283-4288d33401ec	b953925e-247c-4b12-8d2c-15c5060bc268	mucus	Mucus	select	\N	No	["Yes", "No"]	t	3	2026-01-07 21:22:16.056	2026-01-07 21:22:16.056
2e9ea91f-89da-46c0-8039-3906669b4738	b953925e-247c-4b12-8d2c-15c5060bc268	parasite_type	Parasite Type (if seen)	select	\N	\N	["Ascaris lumbricoides", "Trichuris trichiura", "Hookworm", "Entamoeba histolytica", "Giardia lamblia", "Taenia species", "Hymenolepis nana", "Enterobius vermicularis", "Strongyloides stercoralis", "Schistosoma mansoni", "Other (specify in remarks)"]	f	6	2026-01-07 21:22:16.056	2026-01-07 21:22:16.056
7fbdf25a-ee5f-4b49-96f2-0d0e83f7c024	b953925e-247c-4b12-8d2c-15c5060bc268	cyst	Cyst	select	\N	Not seen	["Seen", "Not seen"]	t	7	2026-01-07 21:22:16.056	2026-01-07 21:22:16.056
dab5bbb4-9561-4646-bf28-01959d035c4c	b953925e-247c-4b12-8d2c-15c5060bc268	remarks	Remarks	textarea	\N	\N	null	f	8	2026-01-07 21:22:16.056	2026-01-07 21:22:16.056
61d638f4-3d57-49d5-a0b2-b21929073f2e	b0cef63b-68c5-4865-81ab-f9304e078387	pct	Plateletcrit (PCT)	number	%	0.15-0.35	null	f	16	2026-01-10 21:40:34.491	2026-01-10 21:40:34.491
bc873802-e402-4fc3-ad90-641b4f48469d	b0cef63b-68c5-4865-81ab-f9304e078387	lymphocytes	Lymphocytes % (Lymph%)	number	%	20-45	null	f	17	2026-01-10 21:40:34.491	2026-01-10 21:40:34.491
253fed89-6fdf-45ba-aecf-73dcd8e72b4c	b0cef63b-68c5-4865-81ab-f9304e078387	mid_percent	Mid-range Cell % (Mid%)	number	%	3-15	null	f	18	2026-01-10 21:40:34.491	2026-01-10 21:40:34.491
98d7aa85-56cb-41d3-afe3-4aa73c85ee4c	b0cef63b-68c5-4865-81ab-f9304e078387	gran_percent	Granulocytes % (Gran%)	number	%	40-70	null	f	19	2026-01-10 21:40:34.491	2026-01-10 21:40:34.491
8e92977f-f072-4d63-83dd-404c1c93bfcf	b0cef63b-68c5-4865-81ab-f9304e078387	neutrophils	Neutrophils (N)	number	%	40-70	null	f	20	2026-01-10 21:40:34.491	2026-01-10 21:40:34.491
791070bc-80e9-4d3c-8acf-87e17aaf883e	b0cef63b-68c5-4865-81ab-f9304e078387	monocytes	Monocytes (M)	number	%	2-10	null	f	21	2026-01-10 21:40:34.491	2026-01-10 21:40:34.491
44a5753f-cea1-407c-b36c-fcc38462b94c	b0cef63b-68c5-4865-81ab-f9304e078387	eosinophils	Eosinophils (E)	number	%	0-5	null	f	22	2026-01-10 21:40:34.491	2026-01-10 21:40:34.491
5d5085a5-5450-4895-bb20-9e0d71826ac5	b0cef63b-68c5-4865-81ab-f9304e078387	basophils	Basophils (B)	number	%	0-2	null	f	23	2026-01-10 21:40:34.491	2026-01-10 21:40:34.491
14b160a5-992c-4e2f-882c-aa2f8fec9ecb	c870197e-8a4b-4a84-95f9-b0d1b44af2fb	result	Result	select	\N	Non-Reactive	["Non-Reactive", "Strongly Reactive", "Reactive"]	t	1	2026-01-07 21:22:16.017	2026-01-07 21:22:16.742
4ad2be39-223f-4dea-b3b4-33e92d7f42c3	b0cef63b-68c5-4865-81ab-f9304e078387	additional_notes	Additional Notes	textarea	\N	\N	null	f	24	2026-01-10 21:40:34.491	2026-01-10 21:40:34.491
7e60a426-d3ce-4651-9219-738391f3e772	b1d6df5d-0c3a-4a3b-b5b5-c83d69f19118	antibody_type	Antibody Type	select	\N	\N	["IgG", "IgM", "IgG & IgM"]	t	1	2026-01-07 21:22:16.398	2026-01-07 21:22:16.398
4e6174c8-4f68-4c8c-8fd5-47955a8d25e7	b1d6df5d-0c3a-4a3b-b5b5-c83d69f19118	result	Result	select	\N	Negative	["Negative", "Positive", "Strongly Reactive"]	t	2	2026-01-07 21:22:16.398	2026-01-07 21:22:16.398
dc5d72a0-4ec5-46e7-9168-775712a0af23	b1d6df5d-0c3a-4a3b-b5b5-c83d69f19118	remarks	Remarks	textarea	\N	\N	null	f	3	2026-01-07 21:22:16.398	2026-01-07 21:22:16.398
d2305292-2088-40a6-8b57-c7cbed426852	5ce52030-2492-49a6-9250-271d209a3686	result	Result (mm/hr)	number	mm/hr	Male: 0-15 mm/hr, Female: 0-20 mm/hr	null	t	1	2026-01-07 21:22:16.409	2026-01-07 21:22:16.409
41da3cf3-d979-40f5-b76f-b4f35eedeb35	5ce52030-2492-49a6-9250-271d209a3686	reference_range	Reference Range	text	\N	\N	null	f	2	2026-01-07 21:22:16.409	2026-01-07 21:22:16.409
bd694d6a-c546-42d9-860c-3c04cc36fbea	5ce52030-2492-49a6-9250-271d209a3686	remarks	Remarks	textarea	\N	\N	null	f	3	2026-01-07 21:22:16.409	2026-01-07 21:22:16.409
40718ea5-4cf0-4b6a-97d0-ad039dc1d6fb	71c0f60a-fb2e-47dd-bbd0-938064f34093	afb_result_first_spot	AFB Result (First Spot)	select	\N	Negative	["Negative", "Scanty", "1+", "2+", "3+"]	t	1	2026-01-15 14:02:23.294	2026-01-15 14:02:23.294
28eabb15-a9f3-40fc-a3eb-0f39e14a009f	71c0f60a-fb2e-47dd-bbd0-938064f34093	afb_count_first_spot	AFB Count (First Spot)	text	\N	\N	null	f	2	2026-01-15 14:02:23.294	2026-01-15 14:02:23.294
1110e870-c80d-495d-b9e9-c230bebff16a	71c0f60a-fb2e-47dd-bbd0-938064f34093	afb_result_morning	AFB Result (Morning)	select	\N	Negative	["Negative", "Scanty", "1+", "2+", "3+"]	t	3	2026-01-15 14:02:23.294	2026-01-15 14:02:23.294
b90d3cb3-78a4-46bb-a5b7-1959c705ae48	71c0f60a-fb2e-47dd-bbd0-938064f34093	afb_count_morning	AFB Count (Morning)	text	\N	\N	null	f	4	2026-01-15 14:02:23.294	2026-01-15 14:02:23.294
15c4c621-eef9-49b3-9113-10cafc2a7a37	71c0f60a-fb2e-47dd-bbd0-938064f34093	afb_result_second_spot	AFB Result (Second Spot)	select	\N	Negative	["Negative", "Scanty", "1+", "2+", "3+"]	t	5	2026-01-15 14:02:23.294	2026-01-15 14:02:23.294
c8cc9814-cb79-40e5-8b2e-8b7bb14cf68d	71c0f60a-fb2e-47dd-bbd0-938064f34093	afb_count_second_spot	AFB Count (Second Spot)	text	\N	\N	null	f	6	2026-01-15 14:02:23.294	2026-01-15 14:02:23.294
dc085a0b-736f-4a3e-abc1-2f991ac9ad91	71c0f60a-fb2e-47dd-bbd0-938064f34093	final_comment	Final Comment / Remarks	textarea	\N	\N	null	f	7	2026-01-15 14:02:23.294	2026-01-15 14:02:23.294
215d99f5-b67c-4026-b88c-f0c1702e5b2f	1f69db42-462b-4ee6-b357-f92adafc274a	color	Color	select	\N	\N	["Yellow", "Clear", "Cloudy", "Dark Yellow", "Amber", "Red", "Brown"]	t	1	2026-01-15 14:02:23.305	2026-01-15 14:02:23.305
b4a4eb43-a955-4e1a-8738-6e54b7256dc5	1f69db42-462b-4ee6-b357-f92adafc274a	appearance	Appearance	select	\N	\N	["Clear", "Cloudy", "Turbid"]	t	2	2026-01-15 14:02:23.305	2026-01-15 14:02:23.305
ccc30916-09b2-46ae-b18b-118bb750f461	1f69db42-462b-4ee6-b357-f92adafc274a	protein	Protein	select	\N	Negative	["Negative", "Trace", "+", "++"]	t	3	2026-01-15 14:02:23.305	2026-01-15 14:02:23.305
32023b5b-a7c3-433d-820c-d602741e4d52	1f69db42-462b-4ee6-b357-f92adafc274a	glucose	Glucose	select	\N	Negative	["Negative", "+", "++"]	t	4	2026-01-15 14:02:23.305	2026-01-15 14:02:23.305
9fcdc47a-ad3a-44ac-95db-9f78cb87d379	1f69db42-462b-4ee6-b357-f92adafc274a	ketone	Ketone	select	\N	Negative	["Negative", "+"]	t	5	2026-01-15 14:02:23.305	2026-01-15 14:02:23.305
88cfbd1f-6b7a-470c-a34d-f704d0af8a55	1f69db42-462b-4ee6-b357-f92adafc274a	blood	Blood	select	\N	Negative	["Negative", "+"]	t	6	2026-01-15 14:02:23.305	2026-01-15 14:02:23.305
8b0791b2-d07c-4e43-8010-7c64f6b699fb	1f69db42-462b-4ee6-b357-f92adafc274a	wbc	WBC	select	\N	\N	["None", "Few", "Moderate", "Many", "Full"]	f	7	2026-01-15 14:02:23.305	2026-01-15 14:02:23.305
84047e4d-1c9e-473e-b8f0-dc673964f2f4	1f69db42-462b-4ee6-b357-f92adafc274a	rbc	RBC	select	\N	\N	["None", "Few", "Moderate", "Many", "Full"]	f	8	2026-01-15 14:02:23.305	2026-01-15 14:02:23.305
5716c9c4-e3c4-49d2-97ef-0c35169b3191	1f69db42-462b-4ee6-b357-f92adafc274a	bacteria	Bacteria	select	\N	\N	["Few", "Moderate", "Full"]	f	9	2026-01-15 14:02:23.305	2026-01-15 14:02:23.305
df823e9e-ebfc-4325-86d4-0439e52f132b	b953925e-247c-4b12-8d2c-15c5060bc268	parasite	Parasite	select	\N	Not seen	["No O/P Seen", "Seen"]	t	5	2026-01-07 21:22:16.056	2026-02-08 10:45:00.072
a6f2dad9-e489-4759-a245-8fd4f29e9c0e	1f69db42-462b-4ee6-b357-f92adafc274a	epithelial_cells	Epithelial Cells	select	\N	\N	["None", "Few", "Moderate", "Many"]	f	10	2026-01-15 14:02:23.305	2026-01-15 14:02:23.305
bfc7c67b-8f9e-4571-bbfd-1be6c018257e	2f373e76-31e7-4da2-8cdc-386287ce6241	result	Result	select	\N	Negative (-ve)	["Negative (-ve)", "Positive (+ve)"]	t	1	2026-01-15 14:02:23.323	2026-01-15 14:02:23.323
f6564172-2ac3-43d4-92a3-5e5f5cbf1074	2f373e76-31e7-4da2-8cdc-386287ce6241	remarks	Remarks	textarea	\N	\N	null	f	2	2026-01-15 14:02:23.323	2026-01-15 14:02:23.323
e3b31e91-4d1e-4f17-8649-dace681d5f05	797d78de-63c6-4428-b377-5d02ae4018e1	result	Result	select	\N	Negative	["Negative", "Positive"]	t	1	2026-01-15 14:02:23.328	2026-01-15 14:02:23.328
3170d2cb-e80f-4ff7-809f-b1ec4f468d1e	797d78de-63c6-4428-b377-5d02ae4018e1	remarks	Remarks	textarea	\N	\N	null	f	2	2026-01-15 14:02:23.328	2026-01-15 14:02:23.328
05fd3cd3-6d25-479d-8cb3-76694af0d2c7	eccc85ba-0a40-4498-941c-8eb676c8be34	result	Result	select	\N	\N	["Non-reactive", "Strongly Reactive", "Reactive"]	t	1	2026-01-04 17:40:03.614	2026-01-07 21:22:16.747
73295bdb-5f27-47f2-a552-f0613bf78316	33a71531-d853-48be-98cc-4118d39ebf7d	result	VDRL	select	\N	\N	["Non-reactive", "Strongly Reactive", "Reactive"]	t	1	2026-01-04 17:40:03.658	2026-01-07 21:22:16.753
59fe4bc1-35c5-438a-a923-f08e1b91612a	eccc85ba-0a40-4498-941c-8eb676c8be34	titer	Titer	text	\N	\N	null	f	2	2026-01-04 17:40:03.615	2026-01-04 17:40:03.615
9686dbda-3a8a-48e0-b678-9be4d2568687	3dde3c15-548f-4cba-af38-7a7cfda874e7	testType	Test Type	select	\N	\N	["Malaria", "HIV", "COVID-19", "Strep", "Other"]	t	1	2026-01-04 17:40:03.637	2026-01-04 17:40:03.637
191df044-2f55-446d-b31b-8d8473ca8ba3	3dde3c15-548f-4cba-af38-7a7cfda874e7	result	Result	select	\N	\N	["Positive", "Negative", "Invalid"]	t	2	2026-01-04 17:40:03.638	2026-01-04 17:40:03.638
7e46bed6-8f71-4c8f-92da-7d7f2baec201	3dde3c15-548f-4cba-af38-7a7cfda874e7	notes	Notes	textarea	\N	\N	null	f	3	2026-01-04 17:40:03.64	2026-01-04 17:40:03.64
15b0256b-893f-4cd7-9f76-e9488200c025	1d902667-d1ec-4148-ab5a-cea63c9d9f2d	result	RF	select	\N	\N	["Negative", "Positive"]	t	1	2026-01-04 17:40:03.644	2026-01-04 17:40:03.644
d8cd95c7-363a-40e7-8c9d-18a3e3adb205	1d902667-d1ec-4148-ab5a-cea63c9d9f2d	titer	Titer (IU/mL)	number	IU/mL	\N	null	f	2	2026-01-04 17:40:03.645	2026-01-04 17:40:03.645
8d6c5638-e360-4299-80ad-5546328c327e	4e5de39d-7705-4130-a2ea-29eb2bae4768	value	ASO Titer (IU/mL)	number	IU/mL	<200	null	t	1	2026-01-04 17:40:03.65	2026-01-04 17:40:03.65
72ebd193-41ff-497a-8026-64fc6839d26d	33a71531-d853-48be-98cc-4118d39ebf7d	titer	Titer	text	\N	\N	null	f	2	2026-01-04 17:40:03.66	2026-01-04 17:40:03.66
2f9e6b71-a2ea-468e-b6c0-be7f18abd569	82fd708c-713c-449c-baa3-8d083394f669	value	ALT (U/L)	number	U/L	7–56	null	t	1	2026-01-04 17:40:03.678	2026-01-04 17:40:03.678
7c6516b5-0032-4362-af8f-583e2d71d2ed	9f0aff24-2e7c-4a38-b463-55922b488692	value	AST (U/L)	number	U/L	10–40	null	t	1	2026-01-04 17:40:03.682	2026-01-04 17:40:03.682
e2c3a4ab-07e7-43de-bbc4-7de80211f21b	a9fd508f-bb4e-4447-8ff7-cbe1f37dc9a9	value	ALP (U/L)	number	U/L	44–147	null	t	1	2026-01-04 17:40:03.686	2026-01-04 17:40:03.686
51e3b05f-469f-40c2-9f9c-8651ab9d3547	6a5fea3e-39ec-42b4-ae0c-b9af7a361c10	value	Total Bilirubin (mg/dL)	number	mg/dL	0.1–1.2	null	t	1	2026-01-04 17:40:03.691	2026-01-04 17:40:03.691
f0f728d7-ab8d-4077-a2c9-f39eabee13a9	83c8787e-e308-4d5f-871e-7582f0d0fb00	value	Direct Bilirubin (mg/dL)	number	mg/dL	0.0–0.3	null	t	1	2026-01-04 17:40:03.696	2026-01-04 17:40:03.696
494843b4-b939-4fb8-bc87-235f5c755088	0be41e49-0dd2-4982-b13c-efa7a397a0da	value	Total Protein (g/dL)	number	g/dL	6.0–8.3	null	t	1	2026-01-04 17:40:03.701	2026-01-04 17:40:03.701
e7a05720-454c-4594-9d71-6724d607b71b	a7840826-dc05-475a-a1ea-5ace0f0006e5	value	Albumin (g/dL)	number	g/dL	3.5–5.0	null	t	1	2026-01-04 17:40:03.705	2026-01-04 17:40:03.705
1d5c9403-4160-49a6-95ed-76ada968ab3d	faeadd1d-e600-4835-ae04-0d23ba54f9e9	value	Creatinine (mg/dL)	number	mg/dL	M: 0.7–1.3, F: 0.6–1.1	null	t	1	2026-01-04 17:40:03.708	2026-01-04 17:40:03.708
040c3912-b664-4a62-b201-f12912d38996	6e1d4804-7935-4ff5-a1c0-986d15aa7444	value	BUN (mg/dL)	number	mg/dL	7–20	null	t	1	2026-01-04 17:40:03.712	2026-01-04 17:40:03.712
692c193e-20ba-4754-b4c9-19ab0b627525	2102701e-32e8-4f4f-9319-feb233c06dda	value	Uric Acid (mg/dL)	number	mg/dL	M: 3.4–7.0, F: 2.4–6.0	null	t	1	2026-01-04 17:40:03.716	2026-01-04 17:40:03.716
4653d2a3-c2dd-4d18-805d-95825bdf9c22	77518a51-37f3-4441-b72c-9ea7cb7f26d8	value	Total Cholesterol (mg/dL)	number	mg/dL	<200	null	t	1	2026-01-04 17:40:03.719	2026-01-04 17:40:03.719
9d8f8712-e48a-4104-a763-09b51952f605	15107b86-b9b5-4366-aade-80f67c38ea7b	value	HDL (mg/dL)	number	mg/dL	M: >40, F: >50	null	t	1	2026-01-04 17:40:03.723	2026-01-04 17:40:03.723
82220bb2-7e5d-4b74-9ce9-3420617a2f0a	2f3252e6-cb7a-4fb7-9838-36e2099f2957	value	LDL (mg/dL)	number	mg/dL	<100	null	t	1	2026-01-04 17:40:03.727	2026-01-04 17:40:03.727
5a191695-b455-4df1-81de-662f39dd4b3a	7ab91833-adad-4c86-84d8-f792925e318d	value	Triglycerides (mg/dL)	number	mg/dL	<150	null	t	1	2026-01-04 17:40:03.731	2026-01-04 17:40:03.731
c863506a-b715-49ec-9c40-82618bcd07d9	7c5fbccc-ef0f-444b-bbaf-4a61641e7dc4	value	TSH	number	mIU/L	0.4-4.0 mIU/L (varies by lab, age, pregnancy)	null	t	1	2026-01-04 17:40:03.736	2026-01-04 17:40:03.736
bb09ec5b-fb0b-4778-9305-ddb9eb1a024b	332e5db0-e535-44a0-9ae8-c88837328c88	value	Free T3	number	pg/mL	2.3-4.2 pg/mL (or 3.5-6.5 pmol/L)	null	t	1	2026-01-04 17:40:03.74	2026-01-04 17:40:03.74
32f8272c-d93c-459d-a7f1-937ef2b13fda	e4dfd400-45c5-4a58-98b6-5639d02f9506	value	Free T4	number	ng/dL	0.8-1.8 ng/dL (or 10-23 pmol/L)	null	t	1	2026-01-04 17:40:03.744	2026-01-04 17:40:03.744
c75165a1-3f61-4c86-9c6f-91084aea4df5	49b105e5-3c6c-44fe-8415-387d9ae49481	value	Fasting Blood Glucose (mg/dL)	number	mg/dL	70–99	null	t	1	2026-01-04 17:40:03.748	2026-01-04 17:40:03.748
ea35d302-207f-4ced-8068-3aa2086f8213	f2e38bde-9795-485c-be70-3639799186cd	value	Random Blood Glucose (mg/dL)	number	mg/dL	<140	null	t	1	2026-01-04 17:40:03.752	2026-01-04 17:40:03.752
e65d6d0d-7dcb-4d54-954f-c94345005a31	b953925e-247c-4b12-8d2c-15c5060bc268	ova	Ova	select	\N	Not seen	["No O/P Seen", "Seen"]	t	4	2026-01-07 21:22:16.056	2026-02-08 10:45:00.069
8b386664-83a5-4c6b-a975-84c3cfa59573	0684c2cf-8c69-406c-86e6-a39012d2cd2a	result	Result	select	\N	\N	["Reactive", "Non-reactive", "Strong Reactive"]	t	1	2026-02-08 14:44:49.953	2026-02-08 14:44:49.953
11d67740-c655-489b-99ce-88066877b3db	28ecf5d6-b1f3-4126-a942-8d0734fe7f18	result	Result	select	\N	\N	["Reactive", "Non-reactive", "Strong Reactive"]	t	1	2026-02-08 14:44:49.963	2026-02-08 14:44:49.963
d6b88fd8-8aec-452c-8d3f-b34323215718	335353da-bc1b-419c-b04d-e6cca18a78a1	result	Result	select	\N	\N	["Reactive", "Non-reactive", "Strong Reactive"]	t	1	2026-02-08 14:44:49.986	2026-02-08 14:44:49.986
\.


--
-- Data for Name: LabTestResultFile; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public."LabTestResultFile" (id, "resultId", "fileUrl", "fileName", "fileType", "uploadedAt", "uploadedBy") FROM stdin;
\.


--
-- Data for Name: LabTestTemplate; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public."LabTestTemplate" (id, name, category, description, fields, "isActive", "createdAt", "updatedAt") FROM stdin;
c39f0c5d-e674-4c7d-937e-84d7cbdfa37d	Sample Examination	Microbiology	General specimen examination template	{"remarks": {"type": "textarea", "label": "Remarks", "required": false, "placeholder": "Additional observations"}, "specimenType": {"type": "select", "label": "Specimen Type", "options": ["Sputum", "Urine", "Stool", "Vaginal swab", "Urethral swab", "Wound swab", "Pus", "Blood", "Other"], "required": true}, "collectionDate": {"type": "date", "label": "Collection Date", "required": true}, "macroscopicAppearance": {"type": "text", "label": "Macroscopic Appearance", "required": false, "placeholder": "Enter macroscopic examination findings"}}	t	2026-03-04 15:23:50.249	2026-03-04 15:23:50.249
17428eec-ddc8-4e5b-9831-efbcdee39327	KOH Preparation	Microbiology	KOH preparation for fungal examination	{"remark": {"type": "textarea", "label": "Remark", "required": false, "placeholder": "Additional findings or comments"}, "result": {"type": "select", "label": "Result", "options": ["Fungal elements not seen", "Yeast cells seen", "Budding yeast seen", "Hyphae seen", "Pseudohyphae seen"], "required": true}, "specimenType": {"type": "select", "label": "Specimen Type", "options": ["Skin scraping", "Nail clipping", "Hair", "Vaginal swab", "Other"], "required": true}}	t	2026-03-04 15:23:50.264	2026-03-04 15:23:50.264
83d08167-278c-471b-8f7f-e49ec610523d	Gram Stain	Microbiology	Gram stain for bacterial identification	{"remark": {"type": "textarea", "label": "Remark", "required": false, "placeholder": "Additional findings"}, "pusCells": {"type": "select", "label": "Pus Cells", "options": ["Few", "Moderate", "Many"], "required": false}, "gramReaction": {"type": "select", "label": "Gram Reaction", "options": ["No organism seen", "Gram-positive cocci", "Gram-negative cocci", "Gram-positive bacilli", "Gram-negative bacilli", "Mixed organisms"], "required": true}, "specimenType": {"type": "select", "label": "Specimen Type", "options": ["Sputum", "Vaginal swab", "Urethral swab", "Wound swab", "Pus", "Other"], "required": true}}	t	2026-03-04 15:23:50.267	2026-03-04 15:23:50.267
\.


--
-- Data for Name: Loan; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public."Loan" (id, "staffId", "requestedAmount", "approvedAmount", status, reason, notes, "requestedAt", "reviewedAt", "approvedAt", "deniedAt", "givenAt", "reviewedById", "givenById", "expenseId", "settlementMethod", "settledAt", "settledById", "settledAmount", "settlementAcceptedAt", "settlementAcceptedById", "settlementAcceptedAmount", "createdAt", "updatedAt") FROM stdin;
\.


--
-- Data for Name: MaterialNeedsOrder; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public."MaterialNeedsOrder" (id, "visitId", "patientId", "nurseId", "serviceId", quantity, instructions, notes, status, "billingId", "completedAt", "createdAt", "updatedAt") FROM stdin;
1	2	PAT-2026-128	093cba71-ff80-4568-8969-f93c80ec0cf9	69a3246e-38ac-4ae7-b89b-1ecc24d1e92e	1			PAID	f9440a07-3755-4fa5-bf83-68323aef694b	\N	2026-03-04 23:40:41.079	2026-03-04 23:41:15.935
\.


--
-- Data for Name: MedicalCertificate; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public."MedicalCertificate" (id, "certificateNo", "patientId", "doctorId", "visitId", "certificateDate", "restStartDate", "restEndDate", "totalDays", diagnosis, treatment, recommendations, status, "createdAt", "updatedAt", "appointmentDate") FROM stdin;
eb8b809e-42b0-49fb-91be-9584e8fd740c	MC-000001	PAT-2026-96	093cba71-ff80-4568-8969-f93c80ec0cf9	\N	2026-02-26 00:00:00	\N	\N	\N	fhgjkl	hgjhkl	nbmn,	ACTIVE	2026-02-26 21:12:05.451	2026-02-26 21:12:05.451	\N
\.


--
-- Data for Name: MedicalHistory; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public."MedicalHistory" (id, "patientId", "visitId", "doctorId", "visitUid", "visitDate", "completedDate", details, diagnosis, "diagnosisDetails", instructions, "finalNotes", "needsAppointment", "appointmentId", "createdAt", "updatedAt") FROM stdin;
\.


--
-- Data for Name: MedicationCatalog; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public."MedicationCatalog" (id, name, "genericName", "dosageForm", strength, category, "unitPrice", "availableQuantity", "minimumStock", unit, "packSize", manufacturer, "createdAt", "updatedAt", description, "isRetailOnly") FROM stdin;
bafc1cf3-7932-41b7-b535-84c1257bad49	Amoxicillin 500mg	\N	Tablet	500mg	TABLETS	5	100	10	\N	\N	\N	2026-01-04 10:11:23.864	2026-01-04 10:11:23.864	Antibiotic	f
6c95bd46-19bc-4392-849d-cb191bf810c4	Clindamycin 300mg	\N	Capsule	300mg	CAPSULES	6.5	100	10	\N	\N	\N	2026-01-04 10:11:23.869	2026-01-04 10:11:23.869	Antibiotic	f
47453419-3db2-4e89-9310-2dce7408ff00	Metronidazole 400mg	\N	Tablet	400mg	TABLETS	4.5	100	10	\N	\N	\N	2026-01-04 10:11:23.871	2026-01-04 10:11:23.871	Antibiotic/Antiprotozoal	f
eb02ef22-6b3e-4227-a960-0641f79eacb9	Penicillin V 500mg	\N	Tablet	500mg	TABLETS	4	100	10	\N	\N	\N	2026-01-04 10:11:23.874	2026-01-04 10:11:23.874	Antibiotic	f
76279dc6-269f-4c84-9cbb-2533b03cb3bf	Azithromycin 250mg	\N	Tablet	250mg	TABLETS	7	100	10	\N	\N	\N	2026-01-04 10:11:23.877	2026-01-04 10:11:23.877	Antibiotic	f
472e4f55-fc63-4294-b61c-6e4a4f0973cd	Amoxicillin + Clavulanic Acid 625mg	\N	Tablet	625mg	TABLETS	7	100	10	\N	\N	\N	2026-01-04 10:11:23.88	2026-01-04 10:11:23.88	Broad-spectrum antibiotic	f
ef277098-51c5-4bd1-8d7f-b6e556d24092	Cefalexin 500mg	\N	Capsule	500mg	CAPSULES	6	100	10	\N	\N	\N	2026-01-04 10:11:23.882	2026-01-04 10:11:23.882	Antibiotic	f
4bdd9087-3e41-430e-b14e-6f781468c2fa	Doxycycline 100mg	\N	Tablet	100mg	TABLETS	8	100	10	\N	\N	\N	2026-01-04 10:11:23.885	2026-01-04 10:11:23.885	Antibiotic	f
ef51334d-77fd-4e03-b53d-fe8e26e08cf6	Clarithromycin 250mg	\N	Tablet	250mg	TABLETS	9	100	10	\N	\N	\N	2026-01-04 10:11:23.888	2026-01-04 10:11:23.888	Antibiotic	f
c5e34c67-5c48-494b-8ab3-30f9d40ccf4c	Metronidazole + Amoxicillin 500mg	\N	Tablet	500mg	TABLETS	8.5	100	10	\N	\N	\N	2026-01-04 10:11:23.89	2026-01-04 10:11:23.89	Combination antibiotic	f
f1a8d2aa-7f4f-47de-87d6-7e33734de27d	Ibuprofen 400mg	\N	Tablet	400mg	TABLETS	2	100	10	\N	\N	\N	2026-01-04 10:11:23.893	2026-01-04 10:11:23.893	NSAID painkiller	f
23769a46-0213-445e-90b6-b0debc3245a7	Paracetamol 500mg	\N	Tablet	500mg	TABLETS	1.5	100	10	\N	\N	\N	2026-01-04 10:11:23.895	2026-01-04 10:11:23.895	Analgesic/antipyretic	f
2644b811-d0bc-4994-9ee3-266e9f7066dd	Acetaminophen 500mg	\N	Tablet	500mg	TABLETS	1.5	100	10	\N	\N	\N	2026-01-04 10:11:23.898	2026-01-04 10:11:23.898	Analgesic	f
9b1c1a04-dd59-4f9a-8a9f-aacfab2784b7	Naproxen 250mg	\N	Tablet	250mg	TABLETS	3.5	100	10	\N	\N	\N	2026-01-04 10:11:23.901	2026-01-04 10:11:23.901	NSAID	f
75dfa92b-78c3-44eb-8211-ae286df61da7	Ketorolac 10mg	\N	Tablet	10mg	TABLETS	6	100	10	\N	\N	\N	2026-01-04 10:11:23.904	2026-01-04 10:11:23.904	Strong NSAID	f
95e84d18-de30-4346-a154-42ed3ac2c8bf	Tramadol 50mg	\N	Tablet	50mg	TABLETS	5.5	100	10	\N	\N	\N	2026-01-04 10:11:23.907	2026-01-04 10:11:23.907	Opioid analgesic	f
28305d11-c259-4bea-a897-ce2e2b980094	Aspirin 325mg	\N	Tablet	325mg	TABLETS	1.5	100	10	\N	\N	\N	2026-01-04 10:11:23.91	2026-01-04 10:11:23.91	Anti-inflammatory/antiplatelet	f
b8c68214-0b32-4e29-ae15-2ac177b6c665	Diclofenac 50mg	\N	Tablet	50mg	TABLETS	3.5	100	10	\N	\N	\N	2026-01-04 10:11:23.913	2026-01-04 10:11:23.913	NSAID	f
c0a72fb0-cdd2-4519-b129-05360ea892f1	Codeine 30mg	\N	Tablet	30mg	TABLETS	7	100	10	\N	\N	\N	2026-01-04 10:11:23.916	2026-01-04 10:11:23.916	Opioid cough/pain	f
33d734d1-79ab-4f6d-b366-1219445bd081	Morphine Sulfate 10mg	\N	Tablet	10mg	TABLETS	15	100	10	\N	\N	\N	2026-01-04 10:11:23.918	2026-01-04 10:11:23.918	Strong opioid analgesic	f
b36e1392-316c-43e6-b788-04786b0d0d11	Lidocaine 2% Injectable	\N	Injection	2%	INJECTIONS	10	100	10	\N	\N	\N	2026-01-04 10:11:23.921	2026-01-04 10:11:23.921	Local anesthetic	f
7fccee7f-6a32-4239-9d64-2c4e786dbec1	Articaine 4% Injectable	\N	Injection	4%	INJECTIONS	12	100	10	\N	\N	\N	2026-01-04 10:11:23.924	2026-01-04 10:11:23.924	Local anesthetic	f
21552fb1-8eca-4a63-a8dd-e7fa15421ec9	Epinephrine 1:100,000	\N	Injection	N/A	INJECTIONS	15	100	10	\N	\N	\N	2026-01-04 10:11:23.927	2026-01-04 10:11:23.927	Vasoconstrictor	f
98be91e0-c2e4-447c-8c29-f974abe0a902	Topical Benzocaine 20%	\N	Ointment	20%	OINTMENTS	5	100	10	\N	\N	\N	2026-01-04 10:11:23.93	2026-01-04 10:11:23.93	Topical anesthetic	f
066ba609-0a92-433f-b9e3-46a5f6a04bb9	Oral Lidocaine Spray 10%	\N	Drops	10%	DROPS	6	100	10	\N	\N	\N	2026-01-04 10:11:23.932	2026-01-04 10:11:23.932	Topical anesthetic spray	f
6352f354-39fb-490f-8a5f-a77c2acc09c6	Prilocaine 4% Injectable	\N	Injection	4%	INJECTIONS	11	100	10	\N	\N	\N	2026-01-04 10:11:23.935	2026-01-04 10:11:23.935	Local anesthetic	f
7931248c-d84a-42ab-930c-c126eece08a8	Mepivacaine 3% Injectable	\N	Injection	3%	INJECTIONS	12	100	10	\N	\N	\N	2026-01-04 10:11:23.937	2026-01-04 10:11:23.937	Local anesthetic	f
f5322c86-8798-427d-aced-a6f573332d5f	Bupivacaine 0.5% Injectable	\N	Injection	0.5%	INJECTIONS	14	100	10	\N	\N	\N	2026-01-04 10:11:23.94	2026-01-04 10:11:23.94	Long-acting anesthetic	f
ec62c4e8-4828-402c-9cf6-d80dd77f2f67	Chlorhexidine Mouthwash 0.12%	\N	Syrup	0.12%	SYRUPS	3	100	10	\N	\N	\N	2026-01-04 10:11:23.942	2026-01-04 10:11:23.942	Antiseptic mouth rinse	f
6c2e670e-f8c9-48d8-b839-03695d78fc52	Fluoride Gel 1.23%	\N	Ointment	1.23%	OINTMENTS	8	100	10	\N	\N	\N	2026-01-04 10:11:23.945	2026-01-04 10:11:23.945	Topical fluoride	f
42b3d59f-6389-4a77-b6d1-568f7db782f9	Fluoride Varnish 5%	\N	Ointment	5%	OINTMENTS	12	100	10	\N	\N	\N	2026-01-04 10:11:23.948	2026-01-04 10:11:23.948	Professional fluoride treatment	f
ac77eec9-ae39-4d20-a071-efb14b7c6771	Sodium Fluoride Rinse 0.05%	\N	Syrup	0.05%	SYRUPS	3	100	10	\N	\N	\N	2026-01-04 10:11:23.951	2026-01-04 10:11:23.951	Daily fluoride rinse	f
828e7352-905a-4719-af85-5d9161e6e0f1	Mouthwash with Xylitol	\N	Syrup	N/A	SYRUPS	4.5	100	10	\N	\N	\N	2026-01-04 10:11:23.953	2026-01-04 10:11:23.953	Caries-preventive rinse	f
f7e3d15c-6051-44f4-9929-24b2d287cf06	Mouthwash with Essential Oils	\N	Syrup	N/A	SYRUPS	3.5	100	10	\N	\N	\N	2026-01-04 10:11:23.956	2026-01-04 10:11:23.956	Antiseptic rinse	f
0e97b7e2-5b7f-46ff-b8ae-be1804c337ef	Toothpaste with Fluoride	\N	Ointment	N/A	OINTMENTS	2	100	10	\N	\N	\N	2026-01-04 10:11:23.959	2026-01-04 10:11:23.959	OTC fluoride toothpaste	f
2a37a08a-cf82-4087-a69c-cd9b1e70a85f	Desensitizing Toothpaste	\N	Ointment	N/A	OINTMENTS	3	100	10	\N	\N	\N	2026-01-04 10:11:23.961	2026-01-04 10:11:23.961	For sensitive teeth	f
db8e6f4f-3742-4dec-abe4-fb1d5d9cf7c4	Oral Probiotic Gel	\N	Ointment	N/A	OINTMENTS	6	100	10	\N	\N	\N	2026-01-04 10:11:23.964	2026-01-04 10:11:23.964	Oral microbiome support	f
afaa03e0-b0d3-4428-b21a-f23e09a3124f	Whitening Gel	\N	Ointment	N/A	OINTMENTS	10	100	10	\N	\N	\N	2026-01-04 10:11:23.966	2026-01-04 10:11:23.966	Bleaching agent	f
1fc1d3cd-a503-49ae-926f-3ecc16b2375e	Dexamethasone 4mg	\N	Tablet	4mg	TABLETS	5.5	100	10	\N	\N	\N	2026-01-04 10:11:23.969	2026-01-04 10:11:23.969	Corticosteroid	f
233f5848-4a9e-4b40-a7e6-32e1f7476958	Topical Corticosteroid Gel (Hydrocortisone 1%)	\N	Ointment	1%	OINTMENTS	5.5	100	10	\N	\N	\N	2026-01-04 10:11:23.971	2026-01-04 10:11:23.971	Anti-inflammatory gel	f
bdfdbb81-b0a1-4170-a98b-36818017a2bb	Prednisolone 5mg	\N	Tablet	5mg	TABLETS	6	100	10	\N	\N	\N	2026-01-04 10:11:23.974	2026-01-04 10:11:23.974	Corticosteroid	f
5c579c07-4724-406f-869d-3fb3c8f10a94	Methylprednisolone 4mg	\N	Tablet	4mg	TABLETS	6.5	100	10	\N	\N	\N	2026-01-04 10:11:23.977	2026-01-04 10:11:23.977	Corticosteroid	f
a282eb5a-68e9-4c11-bf74-5a0f818e84e4	Vitamin C Chewable 500mg	\N	Tablet	500mg	TABLETS	2	100	10	\N	\N	\N	2026-01-04 10:11:23.979	2026-01-04 10:11:23.979	Vitamin supplement	f
3f9d0470-ecea-45ca-8d9e-14e64e07b4be	Calcium + Vitamin D Tablets	\N	Tablet	N/A	TABLETS	3.5	100	10	\N	\N	\N	2026-01-04 10:11:23.982	2026-01-04 10:11:23.982	Bone health supplement	f
fac65ee0-232e-4949-842d-efcbf7d7eb28	Vitamin B Complex	\N	Tablet	N/A	TABLETS	4	100	10	\N	\N	\N	2026-01-04 10:11:23.984	2026-01-04 10:11:23.984	B-vitamin supplement	f
66968769-e36c-478a-924b-5fc0e67e484b	Zinc Supplement 50mg	\N	Tablet	50mg	TABLETS	3	100	10	\N	\N	\N	2026-01-04 10:11:23.986	2026-01-04 10:11:23.986	Immune support	f
303d3285-4a51-421a-9962-80a75b3261cf	Iron + Folic Acid Tablet	\N	Tablet	N/A	TABLETS	4.5	100	10	\N	\N	\N	2026-01-04 10:11:23.989	2026-01-04 10:11:23.989	Hematopoietic supplement	f
c0e3cf7e-8332-4d98-a50c-0602bc7cc6fe	Saliva Ejector Tubes	\N	Ointment	N/A	OINTMENTS	2	100	10	\N	\N	\N	2026-01-04 10:11:24.117	2026-01-04 10:11:24.117	Saliva ejector	t
5bfcbe15-c233-4e60-8458-2722b8c024d2	Antifungal Oral Gel (Nystatin 100,000 IU)	\N	Ointment	N/A	OINTMENTS	6	100	10	\N	\N	\N	2026-01-04 10:11:23.992	2026-01-04 10:11:23.992	Antifungal	f
c9a2717d-ac9d-4170-9f25-c557f4146e93	Clotrimazole Troches 10mg	\N	Tablet	10mg	TABLETS	7	100	10	\N	\N	\N	2026-01-04 10:11:23.995	2026-01-04 10:11:23.995	Antifungal lozenge	f
2d4d3dd0-675d-4665-b3c7-149c38fb0a76	Acyclovir 400mg	\N	Tablet	400mg	TABLETS	8	100	10	\N	\N	\N	2026-01-04 10:11:23.998	2026-01-04 10:11:23.998	Antiviral	f
545a2072-1f5c-44c5-afbe-7481b347410f	Valacyclovir 500mg	\N	Tablet	500mg	TABLETS	9	100	10	\N	\N	\N	2026-01-04 10:11:24.002	2026-01-04 10:11:24.002	Antiviral	f
a3ea2425-fec2-4b08-81cf-a8c47bc9e716	Calcium Hydroxide Paste	\N	Ointment	N/A	OINTMENTS	8	100	10	\N	\N	\N	2026-01-04 10:11:24.005	2026-01-04 10:11:24.005	Endodontic material	t
7f1392bb-740b-4e9b-a6a0-2e4adeac640c	Gutta-Percha Points	\N	Ointment	N/A	OINTMENTS	10	100	10	\N	\N	\N	2026-01-04 10:11:24.008	2026-01-04 10:11:24.008	Root canal filling material	t
e7ff1850-2b14-4276-b8ce-99096a6f2d84	Temporary Filling Material (Zinc Oxide Eugenol)	\N	Ointment	N/A	OINTMENTS	6.5	100	10	\N	\N	\N	2026-01-04 10:11:24.011	2026-01-04 10:11:24.011	Temporary restoration	t
31b7e920-0b79-4cba-a68e-3982c6c1dda4	Permanent Filling Material (Composite Resin)	\N	Ointment	N/A	OINTMENTS	12	100	10	\N	\N	\N	2026-01-04 10:11:24.014	2026-01-04 10:11:24.014	Restorative material	t
e4028a5d-17d1-4725-b7b6-c6002bba0f79	Dental Cement	\N	Ointment	N/A	OINTMENTS	5	100	10	\N	\N	\N	2026-01-04 10:11:24.016	2026-01-04 10:11:24.016	Luting cement	t
c9efc44c-59f9-4334-9ab4-7308d5623e13	Glass Ionomer Cement	\N	Ointment	N/A	OINTMENTS	8	100	10	\N	\N	\N	2026-01-04 10:11:24.019	2026-01-04 10:11:24.019	Restorative/luting material	t
b92a714a-c4d4-4364-bdab-671f642bfb0d	Resin Modified Glass Ionomer	\N	Ointment	N/A	OINTMENTS	10	100	10	\N	\N	\N	2026-01-04 10:11:24.021	2026-01-04 10:11:24.021	Advanced restorative material	t
f97cfcf9-fc27-4b94-858f-4ab22fd33cc9	Etching Gel	\N	Ointment	N/A	OINTMENTS	8	100	10	\N	\N	\N	2026-01-04 10:11:24.024	2026-01-04 10:11:24.024	Bonding agent	t
468f96dd-4e2a-4c00-9ecd-f56874fe50d3	Bonding Agent	\N	Ointment	N/A	OINTMENTS	12	100	10	\N	\N	\N	2026-01-04 10:11:24.027	2026-01-04 10:11:24.027	Adhesive for fillings	t
c825b969-9ff6-4818-94e9-dcfdd1cc6111	Crown & Bridge Material	\N	Ointment	N/A	OINTMENTS	20	100	10	\N	\N	\N	2026-01-04 10:11:24.029	2026-01-04 10:11:24.029	Prosthetic material	t
d782bafe-ddc8-44fd-bd35-d6c2d69875b4	Removable Partial Denture Material	\N	Ointment	N/A	OINTMENTS	25	100	10	\N	\N	\N	2026-01-04 10:11:24.032	2026-01-04 10:11:24.032	Denture base material	t
ee08900c-81be-494e-9091-4542db30c9bd	Complete Denture Material	\N	Ointment	N/A	OINTMENTS	30	100	10	\N	\N	\N	2026-01-04 10:11:24.034	2026-01-04 10:11:24.034	Full denture material	t
dd5d8e40-d767-450a-8acb-e12fa4d84607	Implant Abutment Material	\N	Ointment	N/A	OINTMENTS	50	100	10	\N	\N	\N	2026-01-04 10:11:24.037	2026-01-04 10:11:24.037	Implant component	t
a5b94f86-0831-4120-a22c-8b17eeb92be8	Porcelain Veneer Material	\N	Ointment	N/A	OINTMENTS	45	100	10	\N	\N	\N	2026-01-04 10:11:24.039	2026-01-04 10:11:24.039	Cosmetic veneer material	t
1c83e070-479f-4f9d-af7b-133ee88e13de	Temporary Crown Material	\N	Ointment	N/A	OINTMENTS	12	100	10	\N	\N	\N	2026-01-04 10:11:24.042	2026-01-04 10:11:24.042	Temporary crown	t
4e6eda7d-2944-42cb-bf71-22243d5bece0	Core Build-up Material	\N	Ointment	N/A	OINTMENTS	15	100	10	\N	\N	\N	2026-01-04 10:11:24.044	2026-01-04 10:11:24.044	Foundation for crowns	t
b904acd4-8777-4972-95b7-d9aba04aa7c1	Prosthodontic Acrylic Resin	\N	Ointment	N/A	OINTMENTS	18	100	10	\N	\N	\N	2026-01-04 10:11:24.047	2026-01-04 10:11:24.047	Denture resin	t
f83e439f-05ab-4fac-a2b7-dfb4dd816046	Scaling Paste	\N	Ointment	N/A	OINTMENTS	5	100	10	\N	\N	\N	2026-01-04 10:11:24.05	2026-01-04 10:11:24.05	Prophylaxis paste	t
05e27c1c-755f-4d92-9bb0-9fe8c38dd012	Periodontal Dressing	\N	Ointment	N/A	OINTMENTS	6.5	100	10	\N	\N	\N	2026-01-04 10:11:24.053	2026-01-04 10:11:24.053	Post-surgical dressing	t
702b7d8f-c79a-4098-afb7-0bb62cef7568	Chlorhexidine + Fluoride Paste	\N	Ointment	N/A	OINTMENTS	4	100	10	\N	\N	\N	2026-01-04 10:11:24.055	2026-01-04 10:11:24.055	Antibacterial paste	t
b5afa032-164f-427e-b2b8-a21191c1468f	Periodontal Gel with NSAID	\N	Ointment	N/A	OINTMENTS	7	100	10	\N	\N	\N	2026-01-04 10:11:24.058	2026-01-04 10:11:24.058	Anti-inflammatory gel	t
6ace6040-b0cf-40d5-9837-6814fd343bb1	Topical Antimicrobial Gel	\N	Ointment	N/A	OINTMENTS	6	100	10	\N	\N	\N	2026-01-04 10:11:24.06	2026-01-04 10:11:24.06	Antiseptic gel	t
c84d44d7-48fe-4ee1-83e5-82f1fdce3253	Hydrogen Peroxide 3%	\N	Syrup	3%	SYRUPS	2.5	100	10	\N	\N	\N	2026-01-04 10:11:24.063	2026-01-04 10:11:24.063	Antiseptic rinse	t
68750aa0-b402-4418-9d0e-d4eb8cf87963	Saline Rinse 0.9%	\N	Syrup	0.9%	SYRUPS	2	100	10	\N	\N	\N	2026-01-04 10:11:24.065	2026-01-04 10:11:24.065	Oral rinse	t
c8a9bffd-1972-434d-85cc-b42a1f06826c	Dental Alginate Impression Material	\N	Ointment	N/A	OINTMENTS	15	100	10	\N	\N	\N	2026-01-04 10:11:24.068	2026-01-04 10:11:24.068	Impression material	t
b0f4ad1f-5894-4bf8-a99c-2d646326735f	Dental Wax	\N	Ointment	N/A	OINTMENTS	10	100	10	\N	\N	\N	2026-01-04 10:11:24.07	2026-01-04 10:11:24.07	Impression/bite registration	t
6c0d3de2-3de9-4f3d-8682-72f54e6f70a4	Rubber Dam	\N	Ointment	N/A	OINTMENTS	12	100	10	\N	\N	\N	2026-01-04 10:11:24.073	2026-01-04 10:11:24.073	Isolation material	t
297c1aa0-95a5-43e7-b867-305fb9a8350b	Dental Impression Tray	\N	Ointment	N/A	OINTMENTS	8	100	10	\N	\N	\N	2026-01-04 10:11:24.076	2026-01-04 10:11:24.076	Impression tray	t
a9417e25-a11c-4ff4-b3d4-01f04d18204d	Temporary Crown Cement	\N	Ointment	N/A	OINTMENTS	6	100	10	\N	\N	\N	2026-01-04 10:11:24.078	2026-01-04 10:11:24.078	Temporary cement	t
1b9bcaf1-006b-4c9e-b9eb-3f39cbd806e5	Permanent Crown Cement	\N	Ointment	N/A	OINTMENTS	10	100	10	\N	\N	\N	2026-01-04 10:11:24.081	2026-01-04 10:11:24.081	Permanent cement	t
a741bfc7-c147-4c89-bf35-6ac96dc0ec9e	Dental Matrix Band	\N	Ointment	N/A	OINTMENTS	5	100	10	\N	\N	\N	2026-01-04 10:11:24.083	2026-01-04 10:11:24.083	Matrix for fillings	t
9ea93aff-806f-4f7f-8907-5490079a50e2	Dental Ligature Wire	\N	Ointment	N/A	OINTMENTS	4	100	10	\N	\N	\N	2026-01-04 10:11:24.085	2026-01-04 10:11:24.085	Ortho wire	t
70da4d2f-390d-461e-b807-a9155ca94b65	Mouth Guard Material	\N	Ointment	N/A	OINTMENTS	15	100	10	\N	\N	\N	2026-01-04 10:11:24.088	2026-01-04 10:11:24.088	Sports guard material	t
a551be68-59e4-4bf2-8f08-188754460c93	Oral Splint Material	\N	Ointment	N/A	OINTMENTS	12	100	10	\N	\N	\N	2026-01-04 10:11:24.09	2026-01-04 10:11:24.09	TMJ splint material	t
9cf2fad1-6d25-48a3-bcf9-6d1aec0b2806	Occlusal Bite Registration Material	\N	Ointment	N/A	OINTMENTS	8	100	10	\N	\N	\N	2026-01-04 10:11:24.093	2026-01-04 10:11:24.093	Bite registration	t
edec5aa6-710a-4e29-9a43-373da297072e	Rubber Polishing Cups	\N	Ointment	N/A	OINTMENTS	3	100	10	\N	\N	\N	2026-01-04 10:11:24.095	2026-01-04 10:11:24.095	Prophylaxis cup	t
281d5b2b-1b03-4371-92aa-2854254e5ae4	Diamond Burs	\N	Ointment	N/A	OINTMENTS	20	100	10	\N	\N	\N	2026-01-04 10:11:24.098	2026-01-04 10:11:24.098	Drill bit - diamond	t
f16068d8-3e81-4c49-b1d4-e74720e08fbf	Carbide Burs	\N	Ointment	N/A	OINTMENTS	18	100	10	\N	\N	\N	2026-01-04 10:11:24.101	2026-01-04 10:11:24.101	Drill bit - carbide	t
0b5af821-ecad-4061-9162-5bcdb87c56cd	Endodontic Files	\N	Ointment	N/A	OINTMENTS	25	100	10	\N	\N	\N	2026-01-04 10:11:24.104	2026-01-04 10:11:24.104	Root canal file	t
9b87d089-8d1d-4d5a-be79-8e383a7b3013	Syringes for Local Anesthesia	\N	Ointment	N/A	OINTMENTS	5	100	10	\N	\N	\N	2026-01-04 10:11:24.107	2026-01-04 10:11:24.107	Dental syringe	t
48cc5223-b980-4156-80c7-fe2ee6d5e8b4	Disposable Needles 27G	\N	Ointment	27G	OINTMENTS	3	100	10	\N	\N	\N	2026-01-04 10:11:24.109	2026-01-04 10:11:24.109	Anesthesia needle	t
38423772-584d-4163-89d6-f0da99f2e8a9	Cotton Rolls	\N	Ointment	N/A	OINTMENTS	1	100	10	\N	\N	\N	2026-01-04 10:11:24.112	2026-01-04 10:11:24.112	Absorbent cotton	t
0c0fe2d5-3e80-44a4-8a9f-376b8364638f	Gauze Pads	\N	Ointment	N/A	OINTMENTS	1.5	100	10	\N	\N	\N	2026-01-04 10:11:24.114	2026-01-04 10:11:24.114	Sterile gauze	t
eed7b868-00a8-4f05-b86a-f13b9c68a642	High Volume Suction Tips	\N	Ointment	N/A	OINTMENTS	4	100	10	\N	\N	\N	2026-01-04 10:11:24.119	2026-01-04 10:11:24.119	Suction tip	t
6335a4a6-3974-49e3-b709-cd6e0c6103db	Rubber Dam Punch	\N	Ointment	N/A	OINTMENTS	10	100	10	\N	\N	\N	2026-01-04 10:11:24.122	2026-01-04 10:11:24.122	Rubber dam tool	t
50c0c0be-e297-4090-b7ad-bab985d48bb0	Dental Explorer / Probe	\N	Ointment	N/A	OINTMENTS	12	100	10	\N	\N	\N	2026-01-04 10:11:24.125	2026-01-04 10:11:24.125	Diagnostic instrument	t
892eb645-1c83-4d7d-89ba-a08082128d94	Periodontal Probe	\N	Ointment	N/A	OINTMENTS	10	100	10	\N	\N	\N	2026-01-04 10:11:24.127	2026-01-04 10:11:24.127	Gum measurement	t
a0a50354-e327-4733-b9c8-fbb49bc59039	Mirror and Tweezers Set	\N	Ointment	N/A	OINTMENTS	8	100	10	\N	\N	\N	2026-01-04 10:11:24.13	2026-01-04 10:11:24.13	Examination set	t
2ac0ead5-b7ad-4f9c-a013-04760dfff41f	Acne Soap	\N	Ointment	N/A	OINTMENTS	100	100	10	\N	\N	\N	2026-01-04 10:11:24.132	2026-01-04 10:11:24.132	Medicated soap	t
abb4456f-75c5-4584-ad7d-189338a51778	Papaya Soap	\N	Ointment	N/A	OINTMENTS	120	100	10	\N	\N	\N	2026-01-04 10:11:24.135	2026-01-04 10:11:24.135	Exfoliating soap	t
5a708d66-49eb-4931-9cd2-7ee38539531c	Nisa Soap	\N	Ointment	N/A	OINTMENTS	110	100	10	\N	\N	\N	2026-01-04 10:11:24.138	2026-01-04 10:11:24.138	Antibacterial soap	t
dbc498d2-97e9-4156-b7bf-ef175dfbaca4	Dalan Soap	\N	Ointment	N/A	OINTMENTS	80	100	10	\N	\N	\N	2026-01-04 10:11:24.141	2026-01-04 10:11:24.141	Moisturizing soap	t
3f65a188-b39a-4e35-907f-d5658633c3d3	Rola Soap	\N	Ointment	N/A	OINTMENTS	70	100	10	\N	\N	\N	2026-01-04 10:11:24.143	2026-01-04 10:11:24.143	Beauty soap	t
3384a5b6-8107-41b4-8b6c-3881bd94e6cf	Lifeboy Soap	\N	Ointment	N/A	OINTMENTS	80	100	10	\N	\N	\N	2026-01-04 10:11:24.146	2026-01-04 10:11:24.146	Antiseptic soap	t
3e7e83ed-c55c-4046-840c-277b8ff19e4b	Lux Soap	\N	Ointment	N/A	OINTMENTS	100	100	10	\N	\N	\N	2026-01-04 10:11:24.149	2026-01-04 10:11:24.149	Beauty soap	t
4db7c5f1-89ad-401f-b1e2-60085ecb3f28	Kojic Lotion	\N	Ointment	N/A	OINTMENTS	340	100	10	\N	\N	\N	2026-01-04 10:11:24.154	2026-01-04 10:11:24.154	Skin lightening lotion	t
6279a033-2aa8-431a-87cd-e053d44e672a	Nivea Soft Cream	\N	Ointment	N/A	OINTMENTS	380	100	10	\N	\N	\N	2026-01-04 10:11:24.159	2026-01-04 10:11:24.159	Moisturizer	t
6c64471d-78ea-4fda-9df7-d3686245aebc	Baby Oil	\N	Ointment	N/A	OINTMENTS	150	100	10	\N	\N	\N	2026-01-04 10:11:24.161	2026-01-04 10:11:24.161	Mineral oil	t
f0a658c9-871d-4186-b510-943296549834	Vaseline	\N	Ointment	N/A	OINTMENTS	350	100	10	\N	\N	\N	2026-01-04 10:11:24.164	2026-01-04 10:11:24.164	Petroleum jelly	t
a7497f95-20db-44cf-9910-f17dbb419f57	Olive Oil	\N	Ointment	N/A	OINTMENTS	170	100	10	\N	\N	\N	2026-01-04 10:11:24.167	2026-01-04 10:11:24.167	Natural oil	t
c6b41fdd-133b-4378-bc42-c39c24100854	Vatika Oil	\N	Ointment	N/A	OINTMENTS	380	100	10	\N	\N	\N	2026-01-04 10:11:24.169	2026-01-04 10:11:24.169	Hair oil	t
062e3af0-9ba7-467d-ae0f-46f93b557771	Nivea Lotion	\N	Ointment	N/A	OINTMENTS	450	100	10	\N	\N	\N	2026-01-04 10:11:24.172	2026-01-04 10:11:24.172	Body lotion	t
475d12bb-344a-4d6a-b61b-29430a5581f6	FOGG Deodorant	\N	Ointment	N/A	OINTMENTS	450	100	10	\N	\N	\N	2026-01-04 10:11:24.174	2026-01-04 10:11:24.174	Deodorant spray	t
f5186056-3084-4756-8a8c-b22e4e3dbb83	Nivea Roll-on	\N	Ointment	N/A	OINTMENTS	350	100	10	\N	\N	\N	2026-01-04 10:11:24.177	2026-01-04 10:11:24.177	Deodorant roll-on	t
5630e83b-e8d5-471e-abb3-2b52a5dbaaf6	Head & Shoulders Shampoo	\N	Syrup	N/A	SYRUPS	320	100	10	\N	\N	\N	2026-01-04 10:11:24.179	2026-01-04 10:11:24.179	Anti-dandruff shampoo	t
a24c2b0e-417d-4469-ba74-b49e45242148	Sun Silk Shampoo	\N	Syrup	N/A	SYRUPS	170	100	10	\N	\N	\N	2026-01-04 10:11:24.182	2026-01-04 10:11:24.182	Beauty shampoo	t
791aa0fb-4589-43a6-906c-0931c4765614	Colgate Total 12	\N	Ointment	N/A	OINTMENTS	360	100	10	\N	\N	\N	2026-01-04 10:11:24.184	2026-01-04 10:11:24.184	Fluoride toothpaste	t
384a3872-5f78-48cc-b590-7971bbdf1c77	Closeup Toothpaste	\N	Ointment	N/A	OINTMENTS	250	100	10	\N	\N	\N	2026-01-04 10:11:24.186	2026-01-04 10:11:24.186	Mint toothpaste	t
5299fb86-2ee1-4987-8cc0-8eae9cd093cd	Surgical Gloves	\N	Ointment	N/A	OINTMENTS	40	100	10	\N	\N	\N	2026-01-04 10:11:24.189	2026-01-04 10:11:24.189	Latex gloves	t
dea24c61-fef0-4a0b-acb7-ddbb541d66bb	Gauze Swabs	\N	Ointment	N/A	OINTMENTS	80	100	10	\N	\N	\N	2026-01-04 10:11:24.191	2026-01-04 10:11:24.191	Sterile swabs	t
2184e3f0-c961-4828-8865-7add7306adaf	Syringe 10cc	\N	Ointment	N/A	OINTMENTS	15	100	10	\N	\N	\N	2026-01-04 10:11:24.194	2026-01-04 10:11:24.194	Disposable syringe	t
5e1ebd23-e707-4e35-8021-949d8e5e3500	Syringe 5cc	\N	Ointment	N/A	OINTMENTS	10	100	10	\N	\N	\N	2026-01-04 10:11:24.196	2026-01-04 10:11:24.196	Disposable syringe	t
3026ccd5-606e-49c0-9611-24bc0dc40c0a	Elastic Bandage 7.5cm	\N	Ointment	N/A	OINTMENTS	100	100	10	\N	\N	\N	2026-01-04 10:11:24.199	2026-01-04 10:11:24.199	Compression bandage	t
a6f45c1e-494e-4527-a33a-0f7b2fdec9de	Face Mask	\N	Ointment	N/A	OINTMENTS	10	100	10	\N	\N	\N	2026-01-04 10:11:24.201	2026-01-04 10:11:24.201	Disposable mask	t
\.


--
-- Data for Name: MedicationOrder; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public."MedicationOrder" (id, "visitId", "patientId", "doctorId", "medicationCatalogId", name, "genericName", "dosageForm", strength, quantity, "quantityNumeric", unit, duration, instructions, "additionalNotes", category, type, "unitPrice", status, "createdAt", "updatedAt", route, "isDeferred", "atcCode", "calculatedQuantity", "dosageFormCategory", "durationText", "durationUnit", "durationValue", "finalQuantity", "frequencyText", "frequencyType", "frequencyUnit", "frequencyValue", "normalizedName", "quantityOverridden", "routeCode", "rxnormCode", "snomedCode", "strengthText") FROM stdin;
1	1	PAT-2026-123	093cba71-ff80-4568-8969-f93c80ec0cf9	\N	Paractamol	Paractamol	Tablet	450 mg	2	2	unit	7 Days	\N	Custom medication - not in inventory	TABLETS	\N	\N	UNPAID	2026-02-26 14:45:21.592	2026-02-26 14:45:21.627	ORAL	f	\N	14	ORAL_SOLID	7 Days	DAYS	7	2	Twice Daily	TWICE_DAILY	times	\N	paractamol	t	ORAL	\N	\N	\N
2	1	PAT-2026-123	093cba71-ff80-4568-8969-f93c80ec0cf9	23769a46-0213-445e-90b6-b0debc3245a7	Paracetamol 500mg	\N	Tablet	500mg	2	2	unit	7	\N		TABLETS	\N	1.5	UNPAID	2026-02-26 15:10:39.145	2026-02-26 15:10:39.174	ORAL	f	\N	\N	\N	7	DAYS	\N	\N	\N	TWICE_DAILY	times	\N	paracetamol 500mg	f	ORAL	\N	\N	\N
3	1	PAT-2026-123	093cba71-ff80-4568-8969-f93c80ec0cf9	472e4f55-fc63-4294-b61c-6e4a4f0973cd	Amoxicillin + Clavulanic Acid 625mg	\N	Tablet	625mg	2	2	unit	7	\N		TABLETS	\N	7	UNPAID	2026-03-03 06:26:14.053	2026-03-03 06:26:14.072	ORAL	f	\N	\N	\N	7	DAYS	\N	\N	\N	TWICE_DAILY	times	\N	amoxicillin + clavulanic acid 625mg	f	ORAL	\N	\N	\N
4	2	PAT-2026-128	093cba71-ff80-4568-8969-f93c80ec0cf9	23769a46-0213-445e-90b6-b0debc3245a7	Paracetamol 500mg	\N	Tablet	500mg	\N	0	unit	\N	\N		TABLETS	\N	1.5	UNPAID	2026-03-05 12:11:59.135	2026-03-05 12:11:59.143	\N	f	\N	\N	\N	\N	DAYS	\N	\N	\N	\N	times	\N	paracetamol 500mg	f	\N	\N	\N	\N
\.


--
-- Data for Name: NurseAdministration; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public."NurseAdministration" (id, "continuousInfusionId", "administeredById", "administeredAt", "scheduledFor", notes, "createdAt", "updatedAt", completed) FROM stdin;
\.


--
-- Data for Name: NurseServiceAssignment; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public."NurseServiceAssignment" (id, "visitId", "serviceId", "assignedNurseId", "assignedById", status, notes, "orderType", "isWaived", "waivedBy", "waivedAt", "completedAt", "createdAt", "updatedAt", "customPrice") FROM stdin;
3	1	ab2b0bb4-d2da-4a95-859f-c1a0c9911b62	a4ab08f7-163b-4bd6-9f47-16c17e813d34	093cba71-ff80-4568-8969-f93c80ec0cf9	PENDING	Doctor ordered: dressing XXXL, Blood Pressure Check (Walk-in), Blood Pressure Measurement	DOCTOR_ORDERED	f	\N	\N	\N	2026-02-26 19:31:49.82	2026-02-26 19:31:49.82	\N
4	1	34e86984-f8e7-4e53-af10-063dd0b81be8	a4ab08f7-163b-4bd6-9f47-16c17e813d34	093cba71-ff80-4568-8969-f93c80ec0cf9	PENDING	Doctor ordered: Bandage/Dressing Change	DOCTOR_ORDERED	f	\N	\N	\N	2026-02-26 19:54:57.345	2026-02-26 19:54:57.345	\N
5	1	34e86984-f8e7-4e53-af10-063dd0b81be8	0dabda7a-9ece-4fc0-8352-cf6fab907af2	093cba71-ff80-4568-8969-f93c80ec0cf9	PENDING	Doctor ordered: Bandage/Dressing Change	DOCTOR_ORDERED	f	\N	\N	\N	2026-02-26 20:17:44.743	2026-02-26 20:17:44.743	\N
7	1	b79e70ef-806a-4f08-b395-0b0fa16dc853	a4ab08f7-163b-4bd6-9f47-16c17e813d34	093cba71-ff80-4568-8969-f93c80ec0cf9	PENDING	Doctor ordered: Injection Administration	DOCTOR_ORDERED	f	\N	\N	\N	2026-02-26 20:31:35.135	2026-02-26 20:31:35.135	\N
8	1	8f314fd1-be41-49b7-a5c3-1fd600988ee7	e626a9e0-559a-41ec-afbf-8d50f0aeea3f	093cba71-ff80-4568-8969-f93c80ec0cf9	PENDING	Doctor ordered: Abscess Drainage	PROCEDURE_ORDERED	f	\N	\N	\N	2026-03-03 06:24:08.417	2026-03-03 06:24:08.417	\N
9	1	0ab83526-9e53-4dab-9029-568c62959ceb	e626a9e0-559a-41ec-afbf-8d50f0aeea3f	093cba71-ff80-4568-8969-f93c80ec0cf9	PENDING	Doctor ordered: abscess drainage large	PROCEDURE_ORDERED	f	\N	\N	\N	2026-03-03 06:24:08.423	2026-03-03 06:24:08.423	\N
10	2	af26fc2a-3fe5-4085-a203-4f1ab0a10cfb	e626a9e0-559a-41ec-afbf-8d50f0aeea3f	093cba71-ff80-4568-8969-f93c80ec0cf9	PENDING	Doctor ordered: Temperature Check (Walk-in), Urinary Catheterization	DOCTOR_ORDERED	f	\N	\N	\N	2026-03-04 23:41:06.934	2026-03-04 23:41:06.934	\N
11	2	246000c3-27b3-41d6-9572-11e3808dbcc0	e626a9e0-559a-41ec-afbf-8d50f0aeea3f	093cba71-ff80-4568-8969-f93c80ec0cf9	PENDING	Doctor ordered: Temperature Check (Walk-in), Urinary Catheterization	DOCTOR_ORDERED	f	\N	\N	\N	2026-03-04 23:41:06.934	2026-03-04 23:41:06.934	\N
\.


--
-- Data for Name: NurseWalkInOrder; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public."NurseWalkInOrder" (id, "patientId", "serviceId", "nurseId", instructions, notes, status, "billingId", "completedAt", "createdAt", "updatedAt", "visitId") FROM stdin;
1	NURSE-20260307-001	314fd0ec-8a69-454c-9c6e-5c5f4b71126f	e626a9e0-559a-41ec-afbf-8d50f0aeea3f		\N	COMPLETED	f7db5075-e975-4f8c-b8ce-7f6514814291	2026-03-07 02:17:36.235	2026-03-07 02:17:07.856	2026-03-07 02:17:36.236	\N
2	NURSE-20260307-001	5160e0b7-0e04-4532-8823-4cdae4841417	e626a9e0-559a-41ec-afbf-8d50f0aeea3f		\N	COMPLETED	f7db5075-e975-4f8c-b8ce-7f6514814291	2026-03-07 02:17:41.048	2026-03-07 02:17:07.86	2026-03-07 02:17:41.05	\N
\.


--
-- Data for Name: PatientAccount; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public."PatientAccount" (id, "patientId", "accountType", status, balance, "totalDeposited", "totalUsed", "debtOwed", "totalDebtPaid", "verifiedById", "verifiedAt", "rejectionReason", "createdAt", "updatedAt", "creditLimit") FROM stdin;
cdf10248-847c-4301-b92e-7bf9a87c570b	PAT-2026-123	CREDIT	VERIFIED	0	0	0	580	1300	\N	\N	\N	2026-02-26 20:34:26.923	2026-02-26 21:33:44.356	0
\.


--
-- Data for Name: PatientAttachedImage; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public."PatientAttachedImage" (id, "visitId", "patientId", "doctorId", "fileName", "filePath", "fileSize", "mimeType", description, "uploadedAt", "uploadedBy") FROM stdin;
\.


--
-- Data for Name: PatientDiagnosis; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public."PatientDiagnosis" (id, "visitId", "patientId", "doctorId", "diseaseId", type, status, "isPrimary", notes, "createdAt", "updatedAt") FROM stdin;
e2b3ca11-312c-4491-9502-4749a4b80aef	2	PAT-2026-128	093cba71-ff80-4568-8969-f93c80ec0cf9	3e3a1c46-52ae-4fdf-91b0-4b3b0f20bfb9	CLINICAL	ACTIVE	t		2026-03-04 05:07:36.122	2026-03-04 05:07:36.122
3ce36701-9540-4f71-b209-4bf1207d251a	2	PAT-2026-128	093cba71-ff80-4568-8969-f93c80ec0cf9	74830a85-ea9c-40d1-94a8-23a3635c3f42	CLINICAL	ACTIVE	t		2026-03-04 19:20:48.541	2026-03-04 19:20:48.541
\.


--
-- Data for Name: PatientGallery; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public."PatientGallery" (id, "patientId", "visitId", "imageType", "filePath", description, "uploadedById", "createdAt") FROM stdin;
\.


--
-- Data for Name: PharmacyInvoice; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public."PharmacyInvoice" (id, "patientId", "visitId", "invoiceNumber", "totalAmount", status, type, "paymentMethod", "insuranceId", notes, "createdBy", "processedBy", "processedAt", "createdAt", "updatedAt") FROM stdin;
50ad973d-4263-43b5-876a-264f80ed6bfd	PAT-2026-123	1	\N	27	PENDING	DOCTOR_PRESCRIPTION	\N	\N	Medication order billing	\N	\N	\N	2026-02-26 14:45:21.642	2026-03-03 06:26:14.088
8368d93a-8303-465e-b5bf-8b778abce6e4	PAT-2026-128	2	\N	1.5	PENDING	DOCTOR_PRESCRIPTION	\N	\N	Medication order billing	\N	\N	\N	2026-03-05 12:11:59.152	2026-03-05 12:11:59.16
\.


--
-- Data for Name: PharmacyInvoiceItem; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public."PharmacyInvoiceItem" (id, "pharmacyInvoiceId", "medicationOrderId", "medicationCatalogId", name, "dosageForm", strength, quantity, "unitPrice", "totalPrice", notes, "createdAt", "updatedAt") FROM stdin;
d28228df-e376-469d-849b-143685ac2b89	50ad973d-4263-43b5-876a-264f80ed6bfd	1	\N	Paractamol	Tablet	450 mg	2	5	10	\N	2026-02-26 14:45:21.658	2026-02-26 14:45:21.658
2917ac11-57e9-4929-b57e-85e26078a459	50ad973d-4263-43b5-876a-264f80ed6bfd	2	23769a46-0213-445e-90b6-b0debc3245a7	Paracetamol 500mg	Tablet	500mg	2	1.5	3	\N	2026-02-26 15:10:39.196	2026-02-26 15:10:39.196
1a593d95-58f9-4631-930d-888184e98f2d	50ad973d-4263-43b5-876a-264f80ed6bfd	3	472e4f55-fc63-4294-b61c-6e4a4f0973cd	Amoxicillin + Clavulanic Acid 625mg	Tablet	625mg	2	7	14	\N	2026-03-03 06:26:14.084	2026-03-03 06:26:14.084
1b06c74e-9584-434b-baf8-b4f4d896dd90	8368d93a-8303-465e-b5bf-8b778abce6e4	4	23769a46-0213-445e-90b6-b0debc3245a7	Paracetamol 500mg	Tablet	500mg	1	1.5	1.5	\N	2026-03-05 12:11:59.156	2026-03-05 12:11:59.156
\.


--
-- Data for Name: RadiologyOrder; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public."RadiologyOrder" (id, "visitId", "patientId", "doctorId", "typeId", instructions, result, status, "isWalkIn", "billingId", "createdAt", "updatedAt") FROM stdin;
\.


--
-- Data for Name: RadiologyResult; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public."RadiologyResult" (id, "orderId", "batchOrderId", "testTypeId", "resultText", "additionalNotes", status, "createdAt", "updatedAt", findings, conclusion) FROM stdin;
\.


--
-- Data for Name: RadiologyResultFile; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public."RadiologyResultFile" (id, "resultId", "fileUrl", "fileName", "fileType", "uploadedAt", "uploadedBy") FROM stdin;
\.


--
-- Data for Name: RadiologyTemplate; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public."RadiologyTemplate" (id, "investigationTypeId", "findingsTemplate", "conclusionTemplate", "isActive", "createdAt", "updatedAt", "createdBy", "updatedBy") FROM stdin;
22af04cf-3966-451e-b52e-2e1678cea912	41	Liver normal. No focal lesion. Gallbladder normal. No gallstones. Kidneys normal.	Normal abdominal ultrasound study.	t	2026-03-04 17:49:08.786	2026-03-04 17:49:08.786	\N	\N
0b69d1cd-2f15-4bc6-926e-8382346550de	42	Bladder normal. Uterus normal. Adnexa unremarkable. No free fluid.	Unremarkable pelvic ultrasound study.	t	2026-03-04 17:49:08.79	2026-03-04 17:49:08.79	\N	\N
dbac2826-2c05-424d-8c22-13801f961372	43	Single live intrauterine pregnancy. Fetal heart activity present.	Viable intrauterine pregnancy.	t	2026-03-04 17:49:08.794	2026-03-04 17:49:08.794	\N	\N
6f5998f0-b218-4736-be28-bd413aa5f102	44	Thyroid normal in size. No nodule or cyst. No enlarged lymph nodes.	Normal thyroid ultrasound study.	t	2026-03-04 17:49:08.797	2026-03-04 17:49:08.797	\N	\N
9cdffe67-e8fa-4b30-8f30-b26d4f5d3116	45	Normal echotexture. No mass lesion. No enlarged nodes.	Normal breast ultrasound study.	t	2026-03-04 17:49:08.801	2026-03-04 17:49:08.801	\N	\N
6b703f10-6460-45b7-962f-433553bed2b4	46	Normal caliber. Normal color flow. No thrombus.	Normal Doppler ultrasound study.	t	2026-03-04 17:49:08.804	2026-03-04 17:49:08.804	\N	\N
\.


--
-- Data for Name: Referral; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public."Referral" (id, "patientId", "doctorId", "visitId", "referralReason", diagnosis, "facilityName", "doctorDetails", urgency, status, "clinicalHistory", "physicalExam", "labInvestigation", imaging, "treatmentGiven", region, zone, woreda, kebele, "createdAt", "updatedAt") FROM stdin;
010c9954-fc4b-4e45-ba85-812c0f244aed	PAT-2026-96	093cba71-ff80-4568-8969-f93c80ec0cf9	\N	shhs	hsh	opq		NORMAL	PENDING										2026-02-26 21:13:41.342	2026-02-26 21:13:41.342
\.


--
-- Data for Name: Service; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public."Service" (id, code, name, category, price, unit, description, "isActive", "createdAt", "updatedAt", "isVariablePrice", "maxPrice", "minPrice") FROM stdin;
811e0f9c-9811-4a02-bc57-3cf927b7f86d	CT001	CT Head without Contrast	RADIOLOGY	800	UNIT	CT scan of head without contrast	f	2026-01-04 10:08:16.319	2026-01-07 21:21:56.136	f	\N	\N
907e9fd6-af1d-477e-a8a3-2ebc17a45e53	US001	Abdominal Ultrasound	RADIOLOGY	400	UNIT	Abdominal ultrasound examination	t	2026-01-04 10:08:16.308	2026-01-04 10:11:23.355	f	\N	\N
5b08e652-9ad2-4fb4-bee9-be6cca21d6df	URINE001	Urinalysis	LAB	100	UNIT	Urinalysis test	t	2026-01-04 10:11:23.601	2026-01-04 10:11:23.601	f	\N	\N
f1d0308f-18ce-4422-b2e6-9d9c5789580c	VDRL001	VDRL	LAB	50	UNIT	VDRL test	t	2026-01-04 10:11:23.704	2026-01-04 10:11:23.704	f	\N	\N
d77c1cf8-5f79-43c4-8d9d-a4b156c1a9ab	XR004	X-Ray Abdomen	RADIOLOGY	160	UNIT	Abdominal X-ray	f	2026-01-04 10:08:16.304	2026-01-07 21:21:56.126	f	\N	\N
315e3397-2295-4f4a-ada9-0345ff64e196	BT001	Bleeding Time (BT)	LAB	300	UNIT	Bleeding Time (BT) test	f	2026-01-04 10:11:23.583	2026-01-07 21:41:54.073	f	\N	\N
7e1929db-ce87-4893-a5d7-7436921f7961	US002	Pelvic Ultrasound	RADIOLOGY	380	UNIT	Pelvic ultrasound examination	t	2026-01-04 10:08:16.309	2026-01-04 10:11:23.357	f	\N	\N
6fe4b74f-36ed-4f8f-b28c-9e045e07acda	US003	Obstetric Ultrasound	RADIOLOGY	420	UNIT	Obstetric ultrasound examination	t	2026-01-04 10:08:16.311	2026-01-04 10:11:23.359	f	\N	\N
3caa3c4b-3362-4a74-9312-42d0ef9998e0	US004	Thyroid Ultrasound	RADIOLOGY	350	UNIT	Thyroid ultrasound examination	t	2026-01-04 10:08:16.313	2026-01-04 10:11:23.361	f	\N	\N
36b747ef-6db2-4b5a-82fe-8a8ff20c427a	US005	Breast Ultrasound	RADIOLOGY	380	UNIT	Breast ultrasound examination	t	2026-01-04 10:08:16.315	2026-01-04 10:11:23.363	f	\N	\N
f67ac081-581d-4018-a4d4-e96efd7c5924	US006	Doppler Ultrasound	RADIOLOGY	450	UNIT	Doppler ultrasound examination	t	2026-01-04 10:08:16.317	2026-01-04 10:11:23.365	f	\N	\N
0e2e1a81-34aa-4286-9b60-be7b5e1893f0	CT003	CT Chest	RADIOLOGY	1200	UNIT	CT scan of chest	f	2026-01-04 10:08:16.322	2026-01-07 21:21:56.142	f	\N	\N
7e831762-a1c0-4871-8d73-7ad1035ac85f	RET001	Reticulocyte Count	LAB	200	UNIT	Reticulocyte Count test	f	2026-01-04 10:11:23.577	2026-01-07 21:41:54.079	f	\N	\N
1a6515c4-18bd-4c8b-9310-43c5624d088b	MRI001	MRI - Brain	RADIOLOGY	2000	UNIT	MRI scan of brain	f	2026-01-04 10:08:16.326	2026-01-07 21:21:56.156	f	\N	\N
40f19a7c-6e4d-46cd-9c8c-326b058a24f3	MAM001	Mammography	RADIOLOGY	500	UNIT	Mammography examination	f	2026-01-04 10:08:16.329	2026-01-07 21:21:56.17	f	\N	\N
53da0ecc-dd5c-4238-aa63-60524a4a0b71	RBC001	RBC Count	LAB	50	UNIT	RBC Count test	f	2026-01-04 10:11:23.529	2026-01-10 21:40:34.422	f	\N	\N
ee1a55f9-5798-4501-a96b-b68bfa6f5fba	WBC001	WBC Count	LAB	50	UNIT	WBC Count test	f	2026-01-04 10:11:23.534	2026-01-10 21:40:34.434	f	\N	\N
cc6d7bcf-b48c-4684-897a-eb79a75a7485	PBF001	Blood Film	LAB	150	UNIT	Peripheral Blood Film test	f	2026-01-04 10:11:23.592	2026-01-07 21:41:54.086	f	\N	\N
98367a2c-42e1-49d5-8a1d-5c5743d319f1	CONS001	General Doctor Consultation	CONSULTATION	200	UNIT	General doctor consultation fee	t	2026-01-04 10:08:16.331	2026-01-04 11:59:02.237	f	\N	\N
5a981cc6-dee9-4b85-b791-f0e3126d9ff8	CONS002	Specialist Consultation	CONSULTATION	200	UNIT	Specialist doctor consultation fee	t	2026-01-04 10:08:16.333	2026-01-04 11:58:46.576	f	\N	\N
22eedf04-fddd-4023-a109-114495c9e1e9	ESR001	ESR	LAB	125	UNIT	ESR test	t	2026-01-04 10:11:23.565	2026-01-10 13:08:18.386	f	\N	\N
73b76ddf-5006-43f3-b4ea-3b85b096a162	WBCD001	WBC Differential	LAB	50	UNIT	WBC Differential test	f	2026-01-04 10:11:23.554	2026-01-10 21:40:34.468	f	\N	\N
8674ef39-46e0-410d-8486-7faf18fc162a	ALT001	ALT	LAB	200	UNIT	ALT test	t	2026-01-04 10:11:23.724	2026-01-05 16:33:06.385	f	\N	\N
cd1a235d-b538-4975-abe2-db3f4fd4bc35	ASO001	ASO Titer	LAB	200	UNIT	ASO Titer test	t	2026-01-04 10:11:23.693	2026-01-05 16:33:27.642	f	\N	\N
717ff15c-c231-404c-81c9-d3986794bc0e	HCG001	HCG (Qualitative)	LAB	50	UNIT	HCG (Qualitative) test	t	2026-01-04 10:11:23.68	2026-01-05 16:36:07.117	f	\N	\N
b4b52af5-56f4-4a32-b399-00e291211995	HBSAG001	HBsAg	LAB	200	UNIT	HBsAg test	t	2026-01-04 10:11:23.667	2026-01-05 17:00:56.717	f	\N	\N
7c44bbba-11a1-4019-a32b-8d0631f979e2	ALP001	ALP	LAB	300	UNIT	ALP test	t	2026-01-04 10:11:23.734	2026-01-05 16:52:53.7	f	\N	\N
feb3c98e-405c-4ef8-9279-972c9bc23292	AST001	AST	LAB	200	UNIT	AST test	t	2026-01-04 10:11:23.729	2026-01-05 16:56:50.683	f	\N	\N
a96bbe21-f849-47cc-ba89-526c526c3c32	HIV001	HIV Test 	LAB	300	UNIT	HIV test	t	2026-01-04 10:11:23.673	2026-01-05 17:31:46.27	f	\N	\N
ceaabd0b-6175-4207-8539-95f79372bf04	DBIL001	Direct Bilirubin	LAB	200	UNIT	Direct Bilirubin test	t	2026-01-04 10:11:23.745	2026-01-05 16:58:57.058	f	\N	\N
a03e2576-be51-4916-9f8a-3869c12b1927	HCV001	HCV Antibody	LAB	150	UNIT	HCV Antibody test	t	2026-01-04 10:11:23.699	2026-01-05 17:02:06.406	f	\N	\N
2c2a8d83-6e64-44fd-a000-0629117811a3	HCT001	Hematocrit (HCT)	LAB	50	UNIT	Hematocrit (HCT) test	f	2026-01-04 10:11:23.523	2026-01-10 21:40:34.411	f	\N	\N
e22c7ff5-7dbe-48ce-85e8-c40072e75c82	RPR001	RPR	LAB	150	UNIT	RPR test	t	2026-01-04 10:11:23.66	2026-01-05 17:04:38.526	f	\N	\N
159ec24b-db04-42fe-b04f-82dcb0ddd4bb	RF001	Rheumatoid Factor (RF)	LAB	200	UNIT	Rheumatoid Factor (RF) test	t	2026-01-04 10:11:23.686	2026-01-05 17:06:17.638	f	\N	\N
95abafe1-60f8-47a0-8f8d-837c6a24158c	STOOL001	Stool Examination	LAB	100	UNIT	Stool Examination test	t	2026-01-04 10:11:23.631	2026-01-05 17:15:51.17	f	\N	\N
e39f3fa0-9183-4eca-822f-66e165b1727e	TBIL001	Total Bilirubin	LAB	200	UNIT	Total Bilirubin test	t	2026-01-04 10:11:23.739	2026-01-05 17:16:43.436	f	\N	\N
d8d13311-7d4c-4654-9dfe-be65c61f0d64	TP001	Total Protein	LAB	200	UNIT	Total Protein test	t	2026-01-04 10:11:23.75	2026-01-05 17:17:59.552	f	\N	\N
2c17dcec-b981-4bc5-b4eb-729d2944be89	WIDAL001	Widal Test	LAB	100	UNIT	Widal Test test	t	2026-01-04 10:11:23.649	2026-01-05 17:18:21.144	f	\N	\N
a51af10c-f0a1-4141-8dbc-bf5c61612368	WEIL001	Weil-Felix Test	LAB	100	UNIT	Weil-Felix Test test	t	2026-01-04 10:11:23.716	2026-01-05 17:18:34.53	f	\N	\N
d769d862-0483-4fa3-93a0-208d11e57838	PLT001	Platelet Count	LAB	50	UNIT	Platelet Count test	f	2026-01-04 10:11:23.54	2026-01-10 21:40:34.446	f	\N	\N
8cab7249-e261-4f00-bac4-cc651185cccb	HB001	Hemoglobin (Hb)	LAB	50	UNIT	Hemoglobin (Hb) test	f	2026-01-04 10:11:23.514	2026-01-10 21:40:34.477	f	\N	\N
66f5dc69-e9c2-4c46-9e20-ebeb319a629d	BGRH001	Blood Group & Rh	LAB	150	UNIT	Blood Group & Rh test	t	2026-01-04 10:11:23.569	2026-01-13 17:12:35.531	f	\N	\N
b6821231-c621-427e-94de-92e69d1f11bc	XR001	X-Ray Chest PA View	RADIOLOGY	150	UNIT	Chest X-ray PA view	f	2026-01-04 10:08:16.291	2026-01-07 21:21:56.114	f	\N	\N
ab2b0bb4-d2da-4a95-859f-c1a0c9911b62	NURSE001	Blood Pressure Measurement	NURSE	50	UNIT	Blood pressure measurement and monitoring	t	2026-01-04 10:11:24.293	2026-01-04 10:11:24.293	f	\N	\N
3af13084-ec86-4b5a-af72-855ea409fd8e	NURSE002	Temperature Measurement	NURSE	30	UNIT	Body temperature measurement	t	2026-01-04 10:11:24.297	2026-01-04 10:11:24.297	f	\N	\N
1cd435df-aa18-4a7f-ab95-42c580997a13	NURSE004	IV Cannulation	NURSE	150	UNIT	Intravenous cannula insertion	t	2026-01-04 10:11:24.301	2026-01-04 10:11:24.301	f	\N	\N
0a5a276d-e8a7-4ac1-a235-2b1b1192250f	CARD-REG	Patient Card Registration	CONSULTATION	100	UNIT	Initial patient card registration fee (first time only)	t	2026-01-04 10:08:16.335	2026-03-07 00:05:51.531	f	\N	\N
1c394523-3edb-48e7-a35c-17208624f4c6	NURSE006	Vital Signs Monitoring	NURSE	100	UNIT	Complete vital signs monitoring (BP, Temp, Pulse, Resp)	t	2026-01-04 10:11:24.304	2026-01-04 10:11:24.304	f	\N	\N
22698cf4-8afc-4299-b45b-95422695fd99	NURSE007	ECG Recording	NURSE	200	UNIT	Electrocardiogram recording	t	2026-01-04 10:11:24.305	2026-01-04 10:11:24.305	f	\N	\N
ac059478-bd8a-4684-9c82-7ddd7a943d78	DENT014	Gum Treatment	DENTAL	600	UNIT	Periodontal (gum) treatment	t	2026-01-04 10:11:24.539	2026-01-04 10:11:24.539	f	\N	\N
246000c3-27b3-41d6-9572-11e3808dbcc0	NURSE009	Urinary Catheterization	NURSE	250	UNIT	Urinary catheter insertion and care	t	2026-01-04 10:11:24.309	2026-01-04 10:11:24.309	f	\N	\N
139cae63-be79-4802-b323-bfdde2713fea	NURSE010	Nebulization	NURSE	120	UNIT	Nebulization therapy administration	t	2026-01-04 10:11:24.311	2026-01-04 10:11:24.311	f	\N	\N
0e93d0b9-4aa3-4f38-ae6c-94ad2d582a78	NWALK001	Blood Pressure Check (Walk-in)	NURSE_WALKIN	50	UNIT	Quick blood pressure check for walk-in patients	t	2026-01-04 10:11:24.351	2026-01-04 10:11:24.351	f	\N	\N
af26fc2a-3fe5-4085-a203-4f1ab0a10cfb	NWALK002	Temperature Check (Walk-in)	NURSE_WALKIN	30	UNIT	Quick temperature check for walk-in patients	t	2026-01-04 10:11:24.355	2026-01-04 10:11:24.355	f	\N	\N
314fd0ec-8a69-454c-9c6e-5c5f4b71126f	NWALK003	Bandage/Dressing (Walk-in)	NURSE_WALKIN	100	UNIT	Minor wound dressing or bandage change	t	2026-01-04 10:11:24.357	2026-01-04 10:11:24.357	f	\N	\N
64d65b0d-a755-4862-8674-0639ee1f2d7b	NWALK004	Injection Administration (Walk-in)	NURSE_WALKIN	80	UNIT	Administration of a prescribed injection	t	2026-01-04 10:11:24.358	2026-01-04 10:11:24.358	f	\N	\N
5160e0b7-0e04-4532-8823-4cdae4841417	NWALK005	Blood Glucose Test (Walk-in)	NURSE_WALKIN	60	UNIT	Quick blood glucose test for walk-in patients	t	2026-01-04 10:11:24.36	2026-01-04 10:11:24.36	f	\N	\N
dc0625ce-b1c4-4837-a0ce-2c161a970950	NWALK006	Vital Signs Check (Walk-in)	NURSE_WALKIN	100	UNIT	Complete vital signs check for walk-in patients	t	2026-01-04 10:11:24.362	2026-01-04 10:11:24.362	f	\N	\N
0be211d2-8d9b-45be-8411-71a276e3947c	EMDRUG001	Epinephrine (Adrenaline)	EMERGENCY_DRUG	500	UNIT	Emergency treatment for anaphylaxis, cardiac arrest	t	2026-01-04 10:11:24.401	2026-01-04 10:11:24.401	f	\N	\N
260aae3e-fc1a-4cf6-a9bf-d13323d90723	EMDRUG002	Atropine Injection	EMERGENCY_DRUG	300	UNIT	Used for bradycardia, organophosphate poisoning	t	2026-01-04 10:11:24.405	2026-01-04 10:11:24.405	f	\N	\N
f54ba2c9-fa7e-40a2-baa0-07f3b6fcd3f4	EMDRUG003	Morphine Injection	EMERGENCY_DRUG	400	UNIT	Strong pain relief for severe pain	t	2026-01-04 10:11:24.407	2026-01-04 10:11:24.407	f	\N	\N
5092b1b4-6b60-40f6-abe0-7ab29bd5c6a7	EMDRUG005	Salbutamol Nebulization	EMERGENCY_DRUG	250	UNIT	Bronchodilator for asthma attacks	t	2026-01-04 10:11:24.41	2026-01-04 10:11:24.41	f	\N	\N
065433da-ad43-4750-8554-97663754da1b	EMDRUG007	Naloxone Injection	EMERGENCY_DRUG	450	UNIT	Opioid overdose reversal	t	2026-01-04 10:11:24.413	2026-01-04 10:11:24.413	f	\N	\N
1c828929-59e2-460e-8b82-53a3d5e882d3	EMDRUG008	Hydrocortisone Injection	EMERGENCY_DRUG	350	UNIT	Emergency steroid for severe allergic reactions	t	2026-01-04 10:11:24.415	2026-01-04 10:11:24.415	f	\N	\N
df052414-0493-4ce6-9497-05c1a5bd0118	MAT001	Surgical Gloves (Box)	MATERIAL_NEEDS	150	box	Box of sterile surgical gloves	t	2026-01-04 10:11:24.455	2026-01-04 10:11:24.455	f	\N	\N
007a6ab9-18bc-4d78-9416-ab8daaccafde	MAT002	Syringe 5ml (Pack)	MATERIAL_NEEDS	80	pack	Pack of 10 5ml syringes	t	2026-01-04 10:11:24.46	2026-01-04 10:11:24.46	f	\N	\N
fa46d495-206e-4056-ab8f-38c37739bb4f	MAT003	Gauze Pads (Pack)	MATERIAL_NEEDS	120	pack	Pack of sterile gauze pads	t	2026-01-04 10:11:24.462	2026-01-04 10:11:24.462	f	\N	\N
31433f4a-73ff-481a-bfd3-2be865ed5284	MAT004	IV Cannula 18G	MATERIAL_NEEDS	200	piece	Intravenous cannula, 18 gauge	t	2026-01-04 10:11:24.464	2026-01-04 10:11:24.464	f	\N	\N
f6c5e8e9-20c7-47b5-baed-1a2b9ba92b6e	MAT005	Medical Tape	MATERIAL_NEEDS	60	roll	Roll of medical adhesive tape	t	2026-01-04 10:11:24.466	2026-01-04 10:11:24.466	f	\N	\N
ccf90c64-6da4-4829-9bc1-e23372a57935	MAT006	Antiseptic Solution	MATERIAL_NEEDS	180	bottle	Bottle of antiseptic solution (e.g., Povidone-iodine)	t	2026-01-04 10:11:24.467	2026-01-04 10:11:24.467	f	\N	\N
b85d20d6-c062-417c-afe6-84b6ff396f29	MAT007	Cotton Swabs (Box)	MATERIAL_NEEDS	70	box	Box of sterile cotton swabs	t	2026-01-04 10:11:24.469	2026-01-04 10:11:24.469	f	\N	\N
69a3246e-38ac-4ae7-b89b-1ecc24d1e92e	MAT008	Alcohol Wipes (Pack)	MATERIAL_NEEDS	50	pack	Pack of alcohol prep wipes	t	2026-01-04 10:11:24.47	2026-01-04 10:11:24.47	f	\N	\N
e768fbc5-6d21-42cf-a27e-bc5674b66d0d	MAT009	Bandage Roll	MATERIAL_NEEDS	90	roll	Roll of elastic bandage	t	2026-01-04 10:11:24.472	2026-01-04 10:11:24.472	f	\N	\N
9bc8e7a9-ac9c-477f-ba5f-5f9e0ce7f07e	MAT010	Surgical Mask (Box)	MATERIAL_NEEDS	100	box	Box of surgical masks	t	2026-01-04 10:11:24.473	2026-01-04 10:11:24.473	f	\N	\N
f3ffd452-8dc3-4ac7-96b5-2691c504db65	DENT001	Dental Consultation	DENTAL	200	UNIT	Initial dental consultation and examination	t	2026-01-04 10:11:24.513	2026-01-04 10:11:24.513	f	\N	\N
9f2b8113-651f-4fb4-9ce7-ecad4042c6ee	DENT002	Dental Cleaning	DENTAL	300	UNIT	Professional dental cleaning and scaling	t	2026-01-04 10:11:24.517	2026-01-04 10:11:24.517	f	\N	\N
f5d122c3-adf9-4397-9beb-d15aa7c3ff5a	DENT003	Tooth Extraction - Simple	DENTAL	400	UNIT	Simple tooth extraction	t	2026-01-04 10:11:24.519	2026-01-04 10:11:24.519	f	\N	\N
3968dbe4-c971-4c14-abf7-42642465a35d	EMDRUG006	Adrenaline Auto-injector	EMERGENCY_DRUG	800	UNIT	Pre-filled adrenaline auto-injector for anaphylaxis	f	2026-01-04 10:11:24.412	2026-01-04 15:00:04.824	f	\N	\N
9029c940-95cf-417a-845b-684aa0a1870e	ALB001	Albumin	LAB	200	UNIT	Albumin test	t	2026-01-04 10:11:23.755	2026-01-05 16:57:05.234	f	\N	\N
ff3c6949-2169-4f4b-843c-a35050ea3dfa	CREA001	Creatinine	LAB	200	UNIT	Creatinine test	t	2026-01-04 10:11:23.762	2026-01-05 16:58:28.324	f	\N	\N
b441fc6b-5d8b-4e68-b733-84fa97ad40e2	BUN001	BUN	LAB	200	UNIT	BUN test	t	2026-01-04 10:11:23.767	2026-01-05 16:57:17.739	f	\N	\N
080d52da-cc95-414c-a14c-008863579360	FBG001	Fasting Blood Glucose	LAB	50	UNIT	Fasting Blood Glucose test	t	2026-01-04 10:11:23.803	2026-01-05 16:59:31.15	f	\N	\N
8ef29156-931b-4860-8452-341896d14f66	HDL001	HDL Cholesterol	LAB	500	UNIT	HDL Cholesterol test	t	2026-01-04 10:11:23.785	2026-01-05 17:02:30.648	f	\N	\N
fc89be43-0f24-4580-87c8-f0c15fdce005	HBA1C001	HbA1c	LAB	1500	UNIT	HbA1c test	t	2026-01-04 10:11:23.815	2026-01-05 17:02:54.099	f	\N	\N
bbb8d749-dbbe-4ffc-a677-9432a6f9e47c	LDL001	LDL Cholesterol	LAB	500	UNIT	LDL Cholesterol test	t	2026-01-04 10:11:23.79	2026-01-05 17:03:26.426	f	\N	\N
43dd343b-914d-42ee-96dc-53dc07295796	RBG001	Random Blood Glucose	LAB	70	UNIT	Random Blood Glucose test	t	2026-01-04 10:11:23.809	2026-01-05 17:05:39.865	f	\N	\N
46e4a5f2-7577-4591-a808-04c222702954	CHOL001	Total Cholesterol	LAB	200	UNIT	Total Cholesterol test	t	2026-01-04 10:11:23.778	2026-01-05 17:17:06.692	f	\N	\N
477b0189-f851-4cb3-a9c9-a99b7d1b136b	UA001	Uric Acid	LAB	200	UNIT	Uric Acid test	t	2026-01-04 10:11:23.772	2026-01-05 17:19:20.225	f	\N	\N
6f3030f4-ab3b-43e6-b589-0317829c5d88	TG001	Triglycerides	LAB	200	UNIT	Triglycerides test	t	2026-01-04 10:11:23.797	2026-01-05 17:17:38.209	f	\N	\N
ce9d6a46-923b-4a23-9399-78763b1cea81	LAB005	VDRL	LAB	200	UNIT		t	2026-01-05 09:30:09.188	2026-01-05 09:30:09.188	f	\N	\N
07b63b51-674d-4540-87d8-73c16a9eb0d2	NURSE008	Blood Glucose Testing	NURSE	100	UNIT	Point-of-care blood glucose testing	t	2026-01-04 10:11:24.307	2026-02-26 19:41:10.107	t	550	100
7f44b454-3528-476a-add8-eab4f1e2cbf5	DENT004	Tooth Extraction - Surgical	DENTAL	800	UNIT	Surgical tooth extraction	t	2026-01-04 10:11:24.521	2026-01-04 10:11:24.521	f	\N	\N
798cde77-4417-47c7-9afe-19149f518534	DENT005	Filling - Amalgam	DENTAL	250	TOOTH	Amalgam filling (silver filling)	t	2026-01-04 10:11:24.523	2026-01-04 10:11:24.523	f	\N	\N
93681436-e587-4254-b400-214998d3a6b1	DENT006	Filling - Composite	DENTAL	350	TOOTH	Composite filling (white filling)	t	2026-01-04 10:11:24.525	2026-01-04 10:11:24.525	f	\N	\N
dc133f2e-10cd-472e-a693-23ff838aa0f5	DENT007	Root Canal Treatment	DENTAL	1500	TOOTH	Root canal treatment (endodontic therapy)	t	2026-01-04 10:11:24.527	2026-01-04 10:11:24.527	f	\N	\N
5ca93b2c-d213-49f9-a674-41652800bfa6	DENT009	Dental Bridge	DENTAL	5000	JAW	Dental bridge placement	t	2026-01-04 10:11:24.531	2026-01-04 10:11:24.531	f	\N	\N
c56c9dd4-82df-4c8c-a659-51ee8627ffa3	DENT010	Dental Implant	DENTAL	15000	TOOTH	Dental implant placement	t	2026-01-04 10:11:24.532	2026-01-04 10:11:24.532	f	\N	\N
259914d1-999e-440e-969c-2d16011d7fe7	DENT011	Denture - Full	DENTAL	8000	JAW	Full denture (upper or lower)	t	2026-01-04 10:11:24.534	2026-01-04 10:11:24.534	f	\N	\N
454f9337-a365-48af-931d-f10c4fd3b854	DENT012	Denture - Partial	DENTAL	4000	UNIT	Partial denture	t	2026-01-04 10:11:24.536	2026-01-04 10:11:24.536	f	\N	\N
826d8eaf-c646-48c7-b26f-5f5a7c3defb8	DENT013	Teeth Whitening	DENTAL	1200	UNIT	Professional teeth whitening treatment	t	2026-01-04 10:11:24.537	2026-01-04 10:11:24.537	f	\N	\N
5e06fae9-412b-43fc-bdc7-db9163b20b58	DENT015	Dental X-Ray - Periapical	DENTAL	150	TOOTH	Periapical X-ray (single tooth)	t	2026-01-04 10:11:24.541	2026-01-04 10:11:24.541	f	\N	\N
1fd5b0c5-ce79-47a7-b536-f152879fbfb8	DENT016	Dental X-Ray - Bitewing	DENTAL	200	UNIT	Bitewing X-ray (posterior teeth)	t	2026-01-04 10:11:24.542	2026-01-04 10:11:24.542	f	\N	\N
d6c68b7d-74a4-4e54-86c8-4b4da9c88eba	DENT017	Dental X-Ray - Panoramic	DENTAL	400	UNIT	Panoramic X-ray (full mouth)	t	2026-01-04 10:11:24.544	2026-01-04 10:11:24.544	f	\N	\N
dd991e73-fef1-41e4-84d1-424d4d07cbe2	PROC002	Suture Removal	PROCEDURE	150	UNIT	Surgical suture removal	t	2026-01-04 10:11:24.696	2026-01-04 10:11:24.696	f	\N	\N
ee1776d6-2c66-4ec0-98f2-498182089118	PROC003	Wound Debridement	PROCEDURE	800	UNIT	Wound cleaning and debridement	t	2026-01-04 10:11:24.698	2026-01-04 10:11:24.698	f	\N	\N
8f314fd1-be41-49b7-a5c3-1fd600988ee7	PROC004	Abscess Drainage	PROCEDURE	600	UNIT	Incision and drainage of abscess	t	2026-01-04 10:11:24.7	2026-01-04 10:11:24.7	f	\N	\N
9440874e-c28e-40ca-88d8-1b23e481507c	PROC005	Foreign Body Removal	PROCEDURE	400	UNIT	Removal of foreign body from wound	t	2026-01-04 10:11:24.702	2026-01-04 10:11:24.702	f	\N	\N
7f7bbccf-2ce7-4e19-9387-9888368dec69	INF001	Continuous IV Infusion Setup	CONTINUOUS_INFUSION	500	UNIT	Setup and initiation of continuous IV infusion	t	2026-01-04 10:11:24.704	2026-01-04 10:11:24.704	f	\N	\N
70e32309-b6b7-4e8a-b364-de525443c054	INF002	Subcutaneous Infusion Setup	CONTINUOUS_INFUSION	600	UNIT	Subcutaneous infusion pump setup	t	2026-01-04 10:11:24.706	2026-01-04 10:11:24.706	f	\N	\N
4de708e3-d5cf-4ea6-b9f4-24a0f4ce8091	INF003	Epidural Infusion Setup	CONTINUOUS_INFUSION	1000	UNIT	Epidural catheter and infusion setup	t	2026-01-04 10:11:24.707	2026-01-04 10:11:24.707	f	\N	\N
42781a63-e5a8-479f-8144-dd3d9fbe70c9	EMER001	Emergency Consultation	EMERGENCY	500	UNIT	Emergency department consultation fee	t	2026-01-04 10:11:24.709	2026-01-04 10:11:24.709	f	\N	\N
51dc35c2-2429-43c0-9752-815fae66b818	EMER002	Emergency Resuscitation	EMERGENCY	2000	UNIT	Emergency resuscitation and stabilization	t	2026-01-04 10:11:24.71	2026-01-04 10:11:24.71	f	\N	\N
f6976dfb-a41b-4657-93b5-1d740224e244	EMER003	Emergency Trauma Assessment	EMERGENCY	800	UNIT	Emergency trauma evaluation and assessment	t	2026-01-04 10:11:24.712	2026-01-04 10:11:24.712	f	\N	\N
4085132d-8c86-46bc-8734-40cc7664aac4	DIAG001	Diagnostic Consultation	DIAGNOSTIC	400	UNIT	Specialized diagnostic consultation	t	2026-01-04 10:11:24.714	2026-01-04 10:11:24.714	f	\N	\N
366840fe-a6c7-4783-b463-540cd17be114	DIAG002	Health Screening Package	DIAGNOSTIC	1500	UNIT	Comprehensive health screening package	t	2026-01-04 10:11:24.715	2026-01-04 10:11:24.715	f	\N	\N
d78d11c6-473f-4c4f-98e5-5ad92b2f06f3	TREAT001	Physiotherapy Session	TREATMENT	300	UNIT	Individual physiotherapy treatment session	t	2026-01-04 10:11:24.717	2026-01-04 10:11:24.717	f	\N	\N
4d15ce07-3816-497f-a43b-c934125e8550	TREAT002	Occupational Therapy	TREATMENT	350	UNIT	Occupational therapy session	t	2026-01-04 10:11:24.719	2026-01-04 10:11:24.719	f	\N	\N
6e53a73b-63d6-4ed0-8d18-9da0a223668e	TREAT003	Wound Care Treatment	TREATMENT	250	UNIT	Specialized wound care treatment	t	2026-01-04 10:11:24.72	2026-01-04 10:11:24.72	f	\N	\N
23dafd9b-76bd-416e-97b7-3ac371fd1027	OTHER001	Medical Certificate	OTHER	100	UNIT	Medical certificate issuance	t	2026-01-04 10:11:24.722	2026-01-04 10:11:24.722	f	\N	\N
baccca53-ab29-4f32-b349-c69412a09027	OTHER002	Health Report	OTHER	200	UNIT	Comprehensive health report preparation	t	2026-01-04 10:11:24.724	2026-01-04 10:11:24.724	f	\N	\N
5eb4a9a1-e365-4d7e-a985-5acfe093df37	OTHER003	Medical Documentation	OTHER	150	UNIT	Medical documentation and record services	t	2026-01-04 10:11:24.725	2026-01-04 10:11:24.725	f	\N	\N
5b8b1955-b161-4217-993b-c9b5cf4266db	CARD-ACT	Patient Card Activation	CONSULTATION	100	UNIT	Patient card activation/renewal fee (valid for 30 days)	t	2026-01-04 10:08:16.337	2026-01-04 11:58:22.533	f	\N	\N
4c37eaaf-7f3c-491d-85d5-f1f1071044d5	PROC006	implant insertion	PROCEDURE	750	UNIT		t	2026-01-04 14:53:00.051	2026-01-04 14:53:00.051	f	\N	\N
03b55355-5dfd-40c7-865a-040e683a2f63	PROC007	dipo provera	PROCEDURE	150	UNIT		t	2026-01-04 14:53:40.204	2026-01-04 14:53:40.204	f	\N	\N
65d021dd-afc0-41eb-b84c-55060b441e0b	PROC008	lucid	PROCEDURE	1500	UNIT		t	2026-01-04 14:54:09.68	2026-01-04 14:54:09.68	f	\N	\N
91345ec8-5b95-4d92-8082-d202a229dffc	PROC009	Implanole removal	PROCEDURE	500	UNIT		t	2026-01-04 14:55:11.532	2026-01-04 14:55:11.532	f	\N	\N
b3b97cd8-a96c-4f8f-afa9-93f7bd64388c	PROC011	dressing XXXL	NURSE	1000	UNIT		t	2026-01-04 14:56:26.519	2026-01-04 14:58:05.217	f	\N	\N
1df30684-2dfd-47ae-8992-98fe395c8927	EMDRUG004	Diazepam Injection	EMERGENCY_DRUG	350	UNIT	Used for seizures, severe anxiety, muscle spasms	t	2026-01-04 10:11:24.409	2026-01-04 14:59:38.534	f	\N	\N
ae6742ad-bbd5-4af5-b73e-c91852f476b7	LAB001	pict malaria	LAB	150	UNIT		t	2026-01-05 06:52:12.655	2026-01-05 06:52:12.655	f	\N	\N
c981eea3-c8fa-4c75-a7cc-5b55d468c0b0	LAB002	RDT	LAB	200	UNIT		t	2026-01-05 06:52:43.463	2026-01-05 06:52:43.463	f	\N	\N
3023b4bd-fa31-4c36-947a-868fb31ecfa1	LAB003	peripheral  blood film	LAB	150	UNIT		t	2026-01-05 06:53:39.092	2026-01-05 06:53:39.092	f	\N	\N
79fc6dd1-824d-4674-8756-0bade8e40c66	FT4001	Free T4 (Thyroxine)	LAB	1000	UNIT	Free T4 (Thyroxine) test	t	2026-01-04 17:31:13.761	2026-01-05 17:00:10.685	f	\N	\N
3e5a4280-4b80-4054-a478-5b90d296606c	HCG002	HCG (Quantitative)	LAB	70	UNIT	HCG (Quantitative) test	t	2026-01-04 17:31:13.635	2026-01-05 17:01:34.028	f	\N	\N
cfcbcca0-d8e2-4bb0-b9fc-bb36618cbe4a	RTD001	RTD (Rapid Test Device)	LAB	200	UNIT	RTD (Rapid Test Device) test	t	2026-01-04 17:31:13.644	2026-01-05 17:05:01.333	f	\N	\N
fb1ca7cb-c0c5-4e95-abd8-ec61a3e6cb71	TSH001	TSH (Thyroid Stimulating Hormone)	LAB	1000	UNIT	TSH (Thyroid Stimulating Hormone) test	t	2026-01-04 17:31:13.75	2026-01-05 17:16:23.135	f	\N	\N
e1e0e8fe-e030-49f5-b241-0171288dc272	PROC001	Minor Surgical Procedure	PROCEDURE	2500	UNIT	Minor surgical procedure	t	2026-01-04 10:11:24.691	2026-01-13 17:14:23.422	f	\N	\N
709ea608-8b82-4a48-8e18-faf83bcaf787	LAB006	U/A	LAB	100	UNIT		t	2026-01-05 09:30:28.863	2026-01-05 09:30:28.863	f	\N	\N
9aec1571-773d-428b-aebb-116761f41766	LAB007	CBC	LAB	400	UNIT		t	2026-01-05 09:30:47.455	2026-01-05 09:30:47.455	f	\N	\N
132257f3-e6da-4ca9-a0b4-ddbbfb0e39ef	LAB008	HBSAG	LAB	200	UNIT		t	2026-01-05 09:31:09.419	2026-01-05 09:31:09.419	f	\N	\N
b1c7e8e9-82c4-4bcb-aa93-ffb10be4fc97	LAB009	HCV	LAB	200	UNIT		t	2026-01-05 09:31:22.339	2026-01-05 09:31:22.339	f	\N	\N
b3c29400-cfc3-446a-a9bc-9930800dcca0	FT3001	Free T3 (Triiodothyronine)	LAB	1000	UNIT	Free T3 (Triiodothyronine) test	t	2026-01-04 17:31:13.756	2026-01-05 16:59:51.107	f	\N	\N
099d03e8-954f-44ed-a245-0a7f5554be91	MAT011	SURGICAL GLAVE	MATERIAL_NEEDS	50	UNIT		t	2026-01-15 17:43:35.106	2026-01-15 17:43:35.106	f	\N	\N
946f0324-6340-4589-93b0-b9e898ab6afc	MAT012	DISPOSABLE GLAVE PAIR	MATERIAL_NEEDS	50	UNIT		t	2026-01-15 17:44:12.117	2026-01-15 17:44:12.117	f	\N	\N
f0d1b8f6-c8a9-417a-bbb3-83cd4161dc10	LAB010	H/pylori anti body	LAB	250	UNIT		t	2026-01-06 12:05:58.258	2026-01-06 12:05:58.258	f	\N	\N
96a1022a-c059-4be3-aa56-15713428034a	LAB011	h/pylori anti gene	LAB	250	UNIT		t	2026-01-06 12:07:04.319	2026-01-06 12:07:04.319	f	\N	\N
82694648-8070-49b3-b233-d6b3ebfb1767	MAT013	IV CANULA INSERATION	MATERIAL_NEEDS	150	UNIT		t	2026-01-15 17:44:57.315	2026-01-15 17:44:57.315	f	\N	\N
3566536f-f272-4574-a8ab-513df7f9e597	CBC001	Complete Blood Count (CBC)	LAB	400	UNIT	Complete Blood Count (CBC) - Comprehensive hematology panel	t	2026-01-06 19:25:38.064	2026-01-06 19:25:38.064	f	\N	\N
0bb17b8b-e318-45da-9e68-d7c7cc32dcb3	US007	Abdomino-Pelvic Ultrasound (Female)	RADIOLOGY	1500	UNIT	Combined abdominal and pelvic ultrasound for female patients	t	2026-01-07 21:21:56.533	2026-01-07 21:21:56.533	f	\N	\N
7d7f7c84-ef52-456c-aae0-74932f998a33	US008	Abdomino-Pelvic Ultrasound (Male)	RADIOLOGY	1500	UNIT	Combined abdominal and pelvic ultrasound for male patients	t	2026-01-07 21:21:56.542	2026-01-07 21:21:56.542	f	\N	\N
c90bd9bb-d967-4e2b-9e87-37f66bebf635	US009	Transvaginal Ultrasound (TVS)	RADIOLOGY	1200	UNIT	Transvaginal ultrasound examination	t	2026-01-07 21:21:56.549	2026-01-07 21:21:56.549	f	\N	\N
4b826be6-1d43-4605-8a75-8f6b3c344aa9	CONS004	SURGICAL BLADE	MATERIAL_NEEDS	100	UNIT		t	2026-01-15 17:45:43.165	2026-01-15 17:45:43.165	f	\N	\N
0f4eeaba-9421-439a-ae57-4a1daa0caedc	HPYLORIAB001	H. pylori Antibody (Serology)	LAB	250	UNIT	H. pylori antibody serology test	t	2026-01-07 21:22:16.393	2026-01-10 13:06:03.79	f	\N	\N
d32b6a47-2e50-46bb-be57-cd3bb5c45dca	HPYLORIAG001	H. pylori Antigen (Stool Test)	LAB	250	UNIT	H. pylori Antigen detection in stool sample	t	2026-01-07 21:22:16.379	2026-01-10 13:06:37.291	f	\N	\N
06516f0d-b079-4c75-b285-4340cfdd218a	RCI001	Red Cell Indices (MCV, MCH, MCHC)	LAB	100	UNIT	Red Cell Indices (MCV, MCH, MCHC) test	f	2026-01-04 10:11:23.546	2026-01-10 21:40:34.456	f	\N	\N
44c274b4-e740-4c37-945f-0d33017020e1	ENTRY001	Entry Fee	OTHER	200	UNIT	Patient registration and entry fee	t	2026-01-11 12:36:32.86	2026-01-11 12:36:32.86	f	\N	\N
0ab83526-9e53-4dab-9029-568c62959ceb	PROC012	abscess drainage large	PROCEDURE	1500	UNIT		t	2026-01-13 17:15:52.457	2026-01-13 17:15:52.457	f	\N	\N
3e9e842d-bb68-41ac-9847-a636ad0478dc	AFB001	AFB Sputum (Spot–Morning–Spot)	LAB	300	UNIT	Acid-Fast Bacilli Sputum Examination - Three samples (Spot-Morning-Spot)	t	2026-01-15 14:02:23.281	2026-01-15 14:02:23.281	f	\N	\N
7999d55e-285c-493c-9367-ee25456a9ce2	EMDRUG009	ceftraxon 1gr	EMERGENCY_DRUG	200	UNIT		t	2026-01-15 17:05:12.078	2026-01-15 17:05:12.078	f	\N	\N
915e2355-98b9-45a9-959e-9fb359eafb44	EMDRUG010	diclofenac	EMERGENCY_DRUG	100	UNIT		t	2026-01-15 17:05:37.086	2026-01-15 17:05:37.086	f	\N	\N
237dac9f-318e-4766-8f2c-d7fd557b8c34	EMDRUG011	hydrocortison	EMERGENCY_DRUG	350	UNIT		t	2026-01-15 17:06:10.022	2026-01-15 17:06:10.022	f	\N	\N
565da222-f6a4-41e8-aa3c-2539f341e258	EMDRUG012	omperazole	EMERGENCY_DRUG	400	UNIT		t	2026-01-15 17:08:02.346	2026-01-15 17:08:02.346	f	\N	\N
abf3fc5d-d052-4c46-a421-1347cb995556	EMDRUG013	cimtidin 200mg	EMERGENCY_DRUG	250	UNIT		t	2026-01-15 17:08:34.33	2026-01-15 17:08:34.33	f	\N	\N
4596a8dc-cb6f-4111-acf7-2f97f2daa51a	EMDRUG014	adernalin 1ml	EMERGENCY_DRUG	300	UNIT		t	2026-01-15 17:09:10.181	2026-01-15 17:09:10.181	f	\N	\N
ae8dc499-7ccf-4600-b279-240877876c07	EMDRUG015	dexametason 8mg	EMERGENCY_DRUG	200	UNIT		t	2026-01-15 17:09:55.618	2026-01-15 17:09:55.618	f	\N	\N
5226b255-6590-43d6-91ed-0aebfe559202	EMDRUG016	plasil 10mg 	EMERGENCY_DRUG	150	UNIT		t	2026-01-15 17:10:50.92	2026-01-15 17:10:50.92	f	\N	\N
3f7aecf0-a78b-4cb5-8930-f8bd996fd774	EMDRUG017	gentamcyin 80mg	EMERGENCY_DRUG	120	UNIT		t	2026-01-15 17:11:56.962	2026-01-15 17:11:56.962	f	\N	\N
06242c7b-1c2f-4c7c-92e4-d09a327fbf7c	EMDRUG018	dipo provera	EMERGENCY_DRUG	150	UNIT		t	2026-01-15 17:14:42.014	2026-01-15 17:14:42.014	f	\N	\N
47a0f72f-c5c2-47f1-a2ae-e188dcc87abf	EMDRUG019	tramadole 100mg	EMERGENCY_DRUG	200	UNIT		t	2026-01-15 17:15:23.442	2026-01-15 17:15:23.442	f	\N	\N
0bb33b84-442d-44e5-ace6-9a697e4ec9d4	EMDRUG020	diazapham inj	EMERGENCY_DRUG	300	UNIT		t	2026-01-15 17:15:58.266	2026-01-15 17:15:58.266	f	\N	\N
ce4ca093-275b-438f-a99c-02cdbd2f32f4	EMDRUG021	DNS 1000ML	EMERGENCY_DRUG	500	UNIT		t	2026-01-15 17:33:38.936	2026-01-15 17:33:38.936	f	\N	\N
a4f9a64f-30f9-4666-a0b9-147fd004f2af	CONS003	NS	EMERGENCY_DRUG	500	UNIT		t	2026-01-15 17:34:08.215	2026-01-15 17:34:08.215	f	\N	\N
d87f643a-0efb-4b14-be92-dfbf4d1d12ec	EMDRUG022	RINGER LACTATE	EMERGENCY_DRUG	500	UNIT		t	2026-01-15 17:34:35.931	2026-01-15 17:34:35.931	f	\N	\N
ce0ac2cd-5b72-4df3-8c5a-40a0b3cd6f8a	EMDRUG023	40 % DEXTROS	EMERGENCY_DRUG	100	UNIT		t	2026-01-15 17:36:17.097	2026-01-15 17:36:17.097	f	\N	\N
66d8efe3-0231-46ce-be4e-da9c22e667d6	EMDRUG024	PROCAIN PENCILLIN/PPF 2.5ML	EMERGENCY_DRUG	150	UNIT		t	2026-01-15 17:38:26.563	2026-01-15 17:38:26.563	f	\N	\N
01c9a642-a14c-49af-9c69-ac123d069efa	EMDRUG025	VITAMIN B COMPLEX 	EMERGENCY_DRUG	200	UNIT		t	2026-01-15 17:39:08.642	2026-01-15 17:39:08.642	f	\N	\N
fdaeefb0-df8e-404e-8e12-a64169bd5354	EMDRUG026	HADRALYASIN INJ	EMERGENCY_DRUG	300	UNIT		t	2026-01-15 17:40:44.692	2026-01-15 17:40:44.692	f	\N	\N
344b1d81-dedf-49c8-83f8-6200cd1c4595	EMDRUG027	ARTEMETIR 80MG 	EMERGENCY_DRUG	150	UNIT		t	2026-01-15 17:41:45.823	2026-01-15 17:41:45.823	f	\N	\N
0fe08c72-72ef-447d-8879-07e29effa8d3	PICT001	Blood Film (BF)	LAB	150	UNIT	PICT – Malaria test	t	2026-01-04 10:11:23.711	2026-02-08 14:44:06.126	f	\N	\N
2173eed0-f1d8-4952-9a1c-cd0c4fb8f6ce	ACC-001	Wound Cleaning & Dressing	ACCOMMODATION	500	UNIT	\N	t	2026-02-08 20:09:03.46	2026-02-08 20:11:24.412	f	\N	\N
8a544c55-4df6-440b-9e77-5c037b17e3ef	ACC-002	IV Fluid Admin (Nursing Fee)	ACCOMMODATION	300	UNIT	\N	t	2026-02-08 20:09:03.463	2026-02-08 20:11:24.416	f	\N	\N
c0003e97-ea4b-491a-89fb-6f2a4c4470f2	ACC-003	Vital Signs Monitoring (Daily)	ACCOMMODATION	200	UNIT	\N	t	2026-02-08 20:09:03.465	2026-02-08 20:11:24.419	f	\N	\N
b85a1204-3416-4f1d-9432-0f8f19e3dc84	ACC-004	Physiotherapy Session	ACCOMMODATION	1500	UNIT	\N	t	2026-02-08 20:09:03.467	2026-02-08 20:11:24.421	f	\N	\N
1b1341b9-8175-408b-bdd6-858da972304c	ACC-005	General Nursing Care	ACCOMMODATION	400	UNIT	\N	t	2026-02-08 20:09:03.469	2026-02-08 20:11:24.425	f	\N	\N
bb91d034-4f71-413a-8a83-e2ff2677809b	BED-CHRG	Bed Occupancy Charge	ACCOMMODATION	0	UNIT	\N	t	2026-02-08 21:16:10.049	2026-02-08 21:16:10.049	f	\N	\N
21efba89-5343-4817-91f2-4694682cab12	BED001	Bed 1	ACCOMMODATION	150	UNIT		t	2026-02-08 20:58:00.914	2026-02-09 10:46:56.317	f	\N	\N
d9c83637-a7cf-4280-a45c-059d25780db5	DENT008	Crown Placement	DENTAL	2500	TOOTH	Dental crown placement	t	2026-01-04 10:11:24.529	2026-02-19 23:39:06.76	t	2500	1500
3f5da570-ee41-401b-90e7-f940af71652c	DENT018	CBCT Scan (Dental)	DENTAL	1000	UNIT	Cone Beam CT scan for dental imaging	t	2026-01-04 10:11:24.545	2026-02-26 19:20:35.043	t	2000	1000
34e86984-f8e7-4e53-af10-063dd0b81be8	NURSE003	Bandage/Dressing Change	NURSE	100	UNIT	Wound dressing and bandage application/change	t	2026-01-04 10:11:24.299	2026-02-26 19:21:04.783	t	1000	100
b79e70ef-806a-4f08-b395-0b0fa16dc853	NURSE005	Injection Administration	NURSE	80	UNIT	Intramuscular or subcutaneous injection	t	2026-01-04 10:11:24.302	2026-01-04 10:11:24.302	t	500	50
c526a802-11d4-441e-aa7e-867d20244d4f	MICRO001	Sample Examination	LAB	50	UNIT	\N	t	2026-03-04 15:34:47.033	2026-03-04 15:34:47.033	f	\N	\N
44cca180-f38a-42d4-b037-dc59cda1a186	MICRO002	KOH Preparation	LAB	80	UNIT	\N	t	2026-03-04 15:34:47.033	2026-03-04 15:34:47.033	f	\N	\N
910251a6-6950-4b53-b628-a1b291057ae3	MICRO003	Gram Stain	LAB	100	UNIT	\N	t	2026-03-04 15:34:47.033	2026-03-04 15:34:47.033	f	\N	\N
7556ef8a-9592-464c-ad23-0ed7b02a5acf	MICRO004	AFB (Ziehl-Neelsen) - 3 Day	LAB	150	UNIT	\N	t	2026-03-04 15:34:47.033	2026-03-04 15:34:47.033	f	\N	\N
1085e5c8-4d75-463e-a9aa-4df8143a769f	MICRO005	T. vaginalis Wet Mount	LAB	70	UNIT	\N	t	2026-03-04 15:34:47.033	2026-03-04 15:34:47.033	f	\N	\N
8d5f8d12-7f83-42db-9fe2-4027c8f7ce79	CARD-ACT-DERM	Dermatology Patient Card Activation	CONSULTATION	200	UNIT	Dermatology patient card activation/renewal fee (valid for 30 days)	t	2026-03-06 23:46:52.593	2026-03-06 23:46:52.593	f	\N	\N
d6b22240-5eb4-497f-82f8-7978c910d3c0	CARD-REG-DERM	Dermatology Patient Card Registration	CONSULTATION	200	UNIT	Initial dermatology patient card registration fee (first time only)	t	2026-03-06 23:46:52.578	2026-03-07 00:06:11.583	f	\N	\N
\.


--
-- Data for Name: SystemSettings; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public."SystemSettings" (id, key, value, description, "updatedById", "updatedAt", "createdAt") FROM stdin;
9a69ab7f-4201-4eb4-9f34-0a430b43431f	cardExpiryPeriodDays	30	Number of days before a card expires after activation	\N	2026-03-04 04:21:31.519	2026-03-04 04:21:31.519
\.


--
-- Data for Name: Tooth; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public."Tooth" (id, number, "eruptionStart", "eruptionEnd", "rootCompletion") FROM stdin;
1	11	7	8	10
2	12	8	9	11
3	13	11	12	13
4	14	10	11	12
5	15	10	12	12
6	16	6	7	9
7	17	12	13	14
8	18	17	21	18
9	21	7	8	10
10	22	8	9	11
11	23	11	12	13
12	24	10	11	12
13	25	10	12	12
14	26	6	7	9
15	27	12	13	14
16	28	17	21	18
17	31	6	7	9
18	32	7	8	10
19	33	9	10	12
20	34	10	12	12
21	35	11	12	13
22	36	6	7	9
23	37	11	13	14
24	38	17	21	18
25	41	6	7	9
26	42	7	8	10
27	43	9	10	12
28	44	10	12	12
29	45	11	12	13
30	46	6	7	9
31	47	11	13	14
32	48	17	21	18
\.


--
-- Data for Name: User; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public."User" (id, fullname, username, password, email, phone, role, "licenseNumber", availability, "isActive", "consultationFee", "waiveConsultationFee", "passwordChangedAt", "createdAt", "updatedAt", qualifications) FROM stdin;
a9e63cbf-3913-419b-8f4c-8e06fc10a306	System Administrator	admin	$2a$10$5zet0mvo/IZOJPXCEeuXUOd1pWfSrUT/AQV3zFICMCeEHG7XdFdrG	admin@medicalclinic.com	0000000000	ADMIN	\N	t	t	\N	f	\N	2026-01-04 10:30:18.744	2026-01-04 10:30:18.744	\N
192e9573-7cd6-4c43-992b-09ea2e3c3a3d	Birhane Abdela	Birhane	$2a$10$7k2PeGxOgB1j66tTE3bxyeb7cExem4PsIxS2tNqpuE2L9E4bHILja	birhane@gmail.com	\N	BILLING_OFFICER	\N	t	t	\N	f	\N	2026-01-04 12:01:13.651	2026-01-04 12:01:13.651	{}
d7f145ec-d9f5-461b-af89-67950add2640	Pharmacy Bill	Pharmacy Bill	$2a$10$POJY3AQ/kojKiMgHO2tZMOkKYMyrmaL5UyHW.XYVF0FwyZKWK9TB2	pharmacybill@gmail.com	\N	PHARMACY_BILLING_OFFICER	\N	t	t	\N	f	\N	2026-01-04 12:07:36.973	2026-01-04 12:07:36.973	{}
1f85b788-1c79-4c9f-b540-ad1bca75ff19	temesgen fikadu	temesgen	$2a$10$6oDCqP1pSAEiIBaLsbZYHeaAyb560Iqaq4Un9aseGYM8U7nTJV/QO	\N	\N	DOCTOR	\N	t	t	0	t	\N	2026-01-04 16:09:43.191	2026-01-04 16:09:43.191	{"General Doctor"}
5b65ac86-c4f7-4ed9-8684-42455269992b	Pharmacy	pharmacy	$2a$10$ORKbv8LBZ76l4FCqDXEXMOYZlMwVxUV4ghZCDjykvOXKHXSBgyXS6	\N	\N	PHARMACIST	\N	t	t	\N	f	\N	2026-01-04 12:06:57.389	2026-01-11 11:42:56.377	{}
b7f4ef29-cd57-430e-a656-dc234f526585	Teshale Kenbata	labratory 1	$2a$10$Mw348LPq2BgMOYCEFvZXzeRU13XEiMtZTzZJU5tWyKCGWXPGAsHW6	lab@gmail.com	\N	LAB_TECHNICIAN	\N	t	t	\N	f	\N	2026-01-04 12:05:34.407	2026-01-17 15:35:51.529	{}
45aa0bdd-f1a9-4fbe-8125-358e94cba160	Bereket Birhanu	Bereket_biller	$2a$10$X5Q1B8r50r9BJKRX9OnWAuA4hppNAiecYaTRsIqoAmymlYzqXM7ZK	bereket@gmail.com	\N	BILLING_OFFICER	\N	t	t	\N	f	\N	2026-01-04 13:04:57.641	2026-01-17 15:36:11.291	{}
a4ab08f7-163b-4bd6-9f47-16c17e813d34	Abera	Nurs Abera	$2a$10$9Ey4G92Mh1RZ34a56NpfU..nh1v2tQcNPgrcM4Y6qr0yjU3A25dtW	\N	\N	NURSE	\N	t	t	\N	f	\N	2026-01-17 15:38:40.87	2026-01-17 15:39:06.814	{}
0dabda7a-9ece-4fc0-8352-cf6fab907af2	Neway Nigussie	Nurs Neway	$2a$10$Zryv1xI9HdaB0R2MYoy/puntF6ZFdFj2y2e6984ufZeNUuePm703y	nurse@gmail.com	\N	NURSE	\N	t	t	\N	f	\N	2026-01-04 12:04:58.948	2026-01-17 15:39:32.735	{}
4a4b897a-2b02-4db8-8b86-4ba253c37181	Ginbaru	Labratory Ginbaru	$2a$10$bnaSq22.1yruuHNw9yG2L.nK18MD.YCCG9YBGJ/MNQ9l0mVnCTTHi	\N	\N	LAB_TECHNICIAN	\N	t	t	\N	f	\N	2026-01-17 15:40:46.641	2026-01-17 15:40:46.641	{}
b818dc1d-4c36-4815-85ae-f50ad493cfe3	Tesfaye Shelemo	Labratory Tesfaye	$2a$10$Lxhmdznt1tzzH1Gg3F.sh.LZEmLGgUaChP9Rl5rG6Tcw.jRvRiUxu	\N	\N	LAB_TECHNICIAN	\N	t	t	\N	f	\N	2026-01-17 15:41:22.431	2026-01-17 15:41:22.431	{}
ac094d45-2586-4b57-8297-415878397e61	Dr. Asfawu	Radiologist Asfawu	$2a$10$a0q4Jah6YVvyiC.RgsPf3.rrIrh/0FvjEcBq27t4SonQ1ZWSXU7Cu	\N	\N	RADIOLOGIST	\N	t	t	\N	f	\N	2026-01-17 15:42:35.526	2026-01-17 15:42:35.526	{}
7e46bc02-5737-42b0-ba76-5304b4d695b2	Radiology	Radiology	$2a$10$R0EtGzKk3OBTrVuo965UeuYzVaoaDIE8J1hwBme5VmFTAP.kIQD6C	radiology@gmail.com	\N	RADIOLOGIST	\N	t	t	\N	f	\N	2026-01-04 12:06:18.004	2026-01-19 14:01:02.233	{}
e626a9e0-559a-41ec-afbf-8d50f0aeea3f	Adane	HO	$2a$10$/Iofp0CISw8wXFqoydRvpeb8hlLIQCdrYM4EHxL9viLIXPudeChxy	\N	\N	NURSE	\N	t	t	\N	f	\N	2026-01-17 15:38:09.949	2026-02-07 14:16:12.605	{}
3f9a7b1c-8d2e-4f51-a3b0-c9d8e7f6a5b4	reception	reception	$2a$10$ORKbv8LBZ76l4FCqDXEXMOYZlMwVxUV4ghZCDjykvOXKHXSBgyXS6	\N	\N	RECEPTIONIST	\N	t	t	\N	f	\N	2026-02-22 20:38:24.109	2026-02-22 20:38:24.109	\N
093cba71-ff80-4568-8969-f93c80ec0cf9	Dr. Asrat Mojo	Dr.Asrat Mojo	$2a$10$.7E9Hnh.B1qvPWDnHm.A0uxnwBqDkVWkrniZ/whLFrzCTJC/kzTcO	asrat@gmail.com	\N	DOCTOR	\N	t	t	0	t	\N	2026-01-04 12:02:38.869	2026-03-04 04:26:29.329	{"General Doctor"}
\.


--
-- Data for Name: VirtualQueue; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public."VirtualQueue" (id, name, phone, "patientId", status, priority, notes, "createdAt", "updatedAt", "processedAt", "processedBy") FROM stdin;
\.


--
-- Data for Name: Visit; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public."Visit" (id, "visitUid", "patientId", "createdById", "suggestedDoctorId", date, status, "queueType", "isEmergency", notes, diagnosis, "diagnosisDetails", instructions, "assignmentId", "completedAt", "createdAt", "updatedAt", outcome) FROM stdin;
8	VISIT-260307-05	PAT-2026-133	192e9573-7cd6-4c43-992b-09ea2e3c3a3d	\N	2026-03-07 01:38:26.609	WAITING_FOR_TRIAGE	CONSULTATION	f	Automatic visit creation after card registration payment	\N	\N	\N	\N	\N	2026-03-07 01:38:26.609	2026-03-07 01:38:26.609	\N
4	VISIT-260307-01	PAT-2026-129	45aa0bdd-f1a9-4fbe-8125-358e94cba160	\N	2026-03-06 23:26:45.809	WAITING_FOR_TRIAGE	CONSULTATION	f	Automatic visit creation after card registration payment	\N	\N	\N	5	\N	2026-03-06 23:26:45.809	2026-03-07 03:35:34.563	\N
3	VISIT-260304-02	PAT-2026-127	45aa0bdd-f1a9-4fbe-8125-358e94cba160	\N	2026-03-04 12:18:18.872	WAITING_FOR_TRIAGE	CONSULTATION	f	Automatic visit creation after card registration payment	\N	\N	\N	3	\N	2026-03-04 12:18:18.872	2026-03-04 22:04:48.968	\N
1	VISIT-260226-01	PAT-2026-123	192e9573-7cd6-4c43-992b-09ea2e3c3a3d	\N	2026-02-26 13:59:26.255	SENT_TO_LAB	RESULTS_REVIEW	f	Returning patient visit	\N	\N	\N	1	\N	2026-02-26 13:59:26.255	2026-03-07 03:49:35.089	\N
5	VISIT-260307-02	PAT-2026-130	45aa0bdd-f1a9-4fbe-8125-358e94cba160	\N	2026-03-06 23:26:48.611	WAITING_FOR_TRIAGE	CONSULTATION	f	Automatic visit creation after card registration payment	\N	\N	\N	\N	\N	2026-03-06 23:26:48.611	2026-03-06 23:26:48.611	\N
6	VISIT-260307-03	PAT-2026-135	45aa0bdd-f1a9-4fbe-8125-358e94cba160	\N	2026-03-07 00:06:24.602	WAITING_FOR_TRIAGE	CONSULTATION	f	Automatic visit creation after card registration payment	\N	\N	\N	\N	\N	2026-03-07 00:06:24.602	2026-03-07 00:06:24.602	\N
7	VISIT-260307-04	PAT-2026-134	45aa0bdd-f1a9-4fbe-8125-358e94cba160	\N	2026-03-07 00:06:26.997	WAITING_FOR_TRIAGE	CONSULTATION	f	Automatic visit creation after card registration payment	\N	\N	\N	\N	\N	2026-03-07 00:06:26.997	2026-03-07 00:06:26.997	\N
2	VISIT-260304-01	PAT-2026-128	45aa0bdd-f1a9-4fbe-8125-358e94cba160	093cba71-ff80-4568-8969-f93c80ec0cf9	2026-03-04 04:21:31.533	SENT_TO_LAB	CONSULTATION	f	Automatic visit creation after card registration payment	hglo, Malaria (P. falciparum)	\N	\N	2	\N	2026-03-04 04:21:31.533	2026-03-07 00:30:32.542	\N
\.


--
-- Data for Name: VitalSign; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public."VitalSign" (id, "patientId", "visitId", "bloodPressure", temperature, "tempUnit", "heartRate", "respirationRate", height, weight, bmi, "oxygenSaturation", condition, notes, "painScoreRest", "painScoreMovement", "sedationScore", "gcsEyes", "gcsVerbal", "gcsMotor", "bloodPressureSystolic", "bloodPressureDiastolic", "chiefComplaint", "historyOfPresentIllness", "onsetOfSymptoms", "durationOfSymptoms", "severityOfSymptoms", "associatedSymptoms", "relievingFactors", "aggravatingFactors", "generalAppearance", "headAndNeck", "cardiovascularExam", "respiratoryExam", "abdominalExam", extremities, "neurologicalExam", "createdAt", "updatedAt", "recordedByRole") FROM stdin;
1	PAT-2026-123	1	210/80	80	C	75	\N	175	20	0.0006530612244897959	\N	critical 	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-01 01:49:50.809	2026-03-01 01:49:50.809	DOCTOR
2	PAT-2026-123	1	120	\N	C	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-04 04:19:24.352	2026-03-04 04:19:24.352	DOCTOR
3	PAT-2026-123	1	222222	\N	C	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-04 04:19:43.577	2026-03-04 04:19:43.577	DOCTOR
4	PAT-2026-128	2	120/80	50	C	80	\N	180	70	0.002160493827160494	\N	Good	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-04 04:24:38.24	2026-03-04 04:24:38.24	NURSE
5	PAT-2026-128	2	120/80	75	C	80	\N	180	90	0.002777777777777778	\N	Good	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	2026-03-04 04:57:28.488	2026-03-04 04:57:28.488	DOCTOR
\.


--
-- Data for Name: _prisma_migrations; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public._prisma_migrations (id, checksum, finished_at, migration_name, logs, rolled_back_at, started_at, applied_steps_count) FROM stdin;
24d81b46-6e83-4b11-ac6a-f42a6f8ac134	4f204064d8548b81cbac828e6d5e461ca626dffe0f9bb9ee126742fdb9c4a127	2026-02-26 16:46:27.395878+03	20251227122628_init	\N	\N	2026-02-26 16:46:25.676607+03	1
dc3d385c-5c5b-4954-9748-8bf73e4e0b13	02cec1788a27eedfbd700dd1a8dfb1be436c97faf19a744ce86db5db894f2380	2026-02-26 16:46:27.416428+03	20251227131537_add_is_retail_only_to_medication_catalog	\N	\N	2026-02-26 16:46:27.399003+03	1
f6afd4ed-418e-4f20-8ebb-1e918f6b74b9	9673d8a9f29a1f0efa24c7d2bcc0d71b38d7b201e08355df30bb3dfafb1b910c	2026-03-04 22:09:28.105646+03	20260108000000_add_age_to_patient	\N	\N	2026-03-04 22:09:28.083879+03	1
77bdae02-048d-4d8f-b0ab-cad6364d85cd	2697e26f05994270743f1edc96a9c4aa51ed644d627e2e7551bccfa0706e1377	2026-02-26 16:46:27.433997+03	20260103220700_add_new_service_categories	\N	\N	2026-02-26 16:46:27.419219+03	1
5515df71-b383-4833-9080-548f40d4bcbb	fd888f70632d6813db38d66c9ef98be58c896487541619548c7f95f384541f9f	2026-02-26 16:46:27.48285+03	20260107200000_add_radiology_templates	\N	\N	2026-02-26 16:46:27.436719+03	1
b93b97f4-5807-406f-8611-34046339bd30	b06deaa2a676145248eda2e58616f1991e2ac13541369ef60c4b01a0db26949f	2026-02-26 16:46:27.936337+03	20260208103223_init_and_changes	\N	\N	2026-02-26 16:46:27.487633+03	1
054debaa-b813-43df-bab8-7c3cff484c73	6dd1f62c6bf5d14719112482413b6c78ece9bfedcb1a8b70852c74701fffdb27	2026-02-26 16:46:28.142927+03	20260223070654_add_doctor_walkin_order	\N	\N	2026-02-26 16:46:27.940012+03	1
a4a8c422-6eb0-436d-b83f-44df8e72b388	d731daf32570e0aa398d620ca26c38e82ac1a0aaa1ba1df5e8a6334fe7356180	2026-02-26 16:46:28.167939+03	20260226122329_enhanced_prescription_fields	\N	\N	2026-02-26 16:46:28.145545+03	1
df4b6f83-f41d-4cd6-9c45-60a5325fb3e5	4f204064d8548b81cbac828e6d5e461ca626dffe0f9bb9ee126742fdb9c4a127	2026-02-08 13:32:18.069913+03	20251227122628_init	\N	\N	2026-02-08 13:32:16.412479+03	1
ea50d278-7ecc-42db-af4c-7c506aee03a9	02cec1788a27eedfbd700dd1a8dfb1be436c97faf19a744ce86db5db894f2380	2026-02-08 13:32:18.081902+03	20251227131537_add_is_retail_only_to_medication_catalog	\N	\N	2026-02-08 13:32:18.071274+03	1
bfe13453-2e1a-47b7-b645-23a28f0f3fe4	2697e26f05994270743f1edc96a9c4aa51ed644d627e2e7551bccfa0706e1377	2026-02-08 13:32:18.089189+03	20260103220700_add_new_service_categories	\N	\N	2026-02-08 13:32:18.083277+03	1
612a0060-991e-4c8d-be29-a0a524593c7b	fd888f70632d6813db38d66c9ef98be58c896487541619548c7f95f384541f9f	2026-02-08 13:32:18.118996+03	20260107200000_add_radiology_templates	\N	\N	2026-02-08 13:32:18.090586+03	1
cae9f454-e382-4e58-b144-609f3d43bb24	b06deaa2a676145248eda2e58616f1991e2ac13541369ef60c4b01a0db26949f	2026-02-08 13:32:23.716143+03	20260208103223_init_and_changes	\N	\N	2026-02-08 13:32:23.271168+03	1
a18f4b58-d057-4ee4-ba45-323a20d5ba05	4f204064d8548b81cbac828e6d5e461ca626dffe0f9bb9ee126742fdb9c4a127	2026-01-04 13:08:15.7665+03	20251227122628_init	\N	\N	2026-01-04 13:08:15.521566+03	1
8ca59e57-6220-4475-81cc-6322115c1d0b	02cec1788a27eedfbd700dd1a8dfb1be436c97faf19a744ce86db5db894f2380	2026-01-04 13:08:15.773623+03	20251227131537_add_is_retail_only_to_medication_catalog	\N	\N	2026-01-04 13:08:15.767411+03	1
2a043da5-5e70-43dd-bab8-d09947cf1f79	2697e26f05994270743f1edc96a9c4aa51ed644d627e2e7551bccfa0706e1377	2026-01-04 13:08:15.780704+03	20260103220700_add_new_service_categories	\N	\N	2026-01-04 13:08:15.77438+03	1
0de4325d-1177-4999-8257-a44f32b63467	fd888f70632d6813db38d66c9ef98be58c896487541619548c7f95f384541f9f	2026-01-08 00:21:32.773551+03	20260107231541_add_radiology_templates	\N	\N	2026-01-08 00:21:32.760622+03	1
94d1fe61-3cf2-46ce-8d79-a2fbcf5c4c1b	fd888f70632d6813db38d66c9ef98be58c896487541619548c7f95f384541f9f	\N	20260107200000_add_radiology_templates	A migration failed to apply. New migrations cannot be applied before the error is recovered from. Read more about how to resolve migration issues in a production database: https://pris.ly/d/migrate-resolve\n\nMigration name: 20260107200000_add_radiology_templates\n\nDatabase error code: 42P07\n\nDatabase error:\nERROR: relation "RadiologyTemplate" already exists\n\nDbError { severity: "ERROR", parsed_severity: Some(Error), code: SqlState(E42P07), message: "relation \\"RadiologyTemplate\\" already exists", detail: None, hint: None, position: None, where_: None, schema: None, table: None, column: None, datatype: None, constraint: None, file: Some("heap.c"), line: Some(1160), routine: Some("heap_create_with_catalog") }\n\n   0: sql_schema_connector::apply_migration::apply_script\n           with migration_name="20260107200000_add_radiology_templates"\n             at schema-engine/connectors/sql-schema-connector/src/apply_migration.rs:106\n   1: schema_core::commands::apply_migrations::Applying migration\n           with migration_name="20260107200000_add_radiology_templates"\n             at schema-engine/core/src/commands/apply_migrations.rs:91\n   2: schema_core::state::ApplyMigrations\n             at schema-engine/core/src/state.rs:226	2026-01-12 17:12:10.99597+03	2026-01-12 17:11:35.186696+03	0
6ec75846-bea3-40d1-b27e-80abdaec6d79	fd888f70632d6813db38d66c9ef98be58c896487541619548c7f95f384541f9f	2026-01-12 17:12:10.998167+03	20260107200000_add_radiology_templates		\N	2026-01-12 17:12:10.998167+03	0
\.


--
-- Name: Appointment_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public."Appointment_id_seq"', 1, false);


--
-- Name: Assignment_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public."Assignment_id_seq"', 6, true);


--
-- Name: AuditLog_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public."AuditLog_id_seq"', 7933, true);


--
-- Name: BatchOrderService_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public."BatchOrderService_id_seq"', 12, true);


--
-- Name: BatchOrder_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public."BatchOrder_id_seq"', 14, true);


--
-- Name: CardActivation_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public."CardActivation_id_seq"', 7, true);


--
-- Name: CompoundIngredient_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public."CompoundIngredient_id_seq"', 7, true);


--
-- Name: CompoundPrescription_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public."CompoundPrescription_id_seq"', 4, true);


--
-- Name: ContinuousInfusion_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public."ContinuousInfusion_id_seq"', 1, false);


--
-- Name: DentalProcedureCompletion_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public."DentalProcedureCompletion_id_seq"', 1, false);


--
-- Name: DentalRecord_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public."DentalRecord_id_seq"', 1, false);


--
-- Name: Department_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public."Department_id_seq"', 1, false);


--
-- Name: DispenseLog_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public."DispenseLog_id_seq"', 1, false);


--
-- Name: DispensedMedicine_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public."DispensedMedicine_id_seq"', 1, false);


--
-- Name: DoctorWalkInOrder_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public."DoctorWalkInOrder_id_seq"', 1, false);


--
-- Name: EmergencyDrugOrder_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public."EmergencyDrugOrder_id_seq"', 3, true);


--
-- Name: File_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public."File_id_seq"', 1, false);


--
-- Name: Inventory_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public."Inventory_id_seq"', 1, false);


--
-- Name: InvestigationType_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public."InvestigationType_id_seq"', 46, true);


--
-- Name: LabOrder_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public."LabOrder_id_seq"', 1, false);


--
-- Name: MaterialNeedsOrder_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public."MaterialNeedsOrder_id_seq"', 1, true);


--
-- Name: MedicalHistory_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public."MedicalHistory_id_seq"', 1, false);


--
-- Name: MedicationOrder_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public."MedicationOrder_id_seq"', 4, true);


--
-- Name: NurseAdministration_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public."NurseAdministration_id_seq"', 1, false);


--
-- Name: NurseServiceAssignment_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public."NurseServiceAssignment_id_seq"', 11, true);


--
-- Name: NurseWalkInOrder_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public."NurseWalkInOrder_id_seq"', 2, true);


--
-- Name: RadiologyOrder_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public."RadiologyOrder_id_seq"', 1, false);


--
-- Name: Tooth_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public."Tooth_id_seq"', 33, false);


--
-- Name: Visit_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public."Visit_id_seq"', 8, true);


--
-- Name: VitalSign_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public."VitalSign_id_seq"', 5, true);


--
-- Name: AccountDeposit AccountDeposit_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."AccountDeposit"
    ADD CONSTRAINT "AccountDeposit_pkey" PRIMARY KEY (id);


--
-- Name: AccountRequest AccountRequest_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."AccountRequest"
    ADD CONSTRAINT "AccountRequest_pkey" PRIMARY KEY (id);


--
-- Name: AccountTransaction AccountTransaction_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."AccountTransaction"
    ADD CONSTRAINT "AccountTransaction_pkey" PRIMARY KEY (id);


--
-- Name: AdmissionService AdmissionService_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."AdmissionService"
    ADD CONSTRAINT "AdmissionService_pkey" PRIMARY KEY (id);


--
-- Name: Admission Admission_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."Admission"
    ADD CONSTRAINT "Admission_pkey" PRIMARY KEY (id);


--
-- Name: Appointment Appointment_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."Appointment"
    ADD CONSTRAINT "Appointment_pkey" PRIMARY KEY (id);


--
-- Name: Assignment Assignment_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."Assignment"
    ADD CONSTRAINT "Assignment_pkey" PRIMARY KEY (id);


--
-- Name: AuditLog AuditLog_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."AuditLog"
    ADD CONSTRAINT "AuditLog_pkey" PRIMARY KEY (id);


--
-- Name: BankDeposit BankDeposit_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."BankDeposit"
    ADD CONSTRAINT "BankDeposit_pkey" PRIMARY KEY (id);


--
-- Name: BatchOrderService BatchOrderService_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."BatchOrderService"
    ADD CONSTRAINT "BatchOrderService_pkey" PRIMARY KEY (id);


--
-- Name: BatchOrder BatchOrder_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."BatchOrder"
    ADD CONSTRAINT "BatchOrder_pkey" PRIMARY KEY (id);


--
-- Name: Bed Bed_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."Bed"
    ADD CONSTRAINT "Bed_pkey" PRIMARY KEY (id);


--
-- Name: BillPayment BillPayment_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."BillPayment"
    ADD CONSTRAINT "BillPayment_pkey" PRIMARY KEY (id);


--
-- Name: BillingService BillingService_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."BillingService"
    ADD CONSTRAINT "BillingService_pkey" PRIMARY KEY (id);


--
-- Name: Billing Billing_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."Billing"
    ADD CONSTRAINT "Billing_pkey" PRIMARY KEY (id);


--
-- Name: CardActivation CardActivation_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."CardActivation"
    ADD CONSTRAINT "CardActivation_pkey" PRIMARY KEY (id);


--
-- Name: CashExpense CashExpense_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."CashExpense"
    ADD CONSTRAINT "CashExpense_pkey" PRIMARY KEY (id);


--
-- Name: CashTransaction CashTransaction_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."CashTransaction"
    ADD CONSTRAINT "CashTransaction_pkey" PRIMARY KEY (id);


--
-- Name: CompoundIngredient CompoundIngredient_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."CompoundIngredient"
    ADD CONSTRAINT "CompoundIngredient_pkey" PRIMARY KEY (id);


--
-- Name: CompoundPrescription CompoundPrescription_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."CompoundPrescription"
    ADD CONSTRAINT "CompoundPrescription_pkey" PRIMARY KEY (id);


--
-- Name: ContinuousInfusion ContinuousInfusion_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."ContinuousInfusion"
    ADD CONSTRAINT "ContinuousInfusion_pkey" PRIMARY KEY (id);


--
-- Name: CustomMedication CustomMedication_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."CustomMedication"
    ADD CONSTRAINT "CustomMedication_pkey" PRIMARY KEY (id);


--
-- Name: DailyCashSession DailyCashSession_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."DailyCashSession"
    ADD CONSTRAINT "DailyCashSession_pkey" PRIMARY KEY (id);


--
-- Name: DentalPhoto DentalPhoto_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."DentalPhoto"
    ADD CONSTRAINT "DentalPhoto_pkey" PRIMARY KEY (id);


--
-- Name: DentalProcedureCompletion DentalProcedureCompletion_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."DentalProcedureCompletion"
    ADD CONSTRAINT "DentalProcedureCompletion_pkey" PRIMARY KEY (id);


--
-- Name: DentalRecord DentalRecord_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."DentalRecord"
    ADD CONSTRAINT "DentalRecord_pkey" PRIMARY KEY (id);


--
-- Name: Department Department_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."Department"
    ADD CONSTRAINT "Department_pkey" PRIMARY KEY (id);


--
-- Name: DetailedLabResult DetailedLabResult_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."DetailedLabResult"
    ADD CONSTRAINT "DetailedLabResult_pkey" PRIMARY KEY (id);


--
-- Name: DiagnosisNotes DiagnosisNotes_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."DiagnosisNotes"
    ADD CONSTRAINT "DiagnosisNotes_pkey" PRIMARY KEY (id);


--
-- Name: Disease Disease_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."Disease"
    ADD CONSTRAINT "Disease_pkey" PRIMARY KEY (id);


--
-- Name: DispenseLog DispenseLog_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."DispenseLog"
    ADD CONSTRAINT "DispenseLog_pkey" PRIMARY KEY (id);


--
-- Name: DispensedMedicine DispensedMedicine_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."DispensedMedicine"
    ADD CONSTRAINT "DispensedMedicine_pkey" PRIMARY KEY (id);


--
-- Name: DoctorWalkInOrder DoctorWalkInOrder_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."DoctorWalkInOrder"
    ADD CONSTRAINT "DoctorWalkInOrder_pkey" PRIMARY KEY (id);


--
-- Name: EmergencyDrugOrder EmergencyDrugOrder_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."EmergencyDrugOrder"
    ADD CONSTRAINT "EmergencyDrugOrder_pkey" PRIMARY KEY (id);


--
-- Name: File File_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."File"
    ADD CONSTRAINT "File_pkey" PRIMARY KEY (id);


--
-- Name: InsuranceTransaction InsuranceTransaction_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."InsuranceTransaction"
    ADD CONSTRAINT "InsuranceTransaction_pkey" PRIMARY KEY (id);


--
-- Name: Insurance Insurance_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."Insurance"
    ADD CONSTRAINT "Insurance_pkey" PRIMARY KEY (id);


--
-- Name: InternationalMedicalCertificate InternationalMedicalCertificate_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."InternationalMedicalCertificate"
    ADD CONSTRAINT "InternationalMedicalCertificate_pkey" PRIMARY KEY (id);


--
-- Name: Inventory Inventory_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."Inventory"
    ADD CONSTRAINT "Inventory_pkey" PRIMARY KEY (id);


--
-- Name: InvestigationType InvestigationType_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."InvestigationType"
    ADD CONSTRAINT "InvestigationType_pkey" PRIMARY KEY (id);


--
-- Name: LabOrder LabOrder_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."LabOrder"
    ADD CONSTRAINT "LabOrder_pkey" PRIMARY KEY (id);


--
-- Name: LabResultFile LabResultFile_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."LabResultFile"
    ADD CONSTRAINT "LabResultFile_pkey" PRIMARY KEY (id);


--
-- Name: LabResult LabResult_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."LabResult"
    ADD CONSTRAINT "LabResult_pkey" PRIMARY KEY (id);


--
-- Name: LabTestGroup LabTestGroup_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."LabTestGroup"
    ADD CONSTRAINT "LabTestGroup_pkey" PRIMARY KEY (id);


--
-- Name: LabTestOrder LabTestOrder_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."LabTestOrder"
    ADD CONSTRAINT "LabTestOrder_pkey" PRIMARY KEY (id);


--
-- Name: LabTestResultField LabTestResultField_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."LabTestResultField"
    ADD CONSTRAINT "LabTestResultField_pkey" PRIMARY KEY (id);


--
-- Name: LabTestResultFile LabTestResultFile_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."LabTestResultFile"
    ADD CONSTRAINT "LabTestResultFile_pkey" PRIMARY KEY (id);


--
-- Name: LabTestResult LabTestResult_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."LabTestResult"
    ADD CONSTRAINT "LabTestResult_pkey" PRIMARY KEY (id);


--
-- Name: LabTestTemplate LabTestTemplate_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."LabTestTemplate"
    ADD CONSTRAINT "LabTestTemplate_pkey" PRIMARY KEY (id);


--
-- Name: LabTest LabTest_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."LabTest"
    ADD CONSTRAINT "LabTest_pkey" PRIMARY KEY (id);


--
-- Name: Loan Loan_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."Loan"
    ADD CONSTRAINT "Loan_pkey" PRIMARY KEY (id);


--
-- Name: MaterialNeedsOrder MaterialNeedsOrder_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."MaterialNeedsOrder"
    ADD CONSTRAINT "MaterialNeedsOrder_pkey" PRIMARY KEY (id);


--
-- Name: MedicalCertificate MedicalCertificate_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."MedicalCertificate"
    ADD CONSTRAINT "MedicalCertificate_pkey" PRIMARY KEY (id);


--
-- Name: MedicalHistory MedicalHistory_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."MedicalHistory"
    ADD CONSTRAINT "MedicalHistory_pkey" PRIMARY KEY (id);


--
-- Name: MedicationCatalog MedicationCatalog_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."MedicationCatalog"
    ADD CONSTRAINT "MedicationCatalog_pkey" PRIMARY KEY (id);


--
-- Name: MedicationOrder MedicationOrder_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."MedicationOrder"
    ADD CONSTRAINT "MedicationOrder_pkey" PRIMARY KEY (id);


--
-- Name: NurseAdministration NurseAdministration_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."NurseAdministration"
    ADD CONSTRAINT "NurseAdministration_pkey" PRIMARY KEY (id);


--
-- Name: NurseServiceAssignment NurseServiceAssignment_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."NurseServiceAssignment"
    ADD CONSTRAINT "NurseServiceAssignment_pkey" PRIMARY KEY (id);


--
-- Name: NurseWalkInOrder NurseWalkInOrder_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."NurseWalkInOrder"
    ADD CONSTRAINT "NurseWalkInOrder_pkey" PRIMARY KEY (id);


--
-- Name: PatientAccount PatientAccount_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."PatientAccount"
    ADD CONSTRAINT "PatientAccount_pkey" PRIMARY KEY (id);


--
-- Name: PatientAttachedImage PatientAttachedImage_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."PatientAttachedImage"
    ADD CONSTRAINT "PatientAttachedImage_pkey" PRIMARY KEY (id);


--
-- Name: PatientDiagnosis PatientDiagnosis_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."PatientDiagnosis"
    ADD CONSTRAINT "PatientDiagnosis_pkey" PRIMARY KEY (id);


--
-- Name: PatientGallery PatientGallery_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."PatientGallery"
    ADD CONSTRAINT "PatientGallery_pkey" PRIMARY KEY (id);


--
-- Name: Patient Patient_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."Patient"
    ADD CONSTRAINT "Patient_pkey" PRIMARY KEY (id);


--
-- Name: PharmacyInvoiceItem PharmacyInvoiceItem_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."PharmacyInvoiceItem"
    ADD CONSTRAINT "PharmacyInvoiceItem_pkey" PRIMARY KEY (id);


--
-- Name: PharmacyInvoice PharmacyInvoice_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."PharmacyInvoice"
    ADD CONSTRAINT "PharmacyInvoice_pkey" PRIMARY KEY (id);


--
-- Name: RadiologyOrder RadiologyOrder_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."RadiologyOrder"
    ADD CONSTRAINT "RadiologyOrder_pkey" PRIMARY KEY (id);


--
-- Name: RadiologyResultFile RadiologyResultFile_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."RadiologyResultFile"
    ADD CONSTRAINT "RadiologyResultFile_pkey" PRIMARY KEY (id);


--
-- Name: RadiologyResult RadiologyResult_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."RadiologyResult"
    ADD CONSTRAINT "RadiologyResult_pkey" PRIMARY KEY (id);


--
-- Name: RadiologyTemplate RadiologyTemplate_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."RadiologyTemplate"
    ADD CONSTRAINT "RadiologyTemplate_pkey" PRIMARY KEY (id);


--
-- Name: Referral Referral_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."Referral"
    ADD CONSTRAINT "Referral_pkey" PRIMARY KEY (id);


--
-- Name: Service Service_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."Service"
    ADD CONSTRAINT "Service_pkey" PRIMARY KEY (id);


--
-- Name: SystemSettings SystemSettings_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."SystemSettings"
    ADD CONSTRAINT "SystemSettings_pkey" PRIMARY KEY (id);


--
-- Name: Tooth Tooth_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."Tooth"
    ADD CONSTRAINT "Tooth_pkey" PRIMARY KEY (id);


--
-- Name: User User_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."User"
    ADD CONSTRAINT "User_pkey" PRIMARY KEY (id);


--
-- Name: VirtualQueue VirtualQueue_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."VirtualQueue"
    ADD CONSTRAINT "VirtualQueue_pkey" PRIMARY KEY (id);


--
-- Name: Visit Visit_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."Visit"
    ADD CONSTRAINT "Visit_pkey" PRIMARY KEY (id);


--
-- Name: VitalSign VitalSign_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."VitalSign"
    ADD CONSTRAINT "VitalSign_pkey" PRIMARY KEY (id);


--
-- Name: _prisma_migrations _prisma_migrations_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public._prisma_migrations
    ADD CONSTRAINT _prisma_migrations_pkey PRIMARY KEY (id);


--
-- Name: AccountDeposit_accountId_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "AccountDeposit_accountId_idx" ON public."AccountDeposit" USING btree ("accountId");


--
-- Name: AccountDeposit_depositedById_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "AccountDeposit_depositedById_idx" ON public."AccountDeposit" USING btree ("depositedById");


--
-- Name: AccountDeposit_patientId_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "AccountDeposit_patientId_idx" ON public."AccountDeposit" USING btree ("patientId");


--
-- Name: AccountRequest_accountId_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "AccountRequest_accountId_idx" ON public."AccountRequest" USING btree ("accountId");


--
-- Name: AccountRequest_createdAt_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "AccountRequest_createdAt_idx" ON public."AccountRequest" USING btree ("createdAt");


--
-- Name: AccountRequest_patientId_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "AccountRequest_patientId_idx" ON public."AccountRequest" USING btree ("patientId");


--
-- Name: AccountRequest_requestType_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "AccountRequest_requestType_idx" ON public."AccountRequest" USING btree ("requestType");


--
-- Name: AccountRequest_status_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "AccountRequest_status_idx" ON public."AccountRequest" USING btree (status);


--
-- Name: AccountTransaction_accountId_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "AccountTransaction_accountId_idx" ON public."AccountTransaction" USING btree ("accountId");


--
-- Name: AccountTransaction_createdAt_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "AccountTransaction_createdAt_idx" ON public."AccountTransaction" USING btree ("createdAt");


--
-- Name: AccountTransaction_patientId_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "AccountTransaction_patientId_idx" ON public."AccountTransaction" USING btree ("patientId");


--
-- Name: AccountTransaction_processedById_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "AccountTransaction_processedById_idx" ON public."AccountTransaction" USING btree ("processedById");


--
-- Name: AccountTransaction_subAccount_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "AccountTransaction_subAccount_idx" ON public."AccountTransaction" USING btree ("subAccount");


--
-- Name: AccountTransaction_type_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "AccountTransaction_type_idx" ON public."AccountTransaction" USING btree (type);


--
-- Name: Appointment_appointmentDate_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "Appointment_appointmentDate_idx" ON public."Appointment" USING btree ("appointmentDate");


--
-- Name: Appointment_createdById_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "Appointment_createdById_idx" ON public."Appointment" USING btree ("createdById");


--
-- Name: Appointment_doctorId_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "Appointment_doctorId_idx" ON public."Appointment" USING btree ("doctorId");


--
-- Name: Appointment_patientId_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "Appointment_patientId_idx" ON public."Appointment" USING btree ("patientId");


--
-- Name: Appointment_status_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "Appointment_status_idx" ON public."Appointment" USING btree (status);


--
-- Name: BankDeposit_depositedById_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "BankDeposit_depositedById_idx" ON public."BankDeposit" USING btree ("depositedById");


--
-- Name: BankDeposit_sessionId_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "BankDeposit_sessionId_idx" ON public."BankDeposit" USING btree ("sessionId");


--
-- Name: BankDeposit_status_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "BankDeposit_status_idx" ON public."BankDeposit" USING btree (status);


--
-- Name: BatchOrderService_batchOrderId_serviceId_key; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX "BatchOrderService_batchOrderId_serviceId_key" ON public."BatchOrderService" USING btree ("batchOrderId", "serviceId");


--
-- Name: Bed_code_key; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX "Bed_code_key" ON public."Bed" USING btree (code);


--
-- Name: Bed_name_key; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX "Bed_name_key" ON public."Bed" USING btree (name);


--
-- Name: BillingService_billingId_serviceId_key; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX "BillingService_billingId_serviceId_key" ON public."BillingService" USING btree ("billingId", "serviceId");


--
-- Name: CardActivation_activatedAt_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "CardActivation_activatedAt_idx" ON public."CardActivation" USING btree ("activatedAt");


--
-- Name: CardActivation_activatedById_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "CardActivation_activatedById_idx" ON public."CardActivation" USING btree ("activatedById");


--
-- Name: CardActivation_patientId_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "CardActivation_patientId_idx" ON public."CardActivation" USING btree ("patientId");


--
-- Name: CashExpense_category_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "CashExpense_category_idx" ON public."CashExpense" USING btree (category);


--
-- Name: CashExpense_recordedById_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "CashExpense_recordedById_idx" ON public."CashExpense" USING btree ("recordedById");


--
-- Name: CashExpense_sessionId_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "CashExpense_sessionId_idx" ON public."CashExpense" USING btree ("sessionId");


--
-- Name: CashTransaction_processedById_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "CashTransaction_processedById_idx" ON public."CashTransaction" USING btree ("processedById");


--
-- Name: CashTransaction_sessionId_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "CashTransaction_sessionId_idx" ON public."CashTransaction" USING btree ("sessionId");


--
-- Name: CashTransaction_type_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "CashTransaction_type_idx" ON public."CashTransaction" USING btree (type);


--
-- Name: CompoundPrescription_referenceNumber_key; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX "CompoundPrescription_referenceNumber_key" ON public."CompoundPrescription" USING btree ("referenceNumber");


--
-- Name: ContinuousInfusion_medicationOrderId_key; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX "ContinuousInfusion_medicationOrderId_key" ON public."ContinuousInfusion" USING btree ("medicationOrderId");


--
-- Name: CustomMedication_doctorId_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "CustomMedication_doctorId_idx" ON public."CustomMedication" USING btree ("doctorId");


--
-- Name: CustomMedication_doctorId_name_strength_key; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX "CustomMedication_doctorId_name_strength_key" ON public."CustomMedication" USING btree ("doctorId", name, strength);


--
-- Name: CustomMedication_name_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "CustomMedication_name_idx" ON public."CustomMedication" USING btree (name);


--
-- Name: CustomMedication_normalizedName_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "CustomMedication_normalizedName_idx" ON public."CustomMedication" USING btree ("normalizedName");


--
-- Name: DailyCashSession_createdById_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "DailyCashSession_createdById_idx" ON public."DailyCashSession" USING btree ("createdById");


--
-- Name: DailyCashSession_sessionDate_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "DailyCashSession_sessionDate_idx" ON public."DailyCashSession" USING btree ("sessionDate");


--
-- Name: DailyCashSession_status_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "DailyCashSession_status_idx" ON public."DailyCashSession" USING btree (status);


--
-- Name: DentalPhoto_doctorId_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "DentalPhoto_doctorId_idx" ON public."DentalPhoto" USING btree ("doctorId");


--
-- Name: DentalPhoto_patientId_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "DentalPhoto_patientId_idx" ON public."DentalPhoto" USING btree ("patientId");


--
-- Name: DentalPhoto_photoType_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "DentalPhoto_photoType_idx" ON public."DentalPhoto" USING btree ("photoType");


--
-- Name: DentalPhoto_visitId_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "DentalPhoto_visitId_idx" ON public."DentalPhoto" USING btree ("visitId");


--
-- Name: DentalProcedureCompletion_batchOrderId_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "DentalProcedureCompletion_batchOrderId_idx" ON public."DentalProcedureCompletion" USING btree ("batchOrderId");


--
-- Name: DentalProcedureCompletion_batchOrderServiceId_key; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX "DentalProcedureCompletion_batchOrderServiceId_key" ON public."DentalProcedureCompletion" USING btree ("batchOrderServiceId");


--
-- Name: DentalProcedureCompletion_doctorId_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "DentalProcedureCompletion_doctorId_idx" ON public."DentalProcedureCompletion" USING btree ("doctorId");


--
-- Name: DentalProcedureCompletion_patientId_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "DentalProcedureCompletion_patientId_idx" ON public."DentalProcedureCompletion" USING btree ("patientId");


--
-- Name: DentalProcedureCompletion_visitId_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "DentalProcedureCompletion_visitId_idx" ON public."DentalProcedureCompletion" USING btree ("visitId");


--
-- Name: DetailedLabResult_labOrderId_serviceId_templateId_key; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX "DetailedLabResult_labOrderId_serviceId_templateId_key" ON public."DetailedLabResult" USING btree ("labOrderId", "serviceId", "templateId");


--
-- Name: DiagnosisNotes_createdAt_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "DiagnosisNotes_createdAt_idx" ON public."DiagnosisNotes" USING btree ("createdAt");


--
-- Name: DiagnosisNotes_doctorId_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "DiagnosisNotes_doctorId_idx" ON public."DiagnosisNotes" USING btree ("doctorId");


--
-- Name: DiagnosisNotes_patientId_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "DiagnosisNotes_patientId_idx" ON public."DiagnosisNotes" USING btree ("patientId");


--
-- Name: DiagnosisNotes_visitId_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "DiagnosisNotes_visitId_idx" ON public."DiagnosisNotes" USING btree ("visitId");


--
-- Name: Disease_code_key; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX "Disease_code_key" ON public."Disease" USING btree (code);


--
-- Name: DoctorWalkInOrder_billingId_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "DoctorWalkInOrder_billingId_idx" ON public."DoctorWalkInOrder" USING btree ("billingId");


--
-- Name: DoctorWalkInOrder_createdAt_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "DoctorWalkInOrder_createdAt_idx" ON public."DoctorWalkInOrder" USING btree ("createdAt");


--
-- Name: DoctorWalkInOrder_doctorId_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "DoctorWalkInOrder_doctorId_idx" ON public."DoctorWalkInOrder" USING btree ("doctorId");


--
-- Name: DoctorWalkInOrder_patientId_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "DoctorWalkInOrder_patientId_idx" ON public."DoctorWalkInOrder" USING btree ("patientId");


--
-- Name: DoctorWalkInOrder_serviceId_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "DoctorWalkInOrder_serviceId_idx" ON public."DoctorWalkInOrder" USING btree ("serviceId");


--
-- Name: DoctorWalkInOrder_status_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "DoctorWalkInOrder_status_idx" ON public."DoctorWalkInOrder" USING btree (status);


--
-- Name: EmergencyDrugOrder_billingId_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "EmergencyDrugOrder_billingId_idx" ON public."EmergencyDrugOrder" USING btree ("billingId");


--
-- Name: EmergencyDrugOrder_createdAt_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "EmergencyDrugOrder_createdAt_idx" ON public."EmergencyDrugOrder" USING btree ("createdAt");


--
-- Name: EmergencyDrugOrder_doctorId_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "EmergencyDrugOrder_doctorId_idx" ON public."EmergencyDrugOrder" USING btree ("doctorId");


--
-- Name: EmergencyDrugOrder_patientId_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "EmergencyDrugOrder_patientId_idx" ON public."EmergencyDrugOrder" USING btree ("patientId");


--
-- Name: EmergencyDrugOrder_serviceId_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "EmergencyDrugOrder_serviceId_idx" ON public."EmergencyDrugOrder" USING btree ("serviceId");


--
-- Name: EmergencyDrugOrder_status_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "EmergencyDrugOrder_status_idx" ON public."EmergencyDrugOrder" USING btree (status);


--
-- Name: EmergencyDrugOrder_visitId_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "EmergencyDrugOrder_visitId_idx" ON public."EmergencyDrugOrder" USING btree ("visitId");


--
-- Name: InsuranceTransaction_createdAt_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "InsuranceTransaction_createdAt_idx" ON public."InsuranceTransaction" USING btree ("createdAt");


--
-- Name: InsuranceTransaction_insuranceId_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "InsuranceTransaction_insuranceId_idx" ON public."InsuranceTransaction" USING btree ("insuranceId");


--
-- Name: InsuranceTransaction_patientId_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "InsuranceTransaction_patientId_idx" ON public."InsuranceTransaction" USING btree ("patientId");


--
-- Name: InsuranceTransaction_serviceDate_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "InsuranceTransaction_serviceDate_idx" ON public."InsuranceTransaction" USING btree ("serviceDate");


--
-- Name: InsuranceTransaction_status_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "InsuranceTransaction_status_idx" ON public."InsuranceTransaction" USING btree (status);


--
-- Name: InsuranceTransaction_visitId_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "InsuranceTransaction_visitId_idx" ON public."InsuranceTransaction" USING btree ("visitId");


--
-- Name: Insurance_code_key; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX "Insurance_code_key" ON public."Insurance" USING btree (code);


--
-- Name: InternationalMedicalCertificate_certificateNo_key; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX "InternationalMedicalCertificate_certificateNo_key" ON public."InternationalMedicalCertificate" USING btree ("certificateNo");


--
-- Name: InternationalMedicalCertificate_doctorId_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "InternationalMedicalCertificate_doctorId_idx" ON public."InternationalMedicalCertificate" USING btree ("doctorId");


--
-- Name: InternationalMedicalCertificate_patientId_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "InternationalMedicalCertificate_patientId_idx" ON public."InternationalMedicalCertificate" USING btree ("patientId");


--
-- Name: LabTestOrder_batchOrderId_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "LabTestOrder_batchOrderId_idx" ON public."LabTestOrder" USING btree ("batchOrderId");


--
-- Name: LabTestOrder_labTestId_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "LabTestOrder_labTestId_idx" ON public."LabTestOrder" USING btree ("labTestId");


--
-- Name: LabTestOrder_patientId_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "LabTestOrder_patientId_idx" ON public."LabTestOrder" USING btree ("patientId");


--
-- Name: LabTestOrder_status_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "LabTestOrder_status_idx" ON public."LabTestOrder" USING btree (status);


--
-- Name: LabTestOrder_visitId_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "LabTestOrder_visitId_idx" ON public."LabTestOrder" USING btree ("visitId");


--
-- Name: LabTestResultField_testId_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "LabTestResultField_testId_idx" ON public."LabTestResultField" USING btree ("testId");


--
-- Name: LabTestResult_orderId_testId_key; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX "LabTestResult_orderId_testId_key" ON public."LabTestResult" USING btree ("orderId", "testId");


--
-- Name: LabTestResult_status_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "LabTestResult_status_idx" ON public."LabTestResult" USING btree (status);


--
-- Name: LabTestResult_testId_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "LabTestResult_testId_idx" ON public."LabTestResult" USING btree ("testId");


--
-- Name: LabTest_category_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "LabTest_category_idx" ON public."LabTest" USING btree (category);


--
-- Name: LabTest_code_key; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX "LabTest_code_key" ON public."LabTest" USING btree (code);


--
-- Name: LabTest_groupId_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "LabTest_groupId_idx" ON public."LabTest" USING btree ("groupId");


--
-- Name: LabTest_isActive_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "LabTest_isActive_idx" ON public."LabTest" USING btree ("isActive");


--
-- Name: Loan_expenseId_key; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX "Loan_expenseId_key" ON public."Loan" USING btree ("expenseId");


--
-- Name: Loan_requestedAt_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "Loan_requestedAt_idx" ON public."Loan" USING btree ("requestedAt");


--
-- Name: Loan_staffId_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "Loan_staffId_idx" ON public."Loan" USING btree ("staffId");


--
-- Name: Loan_status_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "Loan_status_idx" ON public."Loan" USING btree (status);


--
-- Name: MaterialNeedsOrder_billingId_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "MaterialNeedsOrder_billingId_idx" ON public."MaterialNeedsOrder" USING btree ("billingId");


--
-- Name: MaterialNeedsOrder_createdAt_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "MaterialNeedsOrder_createdAt_idx" ON public."MaterialNeedsOrder" USING btree ("createdAt");


--
-- Name: MaterialNeedsOrder_nurseId_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "MaterialNeedsOrder_nurseId_idx" ON public."MaterialNeedsOrder" USING btree ("nurseId");


--
-- Name: MaterialNeedsOrder_patientId_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "MaterialNeedsOrder_patientId_idx" ON public."MaterialNeedsOrder" USING btree ("patientId");


--
-- Name: MaterialNeedsOrder_serviceId_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "MaterialNeedsOrder_serviceId_idx" ON public."MaterialNeedsOrder" USING btree ("serviceId");


--
-- Name: MaterialNeedsOrder_status_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "MaterialNeedsOrder_status_idx" ON public."MaterialNeedsOrder" USING btree (status);


--
-- Name: MaterialNeedsOrder_visitId_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "MaterialNeedsOrder_visitId_idx" ON public."MaterialNeedsOrder" USING btree ("visitId");


--
-- Name: MedicalCertificate_certificateDate_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "MedicalCertificate_certificateDate_idx" ON public."MedicalCertificate" USING btree ("certificateDate");


--
-- Name: MedicalCertificate_certificateNo_key; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX "MedicalCertificate_certificateNo_key" ON public."MedicalCertificate" USING btree ("certificateNo");


--
-- Name: MedicalCertificate_doctorId_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "MedicalCertificate_doctorId_idx" ON public."MedicalCertificate" USING btree ("doctorId");


--
-- Name: MedicalCertificate_patientId_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "MedicalCertificate_patientId_idx" ON public."MedicalCertificate" USING btree ("patientId");


--
-- Name: MedicalCertificate_status_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "MedicalCertificate_status_idx" ON public."MedicalCertificate" USING btree (status);


--
-- Name: MedicalHistory_completedDate_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "MedicalHistory_completedDate_idx" ON public."MedicalHistory" USING btree ("completedDate");


--
-- Name: MedicalHistory_doctorId_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "MedicalHistory_doctorId_idx" ON public."MedicalHistory" USING btree ("doctorId");


--
-- Name: MedicalHistory_patientId_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "MedicalHistory_patientId_idx" ON public."MedicalHistory" USING btree ("patientId");


--
-- Name: MedicalHistory_visitDate_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "MedicalHistory_visitDate_idx" ON public."MedicalHistory" USING btree ("visitDate");


--
-- Name: MedicalHistory_visitId_key; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX "MedicalHistory_visitId_key" ON public."MedicalHistory" USING btree ("visitId");


--
-- Name: MedicationCatalog_category_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "MedicationCatalog_category_idx" ON public."MedicationCatalog" USING btree (category);


--
-- Name: MedicationCatalog_isRetailOnly_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "MedicationCatalog_isRetailOnly_idx" ON public."MedicationCatalog" USING btree ("isRetailOnly");


--
-- Name: MedicationCatalog_name_dosageForm_strength_key; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX "MedicationCatalog_name_dosageForm_strength_key" ON public."MedicationCatalog" USING btree (name, "dosageForm", strength);


--
-- Name: MedicationCatalog_name_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "MedicationCatalog_name_idx" ON public."MedicationCatalog" USING btree (name);


--
-- Name: NurseServiceAssignment_assignedNurseId_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "NurseServiceAssignment_assignedNurseId_idx" ON public."NurseServiceAssignment" USING btree ("assignedNurseId");


--
-- Name: NurseServiceAssignment_createdAt_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "NurseServiceAssignment_createdAt_idx" ON public."NurseServiceAssignment" USING btree ("createdAt");


--
-- Name: NurseServiceAssignment_status_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "NurseServiceAssignment_status_idx" ON public."NurseServiceAssignment" USING btree (status);


--
-- Name: NurseServiceAssignment_visitId_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "NurseServiceAssignment_visitId_idx" ON public."NurseServiceAssignment" USING btree ("visitId");


--
-- Name: NurseWalkInOrder_billingId_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "NurseWalkInOrder_billingId_idx" ON public."NurseWalkInOrder" USING btree ("billingId");


--
-- Name: NurseWalkInOrder_createdAt_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "NurseWalkInOrder_createdAt_idx" ON public."NurseWalkInOrder" USING btree ("createdAt");


--
-- Name: NurseWalkInOrder_nurseId_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "NurseWalkInOrder_nurseId_idx" ON public."NurseWalkInOrder" USING btree ("nurseId");


--
-- Name: NurseWalkInOrder_patientId_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "NurseWalkInOrder_patientId_idx" ON public."NurseWalkInOrder" USING btree ("patientId");


--
-- Name: NurseWalkInOrder_serviceId_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "NurseWalkInOrder_serviceId_idx" ON public."NurseWalkInOrder" USING btree ("serviceId");


--
-- Name: NurseWalkInOrder_status_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "NurseWalkInOrder_status_idx" ON public."NurseWalkInOrder" USING btree (status);


--
-- Name: PatientAccount_accountType_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "PatientAccount_accountType_idx" ON public."PatientAccount" USING btree ("accountType");


--
-- Name: PatientAccount_patientId_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "PatientAccount_patientId_idx" ON public."PatientAccount" USING btree ("patientId");


--
-- Name: PatientAccount_patientId_key; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX "PatientAccount_patientId_key" ON public."PatientAccount" USING btree ("patientId");


--
-- Name: PatientAccount_status_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "PatientAccount_status_idx" ON public."PatientAccount" USING btree (status);


--
-- Name: PatientAttachedImage_doctorId_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "PatientAttachedImage_doctorId_idx" ON public."PatientAttachedImage" USING btree ("doctorId");


--
-- Name: PatientAttachedImage_patientId_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "PatientAttachedImage_patientId_idx" ON public."PatientAttachedImage" USING btree ("patientId");


--
-- Name: PatientAttachedImage_visitId_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "PatientAttachedImage_visitId_idx" ON public."PatientAttachedImage" USING btree ("visitId");


--
-- Name: PatientDiagnosis_diseaseId_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "PatientDiagnosis_diseaseId_idx" ON public."PatientDiagnosis" USING btree ("diseaseId");


--
-- Name: PatientDiagnosis_patientId_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "PatientDiagnosis_patientId_idx" ON public."PatientDiagnosis" USING btree ("patientId");


--
-- Name: PatientDiagnosis_visitId_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "PatientDiagnosis_visitId_idx" ON public."PatientDiagnosis" USING btree ("visitId");


--
-- Name: PatientGallery_createdAt_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "PatientGallery_createdAt_idx" ON public."PatientGallery" USING btree ("createdAt");


--
-- Name: PatientGallery_imageType_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "PatientGallery_imageType_idx" ON public."PatientGallery" USING btree ("imageType");


--
-- Name: PatientGallery_patientId_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "PatientGallery_patientId_idx" ON public."PatientGallery" USING btree ("patientId");


--
-- Name: PatientGallery_uploadedById_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "PatientGallery_uploadedById_idx" ON public."PatientGallery" USING btree ("uploadedById");


--
-- Name: PatientGallery_visitId_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "PatientGallery_visitId_idx" ON public."PatientGallery" USING btree ("visitId");


--
-- Name: Patient_cardStatus_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "Patient_cardStatus_idx" ON public."Patient" USING btree ("cardStatus");


--
-- Name: Patient_createdAt_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "Patient_createdAt_idx" ON public."Patient" USING btree ("createdAt");


--
-- Name: Patient_insuranceId_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "Patient_insuranceId_idx" ON public."Patient" USING btree ("insuranceId");


--
-- Name: Patient_status_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "Patient_status_idx" ON public."Patient" USING btree (status);


--
-- Name: Patient_type_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "Patient_type_idx" ON public."Patient" USING btree (type);


--
-- Name: RadiologyTemplate_investigationTypeId_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "RadiologyTemplate_investigationTypeId_idx" ON public."RadiologyTemplate" USING btree ("investigationTypeId");


--
-- Name: RadiologyTemplate_investigationTypeId_key; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX "RadiologyTemplate_investigationTypeId_key" ON public."RadiologyTemplate" USING btree ("investigationTypeId");


--
-- Name: RadiologyTemplate_isActive_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "RadiologyTemplate_isActive_idx" ON public."RadiologyTemplate" USING btree ("isActive");


--
-- Name: Service_code_key; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX "Service_code_key" ON public."Service" USING btree (code);


--
-- Name: SystemSettings_key_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "SystemSettings_key_idx" ON public."SystemSettings" USING btree (key);


--
-- Name: SystemSettings_key_key; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX "SystemSettings_key_key" ON public."SystemSettings" USING btree (key);


--
-- Name: User_availability_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "User_availability_idx" ON public."User" USING btree (availability);


--
-- Name: User_email_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "User_email_idx" ON public."User" USING btree (email);


--
-- Name: User_email_key; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX "User_email_key" ON public."User" USING btree (email);


--
-- Name: User_role_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "User_role_idx" ON public."User" USING btree (role);


--
-- Name: User_username_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "User_username_idx" ON public."User" USING btree (username);


--
-- Name: User_username_key; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX "User_username_key" ON public."User" USING btree (username);


--
-- Name: VirtualQueue_createdAt_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "VirtualQueue_createdAt_idx" ON public."VirtualQueue" USING btree ("createdAt");


--
-- Name: VirtualQueue_patientId_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "VirtualQueue_patientId_idx" ON public."VirtualQueue" USING btree ("patientId");


--
-- Name: VirtualQueue_priority_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "VirtualQueue_priority_idx" ON public."VirtualQueue" USING btree (priority);


--
-- Name: VirtualQueue_status_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "VirtualQueue_status_idx" ON public."VirtualQueue" USING btree (status);


--
-- Name: Visit_assignmentId_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "Visit_assignmentId_idx" ON public."Visit" USING btree ("assignmentId");


--
-- Name: Visit_createdAt_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "Visit_createdAt_idx" ON public."Visit" USING btree ("createdAt");


--
-- Name: Visit_patientId_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "Visit_patientId_idx" ON public."Visit" USING btree ("patientId");


--
-- Name: Visit_status_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "Visit_status_idx" ON public."Visit" USING btree (status);


--
-- Name: Visit_suggestedDoctorId_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "Visit_suggestedDoctorId_idx" ON public."Visit" USING btree ("suggestedDoctorId");


--
-- Name: Visit_visitUid_key; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX "Visit_visitUid_key" ON public."Visit" USING btree ("visitUid");


--
-- Name: AccountDeposit AccountDeposit_accountId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."AccountDeposit"
    ADD CONSTRAINT "AccountDeposit_accountId_fkey" FOREIGN KEY ("accountId") REFERENCES public."PatientAccount"(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: AccountDeposit AccountDeposit_depositedById_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."AccountDeposit"
    ADD CONSTRAINT "AccountDeposit_depositedById_fkey" FOREIGN KEY ("depositedById") REFERENCES public."User"(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: AccountDeposit AccountDeposit_patientId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."AccountDeposit"
    ADD CONSTRAINT "AccountDeposit_patientId_fkey" FOREIGN KEY ("patientId") REFERENCES public."Patient"(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: AccountRequest AccountRequest_accountId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."AccountRequest"
    ADD CONSTRAINT "AccountRequest_accountId_fkey" FOREIGN KEY ("accountId") REFERENCES public."PatientAccount"(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: AccountRequest AccountRequest_patientId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."AccountRequest"
    ADD CONSTRAINT "AccountRequest_patientId_fkey" FOREIGN KEY ("patientId") REFERENCES public."Patient"(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: AccountRequest AccountRequest_requestedById_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."AccountRequest"
    ADD CONSTRAINT "AccountRequest_requestedById_fkey" FOREIGN KEY ("requestedById") REFERENCES public."User"(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: AccountRequest AccountRequest_verifiedById_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."AccountRequest"
    ADD CONSTRAINT "AccountRequest_verifiedById_fkey" FOREIGN KEY ("verifiedById") REFERENCES public."User"(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: AccountTransaction AccountTransaction_accountId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."AccountTransaction"
    ADD CONSTRAINT "AccountTransaction_accountId_fkey" FOREIGN KEY ("accountId") REFERENCES public."PatientAccount"(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: AccountTransaction AccountTransaction_billingId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."AccountTransaction"
    ADD CONSTRAINT "AccountTransaction_billingId_fkey" FOREIGN KEY ("billingId") REFERENCES public."Billing"(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: AccountTransaction AccountTransaction_patientId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."AccountTransaction"
    ADD CONSTRAINT "AccountTransaction_patientId_fkey" FOREIGN KEY ("patientId") REFERENCES public."Patient"(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: AccountTransaction AccountTransaction_processedById_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."AccountTransaction"
    ADD CONSTRAINT "AccountTransaction_processedById_fkey" FOREIGN KEY ("processedById") REFERENCES public."User"(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: AccountTransaction AccountTransaction_visitId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."AccountTransaction"
    ADD CONSTRAINT "AccountTransaction_visitId_fkey" FOREIGN KEY ("visitId") REFERENCES public."Visit"(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: AdmissionService AdmissionService_admissionId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."AdmissionService"
    ADD CONSTRAINT "AdmissionService_admissionId_fkey" FOREIGN KEY ("admissionId") REFERENCES public."Admission"(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: AdmissionService AdmissionService_orderedById_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."AdmissionService"
    ADD CONSTRAINT "AdmissionService_orderedById_fkey" FOREIGN KEY ("orderedById") REFERENCES public."User"(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: AdmissionService AdmissionService_serviceId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."AdmissionService"
    ADD CONSTRAINT "AdmissionService_serviceId_fkey" FOREIGN KEY ("serviceId") REFERENCES public."Service"(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: Admission Admission_admittedById_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."Admission"
    ADD CONSTRAINT "Admission_admittedById_fkey" FOREIGN KEY ("admittedById") REFERENCES public."User"(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: Admission Admission_bedId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."Admission"
    ADD CONSTRAINT "Admission_bedId_fkey" FOREIGN KEY ("bedId") REFERENCES public."Bed"(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: Admission Admission_patientId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."Admission"
    ADD CONSTRAINT "Admission_patientId_fkey" FOREIGN KEY ("patientId") REFERENCES public."Patient"(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: Appointment Appointment_createdById_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."Appointment"
    ADD CONSTRAINT "Appointment_createdById_fkey" FOREIGN KEY ("createdById") REFERENCES public."User"(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: Appointment Appointment_doctorId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."Appointment"
    ADD CONSTRAINT "Appointment_doctorId_fkey" FOREIGN KEY ("doctorId") REFERENCES public."User"(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: Appointment Appointment_patientId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."Appointment"
    ADD CONSTRAINT "Appointment_patientId_fkey" FOREIGN KEY ("patientId") REFERENCES public."Patient"(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: Assignment Assignment_doctorId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."Assignment"
    ADD CONSTRAINT "Assignment_doctorId_fkey" FOREIGN KEY ("doctorId") REFERENCES public."User"(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: Assignment Assignment_patientId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."Assignment"
    ADD CONSTRAINT "Assignment_patientId_fkey" FOREIGN KEY ("patientId") REFERENCES public."Patient"(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: AuditLog AuditLog_userId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."AuditLog"
    ADD CONSTRAINT "AuditLog_userId_fkey" FOREIGN KEY ("userId") REFERENCES public."User"(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: BankDeposit BankDeposit_depositedById_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."BankDeposit"
    ADD CONSTRAINT "BankDeposit_depositedById_fkey" FOREIGN KEY ("depositedById") REFERENCES public."User"(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: BankDeposit BankDeposit_sessionId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."BankDeposit"
    ADD CONSTRAINT "BankDeposit_sessionId_fkey" FOREIGN KEY ("sessionId") REFERENCES public."DailyCashSession"(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: BatchOrderService BatchOrderService_batchOrderId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."BatchOrderService"
    ADD CONSTRAINT "BatchOrderService_batchOrderId_fkey" FOREIGN KEY ("batchOrderId") REFERENCES public."BatchOrder"(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: BatchOrderService BatchOrderService_investigationTypeId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."BatchOrderService"
    ADD CONSTRAINT "BatchOrderService_investigationTypeId_fkey" FOREIGN KEY ("investigationTypeId") REFERENCES public."InvestigationType"(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: BatchOrderService BatchOrderService_serviceId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."BatchOrderService"
    ADD CONSTRAINT "BatchOrderService_serviceId_fkey" FOREIGN KEY ("serviceId") REFERENCES public."Service"(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: BatchOrder BatchOrder_doctorId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."BatchOrder"
    ADD CONSTRAINT "BatchOrder_doctorId_fkey" FOREIGN KEY ("doctorId") REFERENCES public."User"(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: BatchOrder BatchOrder_patientId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."BatchOrder"
    ADD CONSTRAINT "BatchOrder_patientId_fkey" FOREIGN KEY ("patientId") REFERENCES public."Patient"(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: BatchOrder BatchOrder_visitId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."BatchOrder"
    ADD CONSTRAINT "BatchOrder_visitId_fkey" FOREIGN KEY ("visitId") REFERENCES public."Visit"(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: BillPayment BillPayment_billingId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."BillPayment"
    ADD CONSTRAINT "BillPayment_billingId_fkey" FOREIGN KEY ("billingId") REFERENCES public."Billing"(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: BillPayment BillPayment_insuranceId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."BillPayment"
    ADD CONSTRAINT "BillPayment_insuranceId_fkey" FOREIGN KEY ("insuranceId") REFERENCES public."Insurance"(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: BillPayment BillPayment_patientId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."BillPayment"
    ADD CONSTRAINT "BillPayment_patientId_fkey" FOREIGN KEY ("patientId") REFERENCES public."Patient"(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: BillingService BillingService_billingId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."BillingService"
    ADD CONSTRAINT "BillingService_billingId_fkey" FOREIGN KEY ("billingId") REFERENCES public."Billing"(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: BillingService BillingService_serviceId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."BillingService"
    ADD CONSTRAINT "BillingService_serviceId_fkey" FOREIGN KEY ("serviceId") REFERENCES public."Service"(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: Billing Billing_insuranceId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."Billing"
    ADD CONSTRAINT "Billing_insuranceId_fkey" FOREIGN KEY ("insuranceId") REFERENCES public."Insurance"(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: Billing Billing_patientId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."Billing"
    ADD CONSTRAINT "Billing_patientId_fkey" FOREIGN KEY ("patientId") REFERENCES public."Patient"(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: Billing Billing_visitId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."Billing"
    ADD CONSTRAINT "Billing_visitId_fkey" FOREIGN KEY ("visitId") REFERENCES public."Visit"(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: CardActivation CardActivation_activatedById_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."CardActivation"
    ADD CONSTRAINT "CardActivation_activatedById_fkey" FOREIGN KEY ("activatedById") REFERENCES public."User"(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: CardActivation CardActivation_billingId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."CardActivation"
    ADD CONSTRAINT "CardActivation_billingId_fkey" FOREIGN KEY ("billingId") REFERENCES public."Billing"(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: CardActivation CardActivation_patientId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."CardActivation"
    ADD CONSTRAINT "CardActivation_patientId_fkey" FOREIGN KEY ("patientId") REFERENCES public."Patient"(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: CashExpense CashExpense_recordedById_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."CashExpense"
    ADD CONSTRAINT "CashExpense_recordedById_fkey" FOREIGN KEY ("recordedById") REFERENCES public."User"(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: CashExpense CashExpense_sessionId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."CashExpense"
    ADD CONSTRAINT "CashExpense_sessionId_fkey" FOREIGN KEY ("sessionId") REFERENCES public."DailyCashSession"(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: CashTransaction CashTransaction_billingId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."CashTransaction"
    ADD CONSTRAINT "CashTransaction_billingId_fkey" FOREIGN KEY ("billingId") REFERENCES public."Billing"(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: CashTransaction CashTransaction_patientId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."CashTransaction"
    ADD CONSTRAINT "CashTransaction_patientId_fkey" FOREIGN KEY ("patientId") REFERENCES public."Patient"(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: CashTransaction CashTransaction_processedById_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."CashTransaction"
    ADD CONSTRAINT "CashTransaction_processedById_fkey" FOREIGN KEY ("processedById") REFERENCES public."User"(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: CashTransaction CashTransaction_sessionId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."CashTransaction"
    ADD CONSTRAINT "CashTransaction_sessionId_fkey" FOREIGN KEY ("sessionId") REFERENCES public."DailyCashSession"(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: CompoundIngredient CompoundIngredient_compoundPrescriptionId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."CompoundIngredient"
    ADD CONSTRAINT "CompoundIngredient_compoundPrescriptionId_fkey" FOREIGN KEY ("compoundPrescriptionId") REFERENCES public."CompoundPrescription"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: CompoundPrescription CompoundPrescription_doctorId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."CompoundPrescription"
    ADD CONSTRAINT "CompoundPrescription_doctorId_fkey" FOREIGN KEY ("doctorId") REFERENCES public."User"(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: CompoundPrescription CompoundPrescription_patientId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."CompoundPrescription"
    ADD CONSTRAINT "CompoundPrescription_patientId_fkey" FOREIGN KEY ("patientId") REFERENCES public."Patient"(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: CompoundPrescription CompoundPrescription_visitId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."CompoundPrescription"
    ADD CONSTRAINT "CompoundPrescription_visitId_fkey" FOREIGN KEY ("visitId") REFERENCES public."Visit"(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: ContinuousInfusion ContinuousInfusion_medicationOrderId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."ContinuousInfusion"
    ADD CONSTRAINT "ContinuousInfusion_medicationOrderId_fkey" FOREIGN KEY ("medicationOrderId") REFERENCES public."MedicationOrder"(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: CustomMedication CustomMedication_doctorId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."CustomMedication"
    ADD CONSTRAINT "CustomMedication_doctorId_fkey" FOREIGN KEY ("doctorId") REFERENCES public."User"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: DailyCashSession DailyCashSession_createdById_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."DailyCashSession"
    ADD CONSTRAINT "DailyCashSession_createdById_fkey" FOREIGN KEY ("createdById") REFERENCES public."User"(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: DailyCashSession DailyCashSession_resetById_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."DailyCashSession"
    ADD CONSTRAINT "DailyCashSession_resetById_fkey" FOREIGN KEY ("resetById") REFERENCES public."User"(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: DentalPhoto DentalPhoto_doctorId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."DentalPhoto"
    ADD CONSTRAINT "DentalPhoto_doctorId_fkey" FOREIGN KEY ("doctorId") REFERENCES public."User"(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: DentalPhoto DentalPhoto_patientId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."DentalPhoto"
    ADD CONSTRAINT "DentalPhoto_patientId_fkey" FOREIGN KEY ("patientId") REFERENCES public."Patient"(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: DentalPhoto DentalPhoto_visitId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."DentalPhoto"
    ADD CONSTRAINT "DentalPhoto_visitId_fkey" FOREIGN KEY ("visitId") REFERENCES public."Visit"(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: DentalProcedureCompletion DentalProcedureCompletion_batchOrderId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."DentalProcedureCompletion"
    ADD CONSTRAINT "DentalProcedureCompletion_batchOrderId_fkey" FOREIGN KEY ("batchOrderId") REFERENCES public."BatchOrder"(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: DentalProcedureCompletion DentalProcedureCompletion_batchOrderServiceId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."DentalProcedureCompletion"
    ADD CONSTRAINT "DentalProcedureCompletion_batchOrderServiceId_fkey" FOREIGN KEY ("batchOrderServiceId") REFERENCES public."BatchOrderService"(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: DentalProcedureCompletion DentalProcedureCompletion_doctorId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."DentalProcedureCompletion"
    ADD CONSTRAINT "DentalProcedureCompletion_doctorId_fkey" FOREIGN KEY ("doctorId") REFERENCES public."User"(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: DentalProcedureCompletion DentalProcedureCompletion_patientId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."DentalProcedureCompletion"
    ADD CONSTRAINT "DentalProcedureCompletion_patientId_fkey" FOREIGN KEY ("patientId") REFERENCES public."Patient"(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: DentalProcedureCompletion DentalProcedureCompletion_visitId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."DentalProcedureCompletion"
    ADD CONSTRAINT "DentalProcedureCompletion_visitId_fkey" FOREIGN KEY ("visitId") REFERENCES public."Visit"(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: DentalRecord DentalRecord_doctorId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."DentalRecord"
    ADD CONSTRAINT "DentalRecord_doctorId_fkey" FOREIGN KEY ("doctorId") REFERENCES public."User"(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: DentalRecord DentalRecord_patientId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."DentalRecord"
    ADD CONSTRAINT "DentalRecord_patientId_fkey" FOREIGN KEY ("patientId") REFERENCES public."Patient"(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: DentalRecord DentalRecord_toothId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."DentalRecord"
    ADD CONSTRAINT "DentalRecord_toothId_fkey" FOREIGN KEY ("toothId") REFERENCES public."Tooth"(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: DentalRecord DentalRecord_visitId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."DentalRecord"
    ADD CONSTRAINT "DentalRecord_visitId_fkey" FOREIGN KEY ("visitId") REFERENCES public."Visit"(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: DetailedLabResult DetailedLabResult_labOrderId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."DetailedLabResult"
    ADD CONSTRAINT "DetailedLabResult_labOrderId_fkey" FOREIGN KEY ("labOrderId") REFERENCES public."BatchOrder"(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: DetailedLabResult DetailedLabResult_serviceId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."DetailedLabResult"
    ADD CONSTRAINT "DetailedLabResult_serviceId_fkey" FOREIGN KEY ("serviceId") REFERENCES public."BatchOrderService"(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: DetailedLabResult DetailedLabResult_templateId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."DetailedLabResult"
    ADD CONSTRAINT "DetailedLabResult_templateId_fkey" FOREIGN KEY ("templateId") REFERENCES public."LabTestTemplate"(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: DiagnosisNotes DiagnosisNotes_doctorId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."DiagnosisNotes"
    ADD CONSTRAINT "DiagnosisNotes_doctorId_fkey" FOREIGN KEY ("doctorId") REFERENCES public."User"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: DiagnosisNotes DiagnosisNotes_patientId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."DiagnosisNotes"
    ADD CONSTRAINT "DiagnosisNotes_patientId_fkey" FOREIGN KEY ("patientId") REFERENCES public."Patient"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: DiagnosisNotes DiagnosisNotes_visitId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."DiagnosisNotes"
    ADD CONSTRAINT "DiagnosisNotes_visitId_fkey" FOREIGN KEY ("visitId") REFERENCES public."Visit"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: DispenseLog DispenseLog_orderId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."DispenseLog"
    ADD CONSTRAINT "DispenseLog_orderId_fkey" FOREIGN KEY ("orderId") REFERENCES public."MedicationOrder"(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: DispenseLog DispenseLog_patientId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."DispenseLog"
    ADD CONSTRAINT "DispenseLog_patientId_fkey" FOREIGN KEY ("patientId") REFERENCES public."Patient"(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: DispenseLog DispenseLog_pharmacyId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."DispenseLog"
    ADD CONSTRAINT "DispenseLog_pharmacyId_fkey" FOREIGN KEY ("pharmacyId") REFERENCES public."User"(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: DispensedMedicine DispensedMedicine_medicationCatalogId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."DispensedMedicine"
    ADD CONSTRAINT "DispensedMedicine_medicationCatalogId_fkey" FOREIGN KEY ("medicationCatalogId") REFERENCES public."MedicationCatalog"(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: DispensedMedicine DispensedMedicine_medicationOrderId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."DispensedMedicine"
    ADD CONSTRAINT "DispensedMedicine_medicationOrderId_fkey" FOREIGN KEY ("medicationOrderId") REFERENCES public."MedicationOrder"(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: DispensedMedicine DispensedMedicine_pharmacyInvoiceId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."DispensedMedicine"
    ADD CONSTRAINT "DispensedMedicine_pharmacyInvoiceId_fkey" FOREIGN KEY ("pharmacyInvoiceId") REFERENCES public."PharmacyInvoice"(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: DoctorWalkInOrder DoctorWalkInOrder_doctorId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."DoctorWalkInOrder"
    ADD CONSTRAINT "DoctorWalkInOrder_doctorId_fkey" FOREIGN KEY ("doctorId") REFERENCES public."User"(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: DoctorWalkInOrder DoctorWalkInOrder_patientId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."DoctorWalkInOrder"
    ADD CONSTRAINT "DoctorWalkInOrder_patientId_fkey" FOREIGN KEY ("patientId") REFERENCES public."Patient"(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: DoctorWalkInOrder DoctorWalkInOrder_serviceId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."DoctorWalkInOrder"
    ADD CONSTRAINT "DoctorWalkInOrder_serviceId_fkey" FOREIGN KEY ("serviceId") REFERENCES public."Service"(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: DoctorWalkInOrder DoctorWalkInOrder_visitId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."DoctorWalkInOrder"
    ADD CONSTRAINT "DoctorWalkInOrder_visitId_fkey" FOREIGN KEY ("visitId") REFERENCES public."Visit"(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: EmergencyDrugOrder EmergencyDrugOrder_doctorId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."EmergencyDrugOrder"
    ADD CONSTRAINT "EmergencyDrugOrder_doctorId_fkey" FOREIGN KEY ("doctorId") REFERENCES public."User"(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: EmergencyDrugOrder EmergencyDrugOrder_patientId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."EmergencyDrugOrder"
    ADD CONSTRAINT "EmergencyDrugOrder_patientId_fkey" FOREIGN KEY ("patientId") REFERENCES public."Patient"(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: EmergencyDrugOrder EmergencyDrugOrder_serviceId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."EmergencyDrugOrder"
    ADD CONSTRAINT "EmergencyDrugOrder_serviceId_fkey" FOREIGN KEY ("serviceId") REFERENCES public."Service"(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: EmergencyDrugOrder EmergencyDrugOrder_visitId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."EmergencyDrugOrder"
    ADD CONSTRAINT "EmergencyDrugOrder_visitId_fkey" FOREIGN KEY ("visitId") REFERENCES public."Visit"(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: File File_batchOrderId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."File"
    ADD CONSTRAINT "File_batchOrderId_fkey" FOREIGN KEY ("batchOrderId") REFERENCES public."BatchOrder"(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: File File_labOrderId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."File"
    ADD CONSTRAINT "File_labOrderId_fkey" FOREIGN KEY ("labOrderId") REFERENCES public."LabOrder"(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: File File_patientId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."File"
    ADD CONSTRAINT "File_patientId_fkey" FOREIGN KEY ("patientId") REFERENCES public."Patient"(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: File File_radiologyOrderId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."File"
    ADD CONSTRAINT "File_radiologyOrderId_fkey" FOREIGN KEY ("radiologyOrderId") REFERENCES public."RadiologyOrder"(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: InsuranceTransaction InsuranceTransaction_insuranceId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."InsuranceTransaction"
    ADD CONSTRAINT "InsuranceTransaction_insuranceId_fkey" FOREIGN KEY ("insuranceId") REFERENCES public."Insurance"(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: InsuranceTransaction InsuranceTransaction_patientId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."InsuranceTransaction"
    ADD CONSTRAINT "InsuranceTransaction_patientId_fkey" FOREIGN KEY ("patientId") REFERENCES public."Patient"(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: InsuranceTransaction InsuranceTransaction_visitId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."InsuranceTransaction"
    ADD CONSTRAINT "InsuranceTransaction_visitId_fkey" FOREIGN KEY ("visitId") REFERENCES public."Visit"(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: InternationalMedicalCertificate InternationalMedicalCertificate_doctorId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."InternationalMedicalCertificate"
    ADD CONSTRAINT "InternationalMedicalCertificate_doctorId_fkey" FOREIGN KEY ("doctorId") REFERENCES public."User"(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: InternationalMedicalCertificate InternationalMedicalCertificate_patientId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."InternationalMedicalCertificate"
    ADD CONSTRAINT "InternationalMedicalCertificate_patientId_fkey" FOREIGN KEY ("patientId") REFERENCES public."Patient"(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: InternationalMedicalCertificate InternationalMedicalCertificate_visitId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."InternationalMedicalCertificate"
    ADD CONSTRAINT "InternationalMedicalCertificate_visitId_fkey" FOREIGN KEY ("visitId") REFERENCES public."Visit"(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: Inventory Inventory_serviceId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."Inventory"
    ADD CONSTRAINT "Inventory_serviceId_fkey" FOREIGN KEY ("serviceId") REFERENCES public."Service"(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: InvestigationType InvestigationType_serviceId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."InvestigationType"
    ADD CONSTRAINT "InvestigationType_serviceId_fkey" FOREIGN KEY ("serviceId") REFERENCES public."Service"(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: LabOrder LabOrder_doctorId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."LabOrder"
    ADD CONSTRAINT "LabOrder_doctorId_fkey" FOREIGN KEY ("doctorId") REFERENCES public."User"(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: LabOrder LabOrder_patientId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."LabOrder"
    ADD CONSTRAINT "LabOrder_patientId_fkey" FOREIGN KEY ("patientId") REFERENCES public."Patient"(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: LabOrder LabOrder_typeId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."LabOrder"
    ADD CONSTRAINT "LabOrder_typeId_fkey" FOREIGN KEY ("typeId") REFERENCES public."InvestigationType"(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: LabOrder LabOrder_visitId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."LabOrder"
    ADD CONSTRAINT "LabOrder_visitId_fkey" FOREIGN KEY ("visitId") REFERENCES public."Visit"(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: LabResultFile LabResultFile_resultId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."LabResultFile"
    ADD CONSTRAINT "LabResultFile_resultId_fkey" FOREIGN KEY ("resultId") REFERENCES public."LabResult"(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: LabResult LabResult_orderId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."LabResult"
    ADD CONSTRAINT "LabResult_orderId_fkey" FOREIGN KEY ("orderId") REFERENCES public."LabOrder"(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: LabResult LabResult_testTypeId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."LabResult"
    ADD CONSTRAINT "LabResult_testTypeId_fkey" FOREIGN KEY ("testTypeId") REFERENCES public."InvestigationType"(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: LabTestOrder LabTestOrder_batchOrderId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."LabTestOrder"
    ADD CONSTRAINT "LabTestOrder_batchOrderId_fkey" FOREIGN KEY ("batchOrderId") REFERENCES public."BatchOrder"(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: LabTestOrder LabTestOrder_doctorId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."LabTestOrder"
    ADD CONSTRAINT "LabTestOrder_doctorId_fkey" FOREIGN KEY ("doctorId") REFERENCES public."User"(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: LabTestOrder LabTestOrder_labTestId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."LabTestOrder"
    ADD CONSTRAINT "LabTestOrder_labTestId_fkey" FOREIGN KEY ("labTestId") REFERENCES public."LabTest"(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: LabTestOrder LabTestOrder_patientId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."LabTestOrder"
    ADD CONSTRAINT "LabTestOrder_patientId_fkey" FOREIGN KEY ("patientId") REFERENCES public."Patient"(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: LabTestOrder LabTestOrder_visitId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."LabTestOrder"
    ADD CONSTRAINT "LabTestOrder_visitId_fkey" FOREIGN KEY ("visitId") REFERENCES public."Visit"(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: LabTestResultField LabTestResultField_testId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."LabTestResultField"
    ADD CONSTRAINT "LabTestResultField_testId_fkey" FOREIGN KEY ("testId") REFERENCES public."LabTest"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: LabTestResultFile LabTestResultFile_resultId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."LabTestResultFile"
    ADD CONSTRAINT "LabTestResultFile_resultId_fkey" FOREIGN KEY ("resultId") REFERENCES public."LabTestResult"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: LabTestResult LabTestResult_orderId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."LabTestResult"
    ADD CONSTRAINT "LabTestResult_orderId_fkey" FOREIGN KEY ("orderId") REFERENCES public."LabTestOrder"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: LabTestResult LabTestResult_testId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."LabTestResult"
    ADD CONSTRAINT "LabTestResult_testId_fkey" FOREIGN KEY ("testId") REFERENCES public."LabTest"(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: LabTest LabTest_groupId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."LabTest"
    ADD CONSTRAINT "LabTest_groupId_fkey" FOREIGN KEY ("groupId") REFERENCES public."LabTestGroup"(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: LabTest LabTest_serviceId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."LabTest"
    ADD CONSTRAINT "LabTest_serviceId_fkey" FOREIGN KEY ("serviceId") REFERENCES public."Service"(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: Loan Loan_expenseId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."Loan"
    ADD CONSTRAINT "Loan_expenseId_fkey" FOREIGN KEY ("expenseId") REFERENCES public."CashExpense"(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: Loan Loan_givenById_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."Loan"
    ADD CONSTRAINT "Loan_givenById_fkey" FOREIGN KEY ("givenById") REFERENCES public."User"(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: Loan Loan_reviewedById_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."Loan"
    ADD CONSTRAINT "Loan_reviewedById_fkey" FOREIGN KEY ("reviewedById") REFERENCES public."User"(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: Loan Loan_settledById_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."Loan"
    ADD CONSTRAINT "Loan_settledById_fkey" FOREIGN KEY ("settledById") REFERENCES public."User"(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: Loan Loan_settlementAcceptedById_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."Loan"
    ADD CONSTRAINT "Loan_settlementAcceptedById_fkey" FOREIGN KEY ("settlementAcceptedById") REFERENCES public."User"(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: Loan Loan_staffId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."Loan"
    ADD CONSTRAINT "Loan_staffId_fkey" FOREIGN KEY ("staffId") REFERENCES public."User"(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: MaterialNeedsOrder MaterialNeedsOrder_nurseId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."MaterialNeedsOrder"
    ADD CONSTRAINT "MaterialNeedsOrder_nurseId_fkey" FOREIGN KEY ("nurseId") REFERENCES public."User"(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: MaterialNeedsOrder MaterialNeedsOrder_patientId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."MaterialNeedsOrder"
    ADD CONSTRAINT "MaterialNeedsOrder_patientId_fkey" FOREIGN KEY ("patientId") REFERENCES public."Patient"(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: MaterialNeedsOrder MaterialNeedsOrder_serviceId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."MaterialNeedsOrder"
    ADD CONSTRAINT "MaterialNeedsOrder_serviceId_fkey" FOREIGN KEY ("serviceId") REFERENCES public."Service"(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: MaterialNeedsOrder MaterialNeedsOrder_visitId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."MaterialNeedsOrder"
    ADD CONSTRAINT "MaterialNeedsOrder_visitId_fkey" FOREIGN KEY ("visitId") REFERENCES public."Visit"(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: MedicalCertificate MedicalCertificate_doctorId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."MedicalCertificate"
    ADD CONSTRAINT "MedicalCertificate_doctorId_fkey" FOREIGN KEY ("doctorId") REFERENCES public."User"(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: MedicalCertificate MedicalCertificate_patientId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."MedicalCertificate"
    ADD CONSTRAINT "MedicalCertificate_patientId_fkey" FOREIGN KEY ("patientId") REFERENCES public."Patient"(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: MedicalCertificate MedicalCertificate_visitId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."MedicalCertificate"
    ADD CONSTRAINT "MedicalCertificate_visitId_fkey" FOREIGN KEY ("visitId") REFERENCES public."Visit"(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: MedicalHistory MedicalHistory_appointmentId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."MedicalHistory"
    ADD CONSTRAINT "MedicalHistory_appointmentId_fkey" FOREIGN KEY ("appointmentId") REFERENCES public."Appointment"(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: MedicalHistory MedicalHistory_doctorId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."MedicalHistory"
    ADD CONSTRAINT "MedicalHistory_doctorId_fkey" FOREIGN KEY ("doctorId") REFERENCES public."User"(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: MedicalHistory MedicalHistory_patientId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."MedicalHistory"
    ADD CONSTRAINT "MedicalHistory_patientId_fkey" FOREIGN KEY ("patientId") REFERENCES public."Patient"(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: MedicalHistory MedicalHistory_visitId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."MedicalHistory"
    ADD CONSTRAINT "MedicalHistory_visitId_fkey" FOREIGN KEY ("visitId") REFERENCES public."Visit"(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: MedicationOrder MedicationOrder_doctorId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."MedicationOrder"
    ADD CONSTRAINT "MedicationOrder_doctorId_fkey" FOREIGN KEY ("doctorId") REFERENCES public."User"(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: MedicationOrder MedicationOrder_medicationCatalogId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."MedicationOrder"
    ADD CONSTRAINT "MedicationOrder_medicationCatalogId_fkey" FOREIGN KEY ("medicationCatalogId") REFERENCES public."MedicationCatalog"(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: MedicationOrder MedicationOrder_patientId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."MedicationOrder"
    ADD CONSTRAINT "MedicationOrder_patientId_fkey" FOREIGN KEY ("patientId") REFERENCES public."Patient"(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: MedicationOrder MedicationOrder_visitId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."MedicationOrder"
    ADD CONSTRAINT "MedicationOrder_visitId_fkey" FOREIGN KEY ("visitId") REFERENCES public."Visit"(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: NurseAdministration NurseAdministration_administeredById_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."NurseAdministration"
    ADD CONSTRAINT "NurseAdministration_administeredById_fkey" FOREIGN KEY ("administeredById") REFERENCES public."User"(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: NurseAdministration NurseAdministration_continuousInfusionId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."NurseAdministration"
    ADD CONSTRAINT "NurseAdministration_continuousInfusionId_fkey" FOREIGN KEY ("continuousInfusionId") REFERENCES public."ContinuousInfusion"(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: NurseServiceAssignment NurseServiceAssignment_assignedById_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."NurseServiceAssignment"
    ADD CONSTRAINT "NurseServiceAssignment_assignedById_fkey" FOREIGN KEY ("assignedById") REFERENCES public."User"(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: NurseServiceAssignment NurseServiceAssignment_assignedNurseId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."NurseServiceAssignment"
    ADD CONSTRAINT "NurseServiceAssignment_assignedNurseId_fkey" FOREIGN KEY ("assignedNurseId") REFERENCES public."User"(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: NurseServiceAssignment NurseServiceAssignment_serviceId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."NurseServiceAssignment"
    ADD CONSTRAINT "NurseServiceAssignment_serviceId_fkey" FOREIGN KEY ("serviceId") REFERENCES public."Service"(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: NurseServiceAssignment NurseServiceAssignment_visitId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."NurseServiceAssignment"
    ADD CONSTRAINT "NurseServiceAssignment_visitId_fkey" FOREIGN KEY ("visitId") REFERENCES public."Visit"(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: NurseWalkInOrder NurseWalkInOrder_nurseId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."NurseWalkInOrder"
    ADD CONSTRAINT "NurseWalkInOrder_nurseId_fkey" FOREIGN KEY ("nurseId") REFERENCES public."User"(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: NurseWalkInOrder NurseWalkInOrder_patientId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."NurseWalkInOrder"
    ADD CONSTRAINT "NurseWalkInOrder_patientId_fkey" FOREIGN KEY ("patientId") REFERENCES public."Patient"(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: NurseWalkInOrder NurseWalkInOrder_serviceId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."NurseWalkInOrder"
    ADD CONSTRAINT "NurseWalkInOrder_serviceId_fkey" FOREIGN KEY ("serviceId") REFERENCES public."Service"(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: NurseWalkInOrder NurseWalkInOrder_visitId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."NurseWalkInOrder"
    ADD CONSTRAINT "NurseWalkInOrder_visitId_fkey" FOREIGN KEY ("visitId") REFERENCES public."Visit"(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: PatientAccount PatientAccount_patientId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."PatientAccount"
    ADD CONSTRAINT "PatientAccount_patientId_fkey" FOREIGN KEY ("patientId") REFERENCES public."Patient"(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: PatientAccount PatientAccount_verifiedById_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."PatientAccount"
    ADD CONSTRAINT "PatientAccount_verifiedById_fkey" FOREIGN KEY ("verifiedById") REFERENCES public."User"(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: PatientAttachedImage PatientAttachedImage_doctorId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."PatientAttachedImage"
    ADD CONSTRAINT "PatientAttachedImage_doctorId_fkey" FOREIGN KEY ("doctorId") REFERENCES public."User"(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: PatientAttachedImage PatientAttachedImage_patientId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."PatientAttachedImage"
    ADD CONSTRAINT "PatientAttachedImage_patientId_fkey" FOREIGN KEY ("patientId") REFERENCES public."Patient"(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: PatientAttachedImage PatientAttachedImage_visitId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."PatientAttachedImage"
    ADD CONSTRAINT "PatientAttachedImage_visitId_fkey" FOREIGN KEY ("visitId") REFERENCES public."Visit"(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: PatientDiagnosis PatientDiagnosis_diseaseId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."PatientDiagnosis"
    ADD CONSTRAINT "PatientDiagnosis_diseaseId_fkey" FOREIGN KEY ("diseaseId") REFERENCES public."Disease"(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: PatientDiagnosis PatientDiagnosis_doctorId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."PatientDiagnosis"
    ADD CONSTRAINT "PatientDiagnosis_doctorId_fkey" FOREIGN KEY ("doctorId") REFERENCES public."User"(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: PatientDiagnosis PatientDiagnosis_patientId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."PatientDiagnosis"
    ADD CONSTRAINT "PatientDiagnosis_patientId_fkey" FOREIGN KEY ("patientId") REFERENCES public."Patient"(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: PatientDiagnosis PatientDiagnosis_visitId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."PatientDiagnosis"
    ADD CONSTRAINT "PatientDiagnosis_visitId_fkey" FOREIGN KEY ("visitId") REFERENCES public."Visit"(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: PatientGallery PatientGallery_patientId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."PatientGallery"
    ADD CONSTRAINT "PatientGallery_patientId_fkey" FOREIGN KEY ("patientId") REFERENCES public."Patient"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: PatientGallery PatientGallery_uploadedById_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."PatientGallery"
    ADD CONSTRAINT "PatientGallery_uploadedById_fkey" FOREIGN KEY ("uploadedById") REFERENCES public."User"(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: PatientGallery PatientGallery_visitId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."PatientGallery"
    ADD CONSTRAINT "PatientGallery_visitId_fkey" FOREIGN KEY ("visitId") REFERENCES public."Visit"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: Patient Patient_insuranceId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."Patient"
    ADD CONSTRAINT "Patient_insuranceId_fkey" FOREIGN KEY ("insuranceId") REFERENCES public."Insurance"(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: PharmacyInvoiceItem PharmacyInvoiceItem_medicationCatalogId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."PharmacyInvoiceItem"
    ADD CONSTRAINT "PharmacyInvoiceItem_medicationCatalogId_fkey" FOREIGN KEY ("medicationCatalogId") REFERENCES public."MedicationCatalog"(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: PharmacyInvoiceItem PharmacyInvoiceItem_medicationOrderId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."PharmacyInvoiceItem"
    ADD CONSTRAINT "PharmacyInvoiceItem_medicationOrderId_fkey" FOREIGN KEY ("medicationOrderId") REFERENCES public."MedicationOrder"(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: PharmacyInvoiceItem PharmacyInvoiceItem_pharmacyInvoiceId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."PharmacyInvoiceItem"
    ADD CONSTRAINT "PharmacyInvoiceItem_pharmacyInvoiceId_fkey" FOREIGN KEY ("pharmacyInvoiceId") REFERENCES public."PharmacyInvoice"(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: PharmacyInvoice PharmacyInvoice_patientId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."PharmacyInvoice"
    ADD CONSTRAINT "PharmacyInvoice_patientId_fkey" FOREIGN KEY ("patientId") REFERENCES public."Patient"(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: PharmacyInvoice PharmacyInvoice_visitId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."PharmacyInvoice"
    ADD CONSTRAINT "PharmacyInvoice_visitId_fkey" FOREIGN KEY ("visitId") REFERENCES public."Visit"(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: RadiologyOrder RadiologyOrder_doctorId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."RadiologyOrder"
    ADD CONSTRAINT "RadiologyOrder_doctorId_fkey" FOREIGN KEY ("doctorId") REFERENCES public."User"(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: RadiologyOrder RadiologyOrder_patientId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."RadiologyOrder"
    ADD CONSTRAINT "RadiologyOrder_patientId_fkey" FOREIGN KEY ("patientId") REFERENCES public."Patient"(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: RadiologyOrder RadiologyOrder_typeId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."RadiologyOrder"
    ADD CONSTRAINT "RadiologyOrder_typeId_fkey" FOREIGN KEY ("typeId") REFERENCES public."InvestigationType"(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: RadiologyOrder RadiologyOrder_visitId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."RadiologyOrder"
    ADD CONSTRAINT "RadiologyOrder_visitId_fkey" FOREIGN KEY ("visitId") REFERENCES public."Visit"(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: RadiologyResultFile RadiologyResultFile_resultId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."RadiologyResultFile"
    ADD CONSTRAINT "RadiologyResultFile_resultId_fkey" FOREIGN KEY ("resultId") REFERENCES public."RadiologyResult"(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: RadiologyResult RadiologyResult_batchOrderId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."RadiologyResult"
    ADD CONSTRAINT "RadiologyResult_batchOrderId_fkey" FOREIGN KEY ("batchOrderId") REFERENCES public."BatchOrder"(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: RadiologyResult RadiologyResult_orderId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."RadiologyResult"
    ADD CONSTRAINT "RadiologyResult_orderId_fkey" FOREIGN KEY ("orderId") REFERENCES public."RadiologyOrder"(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: RadiologyResult RadiologyResult_testTypeId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."RadiologyResult"
    ADD CONSTRAINT "RadiologyResult_testTypeId_fkey" FOREIGN KEY ("testTypeId") REFERENCES public."InvestigationType"(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: RadiologyTemplate RadiologyTemplate_investigationTypeId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."RadiologyTemplate"
    ADD CONSTRAINT "RadiologyTemplate_investigationTypeId_fkey" FOREIGN KEY ("investigationTypeId") REFERENCES public."InvestigationType"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: Referral Referral_doctorId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."Referral"
    ADD CONSTRAINT "Referral_doctorId_fkey" FOREIGN KEY ("doctorId") REFERENCES public."User"(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: Referral Referral_patientId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."Referral"
    ADD CONSTRAINT "Referral_patientId_fkey" FOREIGN KEY ("patientId") REFERENCES public."Patient"(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: Referral Referral_visitId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."Referral"
    ADD CONSTRAINT "Referral_visitId_fkey" FOREIGN KEY ("visitId") REFERENCES public."Visit"(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: SystemSettings SystemSettings_updatedById_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."SystemSettings"
    ADD CONSTRAINT "SystemSettings_updatedById_fkey" FOREIGN KEY ("updatedById") REFERENCES public."User"(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: VirtualQueue VirtualQueue_patientId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."VirtualQueue"
    ADD CONSTRAINT "VirtualQueue_patientId_fkey" FOREIGN KEY ("patientId") REFERENCES public."Patient"(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: Visit Visit_createdById_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."Visit"
    ADD CONSTRAINT "Visit_createdById_fkey" FOREIGN KEY ("createdById") REFERENCES public."User"(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: Visit Visit_patientId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."Visit"
    ADD CONSTRAINT "Visit_patientId_fkey" FOREIGN KEY ("patientId") REFERENCES public."Patient"(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: VitalSign VitalSign_patientId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."VitalSign"
    ADD CONSTRAINT "VitalSign_patientId_fkey" FOREIGN KEY ("patientId") REFERENCES public."Patient"(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: VitalSign VitalSign_visitId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."VitalSign"
    ADD CONSTRAINT "VitalSign_visitId_fkey" FOREIGN KEY ("visitId") REFERENCES public."Visit"(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- PostgreSQL database dump complete
--

\unrestrict 9WbhatwXflEpGH8kRYCS0ieth8VgU8RbNdzrXheJ3alKvPdgw44Yaad0iE3RUF6

