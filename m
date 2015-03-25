From: Nicolas Pitre <nicolas.pitre@linaro.org>
Subject: Re: [PATCH 09/09] arm: bl_switcher: Kill tick suspend hackery
Date: Wed, 25 Mar 2015 08:34:12 -0400 (EDT)
Message-ID: <alpine.LFD.2.11.1503250833420.27567@knanqh.ubzr>
References: <20150216121435.203983131@infradead.org> <4241632.Wi7SZdKMQs@vostro.rjw.lan> <1655112.Ws17YsMfN7@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1655112.Ws17YsMfN7@vostro.rjw.lan>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Peter Zijlstra <peterz@infradead.org>, linux-kernel@vger.kernel.org, mingo@kernel.org, tglx@linutronix.de, Linux PM list <linux-pm@vger.kernel.org>, Russell King <rmk+kernel@arm.linux.org.uk>
List-Id: linux-pm@vger.kernel.org

On Wed, 25 Mar 2015, Rafael J. Wysocki wrote:

> From: Thomas Gleixner <tglx@linutronix.de>
> 
> Use the new tick_suspend/resume_local() and get rid of the homebrewn
> implementation of these in the ARM bL switcher.  The check for the
> cpumask is completely pointless.  There is no harm to suspend a per
> cpu tick device unconditionally.  If that's a real issue then we fix
> it proper at the core level and not with some completely undocumented
> hacks in some random core code.
> 
> Move the tick internals to the core code, now that this nuisance is
> gone.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> Cc: Nicolas Pitre <nicolas.pitre@linaro.org>
> Cc: Russell King <rmk+kernel@arm.linux.org.uk>
> [ rjw: Rebase, changelog ]
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Acked-by: Nicolas Pitre <nicolas.pitre@linaro.org>

