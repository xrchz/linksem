(*Generated by Lem from memory_image.lem.*)
open HolKernel Parse boolLib bossLib;
open lem_numTheory lem_listTheory lem_setTheory lem_functionTheory lem_basic_classesTheory lem_boolTheory lem_maybeTheory lem_stringTheory lem_assert_extraTheory showTheory lem_sortingTheory lem_set_extraTheory missing_pervasivesTheory byte_sequenceTheory elf_types_native_uintTheory lem_tupleTheory elf_headerTheory lem_mapTheory elf_program_header_tableTheory elf_section_header_tableTheory elf_interpreted_sectionTheory elf_interpreted_segmentTheory elf_symbol_tableTheory elf_fileTheory elf_relocationTheory multimapTheory;

val _ = numLib.prefer_num();



val _ = new_theory "memory_image"

(*open import Basic_classes*)
(*open import Function*)
(*open import String*)
(*open import Tuple*)
(*open import Bool*)
(*open import List*)
(*open import Sorting*)
(*open import Map*)
(*open import Set*)
(*open import Set_extra*)
(*open import Multimap*)
(*open import Num*)
(*open import Maybe*)
(*open import Assert_extra*)
(*open import Show*)

(*open import Byte_sequence*)
(*open import Elf_file*)
(*open import Elf_header*)
(*open import Elf_interpreted_segment*)
(*open import Elf_interpreted_section*)
(*open import Elf_program_header_table*)
(*open import Elf_section_header_table*)
(*open import Elf_symbol_table*)
(*open import Elf_types_native_uint*)
(*open import Elf_relocation*)

(*open import Missing_pervasives*)

(* Now we can define memory images *)

val _ = type_abbrev( "byte_pattern_element" , ``:  word8 option``);
val _ = type_abbrev( "byte_pattern" , ``: byte_pattern_element list``);

(* An element might have an address/offset, and it has some contents. *)
val _ = Hol_datatype `
 memory_image_element = <| startpos :  num option 
                             ; length1   :  num option
                             ; contents : byte_pattern
                             |>`;


(* HMM -- ideally I want to fold these into the memory image notion
 * and the startpos thingy. *)
