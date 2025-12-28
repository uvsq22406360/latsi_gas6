(* parser.mly *)

%{
  open Ast

  let variables = Array.make 26 0
%}

%token <int> NUMBER
%token VAR STRING
%token IMPRIME SI ALORS VAVERS ENTREE FIN REM NL
%token PLUS MINUS TIMES EGAL DIVIDE INF INF_OU_EGAL SUP SUP_OU_EGAL EGALITE DIFF 
%token VERGULE LPAREN RPAREN QUOTE
%token EOF

%start <Ast.programme> programme
%type <Ast.ligne> ligne
%type <Ast.instruction> instr
%type <Ast.expression list> expr_list
%type <Ast.variable list> var_list
%type <Ast.expression> expression
%type <Ast.facteur> term facteur
%type <Ast.variable> var
%type <Ast.relation> relop

%%

programme:
  | ligne EOF { $1 }

ligne:
  | NUMBER instr NL { { numero_ligne = $1; instruction = $2 } }

instr:
  | IMPRIME expr_list { Imprime $2 }
  | SI expression relop expression ALORS instr { Si ($2, $3, $4, $5) }
  | VAVERS expression { Vavers $2 }
  | ENTREE var_list { Entree $2 }
  | VAR EGAL expression { Affectation ($1, $3) }
  | FIN { Fin }
  | REM STRING { Rem $2 }
  | NL { Nl }

expr_list:
  | LPAREN expr_list RPAREN { $2 }
  | QUOTE STRING QUOTE { [String $1] }
  | expression { [$1] }
  | expr_list VERGULE LPAREN expr_list RPAREN { $1 @ $4 }

var_list:
  | var { [$1] }
  | var_list VERGULE var { $1 @ [$3] }

expression:
  | PLUS term { Plus $2 }
  | MINUS term { Moins $2 }
  | term { $1 }

term:
  | TIMES facteur { Mult $2 }
  | DIVIDE facteur { Div $2 }
  | facteur { $1 }

facteur:
  | var { Var $1 }
  | NUMBER { Num $1 }
  | LPAREN expression RPAREN { $2 }

var:
  | VAR  { Char.code (String.get $1 0) - 65 }

relop:
  | INF { Inf }
  | INF_OU_EGAL { Inf_ou_egal }
  | SUP { Sup }
  | SUP_OU_EGAL { Sup_ou_egal }
  | EGALITE { Egalite }
  | DIFF { Diff }

%%



