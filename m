From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH V3 1/3] sched: cpufreq: Allow remote cpufreq callbacks
Date: Mon, 24 Jul 2017 15:47:52 +0200
Message-ID: <20170724134752.sejehwa5mjqqc2mq@hirez.programming.kicks-ass.net>
References: <cover.1499927699.git.viresh.kumar@linaro.org>
 <0f950529a63fb95e87944644c4854be4fcfaea38.1499927699.git.viresh.kumar@linaro.org>
 <20170721130349.mv7soic62jdnirq5@hirez.programming.kicks-ass.net>
 <20170724110122.GX352@vireshk-i7>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170724110122.GX352@vireshk-i7>
Sender: linux-kernel-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Len Brown <lenb@kernel.org>, Ingo Molnar <mingo@redhat.com>, linux-pm@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>, smuckle.linux@gmail.com, juri.lelli@arm.com, Morten.Rasmussen@arm.com, patrick.bellasi@arm.com, eas-dev@lists.linaro.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Mon, Jul 24, 2017 at 04:31:22PM +0530, Viresh Kumar wrote:
> On 21-07-17, 15:03, Peter Zijlstra wrote:
> > On Thu, Jul 13, 2017 at 12:14:37PM +0530, Viresh Kumar wrote:

> > > diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_schedutil.c
> > > index 29a397067ffa..ed9c589e5386 100644
> > > --- a/kernel/sched/cpufreq_schedutil.c
> > > +++ b/kernel/sched/cpufreq_schedutil.c
> > > @@ -218,6 +218,10 @@ static void sugov_update_single(struct update_util_data *hook, u64 time,
> > >  	unsigned int next_f;
> > >  	bool busy;
> > >  
> > > +	/* Remote callbacks aren't allowed for policies which aren't shared */
> > > +	if (smp_processor_id() != hook->cpu)
> > > +		return;
> > > +
> > >  	sugov_set_iowait_boost(sg_cpu, time, flags);
> > >  	sg_cpu->last_update = time;
> > >  
> > > @@ -290,6 +294,10 @@ static void sugov_update_shared(struct update_util_data *hook, u64 time,
> > >  	unsigned long util, max;
> > >  	unsigned int next_f;
> > >  
> > > +	/* Don't allow remote callbacks */
> > > +	if (smp_processor_id() != hook->cpu)
> > > +		return;
> > > +
> > >  	sugov_get_util(&util, &max);
> > >  
> > >  	raw_spin_lock(&sg_policy->update_lock);
> > 
> > 
> > Given the whole rq->lock thing, I suspect we could actually not do these
> > two.
> 
> You meant sugov_get_util() and raw_spin_lock()? Why?
> 
> The locking is required here in the shared-policy case to make sure
> only one CPU is updating the frequency for the entire policy. And we
> can't really avoid that even with the rq->lock guarantees from the
> scheduler for the target CPU. 

I said nothing about the shared locking. That is indeed required. All I
said is that those two tests you add could be left out.

> > That would then continue to process the iowait and other accounting
> > stuff, but stall the moment we call into the actual driver, which will
> > then drop the request on the floor as per the first few hunks.
> 
> I am not sure I understood your comment completely though.

Since we call cpufreq_update_util(@rq, ...) with @rq->lock held, all
such calls are in fact serialized for that cpu. Therefore the cpu !=
current_cpu test you add are pointless.

Only once we get to the actual cpufreq driver (intel_pstate and others)
do we run into the fact that we might not be able to service the request
remotely. But since you also add a test there, that is sufficient.
