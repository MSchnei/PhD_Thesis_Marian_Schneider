\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{mttTemplate}[2017/12/12 PhD Dissertation Style]
\LoadClassWithOptions{scrbook}

%% For allowing double spaces 
\usepackage{setspace}

%% For adding copyrights
\usepackage{textcomp}

%% For comparing strings for boolean comparisons
\usepackage{xstring}

%% For fancy headers and footers
\usepackage[automark,headsepline]{scrlayer-scrpage}

%% For advanced conditionals
\usepackage{etoolbox}

% For the extra parsing required in the chapter command
\usepackage{xparse}

% For utf8 symbols in the text
\usepackage[utf8]{inputenc}

% Set the header style, chapter header verso, nothing recto
\renewcommand*{\chaptermarkformat}{Chapter~\thechapter. \enskip}
\rohead{}

% The addmargin environment without the big vertical skip
\newenvironment{addmarginnobigskip}{\setlength{\parskip}{0pt plus 1pt}\addmargin}{\endaddmargin}

% Environment for pushing a paragraph to the bottom of the page
\newenvironment{bottomparagraph}{\par\vspace*{\fill}}{}

% The header page with the title and author
\newcommand{\headerpage}{
	\thispagestyle{empty}
	\begin{center}
		\vspace*{\stretch{1}}

		{\large\bfseries {Doctoral thesis}}
		\\~\\
		\begin{spacing}{1.5}
		{\large\bfseries\MakeUppercase {\thesistitle}}
		\end{spacing}

		\vspace{\stretch{0.5}}

		{\large {\thesisauthor}}
		\\~\\
		\thesisyear
		\vspace{\stretch{2}}

	\end{center}
  \clearpage
}

% Copyright page
\newcommand{\copyrightpage}{
	\thispagestyle{empty}
	\begin{bottomparagraph}

	\textcopyright \space \thesisauthor, Maastricht \thesisyear. \\
	All rights reserved. No part of this publication may be reproduced, stored in a retrieval system or transmitted in any form or by any means, electronic, mechanical, photocopying, recording or otherwise, without prior written permission of the author.
	\\~\\
	\begin{tabular}{@{}ll@{}}
		Cover & \coverdetails \\
		Production & \productiondetails \\
		ISBN & \isbnnumber
	\end{tabular}

	\end{bottomparagraph}
	\clearpage
}

% Thesis title page with obligatory text
\newcommand{\thesistitlepage}{
	\thispagestyle{empty}
	\begin{center}
		\vspace*{\stretch{1.5}}

		\begin{spacing}{1.5}
		{\large\bfseries\MakeUppercase {\thesistitle}}
		\end{spacing}

		\vspace{\stretch{2}}

		Dissertation\\~\\
		To obtain the degree of Doctor at Maastricht University,\\
		on the authority of the Rector Magnificus, Prof. Dr. R.M. Letschert,\\
		in accordance with the decision of the Board of Deans,\\
		to be defended in public \\
		on \thesisdefendingdate, at \thesisdefendingtime
		\\~\\
		by \\~\\
		\thesisauthorfull

		\vspace{\stretch{1}}
	\end{center}
	\clearpage
}

% Flip the printer margins from left to right
\newcommand{\flipbindingmargins}{
	\let\tmp\oddsidemargin
	\let\oddsidemargin\evensidemargin
	\let\evensidemargin\tmp
	\reversemarginpar
}

% The info page with the promotor information and the legal stuff
\newcommand{\infopage}[1][false]{
	\thispagestyle{empty}

	\begin{flushleft}
		\textbf{Promotor}
		\begin{addmarginnobigskip}[1em]{1em}
			\thesispromotors
		\end{addmarginnobigskip}

		\vspace{1em}

		\textbf{Copromotor}
		\begin{addmarginnobigskip}[1em]{2em}
			\thesiscopromotors
		\end{addmarginnobigskip}

		\vspace{2em}

		\textbf{Assessment Committee} \\
		\begin{addmarginnobigskip}[1em]{2em}
			\assessmentcommittee
		\end{addmarginnobigskip}

	\end{flushleft}

	\vfill

	The research presented in this thesis was supported by the Netherlands Organisation for Scientific Research (NWO) Research Talent grant
	    406-14-108 awarded to Marian Schneider and Rainer Goebel.

	\clearpage
}

