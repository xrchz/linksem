(*Generated by Lem from abis/amd64/abi_amd64_program_header_table.lem.*)
open HolKernel Parse boolLib bossLib;
open lem_numTheory lem_basic_classesTheory lem_boolTheory lem_stringTheory;

val _ = numLib.prefer_num();



val _ = new_theory "abi_amd64_program_header_table"

(** [abi_amd64_program_header_table], program header table specific definitions
  * for the AMD64 ABI.
  *)

(*open import Basic_classes*)
(*open import Bool*)
(*open import Num*)
(*open import String*)

(** New segment types. *)

(** The segment contains the stack unwind tables *)
val _ = Define `
 (abi_amd64_pt_gnu_eh_frame  : num= (I 2 *I 842691240))`;
 (* 0x6474e550 *)
val _ = Define `
 (abi_amd64_pt_sunw_eh_frame : num= (I 2 *I 842691240))`;
 (* 0x6474e550 *)
val _ = Define `
 (abi_amd64_pt_sunw_unwind   : num= (I 2 *I 842691240))`;
 (* 0x6474e550 *)

(** [string_of_abi_amd64_elf_segment_type m] produces a string based representation
  * of AMD64 segment type [m].
  *)
(*val string_of_abi_amd64_elf_segment_type : natural -> string*)
val _ = Define `
 (string_of_abi_amd64_elf_segment_type m=  
 (if m = abi_amd64_pt_gnu_eh_frame then
    "GNU_EH_FRAME"
  else if m = abi_amd64_pt_sunw_eh_frame then
    "SUNW_EH_FRAME"
  else if  m = abi_amd64_pt_sunw_unwind then
    "SUNW_UNWIND"
  else
    "Invalid AMD64 segment type"))`;

    
(** [abi_amd64_is_valid_program_interpreter s] checks whether the program interpreter
  * string is valid for AMD64 ABI.
  * See Section 5.2.1
  *)
(*val abi_amd64_is_valid_program_interpreter : string -> bool*)
val _ = Define `
 (abi_amd64_is_valid_program_interpreter s=
   ((s = "/lib/ld64.so.1") \/ (s = "/lib64/ld-linux-x86-64.so.2")))`;

val _ = export_theory()

