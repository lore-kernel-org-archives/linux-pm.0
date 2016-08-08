From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] PM / Domains: Replace -ENOSYS with -ENODEV
Date: Mon, 08 Aug 2016 15:04:06 +0200
Message-ID: <1621597.SvhxW48HpN@vostro.rjw.lan>
References: <1470416816-53336-1-git-send-email-lina.iyer@linaro.org> <CAJZ5v0hXNDRCztvDDii+qKEDz26W16e=eq9yDB+59G-AVrKhMw@mail.gmail.com> <CAMuHMdWKKEt2qq1pMt8YBtgq4DuSV6BJhAemVdNv34p8A44Z9Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:54365 "HELO
	cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1752014AbcHHM6s (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 8 Aug 2016 08:58:48 -0400
In-Reply-To: <CAMuHMdWKKEt2qq1pMt8YBtgq4DuSV6BJhAemVdNv34p8A44Z9Q@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Lukas Wunner <lukas@wunner.de>, Lina Iyer <lina.iyer@linaro.org>, Ulf Hansson <ulf.hansson@linaro.org>, Linux PM <linux-pm@vger.kernel.org>

On Monday, August 08, 2016 11:11:11 AM Geert Uytterhoeven wrote:
> Hi Rafael,
> 
> On Sat, Aug 6, 2016 at 12:17 AM, Rafael J. Wysocki <rafael@kernel.org> wrote:
> > On Fri, Aug 5, 2016 at 9:43 PM, Lukas Wunner <lukas@wunner.de> wrote:
> >> On Fri, Aug 05, 2016 at 11:06:56AM -0600, Lina Iyer wrote:
> >>> ENOSYS is for syscalls that are not supported. ENODEV is a better return
> >>> value when the PM Domains are not available.
> >>>
> >>> Signed-off-by: Lina Iyer <lina.iyer@linaro.org>
> >>
> >> I have no opinion on this, but would like to point out that other parts
> >> in the PM core use -ENOSYS as well (e.g. see drivers/base/power/core.c).
> >> For consistency, if pm_domain.h is changed, the rest should probably be
> >> changed as well.
> 
> ENOSYS has been used to indicate "functionality not supported" all over the
> place...
> 
> > I agree here.  Changing one piece only is likely to result in confusion.
> >
> > Also I'm not sure if ENODEV is a good replacement at all.  ENOTSUPP
> > was suggested instead last time a similar patch was discussed.
> >
> >> It should also be kept in mind that functions might
> >> check the return code and react specifically to the currently used -ENOSYS.
> >> (I've written code like that just yesterday, for the (unmerged) thunderbolt
> >> runtime pm.)
> >
> > But I wouldn't write code doing something like this.
> 
> (in the general case, not limited to PM) What to do instead, if you know a
> dummy function returns -ENOSYS and you need to react on that?

Use IS_ENABLED()?

That at least will make the intention clear to an occasional reader of the code.

> In these cases the exact error code is a contract between caller and
> callee.

That's fair enough.

Thanks,
Rafael

