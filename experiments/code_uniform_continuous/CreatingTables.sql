CREATE TABLE data_log(
prim_subject DEC(20,10) PRIMARY KEY,
workerID MEDIUMTEXT,
subjectID DEC(20,0),
dateInfo MEDIUMTEXT,
background MEDIUMTEXT,
conditionProto MEDIUMTEXT,
success MEDIUMTEXT,
trial_type MEDIUMTEXT,
trial_index DEC(20,0),
time_elapsed DEC(20,0),
internal_node_id MEDIUMTEXT,
responses MEDIUMTEXT,
question_order MEDIUMTEXT,
stimulus MEDIUMTEXT,
stimulus_type MEDIUMTEXT,
button_pressed DEC(10,0),
key_press DEC(10,0),
correct MEDIUMTEXT,
response MEDIUMTEXT,
prompt MEDIUMTEXT,
stimLeft MEDIUMTEXT,
stimRight MEDIUMTEXT,
targetSide MEDIUMTEXT
);

CREATE TABLE condition_log(
rowID INT AUTO_INCREMENT PRIMARY KEY, 
subjectID DEC(5,0), 
assignedCondition MEDIUMTEXT)
);

CREATE TABLE register_log(
rowID INT AUTO_INCREMENT PRIMARY KEY,
workerID VARCHAR(20),
completionCode VARCHAR(20)
); 
