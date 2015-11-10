chapter {* Generated by Lem from gnu_extensions/gnu_ext_abi.lem. *}

theory "Gnu_ext_abi" 

imports 
 	 Main
	 "/auto/homes/dpm36/Work/Cambridge/bitbucket/lem/isabelle-lib/Lem_num" 
	 "/auto/homes/dpm36/Work/Cambridge/bitbucket/lem/isabelle-lib/Lem_list" 
	 "/auto/homes/dpm36/Work/Cambridge/bitbucket/lem/isabelle-lib/Lem_function" 
	 "/auto/homes/dpm36/Work/Cambridge/bitbucket/lem/isabelle-lib/Lem_basic_classes" 
	 "/auto/homes/dpm36/Work/Cambridge/bitbucket/lem/isabelle-lib/Lem_bool" 
	 "/auto/homes/dpm36/Work/Cambridge/bitbucket/lem/isabelle-lib/Lem_maybe" 
	 "/auto/homes/dpm36/Work/Cambridge/bitbucket/lem/isabelle-lib/Lem_string" 
	 "/auto/homes/dpm36/Work/Cambridge/bitbucket/lem/isabelle-lib/Lem_assert_extra" 
	 "/auto/homes/dpm36/Work/Cambridge/bitbucket/linksem/auto_generated/isabelle/Show" 
	 "/auto/homes/dpm36/Work/Cambridge/bitbucket/lem/isabelle-lib/Lem_sorting" 
	 "/auto/homes/dpm36/Work/Cambridge/bitbucket/linksem/auto_generated/isabelle/Missing_pervasives" 
	 "/auto/homes/dpm36/Work/Cambridge/bitbucket/linksem/auto_generated/isabelle/Byte_sequence" 
	 "/auto/homes/dpm36/Work/Cambridge/bitbucket/linksem/auto_generated/isabelle/Elf_types_native_uint" 
	 "/auto/homes/dpm36/Work/Cambridge/bitbucket/lem/isabelle-lib/Lem_tuple" 
	 "/auto/homes/dpm36/Work/Cambridge/bitbucket/linksem/auto_generated/isabelle/Elf_header" 
	 "/auto/homes/dpm36/Work/Cambridge/bitbucket/linksem/auto_generated/isabelle/Elf_program_header_table" 
	 "/auto/homes/dpm36/Work/Cambridge/bitbucket/linksem/auto_generated/isabelle/Elf_section_header_table" 
	 "/auto/homes/dpm36/Work/Cambridge/bitbucket/linksem/auto_generated/isabelle/Elf_interpreted_section" 
	 "/auto/homes/dpm36/Work/Cambridge/bitbucket/linksem/auto_generated/isabelle/Elf_interpreted_segment" 
	 "/auto/homes/dpm36/Work/Cambridge/bitbucket/linksem/auto_generated/isabelle/Elf_symbol_table" 
	 "/auto/homes/dpm36/Work/Cambridge/bitbucket/linksem/auto_generated/isabelle/Elf_file" 
	 "/auto/homes/dpm36/Work/Cambridge/bitbucket/linksem/auto_generated/isabelle/Elf_relocation" 
	 "/auto/homes/dpm36/Work/Cambridge/bitbucket/linksem/auto_generated/isabelle/Memory_image" 
	 "/auto/homes/dpm36/Work/Cambridge/bitbucket/linksem/auto_generated/isabelle/Abis" 

begin 

(*open import Basic_classes*)
(*open import Function*)
(*open import String*)
(*open import Tuple*)
(*open import Bool*)
(*open import List*)
(*open import Sorting*)
(*open import Num*)
(*open import Maybe*)
(*open import Assert_extra*)
(*open import Show*)
(*open import Missing_pervasives*)

(*open import Byte_sequence*)

(*open import Abis*)

(*open import Elf_file*)
(*open import Elf_header*)
(*open import Elf_interpreted_segment*)
(*open import Elf_interpreted_section*)
(*open import Elf_program_header_table*)
(*open import Elf_section_header_table*)
(*open import Elf_symbol_table*)
(*open import Elf_types_native_uint*)
(*open import Elf_relocation*)
(*open import Elf_types_native_uint*)
(*open import Memory_image*)

