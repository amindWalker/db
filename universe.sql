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

DROP DATABASE universe;
--
-- Name: universe; Type: DATABASE; Schema: -; Owner: freecodecamp
--

CREATE DATABASE universe WITH TEMPLATE = template0 ENCODING = 'UTF8' LC_COLLATE = 'C.UTF-8' LC_CTYPE = 'C.UTF-8';


ALTER DATABASE universe OWNER TO freecodecamp;

\connect universe

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
-- Name: black_hole; Type: TABLE; Schema: public; Owner: freecodecamp
--

CREATE TABLE public.black_hole (
    black_hole_id integer NOT NULL,
    name character varying(64) NOT NULL,
    description text NOT NULL,
    emit_radiation boolean,
    size integer,
    gavity integer,
    galaxy_id integer
);


ALTER TABLE public.black_hole OWNER TO freecodecamp;

--
-- Name: black_hole_black_hole_id_seq; Type: SEQUENCE; Schema: public; Owner: freecodecamp
--

CREATE SEQUENCE public.black_hole_black_hole_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.black_hole_black_hole_id_seq OWNER TO freecodecamp;

--
-- Name: black_hole_black_hole_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: freecodecamp
--

ALTER SEQUENCE public.black_hole_black_hole_id_seq OWNED BY public.black_hole.black_hole_id;


--
-- Name: galaxy; Type: TABLE; Schema: public; Owner: freecodecamp
--

CREATE TABLE public.galaxy (
    galaxy_id integer NOT NULL,
    name character varying(64) NOT NULL,
    description text NOT NULL,
    has_life boolean,
    size integer,
    temperature integer,
    distance_in_light_year numeric
);


ALTER TABLE public.galaxy OWNER TO freecodecamp;

--
-- Name: galaxy_galaxy_id_seq; Type: SEQUENCE; Schema: public; Owner: freecodecamp
--

CREATE SEQUENCE public.galaxy_galaxy_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.galaxy_galaxy_id_seq OWNER TO freecodecamp;

--
-- Name: galaxy_galaxy_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: freecodecamp
--

ALTER SEQUENCE public.galaxy_galaxy_id_seq OWNED BY public.galaxy.galaxy_id;


--
-- Name: moon; Type: TABLE; Schema: public; Owner: freecodecamp
--

CREATE TABLE public.moon (
    moon_id integer NOT NULL,
    name character varying(64) NOT NULL,
    description text NOT NULL,
    has_life boolean,
    size integer,
    gravity integer,
    planet_id integer
);


ALTER TABLE public.moon OWNER TO freecodecamp;

--
-- Name: moon_moon_id_seq; Type: SEQUENCE; Schema: public; Owner: freecodecamp
--

CREATE SEQUENCE public.moon_moon_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.moon_moon_id_seq OWNER TO freecodecamp;

--
-- Name: moon_moon_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: freecodecamp
--

ALTER SEQUENCE public.moon_moon_id_seq OWNED BY public.moon.moon_id;


--
-- Name: planet; Type: TABLE; Schema: public; Owner: freecodecamp
--

CREATE TABLE public.planet (
    planet_id integer NOT NULL,
    name character varying(64) NOT NULL,
    description text NOT NULL,
    has_life boolean,
    size integer,
    mass numeric,
    star_id integer
);


ALTER TABLE public.planet OWNER TO freecodecamp;

--
-- Name: planet_planet_id_seq; Type: SEQUENCE; Schema: public; Owner: freecodecamp
--

CREATE SEQUENCE public.planet_planet_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.planet_planet_id_seq OWNER TO freecodecamp;

--
-- Name: planet_planet_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: freecodecamp
--

ALTER SEQUENCE public.planet_planet_id_seq OWNED BY public.planet.planet_id;


--
-- Name: star; Type: TABLE; Schema: public; Owner: freecodecamp
--

CREATE TABLE public.star (
    star_id integer NOT NULL,
    name character varying(64) NOT NULL,
    description text NOT NULL,
    has_life boolean,
    size integer,
    temperature integer,
    mass numeric,
    galaxy_id integer
);


