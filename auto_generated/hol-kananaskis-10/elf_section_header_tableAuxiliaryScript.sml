(*Generated by Lem from elf_section_header_table.lem.*)
open HolKernel Parse boolLib bossLib;
open lem_numTheory lem_listTheory lem_functionTheory lem_basic_classesTheory lem_boolTheory lem_maybeTheory lem_stringTheory showTheory missing_pervasivesTheory errorTheory byte_sequenceTheory endiannessTheory elf_types_native_uintTheory elf_headerTheory string_tableTheory lem_mapTheory elf_program_header_tableTheory elf_section_header_tableTheory;

val _ = numLib.prefer_num();



open lemLib;
(* val _ = lemLib.run_interactive := true; *)
val _ = new_theory "elf_section_header_tableAuxiliary"


(****************************************************)
(*                                                  *)
(* Termination Proofs                               *)
(*                                                  *)
(****************************************************)

(* val gst = Defn.tgoal_no_defn (read_elf32_section_header_table'_def, read_elf32_section_header_table'_ind) *)
val (read_elf32_section_header_table'_rw, read_elf32_section_header_table'_ind_rw) =
  Defn.tprove_no_defn ((read_elf32_section_header_table'_def, read_elf32_section_header_table'_ind),
    (* the termination proof *)
  )
val read_elf32_section_header_table'_rw = save_thm ("read_elf32_section_header_table'_rw", read_elf32_section_header_table'_rw);
val read_elf32_section_header_table'_ind_rw = save_thm ("read_elf32_section_header_table'_ind_rw", read_elf32_section_header_table'_ind_rw);


(* val gst = Defn.tgoal_no_defn (read_elf64_section_header_table'_def, read_elf64_section_header_table'_ind) *)
val (read_elf64_section_header_table'_rw, read_elf64_section_header_table'_ind_rw) =
  Defn.tprove_no_defn ((read_elf64_section_header_table'_def, read_elf64_section_header_table'_ind),
    (* the termination proof *)
  )
val read_elf64_section_header_table'_rw = save_thm ("read_elf64_section_header_table'_rw", read_elf64_section_header_table'_rw);
val read_elf64_section_header_table'_ind_rw = save_thm ("read_elf64_section_header_table'_ind_rw", read_elf64_section_header_table'_ind_rw);


(* val gst = Defn.tgoal_no_defn (get_elf32_section_to_segment_mapping_def, get_elf32_section_to_segment_mapping_ind) *)
val (get_elf32_section_to_segment_mapping_rw, get_elf32_section_to_segment_mapping_ind_rw) =
  Defn.tprove_no_defn ((get_elf32_section_to_segment_mapping_def, get_elf32_section_to_segment_mapping_ind),
    (* the termination proof *)
  )
val get_elf32_section_to_segment_mapping_rw = save_thm ("get_elf32_section_to_segment_mapping_rw", get_elf32_section_to_segment_mapping_rw);
val get_elf32_section_to_segment_mapping_ind_rw = save_thm ("get_elf32_section_to_segment_mapping_ind_rw", get_elf32_section_to_segment_mapping_ind_rw);


(* val gst = Defn.tgoal_no_defn (get_elf64_section_to_segment_mapping_def, get_elf64_section_to_segment_mapping_ind) *)
val (get_elf64_section_to_segment_mapping_rw, get_elf64_section_to_segment_mapping_ind_rw) =
  Defn.tprove_no_defn ((get_elf64_section_to_segment_mapping_def, get_elf64_section_to_segment_mapping_ind),
    (* the termination proof *)
  )
val get_elf64_section_to_segment_mapping_rw = save_thm ("get_elf64_section_to_segment_mapping_rw", get_elf64_section_to_segment_mapping_rw);
val get_elf64_section_to_segment_mapping_ind_rw = save_thm ("get_elf64_section_to_segment_mapping_ind_rw", get_elf64_section_to_segment_mapping_ind_rw);




val _ = export_theory()

