From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: Re: [RFC patch 02/11] cpuidle / arm : a single cpuidle driver
Date: Tue, 26 Mar 2013 10:01:25 +0530
Message-ID: <5151249D.4000602@ti.com>
References: <1363357630-22214-1-git-send-email-daniel.lezcano@linaro.org> <1363357630-22214-3-git-send-email-daniel.lezcano@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:40761 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756126Ab3CZEaq (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 26 Mar 2013 00:30:46 -0400
In-Reply-To: <1363357630-22214-3-git-send-email-daniel.lezcano@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: linaro-kernel@lists.linaro.org, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org, andrew@lunn.ch, magnus.damm@gmail.com, ben-linux@fluff.org, nsekhar@ti.com, rob.herring@calxeda.com, rjw@sisk.pl, kevin.hilman@linaro.org, horms@verge.net.au, kernel@pengutronix.de, kgene.kim@samsung.com, plagnioj@jcrosoft.com, linux@maxim.org.za, jason@lakedaemon.net, lenb@kernel.org

On Friday 15 March 2013 07:57 PM, Daniel Lezcano wrote:
> The cpuidle drivers are duplicating a lot of code and in most
> of the case there is a common pattern we can factor out:
> 
> 	* setup the broadcast timers
> 	* register the driver
> 	* register the devices
> 
> This arm driver is the common part between all the ARM cpuidle drivers,
> with the code factored out.
> 
> It does not handle the coupled idle state for now but it is the first
> step to have everyone to converge to the same code pattern.
> 
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> ---
While I appreciate the effort behind code consolidation, $subject is
bit confusing. You are just abstracting the registration code to one
common place and I don't know why it has to be limited to arm-idle
since it is very generic code. That is true even for the broad-cast
notifier setup which is same across all arch's including ARM, X86.


>  MAINTAINERS                    |    6 +++
>  arch/arm/include/asm/cpuidle.h |    3 ++
>  drivers/cpuidle/Makefile       |    1 +
>  drivers/cpuidle/arm-idle.c     |  112 ++++++++++++++++++++++++++++++++++++++++
>  4 files changed, 122 insertions(+)
>  create mode 100644 drivers/cpuidle/arm-idle.c
> 


[..]

> diff --git a/drivers/cpuidle/arm-idle.c b/drivers/cpuidle/arm-idle.c
> new file mode 100644
> index 0000000..397ff4c
> --- /dev/null
> +++ b/drivers/cpuidle/arm-idle.c
> @@ -0,0 +1,112 @@
> +/*
> + * Copyright 2012 Linaro Ltd: : Daniel Lezcano <daniel.lezcano@linaro.org>
> + *
> + * The code contained herein is licensed under the GNU General Public
> + * License. You may obtain a copy of the GNU General Public License
> + * Version 2 or later at the following locations:
> + *
> + * http://www.opensource.org/licenses/gpl-license.html
> + * http://www.gnu.org/copyleft/gpl.html
> + */
> +
> +#include <linux/clockchips.h>
> +#include <linux/module.h>
> +#include <linux/cpuidle.h>
> +
> +static DEFINE_PER_CPU(struct cpuidle_device, cpuidle_device);
> +static bool use_broadcast_timer = false;
> +
> +#ifdef CONFIG_GENERIC_CLOCKEVENTS
> +static void setup_broadcast_timer(void *arg)
> +{
> +        int cpu = smp_processor_id();
> +        clockevents_notify((int)(arg), &cpu);
> +}
> +
> +static bool __init arm_idle_use_broadcast(struct cpuidle_driver *drv)
> +{
> +	int i;
> +
> +	for (i = 0; i < drv->state_count; i++)
> +		if (drv->states[i].flags & CPUIDLE_FLAG_TIMER_STOP)
> +			return true;
> +	return false;
> +}
> +
> +static inline void arm_idle_timer_broadcast(bool enable)
> +{
> +	on_each_cpu(setup_broadcast_timer, enable ?
> +		    (void *)CLOCK_EVT_NOTIFY_BROADCAST_ON:
> +		    (void *)CLOCK_EVT_NOTIFY_BROADCAST_OFF, 1);
> +}
> +#else
> +static inline bool __init arm_idle_use_broadcast(struct cpuidle_driver *drv)
> +{
> +	return false;
> +}
> +
> +static inline void arm_idle_timer_broadcast(bool enable)
> +{
> +	;
> +}
> +#endif
> +
> +int __init arm_idle_init(struct cpuidle_driver *drv)
> +{
> +	int ret, cpu;
> +	struct cpuidle_device *device;
> +
> +	use_broadcast_timer = arm_idle_use_broadcast(drv);
> +
> +	if (use_broadcast_timer)
> +		arm_idle_timer_broadcast(true);
> +
> +	ret = cpuidle_register_driver(drv);
> +	if (ret) {
> +		printk(KERN_ERR "failed to register idle driver '%s'\n",
> +			drv->name);
> +		return ret;
> +	}
> +
> +	for_each_online_cpu(cpu) {
> +
> +		device = &per_cpu(cpuidle_device, cpu);
> +		device->cpu = cpu;
> +		ret = cpuidle_register_device(device);
> +		if (ret) {
> +			printk(KERN_ERR "Failed to register cpuidle "
> +			       "device for cpu%d\n", cpu);
> +			goto out_unregister;
> +		}
> +	}
> +
> +out:
> +	return ret;
> +
> +out_unregister:
> +	for_each_online_cpu(cpu) {
> +		device = &per_cpu(cpuidle_device, cpu);
> +		cpuidle_unregister_device(device);
> +	}
> +
> +	cpuidle_unregister_driver(drv);
> +	goto out;
> +}
> +EXPORT_SYMBOL_GPL(arm_idle_init);
> +
> +void __exit arm_idle_exit(struct cpuidle_driver *drv)
> +{
> +	int cpu;
> +	struct cpuidle_device *device;
> +
> +	for_each_online_cpu(cpu) {
> +		device = &per_cpu(cpuidle_device, cpu);
> +		cpuidle_unregister_device(device);
> +	}
> +
> +	cpuidle_unregister_driver(drv);
> +
> +	if (use_broadcast_timer)
> +		arm_idle_timer_broadcast(false);
> +}
> +EXPORT_SYMBOL_GPL(arm_idle_exit);
> 
All above code is completly generic and I would rather create
some thing like "drivers/cpuidle/generic-idle.c" where it can
handle all the registration stuff for all arch's rather than
just ARM. There is nothing ARM specific in above code IMHO.

Regards,
Santosh

