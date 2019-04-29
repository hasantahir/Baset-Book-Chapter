%% ---------------------------------------------------------------------------------------------
%% LaTeX Class for Nam Suh's Book
%% ---------------------------------------------------------------------------------------------
%% Created by: Joseph Timothy Foley <foley AT ru.is>
%% Designed for XeTeX because the document will be converted into a word file using Acrobat pro
%%
%% TODO:
%%
%% If XeLaTeX is runing slow, re-run the fontcache:  sudo fc-cache -f -v
%% To use Calibri on Windows Subsystem for Linux: sudo ln -s /mnt/c/Windows/Fonts /usr/share/fonts/WindowsFonts
%%
%% --------------- Identification ----------------------------
\newcommand{\fileversion@suhbook}{1.0}
\newcommand{\filedate@suhbook}{2019/01/12}% must be YYYY/MM/DD!
\newcommand{\fileauthor@suhbook}{Joseph Timothy Foley, foley at RU.IS}
\ProvidesClass{suhbook}[\filedate@suhbook by \fileauthor@suhbook]
\NeedsTeXFormat{LaTeX2e}
\typeout{Nam Suh Book Class \fileversion@suhbook <\filedate@suhbook>, by \fileauthor@suhbook}
\typeout{Requires XeLaTeX}
%% ---------------- Critical packages -----------------------------
% Toolbox of many many macros that make a lot of latex code smarter and more robust
% Incl:  \newbool, \ifbool, etc.
% http://texdoc.net/texmf-dist/doc/latex/etoolbox/etoolbox.pdf
\RequirePackage{etoolbox}

%% Command to remove things if we are draft mode
\RequirePackage{ifdraft}

%% LaTeX3
%% Some of this may already be included as a dependancy from another package
% Better handling of arguments, particularly for defaults
%\RequirePackage{xargs}

% Specialized commands for constructing macros
%\RequirePackage{xparse}

%% ---------------- Boolean switches -----------------------------
%% Booleans make it easy to enable and disable parts of the template
%% Use the etoolbox macros!
%% http://texdoc.net/texmf-dist/doc/latex/etoolbox/etoolbox.pdf
%% pg 14-15

\newbool{debug}
\newbool{forcegraphics}
\newbool{proof}

%% ---------------- Declaration of Class Options--------------------
%% Remember that we have \AtEndOfClass{},\AtEndOfPackage{}
%%     \AtBeginDocument{}, \AtEndDocument{}
%% If you want execution conditional on file existence
%%     \IfFileExists{filename}{true}{false}
%%     \InputIfFileExists{filename}{true}{false}
%% For error reporting
%%     \ClassError{class-name}{error-text}{help-text}
%%     \PackageError{class-name}{error-text}{help-text}

\newcommand{\finalifforcegraphics}[1]{}%Dummy function for forcing graphics
\DeclareOption{debug}{%
  \booltrue{debug}\typeout{suhbook option: debug}}
