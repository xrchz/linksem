(*Generated by Lem from elf_symbol_table.lem.*)
open HolKernel Parse boolLib bossLib;
open lem_numTheory lem_listTheory lem_setTheory lem_basic_classesTheory lem_boolTheory lem_maybeTheory lem_stringTheory showTheory missing_pervasivesTheory errorTheory byte_sequenceTheory endiannessTheory elf_types_native_uintTheory lem_tupleTheory elf_headerTheory string_tableTheory;

val _ = numLib.prefer_num();



val _ = new_theory "elf_symbol_table"

(** [elf_symbol_table] provides types, functions and other definitions for
  * working with ELF symbol tables.
  *)

(*open import Basic_classes*)
(*open import Bool*)
(*open import List*)
(*open import Maybe*)
(*open import Num*)
(*open import String*)
(*open import Tuple*)
(*import Set*)

(*open import Byte_sequence*)
(*open import Error*)
(*open import Missing_pervasives*)
(*open import Show*)

(*open import Elf_header*)
(*open import Elf_types_native_uint*)
(*open import Endianness*)
(*open import String_table*)

(** Undefined symbol index *)

val _ = Define `
 (stn_undef : num= (I 0))`;


(** Symbol binding *)

(** Local symbols are not visible outside of the object file containing their
  * definition.
  *)
val _ = Define `
 (stb_local : num= (I 0))`;


(** Global symbols are visible to all object files being combined.
  *)
val _ = Define `
 (stb_global : num= (I 1))`;


(** Weak symbols resemble global symbols but their definitions have lower
  * precedence.
  *)
val _ = Define `
 (stb_weak : num= (I 2))`;


(** Values in the following range have reserved OS specific semantics.
  *)
val _ = Define `
 (stb_loos : num= (I 10))`;

val _ = Define `
 (stb_hios : num= (I 12))`;


(** Values in the following range have reserved processor specific semantics.
  *)
val _ = Define `
 (stb_loproc : num= (I 13))`;

val _ = Define `
 (stb_hiproc : num= (I 15))`;


(** string_of_symbol_binding b os proc] produces a string representation of
  * binding [m] using printing functions [os] and [proc] for OS- and processor-
  * specific values respectively.
  * OCaml specific definition.
  *)
(*val string_of_symbol_binding : natural -> (natural -> string) -> (natural -> string) -> string*)
val _ = Define `
 (string_of_symbol_binding m os proc=  
 (if m = stb_local then
    "LOCAL"
  else if m = stb_global then
    "GLOBAL"
  else if m = stb_weak then
    "WEAK"
  else if (m >= stb_loos) /\ (m <= stb_hios) then
    os m
  else if (m >= stb_loproc) /\ (m <= stb_hiproc) then
    proc m
  else
    "Invalid symbol binding"))`;


(** Symbol types *)

(** The symbol's type is not specified.
  *)
val _ = Define `
 (stt_notype : num= (I 0))`;


(** The symbol is associated with a data object such as a variable.
  *)
val _ = Define `
 (stt_object : num= (I 1))`;


(** The symbol is associated with a function or other executable code.
  *)
val _ = Define `
 (stt_func : num= (I 2))`;


(** The symbol is associated with a section.
  *)
val _ = Define `
 (stt_section : num= (I 3))`;


(** Conventionally the symbol's value gives the name of the source file associated
  * with the object file.
  *)
val _ = Define `
 (stt_file : num= (I 4))`;


(** The symbol is an uninitialised common block.
  *)
val _ = Define `
 (stt_common : num= (I 5))`;


(** The symbol specified a Thread Local Storage (TLS) entity.
  *)
val _ = Define `
 (stt_tls : num= (I 6))`;


(** Values in the following range are reserved solely for OS-specific semantics.
  *)
val _ = Define `
 (stt_loos : num= (I 10))`;

val _ = Define `
 (stt_hios : num= (I 12))`;


(** Values in the following range are reserved solely for processor-specific
  * semantics.
  *)
val _ = Define `
 (stt_loproc : num= (I 13))`;

val _ = Define `
 (stt_hiproc : num= (I 15))`;


