(*Generated by Lem from default_printing.lem.*)
open HolKernel Parse boolLib bossLib stringTheory;
open lem_functionTheory;

val _ = numLib.prefer_num();



val _ = new_theory "default_printing"

(** [default_printing] module is a small utility module providing default
  * printing functions for when ABI-specific functions are not available.
  * These functions were constantly being redefined and reused all over the
  * place hence their placement in this module.
  *)
(*open import Function*)

(** [default_os_specific_print] is a default print function for OS specific
  * functionality.
  *)
(*val default_os_specific_print : forall 'a. 'a -> string*)
val _ = Define `
 (default_os_specific_print= 
  (K "*Default OS specific print*"))`;


(** [default_proc_specific_print] is a default print function for processor specific
  * functionality.
  *)
(*val default_proc_specific_print : forall 'a. 'a -> string*)
val _ = Define `
 (default_proc_specific_print= 
  (K "*Default processor specific print*"))`;


(** [default_user_specific_print] is a default print function for user specific
  * functionality.
  *)
(*val default_user_specific_print : forall 'a. 'a -> string*)
val _ = Define `
 (default_user_specific_print= 
  (K "*Default user specific print*"))`;

val _ = export_theory()

