From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH V2 07/14] cpufreq: stats: remove cpufreq_stats_update_policy_cpu()
Date: Sat, 03 Jan 2015 23:25:02 +0100
Message-ID: <2616922.JoeBe3VJ9b@vostro.rjw.lan>
References: <cover.1420177186.git.viresh.kumar@linaro.org> <53e8e4e9a40d2759ebdecfe4649f9ecee112a330.1420177186.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:53092 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1752576AbbACWCu (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sat, 3 Jan 2015 17:02:50 -0500
In-Reply-To: <53e8e4e9a40d2759ebdecfe4649f9ecee112a330.1420177186.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, prarit@redhat.com, skannan@codeaurora.org

On Friday, January 02, 2015 11:16:44 AM Viresh Kumar wrote:
> cpufreq_stats_update_policy_cpu() doesn't do any useful stuff anymore and must
> be removed.

Well, "can be" sounds more appropriate than "must be".  It wouldn't hurt to
leave it as is, after all.

> Along with it, also remove 'cpu' field from 'struct cpufreq_stats'
> as that isn't used as well.

It's the reverse.  Because the cpu field is not necessary any more, it can
be dropped *along* *with* cpufreq_stats_update_policy_cpu().

Modifying data structures is more important than dropping a trivial function
and it should be described this way in the changelog.


> Reviewed-by: Prarit Bhargava <prarit@redhat.com>
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
>  drivers/cpufreq/cpufreq_stats.c | 14 --------------
>  1 file changed, 14 deletions(-)
> 
> diff --git a/drivers/cpufreq/cpufreq_stats.c b/drivers/cpufreq/cpufreq_stats.c
> index 106c89ccef30..f458fdbc5bfd 100644
> --- a/drivers/cpufreq/cpufreq_stats.c
> +++ b/drivers/cpufreq/cpufreq_stats.c
> @@ -18,7 +18,6 @@
>  static spinlock_t cpufreq_stats_lock;
>  
>  struct cpufreq_stats {
> -	unsigned int cpu;
>  	unsigned int total_trans;
>  	unsigned long long last_time;
>  	unsigned int max_state;
> @@ -194,7 +193,6 @@ static int __cpufreq_stats_create_table(struct cpufreq_policy *policy)
>  	if (ret)
>  		goto error_out;
>  
> -	stat->cpu = cpu;
>  	policy->stats_data = stat;
>  
>  	cpufreq_for_each_valid_entry(pos, table)
> @@ -251,24 +249,12 @@ static void cpufreq_stats_create_table(unsigned int cpu)
>  	cpufreq_cpu_put(policy);
>  }
>  
> -static void cpufreq_stats_update_policy_cpu(struct cpufreq_policy *policy)
> -{
> -	struct cpufreq_stats *stat = policy->stats_data;
> -
> -	stat->cpu = policy->cpu;

Well, if you wrote it the way I suggested in the previous patch, it would be
more obvious ...

> -}
> -
>  static int cpufreq_stat_notifier_policy(struct notifier_block *nb,
>  		unsigned long val, void *data)
>  {
>  	int ret = 0;
>  	struct cpufreq_policy *policy = data;
>  
> -	if (val == CPUFREQ_UPDATE_POLICY_CPU) {
> -		cpufreq_stats_update_policy_cpu(policy);
> -		return 0;
> -	}
> -
>  	if (val == CPUFREQ_CREATE_POLICY)
>  		ret = __cpufreq_stats_create_table(policy);
>  	else if (val == CPUFREQ_REMOVE_POLICY)
> 

-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
