chapter {* Generated by Lem from elf_relocation.lem. *}

theory "Elf_relocation" 

imports 
 	 Main
	 "/home/dpm/Work/Programming/Cambridge/bitbucket/lem/isabelle-lib/Lem_num" 
	 "/home/dpm/Work/Programming/Cambridge/bitbucket/lem/isabelle-lib/Lem_list" 
	 "/home/dpm/Work/Programming/Cambridge/bitbucket/lem/isabelle-lib/Lem_set" 
	 "/home/dpm/Work/Programming/Cambridge/bitbucket/lem/isabelle-lib/Lem_basic_classes" 
	 "/home/dpm/Work/Programming/Cambridge/bitbucket/lem/isabelle-lib/Lem_string" 
	 "Show" 
	 "Missing_pervasives" 
	 "Error" 
	 "Byte_sequence" 
	 "Endianness" 
	 "Elf_types_native_uint" 

begin 

(** [elf_relocation] formalises types, functions and other definitions for working
  * with ELF relocation and relocation with addend entries.
  *
  * TODO:
  *     * Formalise the ELF32_R_INFO and ELF64_R_INFO macros.
  *)

(*open import Basic_classes*)
(*open import Num*)
(*open import List*)
(*import Set*)

(*open import Endianness*)
(*open import Byte_sequence*)
(*open import Error*)

(*open import String*)
(*open import Show*)
(*open import Missing_pervasives*)

(*open import Elf_types_native_uint*)

(** ELF relocation records *)

record elf32_relocation =
  
 elf32_r_offset ::" uint32 " (** Address at which to relocate *)
   
 elf32_r_info   ::" uint32 " (** Symbol table index/type of relocation to apply *)
   


record elf32_relocation_a =
  
 elf32_ra_offset ::" uint32 "  (** Address at which to relocate *)
   
 elf32_ra_info   ::" uint32 "  (** Symbol table index/type of relocation to apply *)
   
 elf32_ra_addend ::" sint32 " (** Addend used to compute value to be stored *)
   


record elf64_relocation =
  
 elf64_r_offset ::" Elf_Types_Local.uint64 "  (** Address at which to relocate *)
   
 elf64_r_info   ::" uint64 " (** Symbol table index/type of relocation to apply *)
   


record elf64_relocation_a =
  
 elf64_ra_offset ::" Elf_Types_Local.uint64 "   (** Address at which to relocate *)
   
 elf64_ra_info   ::" uint64 "  (** Symbol table index/type of relocation to apply *)
   
 elf64_ra_addend ::" sint64 " (** Addend used to compute value to be stored *)
   


(* We exclusively use elf64_relocation_a in range tags, regardless of what file/reloc 
 * the info came from, so only this one needs an Ord instance. *)
definition elf64_relocation_a_compare  :: " elf64_relocation_a \<Rightarrow> elf64_relocation_a \<Rightarrow> ordering "  where 
     " elf64_relocation_a_compare ent1 ent2 = (    
 (tripleCompare (genericCompare (op<) (op=)) (genericCompare (op<) (op=)) (genericCompare (op<) (op=)) (unat(elf64_ra_offset   ent1), unat(elf64_ra_info   ent1),
        sint(elf64_ra_addend   ent1)) 
        (unat(elf64_ra_offset   ent2), unat(elf64_ra_info   ent2),
        sint(elf64_ra_addend   ent2))))"


definition instance_Basic_classes_Ord_Elf_relocation_elf64_relocation_a_dict  :: "(elf64_relocation_a)Ord_class "  where 
     " instance_Basic_classes_Ord_Elf_relocation_elf64_relocation_a_dict = ((|

  compare_method = elf64_relocation_a_compare,

  isLess_method = (\<lambda> f1 .  (\<lambda> f2 .  (elf64_relocation_a_compare f1 f2 = LT))),

  isLessEqual_method = (\<lambda> f1 .  (\<lambda> f2 .  (op \<in>) (elf64_relocation_a_compare f1 f2) ({LT, EQ}))),

  isGreater_method = (\<lambda> f1 .  (\<lambda> f2 .  (elf64_relocation_a_compare f1 f2 = GT))),

  isGreaterEqual_method = (\<lambda> f1 .  (\<lambda> f2 .  (op \<in>) (elf64_relocation_a_compare f1 f2) ({GT, EQ})))|) )"
   

(** Extracting useful information *)

(** [elf32_relocation_r_sym w] computes the symbol table index associated with
  * an ELF32 relocation(a) entry.
  * [w] here is the [r_info] member of the [elf32_relocation(a)] type.
  *)
