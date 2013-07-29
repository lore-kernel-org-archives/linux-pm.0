From: Jacob Pan <jacob.jun.pan@linux.intel.com>
Subject: Re: [RFC PATCH] thermal: powerclamp: Add support for ARM machine to
 powerclamp driver.
Date: Mon, 29 Jul 2013 11:11:22 -0700
Message-ID: <20130729111122.1e05bf46@chromoly>
References: <1374747727-18602-1-git-send-email-jonghwa3.lee@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:38528 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752159Ab3G2SLD (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Mon, 29 Jul 2013 14:11:03 -0400
In-Reply-To: <1374747727-18602-1-git-send-email-jonghwa3.lee@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Jonghwa Lee <jonghwa3.lee@samsung.com>
Cc: linux-pm@vger.kernel.org, rui.zhang@intel.com, eduardo.valentin@ti.com, amit.daniel@samsung.com, Myungjoo Ham <myungjoo.ham@samsung.com>, "Van De Ven, Arjan" <arjan.van.de.ven@intel.com>

On Thu, 25 Jul 2013 19:22:07 +0900
Jonghwa Lee <jonghwa3.lee@samsung.com> wrote:

> This patch modifies intel_powerclamp driver can be used in not only
> x86 but also ARM. Any ARM system can use intel_powerclamp driver for
> managing thermal problem through injecting intentional idle cycle.
> The required modification is only that it replaces x86's instruction,
> mwait, with arm specific one, wfi and changes the way of calculation
> of idle rate of last window. Other algorithm and codes can be shared
> without any amendment.
> 
+arjan

In general, I agree with you to decouple platform specific part
such as timing and idle data collection from the algorithm. The
abstraction can be cleaner and more complete. Please see my comments
below.

> Signed-off-by: Jonghwa Lee <jonghwa3.lee@samsung.com>
> Signed-off-by: Myungjoo Ham <myungjoo.ham@samsung.com>
> ---
>  drivers/thermal/Kconfig            |    3 +-
>  drivers/thermal/intel_powerclamp.c |   94
> ++++++++++++++++++++++++++---------- 2 files changed, 70
> insertions(+), 27 deletions(-)
> 
> diff --git a/drivers/thermal/Kconfig b/drivers/thermal/Kconfig
> index e988c81..912a788 100644
> --- a/drivers/thermal/Kconfig
> +++ b/drivers/thermal/Kconfig
> @@ -162,8 +162,7 @@ config DB8500_CPUFREQ_COOLING
>  config INTEL_POWERCLAMP
>  	tristate "Intel PowerClamp idle injection driver"
>  	depends on THERMAL
> -	depends on X86
> -	depends on CPU_SUP_INTEL
> +	depends on (X86 && CPU_SUP_INTEL) || ARM
>  	help
>  	  Enable this to enable Intel PowerClamp idle injection
> driver. This enforce idle time which results in more package C-state
> residency. The diff --git a/drivers/thermal/intel_powerclamp.c
> b/drivers/thermal/intel_powerclamp.c index b40b37c..3ff350b 100644
> --- a/drivers/thermal/intel_powerclamp.c
> +++ b/drivers/thermal/intel_powerclamp.c
> @@ -52,12 +52,18 @@
>  #include <linux/seq_file.h>
>  #include <linux/sched/rt.h>
>  
> +#include <asm/hardirq.h>
> +#ifdef CONFIG_X86
>  #include <asm/nmi.h>
>  #include <asm/msr.h>
>  #include <asm/mwait.h>
>  #include <asm/cpu_device_id.h>
>  #include <asm/idle.h>
> -#include <asm/hardirq.h>
> +
> +static unsigned int target_mwait;
> +#elif CONFIG_ARM
> +#include <asm/proc-fns.h>
> +#endif
>  
>  #define MAX_TARGET_RATIO (50U)
>  /* For each undisturbed clamping period (no extra wake ups during
> idle time), @@ -71,7 +77,6 @@
>   */
>  #define DEFAULT_DURATION_JIFFIES (6)
>  
> -static unsigned int target_mwait;
>  static struct dentry *debug_dir;
>  
>  /* user selected target */
> @@ -178,6 +183,7 @@ MODULE_PARM_DESC(window_size, "sliding window in
> number of clamping cycles\n" "\twindow size results in slower
> response time but more smooth\n" "\tclamping results. default to 2.");
>  
> +#ifdef CONFIG_X86
>  static void find_target_mwait(void)
>  {
>  	unsigned int eax, ebx, ecx, edx;
> @@ -246,6 +252,7 @@ static u64 pkg_state_counter(void)
>  
>  	return count;
>  }
> +#endif
>  
>  static void noop_timer(unsigned long foo)
>  {
> @@ -316,6 +323,25 @@ static void adjust_compensation(int
> target_ratio, unsigned int win) }
>  }
>  
> +#ifdef CONFIG_X86
> +static void inline powerclamp_get_cstate_inform(u64 *msr_now, u64
> *tsc_now) +{
> +	*msr_now = pkg_state_counter();
> +	rdtscll(*tsc_now);
> +}
> +#elif CONFIG_ARM
> +static void inline powerclamp_get_cstate_inform(u64 *idle, u64 *wall)
> +{
> +	u64 _wall;
> +	int cpu;
> +
> +	for_each_online_cpu(cpu) {
> +		*idle += get_cpu_idle_time_us(cpu, &_wall);
> +		*wall += _wall;
> +	}
> +}
> +#endif
> +
>  static bool powerclamp_adjust_controls(unsigned int target_ratio,
>  				unsigned int guard, unsigned int win)
>  {
> @@ -324,8 +350,7 @@ static bool powerclamp_adjust_controls(unsigned
> int target_ratio, u64 val64;
>  
>  	/* check result for the last window */
> -	msr_now = pkg_state_counter();
> -	rdtscll(tsc_now);
> +	powerclamp_get_cstate_inform(&msr_now, &tsc_now);
>  
This function name is misleading, it is better to separate clock source
data and idle state counter.
>  	/* calculate pkg cstate vs tsc ratio */
>  	if (!msr_last || !tsc_last)
> @@ -353,6 +378,34 @@ static bool powerclamp_adjust_controls(unsigned
> int target_ratio, return set_target_ratio + guard <= current_ratio;
>  }
>  
> +#ifdef CONFIG_X86
> +static void powerclamp_enter_idle(void)
> +{
> +	unsigned long ecx = 1;
> +	unsigned long eax = target_mwait;
> +
> +	/*
> +	 * REVISIT: may call enter_idle() to notify drivers who
> +	 * can save power during cpu idle. same for exit_idle()
> +	 */
> +	local_touch_nmi();
> +	stop_critical_timings();
> +	__monitor((void *)&current_thread_info()->flags, 0, 0);
> +	cpu_relax(); /* allow HT sibling to run */
> +	__mwait(eax, ecx);
> +	start_critical_timings();
> +	atomic_inc(&idle_wakeup_counter);
> +}
> +#elif CONFIG_ARM

#elif defined(CONFIG_ARM)
otherwise, get compiler warning on x86

> +static void  powerclamp_enter_idle(void)
> +{
> +	stop_critical_timings();
> +	cpu_do_idle();
> +	start_critical_timings();
> +	atomic_inc(&idle_wakeup_counter);
> +}
> +#endif
> +
>  static int clamp_thread(void *arg)
>  {
>  	int cpunr = (unsigned long)arg;
> @@ -428,22 +481,9 @@ static int clamp_thread(void *arg)
>  		preempt_disable();
>  		tick_nohz_idle_enter();
>  		/* mwait until target jiffies is reached */
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
> -			__monitor((void
> *)&current_thread_info()->flags, 0, 0);
> -			cpu_relax(); /* allow HT sibling to run */
> -			__mwait(eax, ecx);
> -			start_critical_timings();
> -			atomic_inc(&idle_wakeup_counter);
> -		}
> +		while (time_before(jiffies, target_jiffies))
> +			powerclamp_enter_idle();
> +
>  		tick_nohz_idle_exit();
>  		preempt_enable_no_resched();
>  	}
> @@ -465,13 +505,12 @@ static void poll_pkg_cstate(struct work_struct
> *dummy) static u64 tsc_last;
>  	static unsigned long jiffies_last;
>  
> -	u64 msr_now;
> +	u64 msr_now = 0;
>  	unsigned long jiffies_now;
> -	u64 tsc_now;
> +	u64 tsc_now = 0;
>  	u64 val64;
>  
> -	msr_now = pkg_state_counter();
> -	rdtscll(tsc_now);
> +	powerclamp_get_cstate_inform(&msr_now, &tsc_now);
>  	jiffies_now = jiffies;
>  
>  	/* calculate pkg cstate vs tsc ratio */
> @@ -499,11 +538,13 @@ static int start_power_clamp(void)
>  	unsigned long cpu;
>  	struct task_struct *thread;
>  
> +#ifdef CONFIG_X86
>  	/* check if pkg cstate counter is completely 0, abort in
> this case */ if (!pkg_state_counter()) {
>  		pr_err("pkg cstate counter not functional, abort\n");
>  		return -EINVAL;
>  	}
> +#endif
>  
>  	set_target_ratio = clamp(set_target_ratio, 0U,
> MAX_TARGET_RATIO - 1); /* prevent cpu hotplug */
> @@ -661,6 +702,7 @@ static struct thermal_cooling_device_ops
> powerclamp_cooling_ops = { .set_cur_state = powerclamp_set_cur_state,
>  };
>  
> +#ifdef CONFIG_X86
>  /* runs on Nehalem and later */
>  static const struct x86_cpu_id intel_powerclamp_ids[] = {
>  	{ X86_VENDOR_INTEL, 6, 0x1a},
> @@ -678,9 +720,11 @@ static const struct x86_cpu_id
> intel_powerclamp_ids[] = { {}
>  };
>  MODULE_DEVICE_TABLE(x86cpu, intel_powerclamp_ids);
> +#endif
>  
>  static int powerclamp_probe(void)
>  {
> +#ifdef CONFIG_X86
>  	if (!x86_match_cpu(intel_powerclamp_ids)) {
>  		pr_err("Intel powerclamp does not run on family %d
> model %d\n", boot_cpu_data.x86, boot_cpu_data.x86_model);
> @@ -694,7 +738,7 @@ static int powerclamp_probe(void)
>  
>  	/* find the deepest mwait value */
>  	find_target_mwait();
> -
> +#endif
>  	return 0;
>  }
>  

[Jacob Pan]

-- 
Thanks,

Jacob
