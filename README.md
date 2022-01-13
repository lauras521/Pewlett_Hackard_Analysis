# Pewlett Hackard Analysis

## Overview
Pewlett Hackard (PH) is a large well established company.  As baby boomers begin to retire, PH needs to plan for its future to make sure they have a seamless transition in employee roles and responsibilities.  PH wants to offer some retirement packages as well as ensure it has a pipeline to fill the vacant spots with well trained employees.  Bobby from HR has been tasked with analyzing information using SQL on its employees to determine who will be retirement eligible and make sure the company is setup for future success even with so many people retiring. 

Analysis was completed for the following items:
1. Determine how many people were going to be retiring by title. 
2. Determine which employees could serve as mentors to ensure the future generation of PH employees are well trained 

## Results

The table below shows how many people will be retiring by title.  
<p align="center">
  <img src = https://github.com/lauras521/Pewlett_Hackard_Analysis/blob/5147973dfad89cf1797e86179c06f75e80c46c4f/Data/retiring_titles_screenshot.PNG>
</p>

* Senior Engineers and Senior Staff make up 70% of the retiring employees
* Overall there are 72,458 retiring employees

The table below shows the beginning of the list of people who are potential mentors to help in the transition.  

<p align="center">
  <img src = https://github.com/lauras521/Pewlett_Hackard_Analysis/blob/5147973dfad89cf1797e86179c06f75e80c46c4f/Data/mentorship_eligibility_screenshot.PNG>
</p>

The table below summarizes the potential mentors to show potential mentors by title.

<p align="center">
  <img src = https://github.com/lauras521/Pewlett_Hackard_Analysis/blob/5147973dfad89cf1797e86179c06f75e80c46c4f/Data/mentoring_titles_screenshot.PNG>
</p>

* There are 1,549 eligible mentors. 
* Senior Engineers and Senior Staff have the highest number of mentors.
* There are no management eligible mentors.  
* 

## Summary

1. How many roles will need to be filled as the "silver tsunami" begins to make an impact?

* Overall there are 72,458 retiring employees so 72,458 roles will need to be filled

2. Are there enough qualified, retirement-ready employees in the departments to mentor the next generation of Pewlett Hackard employees?


Provide high-level responses to the following questions, then provide two additional queries or tables that may provide more insight into the upcoming "silver tsunami."


The 2 additional queries I created and ran to help with additional analysis are the following:
1. determine the number of mentors by title to see if you have enough mentors by title

The query was as follows:

      --extra mentorship count by department
      SELECT COUNT(emp_no), title
      INTO mentoring_titles
      FROM mentorship_eligibility
      GROUP BY title
      ORDER BY count DESC

The results were as follows:

<p align="center">
  <img src = https://github.com/lauras521/Pewlett_Hackard_Analysis/blob/5147973dfad89cf1797e86179c06f75e80c46c4f/Data/mentoring_titles_screenshot.PNG>
</p>

3. determine the Percentage of Employees by Title Retiring to see how many people from a title will be leaving:

The query was as follows:

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


The results were as follows:

<p align="center">
  <img src = https://github.com/lauras521/Pewlett_Hackard_Analysis/blob/5147973dfad89cf1797e86179c06f75e80c46c4f/Data/percent_titles_retiring_screenshot.PNG>
</p>
