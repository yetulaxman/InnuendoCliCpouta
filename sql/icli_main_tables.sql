CREATE TABLE users(
  user_id SERIAL PRIMARY KEY,
  username VARCHAR(50) UNIQUE NOT NULL,
  lastname VARCHAR(255) NOT NULL,
  firstname VARCHAR(255) NOT NULL,
  organization VARCHAR(50) NOT NULL,
  email VARCHAR(120) NOT NULL
);

CREATE TABLE reads(
  read_id SERIAL PRIMARY KEY,
  file1_filename VARCHAR(255) NOT NULL,
  file1_md5 VARCHAR(255) NOT NULL,
  file2_filename VARCHAR(255) NOT NULL,
  file2_md5 VARCHAR(255) NOT NULL,
  accession VARCHAR(255),
  instrument VARCHAR(255),
  library VARCHAR(255),
  library_other VARCHAR(255)
);

CREATE TABLE runs(
  run_id SERIAL PRIMARY KEY,
  user_id INT,
  sample_id INT,
  read_id INT,
  submitter_sample INT,
  submitter_database INT,
  starttime TIMESTAMP,
  active BOOLEAN,
  FOREIGN KEY (user_id)
    REFERENCES users (user_id)
);

CREATE TABLE samples(
  sample_id SERIAL PRIMARY KEY,
  pipeline_species VARCHAR(255) NOT NULL,
  primary_identifier VARCHAR(255) UNIQUE NOT NULL,
  case_id_type VARCHAR(255) NOT NULL,
  case_id_number INT,
  source_category VARCHAR(255) NOT NULL,
  source_species VARCHAR(255),
  sampling_reason VARCHAR(255),
  sampling_date_year SMALLINT,
  sampling_date_month SMALLINT,
  sampling_date_day SMALLINT,
  sample_received_date_year SMALLINT,
  sample_received_date_month SMALLINT,
  sample_received_date_day SMALLINT,
  owner_institute VARCHAR(255)  NOT NULL,
  owner_collection VARCHAR(255),
  location VARCHAR(255) NOT NULL,
  amr_phenotype VARCHAR(255),
  additional_information TEXT
);

CREATE TABLE software(
  software_id SERIAL PRIMARY KEY,
  container     VARCHAR(255) NOT NULL,
  time TIMESTAMP,
  software TEXT
);


