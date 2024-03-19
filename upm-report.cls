\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{upm-report}  %[2023-05-31 v1.0 UPM Report Template]

\LoadClass[12pt,a4paper,oneside]{book}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Nos aseguramos de que usamos xetex como motor de compilación
%
\RequirePackage{ifxetex}
\RequireXeTeX

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Paquetes globales
%
\RequirePackage[%
    titletoc
    ]{appendix}             % "Apéndice" antes del nombre del capítulo
\RequirePackage{awesomebox} % Bloques de texto más molones
\RequirePackage{changepage} % Para poder usar los adjustwidth
\RequirePackage{csquotes}   % Facilitar el trabajo con citas
\RequirePackage{eso-pic}    % Colores y fondos
\RequirePackage{graphicx}   % Mejoras sobre el paquete graphics
\RequirePackage{hologo}     % Para poner logos relacionados con LaTeX
\RequirePackage{ifthen}     % Para poder usar condicionales en la clase
\RequirePackage{pdflscape}  % Posibilidad de páginas en apaisado
\RequirePackage{xcolor}     % Mejoras sobre el paquete color
\RequirePackage{tocloft}  % Añadir indice de ecuaciones

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Valores constantes
%
\def\universityname{Universidad Politécnica de Madrid}
\def\templaterepository{https://github.com/blazaid/UPM-Report-Template}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Opciones de la clase
%
\RequirePackage{kvoptions} % Para usar argumentos al importar la clase
\SetupKeyvalOptions{family=@upm, prefix=@upm@}

% Opciones de configuración de la clase
\DeclareStringOption{school}
\DeclareStringOption{type}
\DeclareStringOption{degree}
\ProcessKeyvalOptions*

% Variables relacionadas con la escuela (arg. 'school')
\newcommand{\schoolname}{}
\newcommand{\schoolabbr}{}
\newcommand{\schoollogo}{}
\newcommand{\schooladdress}{}
\ifthenelse{\equal{\@upm@school}{etsiaab}}{%
    \renewcommand{\schoolname}{E.T.S. de Ingeniería Agronómica, Alimentaria y de Biosistemas}
    \renewcommand{\schoolabbr}{ETSIAAB}
    \renewcommand{\schoollogo}{upm-report/logos/logo-etsiaab.png}
    \renewcommand{\schooladdress}{%
        Campus Ciudad Universitaria\\
        Av. Puerta de Hierro, nº 2 - 4\\
        28040 Madrid, España
    }
    \definecolor{schoolcolor}{RGB}{99,178,76}
    \definecolor{linkcolor}{RGB}{99,178,76}
}{}
\ifthenelse{\equal{\@upm@school}{etsidi}}{%
    \renewcommand{\schoolname}{E.T.S. de Ingeniería y Diseño Industrial}
    \renewcommand{\schoolabbr}{ETSIDI}
    \renewcommand{\schoollogo}{upm-report/logos/logo-etsidi.png}
    \renewcommand{\schooladdress}{%
        c/ Ronda de Valencia, 3\\
        28012, Madrid, España
    }
    \definecolor{schoolcolor}{RGB}{223,30,64}
    \definecolor{linkcolor}{RGB}{223,30,64}
}{}
\ifthenelse{\equal{\@upm@school}{etsii}}{%
    \renewcommand{\schoolname}{E.T.S. de Ingenieros Industriales}
    \renewcommand{\schoolabbr}{ETSII}
    \renewcommand{\schoollogo}{upm-report/logos/logo-etsii.png}
    \renewcommand{\schooladdress}{%
        c/ José Gutiérrez Abascal, 2\\
        28006, Madrid, España
    }
    \definecolor{schoolcolor}{RGB}{0,177,230}
    \definecolor{linkcolor}{RGB}{0,177,230}
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

% Variables relacionadas con el tipo de memoria (arg. 'type')
\newcommand{\reporttype}{}
\newcommand{\reporttypeabbr}{}
\ifthenelse{\equal{\@upm@type}{pfg}}{
    \renewcommand{\reporttype}{Proyecto Fin de Grado}
    \renewcommand{\reporttypeabbr}{PFG}
}{}
\ifthenelse{\equal{\@upm@type}{tfg}}{
    \renewcommand{\reporttype}{Trabajo Fin de Grado}
    \renewcommand{\reporttypeabbr}{TFG}
}{}
\ifthenelse{\equal{\@upm@type}{pfm}}{
    \renewcommand{\reporttype}{Proyecto Fin de Máster}
    \renewcommand{\reporttypeabbr}{PFM}
}{}
\ifthenelse{\equal{\@upm@type}{tfm}}{
    \renewcommand{\reporttype}{Trabajo Fin de Máster}
    \renewcommand{\reporttypeabbr}{TFM}
}{}
\ifthenelse{\equal{\@upm@type}{td}}{
    \renewcommand{\reporttype}{Tesis Doctoral}
    \renewcommand{\reporttypeabbr}{PhD}
}{}
\ifthenelse{\equal{\reporttype}{}}{
    \PackageError{upm-report}{Report type}{Falta el parámetro 'type'}
}{}

% Variables relacionadas con el título de estudios (arg. 'degree')
\newcommand{\degreecode}{}
\newcommand{\degreename}{}
%% ETSIAAB
\ifthenelse{\equal{\@upm@degree}{20BT}}{
    \renewcommand{\degreecode}{20BT}
    \renewcommand{\degreename}{Grado en Biotecnología}
}{}
\ifthenelse{\equal{\@upm@degree}{20BI}}{
    \renewcommand{\degreecode}{20BI}
    \renewcommand{\degreename}{Grado en Ciencias Agrarias y Bioeconomía}
}{}
\ifthenelse{\equal{\@upm@degree}{20IG}}{
    \renewcommand{\degreecode}{20IG}
    \renewcommand{\degreename}{Grado en Ingeniería Agrícola}
}{}
\ifthenelse{\equal{\@upm@degree}{02IA}}{
    \renewcommand{\degreecode}{20IA}
    \renewcommand{\degreename}{Grado en Ingeniería Agroambiental}
}{}
\ifthenelse{\equal{\@upm@degree}{20IA}}{
    \renewcommand{\degreecode}{20IA}
    \renewcommand{\degreename}{Grado en Ingeniería Alimentaria}
}{}
%% ETSIDI
\ifthenelse{\equal{\@upm@degree}{56IE}}{
    \renewcommand{\degreecode}{56IE}
    \renewcommand{\degreename}{Grado en Ingeniería Eléctrica}
}{}
\ifthenelse{\equal{\@upm@degree}{56IA}}{
    \renewcommand{\degreecode}{56IA}
    \renewcommand{\degreename}{Grado en Ingeniería Electrónica Industrial y Automática}
}{}
\ifthenelse{\equal{\@upm@degree}{56IM}}{
    \renewcommand{\degreecode}{56IM}
    \renewcommand{\degreename}{Grado en Ingeniería Mecánica}
}{}
\ifthenelse{\equal{\@upm@degree}{56IQ}}{
    \renewcommand{\degreecode}{56IQ}
    \renewcommand{\degreename}{Grado en Ingeniería Química}
}{}
\ifthenelse{\equal{\@upm@degree}{56DD}}{
    \renewcommand{\degreecode}{56DD}
    \renewcommand{\degreename}{Grado en Ingeniería en Diseño Industrial y Desarrollo de Producto}
}{}
%% ETSISI
%% Grados
\ifthenelse{\equal{\@upm@degree}{61CD}}{
    \renewcommand{\degreecode}{61CD}
    \renewcommand{\degreename}{Grado en Ciencia de Datos e Inteligencia Artificial}
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
    \renewcommand{\degreename}{Grado en Tecnologías para la Sociedad de la Información}
}{}
%% Másters
\ifthenelse{\equal{\@upm@degree}{MAADM}}{
    \renewcommand{\degreecode}{MAADM}
    \renewcommand{\degreename}{Máster Universitario en Aprendizaje Automático y Datos Masivos}
}{}

\ifthenelse{\equal{\degreecode}{}}{
    \PackageError{upm-report}{Degree}{Falta el parámetro 'degree'}
}{}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Autores, directores y demás
%
\renewcommand{\and}{y\space}
%\def\authors{}
%\newcounter{author}
%\makeatletter
%\renewcommand{\author}[1]{\@breakauthor#1\@breakauthor}
%\def\@breakauthor#1 #2\@breakauthor{%
%  \gdef\@author{#1 \textsc{#2}}%
%}
%\makeatother
%\renewcommand{\author}[2][]{%
%    \ifthenelse{\equal{#1}{}}{%
%        % Si el argumento opcional está vacío, establece sólo el nombre
%        % del autor con el género por defecto (femenino)
%        \gdef\@author{#2}%
%    }{%
%        % Si se proporciona el argumento opcional, establece tanto el
%        % nombre como el sexo del codirector
%    }
%}
%\def\@breakauthor#1 #2\@breakauthor{%
%  \gdef\@author{#1 \textsc{#2}}%
%}
%\makeatother

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Variables
%
\makeatletter
\newcommand{\bibauthor}[1]{\gdef\@bibauthor{#1}}%
\newcommand{\@bibauthor}{\@latex@warning@no@line{No \noexpand\bibauthor given}}
\newcommand{\director}[1]{\gdef\@director{#1}}%
\newcommand{\@director}{\@latex@warning@no@line{No \noexpand\director given}}
\newcommand{\bibdirector}[1]{\gdef\@bibdirector{#1}}%
\newcommand{\@bibdirector}{\@latex@warning@no@line{No \noexpand\bibdirector given}}

\makeatother

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Idioma
%
% TODO Convertir el lenguaje en una opción del paquete
\RequirePackage[spanish,es-tabla,es-ucroman]{babel}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Geometría general de las páginas
%
\RequirePackage[
    top=3.5cm,
    bottom=3cm,
    left=2.5cm,
    right=2.5cm,
]{geometry}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Cabeceras y pies de página
%
\RequirePackage{fancyhdr}
\setlength{\headheight}{15.1pt}
\pagestyle{fancy}

% Estilos globales
\fancyhf{}
\fancyhead[L]{\textcolor{schoolcolor}{\sffamily\nouppercase{\rightmark}}}
\fancyhead[R]{\textcolor{schoolcolor}{\sffamily\thepage}}
\renewcommand{\headrulewidth}{0.5pt}

% Estilos en páginas "plain" (e.g. primera de capítulo)
\fancypagestyle{plain}{%
    \fancyhf{}
    \renewcommand{\headrule}{}
    \renewcommand{\footrule}{}
}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Estilos de capítulo, sección, ...
%
\RequirePackage{titlesec}

\titleformat{\chapter}%
    {\fontsize{38}{38}}%
    {\sffamily\fontsize{38}{38}\color{schoolcolor}\thechapter.}%
    {0.6em}%
    {\sffamily\fontsize{38}{38}\raggedleft\hspace*{\fill}}
    [\hrule]
\titlespacing*{\chapter}{0pt}{0pt}{25pt}

\titleformat{\section}%
    {}{\sffamily\huge\thesection.}{0.6em}{\sffamily\huge}
\titleformat{\subsection}%
    {}{\sffamily\Large\thesubsection.}{0.6em}{\sffamily\Large}
\titleformat{\subsubsection}%
    {}{\sffamily\large\thesubsubsection.}{0.6em}{\sffamily\large}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Estilos de la tabla de contenidos
%
\RequirePackage{titletoc}
\setcounter{tocdepth}{1}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Fuentes
%
\RequirePackage{fontspec}  % Para importar fuentes externas
\RequirePackage{microtype} % Mejoras tipográficas generales
% TODO Cambiar los tipos de letra según la guía de estilos de la escuela
\setmainfont[
    Path=upm-report/fonts/Montserrat/,
    Extension=.ttf,
    UprightFont=*-Regular,
    BoldFont=*-SemiBold,
    ItalicFont=*-Italic,
    BoldItalicFont=*-SemiBoldItalic,
]{Montserrat}

\setsansfont[
    Path=upm-report/fonts/Barlow Condensed/,
    Extension=.ttf,
    UprightFont=*-Medium,
    BoldFont=*-Bold,
    ItalicFont=*-MediumItalic,
    BoldItalicFont=*-BoldItalic,
]{BarlowCondensed}

\setmonofont[
    Path=upm-report/fonts/Fira Code/,
    Extension=.ttf,
    UprightFont=*-regular,
    BoldFont=*-bold,
]{firacode}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Fórmulas matemáticas
%
\RequirePackage{amsmath}   % Mejoras presentación matemática
\RequirePackage{mathtools} % Más mejoras de presentación matemática

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Configuración de figuras y tablas
%
\RequirePackage{float}      % Mejorar colocación de elementos flotantes
\RequirePackage{tabularx}   % Tablas más configurables
\newcolumntype{C}{%
    >{\centering\arraybackslash}X%
    }                       % Para tener columnas tipo X centradas
\RequirePackage{booktabs}   % Configuraciones para tablas más bonitas
\RequirePackage{caption}    % Mejora de pies de figuras
\RequirePackage{subcaption} % Pies de subfiguras


\DeclareCaptionFormat{caption-upm}{#1#2~\small #3}
\DeclareCaptionLabelFormat{caption-upm}{\textbf{#1 #2}}
\DeclareCaptionLabelSeparator{caption-upm}{.}

\captionsetup{
    format=caption-upm,
    labelformat=caption-upm,
    labelsep=caption-upm,
}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Configuración general de espaciados, geometrías y otros
%
\setlength{\parskip}{1em}
\linespread{1.2}
\setlength{\parindent}{0pt}


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Configuración para PDF e hipervínculos
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
% Estilos de los listados de código fuente
%
\RequirePackage{listings}
\renewcommand{\lstlistingname}{Listado}
\renewcommand*{\lstlistlistingname}{Índice de listados}

\makeatletter
\renewcommand\lstlistoflistings{\bgroup
  \let\contentsname\lstlistlistingname
  \def\l@lstlisting##1##2{\@dottedtocline{1}{1.5em}{2.3em}{##1}{##2}}
  \let\lst@temp\@starttoc \def\@starttoc##1{\lst@temp{lol}}%
  \tableofcontents \egroup}
\makeatother

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
    frame=lines,
    xleftmargin=\parindent,
    belowcaptionskip=1\baselineskip,
    basicstyle=\color{sbase00}\ttfamily,
    keywordstyle=\color{scyan},
    commentstyle=\color{sbase1},
    stringstyle=\color{sblue},
    numberstyle=\color{sviolet},
    identifierstyle=\color{sbase00},
    breaklines=true,
    showstringspaces=false,
    tabsize=2
}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Listados condicionales
%
\RequirePackage[
    figure,table,lstlisting,equation
    ]{totalcount}  % Contar las veces que aparecen entradas en listados

\newcommand\conditionalLoF{\iftotalfigures\listoffigures\fi}
\newcommand\conditionalLoT{\iftotaltables\listoftables\fi}
\newcommand\conditionalLoL{\iftotallstlistings\lstlistoflistings\fi}
% TODO Con las ecuaciones tenemos dos problemas. El primero, que las
% ecuaciones sin caption no aparecen en el listado, y el segundo, que
% las ecuaciones las cuenta independientemente de si aparecen en el
% listado o no, por lo que si hay una equation*, aparece el epígrafe de
% "Listado de ecuaciones" sin ninguna ecuación.
\newcommand\conditionalLoE{\iftotalequations\listofmyequations\fi}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Licencia de la memoria
%
\RequirePackage[%
    type={CC},%
    modifier={by-nc-sa},%
    version={4.0}%
]{doclicense}

\makeatletter
% Impresión de licencia modificada para que incluya más cosas. Es un
% clon de \docLicenseThis
\newcommand{\licencia}{%
    \setlength{\doclicense@hsize}{\linewidth-\doclicense@imagewidth-\doclicense@imagedistance}%
    \begin{center}
        \begin{minipage}{\doclicense@hsize}
            \ifthenelse{\isempty{\doclicense@hyphenation}}{}{%
                \@nameuse{\doclicense@hyphenation} 
            }%
            \doclicenseLongText Obra derivada de \href{\templaterepository}{\templaterepository}.%
        \end{minipage}
        \hfill
        \begin{minipage}{\doclicense@imagewidth}\doclicenseImage\end{minipage}
    \end{center}
    \vspace{-1.5em}
    Todo cambio respecto a la obra original es responsabilidad exclusiva del presente autor.\\
}
\makeatother
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Referencias y bibliografía
%
\RequirePackage[backend=biber,style=ieee]{biblatex}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Portada
%
\makeatletter         
\renewcommand\maketitle{{
    \sffamily
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
        {\large \MakeUppercase{\universityname}}\\*[1em]
        {\large \MakeUppercase{\textbf{\schoolname}}}\\*[1em]
        {\large \MakeUppercase{\reporttype}}\\*[1em]
        {\large \MakeUppercase{\textbf{\degreename}}}
        \vfill
        \begin{hyphenrules}{nohyphenation}
        \raggedright
        \begin{sloppypar}\fontsize{38}{38}\selectfont\@title\end{sloppypar}
        \end{hyphenrules}
        \vfill
        \vfill
        \parbox[b]{\linewidth}{
            \normalsize
            \textbf{Desarrollado por}: \@author \\*[1em]
            \textbf{Dirigido por}: \@director \\*[1em]
            Madrid, \@date
        }
    \end{adjustwidth}
    \normalfont
    \normalsize
}}
\makeatother

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Licencia
%
\makeatletter
\newcommand\makelicense{{
    \footnotesize
    \clearpage
    \thispagestyle{empty}
    ~\vfill
    \par{
        \textit{\@title}\\
        \textbf{Desarrollado por}: \@author\\
        \textbf{Dirigido por}: \@director\\
        \reporttype, \today\\
    }
    
    \par{
        \textbf{\schoolname}\\
        \schooladdress
    }
    \newline
    \hrule
    \par{
        Si deseas citar este trabajo, la entrada completa en \hologo{BibTeX} es la siguiente:

        \texttt{%
            @mastersthesis\{citekey,\\
                title   = \{\@title\},\\
                author  = \{\@bibauthor~y~\@bibdirector\},\\
                school  = \{\schoolname\},\\
                year    = \{\the\year\},\\
                month   = \{\the\month\},\\
                type    = \{\reporttype\}\\
            \}
        }
    }
    \newline
    \hrule
    \vspace*{-0.5cm}\par{\licencia}
 }}
\makeatother

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Agradecimientos
%
\makeatletter
\newcommand{\acknowledgements}[1]{\gdef\@acknowledgements{#1}}%
\newcommand{\@acknowledgements}{}
\newcommand\makeacknowledgements{{
    \ifthenelse{\equal{\@acknowledgements}{}}{}{
        \clearpage
        \thispagestyle{empty}
        \chapter*{Agradecimientos}
        \@acknowledgements
    }
}}
\makeatother

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Resumen y abstract
%
\makeatletter
\newcommand{\abstract}[2]{%
    \ifthenelse{\equal{#1}{spanish}}{\gdef\@abstractsp{#2}}{}%
    \ifthenelse{\equal{#1}{english}}{\gdef\@abstracten{#2}}{}%
}%
\newcommand{\keywords}[2]{%
    \ifthenelse{\equal{#1}{spanish}}{\gdef\@keywordssp{#2}}{}%
    \ifthenelse{\equal{#1}{english}}{\gdef\@keywordsen{#2}}{}%
}%

\newcommand\makeresumen{{
    \clearpage
    \thispagestyle{empty}
    \chapter*{Resumen}
    \@abstractsp

    \textbf{Palabras clave}: \@keywordssp
}}

\newcommand\makeabstract{{
    \clearpage
    \thispagestyle{empty}
    \chapter*{Abstract}
    \@abstracten

    \textbf{Keywords}: \@keywordsen
}}
\makeatother

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Glosario
%
\RequirePackage[acronym,section,nowarn]{glossaries}
% Hacemos que no haya salto de página entre glosario y siglas
\renewcommand*{\glsclearpage}{}
\makeglossaries

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Cubierta trasera
%
\makeatletter         
\newcommand{\makebackcover}{
    \clearpage
    \thispagestyle{empty}
    \pagecolor{schoolcolor}
    \AddToShipoutPicture*{%
        \put(0,0){%
            \colorbox{black}{%
                \parbox[b][12cm]{\paperwidth}{\vfill\hfill}
            }%
        }
    }
    \vspace*{\fill}
    \begin{center}
        \includegraphics[width=6cm]{\schoollogo}
    \end{center}
}
\makeatother

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Elementos del comienzo del documento
%
\makeatletter
\AtBeginDocument{%
    \maketitle
    \makelicense
    \makeacknowledgements
    \makeresumen
    \makeabstract
    
    \frontmatter

    \begingroup
        \tableofcontents
        \conditionalLoF
        \conditionalLoT
        \conditionalLoL
        \conditionalLoE
    \endgroup

    \mainmatter
}
\makeatother

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Elementos del fin del documento
%
\makeatletter
\AtEndDocument{
    \backmatter

    \printbibliography
    \chapter*{Índice de términos}
    \printglossaries
    %\printindex  TODO Hacer el índice (por supuesto opcional)
    \makebackcover
}
\makeatother

%%gmedina solution
\newcommand{\listequationsname}{Índice de ecuaciones}
\newlistof{myequations}{equ}{\listequationsname}
\newcommand{\myequations}[1]{%
\addcontentsline{equ}{myequations}{\protect\numberline{\theequation}#1}\par}
\setlength{\cftmyequationsnumwidth}{2.5em}% Width of equation number in List of Equations
\makeatother

\endinput