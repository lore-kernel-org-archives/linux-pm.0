From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [RFC/RFT] [PATCH 08/10] cpufreq: intel_pstate: Dyanmically
 update busy pct
Date: Wed, 16 May 2018 09:47:34 +0200
Message-ID: <20180516074734.GY12217@hirez.programming.kicks-ass.net>
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
> +	if (!hwp_boost_threshold_busy_pct) {
> +		int min_freq, max_freq;
> +
> +		min_freq  = cpu->pstate.min_pstate * cpu->pstate.scaling;
> +		update_turbo_state();
> +		max_freq =  global.turbo_disabled || global.no_turbo ?
> +				cpu->pstate.max_freq : cpu->pstate.turbo_freq;
> +
> +		/*
> +		 * We are guranteed to get atleast min P-state.

		   If we assume
> +		 * P-state is proportional to load (such that 10% load
> +		 * increase will result in 10% P-state increase),

		   we will
> +		 * get at least min P-state till we have atleast
> +		 * (min * 100/max) percent cpu load.

turbo makes that story less clear ofcourse.

		   So any load less than
> +		 * than this this we shouldn't do any boost. Then boosting
> +		 * is not free, we will add atleast 20% offset.

This I don't get.. so you want to remain at min P longer?

> +		 */
> +		hwp_boost_threshold_busy_pct = min_freq * 100 / max_freq;
> +		hwp_boost_threshold_busy_pct += 20;
> +		pr_debug("hwp_boost_threshold_busy_pct = %d\n",
> +			 hwp_boost_threshold_busy_pct);
> +	}
> +}

And then this part should go in the previous patch.
