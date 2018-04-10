From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v2] cpufreq/schedutil: Cleanup, document and fix iowait
 boost
Date: Tue, 10 Apr 2018 21:37:08 +0200
Message-ID: <20180410193708.GE4043@hirez.programming.kicks-ass.net>
References: <20180410155931.31973-1-patrick.bellasi@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180410155931.31973-1-patrick.bellasi@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Patrick Bellasi <patrick.bellasi@arm.com>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Ingo Molnar <mingo@redhat.com>, "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, Viresh Kumar <viresh.kumar@linaro.org>, Joel Fernandes <joelaf@google.com>, Steve Muckle <smuckle@google.com>, Juri Lelli <juri.lelli@redhat.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>
List-Id: linux-pm@vger.kernel.org

On Tue, Apr 10, 2018 at 04:59:31PM +0100, Patrick Bellasi wrote:
> The iowait boosting code has been recently updated to add a progressive
> boosting behavior which allows to be less aggressive in boosting tasks
> doing only sporadic IO operations, thus being more energy efficient for
> example on mobile platforms.
> 
> The current code is now however a bit convoluted. Some functionalities
> (e.g. iowait boost reset) are replicated in different paths and their
> documentation is slightly misaligned.

While your patch does seem to improve things, it still has duplicated
bits in. Eg. the TICK_NSEC clearing exists in both functions.

> - sugov_set_iowait_boost: is now in charge only to set/increase the IO
>      wait boost, every time a task wakes up from an IO wait.
> 
> - sugov_iowait_boost: is now in charge to reset/reduce the IO wait
>      boost, every time a sugov update is triggered, as well as
>      to (eventually) enforce the currently required IO boost value.

I'm not sold on those function names; feels like we can do better,
although I'm struggling to come up with anything sensible just now.


>  
>  		if (delta_ns > TICK_NSEC) {
> +			sg_cpu->iowait_boost = iowait
> +				? sg_cpu->sg_policy->policy->min : 0;
> +			sg_cpu->iowait_boost_pending = iowait;
> +			return;
>  		}

> +	if (delta_ns > TICK_NSEC) {
> +		sg_cpu->iowait_boost = 0;
> +		sg_cpu->iowait_boost_pending = false;
> +		return;
> +	}

Looks like something we can maybe put in a helper or something.
