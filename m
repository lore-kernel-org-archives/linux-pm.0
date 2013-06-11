From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH V4 1/2] cpuidle: simplify multiple driver support
Date: Wed, 12 Jun 2013 00:43:33 +0200
Message-ID: <3228162.FYmfSjIvBS@vostro.rjw.lan>
References: <1370641990-13884-1-git-send-email-daniel.lezcano@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from hydra.sisk.pl ([212.160.235.94]:34500 "EHLO hydra.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756291Ab3FKWeY (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Tue, 11 Jun 2013 18:34:24 -0400
In-Reply-To: <1370641990-13884-1-git-send-email-daniel.lezcano@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: francescolavra.fl@gmail.com, lenb@kernel.org, linaro-kernel@lists.linaro.org, patches@linaro.org, linux-pm@vger.kernel.org

On Friday, June 07, 2013 11:53:09 PM Daniel Lezcano wrote:
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
> for the multiple driver support and also the cpuidle_[un]register functions,
> added recently in the cpuidle framework.
> 
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>

Queued up for 3.11 with a modified changelog.

Thanks,
Rafael


> ---
> [V4]
>  - uninitialize per cpu driver variable on error
>  - rollback indentation in cpuidle.h
> [V3]
>  - moved the kerneldoc and comments to a separate patch
> [V2]:
>  - fixed bad refcount check
>  - inverted clockevent notify off order at unregister time
> 
>  drivers/cpuidle/cpuidle.c |    4 +-
>  drivers/cpuidle/driver.c  |  192 +++++++++++++++++++--------------------------
>  include/linux/cpuidle.h   |    6 +-
>  3 files changed, 84 insertions(+), 118 deletions(-)
> 
> diff --git a/drivers/cpuidle/cpuidle.c b/drivers/cpuidle/cpuidle.c
> index c3a93fe..fdc432f 100644
> --- a/drivers/cpuidle/cpuidle.c
> +++ b/drivers/cpuidle/cpuidle.c
> @@ -466,7 +466,7 @@ void cpuidle_unregister(struct cpuidle_driver *drv)
>  	int cpu;
>  	struct cpuidle_device *device;
>  
> -	for_each_possible_cpu(cpu) {
> +	for_each_cpu(cpu, drv->cpumask) {
>  		device = &per_cpu(cpuidle_dev, cpu);
>  		cpuidle_unregister_device(device);
>  	}
> @@ -498,7 +498,7 @@ int cpuidle_register(struct cpuidle_driver *drv,
>  		return ret;
>  	}
>  
> -	for_each_possible_cpu(cpu) {
> +	for_each_cpu(cpu, drv->cpumask) {
>  		device = &per_cpu(cpuidle_dev, cpu);
>  		device->cpu = cpu;
>  
> diff --git a/drivers/cpuidle/driver.c b/drivers/cpuidle/driver.c
> index 8dfaaae..e75fa54 100644
> --- a/drivers/cpuidle/driver.c
> +++ b/drivers/cpuidle/driver.c
> @@ -18,167 +18,140 @@
>  
>  DEFINE_SPINLOCK(cpuidle_driver_lock);
>  
> -static void __cpuidle_set_cpu_driver(struct cpuidle_driver *drv, int cpu);
> -static struct cpuidle_driver * __cpuidle_get_cpu_driver(int cpu);
> +#ifdef CONFIG_CPU_IDLE_MULTIPLE_DRIVERS
>  
> -static void cpuidle_setup_broadcast_timer(void *arg)
> +static DEFINE_PER_CPU(struct cpuidle_driver *, cpuidle_drivers);
> +
> +static struct cpuidle_driver *__cpuidle_get_cpu_driver(int cpu)
>  {
> -	int cpu = smp_processor_id();
> -	clockevents_notify((long)(arg), &cpu);
> +	return per_cpu(cpuidle_drivers, cpu);
>  }
>  
> -static void __cpuidle_driver_init(struct cpuidle_driver *drv, int cpu)
> +static inline void __cpuidle_unset_driver(struct cpuidle_driver *drv)
>  {
> -	int i;
> -
> -	drv->refcnt = 0;
> +	int cpu;
>  
> -	for (i = drv->state_count - 1; i >= 0 ; i--) {
> +	for_each_cpu(cpu, drv->cpumask) {
>  
> -		if (!(drv->states[i].flags & CPUIDLE_FLAG_TIMER_STOP))
> +		if (drv != __cpuidle_get_cpu_driver(cpu))
>  			continue;
>  
> -		drv->bctimer = 1;
> -		on_each_cpu_mask(get_cpu_mask(cpu), cpuidle_setup_broadcast_timer,
> -				 (void *)CLOCK_EVT_NOTIFY_BROADCAST_ON, 1);
> -		break;
> +		per_cpu(cpuidle_drivers, cpu) = NULL;
>  	}
>  }
>  
> -static int __cpuidle_register_driver(struct cpuidle_driver *drv, int cpu)
> +static inline int __cpuidle_set_driver(struct cpuidle_driver *drv)
>  {
> -	if (!drv || !drv->state_count)
> -		return -EINVAL;
> -
> -	if (cpuidle_disabled())
> -		return -ENODEV;
> +	int cpu;
>  
> -	if (__cpuidle_get_cpu_driver(cpu))
> -		return -EBUSY;
> +	for_each_cpu(cpu, drv->cpumask) {
>  
> -	__cpuidle_driver_init(drv, cpu);
> +		if (__cpuidle_get_cpu_driver(cpu)) {
> +			__cpuidle_unset_driver(drv);
> +			return -EBUSY;
> +		}
>  
> -	__cpuidle_set_cpu_driver(drv, cpu);
> +		per_cpu(cpuidle_drivers, cpu) = drv;
> +	}
>  
>  	return 0;
>  }
>  
> -static void __cpuidle_unregister_driver(struct cpuidle_driver *drv, int cpu)
> -{
> -	if (drv != __cpuidle_get_cpu_driver(cpu))
> -		return;
> +#else
>  
> -	if (!WARN_ON(drv->refcnt > 0))
> -		__cpuidle_set_cpu_driver(NULL, cpu);
> +static struct cpuidle_driver *cpuidle_curr_driver;
>  
> -	if (drv->bctimer) {
> -		drv->bctimer = 0;
> -		on_each_cpu_mask(get_cpu_mask(cpu), cpuidle_setup_broadcast_timer,
> -				 (void *)CLOCK_EVT_NOTIFY_BROADCAST_OFF, 1);
> -	}
> +static inline struct cpuidle_driver *__cpuidle_get_cpu_driver(int cpu)
> +{
> +	return cpuidle_curr_driver;
>  }
>  
> -#ifdef CONFIG_CPU_IDLE_MULTIPLE_DRIVERS
> +static inline int __cpuidle_set_driver(struct cpuidle_driver *drv)
> +{
> +	if (cpuidle_curr_driver)
> +		return -EBUSY;
>  
> -static DEFINE_PER_CPU(struct cpuidle_driver *, cpuidle_drivers);
> +	cpuidle_curr_driver = drv;
>  
> -static void __cpuidle_set_cpu_driver(struct cpuidle_driver *drv, int cpu)
> -{
> -	per_cpu(cpuidle_drivers, cpu) = drv;
> +	return 0;
>  }
>  
> -static struct cpuidle_driver *__cpuidle_get_cpu_driver(int cpu)
> +static inline void __cpuidle_unset_driver(struct cpuidle_driver *drv)
>  {
> -	return per_cpu(cpuidle_drivers, cpu);
> +	if (drv == cpuidle_curr_driver)
> +		cpuidle_curr_driver = NULL;
>  }
>  
> -static void __cpuidle_unregister_all_cpu_driver(struct cpuidle_driver *drv)
> +#endif
> +
> +static void cpuidle_setup_broadcast_timer(void *arg)
>  {
> -	int cpu;
> -	for_each_present_cpu(cpu)
> -		__cpuidle_unregister_driver(drv, cpu);
> +	int cpu = smp_processor_id();
> +	clockevents_notify((long)(arg), &cpu);
>  }
>  
> -static int __cpuidle_register_all_cpu_driver(struct cpuidle_driver *drv)
> +static int __cpuidle_driver_init(struct cpuidle_driver *drv)
>  {
> -	int ret = 0;
> -	int i, cpu;
> +	int i;
>  
> -	for_each_present_cpu(cpu) {
> -		ret = __cpuidle_register_driver(drv, cpu);
> -		if (ret)
> -			break;
> -	}
> +	drv->refcnt = 0;
>  
> -	if (ret)
> -		for_each_present_cpu(i) {
> -			if (i == cpu)
> -				break;
> -			__cpuidle_unregister_driver(drv, i);
> -		}
> +	if (!drv->cpumask)
> +		drv->cpumask = (struct cpumask *)cpu_possible_mask;
>  
> +	for (i = drv->state_count - 1; i >= 0 ; i--) {
>  
> -	return ret;
> +		if (!(drv->states[i].flags & CPUIDLE_FLAG_TIMER_STOP))
> +			continue;
> +
> +		drv->bctimer = 1;
> +		break;
> +	}
> +
> +	return 0;
>  }
>  
> -int cpuidle_register_cpu_driver(struct cpuidle_driver *drv, int cpu)
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
>   * cpuidle_unregister_driver - unregisters a driver
>   * @drv: the driver
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
> +	if (WARN_ON(drv->refcnt > 0))
> +		return;
>  
> -static inline void __cpuidle_set_cpu_driver(struct cpuidle_driver *drv, int cpu)
> -{
> -	cpuidle_curr_driver = drv;
> -}
> +	if (drv->bctimer) {
> +		drv->bctimer = 0;
> +		on_each_cpu_mask(drv->cpumask, cpuidle_setup_broadcast_timer,
> +				 (void *)CLOCK_EVT_NOTIFY_BROADCAST_OFF, 1);
> +	}
>  
> -static inline struct cpuidle_driver *__cpuidle_get_cpu_driver(int cpu)
> -{
> -	return cpuidle_curr_driver;
> +	__cpuidle_unset_driver(drv);
>  }
>  
>  /**
> @@ -187,13 +160,11 @@ static inline struct cpuidle_driver *__cpuidle_get_cpu_driver(int cpu)
>   */
>  int cpuidle_register_driver(struct cpuidle_driver *drv)
>  {
> -	int ret, cpu;
> +	int ret;
>  
> -	cpu = get_cpu();
>  	spin_lock(&cpuidle_driver_lock);
> -	ret = __cpuidle_register_driver(drv, cpu);
> +	ret = __cpuidle_register_driver(drv);
>  	spin_unlock(&cpuidle_driver_lock);
> -	put_cpu();
>  
>  	return ret;
>  }
> @@ -205,16 +176,11 @@ EXPORT_SYMBOL_GPL(cpuidle_register_driver);
>   */
>  void cpuidle_unregister_driver(struct cpuidle_driver *drv)
>  {
> -	int cpu;
> -
> -	cpu = get_cpu();
>  	spin_lock(&cpuidle_driver_lock);
> -	__cpuidle_unregister_driver(drv, cpu);
> +	__cpuidle_unregister_driver(drv);
>  	spin_unlock(&cpuidle_driver_lock);
> -	put_cpu();
>  }
>  EXPORT_SYMBOL_GPL(cpuidle_unregister_driver);
> -#endif
>  
>  /**
>   * cpuidle_get_driver - return the current driver
> diff --git a/include/linux/cpuidle.h b/include/linux/cpuidle.h
> index 8f04062..0bc4b74 100644
> --- a/include/linux/cpuidle.h
> +++ b/include/linux/cpuidle.h
> @@ -111,6 +111,9 @@ struct cpuidle_driver {
>  	struct cpuidle_state	states[CPUIDLE_STATE_MAX];
>  	int			state_count;
>  	int			safe_state_index;
> +
> +	/* the driver handles the cpus in cpumask */
> +	struct cpumask       *cpumask;
>  };
>  
>  #ifdef CONFIG_CPU_IDLE
> @@ -135,9 +138,6 @@ extern void cpuidle_disable_device(struct cpuidle_device *dev);
>  extern int cpuidle_play_dead(void);
>  
>  extern struct cpuidle_driver *cpuidle_get_cpu_driver(struct cpuidle_device *dev);
> -extern int cpuidle_register_cpu_driver(struct cpuidle_driver *drv, int cpu);
> -extern void cpuidle_unregister_cpu_driver(struct cpuidle_driver *drv, int cpu);
> -
>  #else
>  static inline void disable_cpuidle(void) { }
>  static inline int cpuidle_idle_call(void) { return -ENODEV; }
> 
-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
