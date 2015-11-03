(*Generated by Lem from byte_sequence.lem.*)
open HolKernel Parse boolLib bossLib;
open lem_numTheory lem_listTheory lem_basic_classesTheory lem_boolTheory lem_stringTheory lem_assert_extraTheory showTheory missing_pervasivesTheory errorTheory byte_sequenceTheory;

val _ = numLib.prefer_num();



open lemLib;
(* val _ = lemLib.run_interactive := true; *)
val _ = new_theory "byte_sequenceAuxiliary"


(****************************************************)
(*                                                  *)
(* Termination Proofs                               *)
(*                                                  *)
(****************************************************)

(* val gst = Defn.tgoal_no_defn (repeat_def, repeat_ind) *)
val (repeat_rw, repeat_ind_rw) =
  Defn.tprove_no_defn ((repeat_def, repeat_ind),
    cheat
  )
val repeat_rw = save_thm ("repeat_rw", repeat_rw);
val repeat_ind_rw = save_thm ("repeat_ind_rw", repeat_ind_rw);


(* val gst = Defn.tgoal_no_defn (concat0_def, concat0_ind) *)
val (concat0_rw, concat0_ind_rw) =
  Defn.tprove_no_defn ((concat0_def, concat0_ind),
    cheat
  )
val concat0_rw = save_thm ("concat0_rw", concat0_rw);
val concat0_ind_rw = save_thm ("concat0_ind_rw", concat0_ind_rw);


(* val gst = Defn.tgoal_no_defn (equal_def, equal_ind) *)
val (equal_rw, equal_ind_rw) =
  Defn.tprove_no_defn ((equal_def, equal_ind),
    cheat
  )
val equal_rw = save_thm ("equal_rw", equal_rw);
val equal_ind_rw = save_thm ("equal_ind_rw", equal_ind_rw);


(* val gst = Defn.tgoal_no_defn (dropbytes_def, dropbytes_ind) *)
val (dropbytes_rw, dropbytes_ind_rw) =
  Defn.tprove_no_defn ((dropbytes_def, dropbytes_ind),
    cheat
  )
val dropbytes_rw = save_thm ("dropbytes_rw", dropbytes_rw);
val dropbytes_ind_rw = save_thm ("dropbytes_ind_rw", dropbytes_ind_rw);




val _ = export_theory()