(** [string_of_symbol_type sym os proc] produces a string representation of
  * symbol type [m] using [os] and [proc] to pretty-print values reserved for
  * OS- and processor-specific functionality.
  *)
(*val string_of_symbol_type : natural -> (natural -> string) -> (natural -> string) -> string*)
val _ = Define `
 (string_of_symbol_type m os proc=  
 (if m = stt_notype then
    "NOTYPE"
  else if m = stt_object then
    "OBJECT"
  else if m = stt_func then
    "FUNC"
  else if m = stt_section then
    "SECTION"
  else if m = stt_file then
    "FILE"
  else if m = stt_common then
    "COMMON"
  else if m = stt_tls then
    "TLS"
  else if (m >= stt_loos) /\ (m <= stt_hios) then
    os m
  else if (m >= stt_loproc) /\ (m <= stt_hiproc) then
    proc m
  else
    "Invalid symbol type"))`;


(** Symbol visibility *)

(** The visibility of the symbol is as specified by the symbol's binding type.
  *)
val _ = Define `
 (stv_default : num= (I 0))`;


(** The meaning of this visibility may be defined by processor supplements to
  * further constrain hidden symbols.
  *)
val _ = Define `
 (stv_internal : num= (I 1))`;


(** The symbol's name is not visible in other components.
  *)
val _ = Define `
 (stv_hidden : num= (I 2))`;


(** The symbol is visible in other components but not pre-emptable.  That is,
  * references to the symbol in the same component resolve to this symbol even
  * if other symbols of the same name in other components would normally be
  * resolved to instead if we followed the normal rules of symbol resolution.
  *)
val _ = Define `
 (stv_protected : num= (I 3))`;


(** [string_of_symbol_visibility m] produces a string representation of symbol
  * visibility [m].
  *)
(*val string_of_symbol_visibility : natural -> string*)
val _ = Define `
 (string_of_symbol_visibility m=  
 (if m = stv_default then
    "DEFAULT"
  else if m = stv_internal then
    "INTERNAL"
  else if m = stv_hidden then
    "HIDDEN"
  else if m = stv_protected then
    "PROTECTED"
  else
    "Invalid symbol visibility"))`;


(** Symbol table entry type *)

(** [elf32_symbol_table_entry] is an entry in a symbol table.
  *)
val _ = Hol_datatype `
 elf32_symbol_table_entry =
  <| elf32_st_name  : word32     (** Index into the object file's string table *)
   ; elf32_st_value : word32     (** Gives the value of the associated symbol *)
   ; elf32_st_size  : word32     (** Size of the associated symbol *)
   ; elf32_st_info  : word8  (** Specifies the symbol's type and binding attributes *)
   ; elf32_st_other : word8  (** Currently specifies the symbol's visibility *)
   ; elf32_st_shndx : word16     (** Section header index symbol is defined with respect to *)
   |>`;


(** [elf32_symbol_table_entry_compare ent1 ent2] is an ordering-comparison function
  * for symbol table entries suitable for constructing sets, finite maps and other
  * ordered data structures from.
  *)
(*val elf32_symbol_table_entry_compare : elf32_symbol_table_entry ->
  elf32_symbol_table_entry -> ordering*)
val _ = Define `
 (elf32_symbol_table_entry_compare ent1 ent2=     
 (sextupleCompare (genericCompare (<) (=)) (genericCompare (<) (=)) (genericCompare (<) (=)) (genericCompare (<) (=)) (genericCompare (<) (=)) (genericCompare (<) (=)) (w2n ent1.elf32_st_name, w2n ent1.elf32_st_value, 
        w2n ent1.elf32_st_size, w2n ent1.elf32_st_info, 
        w2n ent1.elf32_st_other, w2n ent1.elf32_st_shndx)
       (w2n ent2.elf32_st_name, w2n ent2.elf32_st_value, 
        w2n ent2.elf32_st_size, w2n ent2.elf32_st_info, 
        w2n ent2.elf32_st_other, w2n ent2.elf32_st_shndx)))`;


