From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] PM / domains: Kconfig: always enable PM_RUNTIME when genpd enabled
Date: Mon, 17 Nov 2014 02:22:52 +0100
Message-ID: <6465990.KKns6W8hQE@vostro.rjw.lan>
References: <1415917702-6742-1-git-send-email-khilman@kernel.org> <7ha93t8z1q.fsf@deeprootsystems.com> <CAMuHMdVrpwg2pYxUhA5oRgd1g2DmLuSb2jR3ywz8hkjms7UBcw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:52070 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751612AbaKQBBv (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sun, 16 Nov 2014 20:01:51 -0500
In-Reply-To: <CAMuHMdVrpwg2pYxUhA5oRgd1g2DmLuSb2jR3ywz8hkjms7UBcw@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Kevin Hilman <khilman@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, Geert Uytterhoeven <geert+renesas@glider.be>, Linux PM list <linux-pm@vger.kernel.org>, linaro-kernel <linaro-kernel@lists.linaro.org>, Grygorii Strashko <grygorii.strashko@ti.com>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, open list <linux-kernel@vger.kernel.org>

On Saturday, November 15, 2014 01:32:01 PM Geert Uytterhoeven wrote:
> Hi Kevin,
> 
> On Fri, Nov 14, 2014 at 6:36 PM, Kevin Hilman <khilman@kernel.org> wrote:
> >> On Thu, Nov 13, 2014 at 11:28 PM, Kevin Hilman <khilman@kernel.org> wrote:
> >>> It makes little sense to use generic power domains without runtime PM.
> >>
> >> Does it?
> >> It still powers down the PM domains on system suspend (at least on my
> >> boards ;-)
> >
> > Sure, but your devices are also using runtime PM, so I'm not sure how
> > does that change my statement above?
> 
> I do mean with CONFIG_PM_RUNTIME turned off.
> 
> If PM domain support is disabled, s2ram will not power down the PM domains.

But if PM_RUNTIME is enabled along with it, I don't think it will make much
of a different, will it?

Building the kernel with genpd and without PM_RUNTIME is possible today,
but is it really useful?  To me, it only seems to make people try to
reinvent the wheel "because PM_RUNTIME may be unset".

I have to say I'm seriously considering to make PM_SLEEP select
PM_RUNTIME too as that would make quite a few things a *lot* simpler.


-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
