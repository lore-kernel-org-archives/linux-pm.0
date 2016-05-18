From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH 5/5] cpufreq: schedutil: do not update rate limit ts when
 freq is unchanged
Date: Thu, 19 May 2016 01:44:36 +0200
Message-ID: <CAJZ5v0iwz3d6dxY-sUxbU8q1EzcO0gKX1pp-rDb8Www46Fg1uw@mail.gmail.com>
References: <1462828814-32530-1-git-send-email-smuckle@linaro.org>
	<1462828814-32530-6-git-send-email-smuckle@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wm0-f67.google.com ([74.125.82.67]:36377 "EHLO
	mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751284AbcERXoh (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 18 May 2016 19:44:37 -0400
In-Reply-To: <1462828814-32530-6-git-send-email-smuckle@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Steve Muckle <steve.muckle@linaro.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, "Rafael J. Wysocki" <rafael@kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Vincent Guittot <vincent.guittot@linaro.org>, Morten Rasmussen <morten.rasmussen@arm.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>, Juri Lelli <Juri.Lelli@arm.com>, Patrick Bellasi <patrick.bellasi@arm.com>, Michael Turquette <mturquette@baylibre.com>, Viresh Kumar <viresh.kumar@linaro.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Len Brown <lenb@kernel.org>

On Mon, May 9, 2016 at 11:20 PM, Steve Muckle <steve.muckle@linaro.org> wrote:
> The rate limit timestamp (last_freq_update_time) is currently advanced
> anytime schedutil re-evaluates the policy regardless of whether the CPU
> frequency is changed or not. This means that utilization updates which
> have no effect can cause much more significant utilization updates
> (which require a large increase or decrease in CPU frequency) to be
> delayed due to rate limiting.
>
> Instead only update the rate limiting timstamp when the requested
> target-supported frequency changes. The rate limit will now apply to
> the rate of CPU frequency changes rather than the rate of
> re-evaluations of the policy frequency.
>
> Signed-off-by: Steve Muckle <smuckle@linaro.org>

I'm sort of divided here to be honest.

> ---
>  kernel/sched/cpufreq_schedutil.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_schedutil.c
> index e185075fcb5c..4d2907c8a142 100644
> --- a/kernel/sched/cpufreq_schedutil.c
> +++ b/kernel/sched/cpufreq_schedutil.c
> @@ -117,12 +117,11 @@ static void sugov_update_commit(struct sugov_cpu *sg_cpu, int cpu, u64 time,
>         struct sugov_policy *sg_policy = sg_cpu->sg_policy;
>         struct cpufreq_policy *policy = sg_policy->policy;
>
> -       sg_policy->last_freq_update_time = time;
> -
>         if (sg_policy->next_freq == next_freq) {
>                 trace_cpu_frequency(policy->cur, cpu);

You should at least rate limit the trace_cpu_frequency() thing here if
you don't want to advance the last update time I think, or you may
easily end up with the trace buffer flooded by irrelevant stuff.

>                 return;
>         }
> +       sg_policy->last_freq_update_time = time;
>         sg_policy->next_freq = next_freq;
>
>         if (sugov_queue_remote_callback(sg_policy, cpu))
> --
> 2.4.10
>