\DeclareOption{forcegraphics}{%
  \renewcommand{\finalifforcegraphics}[1]{\PassOptionsToPackage{final}{#1}}%
  \finalifforcegraphics{graphicx}%We have to catch graphicx early
  \booltrue{forcegraphics}\typeout{suhbook option: forcegraphics}%
}%
\DeclareOption{proof}{%
  \booltrue{proof}\typeout{suhbook option: proof}}

\PassOptionsToClass{10pt,oneside}{memoir}%Set the default font and paper size

\DeclareOption*{
  \PassOptionsToClass{\CurrentOption}{memoir}
  %% now we pass the remaining unused options to our parent class
  %% If you need to make warnings about options regarding packages
  %% \PackageWarning{packagename}{Unknown option '\CurrentOption'}%
}

%% ---------------- Execution of Options -----------------------------
\ProcessOptions\relax% this stops searching for a * in \ProcessOptions*

%% Alternative way to subclass.  Disable the other option processing
%% if you enable it.  This will dump all options onto the parent class
%\ProcessOptions\LoadClassWithOptions{article}
%% Read page 20 of http://latex-project.org/guides/clsguide.pdf
%% carefully before modifying any of the execution and previous section.
%% ---------------- Package Loading -----------------------------
\LoadClass{memoir}% our parent class.

%% We need to set a "fakedraft" boolean because the 
%%  normal draft behaviour (which uses the boolean "draft") is
%%  too limiting.
\ifdraft{\booltrue{fakedraft}}

%% Memoir options
%% The Word template doesn't have a left and right
\ExecuteOptions{openany}

%% ---------------- XeTeX setup -----------------------------
\RequirePackage{fontspec}% font selecting commands
\RequirePackage{xunicode}% unicode character macros
\RequirePackage{xltxtra}% a few fixes and extras

%% ---------------- Internationalization -----------------------------
\RequirePackage[autostyle,strict]{csquotes} 
\RequirePackage[english]{babel}

%% ---------------- Tables and Graphics ------------------------------
%% This convenience macro is to force the "final" option on a package
%%   if forcegraphics boolean is true
%\finalifforcegraphics{graphicx}%taken care of in option
\RequirePackage{graphicx}

\typeout{XeLaTeX Graphics options being configured}
%% The extensions that it will search for as valid graphics files
%% We need To include the UPPERCASE versions For windows people
\DeclareGraphicsExtensions{.pdf,.jpeg,.jpg,.png,.PDF,.JPEG,.JPG,.PNG,}  


\graphicspath{{graphics/}{Graphics/}{./}}
%% This is a list of folders to search for graphics files to include
%% Each path should be in a {}.  
%% Make sure that the upper/lowercase of the letters matches the folder or
%% you may have weird problems with partners using OSX or Linux.
%% Note that you don't have to put the folder where the .tex file is, it is
%% included automatically, though it is bad practice to put your 
%% graphics there
%% LaTeX will search from left to right in the list, so you can put "cropped" versions
%% in the first directory and it will grab them first. e.g.
%\graphicspath{{graphics-cropped/}{graphics/}{Graphics/}{./}}
%% 
%% If you put a // at the end of the path, it will recursively search for graphics
%% files on unix-type platforms.

\RequirePackage{booktabs}
%% Book quality tables
%% Do not use \hrule.  Instead:
%% \toprule, \midrule, \bottomrule

%\finalifforcegraphics{pdfpages}
\PassOptionsToPackage{final}{pdfpages}%always include or BSc insert does not show up.
\RequirePackage{pdfpages}
%% The "pdfpages" package lets you include PDF documents into your 
%% document but keeps the formatting consistent (headers, footers,
%% etc.)
\includepdfset{pagecommand=\thispagestyle{plain}}
% pagecommand is run on every page.
% This one puts page numbers on included pdfs

%% -------------------Colors----------
\RequirePackage{xcolor}

%% ---------------- Science and Math ------------------------------
%% First we consider the math aspects of fonts
%% Of note, this should be loaded after any AMS packages you 
%% have called directly.
\RequirePackage{amsmath}
\RequirePackage{amssymb}

\RequirePackage{siunitx}  % replacement for SIunits, less problems
%% examples: \SI{9.8}{\meter\per\second\square}


%% ---------------- Fonts -----------------------------
%%%  For help, read http://latex-project.org/guides/fntguide.pdf
%%
\newcommand{\mainfontname}{cambria.ttf}

%\setmainfont[SizeFeatures={Size=10}]{\mainfontname}%to match word template
%\setsansfont{Arial}
%\setmonofont{Courier New}
% Times New Roman
\setromanfont[
BoldFont=cambriab.ttf,
ItalicFont=cambriai.ttf,
BoldItalicFont=cambriabi.ttf,
]{cambria.ttf}
% Arial
\setsansfont[
BoldFont=arialbd.ttf,
ItalicFont=ariali.ttf,
BoldItalicFont=arialbi.ttf
]{arial.ttf}
% Courier New
\setmonofont[Scale=0.90,
BoldFont=courbd.ttf,
ItalicFont=couri.ttf,
BoldItalicFont=courbi.ttf,
%Color={0019D4}
]{cour.ttf}

\newfontfamily\scshape[Letters=SmallCaps,Scale=1.15]{\mainfontname}
%% Small caps uses some non-MS font

\PassOptionsToPackage{warn}{textcomp}%
%% Turn substitutions from errors into warnings on
%% the textcomp package.
%% This is needed because some fonts do not have a \textohm for siunitx

% save the current font size
\newlength{\normaltextsize}
\setlength{\normaltextsize}{\f@size pt}

\RequirePackage{bm}
% bold math, which doesn't exist in some fonts


%% Font guide at
%% http://latex-project.org/guides/fntguide.pdf

% set the font defaults (if they need to be further adjusted)
%\renewcommand{\encodingdefault}{t1}

%\renewcommand{\rmdefault}{ptm}  % adobe times
%\renewcommand{\sfdefault}{phv}  % adobe helvetica?
%\renewcommand{\ttdefault}{pcr}  % adobe courier
%% cmr  : computer modern roman
%% cmss : computer modern sans oblique
%% cmm  : computer modern math
%% ptm  : (postscript) Adobe Times
%% phv  : (postscript) Adobe Helvetica
%% pcr  : (postscript) Adobe Courier

%\renewcommand{\familydefault}{\sfdefault} % switch to \sfdefault if you want to force sanserif
%% \familydefault should be one of the short letter codes such as "lm" or "ptm"
%\renewcommand{\familydefault}{\rmdefault}

%\renewcommand{\seriesdefault}{m}
%% m  : medium
%% b  : bold
%% bx : bold extended
%% sb : semi bold
%% c  : condensed

%\renewcommand{\shapedefault}{n}
%% n  : upshape (normal)
%% it : italics
%% sl : slanted
%% sc : small caps

%%\fontsize{12pt}{14pt}  % args: fontsize, baselineskip (font+space)
%% normal sequence of increasing sizes:  5,7,8,9,10,12,14.4,17.28,20.74,24.88

%%  Specific fonts
%%  Note that you can leave off elements and it will use the last value set (or default??)
% \def\myfont{\fontencoding{T1}\fontfamily{lm}\fontseries{m}\fontshape{n}\fontsize{14pt}{16pt}\selectfont}
%  \fontsize{SIZE}{BASELINESKIP}
%%  setup the other fonts used
\def\headerfont{\fontsize{9pt}{9pt}\selectfont}
\def\titlefont{\fontsize{16pt}{16pt}\selectfont}
\def\abstractfont{\fontshape{it}\fontsize{9pt}{9pt}\selectfont}
\def\sectionfont{\fontsize{10pt}{10pt}\selectfont}
%% ------------- Development -----------------------------
\RequirePackage{lipsum}% generates some test text
%% usage: \lipsum[STARTNUM-ENDNUM]


%% --------------Hyperlinks  -----------------------------
\PassOptionsToPackage{obeyspaces,spaces,hyphens,allowmove}{url}
\RequirePackage{url}
%% The url package typesets url's and unix file paths nicely when they
%% become long.  \url{}
%% Also defines \path{}  which works with filepaths including windows paths.
%% Watch out that you leave a space after a last \ e.g. \path{C:\ }
%% You need another verbatim environment to make those typeset properly.
%% Also defines the \path{} command for paths
%% Option: obeyspace to deal with spaces in a path/url
%% Option: spaces to do linebreaks at the spaces.
%% Option: hyphens to do linebreaks at hyphens.
%% Option: allowmove makes URLs not-fragile, so they can go in things that move
%%         WARNING: If this breaks you will get very very weird errors

%%---------------------- Margins ---------------------------
%% WARNING: memoir class has its own margin macros
%%    Do not use the geometry package unless you know what you are doing
\newcommand{\defaultmargins}{
  % \semiisopage
    % The MS word template uses even 25.4mm margins
    \setlrmarginsandblock{25.4mm}{25.4mm}{*}
    % {left}{right}{ratio}, * for calculate    
    \setulmarginsandblock{25.4mm}{31.7mm}{*} 
    % {upper}{lower}{ratio} * for calculate
  \checkandfixthelayout% implement the margins
}
\defaultmargins{}  % this macro is in case something messes with the margins

%% Some debugging code to check length calculation.
\newcommand{\showlengths@suhbook}{
  \uselengthunit{mm} % showlen package
  Lengths: (with round off error from floats)\\
  covermarginl:\printlength{\covermarginl}\\
  covermarginr:\printlength{\covermarginr}\\
  coverwindowwidth:\printlength{\coverwindowwidth}\\
  covermargint:\printlength{\covermargint}\\
  covermarginb:\printlength{\covermarginb}\\
  coverwindowheight:\printlength{\coverwindowheight}\\
  pagecenterx:\printlength{\pagecenterx}\\
  pagecentery:\printlength{\pagecentery}\\
  windowcenterx:\printlength{\windowcenterx}\\
  windowcentery:\printlength{\windowcentery}\\
  \\
  windowmargin:\printlength{\windowmargin}\\
  coverwindowtextheight:\printlength{\coverwindowtextheight}\\
  coverwindowtextwidth:\printlength{\coverwindowtextwidth}\\
  \\
  covernowinmarginl:\printlength{\covernowinmarginl}\\
}



%%------------------ TextPos -----------------------
\ifbool{debug}{%
  \RequirePackage[absolute, showboxes, verbose]{textpos}%
  \RequirePackage{printlen}% display lengths in arbitrary units
}{%
  \RequirePackage[absolute, verbose]{textpos}%
}%

%% The textpos package allows you to place blocks of text explicitly
%% rather than letting LaTeX put them somewhere.

%% These commands set the units in \begin{textblock} when not 
%%  directly specified
%% We set them to the page sizes so we can align from them
\setlength{\TPHorizModule}{\paperwidth}
\setlength{\TPVertModule}{\paperheight}
%\setlength{\TPMargin}{2mm} %% margins inside the textblock*
\textblockorigin{0mm}{0mm} % start everything near the top-left corner

%% -------------------Lists -----------------------------
\RequirePackage{paralist}
\RequirePackage{dashrule}

%% ---------------- Main Code -----------------------------
%%  Remember that we can declare commands (to make fragile things safe)
%%  The * form is for ``short'' commands, not longer than a paragraph
%%       \DeclareRobustCommand{cmd}[num][default]{definition}
%%       \DeclareRobustCommand*{cmd}[num][default]{definition}
%%  For checking if commands are redefined
%%       \CheckCommand{cmd}[num][default]{definition}

%% Spacing modes from the memoir class
%\SingleSpacing{} % single spacing
%\OnehalfSpacing{} % one and a half
%\DoubleSpacing{} % Double spacing, very ugly.

\newenvironment{chapterintro}
{\begin{center}\begin{minipage}{0.8\linewidth}\abstractfont}
{\end{minipage}\end{center}\vspace{\baselineskip}}

%%% Document variables

%% Standard title, author, date disappear after \maketitle
\newcommand{\title@suhbook}{}
\newcommand{\author@suhbook}{}


\renewcommand{\title}[1]{\gdef\@title{#1}\gdef\title@suhbook{#1}}
\renewcommand{\author}[1]{\gdef\@author{#1}\gdef\author@suhbook{#1}}
\renewcommand{\date}[1]{\gdef\@date{#1}\gdef\date@suhbook{#1}}

\newcommand{\chapterauthor@suhbook}{\author@suhbook}
\newcommand{\setChapterAuthor}[1]{\renewcommand{\chapterauthor@suhbook}{#1}}
\newcommand{\copyrightdate@suhbook}{}
\newcommand{\chapterversiondate@suhbook}{}
\newcommand{\setChapterVersionDate}[1]{\renewcommand{\chapterversiondate@suhbook}{#1}}
\newcommand{\setCopyrightDate}[1]{\renewcommand{\copyrightdate@suhbook}{#1}}
\newcommand{\circulationinfo@suhbook}{}
\newcommand{\setCirculationInfo}[1]{\renewcommand{\circulationinfo@suhbook}{#1}}


\newcommand{\ShowChapterInfo}{The \chapterversiondate@suhbook{} Version}


%----------------- Headers and Footers ---------------------------------
%% Adjust headheight to fit the multiline header
\usepackage{fancyhdr}
\setlength{\headheight}{27pt}

%% The word version doesn't have the topline
\renewcommand{\headrulewidth}{0pt}

%% The copyright/release information is just in the top left header
%% and it is on every page including chapter start
\aliaspagestyle{chapter}{fancy}
\aliaspagestyle{book}{fancy}
\aliaspagestyle{chapter}{fancy}
\aliaspagestyle{cleared}{fancy}
\aliaspagestyle{part}{fancy}
\aliaspagestyle{title}{fancy}
\aliaspagestyle{titlinpage}{fancy}  

\pagestyle{fancy}
\fancyhf{}%Clear existing footers and headers
\lhead{\headerfont{}\color{gray}\title@suhbook{}\\
  Chapter~\thechapter{} by \chapterauthor@suhbook{}, \textcopyright{} \copyrightdate@suhbook{}\\
  \circulationinfo@suhbook{}}
\rfoot{\color{gray}\thepage}


%% Penalties for various text placement issues
\clubpenalty=10000%% orphan lines
\widowpenalty=10000%% widow lines
\hfuzz=1pt%% avoid overfilled hboxes
\vfuzz=5pt%% avoid overfilled vboxes
\newcommand{\draftnote}[1]{\ifdraft{{\color{gray}#1}}}

%\AtEndDocument{
%\typeout{*******************************************************************}
%}



%%% Local Variables:
%%% mode: latex
%%% TeX-master: "des-template.tex"
%%% TeX-engine: xetex
%%% End:
