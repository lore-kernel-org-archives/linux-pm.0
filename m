From: Mark Brown <broonie@sirena.org.uk>
Subject: Re: [RFC PATCH] PM: Introduce generic DVFS
	framework	with device-specific OPPs
Date: Wed, 27 Apr 2011 19:58:09 +0100
Message-ID: <20110427185809.GE12249@sirena.org.uk>
References: <BANLkTi=GVZnZuXmbK54Swi8Nv9ZZGhZcNw@mail.gmail.com>
	<20110427183430.GC12249@sirena.org.uk>
	<BANLkTinufd6SeYWCJ8GsQYHBfWi3beu=Ag@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <BANLkTinufd6SeYWCJ8GsQYHBfWi3beu=Ag@mail.gmail.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Colin Cross <ccross@google.com>
Cc: Nishanth Menon <nm@ti.com>, Len Brown <len.brown@intel.com>, Kevin Hilman <khilman@deeprootsystems.com>, Greg Kroah-Hartman <gregkh@suse.de>, Kyungmin Park <kyungmin.park@samsung.com>, MyungJoo Ham <myungjoo.ham@samsung.com>, linux-pm@lists.linux-foundation.org, Thomas Gleixner <tglx@linutronix.de>
List-Id: linux-pm@vger.kernel.org

On Wed, Apr 27, 2011 at 11:45:18AM -0700, Colin Cross wrote:

> Then TI (and other vendors) are providing one table that specifies two
> things - the relationship between frequency and voltage for each
> clock, and the relationship between multiple clocks for optimal

I imagine you'll also see some of the constraints coming from other
sources (thermal was mentioned, for example).  

> performance.  Mixing those in the kernel breaks platforms (like Tegra)
> that do not have any relationship between multiple clocks.

I'm not sure why this is a problem, presumably you can either define a
lot of simple OPP domains or not use the relevant infrastructure?  If we
can't cope with that sort of scenario then we'd also be unable to cope
with two distinct chips simultaneously using the infrastructure which
seems like an obvious use case.

> Can you point me to a platform that implements keeping multiple clocks
> changing between OPPs together?  As far as I can tell, OMAP4 always
> does dev -> clk, clk -> freq, dev + freq -> voltage, and never looks
> at multiple clocks.

I don't know that I've got anything I can publish, sorry.

> > This comes back to the thing we were discussing in the thread there
> > about there being n:m constraints between settings. ?I've not looked at
> > this in any detail but it may be that for the systems which spec things
> > as operating points we want to root the core clocking in an operating
> > point block which deals with stuff like this.

> On some platforms there may be a need for some global clock governor,
> which can keep multiple clocks in sync, but I haven't seen one for
> which that is truly required.

I gather that with a lot of this stuff there's a big difference between
what works and what people are willing to sign off on over all process
variations, possible timing conditions and so on.