ALTER TABLE public.star OWNER TO freecodecamp;

--
-- Name: star_star_id_seq; Type: SEQUENCE; Schema: public; Owner: freecodecamp
--

CREATE SEQUENCE public.star_star_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.star_star_id_seq OWNER TO freecodecamp;

--
-- Name: star_star_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: freecodecamp
--

ALTER SEQUENCE public.star_star_id_seq OWNED BY public.star.star_id;


--
-- Name: black_hole black_hole_id; Type: DEFAULT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.black_hole ALTER COLUMN black_hole_id SET DEFAULT nextval('public.black_hole_black_hole_id_seq'::regclass);


--
-- Name: galaxy galaxy_id; Type: DEFAULT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.galaxy ALTER COLUMN galaxy_id SET DEFAULT nextval('public.galaxy_galaxy_id_seq'::regclass);


--
-- Name: moon moon_id; Type: DEFAULT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.moon ALTER COLUMN moon_id SET DEFAULT nextval('public.moon_moon_id_seq'::regclass);


--
-- Name: planet planet_id; Type: DEFAULT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.planet ALTER COLUMN planet_id SET DEFAULT nextval('public.planet_planet_id_seq'::regclass);


--
-- Name: star star_id; Type: DEFAULT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.star ALTER COLUMN star_id SET DEFAULT nextval('public.star_star_id_seq'::regclass);


--
-- Data for Name: black_hole; Type: TABLE DATA; Schema: public; Owner: freecodecamp
--

INSERT INTO public.black_hole VALUES (7, 'Black Hole 1', 'A massive black hole at the center of the galaxy', true, 500, 2000, 1);
INSERT INTO public.black_hole VALUES (8, 'Black Hole 2', 'A supermassive black hole with intense gravitational pull', false, 1000, 3000, 2);
INSERT INTO public.black_hole VALUES (9, 'Black Hole 3', 'A dormant black hole in a distant galaxy', true, 300, 1500, 1);


--
-- Data for Name: galaxy; Type: TABLE DATA; Schema: public; Owner: freecodecamp
--

INSERT INTO public.galaxy VALUES (1, 'Milky Way', 'Our home galaxy', true, 5000, 20, 100000);
INSERT INTO public.galaxy VALUES (2, 'Andromeda', 'A spiral galaxy neighboring the Milky Way', false, 7000, 15, 120000);
INSERT INTO public.galaxy VALUES (3, 'Whirlpool', 'A beautiful galaxy with distinct spiral arms', false, 3000, 25, 80000);
INSERT INTO public.galaxy VALUES (7, 'Pinwheel', 'A face-on spiral galaxy in the constellation Ursa Major', false, 550, 75000, 2.012);
INSERT INTO public.galaxy VALUES (8, 'Black Eye', 'A galaxy with a distinctive dark band of dust', false, 300, 65000, 1.723);
INSERT INTO public.galaxy VALUES (9, 'Cigar', 'An elongated galaxy with a cigar-like shape', false, 250, 60000, 1.402);


--
-- Data for Name: moon; Type: TABLE DATA; Schema: public; Owner: freecodecamp
--

