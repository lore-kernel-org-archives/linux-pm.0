From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
        <u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: Re: Clocks used by another OS/CPU (was: Re: [RFC PATCH] clk:
 renesas: cpg-mssr: Add interface for critical core clocks)
Date: Sun, 2 Jul 2017 11:23:36 +0200
Message-ID: <20170702092336.uxwl23kyd4koxclj@pengutronix.de>
References: <CAMuHMdW9+CNTTOVO4SRRUxuz3ajLbY2j1uG8b_RpHX52NPwXrQ@mail.gmail.com>
 <CAL_JsqKGrZeR7z80beY_XEjqd5fEQQwPxusJ1FADoALgNE3fEg@mail.gmail.com>
 <20170630202453.eh6vaehkap3as4np@pengutronix.de>
 <8d86a9aa-1928-6b52-1487-d5fb9dae17f4@gmail.com>
 <20170701181408.yuocymwtj5dgt74d@pengutronix.de>
 <6098d579-f206-5a23-bbfc-ac13e0448479@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <6098d579-f206-5a23-bbfc-ac13e0448479-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Dirk Behme <dirk.behme-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Dirk Behme <dirk.behme-V5te9oGctAVWk0Htik3J/w@public.gmane.org>, Linux PM list <linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "Rafael J. Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>, Michael Turquette <mturquette-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, Stephen Boyd <sboyd-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Linux-Renesas <linux-renesas-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>, Kevin Hilman <khilman-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, linux-clk <linux-clk-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org
List-Id: linux-pm@vger.kernel.org

Hello Dirk,

On Sun, Jul 02, 2017 at 07:48:41AM +0200, Dirk Behme wrote:
> > On my machine (Udoo Neo, A9 + M4) the A9 is the primary CPU that is
> > started by the bootrom. If I want the M4 being the primary device I'd
> > need support in the bootloader to wait long enough (i.e. until the M4 is
> > up) before letting the A9 jump into Linux. Managable I'd say. This way
> > would even make sense if the M4 runs a rt critical OS that shouldn't be
> > forced to wait on the non-rt A9 to enable a clk.
> 
> 
> Overall, assuming that the issue we are discussing here can be solved quite
> easily in hardware (a set of clock registers for each CPU/OS domain,
> connected cleverly to effectively control each clock, with access protection
> for each set of registers) I tend to think that for a SoC supposed to run
> different OS on different cores this is a missing hardware feature (bug?).

So you want to enable bits for your CAN clock, one in each cpu's domain.

I'd say that is a nice idea that a hardware engineer might be proud to
pick up but that results in more headache than fun for the software
colleague.

There are several problems that come immediately to mind:

 - You can switch of a clk because you don't need it on, or because you
   need it off. I guess you want to have the clock on if at least one
   cpu wants it on. So you take away the freedom from the other cpu to
   force the clock off. (Yeah, the currently available clk framework
   doesn't allow that either.)
 - What if cpu 0 sets the parent of the can clk to pll2 but cpu 1 wants
   it set to pll1? How does cpu 1 notice the change?
 - On off might be relatively easy, what about clk dividers? cpu 0 sets
   2 which cpu 1 sets 6.

That convinces me that the disadvantages of having two views on the clk
core have more weight and you really want a single view and share that
by software.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