val _ = type_abbrev( "allocated_symbols_map" , ``: (string, (num # num)) fmap``); (* start, length *)

(* Instead of modelling address calculations (in linker scripts) like so:

type address_expr = natural -> allocated_symbols_map -> natural
                  ( pos     -> environment           -> result address )
                  
   ... we model it as expressions in terms of CursorPosition. HMM.
*) 

val _ = Hol_datatype `
 expr_operand = Var of string
                   | CursorPosition          (* only valid in certain expressions... HMM *)
                   | Constant of num
                   | UnOp of (expr_unary_operation # expr_operand)
                   | BinOp of (expr_binary_operation # expr_operand # expr_operand)
;
expr_unary_operation = Neg of expr_operand
                           | BitwiseInverse of expr_operand
; 
expr_binary_operation = Add of (expr_operand # expr_operand)
                           | Sub of (expr_operand # expr_operand)
                           | BitwiseAnd of (expr_operand # expr_operand)
                           | BitwiseOr of (expr_operand # expr_operand)`;


val _ = Hol_datatype `
 expr_binary_relation = 
    Lt
    | Lte
    | Gt
    | Gte
    | Eq
    | Neq`;


val _ = Hol_datatype `
 expr = 
    False
    | True
    | Not of expr
    | And of (expr # expr)
    | Or of (expr # expr)
    | BinRel of (expr_binary_relation # expr_operand)`;
  (* LH operand is the expr's value *)

(*
val cond_expr : expr -> expr -> expr -> expr
let cond_expr expr1 expr2 expr3 = (Or((And(expr1, expr2)), (And((Not(expr1)), expr3))))
*)

(* Memory image elements all have identities. For convenience
 * we make the identities strings. The string contents are arbitrary,
 * and only their equality is relevant, but choosing friendly names
 * like "ELF header" is good practice.*)
val _ = type_abbrev( "memory_image" , ``: (string, memory_image_element) fmap``);
(* An "element" of an ELF image, in the linking phase, is either a section,
 * the ELF header, the section header table or the program header table.
 * 
 * PROBLEM: We'd like to use section names as the identifiers
 * for those elements that are sections.
 * but we can't, because they are not guaranteed to be unique. 
 * 
 * SOLUTION: Names that are unique in the file are used as keys. 
 * If not unique, the sections are treated as anonymous and given
 * gensym'd string ids (FIXME: implement this).
 *)

(* Currently, our elements have unique names, which are strings.
 * We *don't* want to encode any meaning onto these strings.
 * All meaning should be encoded into labelled ranges.
 * We want to be able to look up 
 *
 * - elements
 * - ranges within elements
 * 
 * ... by their *labels* -- or sometimes just *part* of their labels.
 *)

(* ELF file features with which we can label ranges of the memory image. *)
val _ = Hol_datatype `
 elf_file_feature = 
    ElfHeader of elf64_header
    | ElfSectionHeaderTable of elf64_section_header_table (* do we want to expand these? *)
    | ElfProgramHeaderTable of elf64_program_header_table
    | ElfSection of (num # elf64_interpreted_section) (* SHT idx *)
    | ElfSegment of (num # elf64_interpreted_segment)`;
 (* PHT idx *)

val _ = Hol_datatype `
 symbol_reference
 = <| ref_symname : string                  (* symbol name *)
    ; ref_syment : elf64_symbol_table_entry (* likely-undefined (referencing) symbol *)
    ; ref_sym_scn : num                 (* symtab section idx *) 
    ; ref_sym_idx : num                 (* index into symbol table *)
    |>`;


val _ = Define `
 (symRefCompare x1 x2 =        
(quadrupleCompare (\ x y. EQ) elf64_symbol_table_entry_compare (genericCompare (<) (=)) (genericCompare (<) (=)) (x1.ref_symname, x1.ref_syment, x1.ref_sym_scn, x1.ref_sym_idx)
                (x2.ref_symname, x2.ref_syment, x2.ref_sym_scn, x2.ref_sym_idx)))`;

                
val _ = Define `
(instance_Basic_classes_Ord_Memory_image_symbol_reference_dict =(<|

  compare_method := symRefCompare;

  isLess_method := (\ f1 .  (\ f2 .  (symRefCompare f1 f2 = LT)));

  isLessEqual_method := (\ f1 .  (\ f2 .  (IN) (symRefCompare f1 f2) ({LT; EQ})));

  isGreater_method := (\ f1 .  (\ f2 .  (symRefCompare f1 f2 = GT)));

  isGreaterEqual_method := (\ f1 .  (\ f2 .  (IN) (symRefCompare f1 f2) ({GT; EQ})))|>))`;


val _ = Hol_datatype `
 reloc_site = <|
      ref_relent  : elf64_relocation_a 
    ; ref_rel_scn : num  (* the relocation section idx *)
    ; ref_rel_idx : num  (* the index of the relocation rec *)
    ; ref_src_scn : num  (* the section *from which* the reference logically comes *)
|>`;


val _ = Define `
 (relocSiteCompare x1 x2 =        
(tripleCompare elf64_relocation_a_compare (genericCompare (<) (=)) (genericCompare (<) (=)) (x1.ref_relent, x1.ref_rel_idx, x1.ref_src_scn)
                (x2.ref_relent, x2.ref_rel_idx, x2.ref_src_scn)))`;

                
val _ = Define `
(instance_Basic_classes_Ord_Memory_image_reloc_site_dict =(<|

  compare_method := relocSiteCompare;

  isLess_method := (\ f1 .  (\ f2 .  (relocSiteCompare f1 f2 = LT)));

  isLessEqual_method := (\ f1 .  (\ f2 .  (IN) (relocSiteCompare f1 f2) ({LT; EQ})));

  isGreater_method := (\ f1 .  (\ f2 .  (relocSiteCompare f1 f2 = GT)));

  isGreaterEqual_method := (\ f1 .  (\ f2 .  (IN) (relocSiteCompare f1 f2) ({GT; EQ})))|>))`;


val _ = Hol_datatype `
 symbol_reference_and_reloc_site = <|
      ref         : symbol_reference
    ; maybe_reloc :  reloc_site option
    |>`;


val _ = Define `
 (symRefAndRelocSiteCompare x1 x2 =        
(pairCompare symRefCompare (maybeCompare relocSiteCompare) (x1.ref, x1.maybe_reloc)
                (x2.ref, x2.maybe_reloc)))`;


val _ = Define `
(instance_Basic_classes_Ord_Memory_image_symbol_reference_and_reloc_site_dict =(<|

  compare_method := symRefAndRelocSiteCompare;

  isLess_method := (\ f1 .  (\ f2 .  (symRefAndRelocSiteCompare f1 f2 = LT)));

  isLessEqual_method := (\ f1 .  (\ f2 .  (IN) (symRefAndRelocSiteCompare f1 f2) ({LT; EQ})));

  isGreater_method := (\ f1 .  (\ f2 .  (symRefAndRelocSiteCompare f1 f2 = GT)));

  isGreaterEqual_method := (\ f1 .  (\ f2 .  (IN) (symRefAndRelocSiteCompare f1 f2) ({GT; EQ})))|>))`;


val _ = Hol_datatype `
 symbol_definition
 = <| def_symname : string
    ; def_syment : elf64_symbol_table_entry (* definition's symtab entry *)
    ; def_sym_scn : num                 (* symtab section index, to disamiguate dynsym *)
    ; def_sym_idx : num                 (* index of symbol into the symtab *)
    |>`;


val _ = Define `
 (symDefCompare x1 x2 =        
(quadrupleCompare (\ x y. EQ) elf64_symbol_table_entry_compare (genericCompare (<) (=)) (genericCompare (<) (=)) (x1.def_symname, x1.def_syment, x1.def_sym_scn, x1.def_sym_idx)
                (x2.def_symname, x2.def_syment, x2.def_sym_scn, x2.def_sym_idx)))`;


val _ = Define `
(instance_Basic_classes_Ord_Memory_image_symbol_definition_dict =(<|

  compare_method := symDefCompare;

  isLess_method := (\ f1 .  (\ f2 .  (symDefCompare f1 f2 = LT)));

  isLessEqual_method := (\ f1 .  (\ f2 .  (IN) (symDefCompare f1 f2) ({LT; EQ})));

  isGreater_method := (\ f1 .  (\ f2 .  (symDefCompare f1 f2 = GT)));

  isGreaterEqual_method := (\ f1 .  (\ f2 .  (IN) (symDefCompare f1 f2) ({GT; EQ})))|>))`;


val _ = Hol_datatype `
(*  'a *) ToNaturalList_class= <|
    toNaturalList_method : 'a -> num list
|>`;


(* In order to store tags in a set, we need a total ordering
 * to be defined on them.
 * 
 * But also, in order to look up entries 
 * by tag constructor *alone* (e.g. ImageBase, EntryPoint, etc.)
 * we need a looser version of the same ordering.
 * 
 * So we factor it into a few stages.
 * 
 * - map tag constructors to integers. We'll use this to define the 
 * equivalence classes. Since we want to do queries of the form
 *
 *     FileFeature(ElfSection(_))
 *
 * to get all sections, say, we actually map to a *list* of integers,
 * where each constructor contributes one element to the list.
 * Since lists are lexicographically ordered, we get a total ordering
 * just as good as if we'd used only naturals.
 *)


(* We can also annotate arbitrary ranges of bytes within an element
 * with arbitrary metadata. 
 * 
 * Ideally we want to data-abstract this a bit. But it's hard to do
 * so without baking in ELF-specific and/or (moreover) per-ABI concepts, 
 * like PLTs and GOTs. Ideally we would use something like polymorphic
 * variants here. For now, this has to be the union of all the concepts
 * that we find in the various ABIs we care about. To avoid ELFy things
 * creeping in, we parameterise by 'a, and instantiate the 'a with the
 * relevant ELFy thing when we use it. OH, but then 'a is different for
 * every distinct ELF thing, which is no good. Can we define a mapping
 * from an umbrella "ELF" type to the relevant types in each case? *)
val _ = Hol_datatype `
 range_tag = (*  forall 'abifeature . *)
                 ImageBase
               | EntryPoint
               | SymbolDef of symbol_definition
               | SymbolRef of symbol_reference_and_reloc_site
               | FileFeature of elf_file_feature (* file feature other than symdef and reloc *)
               | AbiFeature of 'abifeature`;


val _ = type_abbrev( "range0" , ``: num # num``); (* start, length *)

val _ = type_abbrev( "element_range" , ``: string # range0``);

val _ = Hol_datatype `
(*  'abifeature *) annotated_memory_image = <|
      elements         : memory_image 
    ; by_range         : (( element_range option), ( 'abifeature range_tag)) multimap
    ; by_tag           : (( 'abifeature range_tag), ( element_range option)) multimap
|>`;


(*val get_empty_memory_image : forall 'abifeature. unit -> annotated_memory_image 'abifeature*)
val _ = Define `
 (get_empty_memory_image = 
  (\u .  (case (u ) of
             ( _ ) => <| elements := FEMPTY ; by_range := EMPTY
                        ; by_tag := EMPTY|>
         )))`;


(* Basic ELFy and ABI-y things. *)
(* FIXME: shouldn't really be here, but need to be in some low-lying module, and 
 * keeping out of elf_* for now to avoid duplication into elf64_, elf32_. *)
val _ = Define `
 (elf_section_is_special s f = (~ (s.elf64_section_type = sht_progbits)
                     /\ ~ (s.elf64_section_type = sht_nobits)))`;


(* This record collects things that ABIs may or must define. 
 * 
 * Since we want to put all ABIs in a list and select one at run time, 
 * we can't maintain a type-level distinction between ABIs; we have to
 * use elf_memory_image any_abi_feature. To avoid a reference cycle,
 * stay polymorphic in the ABI feature type until we define specific ABIs.
 * In practice we'll use only any_abi_feature, because we need to pull
 * the ABI out of a list at run time.
 *)
val _ = type_abbrev( "null_abi_feature" , ``: unit``);

(* The reloc calculation is complicated, so we split up the big function
 * type into smaller ones. *)

(* Q. Do we want "existing", or is it a kind of addend? 
 * A. We do want it -- modelling both separately is necessary, 
 * because we model relocations bytewise, but some arches
 * do bitfield relocations (think ARM). *)
val _ = type_abbrev( "reloc_calculate_fn"    , ``: num -> num -> num -> num``); (* symaddr -> addend -> existing -> relocated *)

val _ = type_abbrev((*  'abifeature *) "reloc_apply_fn" , ``: 'abifeature 
                                (* elf memory image: the context in which the relocation is being applied *)
                                annotated_memory_image ->
                                (* Typically there are two symbol table entries involved in a relocation.
                                 * One is the reference, and is usually undefined.
                                 * The other is the definition, and is defined (else absent, when we use 0).
                                 * However, sometimes the reference is itself a defined symbol.
                                 * Almost always, if so, *that* symbol *is* "the definition".
                                 * However, copy relocs are an exception.
                                 * 
                                 * In the case of copy relocations being fixed up by the dynamic
                                 * linker, the dynamic linker must figure out which definition to
                                 * copy from. This can't be as simple as "the first definition in
                                 * link order", because *our* copy of that symbol is a definition
                                 * (typically in bss). It could be as simple as "the first *after us*
                                 * in link order". FIXME: find the glibc code that does this.
                                 * 
                                 * Can we dig this stuff out of the memory image? If we pass the address
                                 * being relocated, we can find the tags. But I don't want to pass
                                 * the symbol address until the very end. It seems better to pass the symbol
                                 * name, since that's the key that the dynamic linker uses to look for
                                 * other definitions.
                                 * 
                                 * Do we want to pass a whole symbol_reference? This has not only the
                                 * symbol name but also syment, scn and idx. The syment is usually UND, 
                                 * but *could* be defined (and is for copy relocs). The scn and idx are
                                 * not relevant, but it seems cleaner to pass the whole thing anyway.
                                 *)
                                symbol_reference_and_reloc_site -> 
                                (* Should we pass a symbol_definition too? Implicitly, we pass part of it
                                 * by passing the symaddr argument (below). I'd prefer not to depend on
                                 * others -- relocation calculations should look like "mostly address 
                                 * arithmetic", i.e. only the weird ones do something else. *)
                                (* How wide, in bytes, is the relocated field? this may depend on img 
                                 * and on the wider image (copy relocs), so it's returned *by* the reloc function. *)
                                (num (* width *) # reloc_calculate_fn)``);

(* Some kinds of relocation necessarily give us back a R_*_RELATIVE reloc.
 * We don't record this explicitly. Instead, the "bool" is a flag recording whether
 * the field represents an absolute address.
 * Similarly, some relocations can "fail" according to their ABI manuals.
 * This just means that the result can't be represented in the field width.
 * We detect this when actually applying the reloc in the memory image content
 * (done elsewhere). *)
val _ = type_abbrev((*  'abifeature *) "reloc_fn" , ``: num -> (bool # 'abifeature reloc_apply_fn)``);

(*val noop_reloc_calculate : natural -> natural -> natural -> natural*)
val _ = Define `
 (noop_reloc_calculate symaddr addend existing = existing)`;


(*val noop_reloc_apply : forall 'abifeature. reloc_apply_fn 'abifeature*)
val _ = Define `
 (noop_reloc_apply img ref = ( 0, noop_reloc_calculate))`;


(*val noop_reloc : forall 'abifeature. natural -> (bool (* result is absolute addr *) * reloc_apply_fn 'abifeature)*)
val _ = Define `
 (noop_reloc k = (F, noop_reloc_apply))`;


val _ = Hol_datatype `
(*  'abifeature *) abi = (* forall 'abifeature. *)
   <| is_valid_elf_header : elf64_header -> bool (* doesn't this generalise outrageously? is_valid_elf_file? *)
    ; make_elf_header    : num -> num -> num -> num -> num -> num -> num -> elf64_header
                           (* t entry shoff phoff phnum shnum shstrndx *)
    ; reloc              : 'abifeature reloc_fn
    ; section_is_special : elf64_interpreted_section -> 'abifeature annotated_memory_image -> bool
    ; section_is_large   : elf64_interpreted_section -> 'abifeature annotated_memory_image -> bool
    ; maxpagesize        : num
    ; minpagesize        : num
    ; commonpagesize     : num
    ; symbol_is_generated_by_linker : string -> bool
    (*; link_inputs_tap    : 
    ; link_output_sections_tap   : 
    ; link_output_image_tap      : *)
    |>`;


(*val range_contains : (natural * natural) -> (natural * natural) -> bool*)
val _ = Define `
 (range_contains (r1begin, r1len) (r2begin, r2len) =
    (( 
    (* r1 is at least as big as r2 *)r2begin >= r1begin) /\ ((r2begin + r2len) <= (r1begin + r1len))))`;


(*val range_overlaps : (natural * natural) -> (natural * natural) -> bool*)
val _ = Define `
 (range_overlaps (r1begin, r1len) (r2begin, r2len) =    
(((r1begin < (r2begin + r2len)) /\ ((r1begin + r1len) > r2begin))
     \/ ((r2begin < (r1begin + r1len)) /\ ((r2begin + r2len) > r1begin))))`;

    
(*val is_partition : list (natural * natural) -> list (natural * natural) -> bool*)
val _ = Define `
 (is_partition rs ranges =    
( 
    (* 1. each element of the first list falls entirely within some element
     * from the second list. *)let r_is_contained_by_some_range
     = (\ r .  FOLDL (\/) F (MAP (\ range1 .  range_contains range1 r) ranges))
    in
    EVERY (\ r .  r_is_contained_by_some_range r) rs
    /\
    (* 2. elements of the first list do not overlap *)
    EVERY (\ r .  EVERY (\ r2 .  (r = (* should be "=="? *) r2) \/ (~ (range_overlaps r r2))) rs) rs))`;


(*val     nat_range : natural -> natural -> list natural*)
 val nat_range_defn = Hol_defn "nat_range" `
 (nat_range base len =    
((case len of 
        0 => []
    |   _ => base :: (nat_range (base + 1) (len -  1))
    )))`;

val _ = Lib.with_flag (computeLib.auto_import_definitions, false) Defn.save_defn nat_range_defn;

(* Expand a sorted list of ranges into a list of bool, where the list contains
 * true if its index is included in one or more ranges, else false. *)
(*val expand_sorted_ranges : list (natural * natural) -> natural -> list bool -> list bool*)
 val expand_sorted_ranges_defn = Hol_defn "expand_sorted_ranges" `
 (expand_sorted_ranges sorted_ranges min_length accum =    
((case sorted_ranges of
        [] => accum ++ (
            let pad_length = (MAX( 0) (min_length - (missing_pervasives$length accum)))
            in
            (* let _ = Missing_pervasives.errln (
                "padding ranges cares list with " ^ (show pad_length) ^ 
                " cares (accumulated " ^ (show (Missing_pervasives.length accum)) ^ 
                ", min length " ^ (show min_length) ^ ")")
            in *)
            missing_pervasives$replicate pad_length T)
     |  (base, len)  ::  more => 
            (* pad the accum so that it reaches up to base *)
            let up_to_base = (missing_pervasives$replicate (base - (missing_pervasives$length accum)) T)
            in
            let up_to_end_of_range = (up_to_base ++ (missing_pervasives$replicate len F))
            in
            expand_sorted_ranges more min_length (accum ++ up_to_end_of_range)
    )))`;

val _ = Lib.with_flag (computeLib.auto_import_definitions, false) Defn.save_defn expand_sorted_ranges_defn;

(*val expand_unsorted_ranges : list (natural * natural) -> natural -> list bool -> list bool*)
 val _ = Define `
 (expand_unsorted_ranges unsorted_ranges min_length accum =    
(expand_sorted_ranges (QSORT (\ (base1, len1) .  (\ (base2, len2) .  base1 < base2)) unsorted_ranges) min_length accum))`;


(*val make_byte_pattern_revacc : list (maybe byte) -> list byte -> list bool -> list (maybe byte)*)
 val make_byte_pattern_revacc_defn = Hol_defn "make_byte_pattern_revacc" `
 (make_byte_pattern_revacc revacc bytes cares =    
 ((case bytes of
          [] => REVERSE revacc
        | b  ::  bs => (case cares of 
                care  ::  more => make_byte_pattern_revacc ((if ~ care then NONE else SOME b) :: revacc) bs more
              | _ => failwith "make_byte_pattern: unequal length"
              )
    )))`;

val _ = Lib.with_flag (computeLib.auto_import_definitions, false) Defn.save_defn make_byte_pattern_revacc_defn;

(*val make_byte_pattern : list byte -> list bool -> list (maybe byte)*)
 val _ = Define `
 (make_byte_pattern bytes cares =    
 (make_byte_pattern_revacc [] bytes cares))`;


(*val relax_byte_pattern_revacc : list (maybe byte) -> list (maybe byte) -> list bool -> list (maybe byte)*)
 val relax_byte_pattern_revacc_defn = Hol_defn "relax_byte_pattern_revacc" `
 (relax_byte_pattern_revacc revacc bytes cares =    
 ((case bytes of
          [] => REVERSE revacc
        | b  ::  bs => (case cares of 
                care  ::  more => relax_byte_pattern_revacc ((if ~ care then NONE else b) :: revacc) bs more
              | _ => failwith ("relax_byte_pattern: unequal length")
              )
    )))`;

val _ = Lib.with_flag (computeLib.auto_import_definitions, false) Defn.save_defn relax_byte_pattern_revacc_defn;
    
(*val relax_byte_pattern : list (maybe byte) -> list bool -> list (maybe byte)*)
 val _ = Define `
 (relax_byte_pattern bytes cares =    
 (relax_byte_pattern_revacc [] bytes cares))`;


(*val byte_option_matches_byte : maybe byte -> byte -> bool*)
val _ = Define `
 (byte_option_matches_byte optb b =    
((case optb of 
            NONE => T 
        |   SOME some1 => some1 = b 
    )))`;


(*val byte_list_matches_pattern : list (maybe byte) -> list byte -> bool*)
 val byte_list_matches_pattern_defn = Hol_defn "byte_list_matches_pattern" `
 (byte_list_matches_pattern pattern bytes =    
 ((case pattern of 
        [] => T
        | optbyte  ::  more => (case bytes of 
                [] => F
                | abyte  ::  morebytes => 
                    byte_option_matches_byte optbyte abyte 
                 /\ byte_list_matches_pattern more morebytes
            )
    )))`;

val _ = Lib.with_flag (computeLib.auto_import_definitions, false) Defn.save_defn byte_list_matches_pattern_defn;

(*val append_to_byte_pattern_at_offset : natural -> list (maybe byte) -> list (maybe byte) -> list (maybe byte)*)
val _ = Define `
 (append_to_byte_pattern_at_offset offset pat1 pat2 =    
(let pad_length = (offset - missing_pervasives$length pat1)
    in
    if pad_length < 0 then failwith "can't append at offset already used"
    else (pat1 ++ (REPLICATE (id pad_length) NONE)) ++ pat2))`;


(*val accum_pattern_possible_starts_in_one_byte_sequence : list (maybe byte) -> nat -> list byte -> nat -> natural -> list natural -> list natural*)
 val accum_pattern_possible_starts_in_one_byte_sequence_defn = Hol_defn "accum_pattern_possible_starts_in_one_byte_sequence" `
 (accum_pattern_possible_starts_in_one_byte_sequence pattern pattern_len seq seq_len offset accum =    
(
    (* let _ = Missing_pervasives.errs ("At offset " ^ (show offset) ^ "... ")
    in *)(case pattern of
        [] => (* let _ = Missing_pervasives.errs ("terminating with hit (empty pattern)\n") in *)
            offset :: accum
        | bpe  ::  more_bpes => (* nonempty, so check for nonempty seq *)
            (case seq of 
                [] => (*let _ = Missing_pervasives.errs ("terminating with miss (empty pattern)\n") 
                    in *) accum (* ran out of bytes in the sequence, so no match *)
                | byte  ::  more_bytes => let matched_this_byte =                            
 (byte_option_matches_byte bpe byte)
                       in
                       (* let _ = Missing_pervasives.errs ("Byte " ^ (show byte) ^ " matched " ^ (show byte_pattern) ^ "? " ^ (show matched_this_byte) ^ "; ") 
                       in *)
                       let sequence_long_enough = (seq_len >= pattern_len) 
                       in
                       (* let _ = Missing_pervasives.errs ("enough bytes remaining (" ^ (show seq_len) ^ ") to match rest of pattern (" ^ (show pattern_len) ^ ")? " ^ (show sequence_long_enough) ^ "; ") 
                       in *)
                       let matched_here = (matched_this_byte /\ sequence_long_enough /\
                        byte_list_matches_pattern more_bpes more_bytes)
                       in
                       (* let _ = Missing_pervasives.errs ("matched pattern anchored here? " ^ (show matched_this_byte) ^ "\n") 
                       in *)
                       accum_pattern_possible_starts_in_one_byte_sequence 
                           pattern pattern_len 
                           more_bytes (seq_len -  1) 
                           (offset + 1) 
                           (if matched_here then offset :: accum else accum)
            )
    )))`;

val _ = Lib.with_flag (computeLib.auto_import_definitions, false) Defn.save_defn accum_pattern_possible_starts_in_one_byte_sequence_defn;

val _ = Define `
 (swap_pairs s = 
  ({ (v, k) | k, v | ((k, v) IN s) /\ T }))`;


val _ = Define `
 (by_range_from_by_tag = swap_pairs)`;


val _ = Define `
 (by_tag_from_by_range = swap_pairs)`;


(*val filter_elements : forall 'abifeature. ((string * memory_image_element) -> bool) -> 
    annotated_memory_image 'abifeature -> annotated_memory_image 'abifeature*)
val _ = Define `
 (filter_elements pred img =    
 (let new_elements = (FUPDATE_LIST FEMPTY (let x2 = 
  ([]) in  FOLDR
   (\(n, r) x2 . 
    if
    let result = (pred (n, r)) in
    if ~ result then
      (*let _ = Missing_pervasives.outln ("Discarding element named " ^ n) in*) result
    else result then (n, r) :: x2 else x2) x2
   (SET_TO_LIST (FMAP_TO_SET img.elements))))
    in
    let new_by_range =  (SET_FILTER (\ (maybe_range, tag) .  (case maybe_range of
            NONE => T
            | SOME (el_name, el_range) => el_name IN FDOM new_elements
        )) img.by_range)
    in
    let new_by_tag = ({ (v, k) | k, v | ((k, v) IN new_by_range) /\ T })
    in
    <| elements := new_elements
     ; by_range := new_by_range
     ; by_tag   := new_by_tag
     |>))`;


(*val pattern_possible_starts_in_one_byte_sequence : list (maybe byte) -> list byte -> natural -> list natural*)
val _ = Define `
 (pattern_possible_starts_in_one_byte_sequence pattern seq offset =    
(
    (* let _ = Missing_pervasives.errs ("Looking for matches of " ^
        (show (List.length pattern)) ^ "-byte pattern in " ^ (show (List.length seq)) ^ "-byte region\n")
    in *)accum_pattern_possible_starts_in_one_byte_sequence pattern (LENGTH pattern) seq (LENGTH seq) offset []))`;


(*val byte_pattern_of_byte_sequence : byte_sequence -> list (maybe byte)*)
val _ = Define `
 (byte_pattern_of_byte_sequence seq = ((case seq of
    Sequence(bs) => MAP (\ b .  SOME b) bs
)))`;


(*val compute_virtual_address_adjustment : natural -> natural -> natural -> natural*)
val _ = Define `
 (compute_virtual_address_adjustment max_page_size offset vaddr =  
((vaddr - offset) MOD max_page_size))`;

val _ = export_theory()
