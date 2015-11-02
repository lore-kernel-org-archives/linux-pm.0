From: Stephen Boyd <sboyd@codeaurora.org>
Subject: Re: [PATCH] PM / OPP: Protect updates to list_dev with mutex
Date: Mon, 2 Nov 2015 11:14:35 -0800
Message-ID: <20151102191435.GN19782@codeaurora.org>
References: <5f8fac4ad84716ef68fc50ab0b78e11ad2837524.1446205160.git.viresh.kumar@linaro.org>
 <20151030170604.GD19782@codeaurora.org>
 <20151031021409.GT3716@ubuntu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:39659 "EHLO
	smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751025AbbKBTOi (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 2 Nov 2015 14:14:38 -0500
Content-Disposition: inline
In-Reply-To: <20151031021409.GT3716@ubuntu>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, mturquette@baylibre.com, linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Dan Carpenter <dan.carpenter@oracle.com>, Dmitry Torokhov <dtor@chromium.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Len Brown <len.brown@intel.com>, open list <linux-kernel@vger.kernel.org>, Nishanth Menon <nm@ti.com>, Pavel Machek <pavel@ucw.cz>

On 10/31, Viresh Kumar wrote:
> On 30-10-15, 10:06, Stephen Boyd wrote:
> > On 10/30, Viresh Kumar wrote:
> > > dev_opp_list_lock is used everywhere to protect device and OPP lists,
> > > but dev_pm_opp_set_sharing_cpus() is missed somehow. And instead we used
> > > rcu-lock, which wouldn't help here as we are adding a new list_dev.
> > > 
> > > This also fixes a problem where we have called kzalloc(..., GFP_KERNEL)
> > > from within rcu-lock, which isn't allowed as kzalloc can sleep when
> > > called with GFP_KERNEL.
> > 
> > Care to share the splat here?
> 
> I don't know what is wrong (or right) with my exynos 5250 board, but I
> didn't got any splat here even with the right config options (yes I
> should have mentioned that earlier). I have seen this at other times
> as well, while we were running after some cpufreq traces..
> 
> But, the case in hand is pretty straight forward and Mike T. did get a
> splat as that's what he told me. We are calling a sleep-able function
> from rcu_lock and that's obviously wrong.

That's slightly concerning. Given that the bug is so straight
forward but we can't reproduce it doesn't instill a lot of
confidence that the patch is correct.

> 
> > > diff --git a/drivers/base/power/opp/cpu.c b/drivers/base/power/opp/cpu.c
> > > index 7654c5606307..91f15b2e25ee 100644
> > > --- a/drivers/base/power/opp/cpu.c
> > > +++ b/drivers/base/power/opp/cpu.c
> > > @@ -124,12 +124,12 @@ int dev_pm_opp_set_sharing_cpus(struct device *cpu_dev, cpumask_var_t cpumask)
> > >  	struct device *dev;
> > >  	int cpu, ret = 0;
> > >  
> > > -	rcu_read_lock();
> > > +	mutex_lock(&dev_opp_list_lock);
> > >  
> > >  	dev_opp = _find_device_opp(cpu_dev);
> > 
> > So does _find_device_opp() need to be called with rcu_read_lock()
> > held or not? The comment above the function makes it sound like
> > we need RCU, but we don't do that here anymore.
> 
> That is more for the readers, as this function is going to return a
> pointer to the device OPP, and to make sure it isn't freed behind
> their back, they need to take the RCU lock.
> 
> There are other writer code paths as well, like add-opp, where we just
> take the mutex as there can't be anything stronger than that :)
> 

Agreed, but the comment above the function is misleading. We
should correct that comment and/or add the lockdep checks to the
function like we have elsewhere in this file.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
