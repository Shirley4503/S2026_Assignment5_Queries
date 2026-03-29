-- 1
SELECT quantityOnHand
FROM item
WHERE itemDescription = 'bottle of antibiotics';

-- 2
SELECT volunteerName
FROM volunteer
WHERE volunteerTelephone IS NOT NULL
  AND volunteerTelephone NOT LIKE '2%'
  AND volunteerName NOT LIKE '%Jones';

-- 3
SELECT DISTINCT v.volunteerName
FROM volunteer v
JOIN assignment a
  ON v.volunteerId = a.volunteerId
JOIN task t
  ON a.taskCode = t.taskCode
JOIN task_type tt
  ON t.taskTypeId = tt.taskTypeId
WHERE tt.taskTypeName = 'transporting';

-- 4
SELECT t.taskDescription
FROM task t
LEFT JOIN assignment a
  ON t.taskCode = a.taskCode
WHERE a.taskCode IS NULL;

-- 5
SELECT DISTINCT pt.packageTypeName
FROM package_type pt
JOIN package p
  ON pt.packageTypeId = p.packageTypeId
JOIN package_contents pc
  ON p.packageId = pc.packageId
JOIN item i
  ON pc.itemId = i.itemId
WHERE i.itemDescription LIKE '%bottle%';

-- 6
SELECT i.itemDescription
FROM item i
LEFT JOIN package_contents pc
  ON i.itemId = pc.itemId
WHERE pc.itemId IS NULL;

-- 7
SELECT DISTINCT t.taskDescription
FROM task t
JOIN assignment a
  ON t.taskCode = a.taskCode
JOIN volunteer v
  ON a.volunteerId = v.volunteerId
WHERE v.volunteerAddress LIKE '%NJ%';

-- 8
SELECT DISTINCT v.volunteerName
FROM volunteer v
JOIN assignment a
  ON v.volunteerId = a.volunteerId
WHERE a.startDateTime >= '2021-01-01'
  AND a.startDateTime < '2021-07-01';

-- 9
SELECT DISTINCT v.volunteerName
FROM volunteer v
JOIN assignment a
  ON v.volunteerId = a.volunteerId
JOIN task t
  ON a.taskCode = t.taskCode
JOIN package p
  ON t.taskCode = p.taskCode
JOIN package_contents pc
  ON p.packageId = pc.packageId
JOIN item i
  ON pc.itemId = i.itemId
WHERE i.itemDescription = 'can of spam';

-- 10
SELECT i.itemDescription
FROM item i
JOIN package_contents pc
  ON i.itemId = pc.itemId
GROUP BY pc.packageId, i.itemId, i.itemDescription
HAVING i.itemValue * pc.itemQuantity = 100;

-- 11
SELECT ts.taskStatusName, COUNT(DISTINCT a.volunteerId) AS numberOfVolunteers
FROM task_status ts
JOIN task t
  ON ts.taskStatusId = t.taskStatusId
JOIN assignment a
  ON t.taskCode = a.taskCode
GROUP BY ts.taskStatusName
ORDER BY numberOfVolunteers DESC;

-- 12
SELECT taskCode, SUM(packageWeight) AS totalWeight
FROM package
GROUP BY taskCode
ORDER BY totalWeight DESC
LIMIT 1;

-- 13
SELECT COUNT(*) AS numberOfTasks
FROM task t
JOIN task_type tt
  ON t.taskTypeId = tt.taskTypeId
WHERE tt.taskTypeName <> 'packing';

-- 14
SELECT i.itemDescription
FROM item i
JOIN package_contents pc
  ON i.itemId = pc.itemId
JOIN package p
  ON pc.packageId = p.packageId
JOIN assignment a
  ON p.taskCode = a.taskCode
GROUP BY i.itemId, i.itemDescription
HAVING COUNT(DISTINCT a.volunteerId) < 3;

-- 15
SELECT pc.packageId, SUM(i.itemValue * pc.itemQuantity) AS totalValue
FROM package_contents pc
JOIN item i
  ON pc.itemId = i.itemId
GROUP BY pc.packageId
HAVING SUM(i.itemValue * pc.itemQuantity) > 100
ORDER BY totalValue ASC;
