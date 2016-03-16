From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v4 7/7] cpufreq: schedutil: New governor based on
 scheduler utilization data
Date: Wed, 16 Mar 2016 18:35:41 +0100
Message-ID: <20160316173541.GD6344@twins.programming.kicks-ass.net>
References: <1711281.bPmSjlBT7c@vostro.rjw.lan>
 <11678919.CQLTrQTYxG@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from casper.infradead.org ([85.118.1.10]:36782 "EHLO
	casper.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932322AbcCPRgL (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 16 Mar 2016 13:36:11 -0400
Content-Disposition: inline
In-Reply-To: <11678919.CQLTrQTYxG@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Linux PM list <linux-pm@vger.kernel.org>, Juri Lelli <juri.lelli@arm.com>, Steve Muckle <steve.muckle@linaro.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Viresh Kumar <viresh.kumar@linaro.org>, Vincent Guittot <vincent.guittot@linaro.org>, Michael Turquette <mturquette@baylibre.com>, Ingo Molnar <mingo@kernel.org>

On Wed, Mar 16, 2016 at 03:59:18PM +0100, Rafael J. Wysocki wrote:

> +static unsigned int get_next_freq(struct cpufreq_policy *policy,
> +				  unsigned long util, unsigned long max)
> +{
> +	unsigned int freq = arch_scale_freq_invariant() ?
> +				policy->cpuinfo.max_freq : policy->cur;
> +
> +	return (freq + (freq >> 2)) * util / max;
> +}
> +
> +static void sugov_update_single(struct update_util_data *hook, u64 time,
> +				unsigned long util, unsigned long max)
> +{
> +	struct sugov_cpu *sg_cpu = container_of(hook, struct sugov_cpu, update_util);
> +	struct sugov_policy *sg_policy = sg_cpu->sg_policy;
> +	struct cpufreq_policy *policy = sg_policy->policy;
> +	unsigned int next_f;
> +
> +	if (!sugov_should_update_freq(sg_policy, time))
> +		return;
> +
> +	next_f = util <= max ?
> +		get_next_freq(policy, util, max) : policy->cpuinfo.max_freq;

I'm not sure that is correct, would not something like this be more
accurate?

	if (util > max)
		util = max;
	next_f = get_next_freq(policy, util, max);

After all, if we clip util we will still only increment to the next freq
with our multiplication factor.

Hmm, or was this meant to deal with the DL/RT stuff?

Would then not something like:

	/* ULONG_MAX is used to force max_freq for Real-Time policies */
	if (util == ULONG_MAX) {
		next_f = policy->cpuinfo.max_freq;
	} else {
		if (util > max)
			util = max;
		next_f = get_next_freq(policy, util, max);
	}

Be clearer?

> +	sugov_update_commit(sg_policy, time, next_f);
> +}
