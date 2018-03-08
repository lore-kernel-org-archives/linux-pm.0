From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v5 4/4] sched/fair: update util_est only on util_avg
 updates
Date: Thu, 8 Mar 2018 10:48:31 +0100
Message-ID: <20180308094830.GK25201@hirez.programming.kicks-ass.net>
References: <20180222170153.673-1-patrick.bellasi@arm.com>
 <20180222170153.673-5-patrick.bellasi@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180222170153.673-5-patrick.bellasi@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Patrick Bellasi <patrick.bellasi@arm.com>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Ingo Molnar <mingo@redhat.com>, "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, Viresh Kumar <viresh.kumar@linaro.org>, Vincent Guittot <vincent.guittot@linaro.org>, Paul Turner <pjt@google.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>, Morten Rasmussen <morten.rasmussen@arm.com>, Juri Lelli <juri.lelli@redhat.com>, Todd Kjos <tkjos@android.com>, Joel Fernandes <joelaf@google.com>, Steve Muckle <smuckle@google.com>
List-Id: linux-pm@vger.kernel.org

On Thu, Feb 22, 2018 at 05:01:53PM +0000, Patrick Bellasi wrote:
> +#define UTIL_EST_NEED_UPDATE_FLAG 0x1

> @@ -5321,12 +5345,19 @@ static inline void util_est_dequeue(struct cfs_rq *cfs_rq,
>  	if (!task_sleep)
>  		return;
>  
> +	/*
> +	 * Skip update of task's estimated utilization if the PELT signal has
> +	 * never been updated (at least once) since last enqueue time.
> +	 */
> +	ue = READ_ONCE(p->se.avg.util_est);
> +	if (ue.enqueued & UTIL_EST_NEED_UPDATE_FLAG)
> +		return;

The name and function seem inverted, if the flag is set, we do _NOT_
update util_est.

How about something like UTIL_EST_UNCHANGED ? That would give:

	/*
	 * If the PELT values haven't changed since enqueue time,
	 * skip the util_est update.
	 */
	if (enqueue & UTIL_EST_UNCHANGED)
		return;
