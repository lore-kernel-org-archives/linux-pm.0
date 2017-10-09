From: Julia Lawall <julia.lawall@lip6.fr>
Subject: Re: [PATCH 0/2] detect identical chip data arrays
Date: Mon, 9 Oct 2017 10:40:14 +0200 (CEST)
Message-ID: <alpine.DEB.2.20.1710091038340.3252@hadrien>
References: <1507490321-24900-1-git-send-email-Julia.Lawall@lip6.fr> <20171008203258.y7kqx7ipondxlsix@earth> <alpine.DEB.2.20.1710082243140.2160@hadrien> <CAK7LNATGdz52SbYWD2bv7uYBQGVAHAK7xb9oJOgUVsTQJEPN5Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail3-relais-sop.national.inria.fr ([192.134.164.104]:3050 "EHLO
        mail3-relais-sop.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750795AbdJIIkR (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 9 Oct 2017 04:40:17 -0400
In-Reply-To: <CAK7LNATGdz52SbYWD2bv7uYBQGVAHAK7xb9oJOgUVsTQJEPN5Q@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: Sebastian Reichel <sebastian.reichel@collabora.co.uk>, Liam Breck <liam@networkimprov.net>, =?ISO-8859-15?Q?Pali_Roh=E1r?= <pali.rohar@gmail.com>, Linux PM mailing list <linux-pm@vger.kernel.org>, kernel-janitors@vger.kernel.org, Joe Perches <joe@perches.com>, Gilles Muller <Gilles.Muller@lip6.fr>, Nicolas Palix <nicolas.palix@imag.fr>, Michal Marek <mmarek@suse.com>, cocci@systeme.lip6.fr, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, kbuild test robot <fengguang.wu@intel.com>



On Mon, 9 Oct 2017, Masahiro Yamada wrote:

> 2017-10-09 5:44 GMT+09:00 Julia Lawall <julia.lawall@lip6.fr>:
> >
> >
> > On Sun, 8 Oct 2017, Sebastian Reichel wrote:
> >
> >> Hi,
> >>
> >> On Sun, Oct 08, 2017 at 09:18:39PM +0200, Julia Lawall wrote:
> >> > Rename battery.cocci as check_bq27xxx_data.cocci and adjust the warning
> >> > messages to indicate that some structures are the same, in response to
> >> > feedback from Liam Breck.
> >> >
> >> > Although check_bq27xxx_data.cocci says is requires Coccinelle 1.0.7, which
> >> > is not yet released, it actually works with the version currently available
> >> > on Github, eg from Coccinelle commit 3ba77b3a0f91.
> >>
> >> I think the rename makes sense, but I would expect the move to
> >> happen in one go with "git send-email -M", so that it detects the
> >> rename.
> >
> > I'm not actually sure what is the status of the previous version.
> > Masahiro said applied, but I downloaded his tree and it was not there.  So
> > I thought this way would be easier.
>
> My tree is here:
> git://git.kernel.org/pub/scm/linux/kernel/git/masahiroy/linux-kbuild.git
>
> I had applied your patch a few days before.

OK, I got that tree, but it seemed to go only up to October 1.  But maybe
I did not pick the right branch.

>
>
> BTW, how should I handle this series?
>
> 1/2 is reverting it.
>
> So, I can drop the previous one entirely,
> then pick up 2/2 only.
>
> Is this a good thing to do?

That would be perfectly fine with me.  You can drop 1/2 already.  For 2/2,
it would be nice to have an Ack from Liam first.

thanks,
julia

> --
> Best Regards
> Masahiro Yamada
> --
> To unsubscribe from this list: send the line "unsubscribe kernel-janitors" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
