From: Joel Fernandes <joelaf@google.com>
Subject: Re: [PATCH 2/3] cpufreq: schedutil: Fix selection algorithm while
 reducing frequency
Date: Sat, 10 Jun 2017 02:11:39 -0700
Message-ID: <CAJWu+or0GhiVS2rTAGMzS+y5xMrVUakYKO8G7u5Cn1dHX_P=SQ@mail.gmail.com>
References: <cover.1497002895.git.viresh.kumar@linaro.org> <8d5e793df4f06d54794a889543817cf5be131650.1497002895.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-ot0-f174.google.com ([74.125.82.174]:33229 "EHLO
        mail-ot0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751876AbdFJJLl (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 10 Jun 2017 05:11:41 -0400
Received: by mail-ot0-f174.google.com with SMTP id k4so48661369otd.0
        for <linux-pm@vger.kernel.org>; Sat, 10 Jun 2017 02:11:40 -0700 (PDT)
In-Reply-To: <8d5e793df4f06d54794a889543817cf5be131650.1497002895.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, linaro-kernel@lists.linaro.org, Linux PM <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Vincent Guittot <vincent.guittot@linaro.org>, Juri Lelli <Juri.Lelli@arm.com>, Patrick Bellasi <patrick.bellasi@arm.com>, john.ettedgui@gmail.com, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Morten Rasmussen <morten.rasmussen@arm.com>

On Fri, Jun 9, 2017 at 3:15 AM, Viresh Kumar <viresh.kumar@linaro.org> wrote:
> While reducing frequency if there are no frequencies available between
> "current" and "next" calculated frequency, then the core will never
> select the "next" frequency.
>
> For example, consider the possible range of frequencies as 900 MHz, 1
> GHz, 1.1 GHz, and 1.2 GHz. If the current frequency is 1.1 GHz and the
> next frequency (based on current utilization) is 1 GHz, then the
> schedutil governor will try to set the average of these as the next
> frequency (i.e. 1.05 GHz).
>
> Because we always try to find the lowest frequency greater than equal to
> the target frequency, cpufreq_driver_resolve_freq() will end up
> returning 1.1 GHz only. And we will not be able to reduce the frequency
> eventually. The worst hit is the policy->min frequency as that will
> never get selected after the frequency is increased once.

But once utilization goes to 0, it will select the min frequency
(because it selects lowest frequency >= target)?

>
> This affects all the drivers that provide ->target() or ->target_index()
> callbacks.
>
> Though for cpufreq drivers, like intel_pstate, which provide ->target()
> but not ->resolve_freq() (i.e.  cpufreq_driver_resolve_freq() simply
> returns the next frequency), sg_policy->next_freq gets updated with the
> average frequency. And so we will finally select the min frequency when
> the next_freq is 1 more than the min frequency as the average then will
> be equal to the min frequency. But that will also take lots of
> iterations of the schedutil update callbacks to happen.
>
> Fix that by not using the average value for the next_freq in such cases.
>
> Note that this still doesn't fix the drivers which provide ->target()
> but don't provide ->resolve_freq() (e.g. intel_pstate) and such drivers
> need to be updated to provide the ->resolve_freq() callbacks as well in
> order to fix this.
>
> Fixes: 39b64aa1c007 ("cpufreq: schedutil: Reduce frequencies slower")
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
>  kernel/sched/cpufreq_schedutil.c | 33 ++++++++++++++++++++++++++++-----
>  1 file changed, 28 insertions(+), 5 deletions(-)
>
> diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_schedutil.c
> index 1852bd73d903..30e6a62d227c 100644
> --- a/kernel/sched/cpufreq_schedutil.c
> +++ b/kernel/sched/cpufreq_schedutil.c
> @@ -117,6 +117,17 @@ static void sugov_update_commit(struct sugov_policy *sg_policy, u64 time,
>         }
>  }
>
> +static unsigned int resolve_freq(struct sugov_policy *sg_policy,
> +                                unsigned int freq)
> +{
> +       if (freq == sg_policy->cached_raw_freq &&
> +           sg_policy->next_freq != UINT_MAX)
> +               return sg_policy->next_freq;
> +
> +       sg_policy->cached_raw_freq = freq;
> +       return cpufreq_driver_resolve_freq(sg_policy->policy, freq);
> +}
> +
>  /**
>   * get_next_freq - Compute a new frequency for a given cpufreq policy.
>   * @sg_policy: schedutil policy object to compute the new frequency for.
> @@ -145,6 +156,7 @@ static unsigned int get_next_freq(struct sugov_policy *sg_policy,
>         struct cpufreq_policy *policy = sg_policy->policy;
>         unsigned int freq = arch_scale_freq_invariant() ?
>                                 policy->cpuinfo.max_freq : policy->cur;
> +       unsigned int target, original = 0;
>
>         freq = (freq + (freq >> 2)) * util / max;
>
> @@ -156,13 +168,24 @@ static unsigned int get_next_freq(struct sugov_policy *sg_policy,
>         if (freq < policy->min)
>                 freq = policy->min;
>
> -       if (sg_policy->next_freq > freq)
> +       if (sg_policy->next_freq > freq) {
> +               original = freq;
>                 freq = (sg_policy->next_freq + freq) >> 1;
> +       }
>
> -       if (freq == sg_policy->cached_raw_freq && sg_policy->next_freq != UINT_MAX)
> -               return sg_policy->next_freq;
> -       sg_policy->cached_raw_freq = freq;
> -       return cpufreq_driver_resolve_freq(policy, freq);
> +       target = resolve_freq(sg_policy, freq);
> +
> +       /*
> +        * While reducing frequency if there are no frequencies available
> +        * between "original" and "next_freq", resolve_freq() will return
> +        * next_freq because we always try to find the lowest frequency greater
> +        * than equal to the "freq". Fix that by going directly to the
> +        * "original" frequency in that case.
> +        */
> +       if (unlikely(original && target == sg_policy->next_freq))
> +               target = resolve_freq(sg_policy, original);
> +
> +       return target;
>  }

I thought its confusing to have a special case like this. On one hand
we're saying we'd like to select next frequency to be lowest frequency
>= target, on the other hand we're saying if the target wasn't low
enough to trigger an OPP change, then we'd just rather drop the
frequency to the lower OPP. I get why you'd like to do that, because
with patch 1/3 you're lowering frequency more slower before doing the
cpufreq_resolve, but what if the reduction in utilization was really
small to begin with and not because the "reduce frequencies more
slowly" stuff that you moved in patch 1/3? Then in that case you'd be
falsely dropping frequency when the right thing to do would be to
select the lowest freq >= target?

Thanks,
Joel
