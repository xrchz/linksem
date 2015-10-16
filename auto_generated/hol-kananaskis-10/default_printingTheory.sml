structure default_printingTheory :> default_printingTheory =
struct
  val _ = if !Globals.print_thy_loads then print "Loading default_printingTheory ... " else ()
  open Type Term Thm
  infixr -->

  fun C s t ty = mk_thy_const{Name=s,Thy=t,Ty=ty}
  fun T s t A = mk_thy_type{Tyop=s, Thy=t,Args=A}
  fun V s q = mk_var(s,q)
  val U     = mk_vartype
  (*  Parents *)
  local open lem_functionTheory
  in end;
  val _ = Theory.link_parents
          ("default_printing",
          Arbnum.fromString "1445005753",
          Arbnum.fromString "884667")
          [("lem_function",
           Arbnum.fromString "1444993246",
           Arbnum.fromString "682607")];
  val _ = Theory.incorporate_types "default_printing" [];

  val idvector = 
    let fun ID(thy,oth) = {Thy = thy, Other = oth}
    in Vector.fromList
  []
  end;
  local open SharingTables
  in
  val tyvector = build_type_vector idvector
  []
  end
  val _ = Theory.incorporate_consts "default_printing" tyvector [];

  local open SharingTables
  in
  val tmvector = build_term_vector idvector tyvector
  []
  end

  val _ = DB.bindl "default_printing" []

  local open Portable GrammarSpecials Parse
    fun UTOFF f = Feedback.trace("Parse.unicode_trace_off_complaints",0)f
  in
  val _ = mk_local_grms [("lem_functionTheory.lem_function_grammars",
                          lem_functionTheory.lem_function_grammars)]
  val _ = List.app (update_grms reveal) []

  val default_printing_grammars = Parse.current_lgrms()
  end

val _ = if !Globals.print_thy_loads then print "done\n" else ()
val _ = Theory.load_complete "default_printing"
end
