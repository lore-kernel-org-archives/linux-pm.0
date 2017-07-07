From: Joel Fernandes <joelaf@google.com>
Subject: Re: [PATCH v2 4/6] cpufreq: schedutil: update CFS util only if used
Date: Thu, 6 Jul 2017 22:58:31 -0700
Message-ID: <CAJWu+ooS=zpSi2LkOmm5itqZtOcSWdxL128dtG41yOVzq2tBxQ@mail.gmail.com>
References: <1499189651-18797-1-git-send-email-patrick.bellasi@arm.com> <1499189651-18797-5-git-send-email-patrick.bellasi@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-oi0-f44.google.com ([209.85.218.44]:35429 "EHLO
        mail-oi0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750844AbdGGF6d (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 7 Jul 2017 01:58:33 -0400
Received: by mail-oi0-f44.google.com with SMTP id 191so19873628oii.2
        for <linux-pm@vger.kernel.org>; Thu, 06 Jul 2017 22:58:32 -0700 (PDT)
In-Reply-To: <1499189651-18797-5-git-send-email-patrick.bellasi@arm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Patrick Bellasi <patrick.bellasi@arm.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>, Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, Viresh Kumar <viresh.kumar@linaro.org>, Vincent Guittot <vincent.guittot@linaro.org>, Juri Lelli <juri.lelli@arm.com>, Andres Oportus <andresoportus@google.com>, Todd Kjos <tkjos@android.com>, Morten Rasmussen <morten.rasmussen@arm.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>

On Tue, Jul 4, 2017 at 10:34 AM, Patrick Bellasi
<patrick.bellasi@arm.com> wrote:
> Currently the utilization of the FAIR class is collected before locking
> the policy. Although that should not be a big issue for most cases, we
> also don't really know how much latency there can be between the
> utilization reading and its usage.
>
> Let's get the FAIR utilization right before its usage to be better in
> sync with the current status of a CPU.
>
> Signed-off-by: Patrick Bellasi <patrick.bellasi@arm.com>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> Cc: Viresh Kumar <viresh.kumar@linaro.org>
> Cc: linux-kernel@vger.kernel.org
> Cc: linux-pm@vger.kernel.org
> ---
>  kernel/sched/cpufreq_schedutil.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_schedutil.c
> index 98704d8..df433f1 100644
> --- a/kernel/sched/cpufreq_schedutil.c
> +++ b/kernel/sched/cpufreq_schedutil.c
> @@ -308,10 +308,9 @@ static void sugov_update_shared(struct update_util_data *hook, u64 time,
>         if (unlikely(current == sg_policy->thread))
>                 return;
>
> -       sugov_get_util(&util, &max);
> -
>         raw_spin_lock(&sg_policy->update_lock);
>
> +       sugov_get_util(&util, &max);
>         sg_cpu->util = util;
>         sg_cpu->max = max;

Is your concern that there will we spinlock contention before calling
sugov_get_util?

If that's the case, with your patch it seems to me such contention
(and hence spinning) itself could cause the utilization to be inflated
- thus calling sugov_get_util after acquiring the lock will not be as
accurate as before. In that case it seems to me its better to let
sugov_get_util be called before acquiring the lock (as before).

thanks,

-Joel
