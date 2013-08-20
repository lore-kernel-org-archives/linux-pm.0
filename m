From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH 1/2] cpuidle: add hotplug support to initialize the timer broadcast
Date: Tue, 20 Aug 2013 16:07:45 +0200
Message-ID: <13525307.ApnQzHRb9G@vostro.rjw.lan>
References: <1375192468-2255-1-git-send-email-daniel.lezcano@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from hydra.sisk.pl ([212.160.235.94]:51484 "EHLO hydra.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751097Ab3HTN5N (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Tue, 20 Aug 2013 09:57:13 -0400
In-Reply-To: <1375192468-2255-1-git-send-email-daniel.lezcano@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: lenb@kernel.org, linux-pm@vger.kernel.org, patches@linaro.org, linaro-kernel@lists.linaro.org

On Tuesday, July 30, 2013 03:54:27 PM Daniel Lezcano wrote:
> Commit 89878baa73f0f1c679355006bd8632e5d78f96c2 introduced the flag
> CPUIDLE_FLAG_TIMER_STOP where we specify a specific idle state stops the local
> timer.
> 
> Commit a06df062a189a8d5588babb8bf0bb78672497798 introduced the initialization
> of the timer broadcast framework depending of the flag presence.
> 
> If a system is booted with some cpus offline, by setting for example, maxcpus=1
> in the kernel command line, and then they are set online, the timer broadcast
> won't be setup automatically.
> 
> Fix this by adding the cpu hotplug notifier and enable/disable the timer
> broadcast automatically. So no need to handle that at the arch specific driver
> level like eg. intel_idle does.
> 
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> ---
>  drivers/cpuidle/driver.c |   48 ++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 48 insertions(+)
> 
> diff --git a/drivers/cpuidle/driver.c b/drivers/cpuidle/driver.c
> index 3ac499d..e976994 100644
> --- a/drivers/cpuidle/driver.c
> +++ b/drivers/cpuidle/driver.c
> @@ -10,6 +10,7 @@
>  
>  #include <linux/mutex.h>
>  #include <linux/module.h>
> +#include <linux/cpu.h>
>  #include <linux/cpuidle.h>
>  #include <linux/cpumask.h>
>  #include <linux/clockchips.h>
> @@ -147,6 +148,48 @@ static void cpuidle_setup_broadcast_timer(void *arg)
>  }
>  
>  /**
> + * cpuidle_hotplug_notify: notifier callback when a cpu is onlined/offlined
> + * @n: the notifier block
> + * @action: an unsigned long giving the event related to the notification
> + * @hcpu: a void pointer but used as the cpu number which the event is related
> + *
> + * The kernel can boot with some cpus offline, we have to init the timer
> + * broadcast for these cpus when they are onlined. Also we have to disable
> + * the timer broadcast when the cpu is down.
> + *
> + * Returns NOTIFY_OK
> + */
> +static int cpuidle_hotplug_notify(struct notifier_block *n,
> +				  unsigned long action, void *hcpu)
> +{
> +	int cpu = (unsigned long)hcpu;
> +	struct cpuidle_driver *drv;
> +
> +	drv = __cpuidle_get_cpu_driver(cpu);
> +	if (!drv || !drv->bctimer)
> +		goto out;
> +
> +	switch (action & 0xf) {

What does the 0xf stand for?

Please always use the defined symbols in such situations.

> +	case CPU_ONLINE:
> +		smp_call_function_single(cpu, cpuidle_setup_broadcast_timer,
> +					 (void *)CLOCK_EVT_NOTIFY_BROADCAST_ON,
> +					 1);
> +		break;
> +	case CPU_DEAD:
> +		smp_call_function_single(cpu, cpuidle_setup_broadcast_timer,
> +					 (void *)CLOCK_EVT_NOTIFY_BROADCAST_OFF,
> +					 1);
> +		break;

This code is going to be run during every system suspend and resume.
Is this intentional and if so, are you confident that it covers all of the
cases that can happen then?

> +	}
> +out:
> +	return NOTIFY_OK;
> +}
> +
> +static struct notifier_block cpuidle_hotplug_notifier = {
> +	.notifier_call = cpuidle_hotplug_notify,
> +};
> +
> +/**
>   * __cpuidle_driver_init - initialize the driver's internal data
>   * @drv: a valid pointer to a struct cpuidle_driver
>   *
> @@ -262,6 +305,9 @@ int cpuidle_register_driver(struct cpuidle_driver *drv)
>  	ret = __cpuidle_register_driver(drv);
>  	spin_unlock(&cpuidle_driver_lock);
>  
> +	if (!ret)
> +		ret = register_cpu_notifier(&cpuidle_hotplug_notifier);
> +
>  	return ret;
>  }
>  EXPORT_SYMBOL_GPL(cpuidle_register_driver);
> @@ -276,6 +322,8 @@ EXPORT_SYMBOL_GPL(cpuidle_register_driver);
>   */
>  void cpuidle_unregister_driver(struct cpuidle_driver *drv)
>  {
> +	unregister_cpu_notifier(&cpuidle_hotplug_notifier);
> +
>  	spin_lock(&cpuidle_driver_lock);
>  	__cpuidle_unregister_driver(drv);
>  	spin_unlock(&cpuidle_driver_lock);
> 

Thanks,
Rafael

