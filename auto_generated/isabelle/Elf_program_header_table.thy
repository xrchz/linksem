header{*Generated by Lem from elf_program_header_table.lem.*}

theory "Elf_program_header_table" 

imports 
 	 Main
	 "Lem_basic_classes" 
	 "Lem_bool" 
	 "Lem_function" 
	 "Lem_list" 
	 "Lem_maybe" 
	 "Lem_num" 
	 "Lem_string" 
	 "Elf_types" 
	 "Endianness" 
	 "Byte_sequence" 
	 "Error" 
	 "Missing_pervasives" 
	 "Show" 

begin 

(*open import Basic_classes*)
(*open import Bool*)
(*open import Function*)
(*open import List*)
(*open import Maybe*)
(*open import Num*)
(*open import String*)

(*open import Elf_types*)
(*open import Endianness*)

(*open import Byte_sequence*)
(*open import Error*)
(*open import Missing_pervasives*)
(*open import Show*)

(** Segment types
  *
  * FIXME: Bug in Lem as Lem codebase uses [int] type throughout where [BigInt.t]
  * is really needed, hence chokes on huge constants below, which is why they are
  * written in the way that they are.
  *)

(** Unused array element.  All other members of the structure are undefined. *)
definition elf_pt_null  :: " nat "  where 
     " elf_pt_null = (( 0 :: nat))"

(** A loadable segment. *)
definition elf_pt_load  :: " nat "  where 
     " elf_pt_load = (( 1 :: nat))"

(** Dynamic linking information. *)
definition elf_pt_dynamic  :: " nat "  where 
     " elf_pt_dynamic = (( 2 :: nat))"

(** Specifies the location and size of a null-terminated path name to be used to
  * invoke an interpreter.
  *)
definition elf_pt_interp  :: " nat "  where 
     " elf_pt_interp = (( 3 :: nat))"

(** Specifies location and size of auxiliary information. *)
definition elf_pt_note  :: " nat "  where 
     " elf_pt_note = (( 4 :: nat))"

(** Reserved but with unspecified semantics.  If the file contains a segment of
  * this type then it is to be regarded as non-conformant with the ABI.
  *)
definition elf_pt_shlib  :: " nat "  where 
     " elf_pt_shlib = (( 5 :: nat))"

(** Specifies the location and size of the program header table. *)
definition elf_pt_phdr  :: " nat "  where 
     " elf_pt_phdr = (( 6 :: nat))"

(** Specifies the thread local storage (TLS) template.  Need not be supported. *)
definition elf_pt_tls  :: " nat "  where 
     " elf_pt_tls = (( 7 :: nat))"

(** Start of reserved indices for operating system specific semantics. *)
definition elf_pt_loos  :: " nat "  where 
     " elf_pt_loos = ((((( 128 :: nat) *( 128 :: nat)) *( 128 :: nat)) *( 256 :: nat)) *( 3 :: nat))"
 (* 1610612736 (* 0x60000000 *) *)
(** End of reserved indices for operating system specific semantics. *)
definition elf_pt_hios  :: " nat "  where 
     " elf_pt_hios = ( (( 469762047 :: nat) *( 4 :: nat)) +( 3 :: nat))"
 (* 1879048191 (* 0x6fffffff *) *)
(** Start of reserved indices for processor specific semantics. *)
definition elf_pt_loproc  :: " nat "  where 
     " elf_pt_loproc = ( (( 469762048 :: nat) *( 4 :: nat)))"
 (* 1879048192 (* 0x70000000 *) *)
(** End of reserved indices for processor specific semantics. *)
definition elf_pt_hiproc  :: " nat "  where 
     " elf_pt_hiproc = ( (( 536870911 :: nat) *( 4 :: nat)) +( 3 :: nat))"
 (* 2147483647 (* 0x7fffffff *) *)

(** [string_of_elf_segment_type os proc st] produces a string representation of
  * the coding of an ELF segment type [st] using [os] and [proc] to render OS-
  * and processor-specific codings.
  *)
