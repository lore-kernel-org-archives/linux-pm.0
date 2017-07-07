From: Joel Fernandes <joelaf@google.com>
Subject: Re: [RFC PATCH v1 4/8] sched/cpufreq_schedutil: split utilization signals
Date: Thu, 6 Jul 2017 20:26:00 -0700
Message-ID: <CAJWu+oqCT2yX3cLAZOpBdipeg+MFo_KP-jgXZRv07DVYMT+_vA@mail.gmail.com>
References: <20170705085905.6558-1-juri.lelli@arm.com> <20170705085905.6558-5-juri.lelli@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-oi0-f47.google.com ([209.85.218.47]:33665 "EHLO
        mail-oi0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753322AbdGGD0H (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 6 Jul 2017 23:26:07 -0400
Received: by mail-oi0-f47.google.com with SMTP id p188so18117166oia.0
        for <linux-pm@vger.kernel.org>; Thu, 06 Jul 2017 20:26:01 -0700 (PDT)
In-Reply-To: <20170705085905.6558-5-juri.lelli@arm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Juri Lelli <juri.lelli@arm.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>, LKML <linux-kernel@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Vincent Guittot <vincent.guittot@linaro.org>, Steven Rostedt <rostedt@goodmis.org>, luca.abeni@santannapisa.it, claudio@evidence.eu.com, Tommaso Cucinotta <tommaso.cucinotta@santannapisa.it>, bristot@redhat.com, mathieu.poirier@linaro.org, Todd Kjos <tkjos@android.com>, Andres Oportus <andresoportus@google.com>, Morten Rasmussen <morten.rasmussen@arm.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>, Patrick Bellasi <patrick.bellasi@arm.com>, Ingo Molnar <mingo@kernel.org>Rafael J

Hi Juri,

On Wed, Jul 5, 2017 at 1:59 AM, Juri Lelli <juri.lelli@arm.com> wrote:
> To be able to treat utilization signals of different scheduling classes
> in different ways (e.g., CFS signal might be stale while DEADLINE signal
> is never stale by design) we need to split sugov_cpu::util signal in two:
> util_cfs and util_dl.
>
> This patch does that by also changing sugov_get_util() parameter list.
> After this change, aggregation of the different signals has to be performed
> by sugov_get_util() users (so that they can decide what to do with the
> different signals).
>
> Suggested-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
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
>  - refactor aggregation of utilization in sugov_aggregate_util()
> ---
>  kernel/sched/cpufreq_schedutil.c | 28 ++++++++++++++++------------
>  1 file changed, 16 insertions(+), 12 deletions(-)
>
> diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_schedutil.c
> index ba6227625f24..e835fa886225 100644
> --- a/kernel/sched/cpufreq_schedutil.c
> +++ b/kernel/sched/cpufreq_schedutil.c
> @@ -58,7 +58,8 @@ struct sugov_cpu {
>         u64 last_update;
>
>         /* The fields below are only needed when sharing a policy. */
> -       unsigned long util;
> +       unsigned long util_cfs;
> +       unsigned long util_dl;
>         unsigned long max;
>         unsigned int flags;
>
> @@ -154,20 +155,24 @@ static unsigned int get_next_freq(struct sugov_policy *sg_policy,
>         return cpufreq_driver_resolve_freq(policy, freq);
>  }
>
> -static void sugov_get_util(unsigned long *util, unsigned long *max)
> +static void sugov_get_util(struct sugov_cpu *sg_cpu)
>  {
>         struct rq *rq = this_rq();
> -       unsigned long dl_util = (rq->dl.running_bw * SCHED_CAPACITY_SCALE)
> -                               >> BW_SHIFT;
>
> -       *max = arch_scale_cpu_capacity(NULL, smp_processor_id());
> +       sg_cpu->max = arch_scale_cpu_capacity(NULL, smp_processor_id());
> +       sg_cpu->util_cfs = rq->cfs.avg.util_avg;
> +       sg_cpu->util_dl = (rq->dl.running_bw * SCHED_CAPACITY_SCALE)
> +                         >> BW_SHIFT;
> +}
>
> +static unsigned long sugov_aggregate_util(struct sugov_cpu *sg_cpu)
> +{
>         /*
>          * Ideally we would like to set util_dl as min/guaranteed freq and
>          * util_cfs + util_dl as requested freq. However, cpufreq is not yet
>          * ready for such an interface. So, we only do the latter for now.
>          */
> -       *util = min(rq->cfs.avg.util_avg + dl_util, *max);
> +       return min(sg_cpu->util_cfs + sg_cpu->util_dl, sg_cpu->max);
>  }

I am wondering why the need for a separate aggregation API. To me, it
looks like using sugov_get_util to set the sg_cpu util elements and
then do the aggregation at the same time would have the same effect
(without changing the existing parameter list). Is this to handle a
future usecase where aggregation may need to be done differently? For
all the user's of sugov_get_util, aggregation is done in the same way.
Anyway if I missed something, sorry for the noise.

thanks,

-Joel
