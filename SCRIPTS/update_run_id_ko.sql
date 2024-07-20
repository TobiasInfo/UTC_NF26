-- Update Last Run Status to OK and End Time
UPDATE TCH.T_SUIV_RUN
SET RUN_END_DTTM = CURRENT_TIMESTAMP(0), RUN_STTS_CD = 'KO'
WHERE RUN_ID = (SELECT MAX(RUN_ID) FROM TCH.T_SUIV_RUN);