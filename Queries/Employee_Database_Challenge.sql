SELECT e.emp_no, e.first_name, e.last_name, t.title, t.from_date, t.to_date
INTO retirement_titles
FROM employees as e
LEFT JOIN titles as t
ON e.emp_no=t.emp_no
WHERE (e.birth_date BETWEEN '1952-01-01' AND '1955-12-31')
ORDER BY emp_no

-- Use Dictinct with Orderby to remove duplicate rows
SELECT DISTINCT ON (emp_no) emp_no, first_name, last_name, title
INTO unique_titles
FROM retirement_titles
WHERE to_date=('9999-01-01')
ORDER BY emp_no, to_date DESC;


-- Employee count by department number
SELECT COUNT(emp_no), title
INTO retiring_titles
FROM unique_titles
GROUP BY title
ORDER BY count DESC


--deliverable 2
SELECT DISTINCT ON (emp_no) e.emp_no, e.first_name, e.last_name, e.birth_date, de.from_date, de.to_date, t.title
INTO mentorship_eligibility
FROM employees as e
LEFT JOIN dept_emp as de
ON (e.emp_no = de.emp_no)
LEFT JOIN titles as t
ON (e.emp_no = t.emp_no)
WHERE (e.birth_date BETWEEN '1965-01-01' AND '1965-12-31') AND de.to_date=('9999-01-01')
ORDER BY emp_no;


--extra mentorship count by department
SELECT COUNT(emp_no), title
INTO mentoring_titles
FROM mentorship_eligibility
GROUP BY title
ORDER BY count DESC


--extra total number of people in departments to get percent retiring
SELECT COUNT(e.emp_no), t.title
INTO total_employees_titles
FROM employees as e
LEFT JOIN titles as t
ON e.emp_no=t.emp_no
GROUP BY title
ORDER BY count DESC

ALTER TABLE total_employees_titles
RENAME COLUMN count TO Total_Employees;

SELECT rt.title, rt.count, tet.total_employees
INTO percent_retire
FROM retiring_titles as rt
LEFT JOIN total_employees_titles as tet
ON rt.title=tet.title

ALTER TABLE percent_retire
RENAME COLUMN count TO Retirement_Employees;

SELECT title, retirement_employees, total_employees, ROUND(retirement_employees*100.0/total_employees, 1) AS Percent
FROM percent_retire
