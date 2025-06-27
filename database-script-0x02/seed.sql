-- ════════════════════════════════════════
-- Sample data for User
-- ════════════════════════════════════════
INSERT INTO "User" (user_id, first_name, last_name, email, password_hash, phone_number, role)
VALUES
  ('11111111-1111-1111-1111-111111111111', 'Alice', 'Johnson', 'alice@example.com', 'hash1', '+15550001111', 'host'),
  ('22222222-2222-2222-2222-222222222222', 'Bob', 'Smith', 'bob@example.com', 'hash2', '+15550002222', 'guest'),
  ('33333333-3333-3333-3333-333333333333', 'Carol', 'Lee', 'carol@example.com', 'hash3', NULL, 'admin'),
  ('44444444-4444-4444-4444-444444444444', 'Dave', 'Wong', 'dave@example.com', 'hash4', '+15550004444', 'host'),
  ('55555555-5555-5555-5555-555555555555', 'Eve', 'Davis', 'eve@example.com', 'hash5', '+15550005555', 'guest');

-- ════════════════════════════════════════
-- Sample data for Property
-- ════════════════════════════════════════
INSERT INTO Property (property_id, host_id, name, description, location, price_per_night)
VALUES
  ('aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa', '11111111-1111-1111-1111-111111111111', 'Cozy Cottage', 'A small, charming cottage by the lake.', 'Lakeview, CA', 120.00),
  ('bbbbbbbb-bbbb-bbbb-bbbb-bbbbbbbbbbbb', '44444444-4444-4444-4444-444444444444', 'Urban Loft', 'Modern loft in downtown.', 'Metropolis, NY', 200.00);

-- ════════════════════════════════════════
-- Sample data for Booking
-- ════════════════════════════════════════
INSERT INTO Booking (booking_id, property_id, user_id, start_date, end_date, status)
VALUES
  ('aaaabbbb-cccc-dddd-eeee-ffffffffffff', 'aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa', '22222222-2222-2222-2222-222222222222', '2025-07-01', '2025-07-05', 'confirmed'),
  ('bbbbcccc-dddd-eeee-ffff-111111111111', 'bbbbbbbb-bbbb-bbbb-bbbb-bbbbbbbbbbbb', '55555555-5555-5555-5555-555555555555', '2025-08-10', '2025-08-15', 'pending'),
  ('ccccdddd-eeee-ffff-1111-222222222222', 'aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa', '55555555-5555-5555-5555-555555555555', '2025-06-20', '2025-06-22', 'canceled');

-- ════════════════════════════════════════
-- Sample data for Payment
-- ════════════════════════════════════════
INSERT INTO Payment (payment_id, booking_id, amount, payment_method)
VALUES
  ('pay-0001-1111-2222-3333-444444444444', 'aaaabbbb-cccc-dddd-eeee-ffffffffffff', 480.00, 'credit_card'),
  ('pay-0002-2222-3333-4444-555555555555', 'bbbbcccc-dddd-eeee-ffff-111111111111', 1000.00, 'paypal');

-- ════════════════════════════════════════
-- Sample data for Review
-- ════════════════════════════════════════
INSERT INTO Review (review_id, property_id, user_id, rating, comment)
VALUES
  ('rev-0001-aaaa-bbbb-cccc-dddddddddddd', 'aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa', '22222222-2222-2222-2222-222222222222', 5, 'Lovely place, very cozy!'),
  ('rev-0002-eeee-ffff-1111-222222222222', 'bbbbbbbb-bbbb-bbbb-bbbb-bbbbbbbbbbbb', '55555555-5555-5555-5555-555555555555', 4, 'Great location, a bit noisy.');

-- ════════════════════════════════════════
-- Sample data for Message
-- ════════════════════════════════════════
INSERT INTO Message (message_id, sender_id, recipient_id, message_body)
VALUES
  ('msg-0001-aaaa-1111-2222-333333333333', '22222222-2222-2222-2222-222222222222', '11111111-1111-1111-1111-111111111111', 'Hi! Is the cottage available in July?'),
  ('msg-0002-bbbb-3333-4444-555555555555', '11111111-1111-1111-1111-111111111111', '22222222-2222-2222-2222-222222222222', 'Yes, it is available for your dates.');

