(*Generated by Lem from elf_symbol_table.lem.*)
open Lem_basic_classes
open Lem_bool
open Lem_list
open Lem_maybe
open Lem_num
open Lem_string
open Lem_tuple

open Bitstring_local
open Error
open Missing_pervasives
open Show

open Elf_types
open Endianness
open String_table

(** Undefined symbol index *)

let stn_undef : int =( 0)

(** Symbol binding *)

let stb_local : int =( 0)
let stb_global : int =( 1)
let stb_weak : int =( 2)
let stb_loos : int =( 10)
let stb_hios : int =( 12)
let stb_loproc : int =( 13)
let stb_hiproc : int =( 15)

(*val string_of_symbol_binding : nat -> (nat -> string) -> (nat -> string) -> string*)
let string_of_symbol_binding m os proc =  
(if m = stb_local then
    "STB_LOCAL"
  else if m = stb_global then
    "STB_GLOBAL"
  else if m = stb_weak then
    "STB_WEAK"
  else if (m >= stb_loos) && (m <= stb_hios) then
    os m
  else if (m >= stb_loproc) && (m <= stb_hiproc) then
    proc m
  else
    "Invalid symbol binding")

(** Symbol types *)

let stt_notype : int =( 0)
let stt_object : int =( 1)
let stt_func : int =( 2)
let stt_section : int =( 3)
let stt_file : int =( 4)
let stt_common : int =( 5)
let stt_tls : int =( 6)
let stt_loos : int =( 10)
let stt_hios : int =( 12)
let stt_loproc : int =( 13)
let stt_hiproc : int =( 15)

(*val string_of_symbol_type : nat -> (nat -> string) -> (nat -> string) -> string*)
let string_of_symbol_type m os proc =  
(if m = stt_notype then
    "STT_NOTYPE"
  else if m = stt_object then
    "STT_OBJECT"
  else if m = stt_func then
    "STT_FUNC"
  else if m = stt_section then
    "STT_SECTION"
  else if m = stt_file then
    "STT_FILE"
  else if m = stt_common then
    "STT_COMMON"
  else if m = stt_tls then
    "STT_TLS"
  else if (m >= stt_loos) && (m <= stt_hios) then
    os m
  else if (m >= stt_loproc) && (m <= stt_hiproc) then
    proc m
  else
    "Invalid symbol type")

(** Symbol visibility *)

let stv_default : int =( 0)
let stv_internal : int =( 1)
let stv_hidden : int =( 2)
let stv_protected : int =( 3)

(*val string_of_symbol_visibility : nat -> string*)
let string_of_symbol_visibility m =  
(if m = stv_default then
    "STV_DEFAULT"
  else if m = stv_internal then
    "STV_INTERNAL"
  else if m = stv_hidden then
    "STV_HIDDEN"
  else if m = stv_protected then
    "STV_PROTECTED"
  else
    "Invalid symbol visibility")

(** ELF32 symbol table type *)

type elf32_symbol_table_entry =
  { elf32_st_name  : Uint32.t
   ; elf32_st_value : Uint32.t
   ; elf32_st_size  : Uint32.t
   ; elf32_st_info  : Uint32.t
   ; elf32_st_other : Uint32.t
   ; elf32_st_shndx : Uint32.t
   }

(** Extraction of symbol table data *)

(* Functions below common to 32- and 64-bit! *)

(*val get_symbol_binding : unsigned_char -> natural*)
let get_symbol_binding entry =  
(Ml_bindings.natural_of_unsigned_char (Uint32.shift_right entry( 4)))

(*val get_symbol_type : unsigned_char -> natural*)
let get_symbol_type entry =  
(Ml_bindings.natural_of_unsigned_char (Uint32.logand entry (Uint32.of_int32(Int32.of_int 15)))) (* 0xf *)

(*val get_symbol_info : unsigned_char -> unsigned_char -> natural*)
let get_symbol_info entry0 entry1 =  
(Ml_bindings.natural_of_unsigned_char (Uint32.add
    (Uint32.shift_left entry0( 4)) (Uint32.logand entry1
      (Uint32.of_int32(Int32.of_int 15))))) (*0xf*)  

(*val get_symbol_visibility : unsigned_char -> natural*)
let get_symbol_visibility entry =  
(Ml_bindings.natural_of_unsigned_char (Uint32.logand entry (Uint32.of_int32(Int32.of_int 3)))) (* 0x3*)

type symtab_print_bundle = (Big_int.big_int -> string) * (Big_int.big_int -> string)

(*val string_of_elf32_symbol_table_entry : elf32_symbol_table_entry -> string*)
let string_of_elf32_symbol_table_entry entry =  
(unlines [    
("\t" ^ ("Name: "  ^ Uint32.to_string entry.elf32_st_name))
  ; ("\t" ^ ("Value: " ^ Uint32.to_string entry.elf32_st_value))
  ; ("\t" ^ ("Size: "  ^ Uint32.to_string entry.elf32_st_size))
  ; ("\t" ^ ("Info: "  ^ Uint32.to_string entry.elf32_st_info))
  ; ("\t" ^ ("Other: " ^ Uint32.to_string entry.elf32_st_other))
  ; ("\t" ^ ("Shndx: " ^ Uint32.to_string entry.elf32_st_shndx))
  ])

type elf32_symbol_table = elf32_symbol_table_entry list

(*val string_of_elf32_symbol_table : elf32_symbol_table -> string*)
let string_of_elf32_symbol_table symtab =  
(unlines (List.map string_of_elf32_symbol_table_entry symtab))

type 'a hasElf32SymbolTable_class={
  get_elf32_symbol_table_method : 'a -> elf32_symbol_table
}

