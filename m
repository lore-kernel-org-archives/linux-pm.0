From: Quentin Perret <quentin.perret@arm.com>
Subject: Re: [PATCH v2 3/3] cpufreq: intel_pstate: Update max frequency on
 global turbo changes
Date: Tue, 5 Mar 2019 11:42:54 +0000
Message-ID: <20190305114252.wu55upnrzb5j2g7j@queper01-lin>
References: <1755407.S0oJirvq9V@aspire.rjw.lan>
 <258653930.nEdAsQ7rt7@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <258653930.nEdAsQ7rt7@aspire.rjw.lan>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Linux PM <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Chen Yu <yu.c.chen@intel.com>, Gabriele Mazzotta <gabriele.mzt@gmail.com>
List-Id: linux-pm@vger.kernel.org

On Tuesday 05 Mar 2019 at 11:42:06 (+0100), Rafael J. Wysocki wrote:
> +static void intel_pstate_update_max_freq(unsigned int cpu)
> +{
> +	struct cpufreq_policy *policy = cpufreq_cpu_acquire(cpu);
> +	struct cpufreq_policy new_policy;
> +	struct cpudata *cpudata;
> +
> +	if (!policy)
> +		return;
> +
> +	cpudata = all_cpu_data[cpu];
> +	policy->cpuinfo.max_freq = global.turbo_disabled_mf ?
> +			cpudata->pstate.max_freq : cpudata->pstate.turbo_freq;

I'm not too familiar with how the Intel turbo stuff so bear with me but
is this 'pstate.turbo_freq' constant ?

Why not just write it unconditionally into cpuinfo.max_freq ? It's not
guaranteed to always be reachable anyways no ? So maybe that's OK to always
report that one regardless of the boost availability ?

> +	memcpy(&new_policy, policy, sizeof(*policy));
> +	new_policy.max = min(policy->user_policy.max, policy->cpuinfo.max_freq);
> +	new_policy.min = min(policy->user_policy.min, new_policy.max);
> +
> +	cpufreq_set_policy(policy, &new_policy);
> +
> +	cpufreq_cpu_release(policy);
> +}

Thanks,
Quentin
