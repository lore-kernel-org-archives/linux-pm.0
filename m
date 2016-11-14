From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH v2 2/3] cpuidle: allow setting deepest idle
Date: Mon, 14 Nov 2016 22:42:03 +0100
Message-ID: <7184537.W21RKrGsQO@vostro.rjw.lan>
References: <1479149278-12418-1-git-send-email-jacob.jun.pan@linux.intel.com> <1479149278-12418-3-git-send-email-jacob.jun.pan@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1479149278-12418-3-git-send-email-jacob.jun.pan@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jacob Pan <jacob.jun.pan@linux.intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, LKML <linux-kernel@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>, Arjan van de Ven <arjan@linux.intel.com>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Len Brown <lenb@kernel.org>, Rafael Wysocki <rafael.j.wysocki@intel.com>, Eduardo Valentin <edubezval@gmail.com>, Zhang Rui <rui.zhang@intel.com>, Petr Mladek <pmladek@suse.com>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>
List-Id: linux-pm@vger.kernel.org

On Monday, November 14, 2016 10:47:57 AM Jacob Pan wrote:
> When idle injection is used to cap power, we need to override
> governor's choice of idle states. This patch allows caller to select
> the deepest idle state on a CPU therefore achieve the maximum
> potential power saving.
> 
> Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
> ---
>  drivers/cpuidle/cpuidle.c | 11 +++++++++++
>  include/linux/cpuidle.h   |  4 +++-
>  kernel/sched/idle.c       |  3 +++
>  3 files changed, 17 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/cpuidle/cpuidle.c b/drivers/cpuidle/cpuidle.c
> index c73207a..887a52a 100644
> --- a/drivers/cpuidle/cpuidle.c
> +++ b/drivers/cpuidle/cpuidle.c
> @@ -97,6 +97,17 @@ static int find_deepest_state(struct cpuidle_driver *drv,
>  	return ret;
>  }
>  
> +/* Set the current cpu to use the deepest idle state, override governors */
> +void cpuidle_use_deepest_state(bool enable)
> +{
> +	struct cpuidle_device *dev;
> +
> +	preempt_disable();
> +	dev = cpuidle_get_device();
> +	dev->use_deepest_state = enable;
> +	preempt_enable();
> +}
> +
>  #ifdef CONFIG_SUSPEND
>  /**
>   * cpuidle_find_deepest_state - Find the deepest available idle state.
> diff --git a/include/linux/cpuidle.h b/include/linux/cpuidle.h
> index bb31373..7f93c63 100644
> --- a/include/linux/cpuidle.h
> +++ b/include/linux/cpuidle.h
> @@ -74,6 +74,7 @@ struct cpuidle_state {
>  struct cpuidle_device {
>  	unsigned int		registered:1;
>  	unsigned int		enabled:1;
> +	unsigned int		use_deepest_state:1;
>  	unsigned int		cpu;
>  
>  	int			last_residency;
> @@ -192,11 +193,12 @@ static inline struct cpuidle_driver *cpuidle_get_cpu_driver(
>  static inline struct cpuidle_device *cpuidle_get_device(void) {return NULL; }
>  #endif
>  
> -#if defined(CONFIG_CPU_IDLE) && defined(CONFIG_SUSPEND)
> +#if defined(CONFIG_CPU_IDLE)

#ifdef CONFIG_CPU_IDLE

would be more ususal.

>  extern int cpuidle_find_deepest_state(struct cpuidle_driver *drv,
>  				      struct cpuidle_device *dev);
>  extern int cpuidle_enter_freeze(struct cpuidle_driver *drv,
>  				struct cpuidle_device *dev);
> +extern void cpuidle_use_deepest_state(bool enable);
>  #else
>  static inline int cpuidle_find_deepest_state(struct cpuidle_driver *drv,
>  					     struct cpuidle_device *dev)
> diff --git a/kernel/sched/idle.c b/kernel/sched/idle.c
> index cb6442f..9e80f32 100644
> --- a/kernel/sched/idle.c
> +++ b/kernel/sched/idle.c
> @@ -173,6 +173,9 @@ static void cpuidle_idle_call(void)
>  
>  		next_state = cpuidle_find_deepest_state(drv, dev);
>  		call_cpuidle(drv, dev, next_state);
> +	} else if (dev->use_deepest_state) {
> +		next_state = cpuidle_find_deepest_state(drv, dev);
> +		call_cpuidle(drv, dev, next_state);
>  	} else {
>  		/*
>  		 * Ask the cpuidle framework to choose a convenient idle state.

I would arrange the code slightly differently here:

	if (idle_should_freeze() || dev->use_deepest_state) {
		if (idle_should_freeze()) {
			entered_state = cpuidle_enter_freeze(drv, dev);
			if (entered_state > 0) {
				local_irq_enable();
				goto exit_idle;
			}
		}

		next_state = cpuidle_find_deepest_state(drv, dev);
		call_cpuidle(drv, dev, next_state);
	} else {


This way you'd avoid the ugly code duplication and the extra
dev->use_deepest_state branch in the most frequent case.  I guess you could
take the unlikely() thing away from idle_should_freeze() and use it directly
here too.

Thanks,
Rafael
