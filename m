From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH V2 4/9] cpufreq: governor: Drop __gov_queue_work()
Date: Tue, 08 Sep 2015 03:15:42 +0200
Message-ID: <288361840.gGA5ernLiT@vostro.rjw.lan>
References: <cover.1437999691.git.viresh.kumar@linaro.org> <4f7aef4f032e082a5093b91d244647f339ef6558.1437999691.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:59638 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751237AbbIHAry (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 7 Sep 2015 20:47:54 -0400
In-Reply-To: <4f7aef4f032e082a5093b91d244647f339ef6558.1437999691.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, preeti.lkml@gmail.com, open list <linux-kernel@vger.kernel.org>

On Monday, July 27, 2015 05:58:09 PM Viresh Kumar wrote:
> __gov_queue_work() isn't required anymore and can be merged with
> gov_queue_work(). Do it.
> 
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>

Quite frankly I don't see the point.

I'd even remove the inline from its definition and let the compiler decide
what to do with it.

> ---
>  drivers/cpufreq/cpufreq_governor.c | 17 ++++++-----------
>  1 file changed, 6 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/cpufreq/cpufreq_governor.c b/drivers/cpufreq/cpufreq_governor.c
> index a890450711bb..3ddc27764e10 100644
> --- a/drivers/cpufreq/cpufreq_governor.c
> +++ b/drivers/cpufreq/cpufreq_governor.c
> @@ -158,25 +158,20 @@ void dbs_check_cpu(struct dbs_data *dbs_data, int cpu)
>  }
>  EXPORT_SYMBOL_GPL(dbs_check_cpu);
>  
> -static inline void __gov_queue_work(int cpu, struct dbs_data *dbs_data,
> -		unsigned int delay)
> -{
> -	struct cpu_dbs_info *cdbs = dbs_data->cdata->get_cpu_cdbs(cpu);
> -
> -	mod_delayed_work_on(cpu, system_wq, &cdbs->dwork, delay);
> -}
> -
>  void gov_queue_work(struct dbs_data *dbs_data, struct cpufreq_policy *policy,
>  		    unsigned int delay, const struct cpumask *cpus)
>  {
> -	int i;
> +	struct cpu_dbs_info *cdbs;
> +	int cpu;
>  
>  	mutex_lock(&cpufreq_governor_lock);
>  	if (!policy->governor_enabled)
>  		goto out_unlock;
>  
> -	for_each_cpu(i, cpus)
> -		__gov_queue_work(i, dbs_data, delay);
> +	for_each_cpu(cpu, cpus) {
> +		cdbs = dbs_data->cdata->get_cpu_cdbs(cpu);
> +		mod_delayed_work_on(cpu, system_wq, &cdbs->dwork, delay);
> +	}
>  
>  out_unlock:
>  	mutex_unlock(&cpufreq_governor_lock);
> 

Thanks,
Rafael

