-- Query all the data from the Patients Table.
SELECT *
FROM Patients;

-- Query all the data from the Doctors Table.
SELECT *
FROM Doctors;

-- Query all the data from the Appointments Table.
SELECT *
FROM Appointments;

-- Query all the data from the Treatments Table.
SELECT *
FROM Treatments;

--PATIENTS TABLE ANALYIS

--Query the data for patients under the age of 18.
SELECT *
FROM Patients
WHERE age < 18;

--Query the data for patients under the age of 18 and sort the queried data from above from youngest patient to oldest patient.
SELECT *
FROM Patients
WHERE age < 18
ORDER BY age ASC;

--Query the data for all the patients and count how many patients are in each city.
SELECT city, COUNT(*) AS patient_count
FROM Patients
GROUP BY city;

--Display the city with the most number of patients.
SELECT city, COUNT(*) AS patient_count
FROM Patients
GROUP BY city
ORDER BY patient_count DESC
LIMIT 1;

-- Display the average age of the patients.
SELECT AVG(age) AS patient_average_age
FROM Patients;

--Display the number of patients of each gender type.
SELECT gender, COUNT(*) AS patient_count
FROM Patients
GROUP BY gender;


--DOCTORS TABLE ANALYIS

--Query the data of the doctors whose specialization is Neurology
SELECT *
FROM Doctors
WHERE specialization = 'Neurology';

--Query the data of the doctors whose specialization is Pediatrics
SELECT *
FROM Doctors
WHERE specialization = 'Pediatrics';

--Query the data of the doctors whose specialization is Dermatology
SELECT *
FROM Doctors
WHERE specialization = 'Dermatology';

--Query the data of the doctors whose specialization is Cardiology
SELECT *
FROM Doctors
WHERE specialization = 'Cardiology';

--Query the data of the doctors whose specialization is Orthopedics
SELECT *
FROM Doctors
WHERE specialization = 'Orthopedics';

--Query the data for the highest-rated Doctor
SELECT *
FROM Doctors
WHERE rating = (SELECT MAX(rating) FROM Doctors);

--Query the data for the lowest-rated Doctor
SELECT *
FROM Doctors
WHERE rating = (SELECT MIN(rating) FROM Doctors);

--Query the data for the highest-rated Doctor in each specialization.
SELECT *
FROM Doctors outerquery
WHERE rating = (SELECT MAX(rating) FROM Doctors innerquery WHERE outerquery.specialization = innerquery.specialization);

--Query the data for the lowest-rated Doctor in each specialization.
SELECT *
FROM Doctors outerquery
WHERE rating = (SELECT MIN(rating) FROM Doctors innerquery WHERE outerquery.specialization = innerquery.specialization);

--Display the average rating of all the Doctors
SELECT AVG(rating) AS average_rating
FROM Doctors;

--Display the average rating of all the Doctors for each specialization.
SELECT specialization, AVG(rating) AS average_rating
FROM Doctors
GROUP BY specialization;

--Count how many Doctors have a rating above 4.5 stars.
SELECT COUNT(*)
FROM Doctors
WHERE rating > 4.5;


--APPOINTMENTS TABLE ANALYSIS

--Count how many appointments had the survey completed.
SELECT COUNT(*)
FROM Appointments
WHERE survey_completed = 'Yes';

--Count how many appointments had the survey not completed.
SELECT COUNT(*)
FROM Appointments
WHERE survey_completed = 'No';

--Calculate the percentage of appointments with completed surveys.
SELECT ((COUNT(survey_completed)/400.0) * 100.0) AS percentage_completed
FROM Appointments
WHERE survey_completed = 'Yes';

--Count how many appointments are scheduled, completed, and canceled.
SELECT status, COUNT(*) AS appointment_count
FROM Appointments
GROUP BY status;

--Calculate the average time taken for all the Appointments.
SELECT AVG(time_taken_minutes) AS average_time_taken
FROM Appointments;

--Calculate the average time taken for appointments for each reason for appointment.
SELECT reason_for_appointment, AVG(time_taken_minutes) AS average_time_taken
FROM Appointments
GROUP BY reason_for_appointment;

--Query the data for the shortest appointment.
SELECT *
FROM Appointments
WHERE time_taken_minutes  = (SELECT MIN(time_taken_minutes) FROM Appointments);

--Query the data for the longest appointment.
SELECT *
FROM Appointments
WHERE time_taken_minutes  = (SELECT MAX(time_taken_minutes) FROM Appointments);

--Which doctor has completed the most appointments?
SELECT doctor_id, COUNT(*) AS appointment_count
FROM Appointments
GROUP BY doctor_id
ORDER BY appointment_count DESC
LIMIT 1;

