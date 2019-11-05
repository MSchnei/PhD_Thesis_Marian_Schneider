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

% Microtypography.
\usepackage{microtype}

% For figure and captions on separate pages. See
% https://tex.stackexchange.com/questions/49858/how-do-i-make-figure-captions-span-multiple-pages
\usepackage{caption}
% the following format will be used to emulate the captions produced by fltpage
\DeclareCaptionLabelFormat{adja-page}{\hrulefill\\#1 #2 \emph{(previous page)}}

% For utf8 symbols in the text
\usepackage[utf8]{inputenc}

% Set the header style, chapter header verso, nothing recto
\renewcommand*{\chaptermarkformat}{Chapter~\thechapter. \enskip}
\rohead{}

% Define useful commands for header/copyright/legal page, 
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
	This work is licensed under a Creative Commons Attribution 4.0 International License (CC BY 4.0). You are free to share and adapt the material for any purpose, even commercially, under the following terms: Attribution — You must give appropriate credit, provide a link to the license, and indicate if changes were made. You may do so in any reasonable manner, but not in any way that suggests the licensor endorses you or your use. No additional restrictions — You may not apply legal terms or technological measures that legally restrict others from doing anything the license permits. This is a human-readable summary of (and not a substitute for) the license.  For the full license text, see: \href{https://creativecommons.org/licenses/by/4.0/legalcode}{https://creativecommons.org/licenses/by/4.0/legalcode}
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
		on the authority of the Rector Magnificus, Prof. Dr. Rianne M. Letschert,\\
		in accordance with the decision of the Board of Deans,\\
		to be defended in public on \\
		\thesisdefendingdate, at \thesisdefendingtime
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
\newcommand{\infopage}{
	\thispagestyle{empty}

	\begin{flushleft}
		\textbf{Promotors}
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
    \noindent
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

% For citing publications in the beginning of the chapter
\newcommand{\paperciteone}{
	\begin{bottomparagraph}
		\noindent\rule{0.5\textwidth}{0.1pt}\\
		 Based on\\
		 Gulban, O. F.*, Schneider, M.*, Marquardt, I., Haast, R. A., {\&} {De Martino}, F. (2018). A scalable method to improve outer gray matter boundary segmentation at ultra high field MRI. \textit{Plos One}, 13, 1-33.\\
		 \\
		 *Authors contributed equally.
	\end{bottomparagraph}
}
\newcommand{\papercitetwo}{
	\begin{bottomparagraph}
		\noindent\rule{0.5\textwidth}{0.1pt}\\
		 Based on\\
		 Schneider, M., Kemper, V. G., Emmerling, T. C., {De Martino}, F., {\&} Goebel, R. (2019). Columnar clusters in the human motion complex reflect consciously perceived motion axis. \textit{Proceedings of the National Academy of Sciences}, 116, 5096-5101.
	\end{bottomparagraph}
}
\newcommand{\papercitethree}{
	\begin{bottomparagraph}
		\noindent\rule{0.5\textwidth}{0.1pt}\\
		 Based on\\
		 Schneider, M., Marquardt, I., Sengupta, S., {De Martino}, F., {\&} Goebel, R. (2019). Linking apparent position to population receptive field estimates using a visual field projection model. \textit{Proceedings of the Cognitive Computational Neuroscience Conference}, 3, 1006-1009. \\
		 \\
		 Schneider, M., Marquardt, I., Sengupta, S., {De Martino}, F., {\&} Goebel, R. (in preparation). Motion displaces population receptive fields in the direction opposite to motion.
	\end{bottomparagraph}
}

% Automatically start the minitoc in the frontmatter
\let\oldfrontmatter\frontmatter
\renewcommand\frontmatter{\oldfrontmatter \renewcommand*{\chapterheadstartvskip}{\vspace*{0\baselineskip}} \renewcommand{\chaptername}{}}

% Set the chapter style for the main matter
\let\oldmainmatter\mainmatter
\renewcommand\mainmatter{\oldmainmatter \renewcommand*{\chapterheadstartvskip}{\vspace*{8\baselineskip}}}

% Change the chapter index in the backmatter
\let\oldbackmatter\backmatter
\renewcommand\backmatter{\oldbackmatter \renewcommand*{\chapterheadstartvskip}{\vspace*{0\baselineskip}}}

% For changing the numbering of supplementary figures and tables
% This ensures that "S" is pre-pended and counting starts with 1
\newcommand{\beginsupplement}{%
        \setcounter{table}{0}
        \renewcommand{\thetable}{S\thechapter.\arabic{table}}%
        \setcounter{figure}{0}
        \renewcommand{\thefigure}{S\thechapter.\arabic{figure}}%
     }

\newcommand{\stopsupplement}{%
        \setcounter{table}{0}
        \renewcommand{\thetable}{\thechapter.\arabic{table}}%
        \setcounter{figure}{0}
        \renewcommand{\thefigure}{\thechapter.\arabic{figure}}%
     }

% For changing the numbering of figures in the valorization section
\newcommand{\beginvalorization}{%
        \setcounter{figure}{0}
        \renewcommand{\thefigure}{V\arabic{figure}}%
     }


% Set the title style
\KOMAoption{chapterprefix}{true}
\renewcommand{\chaptername}{}
\renewcommand*{\raggedchapter}{\raggedleft}
\setkomafont{chapterprefix}{\fontsize{70}{0} \selectfont}
\setkomafont{chapter}{\normalfont\huge}

% Set all section headers to medium weight
% ("disposition" means all headings in the document)
\setkomafont{disposition}{\mdseries}
% Set TOC entries to small capital letters (sc)
\addtokomafont{chapterentry}{\scshape}
% Set section headers to sc and decrease from \Large to \large 
\setkomafont{section}{\scshape\large}
% Set subsection header slanted
\addtokomafont{subsection}{\slshape}
% Set subsection number from \large to \normalsize
\renewcommand*{\subsectionformat}{\normalsize \thesubsection\autodot\enskip}
% Set subsubsection header slanted
\addtokomafont{subsubsection}{\scshape} 

% Set font of the captions to small and sans serif
\setkomafont{caption}{\small\sffamily}
% Set caption label also to bold and small capitals
\setkomafont{captionlabel}{\small\sffamily\bfseries\scshape}
% Set caption indentation to 0
\setcapindent{0em}

% Paragraph layout, vertical indentation:
\setlength{\parindent}{1cm}
% Paragraph layout, horizontal spacing:
\setlength{\parskip}{0cm}
% Vertical distance between page header and top of text:
\setlength{\headsep}{2.5em}

%% Adjust spacing between section titles and text
\RedeclareSectionCommand[
  beforeskip=-0pt,
  afterskip=2\baselineskip]{chapter}
\RedeclareSectionCommand[
  beforeskip=-\baselineskip,
  afterskip=.6\baselineskip]{section}
\RedeclareSectionCommand[
  beforeskip=-.75\baselineskip,
  afterskip=.6\baselineskip]{subsection}
\RedeclareSectionCommand[
  beforeskip=-.5\baselineskip,
  afterskip=-.4\baselineskip]{subsubsection}

%% "Chapter" prefix in ToC
%\let\@@l@chapter\l@chapter
%\def\l@chapter#1{\@@l@chapter{\chaptername\ #1}}
\makeatother

%% The spacing of the sections in the main table of contents
\RedeclareSectionCommand[tocindent=2.5em]{section}

