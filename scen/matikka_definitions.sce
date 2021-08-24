# common definitions for matikka, cannot be run on its own, with buttons on regular way 
# red button/"väärin" on left, green button/"oikein" on right

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
		background_color = 0,0,0; width=550; height=150; # was 192,0,0 => red
	} t_mistakes_own; x=-350; y=-200;
	text {
		font_size=40;
		caption = ""; # updated on PCL side
		font="Calibri";
		background_color = 0,0,0; width=550; height=150;  # was 192,0,0 => red
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
	trial_duration=forever;
	trial_type=first_response;
	nothing{}; time=0; duration=next_picture; code ="wait_keypress";
} wait_keypress;

trial{
	trial_duration=stimuli_length; # 10-second pause
	trial_type=first_response;
	picture pause_with_mistakes; time=0; duration=next_picture; code ="pause with mistakes trial";
	picture pause_with_mistakes; time=9995; duration=response; code ="pause 10s"; 
	port_code=20; 
} pause_trial;

trial{
	trial_duration=9995; # for 3000ms actual trial duration
	trial_type=fixed;
	picture end_with_feedback; time=0; duration=next_picture; code ="end trial";
} end_trial;

trial{
	trial_duration=2995; # for 3000ms actual trial duration
	trial_type=fixed;
	picture pic_trial_prime; time=0; duration=next_picture; code ="prime trial";
	port_code=16; 
} prime_trial;

trial{
	trial_duration=2995; # for 3000ms actual trial duration
	trial_type=first_response;
	picture pic_trial_target; time=0; duration=next_picture; code ="target trial"; 
	port_code=17; 
	target_button=1,2; # target button for response
} target_trial;

trial{
	trial_duration=2995; # for 3000ms actual trial duration
	trial_type=first_response;
	picture pic_trial_target; time=0; duration=next_picture; code ="target trial continuation";
	port_code=19; 
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
	port_code=121;
} timeout_trial;

	
trial{
	trial_duration=295; # for 100 ms actual trial duration
	trial_type=fixed;
	picture pic_trial_blank; time=0; duration=next_picture; code ="blank trial";
} blank_trial;

trial{
	trial_duration=stimuli_length; # 50, 100, 200 or 500 ms
	trial_type=fixed;
	sound { wavefile { filename = "fail2_100ms.wav"; }; }; time=10; duration=next_picture; code ="wrong answer feedback";
	port_code=30;
} wrong_answer_feedback;
