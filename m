From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [RFC V2 4/6] cpufreq: Use transition_delay_us for legacy
 governors as well
Date: Thu, 13 Jul 2017 18:31:11 +0200
Message-ID: <CAJZ5v0hn2CSXvoQf+Xs8d43=Y8O86J30w9iK99WS_ot8v_Tg4g@mail.gmail.com>
References: <cover.1499853492.git.viresh.kumar@linaro.org> <2b3bfd2566ecaa0635c29a49c110e16803f80db0.1499853492.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-it0-f68.google.com ([209.85.214.68]:33787 "EHLO
        mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752363AbdGMQbN (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 13 Jul 2017 12:31:13 -0400
In-Reply-To: <2b3bfd2566ecaa0635c29a49c110e16803f80db0.1499853492.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, Linux PM <linux-pm@vger.kernel.org>, Vincent Guittot <vincent.guittot@linaro.org>, Dominik Brodowski <linux@dominikbrodowski.net>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

On Thu, Jul 13, 2017 at 7:40 AM, Viresh Kumar <viresh.kumar@linaro.org> wrote:
> The policy->transition_delay_us field is used only by the schedutil
> governor currently, and this field describes how fast the driver wants
> the cpufreq governor to change CPUs frequency. It should rather be a
> common thing across all governors, as it doesn't have any schedutil
> dependency here.
>
> Create a new helper cpufreq_policy_transition_delay_us() to get the
> transition delay across all governors.
>
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
>  drivers/cpufreq/cpufreq_governor.c |  9 +--------
>  include/linux/cpufreq.h            | 15 +++++++++++++++
>  kernel/sched/cpufreq_schedutil.c   | 11 +----------
>  3 files changed, 17 insertions(+), 18 deletions(-)
>
> diff --git a/drivers/cpufreq/cpufreq_governor.c b/drivers/cpufreq/cpufreq_governor.c
> index 858081f9c3d7..eed069ecfd5e 100644
> --- a/drivers/cpufreq/cpufreq_governor.c
> +++ b/drivers/cpufreq/cpufreq_governor.c
> @@ -389,7 +389,6 @@ int cpufreq_dbs_governor_init(struct cpufreq_policy *policy)
>         struct dbs_governor *gov = dbs_governor_of(policy);
>         struct dbs_data *dbs_data;
>         struct policy_dbs_info *policy_dbs;
> -       unsigned int latency;
>         int ret = 0;
>
>         /* State should be equivalent to EXIT */
> @@ -428,13 +427,7 @@ int cpufreq_dbs_governor_init(struct cpufreq_policy *policy)
>         if (ret)
>                 goto free_policy_dbs_info;
>
> -       /* policy latency is in ns. Convert it to us first */
> -       latency = policy->cpuinfo.transition_latency / 1000;
> -       if (latency == 0)
> -               latency = 1;
> -
> -       /* Bring kernel and HW constraints together */
> -       dbs_data->sampling_rate = LATENCY_MULTIPLIER * latency;
> +       dbs_data->sampling_rate = cpufreq_policy_transition_delay_us(policy);
>
>         if (!have_governor_per_policy())
>                 gov->gdbs_data = dbs_data;
> diff --git a/include/linux/cpufreq.h b/include/linux/cpufreq.h
> index 00e4c40a3249..14f0ab61ed17 100644
> --- a/include/linux/cpufreq.h
> +++ b/include/linux/cpufreq.h
> @@ -532,6 +532,21 @@ static inline void cpufreq_policy_apply_limits(struct cpufreq_policy *policy)
>                 __cpufreq_driver_target(policy, policy->min, CPUFREQ_RELATION_L);
>  }
>
> +static inline unsigned int
> +cpufreq_policy_transition_delay_us(struct cpufreq_policy *policy)
> +{
> +       unsigned int delay_us = LATENCY_MULTIPLIER, latency;
> +
> +       if (policy->transition_delay_us)
> +               return policy->transition_delay_us;
> +
> +       latency = policy->cpuinfo.transition_latency / NSEC_PER_USEC;
> +       if (latency)
> +               delay_us *= latency;
> +
> +       return delay_us;
> +}

Not in the header, please, and I don't think you need delay_us:

    latency = policy->cpuinfo.transition_latency / NSEC_PER_USEC;
    if (latency)
        return latency * LATENCY_MULTIPLIER;

    return LATENCY_MULTIPLIER;

Thanks,
Rafael
