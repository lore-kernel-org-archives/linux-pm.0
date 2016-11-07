From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH v2 2/2] cpufreq: stats: clear statistics
Date: Mon, 7 Nov 2016 10:08:26 +0530
Message-ID: <20161107043826.GC21030@vireshk-i7>
References: <20161104165536.20088-1-code@mmayer.net>
 <20161104165536.20088-3-code@mmayer.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f174.google.com ([209.85.192.174]:35472 "EHLO
        mail-pf0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751187AbcKGEia (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 6 Nov 2016 23:38:30 -0500
Received: by mail-pf0-f174.google.com with SMTP id i88so84309928pfk.2
        for <linux-pm@vger.kernel.org>; Sun, 06 Nov 2016 20:38:30 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20161104165536.20088-3-code@mmayer.net>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Markus Mayer <code@mmayer.net>
Cc: "Rafael J . Wysocki" <rjw@rjwysocki.net>, Power Management List <linux-pm@vger.kernel.org>, Broadcom Kernel List <bcm-kernel-feedback-list@broadcom.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Markus Mayer <mmayer@broadcom.com>

On 04-11-16, 09:55, Markus Mayer wrote:
> From: Markus Mayer <mmayer@broadcom.com>
> 
> Allow CPUfreq statistics to be cleared by writing anything to
> /sys/.../cpufreq/stats/reset.
> 
> Signed-off-by: Markus Mayer <mmayer@broadcom.com>
> ---
>  Documentation/cpu-freq/cpufreq-stats.txt |  6 ++++++
>  drivers/cpufreq/cpufreq_stats.c          | 22 ++++++++++++++++++++++
>  2 files changed, 28 insertions(+)
> 
> diff --git a/Documentation/cpu-freq/cpufreq-stats.txt b/Documentation/cpu-freq/cpufreq-stats.txt
> index 8d9773f..3c355f6 100644
> --- a/Documentation/cpu-freq/cpufreq-stats.txt
> +++ b/Documentation/cpu-freq/cpufreq-stats.txt
> @@ -44,11 +44,17 @@ the stats driver insertion.
>  total 0
>  drwxr-xr-x  2 root root    0 May 14 16:06 .
>  drwxr-xr-x  3 root root    0 May 14 15:58 ..
> +--w-------  1 root root 4096 May 14 16:06 reset
>  -r--r--r--  1 root root 4096 May 14 16:06 time_in_state
>  -r--r--r--  1 root root 4096 May 14 16:06 total_trans
>  -r--r--r--  1 root root 4096 May 14 16:06 trans_table
>  --------------------------------------------------------------------------------
>  
> +-  reset
> +Write-only attribute that can be used to reset the stat counters. This can be
> +useful for evaluating system behaviour under different governors without the
> +need for a reboot.
> +
>  -  time_in_state
>  This gives the amount of time spent in each of the frequencies supported by
>  this CPU. The cat output will have "<frequency> <time>" pair in each line, which
> diff --git a/drivers/cpufreq/cpufreq_stats.c b/drivers/cpufreq/cpufreq_stats.c
> index 06d3abd..66419e6 100644
> --- a/drivers/cpufreq/cpufreq_stats.c
> +++ b/drivers/cpufreq/cpufreq_stats.c
> @@ -41,6 +41,18 @@ static int cpufreq_stats_update(struct cpufreq_stats *stats)
>  	return 0;
>  }
>  
> +static void cpufreq_stats_clear_table(struct cpufreq_stats *stats)
> +{
> +	unsigned int count = stats->max_state;
> +
> +	memset(stats->time_in_state, 0, count * sizeof(u64));
> +#ifdef CONFIG_CPU_FREQ_STAT_DETAILS
> +	memset(stats->trans_table, 0, count * count * sizeof(int));
> +#endif
> +	stats->last_time = get_jiffies_64();
> +	stats->total_trans = 0;
> +}
> +
>  static ssize_t show_total_trans(struct cpufreq_policy *policy, char *buf)
>  {
>  	return sprintf(buf, "%d\n", policy->stats->total_trans);
> @@ -64,6 +76,14 @@ static ssize_t show_time_in_state(struct cpufreq_policy *policy, char *buf)
>  	return len;
>  }
>  
> +static ssize_t store_reset(struct cpufreq_policy *policy, const char *buf,
> +			   size_t count)
> +{
> +	/* We don't care what is written to the attribute. */
> +	cpufreq_stats_clear_table(policy->stats);
> +	return count;
> +}
> +
>  #ifdef CONFIG_CPU_FREQ_STAT_DETAILS
>  static ssize_t show_trans_table(struct cpufreq_policy *policy, char *buf)
>  {
> @@ -113,10 +133,12 @@ cpufreq_freq_attr_ro(trans_table);
>  
>  cpufreq_freq_attr_ro(total_trans);
>  cpufreq_freq_attr_ro(time_in_state);
> +cpufreq_freq_attr_wr_perm(reset, 0200);

Just drop the perm argument and this patch looks fine as well.

-- 
viresh
