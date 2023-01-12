-- 1. Contare quanti iscritti ci sono stati ogni anno
SELECT
    COUNT(`id`) AS `NUMERO_ISCRITTI`,
    YEAR (`enrolment_date`)
FROM
    `students`
GROUP BY
    YEAR (`enrolment_date`);

-- 2. Contare gli insegnanti che hanno l'ufficio nello stesso edificio
SELECT
    COUNT(*) AS `NUMERO_PROF`,
    `teachers`.`office_address`
FROM
    `teachers`
GROUP BY
    `office_address`;

-- 3. Calcolare la media dei voti di ogni appello d'esame
SELECT
    AVG(`vote`) AS `media_voti`
    `exam_id`
FROM
    `exam_student`
GROUP BY
    `exam_id`;

-- 4. Contare quanti corsi di laurea ci sono per ogni dipartimento
SELECT
    COUNT(*) AS `num_corsi`
FROM
    `degrees`
GROUP BY
    `department_id`;