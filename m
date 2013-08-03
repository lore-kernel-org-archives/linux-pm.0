From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH 08/10] cpufreq: Fix broken usage of governor->owner's refcount
Date: Sat, 03 Aug 2013 14:08:18 +0200
Message-ID: <4846602.3FgvAM66Ta@vostro.rjw.lan>
References: <cover.1375530162.git.viresh.kumar@linaro.org> <46faea4c060f91f7102d9d33c816693acc25a917.1375530162.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <cpufreq-owner@vger.kernel.org>
In-Reply-To: <46faea4c060f91f7102d9d33c816693acc25a917.1375530162.git.viresh.kumar@linaro.org>
Sender: cpufreq-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: linaro-kernel@lists.linaro.org, patches@linaro.org, cpufreq@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, srivatsa.bhat@linux.vnet.ibm.com, l.majewski@samsung.com
List-Id: linux-pm@vger.kernel.org

On Saturday, August 03, 2013 05:19:26 PM Viresh Kumar wrote:
> Governor's owner refcount usage was broken. We should increment refcount only
> when CPUFREQ_GOV_POLICY_INIT event has come and should decrement only if
> CPUFREQ_GOV_POLICY_EXIT has come.
> 
> Lets fix it.

OK, and what happens if we don't fix it?

Rafael


> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
>  drivers/cpufreq/cpufreq.c | 14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> index e9b969f..74d4969 100644
> --- a/drivers/cpufreq/cpufreq.c
> +++ b/drivers/cpufreq/cpufreq.c
> @@ -1707,8 +1707,9 @@ static int __cpufreq_governor(struct cpufreq_policy *policy,
>  		}
>  	}
>  
> -	if (!try_module_get(policy->governor->owner))
> -		return -EINVAL;
> +	if (event == CPUFREQ_GOV_POLICY_INIT)
> +		if (!try_module_get(policy->governor->owner))
> +			return -EINVAL;
>  
>  	pr_debug("__cpufreq_governor for CPU %u, event %u\n",
>  						policy->cpu, event);
> @@ -1717,6 +1718,8 @@ static int __cpufreq_governor(struct cpufreq_policy *policy,
>  	if ((!policy->governor_enabled && (event == CPUFREQ_GOV_STOP)) ||
>  	    (policy->governor_enabled && (event == CPUFREQ_GOV_START))) {
>  		mutex_unlock(&cpufreq_governor_lock);
> +		if (event == CPUFREQ_GOV_POLICY_INIT)
> +			module_put(policy->governor->owner);
>  		return -EBUSY;
>  	}
>  
> @@ -1744,11 +1747,8 @@ static int __cpufreq_governor(struct cpufreq_policy *policy,
>  		mutex_unlock(&cpufreq_governor_lock);
>  	}
>  
> -	/* we keep one module reference alive for
> -			each CPU governed by this CPU */
> -	if ((event != CPUFREQ_GOV_START) || ret)
> -		module_put(policy->governor->owner);
> -	if ((event == CPUFREQ_GOV_STOP) && !ret)
> +	if (((event == CPUFREQ_GOV_POLICY_INIT) && ret) ||
> +			((event == CPUFREQ_GOV_POLICY_EXIT) && !ret))
>  		module_put(policy->governor->owner);
>  
>  	return ret;
> 
-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
