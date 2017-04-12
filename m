From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 05/17] thermal: cpu_cooling: remove
 cpufreq_cooling_get_level()
Date: Wed, 12 Apr 2017 11:55:16 +0530
Message-ID: <20170412062516.GC5910@vireshk-i7>
References: <cover.1489639999.git.viresh.kumar@linaro.org>
 <707918c88ce650ea11d160e31965482cdebc9a39.1489640000.git.viresh.kumar@linaro.org>
 <20170411174342.GC5528@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f174.google.com ([209.85.192.174]:33929 "EHLO
        mail-pf0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751473AbdDLGZU (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 12 Apr 2017 02:25:20 -0400
Received: by mail-pf0-f174.google.com with SMTP id c198so9201108pfc.1
        for <linux-pm@vger.kernel.org>; Tue, 11 Apr 2017 23:25:20 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20170411174342.GC5528@localhost.localdomain>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Eduardo Valentin <edubezval@gmail.com>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, Javi Merino <javi.merino@kernel.org>, Zhang Rui <rui.zhang@intel.com>, Amit Daniel Kachhap <amit.kachhap@gmail.com>, linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>

On 11-04-17, 10:43, Eduardo Valentin wrote:
> On Thu, Mar 16, 2017 at 10:59:40AM +0530, Viresh Kumar wrote:
> > There is only one user of cpufreq_cooling_get_level() and that already
> > has pointer to the cpufreq_dev structure. It can directly call
> > get_level() instead and we can get rid of cpufreq_cooling_get_level().
> > 
> > Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> > ---
> >  drivers/thermal/cpu_cooling.c | 33 +--------------------------------
> >  include/linux/cpu_cooling.h   |  6 ------
> >  2 files changed, 1 insertion(+), 38 deletions(-)
> > 
> > diff --git a/drivers/thermal/cpu_cooling.c b/drivers/thermal/cpu_cooling.c
> > index e2931c20c309..99dc6833de75 100644
> > --- a/drivers/thermal/cpu_cooling.c
> > +++ b/drivers/thermal/cpu_cooling.c
> > @@ -137,37 +137,6 @@ static unsigned long get_level(struct cpufreq_cooling_device *cpufreq_dev,
> >  }
> >  
> >  /**
> > - * cpufreq_cooling_get_level - for a given cpu, return the cooling level.
> > - * @cpu: cpu for which the level is required
> > - * @freq: the frequency of interest
> > - *
> > - * This function will match the cooling level corresponding to the
> > - * requested @freq and return it.
> > - *
> > - * Return: The matched cooling level on success or THERMAL_CSTATE_INVALID
> > - * otherwise.
> > - */
> > -unsigned long cpufreq_cooling_get_level(unsigned int cpu, unsigned int freq)
> > -{
> > -	struct cpufreq_cooling_device *cpufreq_dev;
> > -
> > -	mutex_lock(&cooling_list_lock);
> > -	list_for_each_entry(cpufreq_dev, &cpufreq_dev_list, node) {
> > -		if (cpumask_test_cpu(cpu, &cpufreq_dev->allowed_cpus)) {
> > -			unsigned long level = get_level(cpufreq_dev, freq);
> > -
> > -			mutex_unlock(&cooling_list_lock);
> > -			return level;
> > -		}
> > -	}
> > -	mutex_unlock(&cooling_list_lock);
> > -
> > -	pr_err("%s: cpu:%d not part of any cooling device\n", __func__, cpu);
> > -	return THERMAL_CSTATE_INVALID;
> > -}
> > -EXPORT_SYMBOL_GPL(cpufreq_cooling_get_level);
> > -
> > -/**
> >   * cpufreq_thermal_notifier - notifier callback for cpufreq policy change.
> >   * @nb:	struct notifier_block * with callback info.
> >   * @event: value showing cpufreq event for which this function invoked.
> > @@ -698,7 +667,7 @@ static int cpufreq_power2state(struct thermal_cooling_device *cdev,
> >  	normalised_power = (dyn_power * 100) / last_load;
> >  	target_freq = cpu_power_to_freq(cpufreq_dev, normalised_power);
> >  
> > -	*state = cpufreq_cooling_get_level(cpu, target_freq);
> > +	*state = get_level(cpufreq_dev, target_freq);
> 
> Did I miss something or we are loosing semantics here?

I just got rid of an unnecessary wrapper routine. That's it. There shouldn't be
any functional change after this patch.

> I guess the idea at this point is to get the level corresponding to the
> frequency on a specific cpu. Let's have a look on get_level()..
> 
> I guess now we can rely on the freq table held in the
> cpufreq_cooling_device..

I am not sure I understood your concerns here :(

-- 
viresh
