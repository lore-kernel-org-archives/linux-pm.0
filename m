From: "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>
Subject: Re: [PATCH 3/3] cpufreq: Don't use cpu removed during cpufreq_driver_unregister
Date: Thu, 03 Jan 2013 19:55:54 +0530
Message-ID: <50E594F2.4000800@linux.vnet.ibm.com>
References: <98330b2deb910453a356404b8cf774c94326bc42.1355636864.git.viresh.kumar@linaro.org> <1fe21314c2e17585e22c546e2cac12544f8f9733.1355636864.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <cpufreq-owner@vger.kernel.org>
In-Reply-To: <1fe21314c2e17585e22c546e2cac12544f8f9733.1355636864.git.viresh.kumar@linaro.org>
Sender: cpufreq-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: rjw@sisk.pl, rafael.j.wysocki@intel.com, linaro-dev@lists.linaro.org, nicolas.pitre@linaro.org, amit.kucheria@linaro.org, mathieu.poirier@linaro.org, linux-kernel@vger.kernel.org, cpufreq@vger.kernel.org, pdsw-power-team@arm.com, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Hi Viresh,

On 12/16/2012 11:20 AM, Viresh Kumar wrote:
> This is how the core works:
> cpufreq_driver_unregister()
>  - subsys_interface_unregister()
>    - for_each_cpu() call cpufreq_remove_dev(), i.e. 0,1,2,3,4 when we
>      unregister.
> 
> cpufreq_remove_dev():
>  - Remove policy node
>  - Call cpufreq_add_dev() for next cpu, sharing mask with removed cpu.
>    i.e. When cpu 0 is removed, we call it for cpu 1. And when called for cpu 2,
>    we call it for cpu 3.
>    - cpufreq_add_dev() would call cpufreq_driver->init()
>    - init would return mask as AND of 2, 3 and 4 for cluster A7.
>    - cpufreq core would do online_cpu && policy->cpus
>      Here is the BUG(). Because cpu hasn't died but we have just unregistered
>      the cpufreq driver, online cpu would still have cpu 2 in it. And so thing
>      go bad again.
> 
> Solution: Keep cpumask of cpus that are registered with cpufreq core and clear
> 	  cpus when we get a call from subsys_interface_unregister() via
> 	  cpufreq_remove_dev().
> 

I took a quick look at the problem you described above, and the cpufreq code..
If we cannot avoid calling cpufreq_add_dev() from cpufreq_remove_dev(), then I can't
think of anything better than what your patch does.

BTW, off-topic, while going through that path, I think I found a memory leak
in __cpufreq_remove_dev():

        if (unlikely(cpumask_weight(data->cpus) > 1)) {
                for_each_cpu(j, data->cpus) {
                        if (j == cpu) 
                                continue;
                        per_cpu(cpufreq_cpu_data, j) = NULL;
                }
        }

We are assigning NULL without freeing that memory.


Regards,
Srivatsa S. Bhat

> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
>  drivers/cpufreq/cpufreq.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> index a0a33bd..271d3be 100644
> --- a/drivers/cpufreq/cpufreq.c
> +++ b/drivers/cpufreq/cpufreq.c
> @@ -47,6 +47,9 @@ static DEFINE_PER_CPU(char[CPUFREQ_NAME_LEN], cpufreq_cpu_governor);
>  #endif
>  static DEFINE_SPINLOCK(cpufreq_driver_lock);
> 
> +/* Used when we unregister cpufreq driver */
> +struct cpumask	cpufreq_online_mask;
> +
>  /*
>   * cpu_policy_rwsem is a per CPU reader-writer semaphore designed to cure
>   * all cpufreq/hotplug/workqueue/etc related lock issues.
> @@ -981,6 +984,7 @@ static int cpufreq_add_dev(struct device *dev, struct subsys_interface *sif)
>  	 * managing offline cpus here.
>  	 */
>  	cpumask_and(policy->cpus, policy->cpus, cpu_online_mask);
> +	cpumask_and(policy->cpus, policy->cpus, &cpufreq_online_mask);
> 
>  	policy->user_policy.min = policy->min;
>  	policy->user_policy.max = policy->max;
> @@ -1064,7 +1068,6 @@ static int __cpufreq_remove_dev(struct device *dev, struct subsys_interface *sif
>  	}
>  	per_cpu(cpufreq_cpu_data, cpu) = NULL;
> 
> -
>  #ifdef CONFIG_SMP
>  	/* if this isn't the CPU which is the parent of the kobj, we
>  	 * only need to unlink, put and exit
> @@ -1185,6 +1188,7 @@ static int cpufreq_remove_dev(struct device *dev, struct subsys_interface *sif)
>  	if (unlikely(lock_policy_rwsem_write(cpu)))
>  		BUG();
> 
> +	cpumask_clear_cpu(cpu, &cpufreq_online_mask);
>  	retval = __cpufreq_remove_dev(dev, sif);
>  	return retval;
>  }
> @@ -1903,6 +1907,8 @@ int cpufreq_register_driver(struct cpufreq_driver *driver_data)
>  	cpufreq_driver = driver_data;
>  	spin_unlock_irqrestore(&cpufreq_driver_lock, flags);
> 
> +	cpumask_setall(&cpufreq_online_mask);
> +
>  	ret = subsys_interface_register(&cpufreq_interface);
>  	if (ret)
>  		goto err_null_driver;
> 

