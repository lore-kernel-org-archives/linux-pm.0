From: "Jon Medhurst (Tixy)" <tixy@linaro.org>
Subject: Re: [PATCH 2/2] cpufreq: Properly handle errors from
 cpufreq_init_policy()
Date: Wed, 08 Jul 2015 12:17:56 +0100
Message-ID: <1436354276.2844.20.camel@linaro.org>
References: <276debea91831d86c34079f6a40d773ce258a62c.1436348436.git.viresh.kumar@linaro.org>
	 <043703bd1914d52340653c3cc31207e505df6139.1436348436.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <043703bd1914d52340653c3cc31207e505df6139.1436348436.git.viresh.kumar@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, open list <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Wed, 2015-07-08 at 15:12 +0530, Viresh Kumar wrote:
> cpufreq_init_policy() can fail, and we don't do anything except a call
> to ->exit() on that. The policy should be freed if this happens.
> 
> Lets do it properly.
> 
> Reported-by: "Jon Medhurst (Tixy)" <tixy@linaro.org>
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---

I tried these patches without the earlier "cpufreq: Initialize the
governor again while restoring policy" patch.

The result is that the error when bringing a cpu online is with flagged
up with a kernel message:

  cpufreq: cpufreq_add_dev: Failed to initialize policy for cpu: 1 (-16)

and afterwards, the sysfs entries that I was poking and causing the
crash aren't present. So looks like this patch has done what we want,
and cleaned things up after an error. So...

Tested-by: Jon Medhurst <tixy@linaro.org>

Thanks for the prompt fix.

>  drivers/cpufreq/cpufreq.c | 20 +++++++++++---------
>  1 file changed, 11 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> index b7aac8eec525..006299214d2e 100644
> --- a/drivers/cpufreq/cpufreq.c
> +++ b/drivers/cpufreq/cpufreq.c
> @@ -1051,11 +1051,10 @@ static int cpufreq_add_dev_interface(struct cpufreq_policy *policy,
>  	return cpufreq_add_dev_symlink(policy);
>  }
>  
> -static void cpufreq_init_policy(struct cpufreq_policy *policy)
> +static int cpufreq_init_policy(struct cpufreq_policy *policy)
>  {
>  	struct cpufreq_governor *gov = NULL;
>  	struct cpufreq_policy new_policy;
> -	int ret = 0;
>  
>  	memcpy(&new_policy, policy, sizeof(*policy));
>  
> @@ -1074,12 +1073,7 @@ static void cpufreq_init_policy(struct cpufreq_policy *policy)
>  		cpufreq_parse_governor(gov->name, &new_policy.policy, NULL);
>  
>  	/* set default policy */
> -	ret = cpufreq_set_policy(policy, &new_policy);
> -	if (ret) {
> -		pr_debug("setting policy failed\n");
> -		if (cpufreq_driver->exit)
> -			cpufreq_driver->exit(policy);
> -	}
> +	return cpufreq_set_policy(policy, &new_policy);
>  }
>  
>  static int cpufreq_add_policy_cpu(struct cpufreq_policy *policy,
> @@ -1376,7 +1370,12 @@ static int cpufreq_add_dev(struct device *dev, struct subsys_interface *sif)
>  		write_unlock_irqrestore(&cpufreq_driver_lock, flags);
>  	}
>  
> -	cpufreq_init_policy(policy);
> +	ret = cpufreq_init_policy(policy);
> +	if (ret) {
> +		pr_err("%s: Failed to initialize policy for cpu: %d (%d)\n",
> +		       __func__, cpu, ret);
> +		goto out_remove_policy_notify;
> +	}
>  
>  	if (!recover_policy) {
>  		policy->user_policy.policy = policy->policy;
> @@ -1396,6 +1395,9 @@ static int cpufreq_add_dev(struct device *dev, struct subsys_interface *sif)
>  
>  	return 0;
>  
> +out_remove_policy_notify:
> +	/* cpufreq_policy_free() will notify based on this */
> +	recover_policy = true;
>  out_exit_policy:
>  	up_write(&policy->rwsem);
>  