val _ = Define `
(instance_Basic_classes_Ord_Elf_symbol_table_elf32_symbol_table_entry_dict= (<|

  compare_method := elf32_symbol_table_entry_compare;

  isLess_method := (\ f1 .  (\ f2 .  (elf32_symbol_table_entry_compare f1 f2 = LT)));

  isLessEqual_method := (\ f1 .  (\ f2 .  (IN) (elf32_symbol_table_entry_compare f1 f2) ({LT; EQ})));

  isGreater_method := (\ f1 .  (\ f2 .  (elf32_symbol_table_entry_compare f1 f2 = GT)));

  isGreaterEqual_method := (\ f1 .  (\ f2 .  (IN) (elf32_symbol_table_entry_compare f1 f2) ({GT; EQ})))|>))`;

   
(** [elf64_symbol_table_entry] is an entry in a symbol table.
  *)
val _ = Hol_datatype `
 elf64_symbol_table_entry =
  <| elf64_st_name  : word32     (** Index into the object file's string table *)
   ; elf64_st_info  : word8  (** Specifies the symbol's type and binding attributes *)
   ; elf64_st_other : word8  (** Currently specifies the symbol's visibility *)
   ; elf64_st_shndx : word16     (** Section header index symbol is defined with respect to *)
   ; elf64_st_value : word64     (** Gives the value of the associated symbol *)
   ; elf64_st_size  : word64    (** Size of the associated symbol *)
   |>`;


(** [elf64_symbol_table_entry_compare ent1 ent2] is an ordering-comparison function
  * for symbol table entries suitable for constructing sets, finite maps and other
  * ordered data structures from.
  *)
(*val elf64_symbol_table_entry_compare : elf64_symbol_table_entry -> elf64_symbol_table_entry ->
  ordering*)
val _ = Define `
 (elf64_symbol_table_entry_compare ent1 ent2=     
 (sextupleCompare (genericCompare (<) (=)) (genericCompare (<) (=)) (genericCompare (<) (=)) (genericCompare (<) (=)) (genericCompare (<) (=)) (genericCompare (<) (=)) (w2n ent1.elf64_st_name, w2n ent1.elf64_st_value, 
        w2n ent1.elf64_st_size, w2n ent1.elf64_st_info, 
        w2n ent1.elf64_st_other, w2n ent1.elf64_st_shndx)
       (w2n ent2.elf64_st_name, w2n ent2.elf64_st_value, 
        w2n ent2.elf64_st_size, w2n ent2.elf64_st_info, 
        w2n ent2.elf64_st_other, w2n ent2.elf64_st_shndx)))`;


val _ = Define `
(instance_Basic_classes_Ord_Elf_symbol_table_elf64_symbol_table_entry_dict= (<|

  compare_method := elf64_symbol_table_entry_compare;

  isLess_method := (\ f1 .  (\ f2 .  (elf64_symbol_table_entry_compare f1 f2 = LT)));

  isLessEqual_method := (\ f1 .  (\ f2 .  (IN) (elf64_symbol_table_entry_compare f1 f2) ({LT; EQ})));

  isGreater_method := (\ f1 .  (\ f2 .  (elf64_symbol_table_entry_compare f1 f2 = GT)));

  isGreaterEqual_method := (\ f1 .  (\ f2 .  (IN) (elf64_symbol_table_entry_compare f1 f2) ({GT; EQ})))|>))`;

  
val _ = type_abbrev( "elf32_symbol_table" , ``: elf32_symbol_table_entry
  list``);
  
val _ = type_abbrev( "elf64_symbol_table" , ``: elf64_symbol_table_entry
  list``);

(** Extraction of symbol table data *)

(* Functions below common to 32- and 64-bit! *)

(** [extract_symbol_binding u] extracts a symbol table entry's symbol binding.  [u]
  * in this case is the [elfXX_st_info] field from a symbol table entry.
  *)
(*val extract_symbol_binding : unsigned_char -> natural*)
val _ = Define `
 (extract_symbol_binding entry=  
 (w2n (word_lsr entry(I 4))))`;

  
(** [extract_symbol_type u] extracts a symbol table entry's symbol type.  [u]
  * in this case is the [elfXX_st_info] field from a symbol table entry.
  *)
