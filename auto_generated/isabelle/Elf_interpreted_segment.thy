chapter {* Generated by Lem from elf_interpreted_segment.lem. *}

theory "Elf_interpreted_segment" 

imports 
 	 Main
	 "/home/dpm/Work/Programming/Cambridge/bitbucket/lem/isabelle-lib/Lem_num" 
	 "/home/dpm/Work/Programming/Cambridge/bitbucket/lem/isabelle-lib/Lem_basic_classes" 
	 "/home/dpm/Work/Programming/Cambridge/bitbucket/lem/isabelle-lib/Lem_bool" 
	 "/home/dpm/Work/Programming/Cambridge/bitbucket/lem/isabelle-lib/Lem_string" 
	 "Show" 
	 "Missing_pervasives" 
	 "Byte_sequence" 
	 "Elf_types_native_uint" 

begin 

(*open import Basic_classes*)
(*open import Bool*)
(*open import Num*)
(*open import String*)

(*open import Elf_types_native_uint*)

(*open import Byte_sequence*)
(*open import Missing_pervasives*)
(*open import Show*)

record elf32_interpreted_segment =
  
 elf32_segment_body  ::" byte_sequence "        (** Body of the segment *)
   
 elf32_segment_type  ::" nat "              (** Type of the segment *)
   
 elf32_segment_size  ::" nat "              (** Size of the segment in bytes *)
   
 elf32_segment_memsz ::" nat "              (** Size of the segment in memory in bytes *)
   
 elf32_segment_base  ::" nat "              (** Base address of the segment *)
   
 elf32_segment_paddr ::" nat "              (** Physical address of segment *)
   
 elf32_segment_align ::" nat "              (** Alignment of the segment *)
   
 elf32_segment_offset ::" nat "             (** Offset of the segment *)
   
 elf32_segment_flags ::" (bool * bool * bool)" (** READ, WRITE, EXECUTE flags. *)
   


record elf64_interpreted_segment =
  
 elf64_segment_body  ::" byte_sequence "        (** Body of the segment *)
   
 elf64_segment_type  ::" nat "              (** Type of the segment *)
   
 elf64_segment_size  ::" nat "              (** Size of the segment in bytes *)
   
 elf64_segment_memsz ::" nat "              (** Size of the segment in memory in bytes *)
   
 elf64_segment_base  ::" nat "              (** Base address of the segment *)
   
 elf64_segment_paddr ::" nat "              (** Physical address of segment *)
   
 elf64_segment_align ::" nat "              (** Alignment of the segment *)
   
 elf64_segment_offset ::" nat "             (** Offset of the segment *)
   
 elf64_segment_flags ::" (bool * bool * bool)" (** READ, WRITE, EXECUTE flags. *)
   

   
definition compare_elf64_interpreted_segment  :: " elf64_interpreted_segment \<Rightarrow> elf64_interpreted_segment \<Rightarrow> ordering "  where 
     " compare_elf64_interpreted_segment s1 s2 = (    
 (tripleCompare compare_byte_sequence (Lem_list.lexicographicCompareBy (genericCompare (op<) (op=))) (Lem_list.lexicographicCompareBy (genericCompare (op<) (op=))) 
    ((elf64_segment_body   s1), [(elf64_segment_type   s1)  ,(elf64_segment_size  
s1)  ,(elf64_segment_memsz  
s1) ,(elf64_segment_base  
s1)  ,(elf64_segment_paddr  
s1) ,(elf64_segment_align  
s1) ,(elf64_segment_offset  
s1)],  ((let (f1, f2, f3) = ((elf64_segment_flags   s1)) in List.map natural_of_bool [f1, f2, f3])))
((elf64_segment_body   s2), [(elf64_segment_type   s2)  ,(elf64_segment_size  
s2)  ,(elf64_segment_memsz  
s2) ,(elf64_segment_base  
s2)  ,(elf64_segment_paddr  
s2) ,(elf64_segment_align  
s2) ,(elf64_segment_offset  
s2)], ((let (f1, f2, f3) = ((elf64_segment_flags   s2)) in List.map natural_of_bool [f1, f2, f3])))))"


definition instance_Basic_classes_Ord_Elf_interpreted_segment_elf64_interpreted_segment_dict  :: "(elf64_interpreted_segment)Ord_class "  where 
     " instance_Basic_classes_Ord_Elf_interpreted_segment_elf64_interpreted_segment_dict = ((|

  compare_method = compare_elf64_interpreted_segment,

  isLess_method = (\<lambda> f1 .  (\<lambda> f2 .  (compare_elf64_interpreted_segment f1 f2 = LT))),

  isLessEqual_method = (\<lambda> f1 .  (\<lambda> f2 .  (let result = (compare_elf64_interpreted_segment f1 f2) in (result = LT) \<or> (result = EQ)))),

  isGreater_method = (\<lambda> f1 .  (\<lambda> f2 .  (compare_elf64_interpreted_segment f1 f2 = GT))),

  isGreaterEqual_method = (\<lambda> f1 .  (\<lambda> f2 .  (let result = (compare_elf64_interpreted_segment f1 f2) in (result = GT) \<or> (result = EQ))))|) )"


type_synonym elf32_interpreted_segments =" elf32_interpreted_segment list "
type_synonym elf64_interpreted_segments =" elf64_interpreted_segment list "

(*val elf32_interpret_program_header_flags : elf32_word -> (bool * bool * bool)*)
definition elf32_interpret_program_header_flags  :: " uint32 \<Rightarrow> bool*bool*bool "  where 
     " elf32_interpret_program_header_flags flags = (
  (let zero = (Elf_Types_Local.uint32_of_nat(( 0 :: nat))) in
  (let one  = (Elf_Types_Local.uint32_of_nat(( 1 :: nat))) in
  (let two  = (Elf_Types_Local.uint32_of_nat(( 2 :: nat))) in
  (let four = (Elf_Types_Local.uint32_of_nat(( 4 :: nat))) in
    (\<not> (Elf_Types_Local.uint32_land flags one = zero),
      \<not> (Elf_Types_Local.uint32_land flags two = zero),
      \<not> (Elf_Types_Local.uint32_land flags four = zero)))))))"


(*val elf64_interpret_program_header_flags : elf64_word -> (bool * bool * bool)*)
definition elf64_interpret_program_header_flags  :: " uint32 \<Rightarrow> bool*bool*bool "  where 
     " elf64_interpret_program_header_flags flags = (
  (let zero = (Elf_Types_Local.uint32_of_nat(( 0 :: nat))) in
  (let one  = (Elf_Types_Local.uint32_of_nat(( 1 :: nat))) in
  (let two  = (Elf_Types_Local.uint32_of_nat(( 2 :: nat))) in
  (let four = (Elf_Types_Local.uint32_of_nat(( 4 :: nat))) in
    (\<not> (Elf_Types_Local.uint32_land flags one = zero),
      \<not> (Elf_Types_Local.uint32_land flags two = zero),
      \<not> (Elf_Types_Local.uint32_land flags four = zero)))))))"


(*val string_of_flags : (bool * bool * bool) -> string*)

(*val string_of_elf32_interpreted_segment : elf32_interpreted_segment -> string*)

(*val string_of_elf64_interpreted_segment : elf64_interpreted_segment -> string*)
end
