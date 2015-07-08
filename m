From: Michael Turquette <mturquette@baylibre.com>
Subject: Re: [RFCv5 PATCH 44/46] sched/fair: jump to max OPP when crossing UP
 threshold
Date: Wed, 08 Jul 2015 09:47:44 -0700
Message-ID: <20150708164744.9112.6023@quantum>
References: <1436293469-25707-1-git-send-email-morten.rasmussen@arm.com>
 <1436293469-25707-45-git-send-email-morten.rasmussen@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pd0-f182.google.com ([209.85.192.182]:36587 "EHLO
	mail-pd0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932574AbbGHQsE convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 8 Jul 2015 12:48:04 -0400
Received: by pddu5 with SMTP id u5so61181998pdd.3
        for <linux-pm@vger.kernel.org>; Wed, 08 Jul 2015 09:48:03 -0700 (PDT)
In-Reply-To: <1436293469-25707-45-git-send-email-morten.rasmussen@arm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Morten Rasmussen <morten.rasmussen@arm.com>, peterz@infradead.org, mingo@redhat.com
Cc: vincent.guittot@linaro.org, daniel.lezcano@linaro.org, Dietmar Eggemann <Dietmar.Eggemann@arm.com>, yuyang.du@intel.com, rjw@rjwysocki.net, Juri Lelli <Juri.Lelli@arm.com>, sgurrappadi@nvidia.com, pang.xunlei@zte.com.cn, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Juri Lelli <juri.lelli@arm.com>

Quoting Morten Rasmussen (2015-07-07 11:24:27)
> From: Juri Lelli <juri.lelli@arm.com>
> 
> Since the true utilization of a long running task is not detectable while
> it is running and might be bigger than the current cpu capacity, create the
> maximum cpu capacity head room by requesting the maximum cpu capacity once
> the cpu usage plus the capacity margin exceeds the current capacity. This
> is also done to try to harm the performance of a task the least.
> 
> cc: Ingo Molnar <mingo@redhat.com>
> cc: Peter Zijlstra <peterz@infradead.org>
> 
> Signed-off-by: Juri Lelli <juri.lelli@arm.com>
> ---
>  kernel/sched/fair.c | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)
> 
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 323331f..c2d6de4 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -8586,6 +8586,25 @@ static void task_tick_fair(struct rq *rq, struct task_struct *curr, int queued)
>  
>         if (!rq->rd->overutilized && cpu_overutilized(task_cpu(curr)))
>                 rq->rd->overutilized = true;
> +
> +       /*
> +        * To make free room for a task that is building up its "real"
> +        * utilization and to harm its performance the least, request a
> +        * jump to max OPP as soon as get_cpu_usage() crosses the UP
> +        * threshold. The UP threshold is built relative to the current
> +        * capacity (OPP), by using same margin used to tell if a cpu
> +        * is overutilized (capacity_margin).
> +        */
> +       if (sched_energy_freq()) {
> +               int cpu = cpu_of(rq);
> +               unsigned long capacity_orig = capacity_orig_of(cpu);
> +               unsigned long capacity_curr = capacity_curr_of(cpu);
> +
> +               if (capacity_curr < capacity_orig &&
> +                   (capacity_curr * SCHED_LOAD_SCALE) <
> +                   (get_cpu_usage(cpu) * capacity_margin))
> +                       cpufreq_sched_set_cap(cpu, capacity_orig);

I'm sure that at some point the Product People are going to want to tune
the capacity value that is requested. Hard-coding the max
capacity/frequency in is a reasonable start, but at some point it would
be nice to fetch an intermediate capacity defined by the cpufreq driver
for this particular cpu. We have already seen that a lot in Android
devices using the interactive governor and it could be done from
cpufreq_sched_start().

Regards,
Mike

> +       }
>  }
>  
>  /*
> -- 
> 1.9.1
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pm" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
