From: Vincent Guittot <vincent.guittot@linaro.org>
Subject: Re: [PATCH] sched/fair: schedutil: update only with all info available
Date: Wed, 11 Apr 2018 09:57:28 +0200
Message-ID: <CAKfTPtB+6LoduwinNxEyTq2TFsOv8jEjnQ3o0M=Sf5viB+PL0w@mail.gmail.com>
References: <20180406172835.20078-1-patrick.bellasi@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180406172835.20078-1-patrick.bellasi@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Patrick Bellasi <patrick.bellasi@arm.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, "open list:THERMAL" <linux-pm@vger.kernel.org>, Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, Viresh Kumar <viresh.kumar@linaro.org>, Juri Lelli <juri.lelli@redhat.com>, Joel Fernandes <joelaf@google.com>, Steve Muckle <smuckle@google.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>, Morten Rasmussen <morten.rasmussen@arm.com>
List-Id: linux-pm@vger.kernel.org

On 6 April 2018 at 19:28, Patrick Bellasi <patrick.bellasi@arm.com> wrote:

>  }
> @@ -5454,8 +5441,11 @@ static void dequeue_task_fair(struct rq *rq, struct task_struct *p, int flags)
>                 update_cfs_group(se);
>         }
>
> -       if (!se)
> +       /* The task is no more visible from the root cfs_rq */
> +       if (!se) {
>                 sub_nr_running(rq, 1);
> +               cpufreq_update_util(rq, 0);

call to cpufreq_update_util() should be done after util_est_dequeue()

> +       }
>
>         util_est_dequeue(&rq->cfs, p, task_sleep);
>         hrtick_update(rq);