> ---
>  arch/arm/common/bL_switcher.c |   16 ++--------------
>  include/linux/clockchips.h    |    6 ------
>  include/linux/tick.h          |   19 ++++---------------
>  kernel/time/tick-common.c     |    2 +-
>  kernel/time/tick-internal.h   |    5 +++++
>  kernel/time/tick-sched.h      |   10 ++++++++++
>  6 files changed, 22 insertions(+), 36 deletions(-)
> 
> Index: linux-pm/include/linux/tick.h
> ===================================================================
> --- linux-pm.orig/include/linux/tick.h
> +++ linux-pm/include/linux/tick.h
> @@ -11,30 +11,19 @@
>  #include <linux/cpumask.h>
>  #include <linux/sched.h>
>  
> -/* ARM BL switcher abuse support */
> -#ifdef CONFIG_GENERIC_CLOCKEVENTS
> -enum tick_device_mode {
> -	TICKDEV_MODE_PERIODIC,
> -	TICKDEV_MODE_ONESHOT,
> -};
> -
> -struct tick_device {
> -	struct clock_event_device *evtdev;
> -	enum tick_device_mode mode;
> -};
> -extern struct tick_device *tick_get_device(int cpu);
> -#endif
> -
>  #ifdef CONFIG_GENERIC_CLOCKEVENTS
>  extern void __init tick_init(void);
>  extern void tick_freeze(void);
>  extern void tick_unfreeze(void);
> -/* Should be core only, but XEN resume magic requires this */
> +/* Should be core only, but ARM BL switcher requires it */
> +extern void tick_suspend_local(void);
> +/* Should be core only, but XEN resume magic and ARM BL switcher require it */
>  extern void tick_resume_local(void);
>  #else /* CONFIG_GENERIC_CLOCKEVENTS */
>  static inline void tick_init(void) { }
>  static inline void tick_freeze(void) { }
>  static inline void tick_unfreeze(void) { }
> +static inline void tick_suspend_local(void) { }
>  static inline void tick_resume_local(void) { }
>  #endif /* !CONFIG_GENERIC_CLOCKEVENTS */
>  
> Index: linux-pm/arch/arm/common/bL_switcher.c
> ===================================================================
> --- linux-pm.orig/arch/arm/common/bL_switcher.c
> +++ linux-pm/arch/arm/common/bL_switcher.c
> @@ -151,8 +151,6 @@ static int bL_switch_to(unsigned int new
>  	unsigned int mpidr, this_cpu, that_cpu;
>  	unsigned int ob_mpidr, ob_cpu, ob_cluster, ib_mpidr, ib_cpu, ib_cluster;
>  	struct completion inbound_alive;
> -	struct tick_device *tdev;
> -	enum clock_event_mode tdev_mode;
>  	long volatile *handshake_ptr;
>  	int ipi_nr, ret;
>  
> @@ -219,13 +217,7 @@ static int bL_switch_to(unsigned int new
>  	/* redirect GIC's SGIs to our counterpart */
>  	gic_migrate_target(bL_gic_id[ib_cpu][ib_cluster]);
>  
> -	tdev = tick_get_device(this_cpu);
> -	if (tdev && !cpumask_equal(tdev->evtdev->cpumask, cpumask_of(this_cpu)))
> -		tdev = NULL;
> -	if (tdev) {
> -		tdev_mode = tdev->evtdev->mode;
> -		clockevents_set_mode(tdev->evtdev, CLOCK_EVT_MODE_SHUTDOWN);
> -	}
> +	tick_suspend_local();
>  
>  	ret = cpu_pm_enter();
>  
> @@ -251,11 +243,7 @@ static int bL_switch_to(unsigned int new
>  
>  	ret = cpu_pm_exit();
>  
> -	if (tdev) {
> -		clockevents_set_mode(tdev->evtdev, tdev_mode);
> -		clockevents_program_event(tdev->evtdev,
> -					  tdev->evtdev->next_event, 1);
> -	}
> +	tick_resume_local();
>  
>  	trace_cpu_migrate_finish(ktime_get_real_ns(), ib_mpidr);
>  	local_fiq_enable();
> Index: linux-pm/include/linux/clockchips.h
> ===================================================================
> --- linux-pm.orig/include/linux/clockchips.h
> +++ linux-pm/include/linux/clockchips.h
> @@ -163,12 +163,6 @@ clockevents_calc_mult_shift(struct clock
>  				      freq, minsec);
>  }
>  
> -/* Should be core only, but is abused by arm bl_switcher */
> -extern void clockevents_set_mode(struct clock_event_device *dev,
> -				 enum clock_event_mode mode);
> -extern int clockevents_program_event(struct clock_event_device *dev,
> -				     ktime_t expires, bool force);
> -
>  extern void clockevents_suspend(void);
>  extern void clockevents_resume(void);
>  
> Index: linux-pm/kernel/time/tick-internal.h
> ===================================================================
> --- linux-pm.orig/kernel/time/tick-internal.h
> +++ linux-pm/kernel/time/tick-internal.h
> @@ -28,6 +28,7 @@ extern bool tick_check_replacement(struc
>  				   struct clock_event_device *newdev);
>  extern void tick_install_replacement(struct clock_event_device *dev);
>  extern int tick_is_oneshot_available(void);
> +extern struct tick_device *tick_get_device(int cpu);
>  
>  /* Check, if the device is functional or a dummy for broadcast */
>  static inline int tick_device_is_functional(struct clock_event_device *dev)
> @@ -38,6 +39,10 @@ static inline int tick_device_is_functio
>  extern void clockevents_shutdown(struct clock_event_device *dev);
>  extern void clockevents_exchange_device(struct clock_event_device *old,
>  					struct clock_event_device *new);
> +extern void clockevents_set_mode(struct clock_event_device *dev,
> +				 enum clock_event_mode mode);
> +extern int clockevents_program_event(struct clock_event_device *dev,
> +				     ktime_t expires, bool force);
>  extern void clockevents_handle_noop(struct clock_event_device *dev);
>  extern int __clockevents_update_freq(struct clock_event_device *dev, u32 freq);
>  extern ssize_t sysfs_get_uname(const char *buf, char *dst, size_t cnt);
> Index: linux-pm/kernel/time/tick-sched.h
> ===================================================================
> --- linux-pm.orig/kernel/time/tick-sched.h
> +++ linux-pm/kernel/time/tick-sched.h
> @@ -3,6 +3,16 @@
>  
>  #include <linux/hrtimer.h>
>  
> +enum tick_device_mode {
> +	TICKDEV_MODE_PERIODIC,
> +	TICKDEV_MODE_ONESHOT,
> +};
> +
> +struct tick_device {
> +	struct clock_event_device *evtdev;
> +	enum tick_device_mode mode;
> +};
> +
>  enum tick_nohz_mode {
>  	NOHZ_MODE_INACTIVE,
>  	NOHZ_MODE_LOWRES,
> Index: linux-pm/kernel/time/tick-common.c
> ===================================================================
> --- linux-pm.orig/kernel/time/tick-common.c
> +++ linux-pm/kernel/time/tick-common.c
> @@ -379,7 +379,7 @@ void tick_shutdown(unsigned int *cpup)
>   *
>   * No locks required. Nothing can change the per cpu device.
>   */
> -static void tick_suspend_local(void)
> +void tick_suspend_local(void)
>  {
>  	struct tick_device *td = this_cpu_ptr(&tick_cpu_device);
>  
> 
> 
