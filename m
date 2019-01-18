From: Matthias Kaehlcke <mka@chromium.org>
Subject: Re: [PATCH 2/3] cpufreq: Implement freq-constraint callback
Date: Thu, 17 Jan 2019 17:49:19 -0800
Message-ID: <20190118014919.GZ261387@google.com>
References: <cover.1547197612.git.viresh.kumar@linaro.org>
 <d6dad7a600a528665eaf309ab2182bc7b5e8060c.1547197612.git.viresh.kumar@linaro.org>
 <20190118014632.GY261387@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190118014632.GY261387@google.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-pm@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Thu, Jan 17, 2019 at 05:46:32PM -0800, Matthias Kaehlcke wrote:
> On Fri, Jan 11, 2019 at 02:48:35PM +0530, Viresh Kumar wrote:
> > This implements the frequency constraint callback and registers it with
> > the freq-constraint framework whenever a policy is created. On policy
> > removal the callback is unregistered.
> > 
> > The constraints are also taken into consideration in
> > cpufreq_set_policy().
> > 
> > No constraints are added until now though.
> 
> nit: 'for now'?
> 
> > Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> > ---
> >  drivers/cpufreq/Kconfig   |  1 +
> >  drivers/cpufreq/cpufreq.c | 44 ++++++++++++++++++++++++++++++++++++++++++++
> >  2 files changed, 45 insertions(+)
> > 
> > diff --git a/drivers/cpufreq/Kconfig b/drivers/cpufreq/Kconfig
> > index 608af20a3494..2c2842cf2734 100644
> > --- a/drivers/cpufreq/Kconfig
> > +++ b/drivers/cpufreq/Kconfig
> > @@ -2,6 +2,7 @@ menu "CPU Frequency scaling"
> >  
> >  config CPU_FREQ
> >  	bool "CPU Frequency scaling"
> > +	select DEVICE_FREQ_CONSTRAINT
> >  	select SRCU
> >  	help
> >  	  CPU Frequency scaling allows you to change the clock speed of 
> > diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> > index a8fa684f5f90..63028612d011 100644
> > --- a/drivers/cpufreq/cpufreq.c
> > +++ b/drivers/cpufreq/cpufreq.c
> > @@ -21,6 +21,7 @@
> >  #include <linux/cpufreq.h>
> >  #include <linux/delay.h>
> >  #include <linux/device.h>
> > +#include <linux/freq_constraint.h>
> >  #include <linux/init.h>
> >  #include <linux/kernel_stat.h>
> >  #include <linux/module.h>
> > @@ -1163,6 +1164,7 @@ static void cpufreq_policy_free(struct cpufreq_policy *policy)
> >  		per_cpu(cpufreq_cpu_data, cpu) = NULL;
> >  	write_unlock_irqrestore(&cpufreq_driver_lock, flags);
> >  
> > +	freq_constraint_remove_cpumask_callback(policy->related_cpus);
> >  	cpufreq_policy_put_kobj(policy);
> >  	free_cpumask_var(policy->real_cpus);
> >  	free_cpumask_var(policy->related_cpus);
> > @@ -1170,6 +1172,24 @@ static void cpufreq_policy_free(struct cpufreq_policy *policy)
> >  	kfree(policy);
> >  }
> >  
> > +static void freq_constraint_callback(void *param)
> > +{
> > +	struct cpufreq_policy *policy = param;
> > +	struct cpufreq_policy new_policy = *policy;
> > +
> > +	new_policy.min = policy->user_policy.min;
> > +	new_policy.max = policy->user_policy.max;
> > +
> > +	down_write(&policy->rwsem);
> > +	if (policy_is_inactive(policy))
> > +		goto unlock;
> > +
> > +	cpufreq_set_policy(policy, &new_policy);
> > +
> > +unlock:
> > +	up_write(&policy->rwsem);
> > +}
> > +
> >  static int cpufreq_online(unsigned int cpu)
> >  {
> >  	struct cpufreq_policy *policy;
> > @@ -1236,6 +1256,14 @@ static int cpufreq_online(unsigned int cpu)
> >  			per_cpu(cpufreq_cpu_data, j) = policy;
> >  			add_cpu_dev_symlink(policy, j);
> >  		}
> > +
> > +		ret = freq_constraint_set_cpumask_callback(policy->related_cpus,
> > +					freq_constraint_callback, policy);
> > +		if (ret) {
> > +			pr_err("Failed to set freq-constraints: %d (%*pbl)\n",
> > +			       ret, cpumask_pr_args(policy->cpus));
> > +			goto out_destroy_policy;
> > +		}
> >  	} else {
> >  		policy->min = policy->user_policy.min;
> >  		policy->max = policy->user_policy.max;
> > @@ -2198,6 +2226,8 @@ static int cpufreq_set_policy(struct cpufreq_policy *policy,
> >  				struct cpufreq_policy *new_policy)
> >  {
> >  	struct cpufreq_governor *old_gov;
> > +	struct device *cpu_dev = get_cpu_device(policy->cpu);
> > +	unsigned long fc_min, fc_max;
> >  	int ret;
> >  
> >  	pr_debug("setting new policy for CPU %u: %u - %u kHz\n",
> > @@ -2217,6 +2247,20 @@ static int cpufreq_set_policy(struct cpufreq_policy *policy,
> >  	if (ret)
> >  		return ret;
> >  
> > +	ret = freq_constraints_get(cpu_dev, &fc_min, &fc_max);
> > +	if (ret) {
> > +		dev_err(cpu_dev, "cpufreq: Failed to get freq-constraints\n");
> > +	} else {
> > +		if (fc_min > new_policy->min)
> > +			new_policy->min = fc_min;
> > +		if (fc_max < new_policy->max)
> > +			new_policy->max = fc_max;
> > +	}
> 
> nit: for if/else constructs with a typical and an 'exception' case
> IMO it is usually more readable when the normal case is handled in the
> 'if' branch (first) and the exception in 'else'.

Forgot to add this:

Reviewed-by: Matthias Kaehlcke <mka@chromium.org>
