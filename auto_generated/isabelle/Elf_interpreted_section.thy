chapter {* Generated by Lem from elf_interpreted_section.lem. *}

theory "Elf_interpreted_section" 

imports 
 	 Main
	 "/home/dpm/Work/Programming/Cambridge/bitbucket/lem/isabelle-lib/Lem_num" 
	 "/home/dpm/Work/Programming/Cambridge/bitbucket/lem/isabelle-lib/Lem_list" 
	 "/home/dpm/Work/Programming/Cambridge/bitbucket/lem/isabelle-lib/Lem_basic_classes" 
	 "/home/dpm/Work/Programming/Cambridge/bitbucket/lem/isabelle-lib/Lem_bool" 
	 "/home/dpm/Work/Programming/Cambridge/bitbucket/lem/isabelle-lib/Lem_maybe" 
	 "/home/dpm/Work/Programming/Cambridge/bitbucket/lem/isabelle-lib/Lem_string" 
	 "Show" 
	 "Missing_pervasives" 
	 "Error" 
	 "Byte_sequence" 
	 "Elf_types_native_uint" 
	 "String_table" 
	 "Elf_section_header_table" 

begin 

(*open import Basic_classes*)
(*open import Bool*)
(*open import List*)
(*open import Maybe*)
(*open import Num*)
(*open import String*)

(*open import Byte_sequence*)
(*open import Error*)
(*open import String_table*)

(*open import Elf_types_native_uint*)
(*open import Elf_section_header_table*)

(*open import Missing_pervasives*)
(*open import Show*)

record elf32_interpreted_section =
  
 elf32_section_name    ::" nat "       (** Name of the section *)
   
 elf32_section_type    ::" nat "       (** Type of the section *)
   
 elf32_section_flags   ::" nat "       (** Flags associated with the section *)
   
 elf32_section_addr    ::" nat "       (** Base address of the section in memory *)
   
 elf32_section_offset  ::" nat "       (** Offset from beginning of file *)
   
 elf32_section_size    ::" nat "       (** Section size in bytes *)
   
 elf32_section_link    ::" nat "       (** Section header table index link *)
   
 elf32_section_info    ::" nat "       (** Extra information, depends on section type *)
   
 elf32_section_align   ::" nat "       (** Alignment constraints for section *)
   
 elf32_section_entsize ::" nat "       (** Size of each entry in table, if section is one *)
   
 elf32_section_body    ::" byte_sequence " (** Body of section *)
   
 elf32_section_name_as_string ::" string " (** Name of the section, as a string;  for no name (name = 0) *)
   

   
(*val elf32_interpreted_section_equal : elf32_interpreted_section -> elf32_interpreted_section -> bool*)
definition elf32_interpreted_section_equal  :: " elf32_interpreted_section \<Rightarrow> elf32_interpreted_section \<Rightarrow> bool "  where 
     " elf32_interpreted_section_equal x y = (    
((elf32_section_name   x) =(elf32_section_name   y)) \<and>
    (((elf32_section_type   x) =(elf32_section_type   y)) \<and>
    (((elf32_section_flags   x) =(elf32_section_flags   y)) \<and>
    (((elf32_section_addr   x) =(elf32_section_addr   y)) \<and>
    (((elf32_section_offset   x) =(elf32_section_offset   y)) \<and>
    (((elf32_section_size   x) =(elf32_section_size   y)) \<and>
    (((elf32_section_link   x) =(elf32_section_link   y)) \<and>
    (((elf32_section_info   x) =(elf32_section_info   y)) \<and>
    (((elf32_section_align   x) =(elf32_section_align   y)) \<and>
    (((elf32_section_entsize   x) =(elf32_section_entsize   y)) \<and>
    (((elf32_section_body   x) =(elf32_section_body   y)) \<and>    
((elf32_section_name_as_string   x) =(elf32_section_name_as_string   y)))))))))))))"


record elf64_interpreted_section =
  
 elf64_section_name    ::" nat "       (** Name of the section *)
   
 elf64_section_type    ::" nat "       (** Type of the section *)
   
 elf64_section_flags   ::" nat "       (** Flags associated with the section *)
   
 elf64_section_addr    ::" nat "       (** Base address of the section in memory *)
   
 elf64_section_offset  ::" nat "       (** Offset from beginning of file *)
   
 elf64_section_size    ::" nat "       (** Section size in bytes *)
   
 elf64_section_link    ::" nat "       (** Section header table index link *)
   
 elf64_section_info    ::" nat "       (** Extra information, depends on section type *)
   
 elf64_section_align   ::" nat "       (** Alignment constraints for section *)
   
 elf64_section_entsize ::" nat "       (** Size of each entry in table, if section is one *)
   
 elf64_section_body    ::" byte_sequence " (** Body of section *)
   
 elf64_section_name_as_string ::" string " (** Name of the section, as a string;  for no name (name = 0) *)
   

   
