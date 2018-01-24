From: Joel Fernandes <joelaf@google.com>
Subject: Re: [PATCH v3 1/3] sched/fair: add util_est on top of PELT
Date: Wed, 24 Jan 2018 08:40:07 -0800
Message-ID: <CAJWu+oo-XSB9CDg2ixZx5jWbVDX7FNk5tVbLo2WiSqR8O+fRRg@mail.gmail.com>
References: <20180123180847.4477-1-patrick.bellasi@arm.com> <20180123180847.4477-2-patrick.bellasi@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180123180847.4477-2-patrick.bellasi@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Patrick Bellasi <patrick.bellasi@arm.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>, Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, Viresh Kumar <viresh.kumar@linaro.org>, Vincent Guittot <vincent.guittot@linaro.org>, Paul Turner <pjt@google.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>, Morten Rasmussen <morten.rasmussen@arm.com>, Juri Lelli <juri.lelli@redhat.com>, Todd Kjos <tkjos@android.com>, Steve Muckle <smuckle@google.com>
List-Id: linux-pm@vger.kernel.org

On Tue, Jan 23, 2018 at 10:08 AM, Patrick Bellasi
<patrick.bellasi@arm.com> wrote:
> The util_avg signal computed by PELT is too variable for some use-cases.
> For example, a big task waking up after a long sleep period will have its
> utilization almost completely decayed. This introduces some latency before
> schedutil will be able to pick the best frequency to run a task.
[...]
> -static inline unsigned long task_util(struct task_struct *p);
>  static unsigned long cpu_util_wake(int cpu, struct task_struct *p);
>
>  static unsigned long capacity_spare_wake(int cpu, struct task_struct *p)
> @@ -6262,6 +6337,11 @@ static inline unsigned long task_util(struct task_struct *p)
>         return p->se.avg.util_avg;
>  }
>
> +static inline unsigned long task_util_est(struct task_struct *p)
> +{
> +       return max(p->se.avg.util_est.ewma, p->se.avg.util_est.last);
> +}
> +
>  /*
>   * cpu_util_wake: Compute cpu utilization with any contributions from
>   * the waking task p removed.
> diff --git a/kernel/sched/features.h b/kernel/sched/features.h
> index 9552fd5854bf..c459a4b61544 100644
> --- a/kernel/sched/features.h
> +++ b/kernel/sched/features.h
> @@ -85,3 +85,8 @@ SCHED_FEAT(ATTACH_AGE_LOAD, true)
>  SCHED_FEAT(WA_IDLE, true)
>  SCHED_FEAT(WA_WEIGHT, true)
>  SCHED_FEAT(WA_BIAS, true)
> +
> +/*
> + * UtilEstimation. Use estimated CPU utilization.
> + */
> +SCHED_FEAT(UTIL_EST, false)
> diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
> index 2e95505e23c6..0b4d9750a927 100644
> --- a/kernel/sched/sched.h
> +++ b/kernel/sched/sched.h
> @@ -470,6 +470,7 @@ struct cfs_rq {
>          * CFS load tracking
>          */
>         struct sched_avg avg;
> +       unsigned long util_est_runnable;

Since struct sched_avg would now have util_est, cfs_rq gets it too.
Then can we not try to reuse that struct and avoid having to expand
cfs_rq more than needed?

I went through previous conversations and couldn't find a reason, if I
missed something I appreciate if you can explain the rationale.

thanks,

- Joel
