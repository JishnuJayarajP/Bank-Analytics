create database project;

use project;


select *from finance1;
select *from finance2;

-- [1] Year wise loan amount 

select year(issue_d) as Year_issuedate,sum(loan_amnt) as Loan_amt from finance1
group by Year_issuedate
order by Year_issuedate;

-- [2] Grade and sub grade wise revol_bal

select grade,sub_grade,sum(revol_bal) as Total_rev_bal from finance1
inner join finance2
on (finance1.ï»¿id=finance2.ï»¿id)
group by grade,sub_grade
order by grade,sub_grade;


-- [3] Total Payment for Verified Status Vs Total Payment for Non Verified Status

select verification_status,round(sum(total_pymnt)) as total_payment
from finance1
inner join finance2
on (finance1.ï»¿id=finance2.ï»¿id)
WHERE verification_status IN ('Verified', 'Not Verified')
group by verification_status
order by verification_status; 


 -- [4] State wise and last_credit_pull_d wise loan status


select addr_state,last_credit_pull_d,loan_status
FROM finance1
INNER JOIN finance2
on (finance1.ï»¿id=finance2.ï»¿id)
group by addr_state,last_credit_pull_d,loan_status
order by last_credit_pull_d;


-- [5] Home ownership Vs last payment date stats

select last_pymnt_d,home_ownership,round(sum(last_pymnt_amnt)) as Total_payment
FROM finance1
INNER JOIN finance2
on (finance1.ï»¿id=finance2.ï»¿id)
where home_ownership in ('RENT', 'MORTGAGE', 'OWN')
group by home_ownership,last_pymnt_d
having round(sum(last_pymnt_amnt)) != 0
order by home_ownership,last_pymnt_d,
round(sum(last_pymnt_amnt)) desc;


Select
YEAR(STR_TO_DATE(finance2.last_pymnt_d, "%b-%yy")) as 'Years'
,finance1.home_ownership
,round(sum(finance2.last_pymnt_amnt)) as 'Total_Payment'
from finance1 join finance2 on finance1.ï»¿id=finance2.ï»¿id
where finance1.home_ownership in ('RENT', 'MORTGAGE', 'OWN')
group by finance1.home_ownership, years
having round(sum(finance2.last_pymnt_amnt)) != 0
order by YEAR(STR_TO_DATE(finance2.last_pymnt_d, "%b-%yy")), round(sum(finance2.last_pymnt_amnt)) desc;