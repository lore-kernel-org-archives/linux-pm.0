From: Pavan Kondeti <pkondeti@codeaurora.org>
Subject: Re: [RFC 1/3] sched/fair: add util_est on top of PELT
Date: Tue, 29 Aug 2017 10:06:44 +0530
Message-ID: <CAEU1=PnypZ7V5yL6K3fT_OpfTosK15ju0vcztk8NpDj9xVu4xw@mail.gmail.com>
References: <20170825102008.4626-1-patrick.bellasi@arm.com> <20170825102008.4626-2-patrick.bellasi@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:54590 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750779AbdH2Egr (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 29 Aug 2017 00:36:47 -0400
In-Reply-To: <20170825102008.4626-2-patrick.bellasi@arm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Patrick Bellasi <patrick.bellasi@arm.com>
Cc: LKML <linux-kernel@vger.kernel.org>, linux-pm@vger.kernel.org, Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, Paul Turner <pjt@google.com>, Vincent Guittot <vincent.guittot@linaro.org>, John Stultz <john.stultz@linaro.org>, Morten Rasmussen <morten.rasmussen@arm.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>, Juri Lelli <juri.lelli@arm.com>, Tim Murray <timmurray@google.com>, Todd Kjos <tkjos@android.com>, Andres Oportus <andresoportus@google.com>, Joel Fernandes <joelaf@google.com>, Viresh Kumar <viresh.kumar@linaro.org>

Hi Patrick,

On Fri, Aug 25, 2017 at 3:50 PM, Patrick Bellasi
<patrick.bellasi@arm.com> wrote:
> The util_avg signal computed by PELT is too variable for some use-cases.
> For example, a big task waking up after a long sleep period will have its
> utilization almost completely decayed. This introduces some latency before
> schedutil will be able to pick the best frequency to run a task.
>
> The same issue can affect task placement. Indeed, since the task
> utilization is already decayed at wakeup, when the task is enqueued in a
> CPU, this can results in a CPU running a big task as being temporarily
> represented as being almost empty. This leads to a race condition where
> other tasks can be potentially allocated on a CPU which just started to run
> a big task which slept for a relatively long period.
>
> Moreover, the utilization of a task is, by PELT definition, a continuously
> changing metrics. This contributes in making almost instantly outdated some
> decisions based on the value of the PELT's utilization.
>
> For all these reasons, a more stable signal could probably do a better job
> of representing the expected/estimated utilization of a SE/RQ. Such a
> signal can be easily created on top of PELT by still using it as an
> estimator which produces values to be aggregated once meaningful events
> happens.
>
> This patch adds a simple implementation of util_est, a new signal built on
> top of PELT's util_avg where:
>
>     util_est(se) = max(se::util_avg, f(se::util_avg@dequeue_times))
>

I don't see any wrapper function in this patch that implements this
signal. You want to use this signal in the task placement path as a
replacement of task_util(), right?

Thanks,
Pavan

-- 
Qualcomm India Private Limited, on behalf of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, a
Linux Foundation Collaborative Project
