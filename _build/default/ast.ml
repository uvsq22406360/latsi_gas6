(* ast.ml *)

type operateur =
  | Plus
  | Moins
  | Mult
  | Div
  | Inf
  | Inf_ou_egal
  | Sup
  | Sup_ou_egal
  | Egal
  | Diff


  type variable = A | B | C | D | E | F | G | H | I | J | K | L | M | N | O | P | Q | R | S | T | U | V | W | X | Y | Z

type expression =
  | Var of variable
  | Num of int
  | String of string
  | Plus of expression * expression
  | Moins of expression * expression
  | Mult of expression * expression
  | Div of expression * expression


type facteur =
  | Variable of string
  | Nombre of int
  | ExprParenth of expression

type instruction =
  | Imprime of expression list
  | Si of expression * operateur * expression * instruction
  | Vavers of expression
  | Entree of string list
  | Affectation of string * expression
  | Fin
  | Rem of string
  | Nl

type ligne = {
  numero_ligne: int;
  instruction: instruction;
}


let init_variables () =
  let variables = Hashtbl.create 26 in
let rec init_loop var =
  match var with
  | A -> Hashtbl.add variables A 0; init_loop B
  | B -> Hashtbl.add variables B 0; init_loop C
  | C -> Hashtbl.add variables C 0; init_loop D
  | D -> Hashtbl.add variables D 0; init_loop E
  | E -> Hashtbl.add variables E 0; init_loop F
  | F -> Hashtbl.add variables F 0; init_loop G
  | G -> Hashtbl.add variables G 0; init_loop H
  | H -> Hashtbl.add variables H 0; init_loop I
  | I -> Hashtbl.add variables I 0; init_loop J
  | J -> Hashtbl.add variables J 0; init_loop K
  | K -> Hashtbl.add variables K 0; init_loop L
  | L -> Hashtbl.add variables L 0; init_loop M
  | M -> Hashtbl.add variables M 0; init_loop N
  | N -> Hashtbl.add variables N 0; init_loop O
  | O -> Hashtbl.add variables O 0; init_loop P
  | P -> Hashtbl.add variables P 0; init_loop Q
  | Q -> Hashtbl.add variables Q 0; init_loop R
  | R -> Hashtbl.add variables R 0; init_loop S
  | S -> Hashtbl.add variables S 0; init_loop T
  | T -> Hashtbl.add variables T 0; init_loop U
  | U -> Hashtbl.add variables U 0; init_loop V
  | V -> Hashtbl.add variables V 0; init_loop W
  | W -> Hashtbl.add variables W 0; init_loop X
  | X -> Hashtbl.add variables X 0; init_loop Y
  | Y -> Hashtbl.add variables Y 0; init_loop Z
  | Z -> Hashtbl.add variables Z 0
in
init_loop A;
variables



type programme = ligne list



