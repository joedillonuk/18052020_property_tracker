DROP TABLE IF EXISTS property_tracker;
CREATE TABLE property_tracker (

  id SERIAL PRIMARY KEY,
  address VARCHAR(255),
  value INT,
  num_bedrooms INT,
  year_built INT,
  buy_let_status VARCHAR(255),
  square_footage INT,
  build_type VARCHAR(255)
);
