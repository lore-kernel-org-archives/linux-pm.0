From: Julia Lawall <julia.lawall@lip6.fr>
Subject: Re: [PATCH] coccinelle: api: detect duplicate chip data arrays
Date: Mon, 9 Oct 2017 08:39:06 +0200 (CEST)
Message-ID: <alpine.DEB.2.20.1710090821190.3143@hadrien>
References: <1506861768-5734-1-git-send-email-Julia.Lawall@lip6.fr> <CAKvHMgT07xoBW_VmAYsxUmoYaz_iN4vFh7Ljb_UQEWAd8bt22w@mail.gmail.com> <alpine.DEB.2.20.1710052122380.2626@hadrien> <CAKvHMgSCZ3CLfKNpQQbK79bnCss0uFTr9TP_i89rkYr8+hAGsw@mail.gmail.com>
 <alpine.DEB.2.20.1710052140200.2626@hadrien> <20171009025039.77oaplaovnvpy6nv@wfg-t540p.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail2-relais-roc.national.inria.fr ([192.134.164.83]:64963 "EHLO
        mail2-relais-roc.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751283AbdJIGjJ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 9 Oct 2017 02:39:09 -0400
In-Reply-To: <20171009025039.77oaplaovnvpy6nv@wfg-t540p.sh.intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Fengguang Wu <fengguang.wu@intel.com>
Cc: Liam Breck <liam@networkimprov.net>, Sebastian Reichel <sebastian.reichel@collabora.co.uk>, =?ISO-8859-15?Q?Pali_Roh=E1r?= <pali.rohar@gmail.com>, Linux PM mailing list <linux-pm@vger.kernel.org>, kernel-janitors@vger.kernel.org, Gilles Muller <Gilles.Muller@lip6.fr>, Nicolas Palix <nicolas.palix@imag.fr>, cocci@systeme.lip6.fr, linux-kernel <linux-kernel@vger.kernel.org>, Masahiro Yamada <yamada.masahiro@socionext.com>

> > I put kbuild in CC.  I don't know what is the criterion for including
> > semantic patches.
>
> We may have 3 options:
>
> 1) push this patch to upstream, so that all users can run the check
>   (with obvious cost)

I tried on my laptop with only one core and no indexing.  In this case,
Coccinelle uses git grep to find relevant files.  It finds only one.  The
time for the whole process is 2 seconds.

> 2) try to optimize away the extra overheads by improving
>   script/coccicheck to support conditional run of some cocci scripts

With Coccinelle, you can make virtual rules that are defined or not on the
command line and determine what does or not happen.  At the moment, putting
virtual full at the top of the file and making all processing depend on
full has the very undesirable effect of causing all of the .cfiles to be
parsed, but I can fix that.

Another possibility is adding "depends on file in "drivers/power/supply""
to the first rule, which everything else depends on.  I doubt that would
affect performance, because the git grep already has a high cost for
starting a shell, but it would make clearer what is going on.

julia


