From: Sai Gurrappadi <sgurrappadi@nvidia.com>
Subject: Re: [RFC][PATCH v3 2/2] cpufreq: schedutil: Avoid reducing frequency
 of busy CPUs prematurely
Date: Thu, 23 Mar 2017 12:26:43 -0700
Message-ID: <58D42173.2080205@nvidia.com>
References: <4366682.tsferJN35u@aspire.rjw.lan> <2185243.flNrap3qq1@aspire.rjw.lan> <3300960.HE4b3sK4dn@aspire.rjw.lan> <2997922.DidfPadJuT@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <2997922.DidfPadJuT@aspire.rjw.lan>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux PM <linux-pm@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Viresh Kumar <viresh.kumar@linaro.org>, Juri Lelli <juri.lelli@arm.com>, Vincent Guittot <vincent.guittot@linaro.org>, Patrick Bellasi <patrick.bellasi@arm.com>, Joel Fernandes <joelaf@google.com>, Morten Rasmussen <morten.rasmussen@arm.com>, Ingo Molnar <mingo@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, Peter Boonstoppel <pboonstoppel@nvidia.com>
List-Id: linux-pm@vger.kernel.org

Hi Rafael,

On 03/21/2017 04:08 PM, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

<snip>

> 
> That has been attributed to CPU utilization metric updates on task
> migration that cause the total utilization value for the CPU to be
> reduced by the utilization of the migrated task.  If that happens,
> the schedutil governor may see a CPU utilization reduction and will
> attempt to reduce the CPU frequency accordingly right away.  That
> may be premature, though, for example if the system is generally
> busy and there are other runnable tasks waiting to be run on that
> CPU already.
> 
> This is unlikely to be an issue on systems where cpufreq policies are
> shared between multiple CPUs, because in those cases the policy
> utilization is computed as the maximum of the CPU utilization values
> over the whole policy and if that turns out to be low, reducing the
> frequency for the policy most likely is a good idea anyway.  On

I have observed this issue even in the shared policy case (one clock domain for many CPUs). On migrate, the actual load update is split into two updates:

1. Add to removed_load on src_cpu (cpu_util(src_cpu) not updated yet)
2. Do wakeup on dst_cpu, add load to dst_cpu

Now if src_cpu manages to do a PELT update before 2. happens, ex: say a small periodic task woke up on src_cpu, it'll end up subtracting the removed_load from its utilization and issue a frequency update before 2. happens.

This causes a premature dip in frequency which doesn't get corrected until the next util update that fires after rate_limit_us. The dst_cpu freq. update from step 2. above gets rate limited in this scenario.


> systems with one CPU per policy, however, it may affect performance
> adversely and even lead to increased energy consumption in some cases.
> 
> On those systems it may be addressed by taking another utilization
> metric into consideration, like whether or not the CPU whose
> frequency is about to be reduced has been idle recently, because if
> that's not the case, the CPU is likely to be busy in the near future
> and its frequency should not be reduced.
> 
> To that end, use the counter of idle calls in the timekeeping code.
> Namely, make the schedutil governor look at that counter for the
> current CPU every time before its frequency is about to be reduced.
> If the counter has not changed since the previous iteration of the
> governor computations for that CPU, the CPU has been busy for all
> that time and its frequency should not be decreased, so if the new
> frequency would be lower than the one set previously, the governor
> will skip the frequency update.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
>  include/linux/tick.h             |    1 +
>  kernel/sched/cpufreq_schedutil.c |   27 +++++++++++++++++++++++++++
>  kernel/time/tick-sched.c         |   12 ++++++++++++
>  3 files changed, 40 insertions(+)
> 
> Index: linux-pm/kernel/sched/cpufreq_schedutil.c
> ===================================================================
> --- linux-pm.orig/kernel/sched/cpufreq_schedutil.c
> +++ linux-pm/kernel/sched/cpufreq_schedutil.c
> @@ -61,6 +61,11 @@ struct sugov_cpu {
>  	unsigned long util;
>  	unsigned long max;
>  	unsigned int flags;
> +
> +	/* The field below is for single-CPU policies only. */
> +#ifdef CONFIG_NO_HZ_COMMON
> +	unsigned long saved_idle_calls;
> +#endif
>  };
>  
>  static DEFINE_PER_CPU(struct sugov_cpu, sugov_cpu);
> @@ -192,6 +197,19 @@ static void sugov_iowait_boost(struct su
>  	sg_cpu->iowait_boost >>= 1;
>  }
>  
> +#ifdef CONFIG_NO_HZ_COMMON
> +static bool sugov_cpu_is_busy(struct sugov_cpu *sg_cpu)
> +{
> +	unsigned long idle_calls = tick_nohz_get_idle_calls();
> +	bool ret = idle_calls == sg_cpu->saved_idle_calls;
> +
> +	sg_cpu->saved_idle_calls = idle_calls;
> +	return ret;
> +}

Hm, sorry I am a bit confused perhaps you could help me understand the problem/solution better :)

Say we have the this simple case of only a single periodic task running on one CPU, wouldn't the PELT update on wakeup cause a frequency update which updates the sg_cpu->saved_idle_calls value here? That would then cause the frequency update on idle entry to always skip dropping frequency right?

If I am reading this correctly, the PELT update on the dequeue for the periodic task (in the scenario above) happens _before_ the idle_calls++ which is in tick_nohz_idle_enter.

Thanks!
-Sai 
