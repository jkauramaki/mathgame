# mathgame - Math game in Presentation
Math gamed used in Puusepp et al. https://doi.org/10.3389/fpsyg.2021.635972 for experimental usage (neuroscience, psychology). Meant for elementary school students, using simple four-operator calculations (+ - * / ). Coded in commercial Presentation language (v20.3, available https://neurobs.com) for accurate stimulus-trigger presentation. Includes a small Matlab parser to check the validity of input files (usage e.g. <tt>parse_matikka(['scen' filesep 'matikka_helpot.txt'])</tt>);.

## General notes
- Has both "normal" and reversed mode (reverse correct/incorrect button choices)
- reuses base code (includes matikka.pcl, matikka_mainloop.pcl and matikka_definitions.sce/matikka_definitions_reverse.sce to minimize copy&paste requirements)
- Several input files (plain text) where the equations are loaded up
- Besides "normal" Presentation log, writes a simplified log file
- By default, tries to write trigger codes for EEG synchronization. This requires some output definition in Presentation software. Try out the practice scenario for a game without triggers, or even slower-pace slow practice
- All the main files have comment blocks in the beginning
- The experiment has a few pre-cut options for wrong answer auditory feedback. Sounds with "fail" on its name are cut from "Sad Trombone.wav" https://freesound.org/s/73581/ (CC BY 3.0, unedited otherwise, only trimmed). Sounds with "fail2" on on file name are from "buzzer2.wav" https://freesound.org/s/164089/ (CC0 1.0). Currently edited version is using 100-ms extract from "buzzer2.wav". The feedback sound can be changed by editing matikka_definitions*.sce

## Input file notes
Input file has the equations shown to the subject. Odd lines have priming line with missing number: letter "o" corresponds to correct answer (Finnish "oikea"), "v" for incorrect ("väärin"). The letter is replaced by an underscore during the experiment run, and the Presentation file calculates the missing value. Even lines have the full equation to be shown. See scen/*.txt for examples of syntax ("matikka-helpot" for easy tasks, "matikka-vaikeat" for slightly harder). Input file looks like 
<pre>
7+6=o
7+6=13
6+9=v
6+9=14
11-3=o
11-3=8
12-7=v
12-7=6
13-6=o
13-6=7
3*o=24
3*8=24
v*3=27
8*3=27
o:2=7
14:2=7
</pre>

The scen directory includes the history of files from previous measurement sessions ("syksy2019" for autumn 2019, "kevät2020" for equations used in spring 2020, being progressively harder).