% The dedication markup, use as \dedication{My text}
\renewcommand{\dedication}[1]{
	\newenvironment{dedicationenv}
	{
		\clearpage           % we want a new page
		\thispagestyle{empty}% no header and footer
		\vspace*{\stretch{1}}% some space at the top
		\itshape             % the text is in italics
		\centering           % put it in the center
	}
	{\par % end the paragraph
		\vspace{\stretch{4}} % space at bottom is three times that at the top
		\clearpage           % finish off the page
	}

	\begin{dedicationenv}
		#1
	\end{dedicationenv}
}

% Table of contents with some specific styling
\let\oldtableofcontents\tableofcontents
\renewcommand\tableofcontents{%
	\cleardoublepage
	% Show table of contents in PDF index (hyperrefpackage):
	\belowpdfbookmark{Table of contents}{content}
	\pagenumbering{gobble}
	\setcounter{tocdepth}{1}
	\oldtableofcontents
}

% Set the title style
\KOMAoption{chapterprefix}{true}
\renewcommand{\chaptername}{}
\renewcommand*{\raggedchapter}{\raggedleft}
\setkomafont{chapterprefix}{\fontsize{70}{0} \selectfont}
\setkomafont{chapter}{\normalfont\huge}

% Automatically start the minitoc in the frontmatter
\let\oldfrontmatter\frontmatter
\renewcommand\frontmatter{\oldfrontmatter \renewcommand*{\chapterheadstartvskip}{\vspace*{0\baselineskip}} \renewcommand{\chaptername}{}}

% Set the chapter style for the main matter
\let\oldmainmatter\mainmatter
\renewcommand\mainmatter{\oldmainmatter \renewcommand*{\chapterheadstartvskip}{\vspace*{8\baselineskip}}}

% Change the chapter index in the backmatter
\let\oldbackmatter\backmatter
\renewcommand\backmatter{\oldbackmatter \renewcommand*{\chapterheadstartvskip}{\vspace*{0\baselineskip}}}

% For citing the work a chapter came from
\newcommand{\papercitation}[2]{
	\begin{bottomparagraph}
		\rule{0.5\textwidth}{0.1pt}\\
		 \hspace*{1em} Adapted from: \bibentry{#1}. #2.
	\end{bottomparagraph}
}

% For changing the numbering of supplementary figures and tables
\newcommand{\beginsupplement}{%
        \setcounter{table}{0}
        \renewcommand{\thetable}{S\arabic{table}}%
        \setcounter{figure}{0}
        \renewcommand{\thefigure}{S\arabic{figure}}%
     }

% Set fonts for the section headers
% Set the section headers
\setkomafont{disposition}{\scshape\mdseries\rmfamily}
% but that also sets the TOC entries, so reverting that
\addtokomafont{chapterentry}{\rmfamily} 

% Set the font of the captions
\setkomafont{caption}{\small}
\setkomafont{captionlabel}{\small}
\setcapindent{0em}

%% Adjust spacing between start of the section title and text
\RedeclareSectionCommand[
  beforeskip=-0pt,
  afterskip=2\baselineskip]{chapter}
\RedeclareSectionCommand[
  beforeskip=-\baselineskip,
  afterskip=.5\baselineskip]{section}
\RedeclareSectionCommand[
  beforeskip=-.75\baselineskip,
  afterskip=.4\baselineskip]{subsection}
\RedeclareSectionCommand[
  beforeskip=-.5\baselineskip,
  afterskip=.25\baselineskip]{subsubsection}

% Command for adding an appendix section to each chapter
\usepackage{amsmath}
\makeatletter
\newcounter{AppendixSection}
\numberwithin{AppendixSection}{chapter}
\def\@AppendixSection[#1]#2{
	\refstepcounter{AppendixSection}
	\section*{%
		\addcontentsline{toc}{section}{\appendixname\ \Alph{AppendixSection}\quad#1}%
		\appendixname\ \Alph{AppendixSection}\quad#2}
}
\def\@@AppendixSection#1{\@AppendixSection[#1]{#1}}
\def\AppendixSection{\@ifnextchar[\@AppendixSection\@@AppendixSection}
\renewcommand{\theAppendixSection}{\Alph{AppendixSection}}

% "Chapter" prefix in ToC
%\let\@@l@chapter\l@chapter
%\def\l@chapter#1{\@@l@chapter{\chaptername\ #1}}
\makeatother

%% The spacing of the sections in the main table of contents
\RedeclareSectionCommand[tocindent=2.5em]{section}
