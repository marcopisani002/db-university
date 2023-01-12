-- 1. Selezionare tutti gli studenti iscritti al Corso di Laurea in Economia
SELECT
    `students`.`id`,
    `students`.`name`,
    `students`.`surname`,
    `degrees`.`name` AS `corso_di_laurea`
FROM
    `students`
    INNER JOIN `degrees` ON `students`.`degree_id` = `degrees`.`id`
WHERE
    `degrees`.`name` = 'Corso di Laurea in Economia';

-- 2. Selezionare tutti i Corsi di Laurea Magistrale del Dipartimento di Neuroscienze
SELECT
    `degrees`.`name`,
    `degrees`.`level`,
    `degrees`.`id`,
    `departments`.`id` AS `department_id`,
    `departments`.`name`
FROM
    `degrees`
    INNER JOIN `departments` ON `degrees`.`department_id` = `departments`.`id`
WHERE
    `level` = "magistrale"
    AND `departments`.`name` = "Dipartimento di Neuroscienze";

-- 3. Selezionare tutti i corsi in cui insegna Fulvio Amato (id=44)
SELECT
    `courses`.`id`,
    `courses`.`name`,
    `teachers`.`id` AS `teacher_id`,
    `teachers`.`name` AS `teacher_name`,
    `teachers`.`surname`
FROM
    `courses`
    JOIN `course_teacher` ON `courses`.`id` = `course_teacher`.`course_id`
    JOIN `teachers` ON `teachers`.`id` = `course_teacher`.`teacher_id`
WHERE
    `teachers`.`id` = 44;

-- 4. Selezionare tutti gli studenti con i dati relativi al corso di laurea a cui sono iscritti e il
-- relativo dipartimento, in ordine alfabetico per cognome e nome
SELECT
    `students`.`surname`,
    `students`.`name`,
    `students`.`degree_id` AS `id_corso_di_laurea`,
    `degrees`.`department_id`,
    `departments`.`name`
FROM
    `students`
    JOIN `degrees` ON `students`.`degree_id` = `degrees`.`id`
    JOIN `departments` ON `degrees`.`department_id` = `departments`.`id`
ORDER BY
    `students`.`surname`,
    `students`.`name`;

-- 5. Selezionare tutti i corsi di laurea con i relativi corsi e insegnanti
SELECT
    `degrees`.`id` AS `id_corso_di_laurea`,
    `degrees`.`name` AS `nome_corso_di_laurea`,
    `courses`.`name` AS `nome_materia`,
    `course_teacher`.`course_id` AS `id_materia`,
    `teachers`.`id` AS `id_PROF`,
    `teachers`.`name` AS `nome_PROF`,
    `teachers`.`surname` AS `cognome_PROF`
FROM
    `degrees`
    INNER JOIN `courses` ON `degrees`.`id` = `courses`.`degree_id`
    INNER JOIN `course_teacher` ON `courses`.`id` = `course_teacher`.`course_id`
    INNER JOIN `teachers` ON `course_teacher`.`teacher_id` = `teachers`.`id`
ORDER BY
    `degrees`.`name`;

-- 6. Selezionare tutti i docenti che insegnano nel Dipartimento di Matematica (54)

--ME NE TROVO 70 AL POSTO DI 54

SELECT
    `course_teacher`.`teacher_id` AS `id_PROF`,
    `course_teacher`.`course_id` AS `id_CORSO`,
    `courses`.`degree_id` AS `id_facolta`,
    `degrees`.`department_id` AS `id_DIPARTIMENTO`,
    `teachers`.`name`,
    `teachers`.`surname`
FROM
    `teachers`
    INNER JOIN `course_teacher` ON `course_teacher`.`teacher_id` = `teachers`.`id`
    INNER JOIN `courses` ON `course_teacher`.`course_id` = `courses`.`id`
    INNER JOIN `degrees` ON `courses`.`degree_id` = `degrees`.`id`
    INNER JOIN `departments` ON `degrees`.`department_id` = `departments`.`id`
WHERE
    `departments`.`name` LIKE 'Dipartimento di Matematica';

-- 7. BONUS: Selezionare per ogni studente quanti tentativi d’esame ha sostenuto per
-- superare ciascuno dei suoi esami