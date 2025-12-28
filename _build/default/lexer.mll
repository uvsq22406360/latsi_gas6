(* lexer.mll *)

{
  open Parser
}

let layout = [' ' '\t']
let chiffre = ['0'-'9']
let lettre = ['A'-'Z' 'a'-'z']
let variable = ['A'-'Z']
let guillemet = '\"' 
let interieur_string = [' ' ',' ';' ':' '.' '\'' '_' 'A'-'Z' 'a'-'z' '0'-'9'] 


rule main = parse
  | layout  { token lexbuf } 
  | lettre+ as var                  { VAR (String.get (Lexing.lexeme lexbuf) 0) }
  | chiffre+ as num                   { NUMBER (int_of_string (Lexing.lexeme lexbuf)) }
  | guillemet interieur_string* guillemet { STRING (Lexing.lexeme lexbuf) }
  | ","         { VERGULE }
  | "IMPRIME"   { IMPRIME  }
  | "SI"        { SI  }
  | "ALORS"     { ALORS  }
  | "VAVERS"    { VAVERS }
  | "ENTREE"    { ENTREE }
  | "FIN"       { FIN  }
  | "REM"       { REM }
  | "NL"        { NL }
  | '\n'    {  NL }
  | "="     { EGAL }
  | "+"     { PLUS  }
  | "-"     { MOINS }
  | "*"     { MULT }
  | "/"     { DIV  }
  | "<"     { INF }
  | "<="    {  INF_OU_EGAL }
  | ">"     { SUP }
  | ">="    { SUP_OU_EGAL }
  | "=="    { EGALITE }
  | "<>"    { DIFF  }
  | "><"    { DIFF  }
  | "("     { LPAREN  }
  | ")"     { RPAREN  }
  | guillemet   { QUOTE  }
  | eof     { EOF  }
  | _       { raise (Error (Lexing.lexeme lexbuf)) }
