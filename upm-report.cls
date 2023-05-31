\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{upm-report}

\LoadClass[12pt, a4paper, oneside, extrafontsizes]{memoir}

% Nos aseguramos de que usamos xetex como motor de compilación
\RequirePackage{ifxetex}
\RequireXeTeX

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Requisitos base
%
\RequirePackage{ifthen}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Para los colores y fondos
%
\RequirePackage{graphicx}
\RequirePackage{xcolor}
\RequirePackage{eso-pic}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Constantes
%
\def\universityname{Universidad Politécnica de Madrid}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Opciones de la clase
%
\RequirePackage{kvoptions}
\SetupKeyvalOptions{family=@upm, prefix=@upm@}

\DeclareStringOption{school}
\DeclareStringOption{type}
\DeclareStringOption{degree}
\DeclareStringOption{authorsex}
\DeclareStringOption{directorsex}

\ProcessKeyvalOptions*

% Comprobamos que los valores de las opciones son válidos y creamos las
% variables en consecuencia

%%% Información específica de la escuela
\newcommand{\schoolname}{}
\newcommand{\schoolabbr}{}
\newcommand{\schoollogo}{}
\newcommand{\schooladdress}{}
\ifthenelse{\equal{\@upm@school}{etsii}}{%
    \renewcommand{\schoolname}{E.T.S. de Ingenieros Industriales}
    \renewcommand{\schoolabbr}{ETSII}
    \renewcommand{\schoollogo}{upm-report/logos/logo-etsii.png}
    \renewcommand{\schooladdress}{%
        c/ José Gutiérrez Abascal, 2\\
        28006, Madrid, España
    }
    \definecolor{schoolcolor}{RGB}{0,177,230}
    \definecolor{linkcolor}{RGB}{0,170,230}
}{}
\ifthenelse{\equal{\@upm@school}{etsisi}}{%
    \renewcommand{\schoolname}{E.T.S. de Ingeniería de Sistemas Informáticos}
    \renewcommand{\schoolabbr}{ETSISI}
    \renewcommand{\schoollogo}{upm-report/logos/logo-etsisi.png}
    \renewcommand{\schooladdress}{%
        Campus Sur UPM, Carretera de Valencia (A-3), km. 7\\
        28031, Madrid, España
    }
    \definecolor{schoolcolor}{RGB}{31,130,192}
    \definecolor{linkcolor}{RGB}{31,130,192}
}{}

\ifthenelse{\equal{\schoolname}{}}{
    \PackageError{upm-report}{School}{Falta el parámetro 'school'}
}{}

%%% Tipo de memoria
\newcommand{\reporttype}{}
\newcommand{\reporttypeabbr}{}
\ifthenelse{\equal{\@upm@type}{pfg}}{
    \renewcommand{\reporttype}{Proyecto Fin de Grado}
    \renewcommand{\reporttypeabbr}{PFG}
}{}
\ifthenelse{\equal{\@upm@type}{pfm}}{
    \renewcommand{\reporttype}{Proyecto Fin de Máster}
    \renewcommand{\reporttypeabbr}{PFM}
}{}
\ifthenelse{\equal{\@upm@type}{td}}{
    \renewcommand{\reporttype}{Tesis Doctoral}
    \renewcommand{\reporttypeabbr}{PhD}
}{}
\ifthenelse{\equal{\reporttype}{}}{
    \PackageError{upm-report}{Report type}{Falta el parámetro 'type'}
}{}

%%% Título de grado, máster o doctorado
\newcommand{\degreecode}{}
\newcommand{\degreename}{}

%%%% ETSII
\ifthenelse{\equal{\@upm@degree}{05TI}}{
    \renewcommand{\degreecode}{05TI}
    \renewcommand{\degreename}{%
        Grado en Ingeniería en Tecnologías Industriales
    }
}{}
\ifthenelse{\equal{\@upm@degree}{05IQ}}{
    \renewcommand{\degreecode}{05IQ}
    \renewcommand{\degreename}{%
        Grado en Ingeniería Química
    }
}{}
\ifthenelse{\equal{\@upm@degree}{05IR}}{
    \renewcommand{\degreecode}{05IR}
    \renewcommand{\degreename}{%
        Grado en Ingeniería de Organización
    }
}{}
\ifthenelse{\equal{\@upm@degree}{05IE}}{
    \renewcommand{\degreecode}{05IE}
    \renewcommand{\degreename}{%
        Grado en Ingeniería de la Energía
    }
}{}

