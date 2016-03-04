From: Steve Muckle <steve.muckle@linaro.org>
Subject: Re: [PATCH v3 9/10] cpufreq: sched: Re-introduce
 cpufreq_update_util()
Date: Fri, 4 Mar 2016 13:21:42 -0800
Message-ID: <56D9FC66.9050201@linaro.org>
References: <2495375.dFbdlAZmA6@vostro.rjw.lan>
 <2409306.qzzMXcm4dm@vostro.rjw.lan> <3276406.TfbasUEj6b@vostro.rjw.lan>
 <2165535.KMoOuEkF5Y@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <2165535.KMoOuEkF5Y@vostro.rjw.lan>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux PM list <linux-pm@vger.kernel.org>
Cc: Juri Lelli <juri.lelli@arm.com>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Viresh Kumar <viresh.kumar@linaro.org>, Vincent Guittot <vincent.guittot@linaro.org>, Michael Turquette <mturquette@baylibre.com>, Ingo Molnar <mingo@kernel.org>
List-Id: linux-pm@vger.kernel.org

On 03/04/2016 05:30 AM, Rafael J. Wysocki wrote:
> +void cpufreq_update_util(u64 time, unsigned long util, unsigned long max)
> +{
> +	struct freq_update_hook *hook;
> +
> +#ifdef CONFIG_LOCKDEP
> +	WARN_ON(debug_locks && !rcu_read_lock_sched_held());
> +#endif
> +
> +	hook = rcu_dereference_sched(*this_cpu_ptr(&cpufreq_freq_update_hook));
> +	/*
> +	 * If this isn't inside of an RCU-sched read-side critical section, hook
> +	 * may become NULL after the check below.
> +	 */
> +	if (hook) {
> +		if (hook->update_util)
> +			hook->update_util(hook, time, util, max);
> +		else
> +			hook->func(hook, time);
> +	}

Is it worth having two hook types?
