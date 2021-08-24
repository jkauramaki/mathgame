# Presentation template for math exercise. 
# 
# Some features / notes
# - reads in previously done mistakes from file "matikka_mistakes.txt" or "practice_mistakes.txt" 
#   from logfile directory => place logfile directory under subdirectory "logs", 
#   e.g. matikka\logs and set Presentation settings accordingly, create at least
#   an empty placeholder file with this name
# - this mistakes is automatically updated halfway during the pause trial
# - besides Presentation file "full" logfile, writes a clean logfile with
#   prefix "clean_" inside logfile, with structure like below
#
#Subject	Trial	EqNo	Eq	EqCorr	Resp	RT	Correct
#none	1	3	42:o=7	true	2	922	true
#none	2	7	3*o=24	true	2	2475	true
#none	3	2	8+5=v	false	1	186	true
#none	4	4	45:v=5	false	1	2381	true
#none	5	8	v*3=27	false	1	1049	true
#none	6	6	v*7=56	false	1	1574	true
#none	7	10	22+36=o	true	2	186	true
#none	8	1	9+3=o	true	2	1279	true
#none	9	5	o*6=36	true	2	890	true
#none	10	9	55-8=v	false	1	742	true
# 
# - pause trial resumes with any button press
# - pause trial time points fixed in the end of main loop ("if i==N")
# - by default button 1 = left-side (incorrect), button 2 = right-side (correct)
# - practice portion reads equations from file "practice.txt" inside scenario folder,
#   real exercise from "matikkaeq.txt"
# - both files assume the syntax
#9+3=o
#9+3=12
#8+5=v
#8+5=12
#[...]
# => odd lines: priming line with missing number replaces by "o" (will be correct/"oikein") 
#    or "v" (will be incorrect/"väärin")
#    even lines: full equation to be shown
# => program parses & calculates the missing value
# => very simple syntax of only simple operators + - / *
#
# version history
# 2019-06-17	initial version with basic functionality (responsive buttons, simple log files etc)


scenario = "Matikka - harjoitusosio";
active_buttons=2;
button_codes=0,0;
write_codes=false;
pulse_width=10;

begin;

TEMPLATE "matikka_definitions.sce"; 

begin_pcl;
include "matikka.pcl";

string filename = "practice.txt";
string clean_log_suffix = "_clean_practice_log.txt";
string mistake_filename = "..\\logs\\practice_mistakes.txt";

include "matikka_mainloop.pcl";