(*val extract_symbol_type : unsigned_char -> natural*)
val _ = Define `
 (extract_symbol_type entry=  
 (w2n (word_and entry ((n2w : num -> 8 word)(I 15)))))`;
 (* 0xf *)

(** [get_symbol_info u] extracts a symbol table entry's symbol info.  [u]
  * in this case is the [elfXX_st_info] field from a symbol table entry.
  *)
(*val make_symbol_info : natural -> natural -> unsigned_char*)
val _ = Define `
 (make_symbol_info binding symtype=  
 (word_add
    (word_lsl ((n2w : num -> 8 word) binding)(I 4))
    (word_and ((n2w : num -> 8 word) symtype)
      ((n2w : num -> 8 word)(I 15)))))`;
 (*0xf*)  

(** [get_symbol_visibility u] extracts a symbol table entry's symbol visibility.  [u]
  * in this case is the [elfXX_st_other] field from a symbol table entry.
  *)
(*val get_symbol_visibility : unsigned_char -> natural*)
val _ = Define `
 (get_symbol_visibility info=  
 (w2n (word_and info ((n2w : num -> 8 word)(I 3)))))`;
 (* 0x3*)
  
(** [make_symbol_other m] converts a natural [m] to an unsigned char suitable
  * for use in a symbol table entry's "other" field.
  * XXX: WHY?
  *)
(*val make_symbol_other : natural -> unsigned_char*)
val _ = Define `
 (make_symbol_other visibility=  
 ((n2w : num -> 8 word) visibility))`;

  
(** [is_elf32_shndx_too_large ent] tests whether the symbol table entry's
  * [shndx] field is equal to SHN_XINDEX, in which case the real value is stored
  * elsewhere.
  *)
(*val is_elf32_shndx_too_large : elf32_symbol_table_entry -> bool*)
val _ = Define `
 (is_elf32_shndx_too_large syment=  
 (w2n syment.elf32_st_shndx = shn_xindex))`;

  
(** [is_elf64_shndx_too_large ent] tests whether the symbol table entry's
  * [shndx] field is equal to SHN_XINDEX, in which case the real value is stored
  * elsewhere.
  *)
(*val is_elf64_shndx_too_large : elf64_symbol_table_entry -> bool*)
val _ = Define `
 (is_elf64_shndx_too_large syment=  
 (w2n syment.elf64_st_shndx = shn_xindex))`;


(** NULL tests *)

(** [is_elf32_null_entry ent] tests whether [ent] is a null symbol table entry,
  * i.e. all fields set to [0].
  *)
(*val is_elf32_null_entry : elf32_symbol_table_entry -> bool*)
val _ = Define `
 (is_elf32_null_entry ent= 
     (((w2n ent.elf32_st_name) =I 0)
    /\ (w2n ent.elf32_st_value =I 0)
    /\ (w2n ent.elf32_st_size =I 0)
    /\ (w2n ent.elf32_st_info =I 0)
    /\ (w2n ent.elf32_st_other =I 0)
    /\ (w2n ent.elf32_st_shndx =I 0)))`;

    
(** [is_elf64_null_entry ent] tests whether [ent] is a null symbol table entry,
  * i.e. all fields set to [0].
  *)
(*val is_elf64_null_entry : elf64_symbol_table_entry -> bool*)
val _ = Define `
 (is_elf64_null_entry ent= 
     (((w2n ent.elf64_st_name) =I 0)
    /\ (w2n ent.elf64_st_value =I 0)
    /\ (w2n ent.elf64_st_size =I 0)
    /\ (w2n ent.elf64_st_info =I 0)
    /\ (w2n ent.elf64_st_other =I 0)
    /\ (w2n ent.elf64_st_shndx =I 0)))`;


(** Printing symbol table entries *)