(*%{
  open Ast  (* Importe le module Ast, qui contient les types d'AST définis pour le langage LATSI. *)
%}

%token <int> NUMBER  (* Déclare un jeton NUMBER avec une annotation <int> pour contenir une valeur entière. *)
%token VAR STRING  (* Déclare des jetons VAR et STRING pour les variables et les chaînes de caractères. *)
%token IMPRIME SI ALORS VAVERS ENTREE FIN REM NL  (* Déclare des jetons pour les mots-clés réservés du langage. *)
%token PLUS MINUS TIMES EGAL DIVIDE INF INF_OU_EGAL SUP SUP_OU_EGAL EGALITE DIFF  (* Déclare des jetons pour les opérateurs et les opérateurs de comparaison. *)
%token VERGULE LPAREN RPAREN QUOTE  (* Déclare des jetons pour les symboles de ponctuation. *)
%token EOF  (* Déclare un jeton pour la fin du fichier. *)

%start <Ast.programme> programme  (* Spécifie le point de départ de l'analyse syntaxique, qui est la règle 'programme'. *)
%type <Ast.ligne list> programme  (* Indique le type de l'AST résultant de la règle 'programme'. *)
%type <Ast.ligne> ligne  (* Indique le type de l'AST résultant de la règle 'ligne'. *)
%type <Ast.instruction> instr  (* Indique le type de l'AST résultant de la règle 'instr'. *)
%type <Ast.expression list> expr_list  (* Indique le type de l'AST résultant de la règle 'expr_list'. *)
%type <Ast.variable list> var_list  (* Indique le type de l'AST résultant de la règle 'var_list'. *)
%type <Ast.expression> expression  (* Indique le type de l'AST résultant de la règle 'expression'. *)
%type <Ast.facteur> term facteur  (* Indique le type de l'AST résultant des règles 'term' et 'facteur'. *)

%%

programme:
  | ligne EOF { $1 }  (* Définit la règle pour un programme, qui consiste en une séquence de lignes suivie de la fin du fichier. *)

ligne:
  | NUMBER instr NL { { numero_ligne = $1; instruction = $2 } }  (* Définit la règle pour une ligne de programme, comprenant un numéro de ligne suivi d'une instruction et d'un saut de ligne. *)

instr:
  | IMPRIME expr_list { Imprime $2 }  (* Définit la règle pour l'instruction IMPRIME, prenant une liste d'expressions à imprimer. *)
  | SI expression relop expression ALORS instr { Si ($2, $3, $4, $5) } //A voir (* Définit la règle pour l'instruction SI, avec une condition, une relation de comparaison, une autre condition et une instruction à exécuter. *)
  | VAVERS expression { Vavers $2 }  (* Définit la règle pour l'instruction VAVERS, indiquant un saut à une autre ligne en fonction d'une expression. *)
  | ENTREE var_list { Entree $2 }  (* Définit la règle pour l'instruction ENTREE, demandant à l'utilisateur d'entrer des valeurs pour une liste de variables. *)
  | VAR EGAL expression { Affectation ($1, $3) }  (* Définit la règle pour l'instruction d'affectation, assignant une expression à une variable. *)
  | FIN { Fin }  (* Définit la règle pour l'instruction FIN, indiquant la fin du programme. *)
  | REM STRING { Rem $2 }  (* Définit la règle pour l'instruction REM, un commentaire sans effet sur l'exécution. *)
  | NL { Nl }  (* Définit la règle pour un saut de ligne. *)

expr_list:
  | LPAREN expr_list RPAREN { $2 }  (* Définit la règle pour une liste d'expressions entre parenthèses. *)
  | STRING { [String $1] }  (* Définit la règle pour une expression représentant une chaîne de caractères. *)
  | expression { [$1] }  (* Définit la règle pour une expression simple. *)
  | expr_list VERGULE LPAREN expr_list RPAREN { $1 @ $4 }  (* Définit la règle pour une liste d'expressions séparées par des virgules. *)

var_list:
  | VAR { [$1] }  (* Définit la règle pour une liste de variables contenant une seule variable. *)
  | var_list VERGULE VAR { $1 @ [$3] }  (* Définit la règle pour une liste de variables séparées par des virgules. *)

expression:
  | PLUS term { Plus $2 }  (* Définit la règle pour une expression avec un opérateur de somme. *)
  | MINUS term { Moins $2 }  (* Définit la règle pour une expression avec un opérateur de soustraction. *)
  | term { $1 }  (* Définit la règle pour une expression simple. *)

term:
  | TIMES facteur { Mult $2 }  (* Définit la règle pour un terme avec un opérateur de multiplication. *)
  | DIVIDE facteur { Div $2 }  (* Définit la règle pour un terme avec un opérateur de division. *)
  | facteur { $1 }  (* Définit la règle pour un facteur simple. *)

facteur:
  | VAR { Var $1 }  (* Définit la règle pour un facteur représentant une variable. *)
  | NUMBER { Num $1 }  (* Définit la règle pour un facteur représentant un nombre. *)
  | LPAREN expression RPAREN { $2 }  (* Définit la règle pour un facteur entre parenthèses, représentant une expression. *)

relop:
  | INF { Inf }  (* Définit la règle pour l'opérateur de comparaison inférieur. *)
  | INF_OU_EGAL { Inf_ou_egal }  (* Définit la règle pour l'opérateur de comparaison inférieur ou égal. *)
  | SUP { Sup }  (* Définit la règle pour l'opérateur de comparaison supérieur. *)
  | SUP_OU_EGAL { Sup_ou_egal }  (* Définit la règle pour l'opérateur de comparaison supérieur ou égal. *)
  | EGAL { Egal }  (* Définit la règle pour l'opérateur de comparaison égal. *)
  | DIFF { Diff }  (* Définit la règle pour l'opérateur de comparaison différent. *)
  
%{
  (* Fonction d'initialisation des variables *)
  let init_variables () =
    Array.fill variables 0 26 0
%}
 *)