From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH V3 2/2] cpuidle: Comment the driver's framework code
Date: Fri, 07 Jun 2013 13:09:43 +0200
Message-ID: <2760099.QFAZMiNNlb@vostro.rjw.lan>
References: <1370518831-19287-1-git-send-email-daniel.lezcano@linaro.org> <1370518831-19287-2-git-send-email-daniel.lezcano@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from hydra.sisk.pl ([212.160.235.94]:59435 "EHLO hydra.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754580Ab3FGLAi (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Fri, 7 Jun 2013 07:00:38 -0400
In-Reply-To: <1370518831-19287-2-git-send-email-daniel.lezcano@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: francescolavra.fl@gmail.com, lenb@kernel.org, linaro-kernel@lists.linaro.org, patches@linaro.org, linux-pm@vger.kernel.org

On Thursday, June 06, 2013 01:40:31 PM Daniel Lezcano wrote:
> Added kerneldoc and comments for the cpuidle framework driver's code.
> 
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> ---
>  drivers/cpuidle/driver.c |  128 +++++++++++++++++++++++++++++++++++++++++++---
>  1 file changed, 120 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/cpuidle/driver.c b/drivers/cpuidle/driver.c
> index 745adae..0268346 100644
> --- a/drivers/cpuidle/driver.c
> +++ b/drivers/cpuidle/driver.c
> @@ -22,11 +22,28 @@ DEFINE_SPINLOCK(cpuidle_driver_lock);
>  
>  static DEFINE_PER_CPU(struct cpuidle_driver *, cpuidle_drivers);
>  
> +/**
> + * __cpuidle_get_cpu_driver: returns the cpuidle driver tied with the specified
> + * cpu.

That should be a single line (as required by kerneldoc).

> + *

And please don't add this empty line (analogously below).

> + * @cpu: an integer specifying the cpu number

Why don't you say "@cpu: CPU number"?  It's quite clear from the header below
that this is an integer. :-)

> + *
> + * Returns a pointer to struct cpuidle_driver, NULL if no driver has been
> + * registered for this driver
> + */
>  static struct cpuidle_driver *__cpuidle_get_cpu_driver(int cpu)
>  {
>  	return per_cpu(cpuidle_drivers, cpu);
>  }
>  
> +/**
> + * __cpuidle_set_driver: assign to the per cpu variable the driver pointer for
> + * each cpu the driver is assigned to with the cpumask.
> + *
> + * @drv: a pointer to a struct cpuidle_driver
> + *
> + * Returns 0 on success, < 0 otherwise

This is meaningless.  If you want to describe return values like this, you need
to explain what the success is and what error values can be returned and what
they mean.

And please say "a negative error code" instead of "< 0". :-)

Thanks,
Rafael


> + */
>  static inline int __cpuidle_set_driver(struct cpuidle_driver *drv)
>  {
>  	int cpu;
> @@ -42,6 +59,12 @@ static inline int __cpuidle_set_driver(struct cpuidle_driver *drv)
>  	return 0;
>  }
>  
> +/**
> + * __cpuidle_unset_driver: for each cpu the driver is handling, set the per cpu
> + * variable driver to NULL.
> + *
> + * @drv: a pointer to a struct cpuidle_driver
> + */
>  static inline void __cpuidle_unset_driver(struct cpuidle_driver *drv)
>  {
>  	int cpu;
> @@ -59,11 +82,27 @@ static inline void __cpuidle_unset_driver(struct cpuidle_driver *drv)
>  
>  static struct cpuidle_driver *cpuidle_curr_driver;
>  
> +/**
> + * __cpuidle_get_cpu_driver: returns the global cpuidle driver pointer.
> + *
> + * @cpu: an integer specifying the cpu number, this parameter is ignored
> + *
> + * Returns a pointer to a struct cpuidle_driver, NULL if no driver was
> + * previously registered
> + */
>  static inline struct cpuidle_driver *__cpuidle_get_cpu_driver(int cpu)
>  {
>  	return cpuidle_curr_driver;
>  }
>  
> +/**
> + * __cpuidle_set_driver: assign the cpuidle driver pointer to the global cpuidle
> + * driver variable.
> + *
> + * @drv: a pointer to a struct cpuidle_driver
> + *
> + * Returns 0 on success, < 0 otherwise
> + */
>  static inline int __cpuidle_set_driver(struct cpuidle_driver *drv)
>  {
>  	if (cpuidle_curr_driver)
> @@ -74,6 +113,12 @@ static inline int __cpuidle_set_driver(struct cpuidle_driver *drv)
>  	return 0;
>  }
>  
> +/**
> + * __cpuidle_unset_driver: reset the global cpuidle driver variable if the
> + * cpuidle driver pointer match it.
> + *
> + * @drv: a pointer to a struct cpuidle_driver
> + */
>  static inline void __cpuidle_unset_driver(struct cpuidle_driver *drv)
>  {
>  	if (drv == cpuidle_curr_driver)
> @@ -82,21 +127,49 @@ static inline void __cpuidle_unset_driver(struct cpuidle_driver *drv)
>  
>  #endif
>  
> +/**
> + * cpuidle_setup_broadcast_timer: set the broadcast timer notification for the
> + * current cpu. This function is called per cpu context invoked by a smp cross
> + * call. It is not supposed to be called directly.
> + *
> + * @arg: a void pointer, actually used to match the smp cross call api but used
> + * as a long with two values:
> + * - CLOCK_EVT_NOTIFY_BROADCAST_ON
> + * - CLOCK_EVT_NOTIFY_BROADCAST_OFF
> + */
>  static void cpuidle_setup_broadcast_timer(void *arg)
>  {
>  	int cpu = smp_processor_id();
>  	clockevents_notify((long)(arg), &cpu);
>  }
>  
> +/**
> + * __cpuidle_driver_init: initialize the driver internal data.
> + *
> + * @drv: a valid pointer to a struct cpuidle_driver
> + *
> + * Returns 0 on success, < 0 otherwise
> + */
>  static int __cpuidle_driver_init(struct cpuidle_driver *drv)
>  {
>  	int i;
>  
>  	drv->refcnt = 0;
>  
> +	/*
> +	 * we default here to all cpu possible because if the kernel
> +	 * boots with some cpus offline and then we online one of them
> +	 * the cpu notifier won't know which driver to assign
> +	 */
>  	if (!drv->cpumask)
>  		drv->cpumask = (struct cpumask *)cpu_possible_mask;
>  
> +	/*
> +	 * we look for the timer stop flag in the different states,
> +	 * so know we have to setup the broadcast timer. The loop is
> +	 * in reverse order, because usually the deeper state has this
> +	 * flag set
> +	 */
>  	for (i = drv->state_count - 1; i >= 0 ; i--) {
>  
>  		if (!(drv->states[i].flags & CPUIDLE_FLAG_TIMER_STOP))
> @@ -109,6 +182,16 @@ static int __cpuidle_driver_init(struct cpuidle_driver *drv)
>  	return 0;
>  }
>  
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
>  static int __cpuidle_register_driver(struct cpuidle_driver *drv)
>  {
>  	int ret;
> @@ -135,8 +218,12 @@ static int __cpuidle_register_driver(struct cpuidle_driver *drv)
>  }
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
>   */
>  static void __cpuidle_unregister_driver(struct cpuidle_driver *drv)
>  {
> @@ -153,8 +240,12 @@ static void __cpuidle_unregister_driver(struct cpuidle_driver *drv)
>  }
>  
>  /**
> - * cpuidle_register_driver - registers a driver
> - * @drv: the driver
> + * cpuidle_register_driver: registers a driver by taking a lock to prevent
> + * multiple callers to [un]register a driver at the same time.
> + *
> + * @drv: a pointer to a valid struct cpuidle_driver
> + *
> + * Returns 0 on success, < 0 otherwise
>   */
>  int cpuidle_register_driver(struct cpuidle_driver *drv)
>  {
> @@ -169,8 +260,11 @@ int cpuidle_register_driver(struct cpuidle_driver *drv)
>  EXPORT_SYMBOL_GPL(cpuidle_register_driver);
>  
>  /**
> - * cpuidle_unregister_driver - unregisters a driver
> - * @drv: the driver
> + * cpuidle_unregister_driver: unregisters a driver by taking a lock to prevent
> + * multiple callers to [un]register a driver at the same time. The specified
> + * driver must match the driver currently registered.
> + *
> + * @drv: a pointer to a valid struct cpuidle_driver
>   */
>  void cpuidle_unregister_driver(struct cpuidle_driver *drv)
>  {
> @@ -181,7 +275,9 @@ void cpuidle_unregister_driver(struct cpuidle_driver *drv)
>  EXPORT_SYMBOL_GPL(cpuidle_unregister_driver);
>  
>  /**
> - * cpuidle_get_driver - return the current driver
> + * cpuidle_get_driver: returns the driver tied with the current cpu.
> + *
> + * Returns a struct cpuidle_driver pointer, or NULL if no driver is registered
>   */
>  struct cpuidle_driver *cpuidle_get_driver(void)
>  {
> @@ -197,7 +293,12 @@ struct cpuidle_driver *cpuidle_get_driver(void)
>  EXPORT_SYMBOL_GPL(cpuidle_get_driver);
>  
>  /**
> - * cpuidle_get_cpu_driver - return the driver tied with a cpu
> + * cpuidle_get_cpu_driver: returns the driver registered with a cpu.
> + *
> + * @dev: a valid pointer to a struct cpuidle_device
> + *
> + * Returns a struct cpuidle_driver pointer, or NULL if no driver is registered
> + * for the specified cpu
>   */
>  struct cpuidle_driver *cpuidle_get_cpu_driver(struct cpuidle_device *dev)
>  {
> @@ -208,6 +309,13 @@ struct cpuidle_driver *cpuidle_get_cpu_driver(struct cpuidle_device *dev)
>  }
>  EXPORT_SYMBOL_GPL(cpuidle_get_cpu_driver);
>  
> +/**
> + * cpuidle_driver_ref: gets a refcount for the driver. Note this function takes
> + * a refcount for the driver assigned to the current cpu.
> + *
> + * Returns a struct cpuidle_driver pointer, or NULL if no driver is registered
> + * for the current cpu
> + */
>  struct cpuidle_driver *cpuidle_driver_ref(void)
>  {
>  	struct cpuidle_driver *drv;
> @@ -221,6 +329,10 @@ struct cpuidle_driver *cpuidle_driver_ref(void)
>  	return drv;
>  }
>  
> +/**
> + * cpuidle_driver_unref: puts down the refcount for the driver. Note this
> + * function decrement the refcount for the driver assigned to the current cpu.
> + */
>  void cpuidle_driver_unref(void)
>  {
>  	struct cpuidle_driver *drv = cpuidle_get_driver();
> 
-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
