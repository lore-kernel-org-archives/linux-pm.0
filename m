From: Wang Dongsheng-B40534 <B40534@freescale.com>
Subject: RE: [PATCH] cpuidle: add freescale e500 family porcessors idle
 support
Date: Wed, 31 Jul 2013 06:30:06 +0000
Message-ID: <ABB05CD9C9F68C46A5CEDC7F15439259FF2AAC@039-SN2MPN1-021.039d.mgd.msft.net>
References: <1375167603-16722-1-git-send-email-dongsheng.wang@freescale.com>
 (from	dongsheng.wang@freescale.com on Tue Jul 30 02:00:03 2013)
 <1375213104.30721.79@snotra>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from co1ehsobe001.messaging.microsoft.com ([216.32.180.184]:17609
	"EHLO co1outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752865Ab3GaGaL convert rfc822-to-8bit
	(ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Wed, 31 Jul 2013 02:30:11 -0400
In-Reply-To: <1375213104.30721.79@snotra>
Content-Language: en-US
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Wood Scott-B07421 <B07421@freescale.com>
Cc: "rjw@sisk.pl" <rjw@sisk.pl>, "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>, "benh@kernel.crashing.org" <benh@kernel.crashing.org>, Li Yang-R58472 <r58472@freescale.com>, Zhao Chenhui-B35336 <B35336@freescale.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>



> -----Original Message-----
> From: Wood Scott-B07421
> Sent: Wednesday, July 31, 2013 3:38 AM
> To: Wang Dongsheng-B40534
> Cc: rjw@sisk.pl; daniel.lezcano@linaro.org; benh@kernel.crashing.org; Li
> Yang-R58472; Zhao Chenhui-B35336; linux-pm@vger.kernel.org; linuxppc-
> dev@lists.ozlabs.org
> Subject: Re: [PATCH] cpuidle: add freescale e500 family porcessors idle
> support
> 
> On 07/30/2013 02:00:03 AM, Dongsheng Wang wrote:
> > From: Wang Dongsheng <dongsheng.wang@freescale.com>
> >
> > Add cpuidle support for e500 family, using cpuidle framework to
> > manage various low power modes. The new implementation will remain
> > compatible with original idle method.
> >
> > Initially, this supports PW10, and subsequent patches will support
> > PW20/DOZE/NAP.
> 
> Could you explain what the cpuidle framework does for us that the
> current idle code doesn't?
> 

The current idle code, Only a state of low power can make the core idle.
The core can't get into more low power state.

> In particular, what scenario do you see where we would require a
> software
> governor to choose between idle states, and how much power is saved
> compared to a simpler approach?  There is timer that can be used to
> automatically enter PW20 after a certain amount of time in PW10.

Yes, the hardware can automatically enter PW20 state. But this is hardware
feature, we need to software to manage it. Only for PW20 state, we can drop
this cpuidle and using the hardware to control it. But if we need to support
PH10/PH15/PH20/PH30, the current idle code cannot support them. 

> How much better results do you get from a software governor?  Do we even
> have the right data to characterize each state so that a software governor
> could make good decisions?  Is cpuidle capable of governing the interval
> of such a timer, rather than directly governing states?
> 
>From now on we did not benchmark these data, because we only have PW10 state.

I can do support doze/nap for e6500. To get some data to show you.

> As for doze/nap, why would we want to use those on newer cores?  Do you
> have numbers for how much power each mode saves?
> 
The PH state is plan to support, if the core can make into more low power state,
why not to do this.

PH10(doze)/PH15(nap)/PH20/PH30, These states can save more CPU power.

> Active governors may be useful on older cores that only have doze/nap,
> to
> select between them, but if that's the use case then why start with
> pw10?
Pw10 is supported on E500MC/E5500/E6500. And we plan to support PW20 for E65OO core.
I will take doze/nap up a bit later.

> And I'd want to see numbers for how much power nap saves versus doze.
> 
> > Signed-off-by: Wang Dongsheng <dongsheng.wang@freescale.com>
> > ---
> > This patch keep using cpuidle_register_device(), because we need to
> > support cpu
> > hotplug. I will fix "device" issue in this driver, after
> > Deepthi Dharwar <deepthi@linux.vnet.ibm.com> add a hotplug handler
> > into cpuidle
> > freamwork.
> 
> Where's the diffstat?
> 
See, http://patchwork.ozlabs.org/patch/260997/

> > @@ -0,0 +1,222 @@
> > +/*
> > + * Copyright 2013 Freescale Semiconductor, Inc.
> > + *
> > + * CPU Idle driver for Freescale PowerPC e500 family processors.
> > + *
> > + * This program is free software; you can redistribute it and/or
> > modify
> > + * it under the terms of the GNU General Public License version 2 as
> > + * published by the Free Software Foundation.
> > + *
> > + * Author: Wang Dongsheng <dongsheng.wang@freescale.com>
> > + */
> 
> Is this derived from some other file?  It looks like it...  Where's the
> attribution?
> 
The copyright is from drivers/cpufreq/ppc-corenet-cpufreq.c

> > +#include <linux/cpu.h>
> > +#include <linux/cpuidle.h>
> > +#include <linux/init.h>
> > +#include <linux/kernel.h>
> > +#include <linux/module.h>
> > +#include <linux/notifier.h>
> > +
> > +#include <asm/machdep.h>
> > +
> > +static struct cpuidle_driver e500_idle_driver = {
> > +	.name = "e500_idle",
> > +	.owner = THIS_MODULE,
> > +};
> > +
> > +static struct cpuidle_device __percpu *e500_cpuidle_devices;
> > +
> > +static void e500_cpuidle(void)
> > +{
> > +	/*
> > +	 * This would call on the cpuidle framework, and the back-end
> > +	 * driver to go to idle states.
> > +	 */
> > +	if (cpuidle_idle_call()) {
> > +		/*
> > +		 * On error, execute default handler
> > +		 * to go into low thread priority and possibly
> > +		 * low power mode.
> > +		 */
> > +		HMT_low();
> > +		HMT_very_low();
> 
> This HMT stuff doesn't do anything on e500 derivatives AFAIK.
> 
Yes, there should do nothing, let arch_cpu_idle to do the failed.

> > +static struct cpuidle_state fsl_pw_idle_states[] = {
> > +	{
> > +		.name = "pw10",
> > +		.desc = "pw10",
> > +		.flags = CPUIDLE_FLAG_TIME_VALID,
> > +		.exit_latency = 0,
> > +		.target_residency = 0,
> > +		.enter = &pw10_enter
> 
> Where is pw10_enter defined?
> 
In this patch..

> > +static int cpu_is_feature(unsigned long feature)
> > +{
> > +	return (cur_cpu_spec->cpu_features == feature);
> > +}
> > +
> > +static int __init e500_idle_init(void)
> > +{
> > +	struct cpuidle_state *cpuidle_state_table = NULL;
> > +	struct cpuidle_driver *drv = &e500_idle_driver;
> > +	int err;
> > +	unsigned int max_idle_state = 0;
> > +
> > +	if (cpuidle_disable != IDLE_NO_OVERRIDE)
> > +		return -ENODEV;
> > +
> > +	if (cpu_is_feature(CPU_FTRS_E500MC) ||
> > cpu_is_feature(CPU_FTRS_E5500) ||
> > +			cpu_is_feature(CPU_FTRS_E6500)) {
> 
> There's no guarantee that a CPU with the same set of features is the
> exact same CPU.
> 
> What specific feature are you looking for here?
> 
Here is the type of the core. E500MC,E5500,E6500 do wait.

> > +		cpuidle_state_table = fsl_pw_idle_states;
> > +		max_idle_state = ARRAY_SIZE(fsl_pw_idle_states);
> > +	}
> > +
> > +	if (!cpuidle_state_table || !max_idle_state)
> > +		return -EPERM;
> 
> ENODEV?
> 
Looks better than EPERM.

-dongsheng

