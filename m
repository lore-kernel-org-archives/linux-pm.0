From: Javi Merino <javi.merino@arm.com>
Subject: Re: [PATCH] thermal: cpu_cooling: Fix NULL dereference in
 cpufreq_state2power
Date: Thu, 18 Aug 2016 10:30:42 +0100
Message-ID: <20160818093042.GA3154@e104805>
References: <20160817151459.10948-1-brendan.jackman@arm.com>
 <20160817230507.GC24396@ubuntu>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:56737 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753135AbcHRJap (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Thu, 18 Aug 2016 05:30:45 -0400
Content-Disposition: inline
In-Reply-To: <20160817230507.GC24396@ubuntu>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Brendan Jackman <brendan.jackman@arm.com>, linux-pm@vger.kernel.org, Amit Daniel Kachhap <amit.kachhap@gmail.com>

On Thu, Aug 18, 2016 at 04:35:07AM +0530, Viresh Kumar wrote:
> On 17-08-16, 16:14, Brendan Jackman wrote:
> > Currently all CPU cooling devices share a
> > `struct thermal_cooling_device_ops` instance. The thermal core uses the
> > presence of functions in this struct to determine if a cooling device
> > has a power model (see cdev_is_power_actor). cpu_cooling.c adds the
> > power model functions to the shared struct when a device is registered
> > with a power model.
> > 
> > Therefore, if a CPU cooling device is registered using
> > [of_]cpufreq_power_cooling_register, _all_ devices will be determined to
> > have a power model, including any registered with
> > [of_]cpufreq_cooling_register. This can result in cpufreq_state2power
> > being called on a device where dyn_power_table is NULL.
> > 
> > With this commit, instead of having a shared thermal_cooling_device_ops
> > which is mutated, we have two versions: one with the power functions and
> > one without.
> > 
> > Signed-off-by: Brendan Jackman <brendan.jackman@arm.com>
> > Cc: Amit Daniel Kachhap <amit.kachhap@gmail.com>
> > Cc: Viresh Kumar <viresh.kumar@linaro.org>
> > Cc: Javi Merino <javi.merino@arm.com>
> > 
> > ---
> >  drivers/thermal/cpu_cooling.c | 21 ++++++++++++++++-----
> >  1 file changed, 16 insertions(+), 5 deletions(-)
> > 
> > diff --git a/drivers/thermal/cpu_cooling.c b/drivers/thermal/cpu_cooling.c
> > index 3788ed7..a32b417 100644
> > --- a/drivers/thermal/cpu_cooling.c
> > +++ b/drivers/thermal/cpu_cooling.c
> > @@ -740,12 +740,22 @@ static int cpufreq_power2state(struct thermal_cooling_device *cdev,
> >  }
> > 
> >  /* Bind cpufreq callbacks to thermal cooling device ops */
> > +
> >  static struct thermal_cooling_device_ops cpufreq_cooling_ops = {
> >  	.get_max_state = cpufreq_get_max_state,
> >  	.get_cur_state = cpufreq_get_cur_state,
> >  	.set_cur_state = cpufreq_set_cur_state,
> >  };
> > 
> > +static struct thermal_cooling_device_ops cpufreq_power_cooling_ops = {
> > +	.get_max_state		= cpufreq_get_max_state,
> > +	.get_cur_state		= cpufreq_get_cur_state,
> > +	.set_cur_state		= cpufreq_set_cur_state,
> > +	.get_requested_power	= cpufreq_get_requested_power,
> > +	.state2power		= cpufreq_state2power,
> > +	.power2state		= cpufreq_power2state,
> > +};
> > +
> >  /* Notifier for cpufreq policy change */
> >  static struct notifier_block thermal_cpufreq_notifier_block = {
> >  	.notifier_call = cpufreq_thermal_notifier,
> > @@ -795,6 +805,7 @@ __cpufreq_cooling_register(struct device_node *np,
> >  	struct cpumask temp_mask;
> >  	unsigned int freq, i, num_cpus;
> >  	int ret;
> > +	struct thermal_cooling_device_ops *cooling_ops;
> > 
> >  	cpumask_and(&temp_mask, clip_cpus, cpu_online_mask);
> >  	policy = cpufreq_cpu_get(cpumask_first(&temp_mask));
> > @@ -850,10 +861,6 @@ __cpufreq_cooling_register(struct device_node *np,
> >  	cpumask_copy(&cpufreq_dev->allowed_cpus, clip_cpus);
> > 
> >  	if (capacitance) {
> > -		cpufreq_cooling_ops.get_requested_power =
> > -			cpufreq_get_requested_power;
> > -		cpufreq_cooling_ops.state2power = cpufreq_state2power;
> > -		cpufreq_cooling_ops.power2state = cpufreq_power2state;
> >  		cpufreq_dev->plat_get_static_power = plat_static_func;
> > 
> >  		ret = build_dyn_power_table(cpufreq_dev, capacitance);
> > @@ -861,6 +868,10 @@ __cpufreq_cooling_register(struct device_node *np,
> >  			cool_dev = ERR_PTR(ret);
> >  			goto free_table;
> >  		}
> > +
> > +		cooling_ops = &cpufreq_power_cooling_ops;
> > +	} else {
> > +		cooling_ops = &cpufreq_cooling_ops;
> >  	}
> > 
> >  	ret = get_idr(&cpufreq_idr, &cpufreq_dev->id);
> > @@ -885,7 +896,7 @@ __cpufreq_cooling_register(struct device_node *np,
> >  		 cpufreq_dev->id);
> > 
> >  	cool_dev = thermal_of_cooling_device_register(np, dev_name, cpufreq_dev,
> > -						      &cpufreq_cooling_ops);
> > +						      cooling_ops);
> >  	if (IS_ERR(cool_dev))
> >  		goto remove_idr;
> 
> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

Yep, looks good to me.

Acked-by: Javi Merino <javi.merino@arm.com>
