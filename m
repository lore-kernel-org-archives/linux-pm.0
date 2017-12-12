From: Juri Lelli <juri.lelli@redhat.com>
Subject: Re: [PATCH v3 1/6] cpufreq: schedutil: reset sg_cpus's flags at IDLE
 enter
Date: Tue, 12 Dec 2017 15:56:20 +0100
Message-ID: <20171212145620.GA30887@localhost.localdomain>
References: <20171130114723.29210-1-patrick.bellasi@arm.com>
 <20171130114723.29210-2-patrick.bellasi@arm.com>
 <20171207050135.vvhqttazumjg7n7n@vireshk-mac-ubuntu>
 <20171207124510.GP31247@e110439-lin>
 <20171212113727.GO25177@vireshk-i7>
 <20171212133824.GH4635@localhost.localdomain>
 <20171212144019.GQ25177@vireshk-i7>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wm0-f65.google.com ([74.125.82.65]:43922 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753041AbdLLO4Z (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 12 Dec 2017 09:56:25 -0500
Received: by mail-wm0-f65.google.com with SMTP id n138so21172569wmg.2
        for <linux-pm@vger.kernel.org>; Tue, 12 Dec 2017 06:56:25 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20171212144019.GQ25177@vireshk-i7>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Patrick Bellasi <patrick.bellasi@arm.com>, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, Vincent Guittot <vincent.guittot@linaro.org>, Dietmar Eggemann <dietmar.eggemann@arm.com>, Morten Rasmussen <morten.rasmussen@arm.com>, Todd Kjos <tkjos@android.com>, Joel Fernandes <joelaf@google.com>

On 12/12/17 20:10, Viresh Kumar wrote:
> On 12-12-17, 14:38, Juri Lelli wrote:
> > Hi Viresh,
> > 
> > On 12/12/17 17:07, Viresh Kumar wrote:
> > 
> > [...]
> > 
> > > From: Viresh Kumar <viresh.kumar@linaro.org>
> > > Date: Tue, 12 Dec 2017 15:43:26 +0530
> > > Subject: [PATCH] sched: Keep track of cpufreq utilization update flags
> > > 
> > > Currently the schedutil governor overwrites the sg_cpu->flags field on
> > > every call to the utilization handler. It was pretty good as the initial
> > > implementation of utilization handlers, there are several drawbacks
> > > though.
> > > 
> > > The biggest drawback is that the sg_cpu->flags field doesn't always
> > > represent the correct type of tasks that are enqueued on a CPU's rq. For
> > > example, if a fair task is enqueued while a RT or DL task is running, we
> > > will overwrite the flags with value 0 and that may take the CPU to lower
> > > OPPs unintentionally. There can be other corner cases as well which we
> > > aren't aware of currently.
> > > 
> > > This patch changes the current implementation to keep track of all the
> > > task types that are currently enqueued to the CPUs rq. There are two
> > > flags for every scheduling class now, one to set the flag and other one
> > > to clear it. The flag is set by the scheduling classes from the existing
> > > set of calls to cpufreq_update_util(), and the flag is cleared when the
> > > last task of the scheduling class is dequeued. For now, the util update
> > > handlers return immediately if they were called to clear the flag.
> > > 
> > > We can add more optimizations over this patch separately.
> > > 
> > > The last parameter of sugov_set_iowait_boost() is also dropped as the
> > > function can get it from sg_cpu anyway.
> > > 
> > > Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> > 
> > [...]
> > 
> > > @@ -655,7 +669,7 @@ static int sugov_start(struct cpufreq_policy *policy)
> > >  		memset(sg_cpu, 0, sizeof(*sg_cpu));
> > >  		sg_cpu->cpu = cpu;
> > >  		sg_cpu->sg_policy = sg_policy;
> > > -		sg_cpu->flags = SCHED_CPUFREQ_RT;
> > > +		sg_cpu->flags = 0;
> > >  		sg_cpu->iowait_boost_max = policy->cpuinfo.max_freq;
> > >  	}
> > 
> > Why this change during initialization?
> 
> Firstly I am not sure why it was set to SCHED_CPUFREQ_RT, as schedutil wouldn't
> change the frequency until the first time the util handler is called. And once
> that is called we were updating the flag anyway. So, unless I misunderstood its
> purpose, it was doing anything helpful.

That was actually my understanding as well. Your patch made me notice
it.

> 
> I need to remove it otherwise the RT flag may remain set for a very long time
> unnecessarily. That would be until the time the last RT task is not dequeued.
> Consider this for example: we are at max freq when sugov_start() is called and
> it sets the RT flag, but there is no RT task to run. Now, we have tons of CFS
> tasks but we always keep running at max because of the flag. Even the schedutil
> RT thread doesn't get a chance to run/deququed, because we never want a freq
> change with the RT flag and stay at max.
> 
> Makes sense ?

Yes. I guess it's working ok for now because of the problem this patch,
and Patrick's, address (always overwriting).

Thanks,

- Juri
