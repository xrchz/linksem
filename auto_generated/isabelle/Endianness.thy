chapter {* Generated by Lem from endianness.lem. *}

theory "Endianness" 

imports 
 	 Main
	 "/home/dpm/Work/Programming/Cambridge/bitbucket/lem/isabelle-lib/Lem_string" 
	 "Show" 

begin 

(** [endian.lem] defines a type for describing the endianness of an ELF file,
  * and functions and other operations over that type.
  *)

(*open import String*)
(*open import Show*)

(** Type [endianness] describes the endianness of an ELF file.  This is deduced from
  * the first few bytes (magic number, etc.) of the ELF header.
  *)
datatype endianness
  = Big    (* Big endian *)
  | Little (* Little endian *)

(** [default_endianness] is a default endianness to use when reading in the ELF header
  * before we have deduced from its entries what the rest of the file is encoded
  * with.
  *)
(*val default_endianness : endianness*)
definition default_endianness  :: " endianness "  where 
     " default_endianness = ( Little )"


(** [string_of_endianness e] produces a string representation of the [endianness] value
  * [e].
  *)
(*val string_of_endianness : endianness -> string*)
end
