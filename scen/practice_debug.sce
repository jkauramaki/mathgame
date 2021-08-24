# Presentation template for math exercise. 
# 
# Some features / notes
# - reads in previously done mistakes from file "mistakes.txt" or "practice_mistakes.txt" 
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
#   real exercise from "tasks.txt"
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
button_codes=1,2;

begin;

picture {} default; 

picture {
	text {
		font_size=100;
		caption = ""; # updated on PCL side
		font="Calibri";
	} t_equation_prime; x=0; y=0; 
	text {
		font_size=40;
		caption = "väärin"; # updated on PCL side
		font="Calibri";
		background_color = 192,0,0; width=300; height=100; 
	} t_incorrect_prime; x=-550; y=-300;
	text {
		font_size=40;
		caption = "oikein"; # updated on PCL side
		font="Calibri";
		background_color = 0,176,80; width=300; height=100; 
	} t_correct_prime; x=550; y=-300; 
} pic_trial_prime;

picture {
	text {
		font_size=100;
		caption = ""; # updated on PCL side
		font="Calibri";
	} t_equation_target; x=0; y=0; 
	text {
		font_size=40;
		caption = "väärin"; # updated on PCL side
		font="Calibri";
		background_color = 192,0,0; width=300; height=100; 
	} t_incorrect_target; x=-550; y=-300;
	text {
		font_size=40;
		caption = "oikein"; # updated on PCL side
		font="Calibri";
		background_color = 0,176,80; width=300; height=100; 
	} t_correct_target; x=550; y=-300; 
} pic_trial_target;

picture {
	text {
		font_size=100;
		caption = ""; # updated on PCL side
		font="Calibri";
	} t_equation_answer; x=0; y=0; 
	text {
		font_size=40;
		caption = "väärin"; # updated on PCL side
		font="Calibri";
		background_color = 192,0,0; width=300; height=100; 
	} t_incorrect_answer; x=-550; y=-300;
	text {
		font_size=40;
		caption = "oikein"; # updated on PCL side
		font="Calibri";
		background_color = 0,176,80; width=300; height=100; 
	} t_correct_answer; x=550; y=-300; 
} pic_trial_answer;

picture {
	text {
		font_size=40;
		caption = "väärin"; # updated on PCL side
		font="Calibri";
		background_color = 192,0,0; width=300; height=100; 
	} t_incorrect_blank; x=-550; y=-300;
	text {
		font_size=40;
		caption = "oikein"; # updated on PCL side
		font="Calibri";
		background_color = 0,176,80; width=300; height=100; 
	} t_correct_blank; x=550; y=-300; 
} pic_trial_blank;

picture {
	text {
		font_size=100;
		caption = "TAUKO"; # updated on PCL side
		font="Calibri";
	} t_pause; x=0; y=100; 
	text {
		font_size=40;
		caption = "TEIT <u>27</u> VIRHETTÄ"; # updated on PCL side
		font="Calibri";
		background_color = 192,0,0; width=550; height=150; 
	} t_mistakes_own; x=-350; y=-200;
	text {
		font_size=40;
		caption = "MUILLA KESKIMÄÄRIN
<u>19</u> VIRHETTÄ"; # updated on PCL side
		font="Calibri";
		background_color = 192,0,0; width=550; height=150; 
	} t_mistakes_avg; x=350; y=-200; 
} pause_with_mistakes;


picture {
	text {
		font_size=100;
		caption = "TAUKO"; # updated on PCL side
		font="Calibri";
	} t_pause_only; x=0; y=100; 
} pause_only;

picture {
	text {
		font_size=100;
		caption = "LOPPU"; # updated on PCL side
		font="Calibri";
	} t_end; x=0; y=100; 
	text {
		font_size=40;
		caption = "OIKEITA VASTAUKSIA
YHTEENSÄ: <u>94</u>"; # updated on PCL side
		font="Calibri";
		background_color = 0,176,8; width=500; height=200; 
	} t_correct_ans; x=0; y=-100;
	text {
		font_size=50;
		caption = "<b>HIENO SUORITUS!</b>"; # updated on PCL side
		font="Calibri";
	} t_feedback; x=0; y=-250; 
} end_with_feedback;

