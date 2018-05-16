From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [RFC/RFT] [PATCH 08/10] cpufreq: intel_pstate: Dyanmically
 update busy pct
Date: Wed, 16 May 2018 09:43:04 +0200
Message-ID: <20180516074304.GX12217@hirez.programming.kicks-ass.net>
References: <20180516044911.28797-1-srinivas.pandruvada@linux.intel.com>
 <20180516044911.28797-9-srinivas.pandruvada@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180516044911.28797-9-srinivas.pandruvada@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: tglx@linutronix.de, mingo@redhat.com, bp@suse.de, lenb@kernel.org, rjw@rjwysocki.net, mgorman@techsingularity.net, x86@kernel.org, linux-pm@vger.kernel.org, viresh.kumar@linaro.org, juri.lelli@arm.com, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Tue, May 15, 2018 at 09:49:09PM -0700, Srinivas Pandruvada wrote:
> +static inline void intel_pstate_update_busy_threshold(struct cpudata *cpu)
> +{
> +	/* P1 percent out of total range of P-states */
> +	if (cpu->pstate.max_freq != cpu->pstate.turbo_freq) {
> +		hwp_boost_pstate_threshold =
> +			cpu->pstate.max_freq * SCHED_CAPACITY_SCALE / cpu->pstate.turbo_freq;
> +		pr_debug("hwp_boost_pstate_threshold = %d\n",
> +			 hwp_boost_pstate_threshold);
> +	}
> +
> +}
> +
>  static inline void intel_pstate_update_util_hwp(struct update_util_data *data,
>  						u64 time, unsigned int flags)
>  {
> @@ -2061,8 +2097,10 @@ static int __intel_pstate_cpu_init(struct cpufreq_policy *policy)
>  
>  	policy->fast_switch_possible = true;
>  
> -	if (hwp_active)
> +	if (hwp_active) {
>  		csd_init(cpu);
> +		intel_pstate_update_busy_threshold(cpu);
> +	}
>  
>  	return 0;
>  }

This should go in patch #5 and then you can remove that SKX hack. Which
you left in, even though you now did it right.