INSERT INTO public.moon VALUES (41, 'Io', 'One of Jupiter''s four largest moons', false, 25, 2, 15);
INSERT INTO public.moon VALUES (42, 'Europa', 'One of Jupiter''s moons, believed to have a subsurface ocean', false, 30, 1, 19);
INSERT INTO public.moon VALUES (43, 'Phobos II', 'The smaller and outer moon of Mars', false, 5, 0, 20);
INSERT INTO public.moon VALUES (44, 'Deimos', 'The smaller and outer moon of Mars', false, 8, 0, 24);
INSERT INTO public.moon VALUES (45, 'Hyperion', 'An irregularly shaped moon of Saturn', false, 12, 0, 23);
INSERT INTO public.moon VALUES (46, 'Luna', 'Earth''s moon', false, 22, 2, 13);
INSERT INTO public.moon VALUES (47, 'Enceladus', 'A moon of Saturn with subsurface water geysers', false, 18, 0, 23);
INSERT INTO public.moon VALUES (48, 'Phoebe', 'An irregular moon of Saturn with a retrograde orbit', false, 15, 0, 23);
INSERT INTO public.moon VALUES (49, 'Rhea', 'A moon of Saturn with a heavily cratered surface', false, 20, 0, 23);
INSERT INTO public.moon VALUES (50, 'Mimas', 'A small moon of Saturn with a large impact crater', false, 10, 0, 22);
INSERT INTO public.moon VALUES (51, 'Oberon', 'The outermost of Uranus''s five major moons', false, 18, 0, 24);
INSERT INTO public.moon VALUES (52, 'Titania', 'The largest moon of Uranus', false, 25, 0, 14);
INSERT INTO public.moon VALUES (53, 'Nereid', 'A moon of Neptune with an eccentric orbit', false, 15, 0, 22);
INSERT INTO public.moon VALUES (54, 'Proteus', 'The second-largest moon of Neptune', false, 20, 0, 24);
INSERT INTO public.moon VALUES (55, 'Charon', 'The largest moon of Pluto', false, 15, 0, 23);
INSERT INTO public.moon VALUES (56, 'Styx', 'One of Pluto''s five known moons', false, 8, 0, 22);
INSERT INTO public.moon VALUES (57, 'Nix', 'A small moon of Pluto', false, 10, 0, 13);
INSERT INTO public.moon VALUES (58, 'Kerberos', 'A moon of Pluto discovered in 2011', false, 8, 0, 22);
INSERT INTO public.moon VALUES (59, 'Hydra', 'A moon of Pluto discovered in 2005', false, 10, 0, 22);
INSERT INTO public.moon VALUES (60, 'Miranda II', 'A moon of Uranus', false, 8, 0, 13);


--
-- Data for Name: planet; Type: TABLE DATA; Schema: public; Owner: freecodecamp
--

INSERT INTO public.planet VALUES (13, 'Venus', 'The second planet from the Sun', false, 90, 4.87, 1);
INSERT INTO public.planet VALUES (14, 'Mercury', 'The closest planet to the Sun', false, 60, 0.33, 1);
INSERT INTO public.planet VALUES (15, 'Saturn', 'A gas giant known for its prominent rings', false, 400, 568, 2);
INSERT INTO public.planet VALUES (16, 'Neptune', 'A blue gas giant located farthest from the Sun', false, 350, 1024, 2);
INSERT INTO public.planet VALUES (17, 'Pluto', 'A dwarf planet in our solar system', false, 30, 0.0146, 1);
INSERT INTO public.planet VALUES (18, 'Uranus', 'A gas giant tilted on its side', false, 300, 868, 3);
INSERT INTO public.planet VALUES (19, 'Mars II', 'A moon of Mars', false, 15, 0.0082, 2);
INSERT INTO public.planet VALUES (20, 'Ganymede', 'The largest moon in the solar system', false, 35, 0.0248, 3);
INSERT INTO public.planet VALUES (21, 'Titan', 'The largest moon of Saturn', false, 40, 0.0225, 3);
INSERT INTO public.planet VALUES (22, 'Callisto', 'One of Jupiter''s largest moons', false, 30, 0.0189, 3);
INSERT INTO public.planet VALUES (23, 'Miranda', 'A moon of Uranus with a fragmented surface', false, 10, 0.000659, 3);
INSERT INTO public.planet VALUES (24, 'Triton', 'A moon of Neptune with geysers on its surface', false, 25, 0.00358, 3);


--
-- Data for Name: star; Type: TABLE DATA; Schema: public; Owner: freecodecamp
--

