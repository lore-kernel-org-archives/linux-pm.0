From: Ricky Liang <jcliang@chromium.org>
Subject: Re: [RFCv6 PATCH 03/10] sched: scheduler-driven cpu frequency selection
Date: Tue, 2 Feb 2016 01:10:19 +0800
Message-ID: <CAAJzSMervH=-Z0__i_nC2ubUJAcb4J-YP1bWwo5-z4z9RyLcMg@mail.gmail.com>
References: <1449641971-20827-1-git-send-email-smuckle@linaro.org>
	<1449641971-20827-4-git-send-email-smuckle@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1449641971-20827-4-git-send-email-smuckle@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Steve Muckle <steve.muckle@linaro.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, open list <linux-kernel@vger.kernel.org>, linux-pm@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>, Morten Rasmussen <morten.rasmussen@arm.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>, Juri Lelli <Juri.Lelli@arm.com>, Patrick Bellasi <patrick.bellasi@arm.com>, Michael Turquette <mturquette@baylibre.com>
List-Id: linux-pm@vger.kernel.org

Hi Steve,

On Wed, Dec 9, 2015 at 2:19 PM, Steve Muckle <steve.muckle@linaro.org> wrote:

[snip...]

> +static int cpufreq_sched_policy_init(struct cpufreq_policy *policy)
> +{
> +       struct gov_data *gd;
> +       int cpu;
> +
> +       for_each_cpu(cpu, policy->cpus)
> +               memset(&per_cpu(cpu_sched_capacity_reqs, cpu), 0,
> +                      sizeof(struct sched_capacity_reqs));
> +
> +       gd = kzalloc(sizeof(*gd), GFP_KERNEL);
> +       if (!gd)
> +               return -ENOMEM;
> +
> +       gd->throttle_nsec = policy->cpuinfo.transition_latency ?
> +                           policy->cpuinfo.transition_latency :
> +                           THROTTLE_NSEC;
> +       pr_debug("%s: throttle threshold = %u [ns]\n",
> +                 __func__, gd->throttle_nsec);
> +
> +       if (cpufreq_driver_is_slow()) {
> +               cpufreq_driver_slow = true;
> +               gd->task = kthread_create(cpufreq_sched_thread, policy,
> +                                         "kschedfreq:%d",
> +                                         cpumask_first(policy->related_cpus));
> +               if (IS_ERR_OR_NULL(gd->task)) {
> +                       pr_err("%s: failed to create kschedfreq thread\n",
> +                              __func__);
> +                       goto err;
> +               }
> +               get_task_struct(gd->task);
> +               kthread_bind_mask(gd->task, policy->related_cpus);
> +               wake_up_process(gd->task);
> +               init_irq_work(&gd->irq_work, cpufreq_sched_irq_work);
> +       }
> +
> +       policy->governor_data = gd;

This should be moved before if(cpufreq_driver_is_slow()) {...}. I've
seen NULL pointer deference at boot in cpufreq_sched_thread() when it
tried to run sched_setscheduler_nocheck(gd->task, SCHED_FIFO, &param).

> +       set_sched_freq();
> +
> +       return 0;
> +
> +err:

And probably also set policy->governor_data to NULL here.

> +       kfree(gd);
> +       return -ENOMEM;
> +}

[snip...]

Best,
Ricky
