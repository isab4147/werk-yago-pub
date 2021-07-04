\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{yagoexam}[2019/04/09 Isabella's modified exam class (for Yago)]

\DeclareOption*{\PassOptionsToClass{\CurrentOption}{exam}}
\ProcessOptions\relax

\LoadClass[addpoints, 11pt]{exam}

\newif\ifgabarito

\@ifclasswith{exam}{answers}{\gabaritotrue}{\gabaritofalse}

% defaults
%\renewcommand{\normalsize}{\fontsize{9}{10}\selectfont}
%\setlength{\textwidth}{19cm}
%\setlength{\textheight}{24cm}

\RequirePackage[margin=1in]{geometry}
\RequirePackage[brazil]{babel}
\RequirePackage[utf8]{inputenc}
\RequirePackage[T1]{fontenc}

% Define Class, Exam, Date, etc.
\def\@class{\relax}
\newcommand{\class}[1]{\gdef\@class{#1}}
\def\@examname{\relax}
\newcommand{\examname}[1]{\gdef\@examname{#1}}
\def\@schoolyear{\relax}
\newcommand{\schoolyear}[1]{\gdef\@schoolyear{#1}}
\def\@examdate{\relax}
\newcommand{\examdate}[1]{\gdef\@examdate{#1}}
\def\@teacher{\relax}
\newcommand{\teacher}[1]{\gdef\@teacher{#1}}

\newif\ifdepart

\def\@dep{\relax\departfalse}
\newcommand{\dep}[1]{\gdef\@dep{#1}\departtrue}

\RequirePackage{ifthen}
\RequirePackage{fancybox}
\RequirePackage{tikz}

% For an exam, we generally want to turn off paragraph indentation
\parindent 0ex

\renewcommand\partlabel{\makebox[0.7cm][l]{(\alph{partno})}}

\renewcommand{\questionshook}{%
	\setlength{\leftmargin}{0pt}%
	\setlength{\labelwidth}{-\labelsep}%
}


\renewcommand{\partshook}{%
	\setlength{\leftmargin}{10pt}%
	\setlength{\labelsep}{0pt}
	\setlength{\labelwidth}{0cm}%
	\def\makelabel##1{##1}%
}

\newcommand{\formattitletext}[1]{\textbf{\LARGE\fontfamily{qcr}\selectfont{#1}}}

\pointname{ pontos}

\qformat{
	\begingroup
	\vspace{0.5cm}
	\strut\hspace{-4pt}
	\begin{minipage}{\textwidth}
	\formattitletext{\MakeUppercase{Questão \thequestion}}
	\strut\hfill
	\formattitletext{\MakeLowercase{\thepoints}}\\
	\rule[1.1ex]{\textwidth}{1.2pt}
	\strut\smallskip
	\end{minipage}
	\endgroup
}

\renewcommand\appendix{
	\begingroup
	\vspace{0.5cm}
	\strut\hspace{-4pt}
	\begin{minipage}{\textwidth}
		\formattitletext{\MakeUppercase{Apêndice}}
		\strut\hfill\\
		\rule[1.1ex]{\textwidth}{1.2pt}
	\end{minipage}
	\endgroup
}

\newcounter{questionbox}
\stepcounter{questionbox}
\renewcommand*{\thequestionbox} % format counter to include placeholder 0
{\arabic{questionbox}.}

\pgfmathsetmacro{\endpt}{\value{questionbox}*0.7}
\newcommand{\setlittlenumbers}{\pgfmathsetmacro{\endpt}{-1.15+\value{questionbox}*0.7}
	\put(\endpt,2.45){\makebox(0,0)[tl]{\tiny \thequestionbox }}\stepcounter{questionbox}}


\newcommand{\emptybox}[2][\textwidth]{%
	\begingroup
	\setlength{\fboxsep}{-\fboxrule}%
	\noindent\framebox[#1]{\rule{0pt}{#2}}%
	\endgroup}

\renewcommand*{\thequestion} % format counter to include placeholder 0
{\ifnum\value{question}<10 0\fi
	\arabic{question}}

\frenchspacing
\newcommand{\makelogos}[3]{
	\begin{center}
		\begin{minipage}{1.7cm}
			\centering
			\includegraphics[width=1.10\textwidth]{#1}
		\end{minipage}
		\begin{minipage}{11.4cm}
			\begin{center}
			\small
			{\bf Ministério da Educação \\\vspace{2pt}
			Instituto Federal Fluminense} \\\vspace{2pt}
			\textit{campus} #2 \\	
			\end{center}
		\end{minipage}
		\begin{minipage}{1.6cm}
			\centering
			\includegraphics[width=1.10\textwidth]{#3}
		\end{minipage}
	\end{center}

	\vspace{6cm}
}

\renewcommand\maketitle{
	\setlength{\unitlength}{1cm}
%	\begin{center}
	\begin{picture}(-2.0,1.5)(-2.0,1.5)
	\thicklines
	\put(-.5,6.6){\line(1,0){14}}  \put(-.5,2.5){\line(1,0){14}}
	\put(-.5,1.5){\line(1,0){14}}  \put(-.5,1.5){\line(0,1){5.1}}
	\put(13.5,1.5){\line(0,1){5.1}}\put(4.0,2.5){\line(0,1){3.1}}
	\put(4.0,3.5){\line(1,0){9.5}} \put(11.5,1.5){\line(0,1){1}}
	\put(11.55,1.5){\line(0,1){1}} \put(11.6,1.5){\line(0,1){1}}
	\put(13.4,1.5){\line(0,1){1}}  \put(13.45,1.5){\line(0,1){1}}
	\thinlines 
	\put(-.5,5.6){\line(1,0){14}}
	\ifgabarito
	\put(8.75,4.5){\makebox(0,0)[c]{\LARGE \bfseries GABARITO}}
	\else
	\put(4.2,4.8){Aluno:}
	\put(4.2,4.0){Turma:}
	\fi
	\put(6.2,5.25){} \put(6.2,4.8){}  \put(6.2,4.3){}
	\put(6.2,3.8){}  \put(1.6,5.25){} \put(1.6,4.8){}
	\put(1.6,4.35){} \put(1.6,3.8){}  \put(1.6,3.35){}
	\put(1.6,2.8){}
	\put(-.3,4.6){Prof.: \@teacher}
	\put(-.3,4.0){Ano Letivo: \@schoolyear}   \put(-.3,3.4){Data: \@examdate}    
	\put(6.5,7.1){\makebox(0,0)[c]{\LARGE \bfseries  \MakeUppercase{\@examname}}}
	\put(8.75,2.8){\makebox(0,0)[c]{TOTAL: \numpoints\ PONTOS}}
	
	\ifdepart
	\put(6.5,6.1){\makebox(0,0)[bc]{\bfseries \MakeUppercase{\@class}}}    
	\put(6.5,5.7){\makebox(0,0)[bc]{\bfseries \MakeUppercase{\@dep}}}
	\else
	\put(6.5,5.9){\makebox(0,0)[bc]{\bfseries \MakeUppercase{\@class}}}
	\fi
	
	\put(8.75,3.2){\makebox(0,0)[c]{\numquestions\ \ifthenelse{\numquestions>1}{QUESTÕES}{QUESTÃO} EM \numpages\ PÁGINAS}}
	
	\multiput(.2,1.5)(0.7,0){\numquestions}{\line(0,1){1}}
	\foreach \x in {1,...,\numquestions}{
		\setlittlenumbers
	}
	
	\end{picture}
%	\end{center}
	\mbox{\ } \vspace{-0.5cm} \mbox{\ } \\
	
	\vspace{2.5cm}
	
	\rule[1ex]{\textwidth}{2.0pt}
	\vspace{0.5cm}
}

\pagestyle{head}
\firstpageheader{}{}{}
\runningheader{}{\@class\hfill\@examname\ - Página \thepage\ de \numpages\hfill\@examdate}{}
\runningheadrule

\RequirePackage{footnote}
\makesavenoteenv{solution}

\newcommand{\xmark}{\ding{55}}%
\CorrectChoiceEmphasis{\color{red}}

\shadedsolutions
\renewcommand{\solutiontitle}{\noindent\textbf{Solução:}\par\noindent}
\definecolor{SolutionColor}{rgb}{0.8,0.9,1}

\newcommand{\valued}[1]{\begin{flushright}\textbf{#1}\end{flushright}}

\endinput