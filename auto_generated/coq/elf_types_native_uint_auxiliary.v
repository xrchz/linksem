(* Generated by Lem from elf_types_native_uint.lem. *)

Require Import Arith.
Require Import Bool.
Require Import List.
Require Import String.
Require Import Program.Wf.

Open Scope nat_scope.
Open Scope string_scope.


Lemmanatural_land_def_lemma:((forallm n,(beq_nat  
(
  (* For Isabelle backend...*)nat_of_elf64_xword (elf64_xword_land (elf64_xword_of_nat m) (elf64_xword_of_nat n))) 
  (nat_land m n) : Prop)): Prop) .
Lemmanatural_lor_def_lemma:((forallm n,(beq_nat  
(
  (* For Isabelle backend...*)nat_of_elf64_xword (elf64_xword_lor (elf64_xword_of_nat m) (elf64_xword_of_nat n))) 
  (nat_lor m n) : Prop)): Prop) .
Lemmanatural_lxor_def_lemma:((forallm n,(beq_nat  
(
  (* For Isabelle backend...*)nat_of_elf64_xword (elf64_xword_lxor (elf64_xword_of_nat m) (elf64_xword_of_nat n))) 
  (nat_lxor m n) : Prop)): Prop) .