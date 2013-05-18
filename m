From: Francesco Lavra <francescolavra.fl@gmail.com>
Subject: Re: [PATCH] cpuidle: simplify multiple driver support
Date: Sat, 18 May 2013 13:15:05 +0200
Message-ID: <519762B9.5030503@gmail.com>
References: <1368537691-10111-1-git-send-email-daniel.lezcano@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-ee0-f42.google.com ([74.125.83.42]:39090 "EHLO
	mail-ee0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752987Ab3ERLNp (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sat, 18 May 2013 07:13:45 -0400
Received: by mail-ee0-f42.google.com with SMTP id c50so3019514eek.15
        for <linux-pm@vger.kernel.org>; Sat, 18 May 2013 04:13:43 -0700 (PDT)
In-Reply-To: <1368537691-10111-1-git-send-email-daniel.lezcano@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: rjw@sisk.pl, linaro-kernel@lists.linaro.org, patches@linaro.org, linux-pm@vger.kernel.org

On 05/14/2013 03:21 PM, Daniel Lezcano wrote:
> Commit bf4d1b5ddb78f86078ac6ae0415802d5f0c68f92 brought the multiple driver
> support. The code added a couple of new API to register the driver per cpu.
> That led to some code complexity to handle the kernel config options when
> the multiple driver support is enabled or not, which is not really necessary.
> The code has to be compatible when the multiple driver support is not enabled,
> and the multiple driver support has to be compatible with the old api.
> 
> This patch removes this API, which is not yet used by any driver but needed
> for the HMP cpuidle drivers which will come soon, and replaces its usage
> by a cpumask pointer in the cpuidle driver structure telling what cpus are
> handled by the driver. That let the API cpuidle_[un]register_driver to be used
> for the multipled driver support and also the cpuidle_[un]register functions,
> added recently in the cpuidle framework.
> 
> The current code, a bit poor in comments, has been commented and simplified.
> 
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
[...]
> +/**
> + * __cpuidle_register_driver: do some sanity checks, initializes the driver,
> + * assign the driver to the global cpuidle driver variable(s) and setup the
> + * broadcast timer if the cpuidle driver has some states which shutdown the
> + * local timer.
> + *
> + * @drv: a valid pointer to a struct cpuidle_driver
> + *
> + * Returns 0 on success, < 0 otherwise
> + */
> +static int __cpuidle_register_driver(struct cpuidle_driver *drv)
>  {
>  	int ret;
>  
> -	spin_lock(&cpuidle_driver_lock);
> -	ret = __cpuidle_register_driver(drv, cpu);
> -	spin_unlock(&cpuidle_driver_lock);
> +	if (!drv || !drv->state_count)
> +		return -EINVAL;
>  
> -	return ret;
> -}
> +	if (cpuidle_disabled())
> +		return -ENODEV;
>  
> -void cpuidle_unregister_cpu_driver(struct cpuidle_driver *drv, int cpu)
> -{
> -	spin_lock(&cpuidle_driver_lock);
> -	__cpuidle_unregister_driver(drv, cpu);
> -	spin_unlock(&cpuidle_driver_lock);
> -}
> +	ret = __cpuidle_driver_init(drv);
> +	if (ret)
> +		return ret;
>  
> -/**
> - * cpuidle_register_driver - registers a driver
> - * @drv: the driver
> - */
> -int cpuidle_register_driver(struct cpuidle_driver *drv)
> -{
> -	int ret;
> +	ret = __cpuidle_set_driver(drv);
> +	if (ret)
> +		return ret;
>  
> -	spin_lock(&cpuidle_driver_lock);
> -	ret = __cpuidle_register_all_cpu_driver(drv);
> -	spin_unlock(&cpuidle_driver_lock);
> +	if (drv->bctimer)
> +		on_each_cpu_mask(drv->cpumask, cpuidle_setup_broadcast_timer,
> +				 (void *)CLOCK_EVT_NOTIFY_BROADCAST_ON, 1);
>  
> -	return ret;
> +	return 0;
>  }
> -EXPORT_SYMBOL_GPL(cpuidle_register_driver);
>  
>  /**
> - * cpuidle_unregister_driver - unregisters a driver
> - * @drv: the driver
> + * __cpuidle_unregister_driver: checks the driver is no longer in use, reset the
> + * global cpuidle driver variable(s) and disable the timer broadcast
> + * notification mechanism if it was in use.
> + *
> + * @drv: a valid pointer to a struct cpuidle_driver
> + *
> + * Returns 0 on success, < 0 otherwise
>   */
> -void cpuidle_unregister_driver(struct cpuidle_driver *drv)
> +static void __cpuidle_unregister_driver(struct cpuidle_driver *drv)
>  {
> -	spin_lock(&cpuidle_driver_lock);
> -	__cpuidle_unregister_all_cpu_driver(drv);
> -	spin_unlock(&cpuidle_driver_lock);
> -}
> -EXPORT_SYMBOL_GPL(cpuidle_unregister_driver);
> -
> -#else
> -
> -static struct cpuidle_driver *cpuidle_curr_driver;
> +	if (!WARN_ON(drv->refcnt > 0))
> +		return;

Shouldn't it be
if (WARN_ON(drv->refcnt > 0))
	return;
?

>  
> -static inline void __cpuidle_set_cpu_driver(struct cpuidle_driver *drv, int cpu)
> -{
> -	cpuidle_curr_driver = drv;
> -}
> +	__cpuidle_unset_driver(drv);
>  
> -static inline struct cpuidle_driver *__cpuidle_get_cpu_driver(int cpu)
> -{
> -	return cpuidle_curr_driver;
> +	if (drv->bctimer) {
> +		drv->bctimer = 0;
> +		on_each_cpu_mask(drv->cpumask, cpuidle_setup_broadcast_timer,
> +				 (void *)CLOCK_EVT_NOTIFY_BROADCAST_OFF, 1);
> +	}
>  }

Also, shouldn't things be undone in reverse order as they were done in
__cpuidle_register_driver()? I mean disabling the timer broadcast
notification before calling __cpuidle_unset_driver().

Regards,
Francesco
