From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
        <u.kleine-koenig@pengutronix.de>
Subject: Re: Clocks used by another OS/CPU (was: Re: [RFC PATCH] clk:
 renesas: cpg-mssr: Add interface for critical core clocks)
Date: Fri, 30 Jun 2017 22:24:53 +0200
Message-ID: <20170630202453.eh6vaehkap3as4np@pengutronix.de>
References: <CAMuHMdW9+CNTTOVO4SRRUxuz3ajLbY2j1uG8b_RpHX52NPwXrQ@mail.gmail.com>
 <CAL_JsqKGrZeR7z80beY_XEjqd5fEQQwPxusJ1FADoALgNE3fEg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-clk-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAL_JsqKGrZeR7z80beY_XEjqd5fEQQwPxusJ1FADoALgNE3fEg@mail.gmail.com>
Sender: linux-clk-owner@vger.kernel.org
To: Rob Herring <robh+dt@kernel.org>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, Mark Rutland <mark.rutland@arm.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, Dirk Behme <dirk.behme@de.bosch.com>, Linux PM list <linux-pm@vger.kernel.org>, Stephen Boyd <sboyd@codeaurora.org>, Michael Turquette <mturquette@baylibre.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux-Renesas <linux-renesas-soc@vger.kernel.org>, Kevin Hilman <khilman@baylibre.com>, linux-clk <linux-clk@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-pm@vger.kernel.org

Hello,

On Fri, Jun 30, 2017 at 10:58:26AM -0500, Rob Herring wrote:
> > TL;DR: Clocks may be in use by another CPU not running Linux, while Linux
> > disables them as being unused.

not long ago I thought with a few colleagues about this. The scenario is
to start a Linux kernel on a Cortex-M companion to a Cortex-A.

> > On Mon, Jun 26, 2017 at 1:30 PM, Dirk Behme <dirk.behme@de.bosch.com> wrote:
> >> With commit 72f5df2c2bbb6 ("clk: renesas: cpg-mssr: Migrate to
> >> CLK_IS_CRITICAL") we are able to handle critical module clocks.
> >> Introduce the same logic for critical core clocks.
> >>
> >> Signed-off-by: Dirk Behme <dirk.behme@de.bosch.com>
> >> ---
> >> Commit
> >>
> >> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/drivers/clk/renesas?id=72f5df2c2bbb66d4a555cb51eb9f412abf1af77f
> >>
> >> is quite nice to avoid *module* clocks being disabled. Unfortunately,
> >> there are *core* clocks, too. E.g. using an other OS on the Cortex R7
> >> core of the r8a7795, the 'canfd' is a quite popular core clock which
> >> shouldn't be disabled by Linux.
> >>
> >> Therefore, this patch is a proposal to use the same 'mark clocks as
> >> critical' logic implemented for the module clocks for the core
> >> clocks, too.
> >>
> >> Opinions?
> >
> > On r8a7795, there are several Cortex A cores running Linux, and a Cortex R7
> > core which may run another OS.
> > This is an interesting issue, and relevant to other SoCs, too.
> >
> > In this particular case, the "canfd" clock is a core clock used as an
> > auxiliary clock for the CAN0, CAN1, and CANFD interfaces.  This can lead
> > to three scenarios:
> >   1. Linux controls all CAN interfaces
> >      => no issue,
> >   2. The OS on the RT CPU controls all CAN interfaces
> >      => issue, Linux disables the clock
> >   3. Mix of 1 and 2
> >      => More issues.
> > Of course this is not limited to clocks, but also to e.g. PM domains.
> >
> > How can this be handled?
> > I believe just marking the "canfd" clock critical is not the right solution,
> > as about any clock could be used by the RT CPU.
> >
> > Still, Linux needs to be made aware that devices (clocks and PM domains) are
> > controlled by another CPU/OS.
> >
> > Should this be described in DT? It feels like software policy to me.
> 
> No, it shouldn't. It is Linux policy to disable all unused clocks, so
> Linux gets to deal with the consequences.

The ideal solution I imagine is to make the other CPU's OS a consumer of
the Linux clock driver. This would require a generic device driver on the
companion CPU that forwards clk requests via inter-cpu communication to
the Linux clk driver. It could be feed with the necessary information by
the rproc glue. So when the companion cpu is supposed to care for the
can0 device, the steps that should happen are:

 - make sure can0 isn't occupied by the Linux Host
 - reroute the can irq to the companion cpu (if necessary)
 - create a dtb containing something like this for the companion CPU:

 	clks: virtclk {
		compatible = ???
		#clock-cells = <1>;
		...
	};

	can@$address {
		compatible = ...
		regs = ...
		clocks = <&clks 3>;
		clock-names = ...
		...
	};

   where the driver binding to the virtclk device just forwards clk
   requests to the Linux host side which then knows that clk 3 is the
   can clock and does the necessary stuff.

This way the can clock doesn't need special handling in the host's dtb
and no clock necessary for the companion is disabled as unused because
it is requested and enabled.

The only problem I see is that implementing such a driver/protocol
probably is time consuming.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