%%%% ETSISI
\ifthenelse{\equal{\@upm@degree}{61CDIA}}{
    \renewcommand{\degreecode}{61CDIA}
    \renewcommand{\degreename}{%
        Grado en Ciencia de Datos e Inteligencia Artificial
    }
}{}
\ifthenelse{\equal{\@upm@degree}{61CI}}{
    \renewcommand{\degreecode}{61CI}
    \renewcommand{\degreename}{Grado en Ingeniería de Computadores}
}{}
\ifthenelse{\equal{\@upm@degree}{61IW}}{
    \renewcommand{\degreecode}{61IW}
    \renewcommand{\degreename}{Grado en Ingeniería del Software}
}{}
\ifthenelse{\equal{\@upm@degree}{61SI}}{
    \renewcommand{\degreecode}{61SI}
    \renewcommand{\degreename}{Grado en Sistemas de Información}
}{}
\ifthenelse{\equal{\@upm@degree}{61TI}}{
    \renewcommand{\degreecode}{61TI}
    \renewcommand{\degreename}{%
        Grado en Tecnologías para la Sociedad de la Información
    }
}{}
\ifthenelse{\equal{\degreecode}{}}{
    \PackageError{upm-report}{Degree}{Falta el parámetro 'degree'}
}{}

%%% Sexo del autor
\newcommand{\authorsex}{\@upm@authorsex}
\ifthenelse{\not \( \equal{\authorsex}{m} \or \equal{\authorsex}{f} \)}{
    \PackageError{upm-report}{Author sex}{Falta el parámetro 'authorsex'}
}{}

%%% Sexo del director
\newcommand{\directorsex}{\@upm@directorsex}
\ifthenelse{\not \( \equal{\directorsex}{m} \or \equal{\directorsex}{f} \)}{
    \PackageError{upm-report}{Director sex}{Falta el parámetro 'directorsex'}
}{}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Algunos comandos
%

