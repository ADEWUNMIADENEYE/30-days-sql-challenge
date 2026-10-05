SELECT design_type,
       COUNT(*)                                       AS n,
       ROUND(AVG(efficacy_score * 1.0), 1)            AS avg_efficacy,
       ROUND(AVG(student_engagement * 1.0), 1)        AS avg_engagement,
       ROUND(AVG(learning_outcome * 1.0), 1)          AS avg_outcome,
       ROUND(AVG(ai_detection_rate * 1.0), 1)         AS avg_ai_detection,
       ROUND(AVG(student_satisfaction * 1.0), 1)      AS avg_satisfaction
FROM assignment_design_efficacy
GROUP BY design_type
ORDER BY avg_efficacy DESC;

SELECT design_type,
       MIN(efficacy_score)                 AS min_eff,
       MAX(efficacy_score)                 AS max_eff,
       ROUND(STDEV(efficacy_score), 1)     AS stdev_eff
FROM assignment_design_efficacy
GROUP BY design_type
ORDER BY stdev_eff DESC;

SELECT subject, design_type,
       COUNT(*)                            AS n,
       ROUND(AVG(efficacy_score * 1.0), 1) AS avg_efficacy
FROM assignment_design_efficacy
GROUP BY subject, design_type
ORDER BY subject, avg_efficacy DESC;

SELECT design_type, implementation_cost,
       COUNT(*)                            AS n,
       ROUND(AVG(efficacy_score * 1.0), 1) AS avg_efficacy
FROM assignment_design_efficacy
GROUP BY design_type, implementation_cost
ORDER BY design_type,
         CASE implementation_cost WHEN 'Low' THEN 1 WHEN 'Medium' THEN 2 ELSE 3 END;

SELECT implementation_cost,
       COUNT(*)                            AS n,
       ROUND(AVG(efficacy_score * 1.0), 1) AS avg_efficacy
FROM assignment_design_efficacy
GROUP BY implementation_cost
ORDER BY CASE implementation_cost WHEN 'Low' THEN 1 WHEN 'Medium' THEN 2 ELSE 3 END;

SELECT design_type, faculty_workload,
       COUNT(*)                            AS n,
       ROUND(AVG(efficacy_score * 1.0), 1) AS avg_efficacy
FROM assignment_design_efficacy
GROUP BY design_type, faculty_workload
ORDER BY design_type,
         CASE faculty_workload WHEN 'Low' THEN 1 WHEN 'Medium' THEN 2 ELSE 3 END;

SELECT 
    CASE WHEN class_size < 50  THEN '1. Small (<50)'
         WHEN class_size < 100 THEN '2. Medium (50-99)'
         ELSE                       '3. Large (100+)' END AS size_band,
    COUNT(*)                            AS n,
    ROUND(AVG(efficacy_score * 1.0), 1) AS avg_efficacy
FROM assignment_design_efficacy
GROUP BY CASE WHEN class_size < 50  THEN '1. Small (<50)'
              WHEN class_size < 100 THEN '2. Medium (50-99)'
              ELSE                       '3. Large (100+)' END
ORDER BY size_band;


SELECT design_type,
       CASE WHEN class_size < 50  THEN '1. Small (<50)'
            WHEN class_size < 100 THEN '2. Medium (50-99)'
            ELSE                       '3. Large (100+)' END AS size_band,
       COUNT(*)                            AS n,
       ROUND(AVG(efficacy_score * 1.0), 1) AS avg_efficacy
FROM assignment_design_efficacy
GROUP BY design_type,
         CASE WHEN class_size < 50  THEN '1. Small (<50)'
              WHEN class_size < 100 THEN '2. Medium (50-99)'
              ELSE                       '3. Large (100+)' END
ORDER BY design_type, size_band;