From: Pavan Kondeti <pkondeti@codeaurora.org>
Subject: Re: [RFC 1/3] sched/fair: add util_est on top of PELT
Date: Tue, 29 Aug 2017 12:11:15 +0530
Message-ID: <CAEU1=PmgWSi7hrLpQ2nQUi_Ki5Z6JsJMi-fV5ke1B26aC0kqSg@mail.gmail.com>
References: <20170825102008.4626-1-patrick.bellasi@arm.com> <20170825102008.4626-2-patrick.bellasi@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:57018 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750909AbdH2GlS (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 29 Aug 2017 02:41:18 -0400
In-Reply-To: <20170825102008.4626-2-patrick.bellasi@arm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Patrick Bellasi <patrick.bellasi@arm.com>
Cc: LKML <linux-kernel@vger.kernel.org>, linux-pm@vger.kernel.org, Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, Paul Turner <pjt@google.com>, Vincent Guittot <vincent.guittot@linaro.org>, John Stultz <john.stultz@linaro.org>, Morten Rasmussen <morten.rasmussen@arm.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>, Juri Lelli <juri.lelli@arm.com>, Tim Murray <timmurray@google.com>, Todd Kjos <tkjos@android.com>, Andres Oportus <andresoportus@google.com>, Joel Fernandes <joelaf@google.com>, Viresh Kumar <viresh.kumar@linaro.org>

On Fri, Aug 25, 2017 at 3:50 PM, Patrick Bellasi
<patrick.bellasi@arm.com> wrote:
> The util_avg signal computed by PELT is too variable for some use-cases.
> For example, a big task waking up after a long sleep period will have its
> utilization almost completely decayed. This introduces some latency before
> schedutil will be able to pick the best frequency to run a task.
>

<snip>

> diff --git a/include/linux/sched.h b/include/linux/sched.h
> index c28b182c9833..8d7bc55f68d5 100644
> --- a/include/linux/sched.h
> +++ b/include/linux/sched.h
> @@ -26,6 +26,7 @@
>  #include <linux/signal_types.h>
>  #include <linux/mm_types_task.h>
>  #include <linux/task_io_accounting.h>
> +#include <linux/average.h>
>
>  /* task_struct member predeclarations (sorted alphabetically): */
>  struct audit_context;
> @@ -277,6 +278,16 @@ struct load_weight {
>         u32                             inv_weight;
>  };
>
> +/**
> + * Utilizaton's Exponential Weighted Moving Average (EWMA)
> + *
> + * Support functions to track an EWMA for the utilization of SEs and RQs. New
> + * samples will be added to the moving average each time a task completes an
> + * activation. Thus the weight is chosen so that the EWMA wil be relatively
> + * insensitive to transient changes to the task's workload.
> + */
> +DECLARE_EWMA(util, 0, 4);
> +
>  /*

Should the factor be 1 instead of 0? i.e 25% contribution from the
recent sample.

Thanks,
Pavan


-- 
Qualcomm India Private Limited, on behalf of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, a
Linux Foundation Collaborative Project
