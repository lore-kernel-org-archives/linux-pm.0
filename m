From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH 2/4] sched: cpufreq: Keep track of cpufreq utilization
 update flags
Date: Sat, 16 Dec 2017 17:40:00 +0100
Message-ID: <CAJZ5v0jLQ7v5u+OUpK0gSAHvR90K=agvUSuFNzJXMnk+YkKyzQ@mail.gmail.com>
References: <cover.1513158452.git.viresh.kumar@linaro.org> <17ff0b5d83a1275a98f0d1b87daf275f3e964af3.1513158452.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-ot0-f194.google.com ([74.125.82.194]:34871 "EHLO
        mail-ot0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756368AbdLPQkB (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 16 Dec 2017 11:40:01 -0500
In-Reply-To: <17ff0b5d83a1275a98f0d1b87daf275f3e964af3.1513158452.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, Linux PM <linux-pm@vger.kernel.org>, Vincent Guittot <vincent.guittot@linaro.org>, Dietmar Eggemann <dietmar.eggemann@arm.com>, Morten Rasmussen <morten.rasmussen@arm.com>, Juri Lelli <juri.lelli@redhat.com>, Todd Kjos <tkjos@android.com>, Joel Fernandes <joelaf@google.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

On Wed, Dec 13, 2017 at 10:53 AM, Viresh Kumar <viresh.kumar@linaro.org> wrote:
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
> +#define SCHED_CPUFREQ_CLEAR    (1U << 31)

I'm not thrilled by this, because schedutil is not the only user of
the flags and it's totally unclear what the other user(s) should do
when this is set.

Thanks,
Rafael
