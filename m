From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: Re: [PATCH 02/15] cpuidle: initialize the broadcast timer framework
Date: Tue, 26 Mar 2013 10:09:53 +0530
Message-ID: <51512699.2050609@ti.com>
References: <1364234140-514-1-git-send-email-daniel.lezcano@linaro.org> <1364234140-514-3-git-send-email-daniel.lezcano@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:41005 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759386Ab3CZEio (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 26 Mar 2013 00:38:44 -0400
In-Reply-To: <1364234140-514-3-git-send-email-daniel.lezcano@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: rjw@sisk.pl, tglx@linutronix.de, andrew@lunn.ch, linaro-kernel@lists.linaro.org, magnus.damm@gmail.com, ben-linux@fluff.org, linux-pm@vger.kernel.org, nsekhar@ti.com, patches@linaro.org, rob.herring@calxeda.com, linux@arm.linux.org.uk, kevin.hilman@linaro.org, horms@verge.net.au, jason@lakedaemon.net, kernel@pengutronix.de, kgene.kim@samsung.com, plagnioj@jcrosoft.com, linux@maxim.org.za, linux-arm-kernel@lists.infradead.org, lenb@kernel.org

On Monday 25 March 2013 11:25 PM, Daniel Lezcano wrote:
> The commit 89878baa73f0f1c679355006bd8632e5d78f96c2 introduced
> the CPUIDLE_FLAG_TIMER_STOP flag where we specify a specific idle
> state stops the local timer.
> 
> Now use this flag to check at init time if one state will need
> the broadcast timer and, in this case, setup the broadcast timer
> framework. That prevents multiple code duplication in the drivers.
> 
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> ---
>  drivers/cpuidle/driver.c |   35 +++++++++++++++++++++++++++++++++--
>  include/linux/cpuidle.h  |    2 ++
>  2 files changed, 35 insertions(+), 2 deletions(-)
> 
Make sense. Minor comments.

> diff --git a/drivers/cpuidle/driver.c b/drivers/cpuidle/driver.c
> index 422c7b6..476ce0c 100644
> --- a/drivers/cpuidle/driver.c
> +++ b/drivers/cpuidle/driver.c
> @@ -11,6 +11,8 @@
>  #include <linux/mutex.h>
>  #include <linux/module.h>
>  #include <linux/cpuidle.h>
> +#include <linux/cpumask.h>
> +#include <linux/clockchips.h>
>  
>  #include "cpuidle.h"
>  
> @@ -19,9 +21,30 @@ DEFINE_SPINLOCK(cpuidle_driver_lock);
>  static void __cpuidle_set_cpu_driver(struct cpuidle_driver *drv, int cpu);
>  static struct cpuidle_driver * __cpuidle_get_cpu_driver(int cpu);
>  
> -static void __cpuidle_driver_init(struct cpuidle_driver *drv)
> +static void cpuidle_setup_broadcast_timer(void *arg)
>  {
> +	int cpu = smp_processor_id();
> +	clockevents_notify((long)(arg), &cpu);
> +}
> +
> +static void __cpuidle_driver_init(struct cpuidle_driver *drv, int cpu)
> +{
> +	int i;
> +
Un-necessary extra line..

>  	drv->refcnt = 0;
> +
> +	for (i = drv->state_count - 1; i >= 0 ; i--) {
> +
here as well
> +		if (!(drv->states[i].flags & CPUIDLE_FLAG_TIMER_STOP))
> +			continue;
> +
> +		drv->bctimer = 1;
> +
ditto
> +		on_each_cpu_mask(get_cpu_mask(cpu), cpuidle_setup_broadcast_timer,
> +				 (void *)CLOCK_EVT_NOTIFY_BROADCAST_ON, 1);
> +
ditto
> +		break;
> +	}
>  }
>  
>  static int __cpuidle_register_driver(struct cpuidle_driver *drv, int cpu)
> @@ -35,7 +58,7 @@ static int __cpuidle_register_driver(struct cpuidle_driver *drv, int cpu)
>  	if (__cpuidle_get_cpu_driver(cpu))
>  		return -EBUSY;
>  
> -	__cpuidle_driver_init(drv);
> +	__cpuidle_driver_init(drv, cpu);
>  
>  	__cpuidle_set_cpu_driver(drv, cpu);
>  
> @@ -49,6 +72,14 @@ static void __cpuidle_unregister_driver(struct cpuidle_driver *drv, int cpu)
>  
>  	if (!WARN_ON(drv->refcnt > 0))
>  		__cpuidle_set_cpu_driver(NULL, cpu);
> +
> +	if (drv->bctimer) {
> +
> +		drv->bctimer = 0;
> +
> +
no need of extra line here
		on_each_cpu_mask(get_cpu_mask(cpu), cpuidle_setup_broadcast_timer,
> +				 (void *)CLOCK_EVT_NOTIFY_BROADCAST_OFF, 1);
> +	}
>  }
>  
>  #ifdef CONFIG_CPU_IDLE_MULTIPLE_DRIVERS
> diff --git a/include/linux/cpuidle.h b/include/linux/cpuidle.h
> index a837b33..fc3e580 100644
> --- a/include/linux/cpuidle.h
> +++ b/include/linux/cpuidle.h
> @@ -107,6 +107,8 @@ struct cpuidle_driver {
>  
>  	/* set to 1 to use the core cpuidle time keeping (for all states). */
>  	unsigned int		en_core_tk_irqen:1;
> +        /* used by the cpuidle framework to setup the broadcast timer */
> +	unsigned int            bctimer:1;
>  	/* states array must be ordered in decreasing power consumption */
>  	struct cpuidle_state	states[CPUIDLE_STATE_MAX];
>  	int			state_count;
> 

