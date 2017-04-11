From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [RFC 5/9] sched: cpufreq: remove smp_processor_id() in remote
 paths
Date: Tue, 11 Apr 2017 16:05:56 +0530
Message-ID: <20170411103556.GC13627@vireshk-i7>
References: <cover.1489058244.git.viresh.kumar@linaro.org>
 <834d098efe029ee687bac7690bb482e9263a766b.1489058244.git.viresh.kumar@linaro.org>
 <1836427.bpauTYz19k@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1836427.bpauTYz19k@aspire.rjw.lan>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>, smuckle.linux@gmail.com, juri.lelli@arm.com, Morten.Rasmussen@arm.com, patrick.bellasi@arm.com, eas-dev@lists.linaro.org
List-Id: linux-pm@vger.kernel.org

On 29-03-17, 23:28, Rafael J. Wysocki wrote:
> On Thursday, March 09, 2017 05:15:15 PM Viresh Kumar wrote:
> > @@ -216,7 +216,7 @@ static void sugov_update_single(struct update_util_data *hook, u64 time,
> >  	if (flags & SCHED_CPUFREQ_RT_DL) {
> >  		next_f = policy->cpuinfo.max_freq;
> >  	} else {
> > -		sugov_get_util(&util, &max);
> > +		sugov_get_util(&util, &max, hook->cpu);
> 
> Why is this not racy?

Why would reading the utilization values be racy? The only dynamic value here is
"util_avg" and I am not sure if reading it is racy.

But, this whole routine has races which I ignored as we may end up updating
frequency simultaneously from two threads.

> >  		sugov_iowait_boost(sg_cpu, &util, &max);
> >  		next_f = get_next_freq(sg_policy, util, max);
> >  	}
> > @@ -272,7 +272,7 @@ static void sugov_update_shared(struct update_util_data *hook, u64 time,
> >  	unsigned long util, max;
> >  	unsigned int next_f;
> >  
> > -	sugov_get_util(&util, &max);
> > +	sugov_get_util(&util, &max, hook->cpu);
> >  
> 
> And here?
> 
> >  	raw_spin_lock(&sg_policy->update_lock);

The lock prevents the same here though.

So, if we are going to use this series, then we can use the same update-lock in
case of single cpu per policies as well.

-- 
viresh
