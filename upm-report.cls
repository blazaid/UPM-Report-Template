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
\RequirePackage{ifthen}     % Para poder usar condicionales en la clase
\RequirePackage{pdflscape}  % Posibilidad de páginas en apaisado
\RequirePackage{xcolor}     % Mejoras sobre el paquete color

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Valores constantes
%
\def\universityname{Universidad Politécnica de Madrid}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Opciones de la clase
%
\RequirePackage{kvoptions} % Para usar argumentos al importar la clase
\SetupKeyvalOptions{family=@upm, prefix=@upm@}

% Opciones de configuración de la clase
\DeclareStringOption{school}
\DeclareStringOption{type}
\DeclareStringOption{degree}
\DeclareStringOption{authorsex}
\DeclareStringOption{directorsex}
\ProcessKeyvalOptions*

% Variables relacionadas con la escuela (arg. 'school')
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
%% ETSISI
\ifthenelse{\equal{\@upm@degree}{61CD}}{
    \renewcommand{\degreecode}{61CD}
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

% Variables relacionadas con el sexo del autor (arg. 'degree')
\newcommand{\authorsex}{\@upm@authorsex}
\ifthenelse{\not \( \equal{\authorsex}{m} \or \equal{\authorsex}{f} \)}{
    \PackageError{upm-report}{Author sex}{Falta el parámetro 'authorsex'}
}{}

% Variables relacionadas con el sexo del director (arg. 'degree')
\newcommand{\directorsex}{\@upm@directorsex}
\ifthenelse{\not \( \equal{\directorsex}{m} \or \equal{\directorsex}{f} \)}{
    \PackageError{upm-report}{Director sex}{Falta el parámetro 'directorsex'}
}{}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Variables
%
\makeatletter
\newcommand{\director}[1]{\gdef\@director{#1}}%
\newcommand{\@director}{\@latex@warning@no@line{No \noexpand\director given}}\makeatother

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Idioma
%
% TODO Convertir el lenguaje en una opción del paquete
\RequirePackage[spanish,es-tabla]{babel}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Geometría general de las páginas
%
\RequirePackage[
    top=3.5cm,
    bottom=3.5cm,
    left=2.5cm,
    right=2.5cm,
]{geometry}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Cabeceras y pies de página
%
\RequirePackage{fancyhdr}
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
    %Scale=0.85
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
    figure,table,lstlisting
    ]{totalcount}  % Contar las veces que aparecen entradas en listados

\newcommand\conditionalLoF{\iftotalfigures\listoffigures\fi}
\newcommand\conditionalLoT{\iftotaltables\listoftables\fi}
\newcommand\conditionalLoL{\iftotallstlistings\lstlistoflistings\fi}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Licencia de la memoria
%
\RequirePackage[%
    type={CC},%
    modifier={by-nc-sa},%
    version={4.0}%
]{doclicense}

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
        {\fontsize{38}{38}\selectfont\@title}\\*[0.3cm]
        \vfill
        \parbox[b]{\linewidth}{%
            \normalsize
            \textbf{\ifthenelse{\equal{\authorsex}{m}}{Autor}{Autora}}: \@author\\*[1em]
            \textbf{\ifthenelse{\equal{\directorsex}{m}}{Director}{Directora}}: \@director\\*[1em]
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
    \clearpage
    \thispagestyle{empty}
    ~\vfill
    %\setlength{\parindent}{0pt}
    %\setlength{\parskip}{\baselineskip}
    \@author
    \par{
        \textit{\@title}\\
        \reporttype, \today\\
        \textbf{\ifthenelse{\equal{\directorsex}{m}}%
            {Director}%
            {Directora}%
        }: \@director
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
\usepackage[acronym, section]{glossaries}
\renewcommand*{\glsclearpage}{}
\makeglossaries

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Cómo citar
%
\makeatletter         
\newcommand{\makehowtocite}{%
\clearpage
\thispagestyle{empty}
Si deseas citar este trabajo, la entrada completa en \BibTeX\xspace es la siguiente:
% TODO Arreglar esto para que tenga un mejor estilo
% TODO Generar la citation key a partir del año, el nombre del autor y el título del proyecto
\begin{verbatim}
@phdthesis{citation\_key,\\
    author="\theauthor"\\
    title="\@title",\\
    school="\schoolname",\\
    year=\the\year\\
}
\end{verbatim}
}
\makeatother

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
    % TODO Hacer que las secciones aparezcan sólo si tienen algo definido
    \maketitle
    \makelicense
    \makeacknowledgements
    \makeresumen
    \makeabstract
    
    \frontmatter

    \begingroup
        \let\clearpage\relax
        \tableofcontents
        %\listoffigures
        \conditionalLoF
        %\listoftables
        \conditionalLoT
        %\lstlistoflistings
        \conditionalLoL
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
    %\makehowtocite
    \makebackcover
}
\makeatother

\endinput