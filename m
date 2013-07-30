From: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH] cpuidle: add freescale e500 family porcessors idle
 support
Date: Tue, 30 Jul 2013 14:38:24 -0500
Message-ID: <1375213104.30721.79@snotra>
References: <1375167603-16722-1-git-send-email-dongsheng.wang@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; delsp=Yes; format=Flowed
Content-Transfer-Encoding: 8BIT
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from co1ehsobe001.messaging.microsoft.com ([216.32.180.184]:31809
	"EHLO co1outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756860Ab3G3Tic convert rfc822-to-8bit
	(ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Tue, 30 Jul 2013 15:38:32 -0400
In-Reply-To: <1375167603-16722-1-git-send-email-dongsheng.wang@freescale.com> (from
	dongsheng.wang@freescale.com on Tue Jul 30 02:00:03 2013)
Content-Disposition: inline
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Dongsheng Wang <dongsheng.wang@freescale.com>
Cc: rjw@sisk.pl, daniel.lezcano@linaro.org, benh@kernel.crashing.org, leoli@freescale.com, chenhui.zhao@freescale.com, linux-pm@vger.kernel.org, linuxppc-dev@lists.ozlabs.org

On 07/30/2013 02:00:03 AM, Dongsheng Wang wrote:
> From: Wang Dongsheng <dongsheng.wang@freescale.com>
> 
> Add cpuidle support for e500 family, using cpuidle framework to
> manage various low power modes. The new implementation will remain
> compatible with original idle method.
> 
> Initially, this supports PW10, and subsequent patches will support
> PW20/DOZE/NAP.

Could you explain what the cpuidle framework does for us that the  
current
idle code doesn't?

In particular, what scenario do you see where we would require a  
software
governor to choose between idle states, and how much power is saved
compared to a simpler approach?  There is timer that can be used to
automatically enter PW20 after a certain amount of time in PW10.  How
much better results do you get from a software governor?  Do we even  
have
the right data to characterize each state so that a software governor
could make good decisions?  Is cpuidle capable of governing the interval
of such a timer, rather than directly governing states?

As for doze/nap, why would we want to use those on newer cores?  Do you
have numbers for how much power each mode saves?

Active governors may be useful on older cores that only have doze/nap,  
to
select between them, but if that's the use case then why start with  
pw10?
And I'd want to see numbers for how much power nap saves versus doze.

> Signed-off-by: Wang Dongsheng <dongsheng.wang@freescale.com>
> ---
> This patch keep using cpuidle_register_device(), because we need to  
> support cpu
> hotplug. I will fix "device" issue in this driver, after
> Deepthi Dharwar <deepthi@linux.vnet.ibm.com> add a hotplug handler  
> into cpuidle
> freamwork.

Where's the diffstat?

> diff --git a/arch/powerpc/include/asm/machdep.h  
> b/arch/powerpc/include/asm/machdep.h
> index 8b48090..cbdbe25 100644
> --- a/arch/powerpc/include/asm/machdep.h
> +++ b/arch/powerpc/include/asm/machdep.h
> @@ -271,6 +271,16 @@ extern void power7_idle(void);
>  extern void ppc6xx_idle(void);
>  extern void book3e_idle(void);
> 
> +/* Wait for Interrupt */
> +static inline void fsl_cpuidle_wait(void)
> +{
> +#ifdef CONFIG_PPC64
> +	book3e_idle();
> +#else
> +	e500_idle();
> +#endif
> +}

Where is this used?

> +
>  /*
>   * ppc_md contains a copy of the machine description structure for  
> the
>   * current platform. machine_id contains the initial address where  
> the
> diff --git a/drivers/cpuidle/Kconfig b/drivers/cpuidle/Kconfig
> index b3fb81d..7ed114b 100644
> --- a/drivers/cpuidle/Kconfig
> +++ b/drivers/cpuidle/Kconfig
> @@ -35,6 +35,11 @@ depends on ARM
>  source "drivers/cpuidle/Kconfig.arm"
>  endmenu
> 
> +menu "PowerPC CPU Idle Drivers"
> +depends on PPC32 || PPC64

depends on PPC

> diff --git a/drivers/cpuidle/Kconfig.powerpc  
> b/drivers/cpuidle/Kconfig.powerpc
> new file mode 100644
> index 0000000..9f3f5ef
> --- /dev/null
> +++ b/drivers/cpuidle/Kconfig.powerpc
> @@ -0,0 +1,9 @@
> +#
> +# PowerPC CPU Idle drivers
> +#
> +
> +config PPC_E500_CPUIDLE
> +	bool "CPU Idle Driver for E500 family processors"
> +	depends on FSL_SOC_BOOKE
> +	help
> +	  Select this to enable cpuidle on e500 family processors.

FSL_SOC_BOOKE is more than just e500

> diff --git a/drivers/cpuidle/Makefile b/drivers/cpuidle/Makefile
> index 0b9d200..0dde3db 100644
> --- a/drivers/cpuidle/Makefile
> +++ b/drivers/cpuidle/Makefile
> @@ -11,3 +11,7 @@ obj-$(CONFIG_ARM_HIGHBANK_CPUIDLE)	+=  
> cpuidle-calxeda.o
>  obj-$(CONFIG_ARM_KIRKWOOD_CPUIDLE)	+= cpuidle-kirkwood.o
>  obj-$(CONFIG_ARM_ZYNQ_CPUIDLE)		+= cpuidle-zynq.o
>  obj-$(CONFIG_ARM_U8500_CPUIDLE)         += cpuidle-ux500.o
> +
> +##################################################################################
> +# PowerPC platform drivers
> +obj-$(CONFIG_PPC_E500_CPUIDLE)		+= cpuidle-e500.o
> diff --git a/drivers/cpuidle/cpuidle-e500.c  
> b/drivers/cpuidle/cpuidle-e500.c
> new file mode 100644
> index 0000000..1919cea
> --- /dev/null
> +++ b/drivers/cpuidle/cpuidle-e500.c
> @@ -0,0 +1,222 @@
> +/*
> + * Copyright 2013 Freescale Semiconductor, Inc.
> + *
> + * CPU Idle driver for Freescale PowerPC e500 family processors.
> + *
> + * This program is free software; you can redistribute it and/or  
> modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + *
> + * Author: Wang Dongsheng <dongsheng.wang@freescale.com>
> + */

Is this derived from some other file?  It looks like it...  Where's the
attribution?

> +#include <linux/cpu.h>
> +#include <linux/cpuidle.h>
> +#include <linux/init.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/notifier.h>
> +
> +#include <asm/machdep.h>
> +
> +static struct cpuidle_driver e500_idle_driver = {
> +	.name = "e500_idle",
> +	.owner = THIS_MODULE,
> +};
> +
> +static struct cpuidle_device __percpu *e500_cpuidle_devices;
> +
> +static void e500_cpuidle(void)
> +{
> +	/*
> +	 * This would call on the cpuidle framework, and the back-end
> +	 * driver to go to idle states.
> +	 */
> +	if (cpuidle_idle_call()) {
> +		/*
> +		 * On error, execute default handler
> +		 * to go into low thread priority and possibly
> +		 * low power mode.
> +		 */
> +		HMT_low();
> +		HMT_very_low();

This HMT stuff doesn't do anything on e500 derivatives AFAIK.

> +static struct cpuidle_state fsl_pw_idle_states[] = {
> +	{
> +		.name = "pw10",
> +		.desc = "pw10",
> +		.flags = CPUIDLE_FLAG_TIME_VALID,
> +		.exit_latency = 0,
> +		.target_residency = 0,
> +		.enter = &pw10_enter

Where is pw10_enter defined?

> +static int cpu_is_feature(unsigned long feature)
> +{
> +	return (cur_cpu_spec->cpu_features == feature);
> +}
> +
> +static int __init e500_idle_init(void)
> +{
> +	struct cpuidle_state *cpuidle_state_table = NULL;
> +	struct cpuidle_driver *drv = &e500_idle_driver;
> +	int err;
> +	unsigned int max_idle_state = 0;
> +
> +	if (cpuidle_disable != IDLE_NO_OVERRIDE)
> +		return -ENODEV;
> +
> +	if (cpu_is_feature(CPU_FTRS_E500MC) ||  
> cpu_is_feature(CPU_FTRS_E5500) ||
> +			cpu_is_feature(CPU_FTRS_E6500)) {

There's no guarantee that a CPU with the same set of features is the
exact same CPU.

What specific feature are you looking for here?

> +		cpuidle_state_table = fsl_pw_idle_states;
> +		max_idle_state = ARRAY_SIZE(fsl_pw_idle_states);
> +	}
> +
> +	if (!cpuidle_state_table || !max_idle_state)
> +		return -EPERM;

ENODEV?

-Scott