picture {
	text {
		font_size=100;
		caption = "AIKA LOPPUI!"; # updated on PCL side
		font="Calibri";
	} t_timeout; x=0; y=0; 
	text {
		font_size=40;
		caption = "väärin"; # updated on PCL side
		font="Calibri";
		background_color = 192,0,0; width=300; height=100; 
	} t_incorrect_timeout; x=-550; y=-300;
	text {
		font_size=40;
		caption = "oikein"; # updated on PCL side
		font="Calibri";
		background_color = 0,176,80; width=300; height=100; 
	} t_correct_timeout; x=550; y=-300; 
} pic_trial_timeout;


trial{
	trial_duration=2995;
	trial_type=fixed;
	picture pause_only; time=0; duration=next_picture; code ="pause trial";
} pause_only_trial;

trial{
	trial_duration=stimuli_length; # 10-second pause
	trial_type=first_response;
	picture pause_with_mistakes; time=0; duration=next_picture; code ="pause with mistakes trial";
	picture pause_with_mistakes; time=9995; duration=response; code ="pause 10s"; 
	#port_code=20; 
} pause_trial;

trial{
	trial_duration=9995; # for 3000ms actual trial duration
	trial_type=fixed;
	picture end_with_feedback; time=0; duration=next_picture; code ="end trial";
} end_trial;

trial{
	trial_duration=2995; # for 3000ms actual trial duration
	trial_type=fixed;
	#port_code=16; 
	picture pic_trial_prime; time=0; duration=next_picture; code ="prime trial";
} prime_trial;

trial{
	trial_duration=2995; # for 3000ms actual trial duration
	trial_type=first_response;
	picture pic_trial_target; time=0; duration=next_picture; code ="target trial"; 
	#port_code=17; 
	target_button=1,2; # target button for response
} target_trial;

trial{
	trial_duration=2995; # for 3000ms actual trial duration
	trial_type=first_response;
	picture pic_trial_target; time=0; duration=next_picture; code ="target trial continuation";
	#port_code=19; 
	target_button=1,2; # target button for response
} target_trial_continuation;

trial{
	trial_duration=2995; # for 3000ms actual trial duration
	trial_type=fixed;
	picture pic_trial_answer; time=0; duration=next_picture; code ="correct trial";
	#port_code=18; 
} correct_answer_trial;


trial{
	trial_duration=495; # for 500ms actual trial duration
	trial_type=fixed;
	picture pic_trial_timeout; time=0; duration=next_picture; code ="timeout trial";
	#port_code=121 
} timeout_trial;

	
trial{
	trial_duration=295; # for 100 ms actual trial duration
	trial_type=fixed;
	picture pic_trial_blank; time=0; duration=next_picture; code ="blank trial";
} blank_trial;

begin_pcl;
include "matikka.pcl";

int lastRespCount;
int lastResp;
int lastRT;

array<int> eqRating[0];
array<int> eqRT[0];

# read in trials
string filename = "practice.txt";

input_file f = new input_file;
f.open( filename );

# --- String pairs --- #
array<string> all_lines[0];
string str = f.get_line();
loop until !f.last_succeeded() begin
	all_lines.add(str);
	str = f.get_line();
end;
f.close();

# --- Separate lines --- #
array<string> prime_line[0]; # first line the pair
array<string> target_line[0]; # second line
array<string> words[0]; # dummy array

loop int i = 1; until i > all_lines.count() begin
	if (mod(i,2) == 1) then
		prime_line.add(all_lines[i]);
	else
		target_line.add(all_lines[i]);
	end;
	i = i +1;
end;

term.print_line("array<string> prime_lines[" + string(prime_line.count()) + "] = (");
loop int i = 1; until i > prime_line.count() begin
	term.print_line("\"" + prime_line[i] + "\",");
	i = i +1;
end;
term.print_line(");");

array <int> trial_order[prime_line.count()];
trial_order.fill(1,trial_order.count(),1,1);
trial_order.shuffle();

term.print("array<int> trial_order[" + string(trial_order.count()) + "] = (");
loop int i = 1; until i > prime_line.count() begin
	term.print(string(trial_order[i]) + ",");
	i = i +1;
end;
term.print_line(");");


term.print_line("correct lines[" + string(prime_line.count()) + "] = (");
loop int i = 1; until i > prime_line.count() begin
	term.print_line("\"" + show_correct(prime_line[i]) + "\",");
	i = i +1;
end;
term.print_line(");");

term.print_line("prime lines[" + string(prime_line.count()) + "] = (");
loop int i = 1; until i > prime_line.count() begin
	term.print_line("\"" + show_prime(prime_line[i]) + "\",");
	i = i +1;
end;
term.print_line(");");

