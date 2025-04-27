-- 1. First name, last name, and gender of male patients
SELECT first_name, last_name, gender
FROM patients
WHERE gender = 'M';

-- 2. First name and last name of patients with no allergies
SELECT first_name, last_name
FROM patients
WHERE allergies IS NULL OR allergies = '';

-- 3. First name of patients that start with the letter 'C'
SELECT first_name
FROM patients
WHERE first_name LIKE 'C%';

-- 4. First name and last name of patients that weigh within the range of 100 to 120 (inclusive)
SELECT first_name, last_name
FROM patients
WHERE weight BETWEEN 100 AND 120;

-- 5. Update the patients table for the allergies column: replace NULL with 'NKA'
SELECT first_name, last_name,
       COALESCE(allergies, 'NKA') AS allergies
FROM patients;

-- 6. Full name (concatenated)
SELECT CONCAT(first_name, ' ', last_name) AS full_name
FROM patients;

-- 7. First name, last name, and the full province name of each patient
SELECT
    p.first_name,
    p.last_name,
    pn.province_name
FROM
    patients p
JOIN
    province_names pn ON p.province_id = pn.province_id;


-- 8. Number of patients with a birth_date with 2010 as the birth year
SELECT COUNT(*) AS num_patients
FROM patients
WHERE YEAR(birth_date) = 2010;

-- 9. Patient with greatest height
SELECT first_name, last_name, height
FROM patients
WHERE height = (SELECT MAX(height) FROM patients);

-- 10. All columns for patients who have one of the following patient_ids: 1, 45, 534, 879, 1000
SELECT *
FROM patients
WHERE patient_id IN (1, 45, 534, 879, 1000);

-- 11. Total number of admissions
SELECT COUNT(*) AS total_admissions
FROM admissions;

-- 12. Admissions where the patient was admitted and discharged on the same day
SELECT *
FROM admissions
WHERE admission_date = discharge_date;

-- 13. Total number of admissions for patient_id 579
SELECT COUNT(*) AS total_admissions
FROM admissions
WHERE patient_id = 579;

-- 14. Unique cities in province_id 'NS'
SELECT DISTINCT city
FROM patients
WHERE province_id = 'NS';

-- 15. First name, last name, and birth date of patients who have height more than 160 and weight more than 70
SELECT first_name, last_name, birth_date
FROM patients
WHERE height > 160 AND weight > 70;

-- 16. Unique birth years from patients, ordered by ascending
SELECT DISTINCT YEAR(birth_date) AS birth_year
FROM patients
ORDER BY birth_year ASC;

-- 17. Unique first names occurring only once
SELECT first_name
FROM patients
GROUP BY first_name
HAVING COUNT(*) = 1;

-- 18. patient_id and first_name where first_name starts and ends with 's' and is at least 6 characters long
SELECT patient_id, first_name
FROM patients
WHERE first_name LIKE 's%' AND first_name LIKE '%s'
  AND LENGTH(first_name) >= 6;

-- 19. patient_id, first_name, last_name from patients whos diagnosis is 'Dementia'
SELECT p.patient_id, p.first_name, p.last_name
FROM patients p
JOIN admissions a ON p.patient_id = a.patient_id
WHERE a.diagnosis = 'Dementia';

-- 20. Display every patient's first_name. Order the list by the length of each name and then by alphbetically.
SELECT first_name
FROM patients
ORDER BY LENGTH(first_name), first_name;

-- 21. Total male and female patients in the same row
SELECT
  SUM(CASE WHEN gender = 'M' THEN 1 ELSE 0 END) AS male_count,
  SUM(CASE WHEN gender = 'F' THEN 1 ELSE 0 END) AS female_count
FROM patients;


-- 22. patient_id, diagnosis from admissions. Find patients admitted multiple times for the same diagnosis.
SELECT patient_id, diagnosis
FROM admissions
GROUP BY patient_id, diagnosis
HAVING COUNT(*) > 1;

-- 23. City and total number of patients, ordered
SELECT city, COUNT(*) AS total_patients
FROM patients
GROUP BY city
ORDER BY total_patients DESC, city ASC;

-- 24. First name, last name and role of every person that is either patient or doctor
SELECT first_name, last_name, 'Patient' AS role
FROM patients
UNION
SELECT first_name, last_name, 'Doctor' AS role
FROM doctors;

-- 25. All allergies ordered by popularity, remove NULL values
SELECT allergies, COUNT(*) AS count
FROM patients
WHERE allergies IS NOT NULL
GROUP BY allergies
ORDER BY count DESC;

-- 26. Patients born in 1970s, ordered by birth_date
SELECT first_name, last_name, birth_date
FROM patients
WHERE YEAR(birth_date) BETWEEN 1970 AND 1979
ORDER BY birth_date ASC;

-- 27. Full name: LASTNAME,firstname format, ordered by first_name descending
SELECT CONCAT(UPPER(last_name), ',', LOWER(first_name)) AS full_name
FROM patients
ORDER BY first_name DESC;

-- 28. province_id(s) with sum(height) >= 7000
SELECT province_id, SUM(height) AS total_height
FROM patients
GROUP BY province_id
HAVING SUM(height) >= 7000;

-- 29. Difference between the largest weight and smallest weight for last_name 'Maroni'
SELECT MAX(weight) - MIN(weight) AS weight_diff
FROM patients
WHERE last_name = 'Maroni';

-- 30. Days of month and admission counts
SELECT DAY(admission_date) AS day_of_month, COUNT(*) AS admissions_count
FROM admissions
GROUP BY day_of_month
ORDER BY admissions_count DESC, day_of_month;

-- 31. Patients grouped into weight groups
SELECT (FLOOR(weight / 10) * 10) AS weight_group, COUNT(*) AS total_patients
FROM patients
GROUP BY weight_group
ORDER BY weight_group DESC;

-- 32. patient_id, weight, height, isObese (BMI > 30)
SELECT patient_id, weight, height,
  CASE WHEN (weight / POWER(height / 100.0, 2)) > 30 THEN 1 ELSE 0 END AS isObese
FROM patients;

-- 33. Patients with diagnosis 'Epilepsy' and doctor 'Lisa'
SELECT p.patient_id, p.first_name, p.last_name, d.specialty
FROM patients p
JOIN admissions a ON p.patient_id = a.patient_id
JOIN doctors d ON a.attending_doctor_id = d.doctor_id  -- Using attending_doctor_id here
WHERE a.diagnosis = 'Epilepsy' AND d.first_name = 'Lisa';

-- 34. patient_id and temp_password for patients with admissions
SELECT p.patient_id,
       CONCAT(
         p.patient_id,
         LENGTH(p.last_name),
         YEAR(p.birth_date)
       ) AS temp_password
FROM patients p
WHERE EXISTS (
  SELECT 1 FROM admissions a WHERE a.patient_id = p.patient_id
);



















 






