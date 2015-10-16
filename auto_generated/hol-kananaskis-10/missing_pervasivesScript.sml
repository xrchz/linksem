(*Generated by Lem from missing_pervasives.lem.*)
open HolKernel Parse boolLib bossLib;
open lem_numTheory lem_listTheory lem_basic_classesTheory lem_boolTheory lem_maybeTheory lem_stringTheory lem_assert_extraTheory showTheory lem_sortingTheory;

val _ = numLib.prefer_num();



val _ = new_theory "missing_pervasives"

(*open import Basic_classes*)
(*open import Bool*)
(*open import List*)
(*open import Maybe*)
(*open import Num*)
(*open import String*)
(*open import Assert_extra*)
(*open import Show*)
(*open import Sorting*)

(*open import {isabelle} `$ISABELLE_HOME/src/HOL/Word/Word`*)
(*open import {isabelle} `Elf_Types_Local`*)

(*val naturalZero : natural*)
val _ = Define `
 (naturalZero =( 0))`;


(*val id : forall 'a. 'a -> 'a*)
val _ = Define `
 (id x = x)`;


(*type byte*)
(*val natural_of_byte : byte -> natural*)

val _ = Define `
 (compare_byte b1 b2 = (genericCompare (<) (=) (w2n b1) (w2n b2)))`;


val _ = Define `
(instance_Basic_classes_Ord_Missing_pervasives_byte_dict =(<|

  compare_method := compare_byte;

  isLess_method := (\ f1 .  (\ f2 .  (compare_byte f1 f2 = LT)));

  isLessEqual_method := (\ f1 .  (\ f2 .  let result = (compare_byte f1 f2) in (result = LT) \/ (result = EQ)));

  isGreater_method := (\ f1 .  (\ f2 .  (compare_byte f1 f2 = GT)));

  isGreaterEqual_method := (\ f1 .  (\ f2 .  let result = (compare_byte f1 f2) in (result = GT) \/ (result =  EQ)))|>))`;


(*val char_of_byte : byte -> char*)

(* Define how to print a byte in hex *)
(*val hex_char_of_nibble : natural -> char*)
val _ = Define `
 (hex_char_of_nibble n =  
(if n = 0 then
    #"0"
  else if n = 1 then
    #"1"
  else if n = 2 then
    #"2"
  else if n = 3 then
    #"3"
  else if n = 4 then
    #"4"
  else if n = 5 then
    #"5"
  else if n = 6 then
    #"6"
  else if n = 7 then
    #"7"
  else if n = 8 then
    #"8"
  else if n = 9 then
    #"9"
  else if n = 10 then
    #"a"
  else if n = 11 then
    #"b"
  else if n = 12 then
    #"c"
  else if n = 13 then
    #"d"
  else if n = 14 then
    #"e"
  else if n = 15 then
    #"f"
   else
     fail))`;


val _ = Define `
 (hex_string_of_byte b =    
 (IMPLODE [ hex_char_of_nibble ((w2n b) DIV  16)
             ; hex_char_of_nibble ((w2n b) MOD  16)]))`;


(*val natural_of_decimal_digit : char -> maybe natural*)
val _ = Define `
 (natural_of_decimal_digit c =  
(if c = #"0" then
    SOME( 0)
  else if c = #"1" then
    SOME( 1)
  else if c = #"2" then
    SOME( 2)
  else if c = #"3" then
    SOME( 3)
  else if c = #"4" then
    SOME( 4)
  else if c = #"5" then
    SOME( 5)
  else if c = #"6" then
    SOME( 6)
  else if c = #"7" then
    SOME( 7)
  else if c = #"8" then
    SOME( 8)
  else if c = #"9" then
    SOME( 9)
  else
    NONE))`;


(*val natural_of_decimal_string_helper : natural -> list char -> natural*)
 val natural_of_decimal_string_helper_defn = Hol_defn "natural_of_decimal_string_helper" `
 (natural_of_decimal_string_helper acc chars =    
((case chars of 
        [] => acc
        | c  ::  cs => (case natural_of_decimal_digit c of
            SOME dig => natural_of_decimal_string_helper (( 10 * acc) + dig) cs
            | NONE => acc
        )
    )))`;

val _ = Lib.with_flag (computeLib.auto_import_definitions, false) Defn.save_defn natural_of_decimal_string_helper_defn;

(*val natural_of_decimal_string : string -> natural*)
val _ = Define `
 (natural_of_decimal_string s =    
 (natural_of_decimal_string_helper( 0) (EXPLODE s)))`;


(*val hex_string_of_natural : natural -> string*)
 val hex_string_of_natural_defn = Hol_defn "hex_string_of_natural" `
 (hex_string_of_natural n =    
 (if n < 16 then IMPLODE [hex_char_of_nibble n]
    else  STRCAT(hex_string_of_natural (n DIV  16)) (IMPLODE [hex_char_of_nibble (n MOD  16)])))`;

val _ = Lib.with_flag (computeLib.auto_import_definitions, false) Defn.save_defn hex_string_of_natural_defn;

(*val natural_of_bool : bool -> natural*)
val _ = Define `
 (natural_of_bool b =  
((case b of
      T  => 1
    | F => 0
  )))`;


(*val unsafe_nat_of_natural : natural -> nat*)

(*val unsafe_int_of_natural   : natural -> int*)

(*val byte_of_natural : natural -> byte*)

(*val natural_ordering : natural -> natural -> ordering*)
val _ = Define `
 (natural_ordering left right =  
(if left = right then
    EQ
  else if left < right then
    LT
  else
    GT))`;


(*val merge_by : forall 'a. ('a -> 'a -> ordering) -> list 'a -> list 'a -> list 'a*)
 val merge_by_defn = Hol_defn "merge_by" `
 (merge_by comp xs ys =  
((case (xs, ys) of
      ([], ys)      => ys
    | (xs, [])     => xs
    | (x  ::  xs, y  ::  ys) =>
      if comp x y = LT then
        x::(merge_by comp xs (y::ys))
      else
        y::(merge_by comp (x::xs) ys)
  )))`;

val _ = Lib.with_flag (computeLib.auto_import_definitions, false) Defn.save_defn merge_by_defn;

(*val sort_by : forall 'a. ('a -> 'a -> ordering) -> list 'a -> list 'a*)
 val sort_by_defn = Hol_defn "sort_by" `
 (sort_by comp xs =  
((case xs of
      [] => []
    | [x] => [x]
    | xs =>
      let ls = (TAKE (LENGTH xs DIV  2) xs) in
      let rs = (DROP (LENGTH xs DIV  2) xs) in
        merge_by comp (sort_by comp ls) (sort_by comp rs)
  )))`;

val _ = Lib.with_flag (computeLib.auto_import_definitions, false) Defn.save_defn sort_by_defn;

(** [mapMaybei f xs] maps a function expecting an index (the position in the list
  * [xs] that it is currently viewing) and producing a [maybe] type across a list.
  * Elements that produce [Nothing] under [f] are discarded in the output, whilst
  * those producing [Just e] for some [e] are kept.
  *)
(*val mapMaybei' : forall 'a 'b. (natural -> 'a -> maybe 'b) -> natural -> list 'a -> list 'b*)
 val mapMaybei'_defn = Hol_defn "mapMaybei'" `
 (mapMaybei' f idx xs =  
((case xs of
    []    => []
  | x  ::  xs =>
      (case f idx x of
        NONE => mapMaybei' f ( 1 + idx) xs
      | SOME e  => e :: mapMaybei' f ( 1 + idx) xs
      )
  )))`;

val _ = Lib.with_flag (computeLib.auto_import_definitions, false) Defn.save_defn mapMaybei'_defn;

(*val mapMaybei : forall 'a 'b. (natural -> 'a -> maybe 'b) -> list 'a -> list 'b*)
    
val _ = Define `
 (mapMaybei f xs =  
(mapMaybei' f( 0) xs))`;


(** [partitionii is xs] returns a pair of lists: firstly those elements in [xs] that are
    at indices in [is], and secondly the remaining elements. 
    It preserves the order of elements in xs. *)
(*val partitionii' : forall 'a. natural -> list natural -> list 'a 
    -> list (natural * 'a) (* accumulates the 'in' partition *)
    -> list (natural * 'a) (* accumulates the 'out' partition *)
    -> (list (natural * 'a) * list (natural * 'a))*)
 val partitionii'_defn = Hol_defn "partitionii'" `
 (partitionii' (offset : num) sorted_is xs reverse_accum reverse_accum_compl =    
( 
    (* offset o means "xs begins at index o, as reckoned by the indices in sorted_is" *)(case sorted_is of
        [] => (REVERSE reverse_accum, REVERSE reverse_accum_compl)
        | i  ::  more_is => 
            let (length_to_split_off : num) = ( (i - offset))
            in
            let (left, right) = (TAKE length_to_split_off xs, DROP length_to_split_off xs) in
            let left_indices : num list = (GENLIST 
                (\ j .  ( j) + offset)
                (LENGTH left)) 
            in
            let left_with_indices = (list_combine left_indices left) in
            (* left begins at offset, right begins at offset + i *)
            (case right of 
                [] => (* We got to the end of the list before the target index. *) 
                    (REVERSE reverse_accum, 
                     REV reverse_accum_compl left_with_indices)
                | x  ::  more_xs => 
                    (* x is at index i by definition, so more_xs starts with index i + 1 *)
                    partitionii' (i+ 1) more_is more_xs ((i, x) :: reverse_accum) 
                        (REV left_with_indices reverse_accum_compl)
            )
    )))`;

val _ = Lib.with_flag (computeLib.auto_import_definitions, false) Defn.save_defn partitionii'_defn;

(*val filteri : forall 'a. list natural -> list 'a -> list 'a*)
val _ = Define `
 (filteri is xs =    
 (let sorted_is = (QSORT (<=) is) in
    let (accum, accum_compl) = (partitionii'( 0) sorted_is xs [] [])
    in 
    let (just_indices, just_items) = (UNZIP accum)
    in 
    just_items))`;


(*val filterii : forall 'a. list natural -> list 'a -> list (natural * 'a)*)
val _ = Define `
 (filterii is xs =    
 (let sorted_is = (QSORT (<=) is) in
    let (accum, accum_compl) = (partitionii'( 0) sorted_is xs [] [])
    in 
    accum))`;


(*val partitioni : forall 'a. list natural -> list 'a -> (list 'a * list 'a)*)
val _ = Define `
 (partitioni is xs =    
 (let sorted_is = (QSORT (<=) is) in
    let (accum, accum_compl) = (partitionii'( 0) sorted_is xs [] [])
    in
    let (just_indices, just_items) = (UNZIP accum)
    in
    let (just_indices_compl, just_items_compl) = (UNZIP accum_compl)
    in
    (just_items, just_items_compl)))`;


(*val partitionii : forall 'a. list natural -> list 'a -> (list (natural * 'a) * list (natural * 'a))*)
val _ = Define `
 (partitionii is xs =    
 (let sorted_is = (QSORT (<=) is) in
    partitionii'( 0) sorted_is xs [] []))`;


(** [unzip3 ls] takes a list of triples and returns a triple of lists. *)
(*val unzip3: forall 'a 'b 'c. list ('a * 'b * 'c) -> (list 'a * list 'b * list 'c)*)
 val _ = Define `
 (unzip3 l = ((case l of
    [] => ([], [], [])
  | (x, y, z)  ::  xyzs => let (xs, ys, zs) = (unzip3 xyzs) in ((x :: xs), (y :: ys), (z :: zs))
)))`;


(** [null_byte] is the null character a a byte. *)
(*val null_byte : byte*)

(** [null_char] is the null character. *)
(*val null_char : char*)

(** [println s] prints [s] to stdout, adding a trailing newline. *)
(* val println : string -> unit *)
(* declare ocaml target_rep function println = `print_endline` *)

(** [prints s] prints [s] to stdout, without adding a trailing newline. *)
(* val prints : string -> unit *)
(* declare ocaml target_rep function prints = `print_string` *)

(** [errln s] prints [s] to stderr, adding a trailing newline. *)
(*val errln : string -> unit*)

(** [errs s] prints [s] to stderr, without adding a trailing newline. *)
(*val errs : string -> unit*)

(** [outln s] prints [s] to stdout, adding a trailing newline. *)
(*val outln : string -> unit*)

(** [outs s] prints [s] to stdout, without adding a trailing newline. *)
(*val outs : string -> unit*)

(** [intercalate sep xs] places [sep] between all elements of [xs].
  * Made tail recursive and unrolled slightly to improve performance on large
  * lists.*)
(*val intercalate' : forall 'a. 'a -> list 'a -> list 'a -> list 'a*)
 val intercalate'_defn = Hol_defn "intercalate'" `
 (intercalate' sep xs accum =	
((case xs of
		  []       => REVERSE accum
		| [x]      => REVERSE accum ++ [x]
		| [x; y]   => REVERSE accum ++ [x; sep; y]
		| x  ::  y  ::  xs => intercalate' sep xs (sep::(y::(sep::(x::accum))))
	)))`;

val _ = Lib.with_flag (computeLib.auto_import_definitions, false) Defn.save_defn intercalate'_defn;
	
(*val intercalate : forall 'a. 'a -> list 'a -> list 'a*)
val _ = Define `
 (intercalate sep xs = (intercalate' sep xs []))`;


(** [unlines xs] concatenates a list of strings [xs], placing each entry
  * on a new line.
  *)
(*val unlines : list string -> string*)
val _ = Define `
 (unlines xs =  
(FOLDL STRCAT "" (intercalate "\n" xs)))`;


(** [bracket xs] concatenates a list of strings [xs], separating each entry with a
  * space, and bracketing the resulting string.
  *)
(*val bracket : list string -> string*)
val _ = Define `
 (bracket xs =   
(STRCAT"("  (STRCAT(FOLDL STRCAT "" (intercalate " " xs)) ")")))`;

	
(** [string_of_list l] produces a string representation of list [l].
  *)
(*val string_of_list : forall 'a. Show 'a => list 'a -> string*)

(** [split_string_on_char s c] splits a string [s] into a list of substrings
  * on character [c], otherwise returning the singleton list containing [s]
  * if [c] is not found in [s].
  * 
  * NOTE: quirkily, this doesn't discard separators (e.g. because NUL characters 
  * are significant when indexing into string tables). FIXME: given this, is this 
  * function really reusable? I suspect not.
  *)
(*val split_string_on_char : string -> char -> list string*)

(* [find_substring sub s] returns the index at which *)
(*val find_substring : string -> string -> maybe natural*)

(** [string_of_nat m] produces a string representation of natural number [m]. *)
(*val string_of_nat : nat -> string*)

(** [string_suffix i s] returns all but the first [i] characters of [s].
  * Fails if the index is negative, or beyond the end of the string.
  *)
(*val string_suffix : natural -> string -> maybe string*) (* XXX: add custom binding *)
  
(*val nat_length : forall 'a. list 'a -> nat*)
  
(*val length : forall 'a. list 'a -> natural*)
val _ = Define `
 (length xs = (FOLDL (\y x .  
  (case (y ,x ) of ( y , _ ) => 1 + y ))( 0) xs))`;


(** [take cnt xs] takes the first [cnt] elements of list [xs].  Returns a truncation
  * if [cnt] is greater than the length of [xs].
  *)
(*val take : forall 'a. natural -> list 'a -> list 'a*)
 val take_defn = Hol_defn "take" `
 (take m xs =  
((case xs of
      []    => []
    | x  ::  xs =>
      if m = 0 then
        []
      else
        x::take (m -  1) xs
  )))`;

val _ = Lib.with_flag (computeLib.auto_import_definitions, false) Defn.save_defn take_defn;
  
(** [string_prefix i s] returns the first [i] characters of [s].
  * Fails if the index is negative, or beyond the end of the string.
  *)
(*val string_prefix : natural -> string -> maybe string*)
val _ = Define `
 (string_prefix m s =  
(let cs = (EXPLODE s) in
    if m > length cs then
      NONE
    else
      SOME (IMPLODE (take m cs))))`;

(* FIXME: isabelle *)

(** [string_index_of c s] returns [Just(i)] where [i] is the index of the first 
  * occurrence if [c] in [s], if it exists, otherwise returns [Nothing]. *)
(*val string_index_of' : char -> list char -> natural -> maybe natural*)
 val string_index_of'_defn = Hol_defn "string_index_of'" `
 (string_index_of' e ss idx =  
((case ss of
      []    => NONE
    | s  ::  ss =>
      if s = e then
        SOME idx
      else
        string_index_of' e ss ( 1 + idx)
  )))`;

val _ = Lib.with_flag (computeLib.auto_import_definitions, false) Defn.save_defn string_index_of'_defn;
  
(*val string_index_of : char -> string -> maybe natural*)
val _ = Define `
 (string_index_of e s = (string_index_of' e (EXPLODE s)( 0)))`;


(*val index : forall 'a. natural -> list 'a -> maybe 'a*)
 val index_defn = Hol_defn "index" `
 (index m xs =  
((case xs of
      []    => NONE
    | x  ::  xs =>
        if m = 0 then
          SOME x
        else
          index (m -  1) xs
  )))`;

val _ = Lib.with_flag (computeLib.auto_import_definitions, false) Defn.save_defn index_defn;

(*val find_index_helper : forall 'a. natural -> ('a -> bool) -> list 'a -> maybe natural*)
 val find_index_helper_defn = Hol_defn "find_index_helper" `
 (find_index_helper count1 p xs =	
((case xs of
		  []    => NONE
		| y  ::  ys =>
			if p y then
				SOME count1
			else
				find_index_helper (count1 + 1) p ys
	)))`;

val _ = Lib.with_flag (computeLib.auto_import_definitions, false) Defn.save_defn find_index_helper_defn;

(*val find_index : forall 'a. ('a -> bool) -> list 'a -> maybe natural*)
val _ = Define `
 (find_index0 p xs = (find_index_helper( 0) p xs))`;


(*val argv : list string*)

(*val replicate_revacc : forall 'a. list 'a -> natural -> 'a -> list 'a*)
 val replicate_revacc_defn = Hol_defn "replicate_revacc" `
 (replicate_revacc revacc len e =	
((case len of
		  0 => REVERSE revacc
		| m => replicate_revacc (e :: revacc) (m -  1) e
	)))`;

val _ = Lib.with_flag (computeLib.auto_import_definitions, false) Defn.save_defn replicate_revacc_defn;

(*val replicate : forall 'a. natural -> 'a -> list 'a*)
 val _ = Define `
 (replicate len e =	
(replicate_revacc [] len e))`;


(* We want a tail-recursive append. reverse_append l1 l2 appends l2 to the
 * reverse of l1. So we get [l1-backwards] [l2]. So just reverse l1. *)
(*val list_append : forall 'a. list 'a -> list 'a -> list 'a*)
val _ = Define `
 (list_append l1 l2 =    
(REV (REVERSE l1) l2))`;


(*val list_concat : forall 'a. list (list 'a) -> list 'a*) 
val _ = Define `
 (list_concat ll = (FOLDL list_append [] ll))`;


(*val list_concat_map : forall 'a 'b. ('a -> list 'b) -> list 'a -> list 'b*)
val _ = Define `
 (list_concat_map f l =    
 (list_concat (MAP f l)))`;


(*val list_reverse_concat_map_helper : forall 'a 'b. ('a -> list 'b) -> list 'b -> list 'a -> list 'b*)
 val list_reverse_concat_map_helper_defn = Hol_defn "list_reverse_concat_map_helper" `
 (list_reverse_concat_map_helper f acc ll =    
 (let lcons = (\ l .  (\ i .  i :: l))
    in
    (case ll of
        []      => acc
      | item  ::  items => 
            (* item is a thing that maps to a list. it needn't be a list yet *)
            let mapped_list = (f item)
            in 
            (* let _ = Missing_pervasives.errln ("Map function gave us a list of " ^ (show (List.length mapped_list)) ^ " items") in *)
            list_reverse_concat_map_helper f (FOLDL lcons acc (f item)) items
    )))`;

val _ = Lib.with_flag (computeLib.auto_import_definitions, false) Defn.save_defn list_reverse_concat_map_helper_defn;

(*val list_reverse_concat_map : forall 'a 'b. ('a -> list 'b) -> list 'a -> list 'b*)
val _ = Define `
 (list_reverse_concat_map f ll = (list_reverse_concat_map_helper f [] ll))`;


(*val list_take_with_accum : forall 'a. nat -> list 'a -> list 'a -> list 'a*)
 val list_take_with_accum_defn = Hol_defn "list_take_with_accum" `
 (list_take_with_accum n reverse_acc l =   
(
  (*  let _ = Missing_pervasives.errs ("Taking a byte; have accumulated " ^ (show (List.length acc) ^ " so far\n"))
   in *)(case n of
        0 => REVERSE reverse_acc
      | _ => (case l of
            [] => failwith "list_take_with_accum: not enough elements"
            | x  ::  xs => list_take_with_accum (n -  1) (x :: reverse_acc) xs
        )
    )))`;

val _ = Lib.with_flag (computeLib.auto_import_definitions, false) Defn.save_defn list_take_with_accum_defn;

(*val unsafe_string_take : natural -> string -> string*)
val _ = Define `
 (unsafe_string_take m str =  
(let m = (id m) in
    IMPLODE (TAKE m (EXPLODE str))))`;


(** [padding_and_maybe_newline c w s] creates enough of char [c] to pad string [s] to [w] characters, 
  * unless [s] is of length [w - 1] or greater, in which case it generates [w] copies preceded by a newline.
  * This style of formatting is used by the GNU linker in its link map output, so we
  * reproduce it using this function. Note that string [s] does not appear in the
  * output. *)
(*val padding_and_maybe_newline : char -> natural -> string -> string*)
val _ = Define `
 (padding_and_maybe_newline c width str =    
 (let padlen = (width - ( (STRLEN str))) in
    
     STRCAT(if padlen <= 1 then "\n" else "") (IMPLODE (replicate (if padlen <= 1 then width else padlen) c))))`;


(** [space_padding_and_maybe_newline w s] creates enoughspaces to pad string [s] to [w] characters, 
  * unless [s] is of length [w - 1] or greater, in which case it generates [w] copies preceded by a newline.
  * This style of formatting is used by the GNU linker in its link map output, so we
  * reproduce it using this function. Note that string [s] does not appear in the
  * output. *)
(*val space_padding_and_maybe_newline : natural -> string -> string*)
val _ = Define `
 (space_padding_and_maybe_newline width str =    
 (padding_and_maybe_newline #" " width str))`;


(** [padded_and_maybe_newline w s] pads string [s] to [w] characters, using char [c]
  * unless [s] is of length [w - 1] or greater, in which case the padding consists of
  * [w] copies of [c] preceded by a newline.
  * This style of formatting is used by the GNU linker in its link map output, so we
  * reproduce it using this function. *)
(*val padded_and_maybe_newline : char -> natural -> string -> string*)
val _ = Define `
 (padded_and_maybe_newline c width str =     
 (STRCAT str (padding_and_maybe_newline c width str)))`;


(** [padding_to c w s] creates enough copies of [c] to pad string [s] to [w] characters, 
  * or 0 characters if [s] is of length [w] or greater. Note that string [s] does not appear in the
  * output. *)
(*val padding_to : char -> natural -> string -> string*)
val _ = Define `
 (padding_to c width str =    
 (let padlen = (width - ( (STRLEN str))) in
    if padlen <= 0 then "" else (IMPLODE (replicate padlen c))))`;


(** [left_padded_to c w s] left-pads string [s] to [w] characters using [c], 
  * returning it unchanged if [s] is of length [w] or greater. *)
(*val left_padded_to : char -> natural -> string -> string*)
val _ = Define `
 (left_padded_to c width str =     
 (STRCAT(padding_to c width str) str))`;

    
(** [right_padded_to c w s] right-pads string [s] to [w] characters using [c], 
  * returning it unchanged if [s] is of length [w] or greater. *)
(*val right_padded_to : char -> natural -> string -> string*)
val _ = Define `
 (right_padded_to c width str =     
 (STRCAT str (padding_to c width str)))`;


(** [space_padded_and_maybe_newline w s] pads string [s] to [w] characters, using spaces,
  * unless [s] is of length [w - 1] or greater, in which case the padding consists of
  * [w] spaces preceded by a newline.
  * This style of formatting is used by the GNU linker in its link map output, so we
  * reproduce it using this function. *)
(*val space_padded_and_maybe_newline : natural -> string -> string*)
val _ = Define `
 (space_padded_and_maybe_newline width str =     
 (STRCAT str (padding_and_maybe_newline #" " width str)))`;


(** [left_space_padded_to w s] left-pads string [s] to [w] characters using spaces, 
  * returning it unchanged if [s] is of length [w] or greater. *)
(*val left_space_padded_to : natural -> string -> string*)
val _ = Define `
 (left_space_padded_to width str =     
 (STRCAT(padding_to #" " width str) str))`;

    
(** [right_space_padded_to w s] right-pads string [s] to [w] characters using spaces, 
  * returning it unchanged if [s] is of length [w] or greater. *)
(*val right_space_padded_to : natural -> string -> string*)
val _ = Define `
 (right_space_padded_to width str =     
 (STRCAT str (padding_to #" " width str)))`;


(** [left_zero_padded_to w s] left-pads string [s] to [w] characters using zeroes, 
  * returning it unchanged if [s] is of length [w] or greater. *)
(*val left_zero_padded_to : natural -> string -> string*)
val _ = Define `
 (left_zero_padded_to width str =     
 (STRCAT(padding_to #"0" width str) str))`;

 
val _ = export_theory()