INSERT INTO public.star VALUES (1, 'Sun', 'The star at the center of our solar system', false, 1000, 5500, 1.98, 1);
INSERT INTO public.star VALUES (2, 'Sirius', 'The brightest star in the night sky', false, 2000, 9800, 2.12, 1);
INSERT INTO public.star VALUES (3, 'Betelgeuse', 'A red supergiant star in the constellation Orion', false, 5000, 3500, 15.2, 2);
INSERT INTO public.star VALUES (7, 'Alpha Centauri', 'A triple star system nearest to the Solar System', false, 80, 5790, 2.17, 1);
INSERT INTO public.star VALUES (8, 'Antares', 'A red supergiant star in the constellation Scorpius', false, 200, 3600, 15, 2);
INSERT INTO public.star VALUES (9, 'Deneb', 'One of the brightest stars visible in the night sky', false, 150, 8525, 19.3, 3);


--
-- Name: black_hole_black_hole_id_seq; Type: SEQUENCE SET; Schema: public; Owner: freecodecamp
--

SELECT pg_catalog.setval('public.black_hole_black_hole_id_seq', 9, true);


--
-- Name: galaxy_galaxy_id_seq; Type: SEQUENCE SET; Schema: public; Owner: freecodecamp
--

SELECT pg_catalog.setval('public.galaxy_galaxy_id_seq', 9, true);


--
-- Name: moon_moon_id_seq; Type: SEQUENCE SET; Schema: public; Owner: freecodecamp
--

SELECT pg_catalog.setval('public.moon_moon_id_seq', 60, true);


--
-- Name: planet_planet_id_seq; Type: SEQUENCE SET; Schema: public; Owner: freecodecamp
--

SELECT pg_catalog.setval('public.planet_planet_id_seq', 24, true);


--
-- Name: star_star_id_seq; Type: SEQUENCE SET; Schema: public; Owner: freecodecamp
--

SELECT pg_catalog.setval('public.star_star_id_seq', 9, true);


--
-- Name: black_hole black_hole_name_key; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.black_hole
    ADD CONSTRAINT black_hole_name_key UNIQUE (name);


--
-- Name: black_hole black_hole_pkey; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.black_hole
    ADD CONSTRAINT black_hole_pkey PRIMARY KEY (black_hole_id);


--
-- Name: galaxy galaxy_name_key; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.galaxy
    ADD CONSTRAINT galaxy_name_key UNIQUE (name);


--
-- Name: galaxy galaxy_pkey; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.galaxy
    ADD CONSTRAINT galaxy_pkey PRIMARY KEY (galaxy_id);


--
-- Name: moon moon_name_key; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.moon
    ADD CONSTRAINT moon_name_key UNIQUE (name);


--
-- Name: moon moon_pkey; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.moon
    ADD CONSTRAINT moon_pkey PRIMARY KEY (moon_id);


--
-- Name: planet name; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.planet
    ADD CONSTRAINT name UNIQUE (name);


--
-- Name: planet planet_pkey; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.planet
    ADD CONSTRAINT planet_pkey PRIMARY KEY (planet_id);


--
-- Name: star star_name_key; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.star
    ADD CONSTRAINT star_name_key UNIQUE (name);


--
-- Name: star star_pkey; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.star
    ADD CONSTRAINT star_pkey PRIMARY KEY (star_id);


--
-- Name: black_hole black_hole_galaxy_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.black_hole
    ADD CONSTRAINT black_hole_galaxy_id_fkey FOREIGN KEY (galaxy_id) REFERENCES public.galaxy(galaxy_id);


--
-- Name: moon moon_planet_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.moon
    ADD CONSTRAINT moon_planet_id_fkey FOREIGN KEY (planet_id) REFERENCES public.planet(planet_id);


--
-- Name: planet planet_star_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.planet
    ADD CONSTRAINT planet_star_id_fkey FOREIGN KEY (star_id) REFERENCES public.star(star_id);


--
-- Name: star star_galaxy_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.star
    ADD CONSTRAINT star_galaxy_id_fkey FOREIGN KEY (galaxy_id) REFERENCES public.galaxy(galaxy_id);


--
-- PostgreSQL database dump complete
--

