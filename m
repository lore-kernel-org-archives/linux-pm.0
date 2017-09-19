From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH] cpufreq: cpufreq_stats: make last_index signed int
Date: Tue, 19 Sep 2017 11:54:47 -0700
Message-ID: <20170919185447.GC30848@ubuntu>
References: <1505506402-11497-1-git-send-email-byan@nvidia.com>
 <20170918015017.GC17030@ubuntu>
 <961bce0a-5162-5e8d-3474-5b2161cf92c4@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <961bce0a-5162-5e8d-3474-5b2161cf92c4@nvidia.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Bo Yan <byan@nvidia.com>
Cc: rjw@rjwysocki.net, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On 18-09-17, 10:39, Bo Yan wrote:
> Currently, the "last_index" is being checked before
> cpufreq_stats_update(stats) inside function
> "cpufreq_stats_record_transition", so it's taken care of.
> 
> However, the function "show_time_in_state" also calls cpufreq_stats_update,
> the similar check should be done there too, like this:

Yeah, that's what I suggested.

> diff --git a/drivers/cpufreq/cpufreq_stats.c
> b/drivers/cpufreq/cpufreq_stats.c
> index e75880eb037d..15305b5ec322 100644
> --- a/drivers/cpufreq/cpufreq_stats.c
> +++ b/drivers/cpufreq/cpufreq_stats.c
> @@ -62,7 +62,8 @@ static ssize_t show_time_in_state(struct cpufreq_policy
> *policy, char *buf)
>         if (policy->fast_switch_enabled)
>                 return 0;
> 
> -       cpufreq_stats_update(stats);
> +       if ((int)stats->last_index >= 0)

You can rather do:

        if (stats->last_index != -1)

> +               cpufreq_stats_update(stats);
>         for (i = 0; i < stats->state_num; i++) {
>                 len += sprintf(buf + len, "%u %llu\n", stats->freq_table[i],
>                         (unsigned long long)
> 
> 
> This is only needed when policy->cur is not in frequency table when stats
> table is created, in which case, stats->last_index will get -1, then user
> does a "cat time_in_state" before any frequency transition.
> 
> Does this make sense?

-- 
viresh
