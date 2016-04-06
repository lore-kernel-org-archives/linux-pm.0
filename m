From: Jacob Pan <jacob.jun.pan@linux.intel.com>
Subject: Re: [PATCH] thermal/intel_powerclamp: convert to smpboot thread
Date: Wed, 6 Apr 2016 09:47:35 -0700
Message-ID: <20160406094735.1bbb3c0c@icelake>
References: <1457710701-3014-1-git-send-email-bigeasy@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:25892 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750943AbcDFQtG (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Wed, 6 Apr 2016 12:49:06 -0400
In-Reply-To: <1457710701-3014-1-git-send-email-bigeasy@linutronix.de>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: linux-kernel@vger.kernel.org, rt@linutronix.de, Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>, linux-pm@vger.kernel.org, jacob.jun.pan@linux.intel.com, "Van De Ven, Arjan" <arjan.van.de.ven@intel.com>

On Fri, 11 Mar 2016 16:38:21 +0100
Sebastian Andrzej Siewior <bigeasy@linutronix.de> wrote:
Apologize for the delay, I missed it until Rui reminded me.
> Oh boy oh boy. This thing runs at SCHED_FIFO MAX_USER_RT_PRIO/2 and
> stops at mwait_idle_with_hints(). Why bother with /2?
> There are a few things I haven't fully decoded. For instance why is it
> looking at local_softirq_pending()?
the idea is to instrument some kind of quality of service. Idle
injection is a best effort based mechanism. So we don't want to affect
high priority realtime tasks nor softirq.
> The timer is probably here if mwait would let it sleep too long.
> 
not sure i understand. could you explain?
> I tried to convert it over to smpboot thread so we don't have that CPU
> notifier stuff to fire the cpu threads during hotplug events.
> 
there is another patchset to convert it to kthread worker. any
advantage of smpboot thread?
http://comments.gmane.org/gmane.linux.kernel.mm/144964
> the smp_mb() barriers are not documented - I just shifted the code to
> the left.
> 
good point, it was for making control variables visible to other CPUs
immediately.
> The code / logic itself could be a little more inteligent and only
> wake up the threads for the CPUs that are about to idle but it seems
> it is done on all of the at once unless I missed something.
> 
you mean only force idle when there is no natural idle? i thought
about that but hard to coordinate and enforce the duration of each
idle period. Any specific pointers?
> Cc: Zhang Rui <rui.zhang@intel.com>
> Cc: Eduardo Valentin <edubezval@gmail.com>
> Cc: linux-pm@vger.kernel.org
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> ---
>  drivers/thermal/intel_powerclamp.c | 315
> ++++++++++++++++--------------------- 1 file changed, 136
> insertions(+), 179 deletions(-)
> 
> diff --git a/drivers/thermal/intel_powerclamp.c
> b/drivers/thermal/intel_powerclamp.c index 6c79588251d5..e04f7631426a
> 100644 --- a/drivers/thermal/intel_powerclamp.c
> +++ b/drivers/thermal/intel_powerclamp.c
> @@ -51,6 +51,7 @@
>  #include <linux/debugfs.h>
>  #include <linux/seq_file.h>
>  #include <linux/sched/rt.h>
> +#include <linux/smpboot.h>
>  
>  #include <asm/nmi.h>
>  #include <asm/msr.h>
> @@ -85,9 +86,9 @@ static unsigned int control_cpu; /* The cpu
> assigned to collect stat and update
>  				  * can be offlined.
>  				  */
>  static bool clamping;
> +static DEFINE_PER_CPU(struct task_struct *, clamp_kthreads);
> +static DEFINE_PER_CPU(struct timer_list, clamp_timer);
>  
> -
> -static struct task_struct * __percpu *powerclamp_thread;
>  static struct thermal_cooling_device *cooling_dev;
>  static unsigned long *cpu_clamping_mask;  /* bit map for tracking
> per cpu
>  					   * clamping thread
> @@ -368,100 +369,82 @@ static bool
> powerclamp_adjust_controls(unsigned int target_ratio, return
> set_target_ratio + guard <= current_ratio; }
>  
> -static int clamp_thread(void *arg)
> +static void clamp_thread_fn(unsigned int cpu)
>  {
> -	int cpunr = (unsigned long)arg;
> -	DEFINE_TIMER(wakeup_timer, noop_timer, 0, 0);
> -	static const struct sched_param param = {
> -		.sched_priority = MAX_USER_RT_PRIO/2,
> -	};
>  	unsigned int count = 0;
>  	unsigned int target_ratio;
> +	int sleeptime;
> +	unsigned long target_jiffies;
> +	unsigned int guard;
> +	unsigned int compensation = 0;
> +	int interval; /* jiffies to sleep for each attempt */
> +	unsigned int duration_jiffies = msecs_to_jiffies(duration);
> +	unsigned int window_size_now;
> +	struct timer_list *wake_timer = per_cpu_ptr(&clamp_timer,
> cpu); 
> -	set_bit(cpunr, cpu_clamping_mask);
> -	set_freezable();
> -	init_timer_on_stack(&wakeup_timer);
> -	sched_setscheduler(current, SCHED_FIFO, &param);
> +	/*
> +	 * make sure user selected ratio does not take effect until
> +	 * the next round. adjust target_ratio if user has changed
> +	 * target such that we can converge quickly.
> +	 */
> +	target_ratio = set_target_ratio;
> +	guard = 1 + target_ratio/20;
> +	window_size_now = window_size;
> +	count++;
>  
> -	while (true == clamping && !kthread_should_stop() &&
> -		cpu_online(cpunr)) {
> -		int sleeptime;
> -		unsigned long target_jiffies;
> -		unsigned int guard;
> -		unsigned int compensation = 0;
> -		int interval; /* jiffies to sleep for each attempt */
> -		unsigned int duration_jiffies =
> msecs_to_jiffies(duration);
> -		unsigned int window_size_now;
> +	/*
> +	 * systems may have different ability to enter package level
> +	 * c-states, thus we need to compensate the injected idle
> ratio
> +	 * to achieve the actual target reported by the HW.
> +	 */
> +	compensation = get_compensation(target_ratio);
> +	interval = duration_jiffies*100/(target_ratio+compensation);
>  
> -		try_to_freeze();
> -		/*
> -		 * make sure user selected ratio does not take
> effect until
> -		 * the next round. adjust target_ratio if user has
> changed
> -		 * target such that we can converge quickly.
> -		 */
> -		target_ratio = set_target_ratio;
> -		guard = 1 + target_ratio/20;
> -		window_size_now = window_size;
> -		count++;
> -
> -		/*
> -		 * systems may have different ability to enter
> package level
> -		 * c-states, thus we need to compensate the injected
> idle ratio
> -		 * to achieve the actual target reported by the HW.
> -		 */
> -		compensation = get_compensation(target_ratio);
> -		interval =
> duration_jiffies*100/(target_ratio+compensation); -
> -		/* align idle time */
> -		target_jiffies = roundup(jiffies, interval);
> -		sleeptime = target_jiffies - jiffies;
> -		if (sleeptime <= 0)
> -			sleeptime = 1;
> -		schedule_timeout_interruptible(sleeptime);
> -		/*
> -		 * only elected controlling cpu can collect stats
> and update
> -		 * control parameters.
> -		 */
> -		if (cpunr == control_cpu
> && !(count%window_size_now)) {
> -			should_skip =
> -
> powerclamp_adjust_controls(target_ratio,
> -							guard,
> window_size_now);
> -			smp_mb();
> -		}
> -
> -		if (should_skip)
> -			continue;
> -
> -		target_jiffies = jiffies + duration_jiffies;
> -		mod_timer(&wakeup_timer, target_jiffies);
> -		if (unlikely(local_softirq_pending()))
> -			continue;
> -		/*
> -		 * stop tick sched during idle time, interrupts are
> still
> -		 * allowed. thus jiffies are updated properly.
> -		 */
> -		preempt_disable();
> -		/* mwait until target jiffies is reached */
> -		while (time_before(jiffies, target_jiffies)) {
> -			unsigned long ecx = 1;
> -			unsigned long eax = target_mwait;
> -
> -			/*
> -			 * REVISIT: may call enter_idle() to notify
> drivers who
> -			 * can save power during cpu idle. same for
> exit_idle()
> -			 */
> -			local_touch_nmi();
> -			stop_critical_timings();
> -			mwait_idle_with_hints(eax, ecx);
> -			start_critical_timings();
> -			atomic_inc(&idle_wakeup_counter);
> -		}
> -		preempt_enable();
> +	/* align idle time */
> +	target_jiffies = roundup(jiffies, interval);
> +	sleeptime = target_jiffies - jiffies;
> +	if (sleeptime <= 0)
> +		sleeptime = 1;
> +	schedule_timeout_interruptible(sleeptime);
> +	/*
> +	 * only elected controlling cpu can collect stats and update
> +	 * control parameters.
> +	 */
> +	if (cpu == control_cpu && !(count%window_size_now)) {
> +		should_skip =
> +			powerclamp_adjust_controls(target_ratio,
> +						   guard,
> window_size_now);
> +		smp_mb();
>  	}
> -	del_timer_sync(&wakeup_timer);
> -	clear_bit(cpunr, cpu_clamping_mask);
>  
> -	return 0;
> +	if (should_skip)
> +		return;
> +
> +	target_jiffies = jiffies + duration_jiffies;
> +	mod_timer(wake_timer, target_jiffies);
> +	if (unlikely(local_softirq_pending()))
> +		return;
> +	/*
> +	 * stop tick sched during idle time, interrupts are still
> +	 * allowed. thus jiffies are updated properly.
> +	 */
> +	preempt_disable();
> +	/* mwait until target jiffies is reached */
> +	while (time_before(jiffies, target_jiffies)) {
> +		unsigned long ecx = 1;
> +		unsigned long eax = target_mwait;
> +
> +		/*
> +		 * REVISIT: may call enter_idle() to notify drivers
> who
> +		 * can save power during cpu idle. same for
> exit_idle()
> +		 */
> +		local_touch_nmi();
> +		stop_critical_timings();
> +		mwait_idle_with_hints(eax, ecx);
> +		start_critical_timings();
> +		atomic_inc(&idle_wakeup_counter);
> +	}
> +	preempt_enable();
>  }
>  
>  /*
> @@ -505,10 +488,64 @@ static void poll_pkg_cstate(struct work_struct
> *dummy) schedule_delayed_work(&poll_pkg_cstate_work, HZ);
>  }
>  
> +static void clamp_thread_setup(unsigned int cpu)
> +{
> +	struct timer_list *wake_timer;
> +	static struct sched_param param = {
> +		.sched_priority = MAX_USER_RT_PRIO/2,
> +	};
> +
> +	sched_setscheduler(current, SCHED_FIFO, &param);
> +	wake_timer = per_cpu_ptr(&clamp_timer, cpu);
> +
> +	setup_timer(wake_timer, noop_timer, 0);
> +}
> +
> +static void clamp_thread_unpark(unsigned int cpu)
> +{
> +	set_bit(cpu, cpu_clamping_mask);
> +	if (cpu == 0) {
> +		control_cpu = 0;
> +		smp_mb();
> +	}
> +}
> +
> +static void clamp_thread_park(unsigned int cpu)
> +{
> +	clear_bit(cpu, cpu_clamping_mask);
> +	if (cpu == control_cpu) {
> +		control_cpu = cpumask_any_but(cpu_online_mask, cpu);
> +		smp_mb();
> +	}
> +	del_timer_sync(per_cpu_ptr(&clamp_timer, cpu));
> +}
> +
> +static void clamp_thread_cleanup(unsigned int cpu, bool online)
> +{
> +	if (!online)
> +		return;
> +	clamp_thread_park(cpu);
> +}
> +
> +static int clamp_thread_should_run(unsigned int cpu)
> +{
> +	return clamping == true;
> +}
> +
> +static struct smp_hotplug_thread clamp_threads = {
> +	.store			= &clamp_kthreads,
> +	.setup			= clamp_thread_setup,
> +	.cleanup		= clamp_thread_cleanup,
> +	.thread_should_run	= clamp_thread_should_run,
> +	.thread_fn		= clamp_thread_fn,
> +	.park			= clamp_thread_park,
> +	.unpark			= clamp_thread_unpark,
> +	.thread_comm		= "kidle_inject/%u",
> +};
> +
>  static int start_power_clamp(void)
>  {
> -	unsigned long cpu;
> -	struct task_struct *thread;
> +	unsigned int cpu;
>  
>  	/* check if pkg cstate counter is completely 0, abort in
> this case */ if (!has_pkg_state_counter()) {
> @@ -528,23 +565,9 @@ static int start_power_clamp(void)
>  	clamping = true;
>  	schedule_delayed_work(&poll_pkg_cstate_work, 0);
>  
> -	/* start one thread per online cpu */
> -	for_each_online_cpu(cpu) {
> -		struct task_struct **p =
> -			per_cpu_ptr(powerclamp_thread, cpu);
> +	for_each_online_cpu(cpu)
> +		wake_up_process(per_cpu_ptr(clamp_kthreads, cpu));
>  
> -		thread = kthread_create_on_node(clamp_thread,
> -						(void *) cpu,
> -						cpu_to_node(cpu),
> -						"kidle_inject/%ld",
> cpu);
> -		/* bind to cpu here */
> -		if (likely(!IS_ERR(thread))) {
> -			kthread_bind(thread, cpu);
> -			wake_up_process(thread);
> -			*p = thread;
> -		}
> -
> -	}
>  	put_online_cpus();
>  
>  	return 0;
> @@ -552,9 +575,6 @@ static int start_power_clamp(void)
>  
>  static void end_power_clamp(void)
>  {
> -	int i;
> -	struct task_struct *thread;
> -
>  	clamping = false;
>  	/*
>  	 * make clamping visible to other cpus and give per cpu
> clamping threads @@ -562,63 +582,8 @@ static void
> end_power_clamp(void) */
>  	smp_mb();
>  	msleep(20);
> -	if (bitmap_weight(cpu_clamping_mask, num_possible_cpus())) {
> -		for_each_set_bit(i, cpu_clamping_mask,
> num_possible_cpus()) {
> -			pr_debug("clamping thread for cpu %d alive,
> kill\n", i);
> -			thread = *per_cpu_ptr(powerclamp_thread, i);
> -			kthread_stop(thread);
> -		}
> -	}
>  }
>  
> -static int powerclamp_cpu_callback(struct notifier_block *nfb,
> -				unsigned long action, void *hcpu)
> -{
> -	unsigned long cpu = (unsigned long)hcpu;
> -	struct task_struct *thread;
> -	struct task_struct **percpu_thread =
> -		per_cpu_ptr(powerclamp_thread, cpu);
> -
> -	if (false == clamping)
> -		goto exit_ok;
> -
> -	switch (action) {
> -	case CPU_ONLINE:
> -		thread = kthread_create_on_node(clamp_thread,
> -						(void *) cpu,
> -						cpu_to_node(cpu),
> -						"kidle_inject/%lu",
> cpu);
> -		if (likely(!IS_ERR(thread))) {
> -			kthread_bind(thread, cpu);
> -			wake_up_process(thread);
> -			*percpu_thread = thread;
> -		}
> -		/* prefer BSP as controlling CPU */
> -		if (cpu == 0) {
> -			control_cpu = 0;
> -			smp_mb();
> -		}
> -		break;
> -	case CPU_DEAD:
> -		if (test_bit(cpu, cpu_clamping_mask)) {
> -			pr_err("cpu %lu dead but powerclamping
> thread is not\n",
> -				cpu);
> -			kthread_stop(*percpu_thread);
> -		}
> -		if (cpu == control_cpu) {
> -			control_cpu = smp_processor_id();
> -			smp_mb();
> -		}
> -	}
> -
> -exit_ok:
> -	return NOTIFY_OK;
> -}
> -
> -static struct notifier_block powerclamp_cpu_notifier = {
> -	.notifier_call = powerclamp_cpu_callback,
> -};
> -
>  static int powerclamp_get_max_state(struct thermal_cooling_device
> *cdev, unsigned long *state)
>  {
> @@ -788,19 +753,15 @@ static int __init powerclamp_init(void)
>  
>  	/* set default limit, maybe adjusted during runtime based on
> feedback */ window_size = 2;
> -	register_hotcpu_notifier(&powerclamp_cpu_notifier);
> -
> -	powerclamp_thread = alloc_percpu(struct task_struct *);
> -	if (!powerclamp_thread) {
> -		retval = -ENOMEM;
> -		goto exit_unregister;
> -	}
> +	retval = smpboot_register_percpu_thread(&clamp_threads);
> +	if (retval)
> +		goto exit_free;
>  
>  	cooling_dev =
> thermal_cooling_device_register("intel_powerclamp", NULL,
> &powerclamp_cooling_ops); if (IS_ERR(cooling_dev)) {
>  		retval = -ENODEV;
> -		goto exit_free_thread;
> +		goto exit_free_smp_thread;
>  	}
>  
>  	if (!duration)
> @@ -809,11 +770,8 @@ static int __init powerclamp_init(void)
>  	powerclamp_create_debug_files();
>  
>  	return 0;
> -
> -exit_free_thread:
> -	free_percpu(powerclamp_thread);
> -exit_unregister:
> -	unregister_hotcpu_notifier(&powerclamp_cpu_notifier);
> +exit_free_smp_thread:
> +	smpboot_unregister_percpu_thread(&clamp_threads);
>  exit_free:
>  	kfree(cpu_clamping_mask);
>  	return retval;
> @@ -822,9 +780,8 @@ module_init(powerclamp_init);
>  
>  static void __exit powerclamp_exit(void)
>  {
> -	unregister_hotcpu_notifier(&powerclamp_cpu_notifier);
>  	end_power_clamp();
> -	free_percpu(powerclamp_thread);
> +	smpboot_unregister_percpu_thread(&clamp_threads);
>  	thermal_cooling_device_unregister(cooling_dev);
>  	kfree(cpu_clamping_mask);
>  

[Jacob Pan]
