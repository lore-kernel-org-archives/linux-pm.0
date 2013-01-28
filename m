From: Nishanth Menon <nm@ti.com>
Subject: Re: [PATCH] cpufreq: instantiate cpufreq-cpu0 as a platform_driver
Date: Mon, 28 Jan 2013 12:20:11 -0600
Message-ID: <20130128182011.GA6704@kahuna>
References: <1359208550-16402-1-git-send-email-shawn.guo@linaro.org>
 <7196597.b9sJl95POM@vostro.rjw.lan>
 <20130128083159.GD31689@S2101-09.ap.freescale.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <cpufreq-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20130128083159.GD31689@S2101-09.ap.freescale.net>
Sender: cpufreq-owner@vger.kernel.org
To: Shawn Guo <shawn.guo@linaro.org>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, AnilKumar Ch <anilkumar@ti.com>, Mark Langsdorf <mark.langsdorf@calxeda.com>, linux-arm-kernel@lists.infradead.org, cpufreq@vger.kernel.org, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On 16:32-20130128, Shawn Guo wrote:
> On Sat, Jan 26, 2013 at 11:21:27PM +0100, Rafael J. Wysocki wrote:
> > On Saturday, January 26, 2013 09:55:50 PM Shawn Guo wrote:
> > > As multiplatform build is being adopted by more and more ARM platforms,
> > > initcall function should be used very carefully.  For example, when
> > > GENERIC_CPUFREQ_CPU0 is built in the kernel, cpu0_cpufreq_driver_init()
> > > will be called on all the platforms to initialize cpufreq-cpu0 driver.
> > > 
> > > To eliminate this undesired the effect, the patch changes cpufreq-cpu0
> > > driver to have it instantiated as a platform_driver.  Then it will only
> > > run on platforms that create the platform_device "cpufreq-cpu0".
> > > 
> > > Along with the change, it also changes cpu_dev to be &pdev->dev,
> > > so that managed functions can start working, and module build gets
> > > supported too.
> > > 
> > > Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
> > > ---
> > > Rafael,
> > > 
> > > The patch depends patch "power: export opp cpufreq functions".
> > > https://patchwork.kernel.org/patch/1847261/
> > 
> > That one should use EXPORT_SYMBOL_GPL() for exporting symbols, though.
> > 
> When commit 80126ce (PM / OPP: Export symbols for module usage.)
> already exported a few symbols with EXPORT_SYMBOL()?

I have split this out as a separate OPP series with a variant of 
https://patchwork.kernel.org/patch/1847261/ added at last.
Will post this out in a few mins.

-- 
Regards,
Nishanth Menon
