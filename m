From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [RESEND PATCH v2] thermal: tango: add resume support
Date: Mon, 18 Jul 2016 13:10:07 +0200
Message-ID: <2701749.GrMaU3rvHr@wuerfel>
References: <57726196.5060909@free.fr> <7689133.3ycKRvbtrh@wuerfel> <20160718101338.GB422@ulmo.ba.sec>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.126.134]:49605 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751696AbcGRLKx (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 18 Jul 2016 07:10:53 -0400
In-Reply-To: <20160718101338.GB422@ulmo.ba.sec>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: Thierry Reding <thierry.reding@gmail.com>, Sebastian Frias <sf84@laposte.net>, Kevin Hilman <khilman@kernel.org>, linux-pm <linux-pm@vger.kernel.org>, Mason <slash.tmp@free.fr>, Eduardo Valentin <edubezval@gmail.com>, Zhang Rui <rui.zhang@intel.com>

On Monday, July 18, 2016 12:13:38 PM CEST Thierry Reding wrote:
> On Mon, Jul 18, 2016 at 12:09:39PM +0200, Arnd Bergmann wrote:
> > On Monday, July 18, 2016 11:33:28 AM CEST Thierry Reding wrote:
> > 
> > > > +
> > > > +     return 0;
> > > > +}
> > > > +
> > > > +static SIMPLE_DEV_PM_OPS(tango_thermal_pm, NULL, tango_thermal_resume);
> > > > +
> > > > +#define DEV_PM_OPS   &tango_thermal_pm
> > > > +#else
> > > > +#define DEV_PM_OPS   NULL
> > > > +#endif
> > > 
> > > In my experience it's often not useful to #ifdef the struct pm_ops.
> > > These days you almost certainly want PM enabled, and the conditional
> > > doesn't save you all that much in the first place, because it's not
> > > unlikely for this to fit into some of the space that would be padded
> > > out anyway.
> > 
> > This will also generate a warning when CONFIG_PM_SLEEP is not set.
> > Better write this as
> > 
> > #define DEV_PM_OPS (IS_ENABLED(CONFIG_PM_SLEEP) ? &tango_thermal_pm : NULL)
> > 
> > so the compiler can drop the variable definition when it's not
> > needed.
> 
> My suggestion was to define tango_thermal_pm unconditionally to avoid
> any of these tricks. For any real use-case in which the 92 bytes for the
> struct dev_pm_ops would matter you most likely want PM_SLEEP anyway, so
> I don't really see why we would even want to make it optional.

Sure, leaving it unconditional works too. 

> > > As a side-note, I've noticed that this driver has the following
> > > dependencies:
> > > 
> > >         depends on ARCH_TANGO || COMPILE_TEST
> > > 
> > > which, last I checked, is probably going to fail on some architectures
> > > because you need at least another one on HAS_IOMEM (for readl() and
> > > writel()). That's a pre-existing problem, of course, so should be fixed
> > > in a separate patch.
> > 
> > No need, we just merged a patch to no longer allow COMPILE_TEST on
> > arch/um/, so we can safely rely on MMIO to be available for COMPILE_TEST.
> 
> I thought at least S390 didn't have readl() and writel() either, at
> least when PCI wasn't enabled, or some such.

Yes, but they've never complained about COMPILE_TEST breakage because
of that. Tile is in the same boat too in some configurations.

	Arnd

