From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH 2/2] x86: cpuidle: remove broadcast timer initialization
Date: Tue, 20 Aug 2013 16:11:10 +0200
Message-ID: <4496036.lOTuXedAKS@vostro.rjw.lan>
References: <1375192468-2255-1-git-send-email-daniel.lezcano@linaro.org> <1375192468-2255-2-git-send-email-daniel.lezcano@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from hydra.sisk.pl ([212.160.235.94]:51497 "EHLO hydra.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750934Ab3HTOAi (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Tue, 20 Aug 2013 10:00:38 -0400
In-Reply-To: <1375192468-2255-2-git-send-email-daniel.lezcano@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: lenb@kernel.org, linux-pm@vger.kernel.org, patches@linaro.org, linaro-kernel@lists.linaro.org, Len Brown <len.brown@intel.com>

On Tuesday, July 30, 2013 03:54:28 PM Daniel Lezcano wrote:
> Commit 89878baa73f0f1c679355006bd8632e5d78f96c2 introduced the flag
> CPUIDLE_FLAG_TIMER_STOP where we specify a specific idle state stops the local
> timer.
> 
> Commit a06df062a189a8d5588babb8bf0bb78672497798 introduced the initialization
> of the timer broadcast framework depending of the flag presence.
> 
> We have now a way to set a flag for a specific state to tell if the local timer
> will be down in deep idle state or not and we have cpu hotplug support to setup
> the broadcast timer.

So this depends on [1/2], right?

> Remove the timer broadcast initialization from init and at the cpu hotplug
> time.
> 
> Remove the timer broadcast activation in the idle loop.
> 
> Remove the bitmap LAPIC_TIMER_ALWAYS_RELIABLE.
> 
> Set the CPUIDLE_FLAG_TIMER_STOP on the states when they are greater than C1 and
> the cpu has not X86_FEATURE_ARAT.
> 
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>

I generally like the changes made by this patch, but I wonder how much it
has been tested?

The subject is slightly misleading too, because it's about the intel_idle
driver.  Please put intel_idle in the subject.

Thanks,
Rafael


> ---
>  drivers/idle/intel_idle.c |   41 ++++-------------------------------------
>  1 file changed, 4 insertions(+), 37 deletions(-)
> 
> diff --git a/drivers/idle/intel_idle.c b/drivers/idle/intel_idle.c
> index fa6964d..a975868 100644
> --- a/drivers/idle/intel_idle.c
> +++ b/drivers/idle/intel_idle.c
> @@ -55,7 +55,6 @@
>  
>  #include <linux/kernel.h>
>  #include <linux/cpuidle.h>
> -#include <linux/clockchips.h>
>  #include <trace/events/power.h>
>  #include <linux/sched.h>
>  #include <linux/notifier.h>
> @@ -77,10 +76,6 @@ static int max_cstate = CPUIDLE_STATE_MAX - 1;
>  
>  static unsigned int mwait_substates;
>  
> -#define LAPIC_TIMER_ALWAYS_RELIABLE 0xFFFFFFFF
> -/* Reliable LAPIC Timer States, bit 1 for C1 etc.  */
> -static unsigned int lapic_timer_reliable_states = (1 << 1);	 /* Default to only C1 */
> -
>  struct idle_cpu {
>  	struct cpuidle_state *state_table;
>  
> @@ -356,9 +351,6 @@ static int intel_idle(struct cpuidle_device *dev,
>  	if (state->flags & CPUIDLE_FLAG_TLB_FLUSHED)
>  		leave_mm(cpu);
>  
> -	if (!(lapic_timer_reliable_states & (1 << (cstate))))
> -		clockevents_notify(CLOCK_EVT_NOTIFY_BROADCAST_ENTER, &cpu);
> -
>  	if (!need_resched()) {
>  
>  		__monitor((void *)&current_thread_info()->flags, 0, 0);
> @@ -367,23 +359,9 @@ static int intel_idle(struct cpuidle_device *dev,
>  			__mwait(eax, ecx);
>  	}
>  
> -	if (!(lapic_timer_reliable_states & (1 << (cstate))))
> -		clockevents_notify(CLOCK_EVT_NOTIFY_BROADCAST_EXIT, &cpu);
> -
>  	return index;
>  }
>  
> -static void __setup_broadcast_timer(void *arg)
> -{
> -	unsigned long reason = (unsigned long)arg;
> -	int cpu = smp_processor_id();
> -
> -	reason = reason ?
> -		CLOCK_EVT_NOTIFY_BROADCAST_ON : CLOCK_EVT_NOTIFY_BROADCAST_OFF;
> -
> -	clockevents_notify(reason, &cpu);
> -}
> -
>  static int cpu_hotplug_notify(struct notifier_block *n,
>  			      unsigned long action, void *hcpu)
>  {
> @@ -393,10 +371,6 @@ static int cpu_hotplug_notify(struct notifier_block *n,
>  	switch (action & 0xf) {
>  	case CPU_ONLINE:
>  
> -		if (lapic_timer_reliable_states != LAPIC_TIMER_ALWAYS_RELIABLE)
> -			smp_call_function_single(hotcpu, __setup_broadcast_timer,
> -						 (void *)true, 1);
> -
>  		/*
>  		 * Some systems can hotplug a cpu at runtime after
>  		 * the kernel has booted, we have to initialize the
> @@ -524,16 +498,9 @@ static int intel_idle_probe(void)
>  	icpu = (const struct idle_cpu *)id->driver_data;
>  	cpuidle_state_table = icpu->state_table;
>  
> -	if (boot_cpu_has(X86_FEATURE_ARAT))	/* Always Reliable APIC Timer */
> -		lapic_timer_reliable_states = LAPIC_TIMER_ALWAYS_RELIABLE;
> -	else
> -		on_each_cpu(__setup_broadcast_timer, (void *)true, 1);
> -
>  	pr_debug(PREFIX "v" INTEL_IDLE_VERSION
>  		" model 0x%X\n", boot_cpu_data.x86_model);
>  
> -	pr_debug(PREFIX "lapic_timer_reliable_states 0x%x\n",
> -		lapic_timer_reliable_states);
>  	return 0;
>  }
>  
> @@ -594,6 +561,10 @@ static int intel_idle_cpuidle_driver_init(void)
>  			mark_tsc_unstable("TSC halts in idle"
>  					" states deeper than C2");
>  
> +		if (cstate > 1 && !boot_cpu_has(X86_FEATURE_ARAT))
> +			cpuidle_state_table[cstate].flags |=
> +				CPUIDLE_FLAG_TIMER_STOP;
> +
>  		drv->states[drv->state_count] =	/* structure copy */
>  			cpuidle_state_table[cstate];
>  
> @@ -705,10 +676,6 @@ static void __exit intel_idle_exit(void)
>  {
>  	intel_idle_cpuidle_devices_uninit();
>  	cpuidle_unregister_driver(&intel_idle_driver);
> -
> -
> -	if (lapic_timer_reliable_states != LAPIC_TIMER_ALWAYS_RELIABLE)
> -		on_each_cpu(__setup_broadcast_timer, (void *)false, 1);
>  	unregister_cpu_notifier(&cpu_hotplug_notifier);
>  
>  	return;
> 
-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
