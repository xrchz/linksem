(*Generated by Lem from memory_image.lem.*)
open HolKernel Parse boolLib bossLib;
open lem_numTheory lem_listTheory lem_setTheory lem_functionTheory lem_basic_classesTheory lem_boolTheory lem_maybeTheory lem_stringTheory lem_assert_extraTheory showTheory lem_sortingTheory lem_set_extraTheory missing_pervasivesTheory byte_sequenceTheory elf_types_native_uintTheory lem_tupleTheory elf_headerTheory lem_mapTheory elf_program_header_tableTheory elf_section_header_tableTheory elf_interpreted_sectionTheory elf_interpreted_segmentTheory elf_symbol_tableTheory elf_fileTheory elf_relocationTheory multimapTheory memory_imageTheory;

val _ = numLib.prefer_num();



open lemLib;
(* val _ = lemLib.run_interactive := true; *)
val _ = new_theory "memory_imageAuxiliary"


(****************************************************)
(*                                                  *)
(* Termination Proofs                               *)
(*                                                  *)
(****************************************************)

(* val gst = Defn.tgoal_no_defn (nat_range_def, nat_range_ind) *)
val (nat_range_rw, nat_range_ind_rw) =
  Defn.tprove_no_defn ((nat_range_def, nat_range_ind),
    cheat
  )
val nat_range_rw = save_thm ("nat_range_rw", nat_range_rw);
val nat_range_ind_rw = save_thm ("nat_range_ind_rw", nat_range_ind_rw);


(* val gst = Defn.tgoal_no_defn (expand_sorted_ranges_def, expand_sorted_ranges_ind) *)
val (expand_sorted_ranges_rw, expand_sorted_ranges_ind_rw) =
  Defn.tprove_no_defn ((expand_sorted_ranges_def, expand_sorted_ranges_ind),
    cheat
  )
val expand_sorted_ranges_rw = save_thm ("expand_sorted_ranges_rw", expand_sorted_ranges_rw);
val expand_sorted_ranges_ind_rw = save_thm ("expand_sorted_ranges_ind_rw", expand_sorted_ranges_ind_rw);


(* val gst = Defn.tgoal_no_defn (make_byte_pattern_revacc_def, make_byte_pattern_revacc_ind) *)
val (make_byte_pattern_revacc_rw, make_byte_pattern_revacc_ind_rw) =
  Defn.tprove_no_defn ((make_byte_pattern_revacc_def, make_byte_pattern_revacc_ind),
    cheat
  )
val make_byte_pattern_revacc_rw = save_thm ("make_byte_pattern_revacc_rw", make_byte_pattern_revacc_rw);
val make_byte_pattern_revacc_ind_rw = save_thm ("make_byte_pattern_revacc_ind_rw", make_byte_pattern_revacc_ind_rw);


(* val gst = Defn.tgoal_no_defn (relax_byte_pattern_revacc_def, relax_byte_pattern_revacc_ind) *)
val (relax_byte_pattern_revacc_rw, relax_byte_pattern_revacc_ind_rw) =
  Defn.tprove_no_defn ((relax_byte_pattern_revacc_def, relax_byte_pattern_revacc_ind),
    cheat
  )
val relax_byte_pattern_revacc_rw = save_thm ("relax_byte_pattern_revacc_rw", relax_byte_pattern_revacc_rw);
val relax_byte_pattern_revacc_ind_rw = save_thm ("relax_byte_pattern_revacc_ind_rw", relax_byte_pattern_revacc_ind_rw);


(* val gst = Defn.tgoal_no_defn (byte_list_matches_pattern_def, byte_list_matches_pattern_ind) *)
val (byte_list_matches_pattern_rw, byte_list_matches_pattern_ind_rw) =
  Defn.tprove_no_defn ((byte_list_matches_pattern_def, byte_list_matches_pattern_ind),
    cheat
  )
val byte_list_matches_pattern_rw = save_thm ("byte_list_matches_pattern_rw", byte_list_matches_pattern_rw);
val byte_list_matches_pattern_ind_rw = save_thm ("byte_list_matches_pattern_ind_rw", byte_list_matches_pattern_ind_rw);


(* val gst = Defn.tgoal_no_defn (accum_pattern_possible_starts_in_one_byte_sequence_def, accum_pattern_possible_starts_in_one_byte_sequence_ind) *)
val (accum_pattern_possible_starts_in_one_byte_sequence_rw, accum_pattern_possible_starts_in_one_byte_sequence_ind_rw) =
  Defn.tprove_no_defn ((accum_pattern_possible_starts_in_one_byte_sequence_def, accum_pattern_possible_starts_in_one_byte_sequence_ind),
    cheat
  )
val accum_pattern_possible_starts_in_one_byte_sequence_rw = save_thm ("accum_pattern_possible_starts_in_one_byte_sequence_rw", accum_pattern_possible_starts_in_one_byte_sequence_rw);
val accum_pattern_possible_starts_in_one_byte_sequence_ind_rw = save_thm ("accum_pattern_possible_starts_in_one_byte_sequence_ind_rw", accum_pattern_possible_starts_in_one_byte_sequence_ind_rw);




val _ = export_theory()
