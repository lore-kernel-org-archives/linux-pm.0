From: Pavan Kondeti <pkondeti@codeaurora.org>
Subject: Re: [PATCH 1/2] cpufreq: schedutil: Don't restrict kthread to
 related_cpus unnecessarily
Date: Thu, 10 Aug 2017 12:28:30 +0530
Message-ID: <CAEU1=PmXWPdpATvSaj0d8ZrhTtWq6hznXGQc3ipO7AGXE_Pjiw@mail.gmail.com>
References: <8dd297a6ed05ed3f6c33aeb3059e71a1d270c530.1502338812.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:47402 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750868AbdHJG6d (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 10 Aug 2017 02:58:33 -0400
In-Reply-To: <8dd297a6ed05ed3f6c33aeb3059e71a1d270c530.1502338812.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, linux-pm@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>, Juri Lelli <Juri.Lelli@arm.com>, Joel Fernandes <joelaf@google.com>, Pavan Kondeti <pkondeti@codeaurora.org>, LKML <linux-kernel@vger.kernel.org>

On Thu, Aug 10, 2017 at 9:50 AM, Viresh Kumar <viresh.kumar@linaro.org> wrote:
> Utilization update callbacks are now processed remotely, even on the
> CPUs that don't share cpufreq policy with the target CPU (if
> dvfs_possible_from_any_cpu flag is set).
>
> But in non-fast switch paths, the frequency is changed only from one of
> policy->related_cpus. This happens because the kthread which does the
> actual update is bound to a subset of CPUs (i.e. related_cpus).
>
> Allow frequency to be remotely updated as well (i.e. call
> __cpufreq_driver_target()) if dvfs_possible_from_any_cpu flag is set.
>
> Reported-by: Pavan Kondeti <pkondeti@codeaurora.org>
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
>  kernel/sched/cpufreq_schedutil.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_schedutil.c
> index 2e74c49776be..504d0752f8f2 100644
> --- a/kernel/sched/cpufreq_schedutil.c
> +++ b/kernel/sched/cpufreq_schedutil.c
> @@ -487,7 +487,11 @@ static int sugov_kthread_create(struct sugov_policy *sg_policy)
>         }
>
>         sg_policy->thread = thread;
> -       kthread_bind_mask(thread, policy->related_cpus);
> +
> +       /* Kthread is bound to all CPUs by default */
> +       if (!policy->dvfs_possible_from_any_cpu)
> +               kthread_bind_mask(thread, policy->related_cpus);
> +

LGTM. Your other patch in this series is also nice. Thanks for doing it.

Thanks,
Pavan

-- 
Qualcomm India Private Limited, on behalf of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, a
Linux Foundation Collaborative Project
