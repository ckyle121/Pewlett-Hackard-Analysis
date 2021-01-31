--create retiremnt titles table
SELECT e.emp_no,
	e.first_name, 
	e.last_name,
	t.title,
	t.from_date,
	t.to_date
INTO retirement_titles
FROM employees AS e
INNER JOIN titles AS t
	ON e.emp_no = t.emp_no
WHERE (e.birth_date BETWEEN '1952-01-01' AND '1955-12-31')
ORDER BY e.emp_no;
-- Use Dictinct with Orderby to remove duplicate rows
SELECT DISTINCT ON (emp_no) *
INTO unique_titles 
FROM retirement_titles 
ORDER BY emp_no, to_date DESC;
--retrieve the number of employees by their most recent job title who are about to retire
SELECT COUNT (ut.title), ut.title
INTO retiring_titles
FROM unique_titles AS ut 
GROUP BY ut.title
ORDER BY ut.title DESC;
--Create table for Mentorship Eligability 
SELECT DISTINCT ON (e.emp_no) e.emp_no ,
	e.first_name,
	e.last_name,
	e.birth_date,
	de.from_date,
	de.to_date,
	t.title
INTO mentorship_eligability
FROM employees AS e 
	INNER JOIN dept_emp AS de
		ON (e.emp_no = de.emp_no)
	INNER JOIN titles AS t 
		on (de.emp_no = t.emp_no)
WHERE (e.birth_date BETWEEN '1965-01-01' AND '1965-12-31')
ORDER BY emp_no, to_date DESC;
