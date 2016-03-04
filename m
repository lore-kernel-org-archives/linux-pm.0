From: Juri Lelli <juri.lelli@arm.com>
Subject: Re: [PATCH v2 9/10] cpufreq: sched: Re-introduce
 cpufreq_update_util()
Date: Fri, 4 Mar 2016 10:50:07 +0000
Message-ID: <20160304105007.GB4061@e106622-lin>
References: <2495375.dFbdlAZmA6@vostro.rjw.lan>
 <2409306.qzzMXcm4dm@vostro.rjw.lan>
 <3276406.TfbasUEj6b@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <3276406.TfbasUEj6b@vostro.rjw.lan>
Sender: linux-acpi-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Linux PM list <linux-pm@vger.kernel.org>, Steve Muckle <steve.muckle@linaro.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Viresh Kumar <viresh.kumar@linaro.org>, Vincent Guittot <vincent.guittot@linaro.org>, Michael Turquette <mturquette@baylibre.com>, Ingo Molnar <mingo@kernel.org>
List-Id: linux-pm@vger.kernel.org

Hi Rafael,

On 04/03/16 04:18, Rafael J. Wysocki wrote:

[...]

> +/**
> + * cpufreq_update_util - Take a note about CPU utilization changes.
> + * @time: Current time.
> + * @util: CPU utilization.
> + * @max: CPU capacity.
> + *
> + * This function is called on every invocation of update_load_avg() on the CPU
> + * whose utilization is being updated.
> + *
> + * It can only be called from RCU-sched read-side critical sections.
> + */
> +void cpufreq_update_util(u64 time, unsigned long util, unsigned long max)
> +{
> +	struct freq_update_hook *hook;
> +
> +#ifdef CONFIG_LOCKDEP
> +	WARN_ON(debug_locks && !rcu_read_lock_sched_held());
> +#endif
> +
> +	hook = rcu_dereference(*this_cpu_ptr(&cpufreq_freq_update_hook));

Small fix. You forgot to change this to rcu_dereference_sched() (you
only fixed that in 01/10).

Best,

- Juri
