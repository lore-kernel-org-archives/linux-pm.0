From: Joel Fernandes <joelaf@google.com>
Subject: Re: [RFC PATCH v1 3/8] sched/cpufreq_schedutil: make worker kthread
 be SCHED_DEADLINE
Date: Thu, 6 Jul 2017 20:56:32 -0700
Message-ID: <CAJWu+op-y5Q6Ginhxk7ntjTrZmNbJX8arMsqOrkxs34m7CukaA@mail.gmail.com>
References: <20170705085905.6558-1-juri.lelli@arm.com> <20170705085905.6558-4-juri.lelli@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-oi0-f51.google.com ([209.85.218.51]:33149 "EHLO
        mail-oi0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753134AbdGGD4e (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 6 Jul 2017 23:56:34 -0400
Received: by mail-oi0-f51.google.com with SMTP id p188so18455018oia.0
        for <linux-pm@vger.kernel.org>; Thu, 06 Jul 2017 20:56:34 -0700 (PDT)
In-Reply-To: <20170705085905.6558-4-juri.lelli@arm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Juri Lelli <juri.lelli@arm.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>, LKML <linux-kernel@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Vincent Guittot <vincent.guittot@linaro.org>, Steven Rostedt <rostedt@goodmis.org>, luca.abeni@santannapisa.it, claudio@evidence.eu.com, Tommaso Cucinotta <tommaso.cucinotta@santannapisa.it>, bristot@redhat.com, mathieu.poirier@linaro.org, Todd Kjos <tkjos@android.com>, Andres Oportus <andresoportus@google.com>, Morten Rasmussen <morten.rasmussen@arm.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>, Patrick Bellasi <patrick.bellasi@arm.com>, Ingo Molnar <mingo@kernel.org>Rafael J

Hi Juri,

On Wed, Jul 5, 2017 at 1:59 AM, Juri Lelli <juri.lelli@arm.com> wrote:
> Worker kthread needs to be able to change frequency for all other
> threads.
>
> Make it special, just under STOP class.
>
> Signed-off-by: Juri Lelli <juri.lelli@arm.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Ingo Molnar <mingo@kernel.org>
> Cc: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> Cc: Viresh Kumar <viresh.kumar@linaro.org>
> Cc: Luca Abeni <luca.abeni@santannapisa.it>
> Cc: Claudio Scordino <claudio@evidence.eu.com>
> ---
> Changes from RFCv0:
>
>  - use a high bit of sched_flags and don't expose the new flag to
>    userspace (also add derisory comments) (Peter)
> ---
>  include/linux/sched.h            |  1 +
>  kernel/sched/core.c              | 15 +++++++++++++--
>  kernel/sched/cpufreq_schedutil.c | 15 ++++++++++++---
>  kernel/sched/deadline.c          | 13 +++++++++++++
>  kernel/sched/sched.h             | 20 +++++++++++++++++++-
>  5 files changed, 58 insertions(+), 6 deletions(-)
>
> diff --git a/include/linux/sched.h b/include/linux/sched.h
> index 1f0f427e0292..0ba767fdedae 100644
> --- a/include/linux/sched.h
> +++ b/include/linux/sched.h
> @@ -1359,6 +1359,7 @@ extern int idle_cpu(int cpu);
>  extern int sched_setscheduler(struct task_struct *, int, const struct sched_param *);
>  extern int sched_setscheduler_nocheck(struct task_struct *, int, const struct sched_param *);
>  extern int sched_setattr(struct task_struct *, const struct sched_attr *);
> +extern int sched_setattr_nocheck(struct task_struct *, const struct sched_attr *);
>  extern struct task_struct *idle_task(int cpu);
>
>  /**
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index 5186797908dc..0e40c7ff2bf4 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -3998,7 +3998,9 @@ static int __sched_setscheduler(struct task_struct *p,
>         }
>
>         if (attr->sched_flags &
> -               ~(SCHED_FLAG_RESET_ON_FORK | SCHED_FLAG_RECLAIM))
> +               ~(SCHED_FLAG_RESET_ON_FORK |
> +                 SCHED_FLAG_RECLAIM |
> +                 SCHED_FLAG_SPECIAL))
>                 return -EINVAL;

I was thinking if its better to name SCHED_FLAG_SPECIAL something more
descriptive than "special", since it will not be clear looking at
other parts of the code that this is used for the frequency scaling
thread or that its a DL task. I was thinking since this flag is
specifically setup for the sugov thread frequency scaling purpose, a
better flag name than SPECIAL might be SCHED_FLAG_DL_FREQ_SCALE or
SCHED_FLAG_FREQ_SCALE. But I am Ok with whatever makes sense to do
here. Thanks,

Regards,

-Joel
