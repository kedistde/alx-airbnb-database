-- partitioning.sql

-- 1. Create partitioned parent table
CREATE TABLE booking (
  id              BIGSERIAL PRIMARY KEY,
  user_id         BIGINT NOT NULL,
  property_id     BIGINT NOT NULL,
  start_date      DATE NOT NULL,
  end_date        DATE NOT NULL,
  -- other columns...
  partition_key   DATE NOT NULL
) PARTITION BY RANGE (partition_key);

-- 2. Create monthly partitions (e.g., first quarter of 2025)
CREATE TABLE booking_2025_01 PARTITION OF booking
  FOR VALUES FROM ('2025-01-01') TO ('2025-02-01');
CREATE TABLE booking_2025_02 PARTITION OF booking
  FOR VALUES FROM ('2025-02-01') TO ('2025-03-01');
CREATE TABLE booking_2025_03 PARTITION OF booking
  FOR VALUES FROM ('2025-03-01') TO ('2025-04-01');

-- 3. Create index on parent for global usage (propagates to partitions)
CREATE INDEX idx_booking_partition_key ON booking (partition_key);
CREATE INDEX idx_booking_user ON booking (user_id);

-- 4. Insert into parent automatically routes to partitions
-- INSERT INTO booking (...)
EXPLAIN ANALYZE
SELECT * FROM booking
WHERE start_date BETWEEN '2025-02-01' AND '2025-02-28';
EXPLAIN ANALYZE
SELECT * FROM booking
WHERE partition_key BETWEEN '2025-02-01' AND '2025-02-28';


