CREATE TABLE "User" (
  user_id UUID PRIMARY KEY,
  first_name VARCHAR NOT NULL,
  last_name VARCHAR NOT NULL,
  email VARCHAR NOT NULL UNIQUE,
  password_hash VARCHAR NOT NULL,
  phone_number VARCHAR,
  role VARCHAR NOT NULL CHECK (role IN ('guest','host','admin')),
  created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE INDEX idx_user_email ON "User"(email);

CREATE TABLE Property (
  property_id UUID PRIMARY KEY,
  host_id UUID NOT NULL REFERENCES "User"(user_id),
  name VARCHAR NOT NULL,
  description TEXT NOT NULL,
  location VARCHAR NOT NULL,
  price_per_night DECIMAL NOT NULL,
  created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE INDEX idx_property_host ON Property(host_id);

CREATE TABLE Booking (
  booking_id UUID PRIMARY KEY,
  property_id UUID NOT NULL REFERENCES Property(property_id),
  user_id UUID NOT NULL REFERENCES "User"(user_id),
  start_date DATE NOT NULL,
  end_date DATE NOT NULL,
  status VARCHAR NOT NULL CHECK (status IN ('pending','confirmed','canceled')),
  created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE INDEX idx_booking_property ON Booking(property_id);
CREATE INDEX idx_booking_user ON Booking(user_id);

CREATE TABLE Payment (
  payment_id UUID PRIMARY KEY,
  booking_id UUID NOT NULL REFERENCES Booking(booking_id),
  amount DECIMAL NOT NULL,
  payment_date TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  payment_method VARCHAR NOT NULL CHECK (payment_method IN ('credit_card','paypal','stripe'))
);

CREATE INDEX idx_payment_booking ON Payment(booking_id);

CREATE TABLE Review (
  review_id UUID PRIMARY KEY,
  property_id UUID NOT NULL REFERENCES Property(property_id),
  user_id UUID NOT NULL REFERENCES "User"(user_id),
  rating INTEGER NOT NULL CHECK (rating BETWEEN 1 AND 5),
  comment TEXT NOT NULL,
  created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE INDEX idx_review_property ON Review(property_id);
CREATE INDEX idx_review_user ON Review(user_id);

CREATE TABLE Message (
  message_id UUID PRIMARY KEY,
  sender_id UUID NOT NULL REFERENCES "User"(user_id),
  recipient_id UUID NOT NULL REFERENCES "User"(user_id),
  message_body TEXT NOT NULL,
  sent_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE INDEX idx_message_sender ON Message(sender_id);
CREATE INDEX idx_message_recipient ON Message(recipient_id);
