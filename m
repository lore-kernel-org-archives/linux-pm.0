From: Julia Lawall <julia.lawall@lip6.fr>
Subject: Re: [PATCH] coccinelle: api: detect duplicate chip data arrays
Date: Thu, 5 Oct 2017 21:57:00 +0200 (CEST)
Message-ID: <alpine.DEB.2.20.1710052154310.2626@hadrien>
References: <1506861768-5734-1-git-send-email-Julia.Lawall@lip6.fr>                 <CAK7LNAQK7w3FBxJUhX3Vn48XsUT7jQzGDC7kzCx2r-yWm0CdEw@mail.gmail.com>                 <alpine.DEB.2.20.1710052113090.2626@hadrien>                 <1507230959.4434.39.camel@perches.com>
                 <alpine.DEB.2.20.1710052116480.2626@hadrien>         <1507231856.4434.41.camel@perches.com>         <alpine.DEB.2.20.1710052138150.2626@hadrien> <1507233246.4434.44.camel@perches.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail2-relais-roc.national.inria.fr ([192.134.164.83]:11922 "EHLO
        mail2-relais-roc.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751393AbdJET5C (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 5 Oct 2017 15:57:02 -0400
In-Reply-To: <1507233246.4434.44.camel@perches.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Joe Perches <joe@perches.com>
Cc: Masahiro Yamada <yamada.masahiro@socionext.com>, Liam Breck <liam@networkimprov.net>, Sebastian Reichel <sebastian.reichel@collabora.co.uk>, =?ISO-8859-15?Q?Pali_Roh=E1r?= <pali.rohar@gmail.com>, Linux PM mailing list <linux-pm@vger.kernel.org>, kernel-janitors@vger.kernel.org, Gilles Muller <Gilles.Muller@lip6.fr>, Nicolas Palix <nicolas.palix@imag.fr>, Michal Marek <mmarek@suse.com>, cocci@systeme.lip6.fr, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, kbuild test robot <fengguang.wu@intel.com>



On Thu, 5 Oct 2017, Joe Perches wrote:

> On Thu, 2017-10-05 at 21:40 +0200, Julia Lawall wrote:
> > On Thu, 5 Oct 2017, Joe Perches wrote:
> > > btw: spatch 1.7 doesn't seem to have a tag in git
> > >
> > > From the script:
> > >
> > >     // Requires: 1.0.7
> > >
> > > Assuming this is correct, then this doesn't even run today
> > > except maybe on your system.
> >
> > It runs on the current github version.  If you don't have the github
> > version it will suffer from false negatives, but nothing will break.
>
> fyi: there's no tag for 1.0.7 there either.

Yes, I know.  1.0.7 doesn't exist.  I didn't think it would be meaningful
to put the actual version I get with 1.0.6 with the commit id, because
commit ids aren't ordered.  I hoped that 1.0.7 would be released, but I
haven't gotten confirmation that all of the makefile issues have been
resolved.

julia
