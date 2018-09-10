From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH v6 02/14] sched/cpufreq: Factor out utilization to frequency mapping
Date: Mon, 10 Sep 2018 11:29:27 +0200
Message-ID: <1631407.Oe3rajKQQm@aspire.rjw.lan>
References: <20180820094420.26590-1-quentin.perret@arm.com> <20180820094420.26590-3-quentin.perret@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180820094420.26590-3-quentin.perret@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Quentin Perret <quentin.perret@arm.com>
Cc: peterz@infradead.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, gregkh@linuxfoundation.org, mingo@redhat.com, dietmar.eggemann@arm.com, morten.rasmussen@arm.com, chris.redpath@arm.com, patrick.bellasi@arm.com, valentin.schneider@arm.com, vincent.guittot@linaro.org, thara.gopinath@linaro.org, viresh.kumar@linaro.org, tkjos@google.com, joel@joelfernandes.org, smuckle@google.com, adharmap@codeaurora.org, skannan@codeaurora.org, pkondeti@codeaurora.org, juri.lelli@redhat.com, edubezval@gmail.com, srinivas.pandruvada@linux.intel.com, currojerez@riseup.net, javi.merino@kernel.org
List-Id: linux-pm@vger.kernel.org

On Monday, August 20, 2018 11:44:08 AM CEST Quentin Perret wrote:
> The schedutil governor maps utilization values to frequencies by applying
> a 25% margin. Since this sort of mapping mechanism can be needed by other
> users (i.e. EAS), factor the utilization-to-frequency mapping code out
> of schedutil and move it to include/linux/sched/cpufreq.h to avoid code
> duplication. The new map_util_freq() function is inlined to avoid
> overheads.

There really is more to this change than it seems at the face value IMO,
because the formula in question represents the policy part of the governor.

Namely, it is roughly equivalent to the assumption that the governor will
attempt to "stabilize" the "busy" time of the CPU at 80% of its total time
(if possible for the given "raw" utilization and performance limits).
If you take that formula into EAS, it will cause EAS to implicitly require
the cpufreq governor to follow this assumption.

Now, I know that you want to let EAS only work with the schedutil governor,
which is consistent with the above, but the implicit assumption here should
at least be documented somehow IMO.

> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Signed-off-by: Quentin Perret <quentin.perret@arm.com>
> ---
>  include/linux/sched/cpufreq.h    | 6 ++++++
>  kernel/sched/cpufreq_schedutil.c | 3 ++-
>  2 files changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/include/linux/sched/cpufreq.h b/include/linux/sched/cpufreq.h
> index 59667444669f..afa940cd50dc 100644
> --- a/include/linux/sched/cpufreq.h
> +++ b/include/linux/sched/cpufreq.h
> @@ -20,6 +20,12 @@ void cpufreq_add_update_util_hook(int cpu, struct update_util_data *data,
>                         void (*func)(struct update_util_data *data, u64 time,
>  				    unsigned int flags));
>  void cpufreq_remove_update_util_hook(int cpu);
> +
> +static inline unsigned long map_util_freq(unsigned long util,
> +					unsigned long freq, unsigned long cap)
> +{
> +	return (freq + (freq >> 2)) * util / cap;
> +}
>  #endif /* CONFIG_CPU_FREQ */
>  
>  #endif /* _LINUX_SCHED_CPUFREQ_H */
> diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_schedutil.c
> index 3fffad3bc8a8..f5206c950143 100644
> --- a/kernel/sched/cpufreq_schedutil.c
> +++ b/kernel/sched/cpufreq_schedutil.c
> @@ -13,6 +13,7 @@
>  
>  #include "sched.h"
>  
> +#include <linux/sched/cpufreq.h>
>  #include <trace/events/power.h>
>  
>  struct sugov_tunables {
> @@ -167,7 +168,7 @@ static unsigned int get_next_freq(struct sugov_policy *sg_policy,
>  	unsigned int freq = arch_scale_freq_invariant() ?
>  				policy->cpuinfo.max_freq : policy->cur;
>  
> -	freq = (freq + (freq >> 2)) * util / max;
> +	freq = map_util_freq(util, freq, max);
>  
>  	if (freq == sg_policy->cached_raw_freq && !sg_policy->need_freq_update)
>  		return sg_policy->next_freq;
> 
