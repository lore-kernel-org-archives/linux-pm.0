From: Patrick Bellasi <patrick.bellasi@arm.com>
Subject: Re: [PATCH v5 09/15] sched/cpufreq: uclamp: add utilization clamping
 for FAIR tasks
Date: Wed, 7 Nov 2018 11:38:49 +0000
Message-ID: <20181107113849.GC14309@e110439-lin>
References: <20181029183311.29175-1-patrick.bellasi@arm.com>
 <20181029183311.29175-11-patrick.bellasi@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20181029183311.29175-11-patrick.bellasi@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Cc: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, Tejun Heo <tj@kernel.org>, "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, Vincent Guittot <vincent.guittot@linaro.org>, Viresh Kumar <viresh.kumar@linaro.org>, Paul Turner <pjt@google.com>, Quentin Perret <quentin.perret@arm.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>, Morten Rasmussen <morten.rasmussen@arm.com>, Juri Lelli <juri.lelli@redhat.com>, Todd Kjos <tkjos@google.com>, Joel Fernandes <joelaf@google.com>, Steve Muckle <smuckle@google.com>, Suren Baghdasaryan <surenb@google.com>
List-Id: linux-pm@vger.kernel.org

On 29-Oct 18:33, Patrick Bellasi wrote:

[...]

> +#ifdef CONFIG_UCLAMP_TASK
> +/**
> + * clamp_util: clamp a utilization value for a specified CPU
> + * @rq: the CPU's RQ to get the clamp values from
> + * @util: the utilization signal to clamp
> + *
> + * Each CPU tracks util_{min,max} clamp values depending on the set of its
> + * currently RUNNABLE tasks. Given a utilization signal, i.e a signal in
> + * the [0..SCHED_CAPACITY_SCALE] range, this function returns a clamped
> + * utilization signal considering the current clamp values for the
> + * specified CPU.
> + *
> + * Return: a clamped utilization signal for a given CPU.
> + */
> +static inline unsigned int uclamp_util(struct rq *rq, unsigned int util)
> +{
> +	unsigned int min_util = rq->uclamp.value[UCLAMP_MIN];
> +	unsigned int max_util = rq->uclamp.value[UCLAMP_MAX];

Just notice here we can have an issue.

For each scheduling entity, we always ensure that:

    util_min <= util_max

However, since CPU's {min,max}_util clamps are always MAX aggregated
considering the corresponding clamps of RUNNABLE tasks with
_different_ clamps, we can end up with CPU clamps where:

    util_min > util_max

Thus, we need to add the following sanity check here:

+       if (unlikely(min_util > max_util))
+               return min_util;

> +
> +	return clamp(util, min_util, max_util);
> +}

-- 
#include <best/regards.h>

Patrick Bellasi
