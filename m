From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v4 03/16] sched/core: uclamp: add CPU's clamp groups
 accounting
Date: Wed, 12 Sep 2018 19:34:21 +0200
Message-ID: <20180912173421.GX24082@hirez.programming.kicks-ass.net>
References: <20180828135324.21976-1-patrick.bellasi@arm.com>
 <20180828135324.21976-4-patrick.bellasi@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180828135324.21976-4-patrick.bellasi@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Patrick Bellasi <patrick.bellasi@arm.com>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Ingo Molnar <mingo@redhat.com>, Tejun Heo <tj@kernel.org>, "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, Viresh Kumar <viresh.kumar@linaro.org>, Vincent Guittot <vincent.guittot@linaro.org>, Paul Turner <pjt@google.com>, Quentin Perret <quentin.perret@arm.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>, Morten Rasmussen <morten.rasmussen@arm.com>, Juri Lelli <juri.lelli@redhat.com>, Todd Kjos <tkjos@google.com>, Joel Fernandes <joelaf@google.com>, Steve Muckle <smuckle@google.com>, Suren Baghdasaryan <surenb@google.com>
List-Id: linux-pm@vger.kernel.org

On Tue, Aug 28, 2018 at 02:53:11PM +0100, Patrick Bellasi wrote:
> diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
> index 72df2dc779bc..513608ae4908 100644
> --- a/kernel/sched/sched.h
> +++ b/kernel/sched/sched.h
> @@ -764,6 +764,50 @@ extern void rto_push_irq_work_func(struct irq_work *work);
>  #endif
>  #endif /* CONFIG_SMP */
>  
> +#ifdef CONFIG_UCLAMP_TASK
> +/**
> + * struct uclamp_group - Utilization clamp Group
> + * @value: utilization clamp value for tasks on this clamp group
> + * @tasks: number of RUNNABLE tasks on this clamp group
> + *
> + * Keep track of how many tasks are RUNNABLE for a given utilization
> + * clamp value.
> + */
> +struct uclamp_group {
> +	int value;
> +	int tasks;
> +};

We could use bit fields again to compress in 10:22 bits I suppose. 4M
tasks is quite a lot to have runnable on a single CPU ;-)