definition compare_elf64_interpreted_section  :: " elf64_interpreted_section \<Rightarrow> elf64_interpreted_section \<Rightarrow> ordering "  where 
     " compare_elf64_interpreted_section s1 s2 = (   
 (pairCompare (lexicographicCompareBy (genericCompare (op<) (op=))) compare_byte_sequence 
    ([(elf64_section_name   s1)    ,(elf64_section_type  
s1)    ,(elf64_section_flags  
s1)   ,(elf64_section_addr  
s1)    ,(elf64_section_offset  
s1)  ,(elf64_section_size  
s1)    ,(elf64_section_link  
s1)    ,(elf64_section_info  
s1)    ,(elf64_section_align  
s1)   ,(elf64_section_entsize  
s1)],(elf64_section_body   s1)) ([(elf64_section_name   s2)    ,(elf64_section_type  
s2)    ,(elf64_section_flags  
s2)   ,(elf64_section_addr  
s2)    ,(elf64_section_offset  
s2)  ,(elf64_section_size  
s2)    ,(elf64_section_link  
s2)    ,(elf64_section_info  
s2)    ,(elf64_section_align  
s2)   ,(elf64_section_entsize  
s2)],(elf64_section_body   s2))))"


definition instance_Basic_classes_Ord_Elf_interpreted_section_elf64_interpreted_section_dict  :: "(elf64_interpreted_section)Ord_class "  where 
     " instance_Basic_classes_Ord_Elf_interpreted_section_elf64_interpreted_section_dict = ((|

  compare_method = compare_elf64_interpreted_section,

  isLess_method = (\<lambda> f1 .  (\<lambda> f2 .  (compare_elf64_interpreted_section f1 f2 = LT))),

  isLessEqual_method = (\<lambda> f1 .  (\<lambda> f2 .  (op \<in>) (compare_elf64_interpreted_section f1 f2) ({LT, EQ}))),

  isGreater_method = (\<lambda> f1 .  (\<lambda> f2 .  (compare_elf64_interpreted_section f1 f2 = GT))),

  isGreaterEqual_method = (\<lambda> f1 .  (\<lambda> f2 .  (op \<in>) (compare_elf64_interpreted_section f1 f2) ({GT, EQ})))|) )"


   
(*val elf64_interpreted_section_equal : elf64_interpreted_section -> elf64_interpreted_section -> bool*)
definition elf64_interpreted_section_equal  :: " elf64_interpreted_section \<Rightarrow> elf64_interpreted_section \<Rightarrow> bool "  where 
     " elf64_interpreted_section_equal x y = (    
((elf64_section_name   x) =(elf64_section_name   y)) \<and>
    (((elf64_section_type   x) =(elf64_section_type   y)) \<and>
    (((elf64_section_flags   x) =(elf64_section_flags   y)) \<and>
    (((elf64_section_addr   x) =(elf64_section_addr   y)) \<and>
    (((elf64_section_offset   x) =(elf64_section_offset   y)) \<and>
    (((elf64_section_size   x) =(elf64_section_size   y)) \<and>
    (((elf64_section_link   x) =(elf64_section_link   y)) \<and>
    (((elf64_section_info   x) =(elf64_section_info   y)) \<and>
    (((elf64_section_align   x) =(elf64_section_align   y)) \<and>
    (((elf64_section_entsize   x) =(elf64_section_entsize   y)) \<and>
    (((elf64_section_body   x) =(elf64_section_body   y)) \<and>    
((elf64_section_name_as_string   x) =(elf64_section_name_as_string   y)))))))))))))"


(*val null_elf32_interpreted_section : elf32_interpreted_section*)
definition null_elf32_interpreted_section  :: " elf32_interpreted_section "  where 
     " null_elf32_interpreted_section = (
  (| elf32_section_name =(( 0 :: nat))
   , elf32_section_type =(( 0 :: nat))
   , elf32_section_flags =(( 0 :: nat))
   , elf32_section_addr =(( 0 :: nat))
   , elf32_section_offset =(( 0 :: nat))
   , elf32_section_size =(( 0 :: nat))
   , elf32_section_link =(( 0 :: nat))
   , elf32_section_info =(( 0 :: nat))
   , elf32_section_align =(( 0 :: nat))
   , elf32_section_entsize =(( 0 :: nat)) 
   , elf32_section_body = Byte_sequence.empty
   , elf32_section_name_as_string = ('''')
   |) )"


(*val null_elf64_interpreted_section : elf64_interpreted_section*)
definition null_elf64_interpreted_section  :: " elf64_interpreted_section "  where 
     " null_elf64_interpreted_section = (
  (| elf64_section_name =(( 0 :: nat))
   , elf64_section_type =(( 0 :: nat))
   , elf64_section_flags =(( 0 :: nat))
   , elf64_section_addr =(( 0 :: nat))
   , elf64_section_offset =(( 0 :: nat))
   , elf64_section_size =(( 0 :: nat))
   , elf64_section_link =(( 0 :: nat))
   , elf64_section_info =(( 0 :: nat))
   , elf64_section_align =(( 0 :: nat))
   , elf64_section_entsize =(( 0 :: nat)) 
   , elf64_section_body = Byte_sequence.empty
   , elf64_section_name_as_string = ('''')
   |) )"


