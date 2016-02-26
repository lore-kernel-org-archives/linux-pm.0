From: Stephen Boyd <sboyd@codeaurora.org>
Subject: Re: [RFC v2 07/12] PM / cpu_domains: Add PM Domain governor for CPUs
Date: Fri, 26 Feb 2016 11:33:38 -0800
Message-ID: <20160226193338.GY28849@codeaurora.org>
References: <1455310238-8963-1-git-send-email-lina.iyer@linaro.org>
 <1455310238-8963-8-git-send-email-lina.iyer@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:57374 "EHLO
	smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753495AbcBZTdk (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 26 Feb 2016 14:33:40 -0500
Content-Disposition: inline
In-Reply-To: <1455310238-8963-8-git-send-email-lina.iyer@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Lina Iyer <lina.iyer@linaro.org>
Cc: ulf.hansson@linaro.org, khilman@kernel.org, rjw@rjwysocki.net, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, geert@linux-m68k.org, k.kozlowski@samsung.com, msivasub@codeaurora.org, agross@codeaurora.org, linux-arm-msm@vger.kernel.org, lorenzo.pieralisi@arm.com, ahaslam@baylibre.com, mtitinger@baylibre.com

On 02/12, Lina Iyer wrote:
> @@ -52,6 +55,76 @@ struct cpu_pm_domain *to_cpu_pd(struct generic_pm_domain *d)
>  	return res;
>  }
>  
> +static bool cpu_pd_down_ok(struct dev_pm_domain *pd)
> +{
> +	struct generic_pm_domain *genpd = pd_to_genpd(pd);
> +	struct cpu_pm_domain *cpu_pd = to_cpu_pd(genpd);
> +	int qos = pm_qos_request(PM_QOS_CPU_DMA_LATENCY);
> +	u64 sleep_ns;
> +	ktime_t earliest, next_wakeup;
> +	int cpu;
> +	int i;
> +
> +	/* Reset the last set genpd state, default to index 0 */
> +	genpd->state_idx = 0;
> +
> +	/* We dont want to power down, if QoS is 0 */
> +	if (!qos)
> +		return false;
> +
> +	/*
> +	 * Find the sleep time for the cluster.
> +	 * The time between now and the first wake up of any CPU that
> +	 * are in this domain hierarchy is the time available for the
> +	 * domain to be idle.
> +	 */
> +	earliest = ktime_set(KTIME_SEC_MAX, 0);
> +	for_each_cpu_and(cpu, cpu_pd->cpus, cpu_online_mask) {

We're not worried about hotplug happening in parallel because
preemption is disabled here?

> +		next_wakeup = tick_nohz_get_next_wakeup(cpu);
> +		if (earliest.tv64 > next_wakeup.tv64)

	if (ktime_before(next_wakeup, earliest))

> +			earliest = next_wakeup;
> +	}
> +
> +	sleep_ns = ktime_to_ns(ktime_sub(earliest, ktime_get()));
> +	if (sleep_ns <= 0)
> +		return false;
> +
> +	/*
> +	 * Find the deepest sleep state that satisfies the residency
> +	 * requirement and the QoS constraint
> +	 */
> +	for (i = genpd->state_count - 1; i >= 0; i--) {
> +		u64 state_sleep_ns;
> +
> +		state_sleep_ns = genpd->states[i].power_off_latency_ns +
> +			genpd->states[i].power_on_latency_ns +
> +			genpd->states[i].residency_ns;
> +
> +		/*
> +		 * If we cant sleep to save power in the state, move on

s/cant/can't/

> +		 * to the next lower idle state.
> +		 */
> +		if (state_sleep_ns > sleep_ns)
> +			continue;
> +
> +		/*
> +		 * We also dont want to sleep more than we should to

s/dont/don't/

> +		 * gaurantee QoS.
> +		 */
> +		if (state_sleep_ns < (qos * NSEC_PER_USEC))

Maybe we should make qos into qos_ns? Presumably the compiler
would hoist out the multiplication here, but it doesn't hurt to
do it explicitly.

> +			break;
> +	}
> +
> +	if (i >= 0)
> +		genpd->state_idx = i;
> +
> +	return  (i >= 0) ? true : false;

Just return i >= 0?

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
