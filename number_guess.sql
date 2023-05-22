--
-- PostgreSQL database dump
--

-- Dumped from database version 12.9 (Ubuntu 12.9-2.pgdg20.04+1)
-- Dumped by pg_dump version 12.9 (Ubuntu 12.9-2.pgdg20.04+1)

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

DROP DATABASE guess;
--
-- Name: guess; Type: DATABASE; Schema: -; Owner: freecodecamp
--

CREATE DATABASE guess WITH TEMPLATE = template0 ENCODING = 'UTF8' LC_COLLATE = 'C.UTF-8' LC_CTYPE = 'C.UTF-8';


ALTER DATABASE guess OWNER TO freecodecamp;

\connect guess

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

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: game_data; Type: TABLE; Schema: public; Owner: freecodecamp
--

CREATE TABLE public.game_data (
    username character varying(22),
    games_played integer,
    best_game integer
);


ALTER TABLE public.game_data OWNER TO freecodecamp;

--
-- Data for Name: game_data; Type: TABLE DATA; Schema: public; Owner: freecodecamp
--

INSERT INTO public.game_data VALUES ('user_1684748049552', 2, 428);
INSERT INTO public.game_data VALUES ('user_1684748049553', 5, 162);


--
-- PostgreSQL database dump complete
--