(*val string_of_elf_segment_type : (natural -> string) -> (natural -> string) -> natural -> string*)

(** Program header table entry type *)

(** Type [elf32_program_header_table_entry] encodes a program header table entry
  * for 32-bit platforms.  Each entry describes a segment in an executable or
  * shared object file.
  *)
record elf32_program_header_table_entry =
  
 elf32_p_type   ::" uint32 " (** Type of the segment *)
   
 elf32_p_offset ::" uint32 "  (** Offset from beginning of file for segment *)
   
 elf32_p_vaddr  ::" uint32 " (** Virtual address for segment in memory *)
   
 elf32_p_paddr  ::" uint32 " (** Physical address for segment *)
   
 elf32_p_filesz ::" uint32 " (** Size of segment in file, in bytes *)
   
 elf32_p_memsz  ::" uint32 " (** Size of segment in memory image, in bytes *)
   
 elf32_p_flags  ::" uint32 " (** Segment flags *)
   
 elf32_p_align  ::" uint32 " (** Segment alignment memory for memory and file *)
   


(** Type [elf64_program_header_table_entry] encodes a program header table entry
  * for 64-bit platforms.  Each entry describes a segment in an executable or
  * shared object file.
  *)
record elf64_program_header_table_entry =
  
 elf64_p_type   ::" uint32 "  (** Type of the segment *)
   
 elf64_p_flags  ::" uint32 "  (** Segment flags *)
   
 elf64_p_offset ::" uint64 "   (** Offset from beginning of file for segment *)
   
 elf64_p_vaddr  ::" Elf_Types_Local.uint64 "  (** Virtual address for segment in memory *)
   
 elf64_p_paddr  ::" Elf_Types_Local.uint64 "  (** Physical address for segment *)
   
 elf64_p_filesz ::" uint64 " (** Size of segment in file, in bytes *)
   
 elf64_p_memsz  ::" uint64 " (** Size of segment in memory image, in bytes *)
   
 elf64_p_align  ::" uint64 " (** Segment alignment memory for memory and file *)
   

  
(** [string_of_elf32_program_header_table_entry os proc et] produces a string
  * representation of a 32-bit program header table entry using [os] and [proc]
  * to render OS- and processor-specific entries.
  *)
(*val string_of_elf32_program_header_table_entry : (natural -> string) -> (natural -> string) -> elf32_program_header_table_entry -> string*)

(** [string_of_elf64_program_header_table_entry os proc et] produces a string
  * representation of a 64-bit program header table entry using [os] and [proc]
  * to render OS- and processor-specific entries.
  *)
(*val string_of_elf64_program_header_table_entry : (natural -> string) -> (natural -> string) -> elf64_program_header_table_entry -> string*)

(** [string_of_elf32_program_header_table_entry_default et] produces a string representation
  * of table entry [et] where OS- and processor-specific entries are replaced with
  * default strings.
  *)
(*val string_of_elf32_program_header_table_entry_default : elf32_program_header_table_entry -> string*)

(** [string_of_elf64_program_header_table_entry_default et] produces a string representation
  * of table entry [et] where OS- and processor-specific entries are replaced with
  * default strings.
  *)
(*val string_of_elf64_program_header_table_entry_default : elf64_program_header_table_entry -> string*)

(*val bytes_of_elf32_program_header_table_entry : endianness -> elf32_program_header_table_entry -> byte_sequence*)
definition bytes_of_elf32_program_header_table_entry  :: " endianness \<Rightarrow> elf32_program_header_table_entry \<Rightarrow> byte_sequence "  where 
     " bytes_of_elf32_program_header_table_entry endian entry = (
  Byte_sequence.from_byte_lists [
    bytes_of_elf32_word endian(elf32_p_type   entry)
  , bytes_of_elf32_off  endian(elf32_p_offset   entry)
  , bytes_of_elf32_addr endian(elf32_p_vaddr   entry)
  , bytes_of_elf32_addr endian(elf32_p_paddr   entry)
  , bytes_of_elf32_word endian(elf32_p_filesz   entry)
  , bytes_of_elf32_word endian(elf32_p_memsz   entry)
  , bytes_of_elf32_word endian(elf32_p_flags   entry)
  , bytes_of_elf32_word endian(elf32_p_align   entry)
  ])"


