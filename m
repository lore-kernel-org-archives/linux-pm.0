From: Juri Lelli <juri.lelli@arm.com>
Subject: Re: [PATCH 0/3] cpufreq: Replace timers with utilization update
 callbacks
Date: Wed, 10 Feb 2016 12:33:42 +0000
Message-ID: <20160210123342.GA11415@e106622-lin>
References: <3071836.JbNxX8hU6x@vostro.rjw.lan>
 <56B93548.9090006@linaro.org>
 <CAJZ5v0gJwLVezLTLwGX=GDrsGeH6X040JmOaW6_uX2XzQwO9mg@mail.gmail.com>
 <5387313.xAhVpzgZCg@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:46765 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750817AbcBJMc5 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Wed, 10 Feb 2016 07:32:57 -0500
Content-Disposition: inline
In-Reply-To: <5387313.xAhVpzgZCg@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Steve Muckle <steve.muckle@linaro.org>, "Rafael J. Wysocki" <rafael@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Linux PM list <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Viresh Kumar <viresh.kumar@linaro.org>, Thomas Gleixner <tglx@linutronix.de>

Hi Rafael,

On 09/02/16 21:05, Rafael J. Wysocki wrote:

[...]

> +/**
> + * cpufreq_update_util - Take a note about CPU utilization changes.
> + * @util: Current utilization.
> + * @max: Utilization ceiling.
> + *
> + * This function is called by the scheduler on every invocation of
> + * update_load_avg() on the CPU whose utilization is being updated.
> + */
> +void cpufreq_update_util(unsigned long util, unsigned long max)
> +{
> +	struct update_util_data *data;
> +
> +	rcu_read_lock();
> +
> +	data = rcu_dereference(*this_cpu_ptr(&cpufreq_update_util_data));
> +	if (data && data->func)
> +		data->func(data, cpu_clock(smp_processor_id()), util, max);

Are util and max used anywhere? It seems to me that cpu_clock is used by
the callbacks to check if the sampling period is elapsed, but I couldn't
yet find who is using util and max.

Thanks,

- Juri
