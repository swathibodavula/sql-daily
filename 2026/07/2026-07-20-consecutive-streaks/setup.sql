-- 2026-07-20 — Consecutive Streaks
-- Schema and sample data. Run this before solution.sql.

CREATE OR REPLACE TABLE Attendance (
    employee_id INT,
    work_date   DATE,
    status      VARCHAR,
    PRIMARY KEY (employee_id, work_date)
);

INSERT INTO Attendance VALUES
    (1, '2026-07-01', 'present'),
    (1, '2026-07-02', 'present'),
    (1, '2026-07-03', 'present'),
    (1, '2026-07-05', 'present'),
    (2, '2026-07-01', 'present'),
    (2, '2026-07-02', 'absent'),
    (2, '2026-07-03', 'present'),
    (2, '2026-07-04', 'present'),
    (2, '2026-07-05', 'present'),
    (2, '2026-07-06', 'present');