(** [read_elf32_program_header_table_entry endian bs0] reads an ELF32 program header table
  * entry from byte sequence [bs0] assuming endianness [endian].  If [bs0] is larger
  * than necessary, the excess is returned from the function, too.
  *)
(*val read_elf32_program_header_table_entry : endianness -> byte_sequence -> error (elf32_program_header_table_entry * byte_sequence)*)
definition read_elf32_program_header_table_entry  :: " endianness \<Rightarrow> byte_sequence \<Rightarrow>(elf32_program_header_table_entry*byte_sequence)error "  where 
     " read_elf32_program_header_table_entry endian bs = (
	read_elf32_word endian bs >>= (\<lambda> (typ1, bs) . 
	read_elf32_off  endian bs >>= (\<lambda> (offset, bs) . 
	read_elf32_addr endian bs >>= (\<lambda> (vaddr, bs) . 
	read_elf32_addr endian bs >>= (\<lambda> (paddr, bs) . 
	read_elf32_word endian bs >>= (\<lambda> (filesz, bs) . 
	read_elf32_word endian bs >>= (\<lambda> (memsz, bs) . 
	read_elf32_word endian bs >>= (\<lambda> (flags, bs) . 
	read_elf32_word endian bs >>= (\<lambda> (align, bs) . 
		error_return ((| elf32_p_type = typ1, elf32_p_offset = offset,
                elf32_p_vaddr = vaddr, elf32_p_paddr = paddr,
                elf32_p_filesz = filesz, elf32_p_memsz = memsz,
                elf32_p_flags = flags, elf32_p_align = align |), bs))))))))))"


(*val bytes_of_elf64_program_header_table_entry : endianness -> elf64_program_header_table_entry -> byte_sequence*)
definition bytes_of_elf64_program_header_table_entry  :: " endianness \<Rightarrow> elf64_program_header_table_entry \<Rightarrow> byte_sequence "  where 
     " bytes_of_elf64_program_header_table_entry endian entry = (
  Byte_sequence.from_byte_lists [
    bytes_of_elf64_word  endian(elf64_p_type   entry)
  , bytes_of_elf64_word  endian(elf64_p_flags   entry)
  , bytes_of_elf64_off   endian(elf64_p_offset   entry)
  , bytes_of_elf64_addr  endian(elf64_p_vaddr   entry)
  , bytes_of_elf64_addr  endian(elf64_p_paddr   entry)
  , bytes_of_elf64_xword endian(elf64_p_filesz   entry)
  , bytes_of_elf64_xword endian(elf64_p_memsz   entry)
  , bytes_of_elf64_xword endian(elf64_p_align   entry)
  ])"


(*val read_elf64_program_header_table_entry : endianness -> byte_sequence -> error (elf64_program_header_table_entry * byte_sequence)*)
definition read_elf64_program_header_table_entry  :: " endianness \<Rightarrow> byte_sequence \<Rightarrow>(elf64_program_header_table_entry*byte_sequence)error "  where 
     " read_elf64_program_header_table_entry endian bs = (
  read_elf64_word endian bs >>= (\<lambda> (typ1, bs) . 
  read_elf64_word endian bs >>= (\<lambda> (flags, bs) . 
  read_elf64_off  endian bs >>= (\<lambda> (offset, bs) . 
  read_elf64_addr endian bs >>= (\<lambda> (vaddr, bs) . 
  read_elf64_addr endian bs >>= (\<lambda> (paddr, bs) . 
  read_elf64_xword endian bs >>= (\<lambda> (filesz, bs) . 
  read_elf64_xword endian bs >>= (\<lambda> (memsz, bs) . 
  read_elf64_xword endian bs >>= (\<lambda> (align, bs) . 
    error_return ((| elf64_p_type = typ1,
                elf64_p_flags = flags, elf64_p_offset = offset,
                elf64_p_vaddr = vaddr, elf64_p_paddr = paddr,
                elf64_p_filesz = filesz, elf64_p_memsz = memsz, elf64_p_align = align  |), bs))))))))))"