(*val read_elf32_symbol_table_entry : endianness -> bitstring -> error (elf32_symbol_table_entry * bitstring)*)
let read_elf32_symbol_table_entry endian bs0 =  
(Ml_bindings.read_elf32_word endian bs0 >>= (fun (st_name, bs0) ->
  Ml_bindings.read_elf32_addr endian bs0 >>= (fun (st_value, bs0) ->
  Ml_bindings.read_elf32_word endian bs0 >>= (fun (st_size, bs0) ->
  Ml_bindings.read_unsigned_char endian bs0 >>= (fun (st_info, bs0) ->
  Ml_bindings.read_unsigned_char endian bs0 >>= (fun (st_other, bs0) ->
  Ml_bindings.read_elf32_half endian bs0 >>= (fun (st_shndx, bs0) ->
    return ({ elf32_st_name = st_name; elf32_st_value = st_value;
                 elf32_st_size = st_size; elf32_st_info = st_info;
                 elf32_st_other = st_other; elf32_st_shndx = st_shndx }, bs0))))))))

(*val read_elf32_symbol_table : endianness -> bitstring -> error elf32_symbol_table*)
let rec read_elf32_symbol_table endian bs0 =  
(if Big_int.eq_big_int (Ml_bindings.bitstring_length bs0)(Big_int.big_int_of_int 0) then
    return []
  else
    read_elf32_symbol_table_entry endian bs0 >>= (fun (head, bs0) ->
    read_elf32_symbol_table endian bs0 >>= (fun tail ->
    return (head::tail))))

(** ELF64 symbol table type *)

type elf64_symbol_table_entry =
  { elf64_st_name  : Uint32.t
   ; elf64_st_info  : Uint32.t
   ; elf64_st_other : Uint32.t
   ; elf64_st_shndx : Uint32.t
   ; elf64_st_value : Uint64.t
   ; elf64_st_size  : Uint64.t
   }

(*val string_of_elf64_symbol_table_entry : elf64_symbol_table_entry -> string*)
let string_of_elf64_symbol_table_entry entry =  
(unlines [    
("\t" ^ ("Name: "  ^ Uint32.to_string entry.elf64_st_name))
  ; ("\t" ^ ("Info: "  ^ Uint32.to_string entry.elf64_st_info))
  ; ("\t" ^ ("Other: " ^ Uint32.to_string entry.elf64_st_other))
  ; ("\t" ^ ("Shndx: " ^ Uint32.to_string entry.elf64_st_shndx))
  ; ("\t" ^ ("Value: " ^ Uint64.to_string entry.elf64_st_value))
  ; ("\t" ^ ("Size: "  ^ Uint64.to_string entry.elf64_st_size))
  ])

type elf64_symbol_table = elf64_symbol_table_entry list

(*val string_of_elf64_symbol_table : elf64_symbol_table -> string*)
let string_of_elf64_symbol_table symtab =  
(unlines (List.map string_of_elf64_symbol_table_entry symtab))

type 'a hasElf64SymbolTable_class={
  get_elf64_symbol_table_method : 'a -> elf64_symbol_table
}

(*val read_elf64_symbol_table_entry : endianness -> bitstring -> error (elf64_symbol_table_entry * bitstring)*)
let read_elf64_symbol_table_entry endian bs0 =  
(Ml_bindings.read_elf64_word endian bs0 >>= (fun (st_name, bs0) ->
  Ml_bindings.read_unsigned_char endian bs0 >>= (fun (st_info, bs0) ->
  Ml_bindings.read_unsigned_char endian bs0 >>= (fun (st_other, bs0) ->
  Ml_bindings.read_elf64_half endian bs0 >>= (fun (st_shndx, bs0) ->
  Ml_bindings.read_elf64_addr endian bs0 >>= (fun (st_value, bs0) ->
  Ml_bindings.read_elf64_xword endian bs0 >>= (fun (st_size, bs0) ->
    return ({ elf64_st_name = st_name; elf64_st_info = st_info;
                 elf64_st_other = st_other; elf64_st_shndx = st_shndx;
                 elf64_st_value = st_value; elf64_st_size = st_size }, bs0))))))))

(*val read_elf64_symbol_table : endianness -> bitstring -> error elf64_symbol_table*)
let rec read_elf64_symbol_table endian bs0 =  
(if Big_int.eq_big_int (Ml_bindings.bitstring_length bs0)(Big_int.big_int_of_int 0) then
    return []
  else
    read_elf64_symbol_table_entry endian bs0 >>= (fun (head, bs0) ->
    read_elf64_symbol_table endian bs0 >>= (fun tail ->
    return (head::tail))))

(*val get_elf32_symbol_image_address : elf32_symbol_table -> string_table -> error (list (string * natural))*)
let get_elf32_symbol_image_address symtab strtab =  
(mapM (fun entry ->
    let name = (Ml_bindings.natural_of_elf32_word entry.elf32_st_name) in
    let addr = (Ml_bindings.natural_of_elf32_addr entry.elf32_st_value) in
      String_table.get_string_at name strtab >>= (fun str ->
      return (str, addr))
  ) symtab)

(*val get_elf64_symbol_image_address : elf64_symbol_table -> string_table -> error (list (string * natural))*)
let get_elf64_symbol_image_address symtab strtab =  
(mapM (fun entry ->
    let name = (Ml_bindings.natural_of_elf64_word entry.elf64_st_name) in
    let addr = (Ml_bindings.natural_of_elf64_addr entry.elf64_st_value) in
      String_table.get_string_at name strtab >>= (fun str ->
      return (str, addr))
  ) symtab)