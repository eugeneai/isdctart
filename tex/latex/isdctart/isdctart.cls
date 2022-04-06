
\NeedsTeXFormat{LaTeX2e}[1995/12/01]
\ProvidesClass{isdctart}[2022/03/31,0.1.0: Typesetting articles for ISDCT SB RAS Journal]

\newcommand{\isdct@setmonofont}[1]{%
  \setmonofont{#1}[
     Scale=MatchLowercase,
     Numbers=SlashedZero,
     Ligatures=TeX,
     Numbers=Lining]
  \newfontfamily{\cyrillicfonttt}{#1}[
     Scale=MatchLowercase,
     Numbers=SlashedZero,
     Ligatures=TeX,
     Numbers=Lining]
  \PackageInfo{isdctart}{Set mono font as #1.}}

\newcommand{\isdct@ttfont}[0] {\isdct@setmonofont{Courier New}}

\newcommand{\isdct@setmathfont}[1]{%
  \setmathfont{#1}[Scale=MatchLowercase]
  % \newfontfamily{\cyrillicfonttt}{#1}[Scale=MatchLowercase]
  \PackageInfo{isdctart}{Set math font as #1.}}


\newcommand{\isdct@mathfont}[0] {}

\AtBeginDocument{%
\ifPDFTeX\else
\isdct@ttfont
\isdct@mathfont
\fi
\start@i18n
% \start@switcht
\startrussian
}

\newif\ifisdct@babel\isdct@babelfalse
\newif\ifisdct@poly\isdct@polyfalse

% Font search mechanics
\newif\ifisdct@af\isdct@affalse
\newif\ifisdct@sc\isdct@scfalse
\newif\ifisdct@fc\isdct@fcfalse
\newif\ifisdct@cn\isdct@cnfalse

% -------------- Options -----------------

\DeclareOption{babel}{\isdct@babeltrue}

\DeclareOption{polyglossia}{\isdct@polytrue}

\isdct@aftrue
\DeclareOption{sourcecode}{\isdct@sctrue\isdct@affalse}
\DeclareOption{firacode}{\isdct@fctrue\isdct@affalse}
\DeclareOption{courier}{\isdct@cntrue\isdct@affalse}
\DeclareOption{wordmath}{%
  \renewcommand{\isdct@mathfont}{\isdct@setmathfont{Asana Math}}
}

\DeclareOption{english}{
    \def\start@switcht{\startenglish}
    \def\start@i18n{
      \ifisdct@poly
      \setmainlanguage{english}
      \setotherlanguage{russian}
      \selectlanguage{english}
      \fi}
}
\DeclareOption{russian}{
  \def\start@switcht{\startrussian}
  \def\start@i18n{
    \ifisdct@poly
    \setmainlanguage{russian}
    \setotherlanguage{english}
    \selectlanguage{russian}
    \fi}
}

\DeclareOption*{\PassOptionsToClass{\CurrentOption}{ceurart}}
\ExecuteOptions{english}% No default options for now
\ProcessOptions\relax
\LoadClass{ceurart}






\RequirePackage{iftex}
\ifPDFTeX\else
\RequirePackage{luatextra}
%\RequirePackage[bold-style=upright]{unicode-math}
\RequirePackage{unicode-math}
\RequirePackage{unicode-math}
\defaultfontfeatures{Scale=MatchLowercase}
%\RequirePackage[protrusion=false,expansion=false]{microtype}
\RequirePackage{microtype}
\SetProtrusion
    [name=std]
    {
      encoding={utf8},
      family=*}
    {
    « = {300,     },
    » = {    , 300},
    „ = {300,     },
    “ = {    , 300},
    ( = {300,     },
    ) = {    , 300},
    ! = {    , 300},
    ? = {    , 300},
    : = {    , 300},
    ; = {    , 300},
    . = {    , 300},
    - = {    , 300},
   {,}= {    , 300}
    }
\microtypesetup{protrusion=true,expansion=true}
\fi


% ---------------- Option implementations ---------

\ifisdct@babel
% Кодировка - только utf8!
\ifPDFTeX
\RequirePackage[utf8]{inputenc}
\RequirePackage[T2A,T1]{fontenc}
\fi
\RequirePackage[english,main=russian]{babel} % Подключение традиционного
% пакета русификации Babel
\PackageWarning{babel}{Setting Russian language as default\MessageBreak
      and English as other language.\MessageBreak
      Устанавливаем русский\MessageBreak
      основным языком текста,\MessageBreak
      а английский - вторым.}
\fi

\ifisdct@poly
  \@ifpackageloaded{babel}{&
    \PackageError{isdctart}{Cannot load both 'babel' and 'polyglossia'\MessageBreak
    }{Choose either 'babel' or 'polyglossia' for support\MessageBreak
      Russian language.\MessageBreak
      Выберите или пакет 'babel' или 'polyglossia'.
    }
  }{}
\RequirePackage{polyglossia} % Подключение нового пакета русификации.
\setmainlanguage{russian}    % Задание основного языка
\setotherlanguage{english}   % Задание второго используемого языка.
\setkeys{russian}{babelshorthands=true} % Переносы типа
% красно"=зеленый
\PackageWarning{polyglossia}{Set Russian language as default\MessageBreak
      and English as other language.\MessageBreak
      Устанавливаем русский\MessageBreak
      основным языком текста,\MessageBreak
      а английский - вторым.}
\fi

\newif\ifisdct@fontnotdone\isdct@fontnotdonetrue
\ifisdct@af
\IfFontExistsTF{Source Code Pro}{%
  \isdct@fontnotdonefalse
  \isdct@sctrue
}{}
\ifisdct@fontnotdone
\IfFontExistsTF{Fira Code Medium}{%
  \isdct@fontnotdonefalse
  \isdct@fctrue
}{}
\fi
\ifisdct@fontnotdone
\IfFontExistsTF{Courier New}{%
  \isdct@fontnotdonefalse
  \isdct@cntrue
}{}
\fi
\fi  % af, autofont

\ifisdct@sc
\renewcommand{\isdct@ttfont}[0]{%
  \isdct@setmonofont{Source Code Pro}
}
\fi
\ifisdct@fc
\renewcommand{\isdct@ttfont}[0]{%
  \isdct@setmonofont{Fira Code Medium}
}
\fi
\ifisdct@cn
\renewcommand{\isdct@ttfont}[0]{%
  \isdct@setmonofont{Counter New}
}
\fi

\@ifpackageloaded{amsthm}{}{
\RequirePackage{ntheorem}
}

%\RequirePackage{cite}

\RequirePackage{geometry}
%\RequirePackage{longtable}
\RequirePackage{indentfirst}

\@ifpackageloaded{natbib}{
  \setcitestyle{numbers,square} % FIXME!!
}{}

\newcommand{\isdct@defgeom}{\geometry{a4paper,height=25cm,width=16.7cm,outer=1.8cm,marginparwidth=2cm}}
%\def\email#1{\makeatletter{\tt#1}\makeatother}
\hypersetup{
    %bookmarks=true,         % show bookmarks bar?
    unicode=true,          % non-Latin characters in Acrobat’s bookmarks
    pdftoolbar=true,        % show Acrobat’s toolbar?
    pdfmenubar=true,        % show Acrobat’s menu?
    pdffitwindow=false,     % window fit to page when opened
    pdfstartview={FitH},    % fits the width of the page to the window
    pdftitle={Procedings of NLA'2018 conference},    % title
    pdfauthor={},     % author
    pdfsubject={math},   % subject of the document
    pdfcreator={LaTeX},   % creator of the document
    pdfproducer={LaTeX}, % producer of the document
    pdfkeywords={math}, % list of keywords
    pdfnewwindow=true,      % links in new window
    colorlinks=true,       % false: boxed links; true: colored links
    linkcolor=black, %[rgb]{0 0.4 0.1},          % color of internal links
    citecolor=black, %blue,        % color of links to bibliography
    filecolor=black,      % color of file links
    urlcolor=black % [rgb]{0.3 0.0 0.3}           % color of external links
}

\def\start@i18n{}
\def\start@switcht{}

\def\switcht@albion{%
\def\abstractname{}
\def\ackname{Acknowledgements}
\def\andname{\unskip, }
\def\lastandname{\unskip, }
\def\appendixname{Appendix}
\def\chaptername{Chapter}
\def\claimname{Claim}
\def\conjecturename{Conjecture}
\def\contentsname{Table of Contents}
\def\corollaryname{Corollary}
\def\definitionname{Definition}
\def\examplename{Example}
\def\exercisename{Exercise}
\def\figurename{Fig.}
\def\keywordname{{\bf Keywords:}}
\def\indexname{Index}
\def\lemmaname{Lemma}
\def\contriblistname{List of Contributors}
\def\listfigurename{List of Figures}
\def\listtablename{List of Tables}
\def\mailname{{\it Correspondence to\/}:}
\def\noteaddname{Note added in proof}
\def\notename{Note}
\def\partname{Part}
\def\problemname{Problem}
\def\proofname{Proof}
\def\propertyname{Property}
\def\propositionname{Proposition}
\def\questionname{Question}
\def\remarkname{Remark}
\def\seename{see}
\def\solutionname{Solution}
\def\subclassname{{\it Subject Classifications\/}:}
\def\tablename{Table}
\def\thebibliographyname{References}
\def\theoremname{Theorem}}
\switcht@albion

\def\switcht@russian{%
\def\abstractname{}
\def\ackname{Благодарности}
\def\andname{\unskip, }
\def\lastandname{\unskip, }
\def\appendixname{Приложения}
\def\chaptername{Глава}
\def\claimname{Claim}
\def\conjecturename{Предположение}
\def\contentsname{Содержание}
\def\corollaryname{Следствие}
\def\definitionname{Определение}
\def\examplename{Пример}
\def\exercisename{Упражнение}
\def\figurename{Рис.}
\def\keywordname{{\bf Ключевые слова:}}
\def\indexname{Указатель терминов}
\def\lemmaname{Лемма}
\def\contriblistname{Список соавторов}
\def\listfigurename{Список рисунков}
\def\listtablename{Список таблиц}
\def\mailname{{\it Корреспонденция\/}:}
\def\noteaddname{Замечание в доказательстве}
\def\notename{Замечание}
\def\partname{Часть}
\def\problemname{Задача}
\def\proofname{Доказательство}
\def\propertyname{Свойство}
\def\propositionname{Утверждение}
\def\questionname{Вопрос}
\def\remarkname{Замечание}
\def\seename{см.}
\def\solutionname{Решение}
\def\subclassname{{\it Тематические классификации\/}:}
\def\tablename{Таблица}
\def\thebibliographyname{Список литературы}
\def\theoremname{Теорема}}

% \def\switcht@russian{%
% \def\ackname{\cyr\CYRB\cyrl\cyra\cyrg\cyro\cyrd\cyra\cyrr\cyrn\cyro\cyrs\cyrt\cyri.}
% \def\andname{\cyr\unskip, }
% \def\lastandname{\cyr\unskip, }
% \def\appendixname{\cyr\CYRP\cyrr\cyri\cyrl\cyro\cyrzh\cyre\cyrn\cyri\cyrya}
% \def\chaptername{\cyr\CYRG\cyrl\cyra\cyrv\cyra}
% \def\claimname{\cyr\CYRP\cyrr\cyre\cyrd\cyrp\cyro\cyrl\cyro\cyrzh\cyre\cyrn\cyri\cyre}
% \def\conjecturename{\cyr\CYRP\cyrr\cyre\cyrd\cyrp\cyro\cyrl\cyro\cyrzh\cyre\cyrn\cyri\cyre}
% \def\contentsname{\cyr\CYRS\cyro\cyrd\cyre\cyrr\cyrzh\cyra\cyrn\cyri\cyre}
% \def\corollaryname{\cyr\CYRS\cyrl\cyre\cyrd\cyrs\cyrt\cyrv\cyri\cyre}
% \def\definitionname{\cyr\CYRO\cyrp\cyrr\cyre\cyrd\cyre\cyrl\cyre\cyrn\cyri\cyre}
% \def\examplename{\cyr\CYRP\cyrr\cyri\cyrm\cyre\cyrr}
% \def\exercisename{\cyr\CYRU\cyrp\cyrr\cyra\cyrzh\cyrn\cyre\cyrn\cyri\cyre}
% \def\figurename{\cyr\CYRR\cyri\cyrs.}
% \def\keywordname{{\bf \cyr\CYRK\cyrl\cyryu\cyrch\cyre\cyrv\cyrery\cyre\ \cyrs\cyrl\cyro\cyrv\cyra:}}
% \def\indexname{\cyr\CYRU\cyrk\cyra\cyrz\cyra\cyrt\cyre\cyrl\cyrsftsn\ \cyrt\cyre\cyrr\cyrm\cyri\cyrn\cyro\cyrv}
% \def\lemmaname{\cyr\CYRL\cyre\cyrm\cyrm\cyra}
% \def\contriblistname{\cyr\CYRS\cyrp\cyri\cyrs\cyro\cyrk\ \cyrs\cyro\cyra\cyrv\cyrt\cyro\cyrr\cyro\cyrv}
% \def\listfigurename{\cyr\CYRS\cyrp\cyri\cyrs\cyro\cyrk\ \cyrr\cyri\cyrs\cyru\cyrn\cyrk\cyro\cyrv}
% \def\listtablename{\cyr\CYRS\cyrp\cyri\cyrs\cyro\cyrk\ \cyrt\cyra\cyrb\cyrl\cyri\cyrc}
% \def\mailname{{\it \cyr\CYRK\cyro\cyrr\cyrr\cyre\cyrs\cyrp\cyro\cyrn\cyrd\cyre\cyrn\cyrc\cyri\cyrya\/}:}
% \def\noteaddname{\cyr\CYRZ\cyra\cyrm\cyre\cyrch\cyra\cyrn\cyri\cyre\ \cyrv\ \cyrd\cyro\cyrk\cyra\cyrz\cyra\cyrt\cyre\cyrl\cyrsftsn\cyrs\cyrt\cyrv\cyre}
% \def\notename{\cyr\CYRZ\cyra\cyrm\cyre\cyrch\cyra\cyrn\cyri\cyre}
% \def\partname{\cyr\CYRCH\cyra\cyrs\cyrt\cyrsftsn}
% \def\problemname{\cyr\CYRZ\cyra\cyrd\cyra\cyrch\cyra}
% \def\proofname{\cyr\CYRD\cyro\cyrk\cyra\cyrz\cyra\cyrt\cyre\cyrl\cyrsftsn\cyrs\cyrt\cyrv\cyro}
% \def\propertyname{\cyr\CYRS\cyrv\cyro\cyrishrt\cyrs\cyrt\cyrv\cyro}
% \def\propositionname{\cyr\CYRU\cyrt\cyrv\cyre\cyrr\cyrzh\cyrd\cyre\cyrn\cyri\cyre}
% \def\questionname{\cyr\CYRV\cyro\cyrp\cyrr\cyro\cyrs}
% \def\remarkname{\cyr\CYRZ\cyra\cyrm\cyre\cyrch\cyra\cyrn\cyri\cyre}
% \def\seename{\cyrs\cyrm.}
% \def\solutionname{\cyr\CYRR\cyre\cyrsh\cyre\cyrn\cyri\cyre}
% \def\subclassname{{\it \cyr\CYRT\cyre\cyrm\cyra\cyrt\cyri\cyrch\cyre\cyrs\cyrk\cyri\cyre\ \cyrk\cyrl\cyra\cyrs\cyrs\cyri\cyrf\cyri\cyrk\cyra\cyrc\cyri\cyri\/}:}
% \def\tablename{\cyr\CYRT\cyra\cyrb\cyrl\cyri\cyrc\cyra}
% \def\thebibliographyname{\cyr\CYRS\cyrp\cyri\cyrs\cyro\cyrk\ \cyrl\cyri\cyrt\cyre\cyrr\cyra\cyrt\cyru\cyrr\cyrery}}

\newcommand{\startenglish}{\switcht@albion\selectlanguage{english}}
\newcommand{\startrussian}{\switcht@russian\selectlanguage{russian}}

\newenvironment{englishtitle}%
{
  \selectlanguage{english}
  \switcht@albion
  \@english@titletrue
  \@title@newpagetrue
  \@ru@head@shiftfalse
}%
{%\relax
  \selectlanguage{russian}
  \@english@titlefalse
  \@title@newpagefalse
  \@ru@head@shifttrue
  \vspace{-2em}
}

\newenvironment{englisharticle}%
{
  \startenglish
  \@english@titletrue
  \@russian@titlefalse
  \@title@newpagetrue
  \@ru@head@shiftfalse
}%
{\relax
  \startrussian
  \selectlanguage{russian}
  \switcht@russian
  \@title@newpagetrue
  \@ru@head@shiftfalse
  %\@english@titlefalse
}

\ExplSyntaxOn

%% Acknowledgments
% save the old commands
%\let\ceurack\acknowledgments
%\let\ceurendack\endacknowledgments
\RenewDocumentEnvironment { acknowledgments } { }
{
  \group_begin:
  \section*{\ackname}
}
{ \group_end: }

\ExplSyntaxOff


% Last must be
\frenchspacing
\righthyphenmin=2
\lefthyphenmin=2

\isdct@defgeom
\start@i18n