term.print_line("target lines[" + string(prime_line.count()) + "] = (");
loop int i = 1; until i > prime_line.count() begin
	term.print_line("\"" + show_target(prime_line[i],target_line[i]) + "\",");
	i = i +1;
end;
term.print_line(");");

term.print_line("is_correct [" + string(prime_line.count()) + "] = (");
loop int i = 1; until i > prime_line.count() begin
	term.print_line("\"" + string(is_correct(prime_line[i])) + "\",");
	i = i +1;
end;
term.print_line(");");


# set texts as formatted to allow bold+underline text
t_equation_prime.set_formatted_text( true ); t_incorrect_prime.set_formatted_text( true ); t_correct_prime.set_formatted_text( true );
t_equation_target.set_formatted_text( true ); t_incorrect_target.set_formatted_text( true ); t_correct_target.set_formatted_text( true );
t_equation_answer.set_formatted_text( true ); t_incorrect_answer.set_formatted_text( true ); t_correct_answer.set_formatted_text( true );
t_pause.set_formatted_text( true );
t_mistakes_own.set_formatted_text( true ); 
t_mistakes_avg.set_formatted_text( true );
t_pause_only.set_formatted_text( true ); 
t_end.set_formatted_text( true );
t_correct_ans.set_formatted_text( true );
t_feedback.set_formatted_text( true );

# --- Write log --- #
output_file mylog = new output_file; # create new custom logfile
string subj_string=logfile.subject();
if subj_string == "" then
		subj_string="none";
end;
string mylog_name="" + subj_string + "_clean_practice_log.txt";
if file_exists(logfile_directory + mylog_name) then
	loop
		int i = 1
	until
		(file_exists(logfile_directory + mylog_name) == false) || i > 50 
	begin
		mylog_name = subj_string + string(i) + "_clean_practice_log.txt";
		i = i + 1
	end;
end;
mylog.open(mylog_name, false ); # don't overwrite
mylog.print("Subject\tTrial\tEqNo\tEq\tEqCorr\tResp\tRT\tCorrect\n");

# start main loop
int target_stim_time_in;
int n_mistakes_own=0,n_correct=0;
int avg_n_mistakes_others=read_avg_mistakes("..\\logs\\practice_mistakes.txt");
bool is_resp_correct; # was the last response correct
term.print_line("read_avg_mistakes(): avg_n_mistakes_others = " + string(avg_n_mistakes_others));

loop int i = 1; until i > trial_order.count() begin
	int eq_no=trial_order[i];
	
	term.print_line("trial" + string(i) + ": equation: " + prime_line[eq_no]);

	t_equation_prime.set_caption( show_prime(prime_line[eq_no]) );
	t_equation_prime.redraw();
	prime_trial.present();
	
	t_equation_target.set_caption( show_target(prime_line[eq_no],target_line[eq_no]) ); t_equation_target.redraw();
	# reset correct/incorrect buttons
	t_incorrect_target.set_caption("väärin"); t_incorrect_target.redraw();
	t_correct_target.set_caption("oikein"); t_correct_target.redraw();
	target_trial.set_duration(2995);
	
	# present target trial and parse response, show feedback (bold-face answer), allow changing the response
	target_stim_time_in=clock.time_dms();
	target_trial.present();
	
	response_data last;
	stimulus_data last_stim=stimulus_manager.last_stimulus_data();
	
	if (bool( response_manager.response_count() ) && bool( stimulus_manager.stimulus_count() )) then
		last = response_manager.last_response_data();
		lastRT=last_stim.reaction_time();
		lastResp=response_manager.last_response();
		term.print_line("trial" + string(i) + " resp detected: " + string(lastResp) + " / " + string(lastRT) + " ms; target_trial_time_left=" + string((target_stim_time_in+29950-clock.time_dms())/10));
		loop
			int target_trial_time_left = (target_stim_time_in+29950-clock.time_dms())/10; # time_dms in TENTHS of ms => divide by 10
			bool first_presentation=true;
		until
			target_trial_time_left <= 0
		begin
			lastResp=response_manager.last_response();
			if lastResp==1 then
				t_incorrect_target.set_caption("<b>väärin</b>"); t_incorrect_target.redraw();
				t_correct_target.set_caption("oikein"); t_correct_target.redraw();
			elseif lastResp==2 then
				t_incorrect_target.set_caption("väärin"); t_incorrect_target.redraw();
				t_correct_target.set_caption("<b>oikein<b>"); t_correct_target.redraw();
			end;
			target_trial_continuation.set_duration(target_trial_time_left);
			term.print_line("trial" + string(i) + " resp detected: new trial duration (for feedback) " + string(target_trial_time_left) + " ms");
			target_trial_continuation.present();
			last = response_manager.last_response_data();
			last_stim = stimulus_manager.last_stimulus_data();
			if (bool( response_manager.response_count() ) && bool( stimulus_manager.stimulus_count() )) then
				if (first_presentation) then
					lastRT=last_stim.reaction_time(); 
					first_presentation=false;
				else
					lastRT=lastRT+last_stim.reaction_time(); # in case subject changes the response, sum the current + previous RTs
				end;
				lastResp=response_manager.last_response();
			end;
			
			target_trial_time_left = (target_stim_time_in+29950-clock.time_dms())/10; # time_dms in TENTHS of ms => divide by 10
		end;
	else
		# no response within time, show brief timeout trial
		timeout_trial.present();
		lastResp=0;
		lastRT=-1;
	end;

	term.print_line("trial" + string(i) + ": adding resp / RT: " + string(lastResp) + " / " + string(lastRT) + " ms");
	eqRating.add(lastResp);
	eqRT.add(lastRT);
	
	is_resp_correct=false;
	# change also the correct trial feedback on buttons to indicate
	if lastResp==1 then
		t_incorrect_answer.set_caption("<b>väärin</b>"); t_incorrect_answer.redraw();
		t_correct_answer.set_caption("oikein"); t_correct_answer.redraw();
		if is_correct(prime_line[eq_no])==true then # respond "incorrect" but equation was right
			n_mistakes_own=n_mistakes_own+1;
			term.print_line("trial" + string(i) + ": adding mistake due resp incorrect/eq correct");
		else
			is_resp_correct=true;
			n_correct=n_correct+1;
		end;
	elseif lastResp==2 then
		t_incorrect_answer.set_caption("väärin"); t_incorrect_answer.redraw();
		t_correct_answer.set_caption("<b>oikein<b>"); t_correct_answer.redraw();
		if is_correct(prime_line[eq_no])==false then # respond "correct" but equation was wrong
			n_mistakes_own=n_mistakes_own+1;
			term.print_line("trial" + string(i) + ": adding mistake due resp correct/eq wrong");
		else
			is_resp_correct=true;
			n_correct=n_correct+1;
		end;
	else
		n_mistakes_own=n_mistakes_own+1; # no answer / miss, always add to error count
		term.print_line("trial" + string(i) + ": adding mistake due to no answer");
		t_incorrect_answer.set_caption("väärin"); t_incorrect_answer.redraw();
		t_correct_answer.set_caption("oikein"); t_correct_answer.redraw();
	end;
	
	t_equation_answer.set_caption( show_correct(prime_line[eq_no]) );
	t_equation_answer.redraw();
	correct_answer_trial.present();

	# add log file
	#mylog.print("Subject\tTrial\tEqNo\tEq\tEqCorr\tResp\tRT\tCorrect\n");
	mylog.print(subj_string + "\t" + string(i) + "\t" + string(eq_no) + 
		"\t" + prime_line[eq_no] + "\t" + string(is_correct(prime_line[eq_no])) + 
		"\t" + string(lastResp) + "\t" + string(lastRT) + "\t" + string(is_resp_correct) + "\n");

	blank_trial.present();
	
	if i==5 then
		if n_mistakes_own==1 then
			t_mistakes_own.set_caption("TEIT <u>" + string(n_mistakes_own) + "</u> VIRHEEN"); t_mistakes_own.redraw();
		else
			t_mistakes_own.set_caption("TEIT <u>" + string(n_mistakes_own) + "</u> VIRHETTÄ"); t_mistakes_own.redraw();
		end;
		t_mistakes_avg.set_caption("MUILLA KESKIMÄÄRIN\n<u>" + string(avg_n_mistakes_others) + "</u> VIRHETTÄ"); t_mistakes_avg.redraw();
		add_mistakes("..\\logs\\practice_mistakes.txt",n_mistakes_own); # append mistakes so far to a special log file
		pause_trial.present();
	end;

	i = i + 1; 

end;

mylog.close();

# show end trial with number of correct answers
t_correct_ans.set_caption("OIKEITA VASTAUKSIA\nYHTEENSÄ: <u>" + string(n_correct) + "/" + string(trial_order.count()) + "</u>"); t_correct_ans.redraw();
t_feedback.redraw();
end_trial.present();


