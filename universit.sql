-- 1. Selezionare tutti gli studenti nati nel 1990 (160)
SELECT
    *
FROM
    `students`
WHERE
    YEAR(date_of_birth) = 1990;

-- 2. Selezionare tutti i corsi che valgono più di 10 crediti (479)
SELECT
    *
FROM
    `courses`
WHERE
    `cfu` > 10;

-- 3. Selezionare tutti gli studenti che hanno più di 30 anni
-- SELECT * 
-- FROM `students` 
-- WHERE DATE(`date_of_birth`)<"1992-01-11";
SELECT
    *,
    TIMESTAMPDIFF(YEAR, `date_of_birth`, NOW())
FROM
    `students`
WHERE
    TIMESTAMPDIFF(YEAR, `date_of_birth`, NOW()) > 30;

-- 4. Selezionare tutti i corsi del primo semestre del primo anno di un qualsiasi corso di
-- laurea (286)
SELECT
    *
FROM
    `courses` --  WHERE `period`="I semestre" 
    --  AND `year`=1;
    --NEL CASO NON CI SONO CONTROLLI ADEGUATI E L'UTENTE CAMBIA SCRITTURA(PIU FLESSIBILE)
WHERE
    (
        `period` LIKE "I %"
        OR `period` LIKE "1 %"
    )
    AND `year` = 1;

-- 5. Selezionare tutti gli appelli d'esame che avvengono nel pomeriggio (dopo le 14) del 20/06/2020 (21)
SELECT
    *
FROM
    `exams`
WHERE
    `hour` > "14:00:00"
    AND DATE(`date`) = "2020-06-20";

-- 6. Selezionare tutti i corsi di laurea magistrale (38)
SELECT
    *
FROM
    `degrees`
WHERE
    `level` = "magistrale";

-- 7. Da quanti dipartimenti è composta l'università? (12)
SELECT
    COUNT(`id`)
FROM
    `departments`;

-- 8. Quanti sono gli insegnanti che non hanno un numero di telefono? (50)
SELECT
    COUNT(`id`)
FROM
    `teachers`
WHERE
    `phone` IS NULL;

--RAGGRUPPAMENTO "GROUP BY"
SELECT
    YEAR (`date_of_birth`),
    COUNT(`date_of_birth`)
FROM
    `students`
GROUP BY
    YEAR (`date_of_birth`);

--esempio cambio nome con AS
SELECT
    YEAR (`enrolment_date`) as `iscrizione`,
    YEAR (`date_of_birth`) as `anno_nascita`,
    COUNT(`date_of_birth`) as `conteggio`
FROM
    `students`
GROUP BY
    `iscrizione`,
    `anno_nascita`;

--ORDER BY
SELECT
    YEAR (`enrolment_date`) as `iscrizione`,
    YEAR (`date_of_birth`) as `anno_nascita`,
    COUNT(`date_of_birth`) as `conteggio`
FROM
    `students`
GROUP BY
    `iscrizione`,
    `anno_nascita`
ORDER BY
    `conteggio`;

--CON MEDIA (avg)
SELECT
    `exam_id`,
    AVG(`vote`) as `voto`
FROM
    `exam_student`
GROUP BY
    `exam_id`;

--concatenazione di tabelle,cioè importazioni di dati da una tabella ad un altra (JOIN)
SELECT
    `students`.`name` as `first_name`,
    `students`.`surname` as `last_name`,
    `degrees`.`name` as `degree_name`
FROM
    `students`
    INNER JOIN `degrees` ON `students`.`degree_id` = `degrees`.`id`;

--altro esempio
SELECT
    *
FROM
    `degrees`
    INNER JOIN `courses` ON `degrees`.`id` = `courses`.`degree_id`
WHERE
    `degrees`.`name` = "Corso di Laurea in Informatica";

-- Selezionare le informazioni sul corso con id = 144, con tutti i relativi appelli d’esame
SELECT
    *
FROM
    `courses`
    INNER JOIN `exams` ON `courses`.`id` = `exams`.`course_id`
WHERE
    `courses`.`id` = 144;

--# Selezionare a quale dipartimento appartiene il Corso di Laurea in Diritto dell'Economia (Dipartimento di Scienze politiche, giuridiche e studi internazionali)"
SELECT
    `degrees`.*,
    `departments`.`name` AS `Dipartimento`
FROM
    `degrees`
    INNER JOIN `departments` ON `departments`.`id` = `degrees`.`department_id`
WHERE
    `degrees`.`name` = "Corso di Laurea in Diritto dell'Economia";

--# Selezionare tutti gli appelli d'esame del Corso di Laurea Magistrale in Fisica del primo anno
--- 1.PREòEVARE TRAMITE SELECT E WHERE I DATI CHE CI SERVONI
-- 2. CAPISCO COME SONO UNITE LE TABELLE (tramite diagramma) e le unisco (inner)
--3  SE OPPORTUNO,CAMBIO I NOMI DEI DATI TRAMITE L'AS NELLA SELECT
SELECT
    `degrees`.`name` as `Corso di laurea`,
    `courses`.`name` as `Corso`,
    `courses`.`year` as `Anno`,
    `exams`.*
FROM
    `degrees`
    INNER JOIN `courses` ON `courses`.`degree_id` = `degrees`.`id`
    INNER JOIN `exams` ON `exams`.`course_id` = `courses`.`id`
WHERE
    `degrees`.`name` = "Corso di Laurea Magistrale in Fisica"
    AND `courses`.`year` = 1 --AND `courses`.`period` = "I semestre";
    --CASO TABELLA PONTE (relazione molti A molti)
    --selezionare tutti i docenti che insegnano nel "corso di laurea in lettere"
SELECT
    `degrees`.`name` AS `corso_laurea`,
    `courses`.`name` AS `insegnamento`,
    `teachers`.`name` AS `nome_insegnante`,
    `teachers`.`surname` AS `cognome_insegnante`
FROM
    `degrees`
    INNER JOIN `courses` ON `courses`.`degree_id` = `degrees`.`id`
    INNER JOIN `course_teacher` ON `course_teacher`.`course_id` = `courses`.`id`
    INNER JOIN `teachers` ON `course_teacher`.`teacher_id` = `teachers`.`id`
WHERE
    `degrees`.`name` = "Corso di Laurea in Lettere"
ORDER BY
    `cognome_insegnante`;

--# Selezionare il voto medio di superamento d'esame per ogni corso, con anche i dati  del corso di laurea associato, ordinati per media voto decrescente
SELECT
    `courses`.`id`,
    `courses`.`name`,
    AVG(`exam_student`.`vote`) as `avg_vote`
FROM
    `exam_student`
    INNER JOIN `exams` ON `exam_student`.`exam_id` = `exams`.`id`
    INNER JOIN `courses` ON `exams`.`course_id` = `courses`.`id`
    INNER JOIN `degrees` ON `courses`.`degree_id` = `degrees`.`id`
WHERE
    `exam_student`.`vote` >= 18
GROUP BY
    `courses`.`id`
ORDER BY
    `avg_vote` DESC;