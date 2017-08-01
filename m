From: Pavan Kondeti <pkondeti@codeaurora.org>
Subject: Re: [Eas-dev] [PATCH V5 2/2] cpufreq: Process remote callbacks from
 any CPU if the platform permits
Date: Tue, 1 Aug 2017 16:30:34 +0530
Message-ID: <CAEU1=Pm5sdV3imHpx7J2dNqYs5Y_mHiNnQt_HccHsgG2P9NyHQ@mail.gmail.com>
References: <cover.1501223897.git.viresh.kumar@linaro.org> <c121a20eff05565155852c070e83504bf117da3e.1501223897.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <c121a20eff05565155852c070e83504bf117da3e.1501223897.git.viresh.kumar@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, Peter Zijlstra <peterz@infradead.org>, joelaf@google.com, linux-pm@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, skannan@codeaurora.org, smuckle.linux@gmail.com, eas-dev@lists.linaro.org
List-Id: linux-pm@vger.kernel.org

On Fri, Jul 28, 2017 at 12:16 PM, Viresh Kumar <viresh.kumar@linaro.org> wrote:
> On many platforms, CPUs can do DVFS across cpufreq policies. i.e CPU
> from policy-A can change frequency of CPUs belonging to policy-B.
>
> This is quite common in case of ARM platforms where we don't
> configure any per-cpu register.
>
> Add a flag to identify such platforms and update
> cpufreq_can_do_remote_dvfs() to allow remote callbacks if this flag is
> set.
>
> Also enable the flag for cpufreq-dt driver which is used only on ARM
> platforms currently.
>
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
>  drivers/cpufreq/cpufreq-dt.c |  1 +
>  include/linux/cpufreq.h      | 18 ++++++++++++++++--
>  2 files changed, 17 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/cpufreq/cpufreq-dt.c b/drivers/cpufreq/cpufreq-dt.c
> index fef3c2160691..d83ab94d041a 100644
> --- a/drivers/cpufreq/cpufreq-dt.c
> +++ b/drivers/cpufreq/cpufreq-dt.c
> @@ -274,6 +274,7 @@ static int cpufreq_init(struct cpufreq_policy *policy)
>                 transition_latency = CPUFREQ_ETERNAL;
>
>         policy->cpuinfo.transition_latency = transition_latency;
> +       policy->dvfs_possible_from_any_cpu = true;
>
>         return 0;
>
> diff --git a/include/linux/cpufreq.h b/include/linux/cpufreq.h
> index b3b6e8203e82..227cd0f13300 100644
> --- a/include/linux/cpufreq.h
> +++ b/include/linux/cpufreq.h
> @@ -127,6 +127,15 @@ struct cpufreq_policy {
>          */
>         unsigned int            transition_delay_us;
>
> +       /*
> +        * Remote DVFS flag (Not added to the driver structure as we don't want
> +        * to access another structure from scheduler hotpath).
> +        *
> +        * Should be set if CPUs can do DVFS on behalf of other CPUs from
> +        * different cpufreq policies.
> +        */
> +       bool                    dvfs_possible_from_any_cpu;
> +
>          /* Cached frequency lookup from cpufreq_driver_resolve_freq. */
>         unsigned int cached_target_freq;
>         int cached_resolved_idx;
> @@ -564,8 +573,13 @@ struct governor_attr {
>
>  static inline bool cpufreq_can_do_remote_dvfs(struct cpufreq_policy *policy)
>  {
> -       /* Allow remote callbacks only on the CPUs sharing cpufreq policy */
> -       if (cpumask_test_cpu(smp_processor_id(), policy->cpus))
> +       /*
> +        * Allow remote callbacks if:
> +        * - dvfs_possible_from_any_cpu flag is set
> +        * - the local and remote CPUs share cpufreq policy
> +        */
> +       if (policy->dvfs_possible_from_any_cpu ||
> +           cpumask_test_cpu(smp_processor_id(), policy->cpus))
>                 return true;
>
>         return false;

Currently sugov threads in the schedutil governor are pinned to the
policy CPUs. schedutil can now make use of this new
dvfs_possible_from_any_cpu flag and avoid the pinning, right?

Thanks,
Pavan
-- 
Qualcomm India Private Limited, on behalf of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, a
Linux Foundation Collaborative Project
