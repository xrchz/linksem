(*Generated by Lem from string_table.lem.*)
open HolKernel Parse boolLib bossLib;
open lem_numTheory lem_listTheory lem_basic_classesTheory lem_maybeTheory lem_stringTheory showTheory missing_pervasivesTheory errorTheory byte_sequenceTheory;

val _ = numLib.prefer_num();



val _ = new_theory "string_table"

(** The [string_table] module implements string tables.  An ELF file may have
  * multiple different string tables used for different purposes.  A string
  * table is a string coupled with a delimiting character.  Strings may be indexed
  * at any position, not necessarily on a delimiter boundary.
  *)

(*open import Basic_classes*)
(*open import List*)
(*open import Maybe*)
(*open import Num*)
(*open import String*)
(*open import Byte_sequence*)

(*open import Error*)
(*open import Missing_pervasives*)
(*open import Show*)

(** [string_table] type, represents a string table with a fixed delimiting
  * character and underlying string.
  *)
val _ = Hol_datatype `
 string_table
  = Strings of (char # string)`;


(** [mk_string_table base sep] constructs a string table using [base] as the
  * base string and [sep] as the delimiting character to use to split [base]
  * when trying to access the string stored in the table using the functions below.
  *)
(*val mk_string_table : string -> char -> string_table*)
val _ = Define `
 (mk_string_table base sep =  
(Strings (sep, base)))`;


(** [string_table_of_byte_sequence seq] constructs a string table, using the NUL
  * character as terminator, from a byte sequence. *)
(*val string_table_of_byte_sequence : byte_sequence -> string_table*)
val _ = Define `
 (string_table_of_byte_sequence seq = (mk_string_table (string_of_byte_sequence seq) (CHR 0)))`;


(** [empty] is the empty string table with an arbitrary choice of delimiter.
  *)
(*val empty : string_table*)
val _ = Define `
 (empty0 = (Strings ((CHR 0), "")))`;


(** [get_delimiating_character tbl] returns the delimiting character associated
  * with the string table [tbl], used to split the strings.
  *)
(*val get_delimiting_character : string_table -> char*)
val _ = Define `
 (get_delimiting_character tbl =  
((case tbl of
      Strings (sep, base) => sep
  )))`;


(** [get_base_string tbl] returns the base string of the string table [tbl].
  *)
(*val get_base_string : string_table -> string*)
val _ = Define `
 (get_base_string tbl =  
((case tbl of
      Strings (sep, base) => base
  )))`;


(** [concat xs] concatenates several string tables into one providing they all
  * have the same delimiting character.
  *)
(*val concat : list string_table -> error string_table*)
val _ = Define `
 (concat1 xs =  
((case xs of
      []    => return empty0
    | x  ::  xs =>
      let delim = (get_delimiting_character x) in
        if (EVERY (\ x .  get_delimiting_character x = delim) (x::xs)) then
          let base = (FOLDR STRCAT "" (MAP get_base_string (x::xs))) in
            return (mk_string_table base delim)
        else
          fail0 "concat: string tables must have same delimiting characters"
  )))`;


(** [get_string_at index tbl] returns the string starting at character [index]
  * from the start of the base string until the first occurrence of the delimiting
  * character.
  *)
(*val get_string_at : natural -> string_table -> error string*)
val _ = Define `
 (get_string_at index tbl =  
((case ARB index (get_base_string tbl) of
      NONE     => Fail "get_string_at: index out of range"
    | SOME suffix =>
      let delim = (get_delimiting_character tbl) in
      (case string_index_of delim suffix of
          SOME idx =>
          (case string_prefix idx suffix of
              SOME s  => Success s
            | NONE => Fail "get_string_at: index out of range"
          )
        | NONE => Success suffix
      )
  )))`;


(*val find_string : string -> string_table -> maybe natural*)
val _ = Define `
 (find_string s t =    
 ((case t of
        Strings(delim, base) => ARB ( STRCAT s (IMPLODE [delim])) base
    )))`;


(*val insert_string : string -> string_table -> (natural * string_table)*)
val _ = Define `
 (insert_string s t =    
 ((case find_string s t of
        NONE => (case t of
            Strings(delim, base) => (( 1 +  (STRLEN base)), Strings(delim,  STRCAT base  (STRCAT(IMPLODE [delim]) s)))
            )
        | SOME pos => (pos, t)
    )))`;

val _ = export_theory()