> 3) let 0-day maintain and run a collection of 3rd-party scripts if
>   (1,2) turns out to be hard or not always applicable for some scripts
>
> What do you think? At least it'd be easy and quick for us to implement (3).
>
> Thanks,
> Fengguang
>
> > > >> Also maybe the name of the script should include "bq27xxx_data"?
> > > >
> > > > OK
> > > >
> > > >> Few more comments below...
> > > >>
> > > >> On Sun, Oct 1, 2017 at 5:42 AM, Julia Lawall <Julia.Lawall@lip6.fr>
> > > wrote:
> > > >> > This semantic patch detects duplicate arrays declared using
> > > BQ27XXX_DATA
> > > >> > within a single structure.  It is currently specific to the file
> > > >> > drivers/power/supply/bq27xxx_battery.c.
> > > >> >
> > > >> > Signed-off-by: Julia Lawall <Julia.Lawall@lip6.fr>
> > > >> >
> > > >> > ---
> > > >> >  scripts/coccinelle/api/battery.cocci |  161
> > > +++++++++++++++++++++++++++++++++++
> > > >> >  1 file changed, 161 insertions(+)
> > > >> >
> > > >> > diff --git a/scripts/coccinelle/api/battery.cocci
> > > b/scripts/coccinelle/api/battery.cocci
> > > >> > new file mode 100644
> > > >> > index 0000000..77c145a
> > > >> > --- /dev/null
> > > >> > +++ b/scripts/coccinelle/api/battery.cocci
> > > >> > @@ -0,0 +1,161 @@
> > > >> > +/// Detect BQ27XXX_DATA structures with identical registers, dm
> > > registers or
> > > >> > +/// properties.
> > > >> > +//# Doesn't unfold macros used in register or property fields.
> > > >> > +//# Requires OCaml scripting
> > > >> > +///
> > > >> > +// Confidence: High
> > > >> > +// Copyright: (C) 2017 Julia Lawall, Inria/LIP6, GPLv2.
> > > >> > +// URL: http://coccinelle.lip6.fr/
> > > >> > +// Requires: 1.0.7
> > > >> > +// Keywords: BQ27XXX_DATA
> > > >> > +
> > > >> > +virtual report
> > > >> > +
> > > >> > +@initialize:ocaml@
> > > >> > +@@
> > > >> > +
> > > >> > +let print_report p msg =
> > > >> > +  let p = List.hd p in
> > > >> > +  Printf.printf "%s:%d:%d-%d: %s" p.file p.line p.col p.col_end msg
> > > >> > +
> > > >> > +@str depends on report@
> > > >> > +type t;
> > > >> > +identifier i,i1,i2;
> > > >> > +expression e1,e2;
> > > >> > +@@
> > > >> > +
> > > >> > +t i[] = {
> > > >> > +  ...,
> > > >> > +  [e1] = BQ27XXX_DATA(i1,...),
> > > >> > +  ...,
> > > >> > +  [e2] = BQ27XXX_DATA(i2,...),
> > > >> > +  ...,
> > > >> > +};
> > > >> > +
> > > >> > +@script:ocaml tocheck@
> > > >> > +i1 << str.i1;
> > > >> > +i2 << str.i2;
> > > >> > +i1regs; i2regs;
> > > >> > +i1dmregs; i2dmregs;
> > > >> > +i1props; i2props;
> > > >> > +@@
> > > >> > +
> > > >> > +if not(i1 = i2)
> > > >> > +then
> > > >> > +  begin
> > > >> > +    i1regs := make_ident (i1 ^ "_regs");
> > > >> > +    i2regs := make_ident (i2 ^ "_regs");
> > > >> > +    i1dmregs := make_ident (i1 ^ "_dm_regs");
> > > >> > +    i2dmregs := make_ident (i2 ^ "_dm_regs");
> > > >> > +    i1props := make_ident (i1 ^ "_props");
> > > >> > +    i2props := make_ident (i2 ^ "_props")
> > > >> > +  end
> > > >> > +
> > > >> > +(* ----------------------------------------------------------------
> > > *)
> > > >> > +
> > > >> > +@getregs1@
> > > >> > +typedef u8;
> > > >> > +identifier tocheck.i1regs;
> > > >> > +initializer list i1regs_vals;
> > > >> > +position p1;
> > > >> > +@@
> > > >> > +
> > > >> > +u8 i1regs@p1[...] = { i1regs_vals, };
> > > >> > +
> > > >> > +@getregs2@
> > > >> > +identifier tocheck.i2regs;
> > > >> > +initializer list i2regs_vals;
> > > >> > +position p2;
> > > >> > +@@
> > > >> > +
> > > >> > +u8 i2regs@p2[...] = { i2regs_vals, };
> > > >> > +
> > > >> > +@script:ocaml@
> > > >> > +(_,i1regs_vals) << getregs1.i1regs_vals;
> > > >> > +(_,i2regs_vals) << getregs2.i2regs_vals;
> > > >> > +i1regs << tocheck.i1regs;
> > > >> > +i2regs << tocheck.i2regs;
> > > >> > +p1 << getregs1.p1;
> > > >> > +p2 << getregs2.p2;
> > > >> > +@@
> > > >> > +
> > > >> > +if i1regs < i2regs &&
> > > >> > +   List.sort compare i1regs_vals = List.sort compare i2regs_vals
> > > >> > +then
> > > >> > +  let msg =
> > > >> > +    Printf.sprintf
> > > >> > +      "WARNING %s and %s (line %d) have the same registers\n"
> > > >>
> > > >> "are identical" vs "have the same..."
> > > >
> > > > OK, I guess identical would be appropriate for regsand dm_regs, but
> > > > perhaps not for properties because there the same values might be in a
> > > > different order.
> > >
> > > The order of the properties has no impact, so a duplicate is
> > > functionally identical.
> > >
> > > >
> > > > julia
> > > >
> > > >> > +      i1regs i2regs (List.hd p2).line in
> > > >> > +  print_report p1 msg
> > > >> > +
> > > >> > +(* ----------------------------------------------------------------
> > > *)
> > > >> > +
> > > >> > +@getdmregs1@
> > > >> > +identifier tocheck.i1dmregs;
> > > >> > +initializer list i1dmregs_vals;
> > > >> > +position p1;
> > > >> > +@@
> > > >> > +
> > > >> > +struct bq27xxx_dm_reg i1dmregs@p1[] = { i1dmregs_vals, };
> > > >> > +
> > > >> > +@getdmregs2@
> > > >> > +identifier tocheck.i2dmregs;
> > > >> > +initializer list i2dmregs_vals;
> > > >> > +position p2;
> > > >> > +@@
> > > >> > +
> > > >> > +struct bq27xxx_dm_reg i2dmregs@p2[] = { i2dmregs_vals, };
> > > >> > +
> > > >> > +@script:ocaml@
> > > >> > +(_,i1dmregs_vals) << getdmregs1.i1dmregs_vals;
> > > >> > +(_,i2dmregs_vals) << getdmregs2.i2dmregs_vals;
> > > >> > +i1dmregs << tocheck.i1dmregs;
> > > >> > +i2dmregs << tocheck.i2dmregs;
> > > >> > +p1 << getdmregs1.p1;
> > > >> > +p2 << getdmregs2.p2;
> > > >> > +@@
> > > >> > +
> > > >> > +if i1dmregs < i2dmregs &&
> > > >> > +   List.sort compare i1dmregs_vals = List.sort compare i2dmregs_vals
> > > >> > +then
> > > >> > +  let msg =
> > > >> > +    Printf.sprintf
> > > >> > +      "WARNING %s and %s (line %d) have the same dm registers\n"
> > > >>
> > > >> "are identical" vs "have the same..."
> > > >>
> > > >> > +      i1dmregs i2dmregs (List.hd p2).line in
> > > >> > +  print_report p1 msg
> > > >> > +
> > > >> > +(* ----------------------------------------------------------------
> > > *)
> > > >> > +
> > > >> > +@getprops1@
> > > >> > +identifier tocheck.i1props;
> > > >> > +initializer list[n1] i1props_vals;
> > > >> > +position p1;
> > > >> > +@@
> > > >> > +
> > > >> > +enum power_supply_property i1props@p1[] = { i1props_vals, };
> > > >> > +
> > > >> > +@getprops2@
> > > >> > +identifier tocheck.i2props;
> > > >> > +initializer list[n2] i2props_vals;
> > > >> > +position p2;
> > > >> > +@@
> > > >> > +
> > > >> > +enum power_supply_property i2props@p2[] = { i2props_vals, };
> > > >> > +
> > > >> > +@script:ocaml@
> > > >> > +(_,i1props_vals) << getprops1.i1props_vals;
> > > >> > +(_,i2props_vals) << getprops2.i2props_vals;
> > > >> > +i1props << tocheck.i1props;
> > > >> > +i2props << tocheck.i2props;
> > > >> > +p1 << getprops1.p1;
> > > >> > +p2 << getprops2.p2;
> > > >> > +@@
> > > >> > +
> > > >> > +if i1props < i2props &&
> > > >> > +   List.sort compare i1props_vals = List.sort compare i2props_vals
> > > >> > +then
> > > >> > +  let msg =
> > > >> > +    Printf.sprintf
> > > >> > +      "WARNING %s and %s (line %d) have the same properties\n"
> > > >>
> > > >> "are identical" vs "have the same..."
> > > >>
> > > >>
> > > >> > +      i1props i2props (List.hd p2).line in
> > > >> > +  print_report p1 msg
> > > >> >
> > > >> --
> > > >> To unsubscribe from this list: send the line "unsubscribe
> > > kernel-janitors" in
> > > >> the body of a message to majordomo@vger.kernel.org
> > > >> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > > >>
> > >
> --
> To unsubscribe from this list: send the line "unsubscribe kernel-janitors" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