(*val elf32_relocation_r_sym : elf32_word -> natural*)
definition elf32_relocation_r_sym  :: " uint32 \<Rightarrow> nat "  where 
     " elf32_relocation_r_sym w = (
  unat (Elf_Types_Local.uint32_rshift w(( 8 :: nat))))"


(** [elf64_relocation_r_sym w] computes the symbol table index associated with
  * an ELF64 relocation(a) entry.
  * [w] here is the [r_info] member of the [elf64_relocation(a)] type.
  *)
(*val elf64_relocation_r_sym : elf64_xword -> natural*)
definition elf64_relocation_r_sym  :: " uint64 \<Rightarrow> nat "  where 
     " elf64_relocation_r_sym w = (
  unat (Elf_Types_Local.uint64_rshift w(( 32 :: nat))))"


(** [elf32_relocation_r_type w] computes the symbol type associated with an ELF32
  * relocation(a) entry.
  * [w] here is the [r_info] member of the [elf32_relocation(a)] type.
  *)
(*val elf32_relocation_r_type : elf32_word -> natural*)
definition elf32_relocation_r_type  :: " uint32 \<Rightarrow> nat "  where 
     " elf32_relocation_r_type w = (
  (unat w) mod( 256 :: nat))"


(** [elf64_relocation_r_type w] computes the symbol type associated with an ELF64
  * relocation(a) entry.
  * [w] here is the [r_info] member of the [elf64_relocation(a)] type.
  *)
(*val elf64_relocation_r_type : elf64_xword -> natural*)
definition elf64_relocation_r_type  :: " uint64 \<Rightarrow> nat "  where 
     " elf64_relocation_r_type w = (
  (let magic = ((( 65536 :: nat) *( 65536 :: nat)) -( 1 :: nat)) in (* 0xffffffffL *)
    unat (Elf_Types_Local.uint64_land w (of_int (int magic)))))"

    
(** Reading relocation entries *)
    
(** [read_elf32_relocation ed bs0] parses an [elf32_relocation] record from
  * byte sequence [bs0] assuming endianness [ed].  The suffix of [bs0] remaining
  * after parsing is also returned.
  * Fails if the relocation record cannot be parsed.
  *)
(*val read_elf32_relocation : endianness -> byte_sequence ->
  error (elf32_relocation * byte_sequence)*)
definition read_elf32_relocation  :: " endianness \<Rightarrow> byte_sequence \<Rightarrow>(elf32_relocation*byte_sequence)error "  where 
     " read_elf32_relocation endian bs = (
  read_elf32_addr endian bs >>= (\<lambda> (r_offset, bs) . 
  read_elf32_word endian bs >>= (\<lambda> (r_info, bs) . 
  error_return ((| elf32_r_offset = r_offset, elf32_r_info = r_info |), bs))))"

    
(** [read_elf64_relocation ed bs0] parses an [elf64_relocation] record from
  * byte sequence [bs0] assuming endianness [ed].  The suffix of [bs0] remaining
  * after parsing is also returned.
  * Fails if the relocation record cannot be parsed.
  *)
(*val read_elf64_relocation : endianness -> byte_sequence ->
  error (elf64_relocation * byte_sequence)*)
definition read_elf64_relocation  :: " endianness \<Rightarrow> byte_sequence \<Rightarrow>(elf64_relocation*byte_sequence)error "  where 
     " read_elf64_relocation endian bs = (
  read_elf64_addr endian bs  >>= (\<lambda> (r_offset, bs) . 
  read_elf64_xword endian bs >>= (\<lambda> (r_info, bs) . 
  error_return ((| elf64_r_offset = r_offset, elf64_r_info = r_info |), bs))))"


(** [read_elf32_relocation_a ed bs0] parses an [elf32_relocation_a] record from
  * byte sequence [bs0] assuming endianness [ed].  The suffix of [bs0] remaining
  * after parsing is also returned.
  * Fails if the relocation record cannot be parsed.
  *)
(*val read_elf32_relocation_a : endianness -> byte_sequence ->
  error (elf32_relocation_a * byte_sequence)*)
definition read_elf32_relocation_a  :: " endianness \<Rightarrow> byte_sequence \<Rightarrow>(elf32_relocation_a*byte_sequence)error "  where 
     " read_elf32_relocation_a endian bs = (
  read_elf32_addr endian bs  >>= (\<lambda> (r_offset, bs) . 
  read_elf32_word endian bs  >>= (\<lambda> (r_info, bs) . 
  read_elf32_sword endian bs >>= (\<lambda> (r_addend, bs) . 
  error_return ((| elf32_ra_offset = r_offset, elf32_ra_info = r_info,
    elf32_ra_addend = r_addend |), bs)))))"


