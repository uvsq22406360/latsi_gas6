open Ast

(* Déclaration des 26 variables prédéfinies *)
let variables = Array.make 26 0

(* Fonction pour l'évaluation d'une expression *)
let rec eval_expr = function
  | Var x -> variables.(Char.code x.[0] - Char.code 'A')
  | Num n -> n
  | Plus (e1, e2) -> eval_expr e1 + eval_expr e2
  | Moins (e1, e2) -> eval_expr e1 - eval_expr e2
  | Mult (e1, e2) -> eval_expr e1 * eval_expr e2
  | Div (e1, e2) -> eval_expr e1 / eval_expr e2

(* Fonction pour l'exécution d'une instruction *)
let rec execute_instruction = function
  | Imprime expr_list ->
      List.iter (fun expr -> print_string (string_of_int (eval_expr expr))) expr_list;
      print_newline ()
  | Si (e1, op, e2, instr) ->
      let eval_e1 = eval_expr e1 in
      let eval_e2 = eval_expr e2 in
      let result =
        match op with
        | Inf -> eval_e1 < eval_e2
        | Inf_ou_egal -> eval_e1 <= eval_e2
        | Sup -> eval_e1 > eval_e2
        | Sup_ou_egal -> eval_e1 >= eval_e2
        | Egal -> eval_e1 = eval_e2
        | Diff -> eval_e1 != eval_e2
      in
      if result then execute_instruction instr
  | Vavers e -> ()
  | Entree vars ->
      List.iter (fun var ->
        let idx = Char.code var.[0] - Char.code 'A' in
        print_string (var ^ " : ");
        variables.(idx) <- read_int ()
      ) vars
  | Affectation (var, expr) ->
      let idx = Char.code var.[0] - Char.code 'A' in
      variables.(idx) <- eval_expr expr
  | Fin -> exit 0
  | Rem _ -> ()
  | Nl -> ()

(* Fonction principale pour exécuter un programme *)
let execute_program programme =
  List.iter (fun ligne -> execute_instruction ligne.instruction) programme

(* Fonction principale pour exécuter un programme avec une gestion d'erreur *)
let run_program programme =
  try
    execute_program programme
  with
  | End_of_file -> exit 0
  | Failure msg -> print_endline ("Erreur: " ^ msg)
  | Invalid_argument _ -> print_endline "Erreur: Argument invalide"
  | Sys_error msg -> print_endline ("Erreur système: " ^ msg)

(* Fonction pour initialiser les variables *)
let init_variables () =
  Array.fill variables 0 26 0
