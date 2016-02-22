From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 2/2] cpufreq: governor: Make gov_set_update_util() static
Date: Mon, 22 Feb 2016 10:54:15 +0530
Message-ID: <20160222052415.GC28226@vireshk-i7>
References: <2410542.x6e5Rli2VY@vostro.rjw.lan>
 <1513735.63Kc3ciBeA@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1513735.63Kc3ciBeA@vostro.rjw.lan>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Linux PM list <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On 21-02-16, 03:15, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> The gov_set_update_util() routine is only used internally by the
> common governor code and it doesn't need to be exported, so make
> it static.
> 
> No functional changes.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
>  drivers/cpufreq/cpufreq_governor.c |    5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
> 
> Index: linux-pm/drivers/cpufreq/cpufreq_governor.c
> ===================================================================
> --- linux-pm.orig/drivers/cpufreq/cpufreq_governor.c
> +++ linux-pm/drivers/cpufreq/cpufreq_governor.c
> @@ -261,8 +261,8 @@ unsigned int dbs_update(struct cpufreq_p
>  }
>  EXPORT_SYMBOL_GPL(dbs_update);
>  
> -void gov_set_update_util(struct policy_dbs_info *policy_dbs,
> -			 unsigned int delay_us)
> +static void gov_set_update_util(struct policy_dbs_info *policy_dbs,
> +				unsigned int delay_us)
>  {
>  	struct cpufreq_policy *policy = policy_dbs->policy;
>  	int cpu;
> @@ -276,7 +276,6 @@ void gov_set_update_util(struct policy_d
>  		cpufreq_set_update_util_data(cpu, &cdbs->update_util);
>  	}
>  }
> -EXPORT_SYMBOL_GPL(gov_set_update_util);
>  
>  static inline void gov_clear_update_util(struct cpufreq_policy *policy)
>  {

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
