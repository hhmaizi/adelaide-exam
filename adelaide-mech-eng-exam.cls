
\ProvidesClass{adelaide-mech-eng-exam}

\providecommand\ANSWERS{F}
\providecommand\SUPP{F}
\providecommand\MARGIN{top=4cm,bottom=3cm,left=3cm,right=3cm}

\LoadClass[12pt]{article}
\RequirePackage{booktabs,color,geometry,fancyhdr,graphicx,lastpage,keyval}
\geometry{a4paper}
\expandafter\geometry\expandafter{\MARGIN}

\pagestyle{fancy}
\fancyhead{}{}
\fancyfoot{}{}
\lhead{Course ID: \COURSEID}
\rhead{Page~\thepage~of~\pageref{LastPage}}
\makeatletter
\cfoot{\NEXTPAGETEXT}
\if \ANSWERS T \relax
  \newcommand\ANS[1]{\par{\itshape\ignorespaces #1\unskip\par}}
  \newcommand\NEXTPAGETEXT{}
\else
  \newcommand\NEXTPAGETEXT{%
    \ifdefined\r@LastPage
      \ifnum \c@page = \expandafter\@secondoftwo\r@LastPage \relax
        END OF EXAMINATION%
      \else
        PLEASE SEE NEXT PAGE%
      \fi
    \else
      PLEASE RE-RUN \LaTeX!%
    \fi
  }  
  \newcommand\ANS[1]{}
\fi
\newcommand\TOTALMARKS{%
  \bigskip\noindent
  \addtocounter{totalmarks}{\value{marks}}%
  \stepcounter{Nparts}%
  \textbf{Total marks for this question: \arabic{marks}.}%
  \newcounter{markedpart:\theNparts}
  \setcounter{markedpart:\theNparts}{\numexpr\value{marks}-1\relax}
  \refstepcounter{markedpart:\theNparts}
  \label{markedpart:\theNparts}
  \setcounter{marks}{0}
}

\newcommand\FAKEMARKS[1]{%
  \setcounter{marks}{#1}%
  \addtocounter{totalmarks}{\value{marks}}%
  \stepcounter{Nparts}%
  \newcounter{markedpart:\theNparts}%
  \setcounter{markedpart:\theNparts}{\numexpr\value{marks}-1\relax}%
  \refstepcounter{markedpart:\theNparts}%
  \label{markedpart:\theNparts}%
}

\def\COUNTMARKS{
  \addtocounter{totalmarks}{-1}
  \refstepcounter{totalmarks}
  \label{marks:total}
  
  \addtocounter{Nparts}{-1}
  \refstepcounter{Nparts}
  \label{parts:total}
}

\providecommand\TITLE[1]{\section{#1}}

\newcounter{totalmarks}
\newcounter{Nparts}

\newcounter{marks}
\newcommand\MARKS[1]{\addtocounter{marks}{#1}\hfill\penalty100\hspace*{\fill}\textsc{\fontsize{9}{9}\selectfont [marks:~\oldstylenums{#1}]}\ignorespaces}

\newcommand\EXAMHEADING{

  \vspace*{-10mm}
  \centerline{%
    \IfFileExists{uni-logo.pdf}{\includegraphics{uni-logo}}{%
      \color{red} \textbf{LOGO MISSING}. Download the university logo and call it \texttt{uni-logo.pdf}.%
    }
  }
  
  \bigskip
  
  \begin{center}
  \large
  \bfseries
  \if\SUPP T
  Replacement/Additional Assessment\par
  \fi
  Examination for the Degree of \ifx\DEGREETYPE\DEGREETYPEB Bachelor\else Master\fi\ of Engineering\par
  \SEMESTER, \YEAR
  \end{center}
  
  \bigskip
  
  \centerline{\fbox{\large\bfseries
  \begin{tabular}{p{0.3\textwidth}@{\quad}p{0.6\textwidth}}
  COURSE ID: \COURSEID & \COURSENAME \\
  &
  \ifx\DEGREETYPE\DEGREETYPEB Undergraduate\else Postgraduate\fi\\
  & MECH ENG \SUBJECTCODE\ \\
  \end{tabular}
  }}
  
  \bigskip
  
  \if\ANSWERS T
  \centerline{\Huge\bfseries\color{red} SOLUTIONS}
  \bigskip
  \fi

}

\newcommand\EXAMCALCS{
  \let\@tempa\@empty
  
  \ifcsname r@parts:total\endcsname
  
  \@tempcnta=0\relax

  \loop
    \advance\@tempcnta by 1\relax
    \edef\@tempb{
      \the\@tempcnta & 
      \unexpanded{\the\numexpr}
      \EXAMTIME*\expandafter\expandafter\expandafter\@firstoftwo\csname r@markedpart:\the\@tempcnta\endcsname    
      /\expandafter\expandafter\expandafter\@firstoftwo\csname r@marks:total\endcsname
      \relax\
      mins & 
      \noexpand\ref{markedpart:\the\@tempcnta} \noexpand
      \\ }
    \expandafter\g@addto@macro\expandafter\@tempa\expandafter{\@tempb}
  
    \ifnum\@tempcnta <
      \expandafter\expandafter\expandafter
        \@firstoftwo\csname r@parts:total\endcsname
  \repeat
  
  \fi
}

\newcommand\EXAMTABLE{
  \begin{center}
  \begin{tabular}{@{}rr@{~~}r@{}}
  \toprule
  \multicolumn{2}{@{}r@{~~}}{Official Reading Time\rlap:} & 10 mins \\
  \multicolumn{2}{@{}r@{~~}}{Writing Time\rlap:} & \EXAMTIME\ mins \\
  \multicolumn{2}{@{}r@{~~}}{Total Duration\rlap:} & \the\numexpr \EXAMTIME+10\relax\ mins \\
  \bottomrule
  \\
  \toprule
  Q\rlap. & Approx.\ time & Marks \\
  \midrule
  \@tempa
  \midrule
  Total\rlap: & \EXAMTIME\ mins & \ref{marks:total} \\
  \bottomrule
  \end{tabular}
  \end{center}
}

\newenvironment{coverpage}{
  \EXAMTITLEOPENING  
  \EXAMHEADING
  \EXAMCALCS
  \EXAMTABLE
  \bigskip
}{
  \EXAMTITLECLOSING
}

\newcommand\EXAMTITLEOPENING{
  \begin{titlepage}
  \setlength\parindent{0pt}
}
\newcommand\EXAMTITLECLOSING{
  \vfill
  \vspace*{2\baselineskip}
  \centerline{DO NOT COMMENCE WRITING UNTIL INSTRUCTED TO DO SO}
  \end{titlepage}
  \stepcounter{page}
}

\newcommand\examsetup{\setkeys{mechexam}}

\define@key{mechexam}{teaching-period}{\def\SEMESTER{#1}}
\define@key{mechexam}{year}{\def\YEAR{#1}}
\define@key{mechexam}{course-name}{\def\COURSENAME{#1}}
\define@key{mechexam}{course-code}{\def\SUBJECTCODE{#1}}
\define@key{mechexam}{course-id}{\def\COURSEID{#1}}
\define@key{mechexam}{degree-type}{\def\DEGREETYPE{#1}}
\define@key{mechexam}{exam-time}{\def\EXAMTIME{#1}}

\def\COURSENAME{[Course name]}
\def\SUBJECTCODE{[Course code]}
\def\COURSEID{[Course ID]}
\def\DEGREETYPE{Bachelor}
\def\DEGREETYPEB{Bachelor}
\def\DEGREETYPEM{Master}
\def\EXAMTIME{180}
\def\YEAR{\the\year}

\usepackage{chngcntr}
\counterwithin{equation}{section}
\counterwithin{figure}{section}
\renewcommand\thefigure{\thesection.\arabic{figure}}