--Which doctor has completed the least appointments?
SELECT doctor_id, COUNT(*) AS appointment_count
FROM Appointments
GROUP BY doctor_id
ORDER BY appointment_count ASC
LIMIT 1;


--TREATMENT ANALYSIS

--Query all the data of the treatments that cost more than 250
SELECT *
FROM Treatments
WHERE treatment_cost > 250;

--Query all the data of the treatments that is the most expensive
SELECT *
FROM Treatments
WHERE treatment_cost = (SELECT MAX(treatment_cost) FROM Treatments);

--Query all the data of the treatments that is the least expensive
SELECT *
FROM Treatments
WHERE treatment_cost = (SELECT MIN(treatment_cost) FROM Treatments);

--Count how many times each treatment was administered.
SELECT treatment_name, COUNT(*) AS treatment_count
FROM Treatments
GROUP BY treatment_name;

--Find the cost of all the treatments added together.
SELECT SUM(treatment_cost) AS total_treatment_cost
FROM Treatments;

--Find the cost of all the treatments added together by group.
SELECT treatment_name, SUM(treatment_cost) AS total_treatment_cost
FROM Treatments
GROUP BY treatment_name;


--JOINING TABLES ANALYSIS

--Query all the data of the doctors that a specific patient has visited.
SELECT d.*
FROM Doctors d
JOIN Appointments a 
ON d.doctor_id = a.doctor_id
WHERE a.patient_id = '4911b775-8ba5-4081-98b0-a664c3b561b6';

--Query all the data of the patients that a specific doctor has visited.
SELECT p.*
FROM Patients p
JOIN Appointments a 
ON p.patient_id = a.patient_id
WHERE a.doctor_id = 'a296ba87-fa91-4278-bbcf-3e0a99c19055';

--Which doctors have overseen the highest-cost treatments?
SELECT d.*
FROM Treatments t
JOIN Appointments a 
ON t.appointment_id = a.appointment_id
JOIN Doctors d 
ON a.doctor_id = d.doctor_id
WHERE t.treatment_cost = (SELECT MAX(treatment_cost) FROM Treatments);


--DATA MODIFICATION

--Inserting a new patient
INSERT INTO Patients(patient_id, first_name, last_name, dob, age, gender, phone, email, city)
VALUES ('3a75b1a9-2c21-4b1d-9782-7a9f7cf7ce05', 'John', 'Doe', '01/01/00', 25, 'Male', '(123) 456-7891', 'johndoe@johndoe.com', 'Westchester');

--Inserting a new Doctor
INSERT INTO Doctors(doctor_id, first_name, last_name, specialization, phone, email, rating)
VALUES ('d41e8511-a929-4275-b003-42fe80617ed4', 'Jack', 'Smith', 'Pediatrics', '(987) 654-3210', 'jacksmith@doctors.com', 5.0)

--Inserting a new Appointment
INSERT INTO Appointments(appointment_id, patient_id, doctor_id, appointment_date, appointment_time, status, time_taken_minutes, reason_for_appointment, survey_completed)
VALUES ('23212e0e-711c-462e-9b05-2d064581bd9b', '3a75b1a9-2c21-4b1d-9782-7a9f7cf7ce05',  'd41e8511-a929-4275-b003-42fe80617ed4', '2025-01-29', '08:30:15', 'Scheduled', 55, 'Vaccination', 'No')

--Inserting a new Treatment
INSERT INTO Treatments(treatment_id, appointment_id, treatment_name, treatment_cost)
VALUES('f6c2d089-3e1b-4c4a-9708-f7422d35b99e', '23212e0e-711c-462e-9b05-2d064581bd9b', 'Vaccination', 50)

--Deleting cancelled Appointments
DELETE FROM Appointments
WHERE status = 'Canceled';

--Updating Patient data
UPDATE Patients
SET phone = '(979) 265-8863'
WHERE patient_id = '4cf9f671-bfb0-4b8a-b9e7-7bcc9207a5b4';

-- Updating a Doctor's rating
UPDATE Doctors
SET rating = 4.5
WHERE doctor_id = '60c8e830-467f-46e2-beb9-0b14902f0bb6';

--Updating an Appointment (Rescheduling a new appointment)
UPDATE Appointments
SET appointment_date = '2025-01-27', appointment_time = '09:30:00', status = 'Scheduled',  time_taken_minutes = NULL, reason_for_appointment = 'Vaccination', survey_completed = 'No'
WHERE appointment_id = '80ac83e5-2dbb-4c2e-8274-980b8bed6800';