(*val elf64_interpreted_section_matches_section_header : 
    elf64_interpreted_section
        -> elf64_section_header_table_entry
            -> bool*)
definition elf64_interpreted_section_matches_section_header  :: " elf64_interpreted_section \<Rightarrow> elf64_section_header_table_entry \<Rightarrow> bool "  where 
     " elf64_interpreted_section_matches_section_header i sh = (  
((elf64_section_name   i) = unat(elf64_sh_name   sh)) \<and>
  (((elf64_section_type   i) = unat(elf64_sh_type   sh)) \<and>
  (((elf64_section_flags   i) = unat(elf64_sh_flags   sh)) \<and>
  (((elf64_section_addr   i) = unat(elf64_sh_addr   sh)) \<and>
  (((elf64_section_offset   i) = unat(elf64_sh_offset   sh)) \<and>
  (((elf64_section_size   i) = unat(elf64_sh_size   sh)) \<and>
  (((elf64_section_link   i) = unat(elf64_sh_link   sh)) \<and>
  (((elf64_section_info   i) = unat(elf64_sh_info   sh)) \<and>
  (((elf64_section_align   i) = unat(elf64_sh_addralign   sh)) (* WHY? *) \<and>  
((elf64_section_entsize   i) = unat(elf64_sh_entsize   sh)))))))))))"

  (* Don't compare the name as a string, because it's implied by the shshtrtab index. *)
  (* NOTE that we can have multiple sections *indistinguishable*
   * except by their section header table index. Imagine 
   * multiple zero-size bss sections at the same address with the same name.
   * That's why in elf_memory_image we always label each ElfSection
   * with its SHT index.
   *)

type_synonym elf32_interpreted_sections =" elf32_interpreted_section list "
type_synonym elf64_interpreted_sections =" elf64_interpreted_section list "

(*val string_of_elf32_interpreted_section : elf32_interpreted_section -> string*)

(*val string_of_elf64_interpreted_section : elf64_interpreted_section -> string*)
   
    
(*val is_valid_elf32_section_header_table_entry : elf32_interpreted_section ->
  string_table -> bool*)
definition is_valid_elf32_section_header_table_entry  :: " elf32_interpreted_section \<Rightarrow> string_table \<Rightarrow> bool "  where 
     " is_valid_elf32_section_header_table_entry ent stbl = (
  (case  String_table.get_string_at(elf32_section_name   ent) stbl of
      Fail    f    => False
    | Success name1 =>
      (case   elf_special_sections name1 of
          None           => False (* ??? *)
        | Some (typ1, flags) =>            
(typ1 =(elf32_section_type   ent)) \<and> (flags =(elf32_section_flags   ent))
      )
  ))"

  
(*val is_valid_elf32_section_header_table : list elf32_interpreted_section ->
  string_table -> bool*)
definition is_valid_elf32_section_header_table0  :: "(elf32_interpreted_section)list \<Rightarrow> string_table \<Rightarrow> bool "  where 
     " is_valid_elf32_section_header_table0 ents stbl = (
  ((\<forall> x \<in> (set ents).  (\<lambda> x .  is_valid_elf32_section_header_table_entry x stbl) x)))"

  
(*val is_valid_elf64_section_header_table_entry : elf64_interpreted_section ->
  string_table -> bool*)
definition is_valid_elf64_section_header_table_entry  :: " elf64_interpreted_section \<Rightarrow> string_table \<Rightarrow> bool "  where 
     " is_valid_elf64_section_header_table_entry ent stbl = (
  (case  String_table.get_string_at(elf64_section_name   ent) stbl of
      Fail    f    => False
    | Success name1 =>
      (case   elf_special_sections name1 of
          None           => False (* ??? *)
        | Some (typ1, flags) =>            
(typ1 =(elf64_section_type   ent)) \<and> (flags =(elf64_section_flags   ent))
      )
  ))"

  
(*val is_valid_elf64_section_header_table : list elf64_interpreted_section ->
  string_table -> bool*)
definition is_valid_elf64_section_header_table0  :: "(elf64_interpreted_section)list \<Rightarrow> string_table \<Rightarrow> bool "  where 
     " is_valid_elf64_section_header_table0 ents stbl = (
  ((\<forall> x \<in> (set ents).  (\<lambda> x .  is_valid_elf64_section_header_table_entry x stbl) x)))"
   
end
