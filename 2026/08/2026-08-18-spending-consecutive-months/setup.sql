CREATE TABLE transactions (
    transaction_id   VARCHAR(20),
    user_id          VARCHAR(10),
    transaction_date DATE,
    amount           DECIMAL(10, 2)
);

INSERT INTO transactions
    (transaction_id, user_id, transaction_date, amount)
VALUES

-- User A
-- Monthly totals: Jan 100, Feb 150, Mar 200, Apr 180
('T001', 'A', '2026-01-05', 100),
('T002', 'A', '2026-02-10', 120),
('T003', 'A', '2026-02-20', 30),
('T004', 'A', '2026-03-15', 200),
('T005', 'A', '2026-04-01', 180),

-- User B
-- Missing February
-- Jan 50, Mar 100, Apr 150
('T006', 'B', '2026-01-05', 50),
('T007', 'B', '2026-03-10', 100),
('T008', 'B', '2026-04-10', 150),

-- User C
-- Increasing for four consecutive months
-- Feb 200, Mar 250, Apr 300, May 400
('T009', 'C', '2026-02-01', 200),
('T010', 'C', '2026-03-01', 250),
('T011', 'C', '2026-04-01', 300),
('T012', 'C', '2026-05-01', 400),

-- User D
-- Equal spending breaks the increasing sequence
-- Jan 100, Feb 150, Mar 150, Apr 200
('T013', 'D', '2026-01-10', 100),
('T014', 'D', '2026-02-10', 150),
('T015', 'D', '2026-03-10', 150),
('T016', 'D', '2026-04-10', 200),

-- User E
-- Increase, decrease, then another increase
-- Jan 100, Feb 200, Mar 50, Apr 100, May 150
('T017', 'E', '2026-01-10', 100),
('T018', 'E', '2026-02-10', 200),
('T019', 'E', '2026-03-10', 50),
('T020', 'E', '2026-04-10', 100),
('T021', 'E', '2026-05-10', 150);