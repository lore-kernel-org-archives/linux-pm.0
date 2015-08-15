From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [RFCv5 PATCH 38/46] sched: scheduler-driven cpu frequency
 selection
Date: Sat, 15 Aug 2015 15:05:45 +0200
Message-ID: <20150815130545.GI10304@worktop.programming.kicks-ass.net>
References: <1436293469-25707-1-git-send-email-morten.rasmussen@arm.com>
 <1436293469-25707-39-git-send-email-morten.rasmussen@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.9]:48985 "EHLO
	bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752442AbbHOTv0 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sat, 15 Aug 2015 15:51:26 -0400
Content-Disposition: inline
In-Reply-To: <1436293469-25707-39-git-send-email-morten.rasmussen@arm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Morten Rasmussen <morten.rasmussen@arm.com>
Cc: mingo@redhat.com, vincent.guittot@linaro.org, daniel.lezcano@linaro.org, Dietmar Eggemann <Dietmar.Eggemann@arm.com>, yuyang.du@intel.com, mturquette@baylibre.com, rjw@rjwysocki.net, Juri Lelli <Juri.Lelli@arm.com>, sgurrappadi@nvidia.com, pang.xunlei@zte.com.cn, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org

On Tue, Jul 07, 2015 at 07:24:21PM +0100, Morten Rasmussen wrote:
> +void cpufreq_sched_set_cap(int cpu, unsigned long capacity)
> +{
> +	unsigned int freq_new, cpu_tmp;
> +	struct cpufreq_policy *policy;
> +	struct gov_data *gd;
> +	unsigned long capacity_max = 0;
> +
> +	/* update per-cpu capacity request */
> +	__this_cpu_write(pcpu_capacity, capacity);
> +
> +	policy = cpufreq_cpu_get(cpu);
> +	if (IS_ERR_OR_NULL(policy)) {
> +		return;
> +	}
> +
> +	if (!policy->governor_data)
> +		goto out;
> +
> +	gd = policy->governor_data;
> +
> +	/* bail early if we are throttled */
> +	if (ktime_before(ktime_get(), gd->throttle))
> +		goto out;

Isn't this the wrong place to throttle? Suppose you're getting multiple
new tasks placed on this CPU, the first one would trigger this callback
and start increasing freq..

While we're still changing freq. (and therefore throttled), another task
comes in which would again raise the freq.

With this scheme you loose the latter freq. change and will not
re-evaluate.

Any scheme that limits the callbacks to the actual hardware will have to
buffer requests and once the hardware returns (be it through an
interrupt or timeout) issue the latest request.

