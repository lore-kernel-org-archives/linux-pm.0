From: Juri Lelli <juri.lelli@redhat.com>
Subject: Re: [PATCH 2/4] sched: cpufreq: Keep track of cpufreq utilization
 update flags
Date: Wed, 13 Dec 2017 12:26:39 +0100
Message-ID: <20171213112639.GD30887@localhost.localdomain>
References: <cover.1513158452.git.viresh.kumar@linaro.org>
 <17ff0b5d83a1275a98f0d1b87daf275f3e964af3.1513158452.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wr0-f193.google.com ([209.85.128.193]:33888 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752764AbdLML0n (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 13 Dec 2017 06:26:43 -0500
Received: by mail-wr0-f193.google.com with SMTP id y21so1801959wrc.1
        for <linux-pm@vger.kernel.org>; Wed, 13 Dec 2017 03:26:43 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <17ff0b5d83a1275a98f0d1b87daf275f3e964af3.1513158452.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, linux-pm@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>, dietmar.eggemann@arm.com, morten.rasmussen@arm.com, tkjos@android.com, joelaf@google.com, linux-kernel@vger.kernel.org

Hi Viresh,

On 13/12/17 15:23, Viresh Kumar wrote:
> Currently the schedutil governor overwrites the sg_cpu->flags field on
> every call to the utilization handler. It was pretty good as the initial
> implementation of utilization handlers, there are several drawbacks
> though.
> 
> The biggest drawback is that the sg_cpu->flags field doesn't always
> represent the correct type of tasks that are enqueued on a CPU's rq. For
> example, if a fair task is enqueued while a RT or DL task is running, we
> will overwrite the flags with value 0 and that may take the CPU to lower
> OPPs unintentionally. There can be other corner cases as well which we
> aren't aware of currently.
> 
> This patch changes the current implementation to keep track of all the
> task types that are currently enqueued to the CPUs rq. A new flag: CLEAR
> is introduced and is set by the scheduling classes when their last task
> is dequeued. When the CLEAR flag bit is set, the schedutil governor resets
> all the other flag bits that are present in the flags parameter. For
> now, the util update handlers return immediately if they were called to
> clear the flag.
> 
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
>  include/linux/sched/cpufreq.h    |  7 ++++++-
>  kernel/sched/cpufreq_schedutil.c | 21 ++++++++++++++++++---
>  kernel/sched/deadline.c          |  4 ++++
>  kernel/sched/fair.c              |  8 ++++++--
>  kernel/sched/rt.c                |  4 ++++
>  5 files changed, 38 insertions(+), 6 deletions(-)
> 
> diff --git a/include/linux/sched/cpufreq.h b/include/linux/sched/cpufreq.h
> index d1ad3d825561..6f6641e61236 100644
> --- a/include/linux/sched/cpufreq.h
> +++ b/include/linux/sched/cpufreq.h
> @@ -8,10 +8,15 @@
>   * Interface between cpufreq drivers and the scheduler:
>   */
>  
> +#define SCHED_CPUFREQ_CLEAR	(1U << 31)
>  #define SCHED_CPUFREQ_RT	(1U << 0)
>  #define SCHED_CPUFREQ_DL	(1U << 1)
> -#define SCHED_CPUFREQ_IOWAIT	(1U << 2)
> +#define SCHED_CPUFREQ_CFS	(1U << 2)

This flag doesn't do much, does it? I mean RT/DL/IOWAIT are used to bump
up frequency, while you are adding CFS for the sake of simmetry, right?
And with my patches DL will hopefully soon be in the same situation.
If my understanding is correct, maybe add a comment?

Apart from this, patch looks good to me; couldn't test it though, sorry.

Reviewed-by: Juri Lelli <juri.lelli@redhat.com>

Thanks,

- Juri
