From: Paul Mundt <lethal@linux-sh.org>
Subject: Re: [Update][PATCH 7/9] PM / Runtime: Add generic clock
	manipulation rountines for runtime PM
Date: Wed, 20 Apr 2011 07:20:04 +0900
Message-ID: <20110419222004.GA9664@linux-sh.org>
References: <201104130205.26988.rjw@sisk.pl> <201104192342.26670.rjw@sisk.pl>
	<20110419215944.GA10031@linux-sh.org>
	<201104200010.50656.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <201104200010.50656.rjw@sisk.pl>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: linux-sh@vger.kernel.org, Greg KH <gregkh@suse.de>, LKML <linux-kernel@vger.kernel.org>, Grant Likely <grant.likely@secretlab.ca>, Linux PM mailing list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Wed, Apr 20, 2011 at 12:10:50AM +0200, Rafael J. Wysocki wrote:
> On Tuesday, April 19, 2011, Paul Mundt wrote:
> > On Tue, Apr 19, 2011 at 11:42:26PM +0200, Rafael J. Wysocki wrote:
> > > On Tuesday, April 19, 2011, Magnus Damm wrote:
> > > > Do you have any plans to add support for multiple clocks per struct
> > > > device? I had some plans to play around with that myself, but if we're
> > > > moving the code to a common place then this obviously becomes a bit
> > > > more complicated.
> > > > 
> > > > It's rather common that each hardware block in an SoC is connected to
> > > > more than a single clock. This needs to be managed by software
> > > > somehow.
> > > > 
> > > > So if the plan is to make to the code generic, how about allowing the
> > > > architecture to associate clocks with each struct device somehow?
> > > 
> > > Hmm.  For now, my patchset generally reorganizes the existing code without
> > > adding new functionality.  Of course, it is possible to add new functionality
> > > on top of it, but I'd prefer to focus on the "real" power domains support
> > > first (which I think should be done in a generic way too).
> > > 
> > Multiple clocks is not new functionality, it's the common case for the
> > bulk of the platforms, and something that is already presently handled.
> 
> OK
> 
> > > The plan is to share as much code as it makes sense between platforms and
> > > architectures.
> > 
> > An admirable plan, but the framework needs to be able to provide at least
> > the current required level of functionality in order for it to be
> > adopted, too.
> 
> Sure.
> 
> > On Mon, Apr 18, 2011 at 09:57:28PM +0200, Rafael J. Wysocki wrote:
> > > @@ -24,23 +24,18 @@
> > >  #ifdef CONFIG_PM_RUNTIME
> > >  static int omap1_pm_runtime_suspend(struct device *dev)
> > >  {
> > > -	struct clk *iclk, *fclk;
> > > -	int ret = 0;
> > > +	int ret;
> > >  
> > >  	dev_dbg(dev, "%s\n", __func__);
> > >  
> > >  	ret = pm_generic_runtime_suspend(dev);
> > > +	if (ret)
> > > +		return ret;
> > >  
> > > -	fclk = clk_get(dev, "fck");
> > > -	if (!IS_ERR(fclk)) {
> > > -		clk_disable(fclk);
> > > -		clk_put(fclk);
> > > -	}
> > > -
> > > -	iclk = clk_get(dev, "ick");
> > > -	if (!IS_ERR(iclk)) {
> > > -		clk_disable(iclk);
> > > -		clk_put(iclk);
> > > +	ret = pm_runtime_clock_suspend(dev);
> > > +	if (ret) {
> > > +		pm_generic_runtime_resume(dev);
> > > +		return ret;
> > >  	}
> > >  
> > >  	return 0;
> > 
> > The before and after changes here are not functionally equivalent. You've
> > gone from an explicit multi-clock scheme to a single encapsulated one via
> > pm_runtime_clock_suspend().
> 
> You're refferring to the OMAP changes I suppose?

Yes, but we have similar use cases on SH, too.

> > Almost every single SH IP block is likewise abstracted in to a function
> > and interface clock, and OMAP and others are where we modelled this
> > abstraction on top of in the first place, so there are certainly users
> > there too.
> 
> In fact, the shmobile runtime PM code in arch/arm/mach-shmobile/pm_runtime.c
> uses only one clock right now.
> 
That's more due to general laziness than design. The code in
arch/sh/kernel/cpu/shmobile/pm_runtime.c goes through a hwblk abstraction
that functionally maps out for some CPUs via one API what is the function
clock on other CPUs. The hwblk API was never carried over to the ARM
side, and so a simplistic single clock case was implemented instead, and
the drivers with multiple clocks all performed manual clock gating on
their multiple clocks outside of the context of runtime PM.

OMAP1 clearly has a demonstratable case for multiple clocks that are
runtime PM managed, and this is exactly the sort of use case that SH
requires, too. If we can migrate off of and kill off some short-lived
ill-conceived APIs in the process, great. IOW, if you solve the OMAP1
problem then we can easily fix up ARM SH/R-Mobile and regular SH parts to
comply uniformly.
