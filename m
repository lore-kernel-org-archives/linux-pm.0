From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH] cpufreq: Implement light weight cpufreq_get_policy_table()
 routine
Date: Wed, 1 Jun 2016 00:40:38 +0200
Message-ID: <CAJZ5v0h95G7ngB7tMpV_vbERZivuLBxXNROqMMQyPaShyr_Raw@mail.gmail.com>
References: <57ec51642c05c8a859ba4bf90fdc80b23d75e239.1464241360.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wm0-f66.google.com ([74.125.82.66]:36190 "EHLO
	mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752788AbcEaWkk (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 31 May 2016 18:40:40 -0400
Received: by mail-wm0-f66.google.com with SMTP id q62so1488407wmg.3
        for <linux-pm@vger.kernel.org>; Tue, 31 May 2016 15:40:39 -0700 (PDT)
In-Reply-To: <57ec51642c05c8a859ba4bf90fdc80b23d75e239.1464241360.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, Lists linaro-kernel <linaro-kernel@lists.linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Steve Muckle <steve.muckle@linaro.org>

On Thu, May 26, 2016 at 7:42 AM, Viresh Kumar <viresh.kumar@linaro.org> wrote:
> Most of the callers of cpufreq_frequency_get_table() already have the
> pointer to a valid policy structure and they don't really need to go
> through the per-cpu variable first and then a check to validate the
> frequency, in order to find the freq-table for the policy.
>
> Implement a light weight call for this and update users.
>
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
>  drivers/cpufreq/cpufreq.c             | 4 ++--
>  drivers/cpufreq/cpufreq_ondemand.c    | 2 +-
>  drivers/cpufreq/cpufreq_stats.c       | 3 +--
>  drivers/cpufreq/freq_table.c          | 4 ++--
>  drivers/cpufreq/ppc_cbe_cpufreq_pmi.c | 2 +-
>  include/linux/cpufreq.h               | 7 +++++++
>  6 files changed, 14 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> index 90f4bf03701d..0b5cf0e4bd4f 100644
> --- a/drivers/cpufreq/cpufreq.c
> +++ b/drivers/cpufreq/cpufreq.c
> @@ -1989,7 +1989,7 @@ int __cpufreq_driver_target(struct cpufreq_policy *policy,
>         if (!cpufreq_driver->target_index)
>                 return -EINVAL;
>
> -       freq_table = cpufreq_frequency_get_table(policy->cpu);
> +       freq_table = cpufreq_get_policy_table(policy);

Maybe rename cpufreq_get_policy_table() to cpufreq_policy_freq_table()?

>         if (unlikely(!freq_table)) {
>                 pr_err("%s: Unable to find freq_table\n", __func__);
>                 return -EINVAL;
> @@ -2343,7 +2343,7 @@ static int cpufreq_boost_set_sw(int state)
>         int ret = -EINVAL;
>
>         for_each_active_policy(policy) {
> -               freq_table = cpufreq_frequency_get_table(policy->cpu);
> +               freq_table = cpufreq_get_policy_table(policy);
>                 if (freq_table) {
>                         ret = cpufreq_frequency_table_cpuinfo(policy,
>                                                         freq_table);
> diff --git a/drivers/cpufreq/cpufreq_ondemand.c b/drivers/cpufreq/cpufreq_ondemand.c
> index 300163430516..23f526726e0b 100644
> --- a/drivers/cpufreq/cpufreq_ondemand.c
> +++ b/drivers/cpufreq/cpufreq_ondemand.c
> @@ -113,7 +113,7 @@ static void ondemand_powersave_bias_init(struct cpufreq_policy *policy)
>  {
>         struct od_policy_dbs_info *dbs_info = to_dbs_info(policy->governor_data);
>
> -       dbs_info->freq_table = cpufreq_frequency_get_table(policy->cpu);
> +       dbs_info->freq_table = cpufreq_get_policy_table(policy);
>         dbs_info->freq_lo = 0;
>  }
>
> diff --git a/drivers/cpufreq/cpufreq_stats.c b/drivers/cpufreq/cpufreq_stats.c
> index d4618144b4c0..5fd1354925d9 100644
> --- a/drivers/cpufreq/cpufreq_stats.c
> +++ b/drivers/cpufreq/cpufreq_stats.c
> @@ -151,11 +151,10 @@ static int cpufreq_stats_create_table(struct cpufreq_policy *policy)
>         unsigned int i = 0, count = 0, ret = -ENOMEM;
>         struct cpufreq_stats *stats;
>         unsigned int alloc_size;
> -       unsigned int cpu = policy->cpu;
>         struct cpufreq_frequency_table *pos, *table;
>
>         /* We need cpufreq table for creating stats table */
> -       table = cpufreq_frequency_get_table(cpu);
> +       table = cpufreq_get_policy_table(policy);
>         if (unlikely(!table))
>                 return 0;
>
> diff --git a/drivers/cpufreq/freq_table.c b/drivers/cpufreq/freq_table.c
> index a8f1daffc9bc..5683ea4b7a03 100644
> --- a/drivers/cpufreq/freq_table.c
> +++ b/drivers/cpufreq/freq_table.c
> @@ -109,7 +109,7 @@ EXPORT_SYMBOL_GPL(cpufreq_frequency_table_verify);
>  int cpufreq_generic_frequency_table_verify(struct cpufreq_policy *policy)
>  {
>         struct cpufreq_frequency_table *table =
> -               cpufreq_frequency_get_table(policy->cpu);
> +               cpufreq_get_policy_table(policy);
>         if (!table)
>                 return -ENODEV;
>
> @@ -214,7 +214,7 @@ int cpufreq_frequency_table_get_index(struct cpufreq_policy *policy,
>  {
>         struct cpufreq_frequency_table *pos, *table;
>
> -       table = cpufreq_frequency_get_table(policy->cpu);
> +       table = cpufreq_get_policy_table(policy);
>         if (unlikely(!table)) {
>                 pr_debug("%s: Unable to find frequency table\n", __func__);
>                 return -ENOENT;
> diff --git a/drivers/cpufreq/ppc_cbe_cpufreq_pmi.c b/drivers/cpufreq/ppc_cbe_cpufreq_pmi.c
> index 7c4cd5c634f2..e228d51beeba 100644
> --- a/drivers/cpufreq/ppc_cbe_cpufreq_pmi.c
> +++ b/drivers/cpufreq/ppc_cbe_cpufreq_pmi.c
> @@ -103,7 +103,7 @@ static int pmi_notifier(struct notifier_block *nb,
>         if (event == CPUFREQ_START)
>                 return 0;
>
> -       cbe_freqs = cpufreq_frequency_get_table(policy->cpu);
> +       cbe_freqs = cpufreq_get_policy_table(policy);
>         node = cbe_cpu_to_node(policy->cpu);
>
>         pr_debug("got notified, event=%lu, node=%u\n", event, node);
> diff --git a/include/linux/cpufreq.h b/include/linux/cpufreq.h
> index 4e81e08db752..42ea01fb8dce 100644
> --- a/include/linux/cpufreq.h
> +++ b/include/linux/cpufreq.h
> @@ -620,6 +620,13 @@ static inline bool policy_has_boost_freq(struct cpufreq_policy *policy)
>  /* the following funtion is for cpufreq core use only */
>  struct cpufreq_frequency_table *cpufreq_frequency_get_table(unsigned int cpu);
>
> +static inline struct cpufreq_frequency_table *
> +cpufreq_get_policy_table(struct cpufreq_policy *policy)

Please don't break this line.

> +{
> +       return policy->freq_table;
> +}
> +
> +
>  /* the following are really really optional */
>  extern struct freq_attr cpufreq_freq_attr_scaling_available_freqs;
>  extern struct freq_attr cpufreq_freq_attr_scaling_boost_freqs;
> --
