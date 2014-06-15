%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%                                                                     %%%%%
%%%%%    qbschedule class file for typesetting quizbowl schedules         %%%%%
%%%%%    Copyright 2014, Jonah Greenthal <jonah@jonahgreenthal.com>       %%%%%
%%%%%    You can use, modify, and distribute this in any way you want,    %%%%%
%%%%%    as long as you give credit.                                      %%%%%
%%%%%                                                                     %%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\ProvidesClass{qbschedule}[2014/05/08 version 0.1]
\NeedsTeXFormat{LaTeX2e}
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{article}}
\ProcessOptions\relax
\LoadClass[12pt]{article}

\RequirePackage[none]{hyphenat}
\RequirePackage{fontspec}
%\RequirePackage{cmap}
\RequirePackage{microtype}
\RequirePackage{calc}
\RequirePackage{etoolbox}
\RequirePackage{arrayjobx}
\RequirePackage[table]{xcolor}
	\definecolor{gray}{rgb}{0.8,0.8,0.8}
\RequirePackage{bigstrut}
\RequirePackage{array}
	\newcolumntype{x}[1]{>{\centering\hspace{0pt}}m{#1}}
	\newcolumntype{y}[1]{>{\raggedright\hspace{0pt}}m{#1}}
	\newcolumntype{z}[1]{>{\raggedleft\hspace{0pt}}m{#1}}


\setlength\parindent{0pt}
\setlength\parskip{20pt}
\setlength\tabcolsep{2pt}
\renewcommand{\arraystretch}{1.25}

\newlength{\TournamentNameSize}					\setlength\TournamentNameSize{24pt}
\newlength{\TournamentSubtitleSize}				\setlength\TournamentSubtitleSize{16pt}
\newlength{\PhaseSize}							\setlength\PhaseSize{20pt}
\newlength{\PoolSize}							\setlength\PoolSize{18pt}
\newlength{\RoomSize}							\setlength\RoomSize{16pt}
\newlength{\StaffSize}							\setlength\StaffSize{12pt}
\newlength{\BuzzerSize}							\setlength\BuzzerSize{12pt}
\newlength{\RoundSize}							\setlength\RoundSize{14pt}
\newlength{\TeamNameSize}						\setlength\TeamNameSize{10pt}

\newlength{\LeftColumnWidth}					\setlength\LeftColumnWidth{1.50in}
\newlength{\RoomColumnWidth}					\setlength\RoomColumnWidth{1.01in}
\newlength{\ByeColumnWidth}						\setlength\ByeColumnWidth{1.1in}

\def\TournamentNameLineSpacingMultiplier		{1.25}
\def\TournamentSubtitleLineSpacingMultiplier	{1.25}
\def\PhaseLineSpacingMultiplier					{1.25}
\def\PoolLineSpacingMultiplier					{0.90}
\def\RoomLineSpacingMultiplier					{1.50}
\def\StaffLineSpacingMultiplier					{1.25}
\def\BuzzerLineSpacingMultiplier				{1.25}
\def\RoundLineSpacingMultiplier					{1.25}
\def\TeamNameLineSpacingMultiplier				{1.25}

\newlength{\TournamentNameLineSpacing}			\setlength\TournamentNameLineSpacing{\TournamentNameSize * \real{\TournamentNameLineSpacingMultiplier}}
\newlength{\TournamentSubtitleLineSpacing}		\setlength\TournamentSubtitleLineSpacing{\TournamentSubtitleSize * \real{\TournamentSubtitleLineSpacingMultiplier}}
\newlength{\PhaseLineSpacing}					\setlength\PhaseLineSpacing{\PhaseSize * \real{\PhaseLineSpacingMultiplier}}
\newlength{\PoolLineSpacing}					\setlength\PoolLineSpacing{\PoolSize * \real{\PoolLineSpacingMultiplier}}
\newlength{\RoomLineSpacing}					\setlength\RoomLineSpacing{\RoomSize * \real{\RoomLineSpacingMultiplier}}
\newlength{\StaffLineSpacing}					\setlength\StaffLineSpacing{\StaffSize * \real{\StaffLineSpacingMultiplier}}
\newlength{\BuzzerLineSpacing}					\setlength\BuzzerLineSpacing{\BuzzerSize * \real{\BuzzerLineSpacingMultiplier}}
\newlength{\RoundLineSpacing}					\setlength\RoundLineSpacing{\RoundSize * \real{\RoundLineSpacingMultiplier}}
\newlength{\TeamNameLineSpacing}				\setlength\TeamNameLineSpacing{\TeamNameSize * \real{\TeamNameLineSpacingMultiplier}}

\newbool{ShowPoolNames}							\setbool{ShowPoolNames}{true}
\newbool{ShowReaders}							\setbool{ShowReaders}{true}
\newbool{ShowScorekeepers}						\setbool{ShowScorekeepers}{true}
\newbool{ShowBuzzerAssignments}					\setbool{ShowBuzzerAssignments}{true}

\newrobustcmd{\invertedcell}[1]{\cellcolor{black}\color{white}#1}
\newrobustcmd{\emptyinvertedcell}{\invertedcell{ }}
\newrobustcmd{\switch}[1]{\hphantom{*}#1*}

\newcommand{\pool}[2]{\multicolumn{#1}{c|}{\invertedcell{\fontsize{\PoolSize}{\PoolLineSpacing}\selectfont\textbf{#2}}}\rule{0pt}{\PoolLineSpacing}}
\newcommand{\byepool}{\invertedcell{\fontsize{\PoolSize}{\PoolLineSpacing}\selectfont\textbf{Bye}}\rule{0pt}{\PoolLineSpacing}}
\newrobustcmd{\room}[1]{\invertedcell{\fontsize{\RoomSize}{\RoomLineSpacing}\selectfont\textbf{#1}}}
\newrobustcmd{\staff}[1]{\invertedcell{\fontsize{\StaffSize}{\StaffLineSpacing}\selectfont#1}}
\newrobustcmd{\buzzer}[1]{\invertedcell{\fontsize{\BuzzerSize}{\BuzzerLineSpacing}\selectfont#1}}
\newrobustcmd{\round}[1]{\fontsize{\RoundSize}{\RoundLineSpacing}\selectfont#1}

\newrobustcmd{\matchup}[2]{\fontsize{\TeamNameSize}{\TeamNameLineSpacing}\selectfont #1 \linebreak #2}
\newrobustcmd{\bye}[1]{\fontsize{\TeamNameSize}{\TeamNameLineSpacing}\selectfont #1}
\newrobustcmd{\nomatch}[1]{\fontsize{\TeamNameSize}{\TeamNameLineSpacing}\selectfont no match}

\pagestyle{empty}

\newcommand{\Header}{ % Designed to be overridden in individual schedules with \renewcommand
	\ifdef{\MainFont}{\setmainfont[Ligatures=TeX]{\MainFont}}{}
	{\fontsize{\TournamentNameSize}{\TournamentNameLineSpacing}\selectfont\textbf{\TournamentName}}{}\\
	\ifdef{\TournamentSubtitle}{{\fontsize{\TournamentSubtitleSize}{\TournamentSubtitleLineSpacing}\selectfont\textit{\TournamentSubtitle}\\}}{}
	\ifdef{\Phase}{{\fontsize{\PhaseSize}{\PhaseLineSpacing}\selectfont\Phase}}{}
}

\newcommand{\Footer}{ % Designed to be overridden in individual schedules with \renewcommand
	\ifdef{\ControlRoom}{\vfill The control room is \ControlRoom.}{}
}

\AtBeginDocument{
	\Header
}

\AtEndDocument{
	\Footer
}
