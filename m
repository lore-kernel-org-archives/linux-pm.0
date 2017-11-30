From: Juri Lelli <juri.lelli@redhat.com>
Subject: Re: [PATCH v3 1/6] cpufreq: schedutil: reset sg_cpus's flags at IDLE
 enter
Date: Thu, 30 Nov 2017 17:02:05 +0100
Message-ID: <20171130160205.GH9903@localhost.localdomain>
References: <20171130114723.29210-1-patrick.bellasi@arm.com>
 <20171130114723.29210-2-patrick.bellasi@arm.com>
 <20171130131222.GA9903@localhost.localdomain>
 <20171130154111.GC31247@e110439-lin>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20171130154111.GC31247@e110439-lin>
Sender: linux-kernel-owner@vger.kernel.org
To: Patrick Bellasi <patrick.bellasi@arm.com>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, Viresh Kumar <viresh.kumar@linaro.org>, Vincent Guittot <vincent.guittot@linaro.org>, Dietmar Eggemann <dietmar.eggemann@arm.com>, Morten Rasmussen <morten.rasmussen@arm.com>, Todd Kjos <tkjos@android.com>, Joel Fernandes <joelaf@google.com>
List-Id: linux-pm@vger.kernel.org

On 30/11/17 15:41, Patrick Bellasi wrote:
> On 30-Nov 14:12, Juri Lelli wrote:
> > Hi,
> > 
> > On 30/11/17 11:47, Patrick Bellasi wrote:
> > 
> > [...]
> > 
> > > diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_schedutil.c
> > > index 2f52ec0f1539..67339ccb5595 100644
> > > --- a/kernel/sched/cpufreq_schedutil.c
> > > +++ b/kernel/sched/cpufreq_schedutil.c
> > > @@ -347,6 +347,12 @@ static void sugov_update_shared(struct update_util_data *hook, u64 time,
> > >  
> > >  	sg_cpu->util = util;
> > >  	sg_cpu->max = max;
> > > +
> > > +	/* CPU is entering IDLE, reset flags without triggering an update */
> > > +	if (unlikely(flags & SCHED_CPUFREQ_IDLE)) {
> > > +		sg_cpu->flags = 0;
> > > +		goto done;
> > > +	}
> > 
> > Looks good for now. I'm just thinking that we will happen for DL, as a
> > CPU that still "has" a sleeping task is not going to be really idle
> > until the 0-lag time.
> 
> AFAIU, for the time being, DL already cannot really rely on this flag
> for its behaviors to be correct. Indeed, flags are reset as soon as
> a FAIR task wakes up and it's enqueued.

Right, and your flags ORing patch should help with this.

> 
> Only once your DL integration patches are in, we do not depends on
> flags anymore since DL will report a ceratain utilization up to the
> 0-lag time, isn't it?

Utilization won't decrease until 0-lag time, correct. I was just
wondering if resetting flags before that time (when a CPU enters idle)
might be an issue.

> 
> If that's the case, I would say that the flags will be used only to
> jump to the max OPP for RT tasks. Thus, this patch should still be valid.
> 
> > I guess we could move this at that point in time?
> 
> Not sure what you mean here. Right now the new SCHED_CPUFREQ_IDLE flag
> is notified only by idle tasks. That's the only code path where we are
> sure the CPU is entering IDLE.
> 

W.r.t. the possible issue above, I was thinking that we might want to
reset flags at 0-lag time for DL (if CPU is still idle). Anyway, two
distinct set of patches. Who gets in last will have to ponder the thing
a little bit more. :)

Best,

Juri
