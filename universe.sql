CREATE DATABASE universe;
\c universe

-- ---------- TABLES ----------

CREATE TABLE galaxy (
    galaxy_id SERIAL PRIMARY KEY,
    name VARCHAR(60) NOT NULL UNIQUE,
    galaxy_type VARCHAR(40) NOT NULL,
    age_in_millions_of_years INT,
    distance_from_earth_mly NUMERIC(10,2),
    has_active_nucleus BOOLEAN,
    description TEXT
);

CREATE TABLE star (
    star_id SERIAL PRIMARY KEY,
    name VARCHAR(60) NOT NULL UNIQUE,
    galaxy_id INT NOT NULL REFERENCES galaxy(galaxy_id),
    age_in_millions_of_years INT,
    temperature_kelvin INT,
    mass_in_solar_masses NUMERIC(8,2),
    is_spherical BOOLEAN,
    has_planets BOOLEAN
);

CREATE TABLE planet (
    planet_id SERIAL PRIMARY KEY,
    name VARCHAR(60) NOT NULL UNIQUE,
    star_id INT NOT NULL REFERENCES star(star_id),
    has_life BOOLEAN,
    is_spherical BOOLEAN,
    diameter_km INT,
    distance_from_star_au NUMERIC(8,3),
    description TEXT
);

CREATE TABLE moon (
    moon_id SERIAL PRIMARY KEY,
    name VARCHAR(60) NOT NULL UNIQUE,
    planet_id INT NOT NULL REFERENCES planet(planet_id),
    is_spherical BOOLEAN,
    diameter_km INT NOT NULL,
    orbital_period_days NUMERIC(8,3)
);

CREATE TABLE constellation (
    constellation_id SERIAL PRIMARY KEY,
    name VARCHAR(60) NOT NULL UNIQUE,
    abbreviation VARCHAR(3) NOT NULL,
    is_zodiac BOOLEAN,
    brightest_star TEXT
);

-- ---------- DATA (values are approximate) ----------

INSERT INTO galaxy (name, galaxy_type, age_in_millions_of_years, distance_from_earth_mly, has_active_nucleus, description) VALUES
('Milky Way', 'Barred spiral', 13600, 0.03, false, 'Our home galaxy'),
('Andromeda', 'Spiral', 10000, 2.54, false, 'Nearest large galaxy to the Milky Way'),
('Triangulum', 'Spiral', 10000, 2.73, false, 'Third largest galaxy in the Local Group'),
('Large Magellanic Cloud', 'Irregular', 13000, 0.16, false, 'Satellite galaxy of the Milky Way'),
('Whirlpool', 'Spiral', 400, 23.16, true, 'Interacting grand-design spiral galaxy'),
('Sombrero', 'Lenticular', 9000, 29.30, true, 'Known for its bright nucleus and dust lane');

INSERT INTO star (name, galaxy_id, age_in_millions_of_years, temperature_kelvin, mass_in_solar_masses, is_spherical, has_planets) VALUES
('Sun', 1, 4600, 5772, 1.00, true, true),
('Proxima Centauri', 1, 4850, 3042, 0.12, true, true),
('Alpha Centauri A', 1, 5300, 5790, 1.10, true, true),
('Sirius', 1, 242, 9940, 2.06, true, true),
('Betelgeuse', 1, 10, 3600, 16.50, true, false),
('Rigel', 1, 8, 12100, 21.00, true, false),
('S Doradus', 4, 5, 8500, 40.00, true, false),
('AE Andromedae', 2, 3, 12000, 40.00, true, false);

INSERT INTO planet (name, star_id, has_life, is_spherical, diameter_km, distance_from_star_au, description) VALUES
('Mercury', 1, false, true, 4879, 0.387, 'Smallest planet in the Solar System'),
('Venus', 1, false, true, 12104, 0.723, 'Hottest planet in the Solar System'),
('Earth', 1, true, true, 12742, 1.000, 'The only known planet with life'),
('Mars', 1, false, true, 6779, 1.524, 'The red planet'),
('Jupiter', 1, false, true, 139820, 5.203, 'Largest planet in the Solar System'),
('Saturn', 1, false, true, 116460, 9.537, 'Famous for its rings'),
('Uranus', 1, false, true, 50724, 19.191, 'Ice giant that rotates on its side'),
('Neptune', 1, false, true, 49244, 30.069, 'Farthest known planet from the Sun'),
('Proxima b', 2, false, true, 13600, 0.049, 'Exoplanet in the habitable zone of Proxima Centauri'),
('Proxima d', 2, false, true, 8500, 0.029, 'Candidate exoplanet close to Proxima Centauri'),
('Alpha Centauri A b', 3, false, true, 15000, 1.100, 'Hypothetical planet candidate'),
('Sirius Prime', 4, false, true, 12000, 2.000, 'Hypothetical planet');

INSERT INTO moon (name, planet_id, is_spherical, diameter_km, orbital_period_days) VALUES
('Moon', 3, true, 3474, 27.322),
('Phobos', 4, false, 22, 0.319),
('Deimos', 4, false, 12, 1.263),
('Io', 5, true, 3643, 1.769),
('Europa', 5, true, 3122, 3.551),
('Ganymede', 5, true, 5268, 7.155),
('Callisto', 5, true, 4821, 16.689),
('Amalthea', 5, false, 167, 0.498),
('Titan', 6, true, 5150, 15.945),
('Enceladus', 6, true, 504, 1.370),
('Mimas', 6, true, 396, 0.942),
('Rhea', 6, true, 1527, 4.518),
('Dione', 6, true, 1123, 2.737),
('Tethys', 6, true, 1062, 1.888),
('Iapetus', 6, true, 1469, 79.322),
('Titania', 7, true, 1578, 8.706),
('Oberon', 7, true, 1523, 13.463),
('Miranda', 7, true, 472, 1.413),
('Ariel', 7, true, 1158, 2.520),
('Umbriel', 7, true, 1169, 4.144),
('Triton', 8, true, 2707, 5.877),
('Nereid', 8, false, 340, 360.131);

INSERT INTO constellation (name, abbreviation, is_zodiac, brightest_star) VALUES
('Orion', 'Ori', false, 'Rigel'),
('Canis Major', 'CMa', false, 'Sirius'),
('Scorpius', 'Sco', true, 'Antares'),
('Leo', 'Leo', true, 'Regulus');
