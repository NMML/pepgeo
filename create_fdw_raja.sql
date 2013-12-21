CREATE EXTENSION oracle_fdw;

CREATE SERVER raja FOREIGN DATA WRAPPER oracle_fdw
          OPTIONS (dbserver '//161.55.120.29:1521/afsc');

GRANT USAGE ON FOREIGN SERVER raja TO "londonj";

CREATE USER MAPPING FOR "londonj" SERVER raja
          OPTIONS (user 'londonj', password <pwd>);