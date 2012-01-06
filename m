From: mark gross <markgross@thegnar.org>
Subject: Re: [PATCH 5/6] cpufreq: Enforce PM QoS min/max limits
Date: Fri, 6 Jan 2012 07:38:03 -0800
Message-ID: <20120106153802.GG12530@mgross-G62>
References: <1325810186-28986-1-git-send-email-amiettinen@nvidia.com>
	<1325810186-28986-6-git-send-email-amiettinen@nvidia.com>
Reply-To: markgross@thegnar.org
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1325810186-28986-6-git-send-email-amiettinen@nvidia.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/linux-pm/>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Antti P Miettinen <amiettinen@nvidia.com>
Cc: linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Fri, Jan 06, 2012 at 02:36:25AM +0200, Antti P Miettinen wrote:
> Observe PM QoS CPU frequency minimum and maximum in addition
> to policy settings.
> 
> Signed-off-by: Antti P Miettinen <amiettinen@nvidia.com>
> ---
>  drivers/cpufreq/cpufreq.c |   49 +++++++++++++++++++++++++++++++++++++++++++-
>  1 files changed, 47 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> index 65a512b..cd90cd2b 100644
> --- a/drivers/cpufreq/cpufreq.c
> +++ b/drivers/cpufreq/cpufreq.c
> @@ -29,6 +29,7 @@
>  #include <linux/completion.h>
>  #include <linux/mutex.h>
>  #include <linux/syscore_ops.h>
> +#include <linux/pm_qos.h>
>  
>  #include <trace/events/power.h>
>  
> @@ -1634,9 +1635,17 @@ static int __cpufreq_set_policy(struct cpufreq_policy *data,
>  				struct cpufreq_policy *policy)
>  {
>  	int ret = 0;
> +	unsigned int pmin = policy->min;
> +	unsigned int pmax = policy->max;
> +	unsigned int qmin = pm_qos_request(PM_QOS_CPU_FREQ_MIN);
> +	unsigned int qmax = pm_qos_request(PM_QOS_CPU_FREQ_MAX);
no max please.

>  
> -	pr_debug("setting new policy for CPU %u: %u - %u kHz\n", policy->cpu,
> -		policy->min, policy->max);
> +	pr_debug("setting new policy for CPU %u: %u - %u (%u - %u) kHz\n",
> +		 policy->cpu, pmin, pmax, qmin, qmax);
> +
> +	/* clamp the new policy to PM QoS limits */
> +	policy->min = max(pmin, qmin);
> +	policy->max = min(pmax, qmax);
>  
>  	memcpy(&policy->cpuinfo, &data->cpuinfo,
>  				sizeof(struct cpufreq_cpuinfo));
> @@ -1711,6 +1720,9 @@ static int __cpufreq_set_policy(struct cpufreq_policy *data,
>  	}
>  
>  error_out:
> +	/* restore the limits that the policy requested */
> +	policy->min = pmin;
> +	policy->max = pmax;
>  	return ret;
>  }
> 


FWIW the following is the part I had not finished in my version of your
patch set.  I'll send my version in a reply after I finish my review of
your code.  Maybe we can consolidate yours and mine?

--mark

> @@ -1904,9 +1916,36 @@ int cpufreq_unregister_driver(struct cpufreq_driver *driver)
>  }
>  EXPORT_SYMBOL_GPL(cpufreq_unregister_driver);
>  
> +static int cpu_freq_notify(struct notifier_block *b,
> +			   unsigned long l, void *v);
> +
> +static struct notifier_block min_freq_notifier = {
> +	.notifier_call = cpu_freq_notify,
> +};
> +static struct notifier_block max_freq_notifier = {
> +	.notifier_call = cpu_freq_notify,
> +};
> +
> +static int cpu_freq_notify(struct notifier_block *b,
> +			   unsigned long l, void *v)
> +{
> +	int cpu;
> +	pr_debug("PM QoS %s %lu\n",
> +		 b == &min_freq_notifier ? "min" : "max", l);
> +	for_each_online_cpu(cpu) {
> +		struct cpufreq_policy *policy = cpufreq_cpu_get(cpu);
> +		if (policy) {
> +			cpufreq_update_policy(policy->cpu);
> +			cpufreq_cpu_put(policy);
> +		}
> +	}
> +	return NOTIFY_OK;
> +}
> +
>  static int __init cpufreq_core_init(void)
>  {
>  	int cpu;
> +	int rc;
>  
>  	for_each_possible_cpu(cpu) {
>  		per_cpu(cpufreq_policy_cpu, cpu) = -1;
> @@ -1916,6 +1955,12 @@ static int __init cpufreq_core_init(void)
>  	cpufreq_global_kobject = kobject_create_and_add("cpufreq", &cpu_subsys.dev_root->kobj);
>  	BUG_ON(!cpufreq_global_kobject);
>  	register_syscore_ops(&cpufreq_syscore_ops);
> +	rc = pm_qos_add_notifier(PM_QOS_CPU_FREQ_MIN,
> +				 &min_freq_notifier);
> +	BUG_ON(rc);
> +	rc = pm_qos_add_notifier(PM_QOS_CPU_FREQ_MAX,
> +				 &max_freq_notifier);
> +	BUG_ON(rc);
>  
>  	return 0;
>  }
> -- 
> 1.7.4.1
> 
> _______________________________________________
> linux-pm mailing list
> linux-pm@lists.linux-foundation.org
> https://lists.linuxfoundation.org/mailman/listinfo/linux-pm
