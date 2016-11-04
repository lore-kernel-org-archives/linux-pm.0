From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH] cpufreq: stats: clear statistics
Date: Fri, 4 Nov 2016 01:28:57 +0100
Message-ID: <CAJZ5v0gZBvdvuVin8hUzFxckFSJo0uVpLta1HHNFfA1A-roPJg@mail.gmail.com>
References: <20161103204615.85395-1-code@mmayer.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wm0-f66.google.com ([74.125.82.66]:33043 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932730AbcKDA27 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 3 Nov 2016 20:28:59 -0400
In-Reply-To: <20161103204615.85395-1-code@mmayer.net>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Markus Mayer <code@mmayer.net>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Power Management List <linux-pm@vger.kernel.org>, Broadcom Kernel List <bcm-kernel-feedback-list@broadcom.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Markus Mayer <mmayer@broadcom.com>

On Thu, Nov 3, 2016 at 9:46 PM, Markus Mayer <code@mmayer.net> wrote:
> From: Markus Mayer <mmayer@broadcom.com>
>
> Allow cpufreq statistics to be cleared by writing anything to
> /sys/.../cpufreq/stats/reset. Reading this new sysfs entry returns
> nothing.
>
> Resetting the statistics can be useful in a test environment (test
> governor, retrieve stats, reset stats, test other governor, etc.). This
> feature is not meant for production use.
>
> Signed-off-by: Markus Mayer <mmayer@broadcom.com>
> ---
>  drivers/cpufreq/Kconfig         | 10 ++++++++++
>  drivers/cpufreq/cpufreq_stats.c | 32 ++++++++++++++++++++++++++++++++
>  2 files changed, 42 insertions(+)
>
> diff --git a/drivers/cpufreq/Kconfig b/drivers/cpufreq/Kconfig
> index d8b164a..97a458e 100644
> --- a/drivers/cpufreq/Kconfig
> +++ b/drivers/cpufreq/Kconfig
> @@ -45,6 +45,16 @@ config CPU_FREQ_STAT_DETAILS
>
>           If in doubt, say N.
>
> +config CPU_FREQ_STAT_RESET
> +       bool "Allow reset of CPU frequency transition statistics"
> +       depends on CPU_FREQ_STAT
> +       help
> +         If enabled, writing to /sys/[...]/cpufreq/stats/reset will reset the
> +         current CPUfreq statistics. This is primarily meant for testing. It
> +         should not be enabled on a production system.
> +
> +         If in doubt, say N.
> +
>  choice
>         prompt "Default CPUFreq governor"
>         default CPU_FREQ_DEFAULT_GOV_USERSPACE if ARM_SA1100_CPUFREQ || ARM_SA1110_CPUFREQ
> diff --git a/drivers/cpufreq/cpufreq_stats.c b/drivers/cpufreq/cpufreq_stats.c
> index 06d3abd..e4e1e3e 100644
> --- a/drivers/cpufreq/cpufreq_stats.c
> +++ b/drivers/cpufreq/cpufreq_stats.c
> @@ -111,6 +111,35 @@ static ssize_t show_trans_table(struct cpufreq_policy *policy, char *buf)
>  cpufreq_freq_attr_ro(trans_table);
>  #endif
>
> +#ifdef CONFIG_CPU_FREQ_STAT_RESET
> +static void cpufreq_stats_clear_table(struct cpufreq_policy *policy)
> +{
> +       struct cpufreq_stats *stats = policy->stats;
> +       unsigned int count = stats->max_state;
> +
> +       memset(stats->time_in_state, 0, count * sizeof(u64));
> +#ifdef CONFIG_CPU_FREQ_STAT_DETAILS
> +       memset(stats->trans_table, 0, count * count * sizeof(int));
> +#endif
> +       stats->last_time = get_jiffies_64();
> +       stats->total_trans = 0;
> +}
> +
> +static ssize_t show_reset(struct cpufreq_policy *policy, char *buf)
> +{
> +       buf[0] = '\0';
> +       return 0;
> +}
> +
> +static ssize_t store_reset(struct cpufreq_policy *policy, const char *buf,
> +                          size_t count)
> +{
> +       cpufreq_stats_clear_table(policy);
> +       return count;
> +}
> +cpufreq_freq_attr_rw(reset);
> +#endif
> +
>  cpufreq_freq_attr_ro(total_trans);
>  cpufreq_freq_attr_ro(time_in_state);
>
> @@ -120,6 +149,9 @@ static struct attribute *default_attrs[] = {
>  #ifdef CONFIG_CPU_FREQ_STAT_DETAILS
>         &trans_table.attr,
>  #endif
> +#ifdef CONFIG_CPU_FREQ_STAT_RESET
> +       &reset.attr,
> +#endif
>         NULL
>  };
>  static struct attribute_group stats_attr_group = {
> --

What would be wrong with adding this unconditionally?

Thanks,
Rafael