% Director del trabajo o tesis. Es un clone de "author", por lo que debería
% funcionar también con varios mediante el comando \and
\makeatletter
\newcommand{\director}[1]{\gdef\@director{#1}}%
\newcommand{\@director}{\@latex@warning@no@line{No \noexpand\director given}}
\addtoiargdef{\director}{%
  \begingroup\let\footnote\@gobble}{%
  \begingroup
    \renewcommand{\thanks}[1]{}
    \renewcommand{\and}{\unskip, }
    \renewcommand{\andnext}{\unskip, }
    \renewcommand{\thanksmark}[1]{}
    \renewcommand{\thanksgap}[1]{}
    \protected@xdef\thedirector{#1}
  \endgroup\endgroup}
\newcommand{\predirector}[1]{\def\@bspredirector{#1}}
\newcommand{\postdirector}[1]{\def\@bspostdirector{#1}}
\renewcommand{\maketitlehookc}{%
  {\@bspredirector \@director \@bspostdirector}%
}
\predirector{\begin{center}
  \large \lineskip .5em%
  \begin{tabular}[t]{c}}
\postdirector{\end{tabular}\par\end{center}}
\makeatother

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Configuraciones varias
%
\pageaiv
\setlength{\trimtop}{0pt}
\setlength{\trimedge}{\stockwidth}
\addtolength{\trimedge}{-\paperwidth}
\settypeblocksize{634pt}{448.13pt}{*}
\setulmargins{4cm}{*}{*}
\setlrmargins{*}{*}{1}
\setmarginnotes{17pt}{51pt}{\onelineskip}
\setheadfoot{\onelineskip}{2\onelineskip}
\setheaderspaces{*}{2\onelineskip}{*}
\checkandfixthelayout
\sideparmargin{outer}

\RequirePackage{mathtools}
\RequirePackage[tablegrid,owncaptions]{vhistory}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% La gente odia la palabra cuadro
%
\renewcommand{\tablename}{Tabla}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Para las figuras
%
\RequirePackage{float}
\RequirePackage{caption}
\RequirePackage{subcaption}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Para los colores y fondos
%
\RequirePackage{graphicx}
\RequirePackage{xcolor}
\RequirePackage{eso-pic}

% Configuración específica de los colores definidos para la escuela
\ifthenelse{\equal{\schoolabbr}{ETSISI}}{%
    \definecolor{schoolcolor}{RGB}{0,170,228}
    \definecolor{linkcolor}{RGB}{0,170,228}
}{}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Idioma
%
\RequirePackage{polyglossia}
\setmainlanguage{spanish}
\gappto\captionsspanish{%
    \renewcommand{\tablename}{Tabla}%
    \renewcommand{\listtablename}{Índice de tablas}
}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Gestión de las comillas
%
\RequirePackage{csquotes}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Licencia de la memoria
%
\RequirePackage[type={CC}, modifier={by-nc-sa}, version={4.0}]{doclicense}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Referencias y bibliografía
%
\RequirePackage[backend=biber,style=ieee]{biblatex}
\addbibresource{references.bib}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Para bloques de texto más molones
%
\RequirePackage{awesomebox}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Cabeceras y pies de página
%
\def\hffont{\color{schoolcolor}\sffamily\small}
\makepagestyle{schoolheader}
\makeheadrule{schoolheader}{\textwidth}{\normalrulethickness}
\makeevenhead{schoolheader}{\hffont\thepage}{}{\hffont\leftmark}
\makeoddhead{schoolheader}{\hffont\rightmark}{}{\hffont\thepage}
\makeevenfoot{schoolheader}{}{}{}
\makeoddfoot{schoolheader}{}{}{}
\makepsmarks{schoolheader}{
    \nouppercaseheads
    \createmark{chapter}{both}{shownumber}{}{\space}
    \createmark{section}{right}{shownumber}{}{\space}
    \createplainmark{toc}{both}{\contentsname}
    \createplainmark{lof}{both}{\listfigurename}
    \createplainmark{lot}{both}{\listtablename}
    \createplainmark{bib}{both}{\bibname}
    \createplainmark{index}{both}{\indexname}
    \createplainmark{glossary}{both}{\glossaryname}
}
\pagestyle{schoolheader}
\copypagestyle{cleared}{schoolheader}
\makeevenhead{cleared}{\hffont\thepage}{}{}
\makeevenfoot{plain}{}{}{}
\makeoddfoot{plain}{}{}{}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Hypersetup
%
\RequirePackage[naturalnames]{hyperref}
\makeatletter
\hypersetup{
    pdfauthor={\@author},
    pdftitle={\@title},
    %pdfsubject={},   % TODO PONER ALGUNA OPCIÓN PARA DETERMINAR EL TEMA
    %pdfkeywords={},  % TODO QUE LAS KEYWORDS SE USEN TAMBIÉN AQUÍ
    pdfcreator={\@author},
    pdfproducer={},
    breaklinks=true,
    linktoc=all,
    plainpages=false,
    unicode=true,
    colorlinks=true,
    linkcolor={linkcolor},
}
\makeatother

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Fuentes
%
\RequirePackage{microtype}
\RequirePackage{fontspec}
\RequirePackage{sansmath}

\setmainfont{Crimson-Roman}[
    Ligatures=TeX,
    ItalicFont = {Crimson-Italic},
    BoldFont = {Crimson-Semibold},
    BoldItalicFont = {Crimson-SemiboldItalic}
]

\setsansfont[
    Path=upm-report/fonts/Helvetica Neue LT/,
    UprightFont = * 57 Condensed,
    BoldFont = * 77 Bold Condensed,
    ItalicFont = * 57 Condensed Oblique,
    BoldItalicFont = * 77 Bold Condensed Oblique,
]{Helvetica Neue LT}

\setmonofont[
    Path=upm-report/fonts/Fira Code/,
    Extension=.ttf,
    UprightFont=*-regular,
    BoldFont=*-bold,
    Scale=0.85
]{firacode}

% TODO Probar esta porque parece que se ve algo mejor en las fórmulas
%\setmathsf{Latin Modern Sans}

% Logos de LaTeX, BibTex, etc.
\RequirePackage{dtk-logos}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Configuración general de espaciados
%
\setlength{\parskip}{1em}
\linespread{1.2}
\setlength{\parindent}{0pt}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Estilos de capítulos, secciones y párrafos
%

% Capítulo
\makechapterstyle{upmstyle}{%
    \renewcommand{\chapnamefont}{\normalfont\sffamily}
    \renewcommand{\chapnumfont}{
        \sffamily\fontsize{38}{38}\color{schoolcolor}\selectfont
    }
    \renewcommand{\chaptitlefont}{
        \HUGE\sffamily\raggedleft\color{black}\selectfont
    }
    \renewcommand{\printchaptername}{}
    \renewcommand{\chapternamenum}{}
    \renewcommand{\printchapternum}{\chapnumfont \thechapter}
    \renewcommand{\afterchapternum}{.\hfill}
    \renewcommand{\afterchaptertitle}{\par\nobreak\medskip\hrule\vskip\afterchapskip}
    
}
\chapterstyle{upmstyle}

% TODO Intentar buscar unos estilos con un poco más de gusto
\setsecheadstyle              {\huge\sffamily\raggedright}
\setsubsecheadstyle           {\LARGE\sffamily\raggedright}
\setsubsubsecheadstyle        {\Large\sffamily\raggedright}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Listados de código fuente
%
\RequirePackage{listings}
\renewcommand{\lstlistingname}{Listado}
\renewcommand*{\lstlistlistingname}{Índice de listados}

\definecolor{sbase03}{HTML}{002B36}
\definecolor{sbase02}{HTML}{073642}
\definecolor{sbase01}{HTML}{586E75}
\definecolor{sbase00}{HTML}{657B83}
\definecolor{sbase0}{HTML}{839496}
\definecolor{sbase1}{HTML}{93A1A1}
\definecolor{sbase2}{HTML}{EEE8D5}
\definecolor{sbase3}{HTML}{FDF6E3}
\definecolor{syellow}{HTML}{B58900}
\definecolor{sorange}{HTML}{CB4B16}
\definecolor{sred}{HTML}{DC322F}
\definecolor{smagenta}{HTML}{D33682}
\definecolor{sviolet}{HTML}{6C71C4}
\definecolor{sblue}{HTML}{268BD2}
\definecolor{scyan}{HTML}{2AA198}
\definecolor{sgreen}{HTML}{859900}
\lstset{
    sensitive=true,
    aboveskip=\baselineskip,
    belowskip=\baselineskip,
    % Border (above and below)
    frame=lines,
    % Extra margin on line (align with paragraph)
    xleftmargin=\parindent,
    % Put extra space under caption
    belowcaptionskip=1\baselineskip,
    % Colors
    % backgroundcolor=\color{sbase3},
    basicstyle=\color{sbase00}\ttfamily,
    keywordstyle=\color{scyan},
    commentstyle=\color{sbase1},
    stringstyle=\color{sblue},
    numberstyle=\color{sviolet},
    identifierstyle=\color{sbase00},
    % Break long lines into multiple lines?
    breaklines=true,
    % Show a character for spaces?
    showstringspaces=false,
    tabsize=2
}
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Manejo de PDF
%
\RequirePackage{pdflscape}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Fórmulas matemáticas
%
\RequirePackage{amsmath}

\RequirePackage{verbatim}
\RequirePackage{fancyvrb}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Glosario
%
\RequirePackage[acronym,noredefwarn]{glossaries}
\makeglossaries

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Para tener los números de mes
%
\let\ordinal\relax
\usepackage{datetime}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Secciones para agradecimientos, resumen y eso
%
\makeatletter
\renewcommand{\abstract}[2]{%
    \ifthenelse{\equal{#1}{spanish}}{\gdef\@abstractsp{#2}}{}%
    \ifthenelse{\equal{#1}{english}}{\gdef\@abstracten{#2}}{}%
}%
\makeatother
\makeatletter
\newcommand{\keywords}[2]{%
    \ifthenelse{\equal{#1}{spanish}}{\gdef\@keywordssp{#2}}{}%
    \ifthenelse{\equal{#1}{english}}{\gdef\@keywordsen{#2}}{}%
}%
\makeatother

\makeatletter
\newcommand{\acknowledgements}[1]{\gdef\@acknowledgements{#1}}%
\newcommand{\@acknowledgements}{\@latex@warning@no@line{No \noexpand\acknowledgements given}}
\makeatother

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Portada y primeras páginas
%
\makeatletter
\def\@maketitle{%
    % Portada
    \thispagestyle{empty}
    % Barra lateral izquierda y logo fondo
    \AddToShipoutPicture*{%
        \AtPageLowerLeft{%
            \makebox[1\paperwidth][r]{%
                \includegraphics[width=0.9\paperwidth]{upm-report/logos/logo-upm}
            }%
        }
        \put(0,0){%
            \colorbox{schoolcolor}{%
                \parbox[b][\paperheight]{2cm}{\vfill\hfill}
            }%
        }
    }
    \begin{adjustwidth}{1.5cm}{}
        \sffamily
        {\large \MakeUppercase{\universityname}}\\*[1em]
        {\large \MakeUppercase{\textbf{\schoolname}}}\\*[1em]
        {\large \MakeUppercase{\reporttype}}\\*[1em]
        {\large \MakeUppercase{\textbf{\degreename}}}
        \vfill
        {\HUGE \@title}\\*[0.3cm]
        \vfill
        \parbox[b]{\linewidth}{%
            \normalsize
            \textbf{\ifthenelse{\equal{\authorsex}{m}}{Autor}{Autora}}: \theauthor\\*[1em]
            \textbf{\ifthenelse{\equal{\directorsex}{m}}{Director}{Directora}}: \@director\\*[1em]
            Madrid, \monthname\xspace\the\year
        }
    \end{adjustwidth}
    \normalfont
    \normalsize
    
	\clearpage
	
	% Licencia
	\thispagestyle{empty}
	~\vfill
	\setlength{\parindent}{0pt}
	\setlength{\parskip}{\baselineskip}
	\theauthor
	\par{
		\textit{\@title}\\
		\reporttype, \textspanish{\today}\\
		\textbf{\ifthenelse{\equal{\directorsex}{m}}{Director}{Directora}}: \@director
	}
	
	\par{
		\textbf{\schoolname}\\
		\schooladdress
	}
	
	\par{
    \doclicenseThis
 }

 \par{
 \footnotesize Obra derivada de \href{https://github.com/blazaid/UPM-Report-Template}{https://github.com/blazaid/UPM-Report-Template}. Todo cambio y modificación respecto a la obra original son responsabilidad exclusiva del presente autor.
 }
    
 \clearpage
 
 % Resumen
	\thispagestyle{empty}
    \chapter*{Resumen}
	\@abstractsp
	
	\textbf{Palabras clave}: \@keywordssp

    % Abstract
	\thispagestyle{empty}
    \chapter*{Abstract}
	\@abstracten
	
	\textbf{Keywords}: \@keywordsen

    % Agradecimientos
	\thispagestyle{empty}
	\selectlanguage{spanish}
    \chapter*{Agradecimientos}
    \@acknowledgements
}

\AtBeginDocument{%
    % Portada y demás elementos
    \maketitle
}

% Páginas y procesos a ejecutar al final de la compilación
\AtEndDocument{
    % Glosario
    % TODO Añadirlo sólo si existe alguna entrada en el glosario
    \printglossary

    % Índice
    % TODO Añadirlo sólo si existe alguna entrada en el índice
    %\printindex

    % Página de cómo citar
    %\clearpage
	%\thispagestyle{empty}
	%\vspace*{\fill}

    %Si deseas citar este trabajo, la entrada completa en \BibTeX\xspace es la siguiente:
    % TODO Arreglar esto para que tenga un mejor estilo
    % TODO Generar la citation key a partir del año, el nombre del autor y el título del proyecto
%\begin{verbatim}
%@phdthesis{citation\_key,\\
%    author="\theauthor"\\
%    title="\@title",\\
%    school="\schoolname",\\
%    year=\the\year\\
%}
%\end{verbatim}
    % Página de cubierta trasera
    \clearpage
    \thispagestyle{empty}
    \pagecolor{schoolcolor}
    \AddToShipoutPicture*{%
        \put(0,0){%
            \colorbox{black}{%
                \parbox[b][10cm]{\paperwidth}{\vfill\hfill}
            }%
        }
    }
    \vspace*{\fill}
    \begin{center}\includegraphics[width=6cm]{\schoollogo}\end{center}
}

\makeatother