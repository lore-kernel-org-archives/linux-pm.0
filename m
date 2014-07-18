From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH V1 Resend 1/4] cpufreq: move policy kobj to policy->cpu at resume
Date: Fri, 18 Jul 2014 02:57:03 +0200
Message-ID: <1667182.nUyuo0gHhu@vostro.rjw.lan>
References: <cover.1405573982.git.viresh.kumar@linaro.org> <568e1bd8a6e3e5eff48e84a0d142464a35c09694.1405573982.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <568e1bd8a6e3e5eff48e84a0d142464a35c09694.1405573982.git.viresh.kumar@linaro.org>
Sender: stable-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, arvind.chauhan@arm.com, srivatsa@mit.edu, skannan@codeaurora.org, ybu@qti.qualcomm.com, stable@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Thursday, July 17, 2014 10:48:25 AM Viresh Kumar wrote:
> This is only relevant to implementations with multiple clusters, where clusters
> have separate clock lines but all CPUs within a cluster share it.
> 
> Consider a dual cluster platform with 2 cores per cluster. During suspend we
> start hot unplugging CPUs in order 1 to 3. When CPU2 is removed, policy->kobj
> would be moved to CPU3 and when CPU3 goes down we wouldn't free policy or its
> kobj as we want to retain permissions/values/etc.
> 
> Now on resume, we will get CPU2 before CPU3 and will call __cpufreq_add_dev().
> We will recover the old policy and update policy->cpu from 3 to 2 from
> update_policy_cpu().
> 
> But the kobj is still tied to CPU3 and isn't moved to CPU2. We wouldn't create a
> link for CPU2, but would try that for CPU3 while bringing it online. Which will
> report errors as CPU3 already has kobj assigned to it.
> 
> This bug got introduced with commit 42f921a, which overlooked this scenario.
> 
> To fix this, lets move kobj to the new policy->cpu while bringing first CPU of a
> cluster back. Also do a WARN_ON() if kobject_move failed, as we would reach here
> only for the first CPU of a non-boot cluster. And we can't recover from this
> situation, if kobject_move() fails.
> 
> Fixes: ("42f921a cpufreq: remove sysfs files for CPUs which failed to come back after resume")
> Cc: stable@vger.kernel.org # 3.13+
> Reported-by: Bu Yitian <ybu@qti.qualcomm.com>
> Reported-by: Saravana Kannan <skannan@codeaurora.org>
> Tested-by: Bu Yitian <ybu@qti.qualcomm.com>
> Reviewed-by: Srivatsa S. Bhat <srivatsa@mit.edu>
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>

Applied, thanks!  The rest is on my todo list.

> ---
>  drivers/cpufreq/cpufreq.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> index 62259d2..6f02485 100644
> --- a/drivers/cpufreq/cpufreq.c
> +++ b/drivers/cpufreq/cpufreq.c
> @@ -1153,10 +1153,12 @@ static int __cpufreq_add_dev(struct device *dev, struct subsys_interface *sif)
>  	 * the creation of a brand new one. So we need to perform this update
>  	 * by invoking update_policy_cpu().
>  	 */
> -	if (recover_policy && cpu != policy->cpu)
> +	if (recover_policy && cpu != policy->cpu) {
>  		update_policy_cpu(policy, cpu);
> -	else
> +		WARN_ON(kobject_move(&policy->kobj, &dev->kobj));
> +	} else {
>  		policy->cpu = cpu;
> +	}
>  
>  	cpumask_copy(policy->cpus, cpumask_of(cpu));
>  
> 

-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
