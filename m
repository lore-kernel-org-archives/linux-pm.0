From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH V2 4/5] cpufreq: Register notifiers with the PM QoS
 framework
Date: Mon, 25 Feb 2019 10:01:49 +0530
Message-ID: <20190225043149.bfl5vdb57xaaje2w@vireshk-i7>
References: <cover.1550748118.git.viresh.kumar@linaro.org>
 <e6969d79643c87af24895d508e5c6f7462b1c758.1550748118.git.viresh.kumar@linaro.org>
 <20190222114446.cmwoe7tanxvf2gxh@e107158-lin.cambridge.arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190222114446.cmwoe7tanxvf2gxh@e107158-lin.cambridge.arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Qais Yousef <qais.yousef@arm.com>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, linux-pm@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>, mka@chromium.org, juri.lelli@gmail.com, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On 22-02-19, 11:44, Qais Yousef wrote:
> Hi Verish
> 
> On 02/21/19 16:59, Viresh Kumar wrote:
> 
> [...]
> 
> > @@ -2239,6 +2314,8 @@ static int cpufreq_set_policy(struct cpufreq_policy *policy,
> >  			      struct cpufreq_policy *new_policy)
> >  {
> >  	struct cpufreq_governor *old_gov;
> > +	struct device *cpu_dev = get_cpu_device(policy->cpu);
> > +	unsigned long min, max;
> >  	int ret;
> >  
> >  	pr_debug("setting new policy for CPU %u: %u - %u kHz\n",
> > @@ -2253,11 +2330,23 @@ static int cpufreq_set_policy(struct cpufreq_policy *policy,
> >  	if (new_policy->min > new_policy->max)
> >  		return -EINVAL;
> >  
> > +	min = dev_pm_qos_read_value(cpu_dev, DEV_PM_QOS_MIN_FREQUENCY);
> > +	max = dev_pm_qos_read_value(cpu_dev, DEV_PM_QOS_MAX_FREQUENCY);
> > +
> > +	if (min > new_policy->min)
> > +		new_policy->min = min;
> > +	if (max < new_policy->max)
> > +		new_policy->max = max;
> > +
> 
> Assuming for example min and max range from 1-10, and thermal throttles max to
> 5 using pm_qos to deal with temporary thermal pressure. But shortly after
> a driver thinks that max shouldn't be greater than 7 for one reason or another.
> 
> What will happen after thermal pressure removes its constraint? Will we still
> remember the driver's request and apply it so max is set to 7 instead of 10?

Once everything comes via PM QoS, it will remember all the presently available
requests and choose a target min/max frequency based on that.

But even with this patchset, with half stuff done with PM QoS and half done with
cpufreq notifiers, it should still work that way only.

-- 
viresh
