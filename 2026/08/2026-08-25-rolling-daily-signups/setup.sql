CREATE TABLE signups (
    signup_date DATE,
    new_users   INTEGER
);

INSERT INTO signups VALUES
    ('2026-08-01', 12),
    ('2026-08-02', 15),
    ('2026-08-03', 9),
    ('2026-08-04', 20),
    ('2026-08-05', 18),
    ('2026-08-06', 22),
    ('2026-08-07', 14),
    -- note: Aug 8 and Aug 9 are missing (tracking outage)
    ('2026-08-10', 30),
    ('2026-08-11', 25),
    ('2026-08-12', 19),
    ('2026-08-13', 28),
    ('2026-08-14', 33);