val _ = type_abbrev( "symtab_print_bundle" , ``:
  (num -> string) # (num -> string)``);

(** [string_of_elf32_symbol_table_entry ent] produces a string based representation
  * of symbol table entry [ent].
  *)
(*val string_of_elf32_symbol_table_entry : elf32_symbol_table_entry -> string*)
val _ = Define `
 (string_of_elf32_symbol_table_entry entry=  
 (unlines [
     STRCAT"\t"   (STRCAT"Name: " (ARB entry.elf32_st_name))
  ;  STRCAT"\t"  (STRCAT"Value: " (ARB entry.elf32_st_value))
  ;  STRCAT"\t"   (STRCAT"Size: " (ARB entry.elf32_st_size))
  ;  STRCAT"\t"   (STRCAT"Info: " (ARB entry.elf32_st_info))
  ;  STRCAT"\t"  (STRCAT"Other: " (ARB entry.elf32_st_other))
  ;  STRCAT"\t"  (STRCAT"Shndx: " (ARB entry.elf32_st_shndx))
  ]))`;

  
(** [string_of_elf64_symbol_table_entry ent] produces a string based representation
  * of symbol table entry [ent].
  *)
(*val string_of_elf64_symbol_table_entry : elf64_symbol_table_entry -> string*)
val _ = Define `
 (string_of_elf64_symbol_table_entry entry=  
 (unlines [
     STRCAT"\t"   (STRCAT"Name: " (ARB entry.elf64_st_name))
  ;  STRCAT"\t"   (STRCAT"Info: " (ARB entry.elf64_st_info))
  ;  STRCAT"\t"  (STRCAT"Other: " (ARB entry.elf64_st_other))
  ;  STRCAT"\t"  (STRCAT"Shndx: " (ARB entry.elf64_st_shndx))
  ;  STRCAT"\t"  (STRCAT"Value: " (ARB entry.elf64_st_value))
  ;  STRCAT"\t"   (STRCAT"Size: " (ARB entry.elf64_st_size))
  ]))`;


(** [string_of_elf32_symbol_table stbl] produces a string based representation
  * of symbol table [stbl].
  *)
(*val string_of_elf32_symbol_table : elf32_symbol_table -> string*)
val _ = Define `
 (string_of_elf32_symbol_table symtab=  
 (unlines (MAP string_of_elf32_symbol_table_entry symtab)))`;

  
(** [elf64_null_symbol_table_entry] is the null symbol table entry, with all
  * fields set to zero.
  *)
(*val elf64_null_symbol_table_entry : elf64_symbol_table_entry*)
val _ = Define `
 (elf64_null_symbol_table_entry=  
 (<| elf64_st_name  := ((n2w : num -> 32 word)(I 0))
   ; elf64_st_info  := ((n2w : num -> 8 word)(I 0))
   ; elf64_st_other := ((n2w : num -> 8 word)(I 0))
   ; elf64_st_shndx := ((n2w : num -> 16 word)(I 0))
   ; elf64_st_value := ((n2w : num -> 64 word)(I 0))
   ; elf64_st_size  := ((n2w : num -> 64 word)(I 0))
   |>))`;


(*val string_of_elf64_symbol_table : elf64_symbol_table -> string*)
val _ = Define `
 (string_of_elf64_symbol_table symtab=  
 (unlines (MAP string_of_elf64_symbol_table_entry symtab)))`;

  
val _ = Define `
(instance_Show_Show_Elf_symbol_table_elf32_symbol_table_entry_dict= (<|

  show_method := string_of_elf32_symbol_table_entry|>))`;


val _ = Define `
(instance_Show_Show_Elf_symbol_table_elf64_symbol_table_entry_dict= (<|

  show_method := string_of_elf64_symbol_table_entry|>))`;


(** Reading in symbol table (entries) *)

(** [read_elf32_symbol_table_entry endian bs0] reads an ELF symbol table entry
  * record from byte sequence [bs0] assuming endianness [endian], returning the
  * remainder of the byte sequence.  Fails if the byte sequence is not long enough.
  *)
(*val read_elf32_symbol_table_entry : endianness -> byte_sequence ->
  error (elf32_symbol_table_entry * byte_sequence)*)
val _ = Define `
 (read_elf32_symbol_table_entry endian bs0=  
 (read_elf32_word endian bs0 >>= (\ (st_name, bs0) . 
  read_elf32_addr endian bs0 >>= (\ (st_value, bs0) . 
  read_elf32_word endian bs0 >>= (\ (st_size, bs0) . 
  read_unsigned_char endian bs0 >>= (\ (st_info, bs0) . 
  read_unsigned_char endian bs0 >>= (\ (st_other, bs0) . 
  read_elf32_half endian bs0 >>= (\ (st_shndx, bs0) . 
    return (<| elf32_st_name := st_name; elf32_st_value := st_value;
                 elf32_st_size := st_size; elf32_st_info := st_info;
                 elf32_st_other := st_other; elf32_st_shndx := st_shndx |>, bs0)))))))))`;


(*val bytes_of_elf32_symbol_table_entry : endianness ->
  elf32_symbol_table_entry -> byte_sequence*)
val _ = Define `
 (bytes_of_elf32_symbol_table_entry endian entry=  
 (byte_sequence$from_byte_lists [
    bytes_of_elf32_word endian entry.elf32_st_name
  ; bytes_of_elf32_addr endian entry.elf32_st_value
  ; bytes_of_elf32_word endian entry.elf32_st_size
  ; bytes_of_unsigned_char entry.elf32_st_info
  ; bytes_of_unsigned_char entry.elf32_st_other
  ; bytes_of_elf32_half endian entry.elf32_st_shndx
  ]))`;


(** [read_elf64_symbol_table_entry endian bs0] reads an ELF symbol table entry
  * record from byte sequence [bs0] assuming endianness [endian], returning the
  * remainder of the byte sequence.  Fails if the byte sequence is not long enough.
  *)       
(*val read_elf64_symbol_table_entry : endianness -> byte_sequence ->
  error (elf64_symbol_table_entry * byte_sequence)*)
val _ = Define `
 (read_elf64_symbol_table_entry endian bs0=  
 (read_elf64_word endian bs0 >>= (\ (st_name, bs0) . 
  read_unsigned_char endian bs0 >>= (\ (st_info, bs0) . 
  read_unsigned_char endian bs0 >>= (\ (st_other, bs0) . 
  read_elf64_half endian bs0 >>= (\ (st_shndx, bs0) . 
  read_elf64_addr endian bs0 >>= (\ (st_value, bs0) . 
  read_elf64_xword endian bs0 >>= (\ (st_size, bs0) . 
    return (<| elf64_st_name := st_name; elf64_st_info := st_info;
                 elf64_st_other := st_other; elf64_st_shndx := st_shndx;
                 elf64_st_value := st_value; elf64_st_size := st_size |>, bs0)))))))))`;


(*val bytes_of_elf64_symbol_table_entry : endianness ->
  elf64_symbol_table_entry -> byte_sequence*)
val _ = Define `
 (bytes_of_elf64_symbol_table_entry endian entry=  
 (byte_sequence$from_byte_lists [
    bytes_of_elf64_word endian entry.elf64_st_name
  ; bytes_of_unsigned_char entry.elf64_st_info
  ; bytes_of_unsigned_char entry.elf64_st_other
  ; bytes_of_elf64_half endian entry.elf64_st_shndx
  ; bytes_of_elf64_addr  endian entry.elf64_st_value
  ; bytes_of_elf64_xword endian entry.elf64_st_size
  ]))`;


(** [read_elf32_symbol_table endian bs0] reads a symbol table from byte sequence
  * [bs0] assuming endianness [endian].  Assumes [bs0]'s length modulo the size
  * of a symbol table entry is 0.  Fails otherwise.
  *)
(*val read_elf32_symbol_table : endianness -> byte_sequence -> error elf32_symbol_table*)
 val read_elf32_symbol_table_defn = Hol_defn "read_elf32_symbol_table" `
 (read_elf32_symbol_table endian bs0=  
 (if byte_sequence$length0 bs0 =I 0 then
    return []
  else
    read_elf32_symbol_table_entry endian bs0 >>= (\ (head, bs0) . 
    read_elf32_symbol_table endian bs0 >>= (\ tail . 
    return (head::tail)))))`;

val _ = Lib.with_flag (computeLib.auto_import_definitions, false) Defn.save_defn read_elf32_symbol_table_defn;
    
(** [read_elf64_symbol_table endian bs0] reads a symbol table from byte sequence
  * [bs0] assuming endianness [endian].  Assumes [bs0]'s length modulo the size
  * of a symbol table entry is 0.  Fails otherwise.
  *)
(*val read_elf64_symbol_table : endianness -> byte_sequence -> error elf64_symbol_table*)
 val read_elf64_symbol_table_defn = Hol_defn "read_elf64_symbol_table" `
 (read_elf64_symbol_table endian bs0=  
 (if byte_sequence$length0 bs0 =I 0 then
    return []
  else
    read_elf64_symbol_table_entry endian bs0 >>= (\ (head, bs0) . 
    read_elf64_symbol_table endian bs0 >>= (\ tail . 
    return (head::tail)))))`;

val _ = Lib.with_flag (computeLib.auto_import_definitions, false) Defn.save_defn read_elf64_symbol_table_defn;

(** Association map of symbol name, symbol type, symbol size, symbol address
  * and symbol binding.
  * A PPCMemism.
  *)
val _ = type_abbrev( "symbol_address_map"
  , ``: (string # (num # num # num # num)) list``);

(** [get_elf32_symbol_image_address symtab stbl] extracts the symbol address map
  * from the symbol table [symtab] using the string table [stbl].
  * A PPCMemism.
  *)
(*val get_elf32_symbol_image_address : elf32_symbol_table -> string_table ->
  error symbol_address_map*)
val _ = Define `
 (get_elf32_symbol_image_address symtab strtab=  
 (mapM (\ entry . 
    let name = (w2n entry.elf32_st_name) in
    let addr = (w2n entry.elf32_st_value) in
    let size1 = (w2n entry.elf32_st_size *I 8) in
    let typ  = (extract_symbol_type entry.elf32_st_info) in
    let bnd  = (extract_symbol_binding entry.elf32_st_info) in
      string_table$get_string_at name strtab >>= (\ str . 
      return (str, (typ, size1, addr, bnd)))
  ) symtab))`;


(** [get_elf64_symbol_image_address symtab stbl] extracts the symbol address map
  * from the symbol table [symtab] using the string table [stbl].
  * A PPCMemism.
  *)
(*val get_elf64_symbol_image_address : elf64_symbol_table -> string_table ->
  error symbol_address_map*)
val _ = Define `
 (get_elf64_symbol_image_address symtab strtab=  
 (mapM (\ entry . 
    let name = (w2n entry.elf64_st_name) in
    let addr = (w2n entry.elf64_st_value) in
    let size1 = (w2n entry.elf64_st_size) in
    let typ  = (extract_symbol_type entry.elf64_st_info) in
    let bnd  = (extract_symbol_binding entry.elf64_st_info) in 
      string_table$get_string_at name strtab >>= (\ str . 
      return (str, (typ, size1, addr, bnd)))
  ) symtab))`;


(** [get_el32_symbol_type ent] extracts the symbol type from symbol table entry
  * [ent].
  *)
(*val get_elf32_symbol_type : elf32_symbol_table_entry -> natural*)
val _ = Define `
 (get_elf32_symbol_type syment=  (extract_symbol_type syment.elf32_st_info))`;


(** [get_el64_symbol_type ent] extracts the symbol type from symbol table entry
  * [ent].
  *)
(*val get_elf64_symbol_type : elf64_symbol_table_entry -> natural*)
val _ = Define `
 (get_elf64_symbol_type syment=  (extract_symbol_type syment.elf64_st_info))`;


(** [get_el32_symbol_binding ent] extracts the symbol binding from symbol table entry
  * [ent].
  *)
(*val get_elf32_symbol_binding : elf32_symbol_table_entry -> natural*)
val _ = Define `
 (get_elf32_symbol_binding syment=  (extract_symbol_binding syment.elf32_st_info))`;


(** [get_el64_symbol_binding ent] extracts the symbol binding from symbol table entry
  * [ent].
  *)
(*val get_elf64_symbol_binding : elf64_symbol_table_entry -> natural*)
val _ = Define `
 (get_elf64_symbol_binding syment=  (extract_symbol_binding syment.elf64_st_info))`;

val _ = export_theory()

