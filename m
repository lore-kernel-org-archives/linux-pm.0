From: Julia Lawall <julia.lawall@lip6.fr>
Subject: Re: [PATCH] coccinelle: api: detect duplicate chip data arrays
Date: Thu, 5 Oct 2017 21:40:08 +0200 (CEST)
Message-ID: <alpine.DEB.2.20.1710052138150.2626@hadrien>
References: <1506861768-5734-1-git-send-email-Julia.Lawall@lip6.fr>         <CAK7LNAQK7w3FBxJUhX3Vn48XsUT7jQzGDC7kzCx2r-yWm0CdEw@mail.gmail.com>         <alpine.DEB.2.20.1710052113090.2626@hadrien>         <1507230959.4434.39.camel@perches.com>        
 <alpine.DEB.2.20.1710052116480.2626@hadrien> <1507231856.4434.41.camel@perches.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323329-1897168193-1507232408=:2626"
Return-path: <kernel-janitors-owner@vger.kernel.org>
In-Reply-To: <1507231856.4434.41.camel@perches.com>
Sender: kernel-janitors-owner@vger.kernel.org
To: Joe Perches <joe@perches.com>
Cc: Masahiro Yamada <yamada.masahiro@socionext.com>, Liam Breck <liam@networkimprov.net>, Sebastian Reichel <sebastian.reichel@collabora.co.uk>, =?ISO-8859-15?Q?Pali_Roh=E1r?= <pali.rohar@gmail.com>, Linux PM mailing list <linux-pm@vger.kernel.org>, kernel-janitors@vger.kernel.org, Gilles Muller <Gilles.Muller@lip6.fr>, Nicolas Palix <nicolas.palix@imag.fr>, Michal Marek <mmarek@suse.com>, cocci@systeme.lip6.fr, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, kbuild test robot <fengguang.wu@intel.com>
List-Id: linux-pm@vger.kernel.org

--8323329-1897168193-1507232408=:2626
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT



On Thu, 5 Oct 2017, Joe Perches wrote:

> On Thu, 2017-10-05 at 21:19 +0200, Julia Lawall wrote:
> > On Thu, 5 Oct 2017, Joe Perches wrote:
> > > On Thu, 2017-10-05 at 21:13 +0200, Julia Lawall wrote:
> > > > On Fri, 6 Oct 2017, Masahiro Yamada wrote:
> > > > > 2017-10-01 21:42 GMT+09:00 Julia Lawall <Julia.Lawall@lip6.fr>:
> > > > > > This semantic patch detects duplicate arrays declared using BQ27XXX_DATA
> > > > > > within a single structure.  It is currently specific to the file
> > > > > > drivers/power/supply/bq27xxx_battery.c.
> > > > > > Signed-off-by: Julia Lawall <Julia.Lawall@lip6.fr>
> > > > > Applied to linux-kbuild/misc.
> > > > Thanks for picking it up.
> > > If it is specific to one file, why not just run it
> > > and post the resultant patch?  Why have it in tree?
> > I guess that they anticipate that the data may change in the future?
>
> Aren't you the script author Julia?  Who is the "they"?

Liam, etc.

> I think having a script for a single file unnecessary.
>
> btw: spatch 1.7 doesn't seem to have a tag in git
>
> From the script:
>
>     // Requires: 1.0.7
>
> Assuming this is correct, then this doesn't even run today
> except maybe on your system.

It runs on the current github version.  If you don't have the github
version it will suffer from false negatives, but nothing will break.

julia

> $ git show
> commit 0bf53049e64295e8ddb625e853134f49568f4bc3
> Merge: 446dc66f8b98 d599cc6a75e0
> Author: julia <julia.lawall@lip6.fr>
> Date:   Sun Oct 1 22:44:34 2017 +0200
>
>     Merge git+ssh://palace.lip6.fr/var/git/coccinelle
>
> $
>
> When I build this, the version is 1.0.6
>
> $ /usr/local/bin/spatch --version
> spatch version 1.0.6-00033-g23cca0a238c2 compiled with OCaml version 4.02.3
> Flags passed to the configure script: [none]
> Python scripting support: yes
> Syntax of regular expresssions: PCRE
>
> > If id-utils is used, Coccinelle will completely ignore files that don't
> > contain BQ27XXX_DATA, so the rule will have essentially no performance
> > impact.  If there is no indexing, it will only "grep" for BQ27XXX_DATA,
> > not actually parse the files that don't contain it.  So there is not much
> > performance impact even in that case.
>
> I'm not sure that matters.
>
> --
> To unsubscribe from this list: send the line "unsubscribe kernel-janitors" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
--8323329-1897168193-1507232408=:2626--
