From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 2/2] cpufreq: ondemand: Drop unused callback from struct
 od_ops
Date: Wed, 17 Feb 2016 10:44:01 +0530
Message-ID: <20160217051401.GJ2454@vireshk-i7>
References: <76641630.CimCW8476L@vostro.rjw.lan>
 <2785243.lPbWKikLZB@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <2785243.lPbWKikLZB@vostro.rjw.lan>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Linux PM list <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On 16-02-16, 21:01, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> The ->freq_increase callback in struct od_ops is never invoked,
> so drop it.
> 
> No functional changes.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
>  drivers/cpufreq/cpufreq_governor.h |    1 -
>  drivers/cpufreq/cpufreq_ondemand.c |    1 -
>  2 files changed, 2 deletions(-)
> 
> Index: linux-pm/drivers/cpufreq/cpufreq_ondemand.c
> ===================================================================
> --- linux-pm.orig/drivers/cpufreq/cpufreq_ondemand.c
> +++ linux-pm/drivers/cpufreq/cpufreq_ondemand.c
> @@ -417,7 +417,6 @@ define_get_cpu_dbs_routines(od_cpu_dbs_i
>  static struct od_ops od_ops = {
>  	.powersave_bias_init_cpu = ondemand_powersave_bias_init_cpu,
>  	.powersave_bias_target = generic_powersave_bias_target,
> -	.freq_increase = dbs_freq_increase,
>  };
>  
>  static struct dbs_governor od_dbs_gov = {
> Index: linux-pm/drivers/cpufreq/cpufreq_governor.h
> ===================================================================
> --- linux-pm.orig/drivers/cpufreq/cpufreq_governor.h
> +++ linux-pm/drivers/cpufreq/cpufreq_governor.h
> @@ -220,7 +220,6 @@ struct od_ops {
>  	void (*powersave_bias_init_cpu)(int cpu);
>  	unsigned int (*powersave_bias_target)(struct cpufreq_policy *policy,
>  			unsigned int freq_next, unsigned int relation);
> -	void (*freq_increase)(struct cpufreq_policy *policy, unsigned int freq);
>  };
>  
>  extern struct mutex dbs_data_mutex;

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
