From: Dietmar Eggemann <dietmar.eggemann@arm.com>
Subject: Re: [PATCH v3 04/14] sched/core: uclamp: update CPU's refcount on
 clamp changes
Date: Wed, 15 Aug 2018 17:02:42 +0200
Message-ID: <4023267d-be06-c599-136e-1f70bf376d5d@arm.com>
References: <20180806163946.28380-1-patrick.bellasi@arm.com>
 <20180806163946.28380-5-patrick.bellasi@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180806163946.28380-5-patrick.bellasi@arm.com>
Content-Language: en-GB
Sender: linux-kernel-owner@vger.kernel.org
To: Patrick Bellasi <patrick.bellasi@arm.com>, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Cc: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, Tejun Heo <tj@kernel.org>, "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, Viresh Kumar <viresh.kumar@linaro.org>, Vincent Guittot <vincent.guittot@linaro.org>, Paul Turner <pjt@google.com>, Morten Rasmussen <morten.rasmussen@arm.com>, Juri Lelli <juri.lelli@redhat.com>, Todd Kjos <tkjos@google.com>, Joel Fernandes <joelaf@google.com>, Steve Muckle <smuckle@google.com>, Suren Baghdasaryan <surenb@google.com>
List-Id: linux-pm@vger.kernel.org

On 08/06/2018 06:39 PM, Patrick Bellasi wrote:

[...]

> +/**
> + * uclamp_task_active: check if a task is currently clamping a CPU
> + * @p: the task to check
> + *
> + * A task actively affects the utilization clamp of a CPU if:
> + * - it's currently enqueued or running on that CPU
> + * - it's refcounted in at least one clamp group of that CPU
> + *
> + * Return: true if p is currently clamping the utilization of its CPU.
> + */
> +static inline bool uclamp_task_active(struct task_struct *p)
> +{
> +	struct rq *rq = task_rq(p);
> +	int clamp_id;
> +
> +	lockdep_assert_held(&p->pi_lock);
> +	lockdep_assert_held(&rq->lock);
> +
> +	if (!task_on_rq_queued(p) && !p->on_cpu)
> +		return false;
> +
> +	for (clamp_id = 0; clamp_id < UCLAMP_CNT; ++clamp_id) {
> +		if (uclamp_task_affects(p, clamp_id))
> +			return true;
> +	}
> +
> +	return false;
> +}

Looks like that uclamp_task_active() is only used once (in 
uclamp_task_update_active()). Can you not code the if condition and the 
for loop directly in uclamp_task_update_active()? This would save code 
(lockdep_assert_held() etc.) and comment lines.

[...]
