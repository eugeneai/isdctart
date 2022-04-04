
\NeedsTeXFormat{LaTeX2e}[1995/12/01]
\ProvidesClass{isdctart}[2022/03/31,0.1.0: Typesetting articles for ISDCT SB RAS Journal]

\newcommand{\isdct@setmonofont}[1]{%
  \setmonofont{#1}[Scale=MatchLowercase]
  \newfontfamily{\cyrillicfonttt}{#1}[Scale=MatchLowercase]
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


\DeclareOption*{\PassOptionsToClass{\CurrentOption}{ceurart}}
\ExecuteOptions{}% No default options for now
\ProcessOptions\relax
\LoadClass{ceurart}






\RequirePackage{iftex}
\ifPDFTeX\else
\RequirePackage{luatextra}
\RequirePackage{unicode-math}
%\defaultfontfeatures{Scale=MatchLowercase}
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
