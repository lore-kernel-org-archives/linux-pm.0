From: "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>
Subject: Re: [PATCH] cpufreq: Fix crash in cpufreq-stats during suspend/resume
Date: Thu, 12 Sep 2013 01:46:27 +0530
Message-ID: <5230CF9B.9090509@linux.vnet.ibm.com>
References: <20130911201128.7749.61727.stgit@srivatsabhat.in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20130911201128.7749.61727.stgit@srivatsabhat.in.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: rjw@sisk.pl, swarren@wwwdotorg.org, viresh.kumar@linaro.org
Cc: "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>, cpufreq@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On 09/12/2013 01:41 AM, Srivatsa S. Bhat wrote:
> Stephen Warren reported that the cpufreq-stats code hits a NULL pointer
> dereference during the second attempt to suspend a system. He also
> pin-pointed the problem to commit 5302c3f "cpufreq: Perform light-weight
> init/teardown during suspend/resume".
> 
> That commit actually ensured that the cpufreq-stats table and the
> cpufreq-stats sysfs entries are *not* torn down (ie., not freed) during
> suspend/resume, which makes it all the more surprising. However, it turns
> out that the root-cause is not that we access an already freed memory, but
> that the reference to the allocated memory gets moved around and we lose
> track of that during resume, leading to the reported crash in a subsequent
> suspend attempt.
> 
> In the suspend path, during CPU offline, the value of policy->cpu is updated
> by choosing one of the surviving CPUs in that policy, as long as there is
> atleast one CPU in that policy. And cpufreq_stats_update_policy_cpu() is
> invoked to update the reference to the stats structure by assigning it to
> the new CPU. However, in the resume path, during CPU online, we end up
> assigning a fresh CPU as the policy->cpu, without letting cpufreq-stats
> know about this. Thus the reference to the stats structure remains
> (incorrectly) associated with the old CPU. So, in a subsequent suspend attempt,
> during CPU offline, we end up accessing an incorrect location to get the
> stats structure, which eventually leads to the NULL pointer dereference.
> 
> Fix this by letting cpufreq-stats know about the update of the policy->cpu
> during CPU online in the resume path. (Also, move the update_policy_cpu()
> function higher up in the file, so that __cpufreq_add_dev() can invoke
> it).
> 
> Reported-by: Stephen Warren <swarren@nvidia.com>
> Signed-off-by: Srivatsa S. Bhat <srivatsa.bhat@linux.vnet.ibm.com>
> Tested-by: Stephen Warren <swarren@nvidia.com>
> ---

Sorry, please ignore this one. I had intended to send 3 patches as a series,
but by mistake I ended up sending just one. I have sent the full series
(3 patches) separately, please consider that posting.

Regards,
Srivatsa S. Bhat

> 
>  drivers/cpufreq/cpufreq.c |   37 ++++++++++++++++++++++++-------------
>  1 file changed, 24 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> index 5a64f66..62bdb95 100644
> --- a/drivers/cpufreq/cpufreq.c
> +++ b/drivers/cpufreq/cpufreq.c
> @@ -947,6 +947,18 @@ static void cpufreq_policy_free(struct cpufreq_policy *policy)
>  	kfree(policy);
>  }
> 
> +static void update_policy_cpu(struct cpufreq_policy *policy, unsigned int cpu)
> +{
> +	policy->last_cpu = policy->cpu;
> +	policy->cpu = cpu;
> +
> +#ifdef CONFIG_CPU_FREQ_TABLE
> +	cpufreq_frequency_table_update_policy_cpu(policy);
> +#endif
> +	blocking_notifier_call_chain(&cpufreq_policy_notifier_list,
> +			CPUFREQ_UPDATE_POLICY_CPU, policy);
> +}
> +
>  static int __cpufreq_add_dev(struct device *dev, struct subsys_interface *sif,
>  			     bool frozen)
>  {
> @@ -1000,7 +1012,18 @@ static int __cpufreq_add_dev(struct device *dev, struct subsys_interface *sif,
>  	if (!policy)
>  		goto nomem_out;
> 
> -	policy->cpu = cpu;
> +
> +	/*
> +	 * In the resume path, since we restore a saved policy, the assignment
> +	 * to policy->cpu is like an update of the existing policy, rather than
> +	 * the creation of a brand new one. So we need to perform this update
> +	 * by invoking update_policy_cpu().
> +	 */
> +	if (frozen && cpu != policy->cpu)
> +		update_policy_cpu(policy, cpu);
> +	else
> +		policy->cpu = cpu;
> +
>  	policy->governor = CPUFREQ_DEFAULT_GOVERNOR;
>  	cpumask_copy(policy->cpus, cpumask_of(cpu));
> 
> @@ -1092,18 +1115,6 @@ static int cpufreq_add_dev(struct device *dev, struct subsys_interface *sif)
>  	return __cpufreq_add_dev(dev, sif, false);
>  }
> 
> -static void update_policy_cpu(struct cpufreq_policy *policy, unsigned int cpu)
> -{
> -	policy->last_cpu = policy->cpu;
> -	policy->cpu = cpu;
> -
> -#ifdef CONFIG_CPU_FREQ_TABLE
> -	cpufreq_frequency_table_update_policy_cpu(policy);
> -#endif
> -	blocking_notifier_call_chain(&cpufreq_policy_notifier_list,
> -			CPUFREQ_UPDATE_POLICY_CPU, policy);
> -}
> -
>  static int cpufreq_nominate_new_policy_cpu(struct cpufreq_policy *policy,
>  					   unsigned int old_cpu, bool frozen)
>  {
> 
