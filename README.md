# qbschedule

qbschedule is a [LaTeX](http://www.latex-project.org/) class for making schedules for [quizbowl](http://www.naqt.com/about-quiz-bowl.html) tournaments, together with a collection of schedule templates.

## Features

- Round-robin and pooled-round-robin schedules
- Snake-seeded preliminary schedules
- Tiered playoff schedules, with repeat matches avoided when possible
- Preliminary and playoff schedules combined when feasible
- Include pool names, buzzer system assignments, staff assignments
- Intended to be easy to customize

## Use
The files are intended to be pretty self-documenting. If you're already fairly comfortable with LaTeX, just download `qbschedule.cls` and the template `.tex` file(s) that you want, open them up in an editor, and do what it looks like you should do. Make sure to compile with `xelatex`. More detailed instructions follow.

1. If you don't already have it, download and install LaTeX. [Here are some guides that may be helpful.](http://latex-project.org/ftp.html)
1. Download `qbschedule.cls` and the template `.tex` file(s) that you want to use.
1. Open the template file(s) in your favorite text editor (e.g. `vim` or `emacs` for Unix/Linux, [Notepad++](http://notepad-plus-plus.org/) for Windows, or [TextMate](http://macromates.com/) for Mac).
1. Change the settings near the top of the template file. You probably want to change…
    - `TournamentName`, whose name is probably self-explanatory
    - `TournamentSubtitle`. For instance, this might contain the expansion of an acronym that is your tournament's name, text like `Hosted by Central High School`, etc. If you don't want to use a subtitle, you should delete this line.
    - `Phase`, which is intended to indicate the portion of the tournament this schedule describes, e.g. preliminary rounds or playoffs. If this isn't applicable, you should delete this line.
    - `ControlRoom`. This will be displayed at the bottom of the schedule. If you don't want this displayed, you should delete this line.
    - `MainFont`. You should be able to change this to the name of any font you have on your system, e.g. `Arial`, `Garamond`, `Times New Roman`, or `Comic Sans MS`.
    - The boolean values `ShowPoolNames` (if applicable), `ShowReaders`, `ShowScorekeepers`, and `ShowBuzzerAssignments`. These mean what they sound like they mean.
    - Entries in the seeding array(s), which have names like `\Seed` or (for playoff schedules) `\PoolA`. You change their entries by modifying lines that look like `\Seed(1)={Team 1}`; the `Team 1` part should be changed to the name of the first seed, etc. For full (or multiple) round robins, of course, the seeding doesn't really matter, but generally speaking, matches between top seeds take place later in the schedule.
    - Entries in the arrays related to pool names (if applicable), rooms, readers, scorekeepers, and buzzers. These should be named in a fairly self-explanatory fashion and should be modified analogously to the seeding array(s). For the reader and scorekeeper arrays, you can surround an entry with `\switch{`…`}`, which will put an asterisk after the staffer's name in the output (while maintaining correct centering of the substantive text) and is intended to indicate that the reader and scorekeeper in that room should actually switch off in each of those roles.
- Save the file.
- Compile the file by running `xelatex` on it. That is, open a terminal or command prompt, navigate to the folder you are working in, and run the command `xelatex theFileName.tex`.

## There's no template for my format!
Open up an [issue](https://github.com/jonahgreenthal/qbschedule/issues) and I'll try to make one. Pull requests are also welcome.

## Resources
This project was announced in [a thread on the Quizbowl Resource Center](http://hsquizbowl.org/forums/viewtopic.php?f=123&t=15996); there might be some discussion of it there.

## LaTeX dependencies
These packages can be installed from [CTAN](http://www.ctan.org/), or — if you are on Windows — installed automatically upon first run using [MiKTeX](http://miktex.org/).

- [array](http://www.ctan.org/pkg/array) (core package) for defining custom column types
- [calc](http://www.ctan.org/pkg/calc) (core package) for computing with lengths and counters
- [arrayjobx](http://www.ctan.org/pkg/arrayjobx) for handling arrays that contain parameters for making the schedules (e.g. teams by seed)
- [bigstrut](http://www.ctan.org/pkg/bigstrut) for managing row heights
- [etoolbox](http://www.ctan.org/pkg/etoolbox) for conditional statements and boolean settings
- [fontspec](http://ctan.org/pkg/fontspec) for font management in XeLaTeX
- [hyphenat](http://www.ctan.org/pkg/hyphenat) to prevent hyphenation
- [microtype](http://www.ctan.org/pkg/microtype) for improved prettiness
- [xcolor](http://www.ctan.org/pkg/xcolor) for setting row shading