(** [read_elf64_relocation_a ed bs0] parses an [elf64_relocation_a] record from
  * byte sequence [bs0] assuming endianness [ed].  The suffix of [bs0] remaining
  * after parsing is also returned.
  * Fails if the relocation record cannot be parsed.
  *)
(*val read_elf64_relocation_a : endianness -> byte_sequence -> error (elf64_relocation_a * byte_sequence)*)
definition read_elf64_relocation_a  :: " endianness \<Rightarrow> byte_sequence \<Rightarrow>(elf64_relocation_a*byte_sequence)error "  where 
     " read_elf64_relocation_a endian bs = (
  read_elf64_addr endian bs   >>= (\<lambda> (r_offset, bs) . 
  read_elf64_xword endian bs  >>= (\<lambda> (r_info, bs) . 
  read_elf64_sxword endian bs >>= (\<lambda> (r_addend, bs) . 
  error_return ((| elf64_ra_offset = r_offset, elf64_ra_info = r_info,
    elf64_ra_addend = r_addend |), bs)))))"


(** [read_elf32_relocation_section' ed bs0] parses a list of [elf32_relocation]
  * records from byte sequence [bs0], which is assumed to have the exact size
  * required, assuming endianness [ed].
  * Fails if any of the records cannot be parsed.
  *)
(*val read_elf32_relocation_section' : endianness -> byte_sequence ->
  error (list elf32_relocation)*)
function (sequential,domintros)  read_elf32_relocation_section'  :: " endianness \<Rightarrow> byte_sequence \<Rightarrow>((elf32_relocation)list)error "  where 
     " read_elf32_relocation_section' endian bs0 = (
  if Byte_sequence.length0 bs0 =( 0 :: nat) then
    error_return []
  else
    read_elf32_relocation endian bs0 >>= (\<lambda> (entry, bs1) . 
    read_elf32_relocation_section' endian bs1 >>= (\<lambda> tail . 
    error_return (entry # tail))))" 
by pat_completeness auto


(** [read_elf64_relocation_section' ed bs0] parses a list of [elf64_relocation]
  * records from byte sequence [bs0], which is assumed to have the exact size
  * required, assuming endianness [ed].
  * Fails if any of the records cannot be parsed.
  *)
(*val read_elf64_relocation_section' : endianness -> byte_sequence ->
  error (list elf64_relocation)*)
function (sequential,domintros)  read_elf64_relocation_section'  :: " endianness \<Rightarrow> byte_sequence \<Rightarrow>((elf64_relocation)list)error "  where 
     " read_elf64_relocation_section' endian bs0 = (
  if Byte_sequence.length0 bs0 =( 0 :: nat) then
    error_return []
  else
    read_elf64_relocation endian bs0 >>= (\<lambda> (entry, bs1) . 
    read_elf64_relocation_section' endian bs1 >>= (\<lambda> tail . 
    error_return (entry # tail))))" 
by pat_completeness auto

    
(** [read_elf32_relocation_a_section' ed bs0] parses a list of [elf32_relocation_a]
  * records from byte sequence [bs0], which is assumed to have the exact size
  * required, assuming endianness [ed].
  * Fails if any of the records cannot be parsed.
  *)
(*val read_elf32_relocation_a_section' : endianness -> byte_sequence ->
  error (list elf32_relocation_a)*)
function (sequential,domintros)  read_elf32_relocation_a_section'  :: " endianness \<Rightarrow> byte_sequence \<Rightarrow>((elf32_relocation_a)list)error "  where 
     " read_elf32_relocation_a_section' endian bs0 = (
  if Byte_sequence.length0 bs0 =( 0 :: nat) then
    error_return []
  else
    read_elf32_relocation_a endian bs0 >>= (\<lambda> (entry, bs1) . 
    read_elf32_relocation_a_section' endian bs1 >>= (\<lambda> tail . 
    error_return (entry # tail))))" 
by pat_completeness auto

    
(** [read_elf64_relocation_a_section' ed bs0] parses a list of [elf64_relocation_a]
  * records from byte sequence [bs0], which is assumed to have the exact size
  * required, assuming endianness [ed].
  * Fails if any of the records cannot be parsed.
  *)
(*val read_elf64_relocation_a_section' : endianness -> byte_sequence ->
  error (list elf64_relocation_a)*)
function (sequential,domintros)  read_elf64_relocation_a_section'  :: " endianness \<Rightarrow> byte_sequence \<Rightarrow>((elf64_relocation_a)list)error "  where 
     " read_elf64_relocation_a_section' endian bs0 = (
  if Byte_sequence.length0 bs0 =( 0 :: nat) then
    error_return []
  else
    read_elf64_relocation_a endian bs0 >>= (\<lambda> (entry, bs1) . 
    read_elf64_relocation_a_section' endian bs1 >>= (\<lambda> tail . 
    error_return (entry # tail))))" 
by pat_completeness auto

    
(** [read_elf32_relocation_section sz ed bs0] reads in a list of [elf32_relocation]
  * records from a prefix of [bs0] of size [sz] assuming endianness [ed].  The
  * suffix of [bs0] remaining after parsing is also returned.
  * Fails if any of the records cannot be parsed or if the length of [bs0] is
  * less than [sz].
  *)
(*val read_elf32_relocation_section : natural -> endianness -> byte_sequence
  -> error (list elf32_relocation * byte_sequence)*)
definition read_elf32_relocation_section  :: " nat \<Rightarrow> endianness \<Rightarrow> byte_sequence \<Rightarrow>((elf32_relocation)list*byte_sequence)error "  where 
     " read_elf32_relocation_section table_size endian bs0 = (
  partition0 table_size bs0 >>= (\<lambda> (eat, rest) . 
  read_elf32_relocation_section' endian eat >>= (\<lambda> entries . 
  error_return (entries, rest))))"


(** [read_elf64_relocation_section sz ed bs0] reads in a list of [elf64_relocation]
  * records from a prefix of [bs0] of size [sz] assuming endianness [ed].  The
  * suffix of [bs0] remaining after parsing is also returned.
  * Fails if any of the records cannot be parsed or if the length of [bs0] is
  * less than [sz].
  *)
(*val read_elf64_relocation_section : natural -> endianness -> byte_sequence
  -> error (list elf64_relocation * byte_sequence)*)
definition read_elf64_relocation_section  :: " nat \<Rightarrow> endianness \<Rightarrow> byte_sequence \<Rightarrow>((elf64_relocation)list*byte_sequence)error "  where 
     " read_elf64_relocation_section table_size endian bs0 = (
  partition0 table_size bs0 >>= (\<lambda> (eat, rest) . 
  read_elf64_relocation_section' endian eat >>= (\<lambda> entries . 
  error_return (entries, rest))))"


(** [read_elf32_relocation_a_section sz ed bs0] reads in a list of [elf32_relocation_a]
  * records from a prefix of [bs0] of size [sz] assuming endianness [ed].  The
  * suffix of [bs0] remaining after parsing is also returned.
  * Fails if any of the records cannot be parsed or if the length of [bs0] is
  * less than [sz].
  *)
(*val read_elf32_relocation_a_section : natural -> endianness -> byte_sequence ->
  error (list elf32_relocation_a * byte_sequence)*)
definition read_elf32_relocation_a_section  :: " nat \<Rightarrow> endianness \<Rightarrow> byte_sequence \<Rightarrow>((elf32_relocation_a)list*byte_sequence)error "  where 
     " read_elf32_relocation_a_section table_size endian bs0 = (
  partition0 table_size bs0 >>= (\<lambda> (eat, rest) . 
  read_elf32_relocation_a_section' endian eat >>= (\<lambda> entries . 
  error_return (entries, rest))))"


(** [read_elf64_relocation_a_section sz ed bs0] reads in a list of [elf64_relocation_a]
  * records from a prefix of [bs0] of size [sz] assuming endianness [ed].  The
  * suffix of [bs0] remaining after parsing is also returned.
  * Fails if any of the records cannot be parsed or if the length of [bs0] is
  * less than [sz].
  *)
(*val read_elf64_relocation_a_section : natural -> endianness -> byte_sequence ->
  error (list elf64_relocation_a * byte_sequence)*)
definition read_elf64_relocation_a_section  :: " nat \<Rightarrow> endianness \<Rightarrow> byte_sequence \<Rightarrow>((elf64_relocation_a)list*byte_sequence)error "  where 
     " read_elf64_relocation_a_section table_size endian bs0 = (
  partition0 table_size bs0 >>= (\<lambda> (eat, rest) . 
  read_elf64_relocation_a_section' endian eat >>= (\<lambda> entries . 
  error_return (entries, rest))))"

end
