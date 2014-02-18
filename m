From: Shawn Guo <shawn.guo@linaro.org>
Subject: Re: [PATCH] cpufreq: Kconfig.arm: Do not select GENERIC_CPUFREQ_CPU0
Date: Tue, 18 Feb 2014 10:26:21 +0800
Message-ID: <20140218022619.GD15716@S2101-09.ap.freescale.net>
References: <1392662127-31005-1-git-send-email-fabio.estevam@freescale.com>
 <8017605.Hn2oDKGgE8@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from am1ehsobe001.messaging.microsoft.com ([213.199.154.204]:31565
	"EHLO am1outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751221AbaBRCZO (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 17 Feb 2014 21:25:14 -0500
Content-Disposition: inline
In-Reply-To: <8017605.Hn2oDKGgE8@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Fabio Estevam <fabio.estevam@freescale.com>, viresh.kumar@linaro.org, festevam@gmail.com, linux-pm@vger.kernel.org

On Mon, Feb 17, 2014 at 10:54:08PM +0100, Rafael J. Wysocki wrote:
> On Monday, February 17, 2014 03:35:27 PM Fabio Estevam wrote:
> > Currently the following warnings are generated when building multi_v7_defconfig:
> > 
> > $ make multi_v7_defconfig 
> > warning: (ARM_HIGHBANK_CPUFREQ) selects GENERIC_CPUFREQ_CPU0 which has unmet direct dependencies (ARCH_HAS_CPUFREQ && CPU_FREQ && HAVE_CLK && REGULATOR && OF && THERMAL && CPU_THERMAL)
> > # configuration written to .config
> > 
> > ARM_HIGHBANK_CPUFREQ can be built with GENERIC_CPUFREQ_CPU0=n, so remove this
> > selection.
> > 
> > Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
> 
> Viresh, Shawn, I need to know if this breaks anything.
> 
> > ---
> >  drivers/cpufreq/Kconfig.arm | 1 -
> >  1 file changed, 1 deletion(-)
> > 
> > diff --git a/drivers/cpufreq/Kconfig.arm b/drivers/cpufreq/Kconfig.arm
> > index 3129749..bdd3ff9 100644
> > --- a/drivers/cpufreq/Kconfig.arm
> > +++ b/drivers/cpufreq/Kconfig.arm
> > @@ -84,7 +84,6 @@ config ARM_EXYNOS_CPU_FREQ_BOOST_SW
> >  config ARM_HIGHBANK_CPUFREQ
> >  	tristate "Calxeda Highbank-based"
> >  	depends on ARCH_HIGHBANK
> > -	select GENERIC_CPUFREQ_CPU0

Dropping this selection does not break build of highbank cpufreq driver,
but will result in a non-functional driver.  So maybe we need

	depends on GENERIC_CPUFREQ_CPU0

Shawn

> >  	select PM_OPP
> >  	select REGULATOR
> >  
> > 
> 
> -- 
> I speak only for myself.
> Rafael J. Wysocki, Intel Open Source Technology Center.

