From: Juri Lelli <juri.lelli@redhat.com>
Subject: Re: [PATCH v4 02/16] sched/core: uclamp: map TASK's clamp values
 into CPU's clamp groups
Date: Wed, 5 Sep 2018 12:45:45 +0200
Message-ID: <20180905104545.GB20267@localhost.localdomain>
References: <20180828135324.21976-1-patrick.bellasi@arm.com>
 <20180828135324.21976-3-patrick.bellasi@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180828135324.21976-3-patrick.bellasi@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Patrick Bellasi <patrick.bellasi@arm.com>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, Tejun Heo <tj@kernel.org>, "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, Viresh Kumar <viresh.kumar@linaro.org>, Vincent Guittot <vincent.guittot@linaro.org>, Paul Turner <pjt@google.com>, Quentin Perret <quentin.perret@arm.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>, Morten Rasmussen <morten.rasmussen@arm.com>, Todd Kjos <tkjos@google.com>, Joel Fernandes <joelaf@google.com>, Steve Muckle <smuckle@google.com>, Suren Baghdasaryan <surenb@google.com>
List-Id: linux-pm@vger.kernel.org

Hi,

On 28/08/18 14:53, Patrick Bellasi wrote:

[...]

>  static inline int __setscheduler_uclamp(struct task_struct *p,
>  					const struct sched_attr *attr)
>  {
> -	if (attr->sched_util_min > attr->sched_util_max)
> -		return -EINVAL;
> -	if (attr->sched_util_max > SCHED_CAPACITY_SCALE)
> -		return -EINVAL;
> +	int group_id[UCLAMP_CNT] = { UCLAMP_NOT_VALID };
> +	int lower_bound, upper_bound;
> +	struct uclamp_se *uc_se;
> +	int result = 0;
>  
> -	p->uclamp[UCLAMP_MIN] = attr->sched_util_min;
> -	p->uclamp[UCLAMP_MAX] = attr->sched_util_max;
> +	mutex_lock(&uclamp_mutex);

This is going to get called from an rcu_read_lock() section, which is a
no-go for using mutexes:

 sys_sched_setattr ->
   rcu_read_lock()
   ...
   sched_setattr() ->
     __sched_setscheduler() ->
       ...
       __setscheduler_uclamp() ->
         ...
	 mutex_lock()

Guess you could fix the issue by getting the task struct after find_
process_by_pid() in sys_sched_attr() and then calling sched_setattr()
after rcu_read_lock() (putting the task struct at the end). Peter
actually suggested this mod to solve a different issue.

Best,

- Juri