(*val gnu_extend: forall 'abifeature. abi 'abifeature -> abi 'abifeature*)
definition gnu_extend  :: " 'abifeature abi \<Rightarrow> 'abifeature abi "  where 
     " gnu_extend a = ( 
   (| is_valid_elf_header0 =(is_valid_elf_header0   a)
    , make_elf_header0     =            
( (*  t -> entry -> shoff -> phoff -> phnum -> shnum -> shstrndx -> hdr *)\<lambda> t .  \<lambda> entry .  \<lambda> shoff .  \<lambda> phoff .  \<lambda> phnum .  \<lambda> shnum .  \<lambda> shstrndx . 
            (let unmod = ((make_elf_header0   a) t entry shoff phoff phnum shnum shstrndx)
            in
              (| elf64_ident    = (case (elf64_ident   unmod) of 
                i0 # i1 # i2 # i3  # i4  # i5  # i6  # 
                _  # _  # i9 # i10 # i11 # i12 # i13 # i14 # i15 # []
                    => [i0, i1, i2, i3, i4, i5, i6,
                        Elf_Types_Local.unsigned_char_of_nat elf_osabi_gnu,
                        Elf_Types_Local.unsigned_char_of_nat(( 1 :: nat)),
                        i9, i10, i11, i12, i13, i14, i15]
                )
               , elf64_type     = (Elf_Types_Local.uint16_of_nat t)
               , elf64_machine  =(elf64_machine   unmod)
               , elf64_version  =(elf64_version   unmod)
               , elf64_entry    =(elf64_entry   unmod)
               , elf64_phoff    = (Elf_Types_Local.uint64_of_nat phoff)
               , elf64_shoff    = (Elf_Types_Local.uint64_of_nat shoff)
               , elf64_flags    =(elf64_flags   unmod)
               , elf64_ehsize   =(elf64_ehsize   unmod)
               , elf64_phentsize=(elf64_phentsize   unmod)
               , elf64_phnum    = (Elf_Types_Local.uint16_of_nat phnum)
               , elf64_shentsize=(elf64_shentsize   unmod)
               , elf64_shnum    = (Elf_Types_Local.uint16_of_nat shnum)
               , elf64_shstrndx = (Elf_Types_Local.uint16_of_nat shstrndx)
               |)))
    , reloc0               =(reloc0   a)
    , section_is_special2  = (\<lambda> isec .  (\<lambda> img1 .  ((section_is_special2  
                                a) isec img1
                                \<or> (Missing_pervasives.string_prefix ( (List.length (''.gnu.warning'')))(elf64_section_name_as_string   isec)
                                 = Some((''.gnu.warning'')))
        (* FIXME: This is a slight abuse. The GNU linker's treatment of 
         * .gnu.warning.* section is not really a function of the output
         * ABI -- it's a function of the input ABI, or arguably perhaps just
         * of the linker itself. We have to do something to make sure these
         * sections get silently processed separately from the usual linker
         * control script, because otherwise our link map output doesn't match
         * the GNU linker's. By declaring these sections special we achieve
         * this by saying they don't participate in linking proper, just like 
         * .symtab and similar sections don't. HMM. I suppose this is 
         * okay, in that although a non-GNU linker might happily link these
         * sections, arguably that is a failure to understand the input files. 
         * But the issue about it being a per-input-file property remains.
         * Q. What does the GNU linker do if a reloc input file whose OSABI
         * is *not* GNU contains a .gnu.warning.* section? That would be a fair
         * test about whether looking at the input ABI is worth doing. *)
                            )))
    , section_is_large0    =(section_is_large0   a)
    , maxpagesize0         =(maxpagesize0   a)
    , minpagesize0         =(minpagesize0  a)
    , commonpagesize0      =(commonpagesize0   a)
    , symbol_is_generated_by_linker0 =(symbol_is_generated_by_linker0   a)
    , make_phdrs0          =(make_phdrs0   a) (* FIXME: also make the GNU phdrs! *)
    , max_phnum0           =(( 3 :: nat) +(max_phnum0   a)) (* FIXME: GNU_RELRO, GNU_STACK; what else? *)
    , guess_entry_point0   =(guess_entry_point0   a)
    , pad_data0            =(pad_data0   a)
    , pad_code0            =(pad_code0   a)
    |) )"

end
