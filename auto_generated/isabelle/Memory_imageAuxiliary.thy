header{*Generated by Lem from memory_image.lem.*}

theory "Memory_imageAuxiliary" 

imports 
 	 Main "~~/src/HOL/Library/Code_Target_Numeral"
	 "Lem_num" 
	 "Lem_list" 
	 "Lem_set" 
	 "Lem_function" 
	 "Lem_basic_classes" 
	 "Lem_bool" 
	 "Lem_maybe" 
	 "Lem_string" 
	 "Lem_assert_extra" 
	 "Show" 
	 "Lem_sorting" 
	 "Missing_pervasives" 
	 "Byte_sequence" 
	 "Elf_types_native_uint" 
	 "Lem_tuple" 
	 "Elf_header" 
	 "Lem_map" 
	 "Elf_program_header_table" 
	 "Elf_file" 
	 "Elf_relocation" 
	 "Elf_section_header_table" 
	 "Elf_interpreted_section" 
	 "Elf_interpreted_segment" 
	 "Elf_symbol_table" 
	 "Multimap" 
	 "Memory_image" 

begin 


(****************************************************)
(*                                                  *)
(* Termination Proofs                               *)
(*                                                  *)
(****************************************************)

termination nat_range by lexicographic_order

termination expand_sorted_ranges by lexicographic_order

termination make_byte_pattern_revacc by lexicographic_order

termination relax_byte_pattern_revacc by lexicographic_order

termination byte_list_matches_pattern by lexicographic_order

termination accum_pattern_possible_starts_in_one_byte_sequence by lexicographic_order



end