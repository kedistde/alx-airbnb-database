-- Users
CREATE TABLE User (
  user_id UUID PRIMARY KEY,
  first_name VARCHAR NOT NULL,
  last_name VARCHAR NOT NULL,
  email VARCHAR UNIQUE NOT NULL,
  password_hash VARCHAR NOT NULL,
  phone_number VARCHAR,
  role ENUM('guest', 'host', 'admin') NOT NULL,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Properties
CREATE TABLE Property (
  property_id UUID PRIMARY KEY,
  host_id UUID NOT NULL REFERENCES User(user_id),
  name VARCHAR NOT NULL,
  description TEXT NOT NULL,
  location VARCHAR NOT NULL,
  price_per_night DECIMAL NOT NULL,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

-- Bookings
CREATE TABLE Booking (
  booking_id UUID PRIMARY KEY,
  property_id UUID NOT NULL REFERENCES Property(property_id),
  user_id UUID NOT NULL REFERENCES User(user_id),
  start_date DATE NOT NULL,
  end_date DATE NOT NULL,
  status ENUM('pending','confirmed','canceled') NOT NULL,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Payments
CREATE TABLE Payment (
  payment_id UUID PRIMARY KEY,
  booking_id UUID NOT NULL REFERENCES Booking(booking_id),
  amount DECIMAL NOT NULL,
  payment_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  payment_method ENUM('credit_card','paypal','stripe') NOT NULL
);

-- Reviews
CREATE TABLE Review (
  review_id UUID PRIMARY KEY,
  property_id UUID NOT NULL REFERENCES Property(property_id),
  user_id UUID NOT NULL REFERENCES User(user_id),
  rating INTEGER CHECK (rating BETWEEN 1 AND 5) NOT NULL,
  comment TEXT NOT NULL,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Messages
CREATE TABLE Message (
  message_id UUID PRIMARY KEY,
  sender_id UUID NOT NULL REFERENCES User(user_id),
  recipient_id UUID NOT NULL REFERENCES User(user_id),
  message_body TEXT NOT NULL,
  sent_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
# Airbnb Schema Normalization to 3NF

## 1. First Normal Form (1NF)
- All tables use atomic columns (no repeating or multi-valued fields).
- Each table has a primary key.
- Data types are simple and indivisible.

## 2. Second Normal Form (2NF)
- Each table has a single-column primary key (UUID).
- All non-key attributes depend entirely on the primary key.
  - E.g., in `Property`, attributes like `name`, `price_per_night`, etc. depend only on `property_id`.

## 3. Third Normal Form (3NF)
- **No transitive dependencies** (where non-key attributes depend on other non-key attributes).
  
| Table     | Potential Transitive Dependencies | Resolution |
|-----------|-----------------------------------|------------|
| Booking   | `total_price` (if stored) depends on `price_per_night * duration` → derived. | **Removed** `total_price` (*:contentReference[oaicite:1]{index=1}*) |
| Payment   | None                              | ✓ All pay info depends only on `payment_id` |
| Review    | None                              | ✓ Ratings/comments depend only on `review_id` |
| Message   | None                              | ✓ Message content depends only on `message_id` |

- Derived attributes like `total_price` violate 3NF because they can be reconstructed from `price_per_night`, `start_date`, and `end_date`. Removing them ensures all attributes depend solely on the primary key and nothing else (*:contentReference[oaicite:2]{index=2}*).

## ✅ Final Check: 3NF Compliance
- All tables in 2NF ✅.
- No non-key attribute depends on another non-key attribute.
- Entire design adheres to 3NF: “every non-prime attribute depends only on the primary key” (*:contentReference[oaicite:3]{index=3}*).

---

## 🙋‍♂️ Summary
-  ore entities and relationships (Users, Properties, Bookings, Payments, Reviews, Messages).
- removed total_price from Booking (derived).
- All non-key attributes depend only on their table’s primary key—no partial or transitive dependencies remain.

