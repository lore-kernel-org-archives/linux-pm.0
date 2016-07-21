From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH v3 1/3] cpufreq: add cpufreq_driver_resolve_freq()
Date: Thu, 21 Jul 2016 14:13:44 -0700
Message-ID: <20160721211344.GJ3122@ubuntu>
References: <1468441527-23534-1-git-send-email-smuckle@linaro.org>
 <1468441527-23534-2-git-send-email-smuckle@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1468441527-23534-2-git-send-email-smuckle@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Steve Muckle <steve.muckle@linaro.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>, Morten Rasmussen <morten.rasmussen@arm.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>, Juri Lelli <Juri.Lelli@arm.com>, Patrick Bellasi <patrick.bellasi@arm.com>, Steve Muckle <smuckle@linaro.org>
List-Id: linux-pm@vger.kernel.org

On 13-07-16, 13:25, Steve Muckle wrote:
> +unsigned int cpufreq_driver_resolve_freq(struct cpufreq_policy *policy,
> +					 unsigned int target_freq)
> +{
> +	target_freq = clamp_val(target_freq, policy->min, policy->max);
> +	policy->cached_target_freq = target_freq;
> +	if (cpufreq_driver->resolve_freq)
> +		return cpufreq_driver->resolve_freq(policy, target_freq);
> +	policy->cached_resolved_idx =
> +		cpufreq_frequency_table_target(policy, target_freq,
> +					       CPUFREQ_RELATION_L);
> +	return policy->freq_table[policy->cached_resolved_idx].frequency;

FWIW, this may crash the kernel for a driver that provides ->target()
but no ->resolve_freq().

-- 
viresh
