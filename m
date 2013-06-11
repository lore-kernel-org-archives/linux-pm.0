From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH V4 2/2] cpuidle: Comment the driver's framework code
Date: Wed, 12 Jun 2013 00:44 +0200
Message-ID: <3140397.S5OGINlLdR@vostro.rjw.lan>
References: <1370641990-13884-1-git-send-email-daniel.lezcano@linaro.org> <1370641990-13884-2-git-send-email-daniel.lezcano@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from hydra.sisk.pl ([212.160.235.94]:34502 "EHLO hydra.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756399Ab3FKWet (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Tue, 11 Jun 2013 18:34:49 -0400
In-Reply-To: <1370641990-13884-2-git-send-email-daniel.lezcano@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: francescolavra.fl@gmail.com, lenb@kernel.org, linaro-kernel@lists.linaro.org, patches@linaro.org, linux-pm@vger.kernel.org

On Friday, June 07, 2013 11:53:10 PM Daniel Lezcano wrote:
> Added kerneldoc and comments for the cpuidle framework driver's code.
> 
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>

Queued up for 3.11 with some modifications.

Thanks,
Rafael


> ---
> [V4]
>  - fixed kerneldoc comment format
> 
>  drivers/cpuidle/driver.c |  134 +++++++++++++++++++++++++++++++++++++++++++---
>  1 file changed, 128 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/cpuidle/driver.c b/drivers/cpuidle/driver.c
> index e75fa54..4cc5bc4 100644
> --- a/drivers/cpuidle/driver.c
> +++ b/drivers/cpuidle/driver.c
> @@ -22,11 +22,26 @@ DEFINE_SPINLOCK(cpuidle_driver_lock);
>  
>  static DEFINE_PER_CPU(struct cpuidle_driver *, cpuidle_drivers);
>  
> +/**
> + * __cpuidle_get_cpu_driver - returns the cpuidle driver tied with a cpu
> + * @cpu: the cpu handled by the driver
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
> + * __cpuidle_unset_driver - set the per cpu variable driver to NULL.
> + * @drv: a valid pointer to a struct cpuidle_driver
> + *
> + * For each cpu belonging to the driver's cpu mask, set the registered
> + * driver to NULL. If the specified driver is different from the registered
> + * one, the registered driver is untouched.
> + */
>  static inline void __cpuidle_unset_driver(struct cpuidle_driver *drv)
>  {
>  	int cpu;
> @@ -40,6 +55,15 @@ static inline void __cpuidle_unset_driver(struct cpuidle_driver *drv)
>  	}
>  }
>  
> +/**
> + * __cpuidle_set_driver - assign to the per cpu variable the driver pointer
> + * @drv: a valid pointer to a struct cpuidle_driver
> + *
> + * For each cpus handled by the driver, belonging to the driver's cpumask,
> + * assign to the per cpu variable the driver pointer
> + *
> + * Returns 0 on success, -EBUSY if a driver was already assigned to a cpu.
> + */
>  static inline int __cpuidle_set_driver(struct cpuidle_driver *drv)
>  {
>  	int cpu;
> @@ -61,11 +85,24 @@ static inline int __cpuidle_set_driver(struct cpuidle_driver *drv)
>  
>  static struct cpuidle_driver *cpuidle_curr_driver;
>  
> +/**
> + * __cpuidle_get_cpu_driver - returns the global cpuidle driver pointer.
> + * @cpu: this parameter is ignored without the multiple driver support
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
> + * __cpuidle_set_driver - assign the global cpuidle driver variable
> + * @drv: a pointer to a struct cpuidle_driver
> + *
> + * Returns 0 on success, -EBUSY if the driver is already registered.
> + */
>  static inline int __cpuidle_set_driver(struct cpuidle_driver *drv)
>  {
>  	if (cpuidle_curr_driver)
> @@ -76,6 +113,13 @@ static inline int __cpuidle_set_driver(struct cpuidle_driver *drv)
>  	return 0;
>  }
>  
> +/**
> + * __cpuidle_unset_driver - reset the global cpuidle driver variable
> + * @drv: a pointer to a struct cpuidle_driver
> + *
> + * Sets the global cpuidle variable to NULL, if the specified driver
> + * does not match the registered driver, the function will have no effect.
> + */
>  static inline void __cpuidle_unset_driver(struct cpuidle_driver *drv)
>  {
>  	if (drv == cpuidle_curr_driver)
> @@ -84,21 +128,49 @@ static inline void __cpuidle_unset_driver(struct cpuidle_driver *drv)
>  
>  #endif
>  
> +/**
> + * cpuidle_setup_broadcast_timer - enable/disable the broadcast timer
> + * @arg: a void pointer, actually used to match the smp cross call api but used
> + * as a long with two values:
> + * - CLOCK_EVT_NOTIFY_BROADCAST_ON
> + * - CLOCK_EVT_NOTIFY_BROADCAST_OFF
> + *
> + * Sets the broadcast timer notification for the current cpu. This function
> + * is called per cpu context invoked by a smp cross call. It not supposed to be
> + * called directly.
> + */
>  static void cpuidle_setup_broadcast_timer(void *arg)
>  {
>  	int cpu = smp_processor_id();
>  	clockevents_notify((long)(arg), &cpu);
>  }
>  
> +/**
> + * __cpuidle_driver_init - initialize the driver's internal data
> + * @drv: a valid pointer to a struct cpuidle_driver
> + *
> + * Returns 0 on success, a negative error otherwise.
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
> @@ -111,6 +183,21 @@ static int __cpuidle_driver_init(struct cpuidle_driver *drv)
>  	return 0;
>  }
>  
> +/**
> + * __cpuidle_register_driver: registers the driver
> + * @drv: a valid pointer to a struct cpuidle_driver
> + *
> + * Does some sanity checks, initializes the driver, assigns the driver
> + * to the global cpuidle driver variable(s) and setup the broadcast
> + * timer if the cpuidle driver has some states which shutdown the
> + * local timer.
> + *
> + * Returns 0 on success, a negative error otherwise:
> + *  * -EINVAL if the driver pointer is NULL
> + *  * -EINVAL if the not idle states available
> + *  * -ENODEV if the cpuidle framework is disabled
> + *  * -EBUSY if the driver is already assigned to the global variables
> + */
>  static int __cpuidle_register_driver(struct cpuidle_driver *drv)
>  {
>  	int ret;
> @@ -137,8 +224,13 @@ static int __cpuidle_register_driver(struct cpuidle_driver *drv)
>  }
>  
>  /**
> - * cpuidle_unregister_driver - unregisters a driver
> - * @drv: the driver
> + * __cpuidle_unregister_driver - unregister the driver
> + * @drv: a valid pointer to a struct cpuidle_driver
> + *
> + * Checks the driver is no longer in use, resets the global cpuidle
> + * driver variable(s) and disable the timer broadcast notification
> + * mechanism if it was in use.
> + *
>   */
>  static void __cpuidle_unregister_driver(struct cpuidle_driver *drv)
>  {
> @@ -156,7 +248,13 @@ static void __cpuidle_unregister_driver(struct cpuidle_driver *drv)
>  
>  /**
>   * cpuidle_register_driver - registers a driver
> - * @drv: the driver
> + * @drv: a pointer to a valid struct cpuidle_driver
> + *
> + * Registers the driver by taking a lock to prevent multiple callers
> + * to [un]register a driver at the same time.
> + *
> + * Returns 0 on success, a negative error otherwise (refer to the
> + *  __cpuidle_register_driver).
>   */
>  int cpuidle_register_driver(struct cpuidle_driver *drv)
>  {
> @@ -172,7 +270,11 @@ EXPORT_SYMBOL_GPL(cpuidle_register_driver);
>  
>  /**
>   * cpuidle_unregister_driver - unregisters a driver
> - * @drv: the driver
> + * @drv: a pointer to a valid struct cpuidle_driver
> + *
> + * Unregisters a driver by taking a lock to prevent multiple callers
> + * to [un]register a driver at the same time. The specified driver
> + * must match the driver currently registered.
>   */
>  void cpuidle_unregister_driver(struct cpuidle_driver *drv)
>  {
> @@ -183,7 +285,9 @@ void cpuidle_unregister_driver(struct cpuidle_driver *drv)
>  EXPORT_SYMBOL_GPL(cpuidle_unregister_driver);
>  
>  /**
> - * cpuidle_get_driver - return the current driver
> + * cpuidle_get_driver - returns the driver tied with the current cpu.
> + *
> + * Returns a struct cpuidle_driver pointer, or NULL if no driver is registered
>   */
>  struct cpuidle_driver *cpuidle_get_driver(void)
>  {
> @@ -199,7 +303,11 @@ struct cpuidle_driver *cpuidle_get_driver(void)
>  EXPORT_SYMBOL_GPL(cpuidle_get_driver);
>  
>  /**
> - * cpuidle_get_cpu_driver - return the driver tied with a cpu
> + * cpuidle_get_cpu_driver - returns the driver registered with a cpu.
> + * @dev: a valid pointer to a struct cpuidle_device
> + *
> + * Returns a struct cpuidle_driver pointer, or NULL if no driver is registered
> + * for the specified cpu
>   */
>  struct cpuidle_driver *cpuidle_get_cpu_driver(struct cpuidle_device *dev)
>  {
> @@ -210,6 +318,14 @@ struct cpuidle_driver *cpuidle_get_cpu_driver(struct cpuidle_device *dev)
>  }
>  EXPORT_SYMBOL_GPL(cpuidle_get_cpu_driver);
>  
> +/**
> + * cpuidle_driver_ref - gets a refcount for the driver
> + *
> + * This function takes a refcount for the driver assigned to the current cpu
> + *
> + * Returns a struct cpuidle_driver pointer, or NULL if no driver is registered
> + * for the current cpu
> + */
>  struct cpuidle_driver *cpuidle_driver_ref(void)
>  {
>  	struct cpuidle_driver *drv;
> @@ -223,6 +339,12 @@ struct cpuidle_driver *cpuidle_driver_ref(void)
>  	return drv;
>  }
>  
> +/**
> + * cpuidle_driver_unref - puts down the refcount for the driver
> + *
> + * This function decrements the refcount for the driver assigned to the current
> + * cpu.
> + */
>  void cpuidle_driver_unref(void)
>  {
>  	struct cpuidle_driver *drv = cpuidle_get_driver();
> 
-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