(** Program header table type *)

(** Type [elf32_program_header_table] represents a program header table for 32-bit
  * ELF files.  A program header table is an array (implemented as a list, here)
  * of program header table entries.
  *)
type_synonym elf32_program_header_table =" elf32_program_header_table_entry
  list "

record 'a HasElf32ProgramHeaderTable_class=

  get_elf32_program_header_table_method ::" 'a \<Rightarrow>  elf32_program_header_table option "



(** Type [elf64_program_header_table] represents a program header table for 64-bit
  * ELF files.  A program header table is an array (implemented as a list, here)
  * of program header table entries.
  *)
type_synonym elf64_program_header_table =" elf64_program_header_table_entry
  list "

record 'a HasElf64ProgramHeaderTable_class=

  get_elf64_program_header_table_method ::" 'a \<Rightarrow>  elf64_program_header_table option "



definition bytes_of_elf32_program_header_table  :: " endianness \<Rightarrow>(elf32_program_header_table_entry)list \<Rightarrow> byte_sequence "  where 
     " bytes_of_elf32_program_header_table endian tbl = (
  Byte_sequence.concat_byte_sequence (List.map (bytes_of_elf32_program_header_table_entry endian) tbl))"


(** [read_elf32_program_header_table' endian bs0] reads an ELF32 program header table from
  * byte_sequence [bs0] assuming endianness [endian].  The byte_sequence [bs0] is assumed
  * to have exactly the correct size for the table.  For internal use, only.  Use
  * [read_elf32_program_header_table] below instead.
  *)
function (sequential,domintros)  read_elf32_program_header_table'  :: " endianness \<Rightarrow> byte_sequence \<Rightarrow>((elf32_program_header_table_entry)list)error "  where 
     " read_elf32_program_header_table' endian bs0 = (
	if length bs0 =( 0 :: nat) then
  	error_return []
  else
  	read_elf32_program_header_table_entry endian bs0 >>= (\<lambda> (entry, bs1) . 
    read_elf32_program_header_table' endian bs1 >>= (\<lambda> tail . 
    error_return (entry # tail))))" 
by pat_completeness auto


definition bytes_of_elf64_program_header_table  :: " endianness \<Rightarrow>(elf64_program_header_table_entry)list \<Rightarrow> byte_sequence "  where 
     " bytes_of_elf64_program_header_table endian tbl = (
  Byte_sequence.concat_byte_sequence (List.map (bytes_of_elf64_program_header_table_entry endian) tbl))"


(** [read_elf64_program_header_table' endian bs0] reads an ELF64 program header table from
  * byte_sequence [bs0] assuming endianness [endian].  The byte_sequence [bs0] is assumed
  * to have exactly the correct size for the table.  For internal use, only.  Use
  * [read_elf32_program_header_table] below instead.
  *)
function (sequential,domintros)  read_elf64_program_header_table'  :: " endianness \<Rightarrow> byte_sequence \<Rightarrow>((elf64_program_header_table_entry)list)error "  where 
     " read_elf64_program_header_table' endian bs0 = (
  if length bs0 =( 0 :: nat) then
    error_return []
  else
    read_elf64_program_header_table_entry endian bs0 >>= (\<lambda> (entry, bs1) . 
    read_elf64_program_header_table' endian bs1 >>= (\<lambda> tail . 
    error_return (entry # tail))))" 
by pat_completeness auto


(** [read_elf32_program_header_table table_size endian bs0] reads an ELF32 program header
  * table from byte_sequence [bs0] assuming endianness [endian] based on the size (in bytes) passed in via [table_size].
  * This [table_size] argument should be equal to the number of entries in the
  * table multiplied by the fixed entry size.  Bitstring [bs0] may be larger than
  * necessary, in which case the excess is returned.
  *)
(*val read_elf32_program_header_table : natural -> endianness -> byte_sequence -> error (elf32_program_header_table * byte_sequence)*)
definition read_elf32_program_header_table  :: " nat \<Rightarrow> endianness \<Rightarrow> byte_sequence \<Rightarrow>((elf32_program_header_table_entry)list*byte_sequence)error "  where 
     " read_elf32_program_header_table table_size endian bs0 = (
	partition table_size bs0 >>= (\<lambda> (eat, rest) . 
	read_elf32_program_header_table' endian eat >>= (\<lambda> table . 
	error_return (table, rest))))"


(** [read_elf64_program_header_table table_size endian bs0] reads an ELF64 program header
  * table from byte_sequence [bs0] assuming endianness [endian] based on the size (in bytes) passed in via [table_size].
  * This [table_size] argument should be equal to the number of entries in the
  * table multiplied by the fixed entry size.  Bitstring [bs0] may be larger than
  * necessary, in which case the excess is returned.
  *)
(*val read_elf64_program_header_table : natural -> endianness -> byte_sequence -> error (elf64_program_header_table * byte_sequence)*)
definition read_elf64_program_header_table  :: " nat \<Rightarrow> endianness \<Rightarrow> byte_sequence \<Rightarrow>((elf64_program_header_table_entry)list*byte_sequence)error "  where 
     " read_elf64_program_header_table table_size endian bs0 = (
  partition table_size bs0 >>= (\<lambda> (eat, rest) . 
  read_elf64_program_header_table' endian eat >>= (\<lambda> table . 
  error_return (table, rest))))"


(** The [pht_print_bundle] type is used to tidy up other type signatures.  Some of the
  * top-level string_of_ functions require six or more functions passed to them,
  * which quickly gets out of hand.  This type is used to reduce that complexity.
  * The first component of the type is an OS specific print function, the second is
  * a processor specific print function.
  *)
type_synonym pht_print_bundle =" (nat \<Rightarrow> string) * (nat \<Rightarrow> string)"

(** [string_of_elf32_program_header_table os proc tbl] produces a string representation
  * of program header table [tbl] using [os] and [proc] to render OS- and processor-
  * specific entries.
  *)
(*val string_of_elf32_program_header_table : pht_print_bundle -> elf32_program_header_table -> string*)

(** [string_of_elf64_program_header_table os proc tbl] produces a string representation
  * of program header table [tbl] using [os] and [proc] to render OS- and processor-
  * specific entries.
  *)
(*val string_of_elf64_program_header_table : pht_print_bundle -> elf64_program_header_table -> string*)

(*val get_elf32_dynamic_linked : elf32_program_header_table -> bool*)
definition get_elf32_dynamic_linked  :: "(elf32_program_header_table_entry)list \<Rightarrow> bool "  where 
     " get_elf32_dynamic_linked pht = (
  ((\<exists> x \<in> (set pht).  (\<lambda> p .  unat(elf32_p_type   p) = elf_pt_interp) x)))"


(*val get_elf32_static_linked : elf32_program_header_table -> bool*)
definition get_elf32_static_linked  :: "(elf32_program_header_table_entry)list \<Rightarrow> bool "  where 
     " get_elf32_static_linked pht = (
  \<not> (get_elf32_dynamic_linked pht))"


(*val get_elf64_dynamic_linked : elf64_program_header_table -> bool*)
definition get_elf64_dynamic_linked  :: "(elf64_program_header_table_entry)list \<Rightarrow> bool "  where 
     " get_elf64_dynamic_linked pht = (
  ((\<exists> x \<in> (set pht).  (\<lambda> p .  unat(elf64_p_type   p) = elf_pt_interp) x)))"


(*val get_elf64_static_linked : elf64_program_header_table -> bool*)
definition get_elf64_static_linked  :: "(elf64_program_header_table_entry)list \<Rightarrow> bool "  where 
     " get_elf64_static_linked pht = (
  \<not> (get_elf64_dynamic_linked pht))"
end