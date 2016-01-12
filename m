From: Juri Lelli <juri.lelli@arm.com>
Subject: Re: [RFC PATCH 07/19] cpufreq: assert locking when accessing
 cpufreq_governor_list
Date: Tue, 12 Jan 2016 15:33:24 +0000
Message-ID: <20160112153324.GB18734@e106622-lin>
References: <1452533760-13787-1-git-send-email-juri.lelli@arm.com>
 <1452533760-13787-8-git-send-email-juri.lelli@arm.com>
 <20160112100122.GY1084@ubuntu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20160112100122.GY1084@ubuntu>
Sender: linux-kernel-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, peterz@infradead.org, rjw@rjwysocki.net, mturquette@baylibre.com, steve.muckle@linaro.org, vincent.guittot@linaro.org, morten.rasmussen@arm.com, dietmar.eggemann@arm.com
List-Id: linux-pm@vger.kernel.org

Hi,

On 12/01/16 15:31, Viresh Kumar wrote:
> On 11-01-16, 17:35, Juri Lelli wrote:
> > @@ -2025,6 +2027,7 @@ int cpufreq_register_governor(struct cpufreq_governor *governor)
> >  	err = -EBUSY;
> >  	if (!find_governor(governor->name)) {
> >  		err = 0;
> > +		lockdep_assert_held(&cpufreq_governor_mutex);
> >  		list_add(&governor->governor_list, &cpufreq_governor_list);
> >  	}
> 
> Why here? This is how the routine looks like:
> 

I guess I was simply over-paranoid. We can drop this assertion.

Thanks,

- Juri

> int cpufreq_register_governor(struct cpufreq_governor *governor)
> {
> 	int err;
> 
> 	if (!governor)
> 		return -EINVAL;
> 
> 	if (cpufreq_disabled())
> 		return -ENODEV;
> 
> 	mutex_lock(&cpufreq_governor_mutex);
> 
> 	governor->initialized = 0;
> 	err = -EBUSY;
> 	if (!find_governor(governor->name)) {
> 		err = 0;
> 		list_add(&governor->governor_list, &cpufreq_governor_list);
> 	}
> 
> 	mutex_unlock(&cpufreq_governor_mutex);
> 	return err;
> }
> 
> 
> -- 
> viresh
> 
