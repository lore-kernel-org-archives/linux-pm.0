From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH V3 1/3] sched: cpufreq: Allow remote cpufreq callbacks
Date: Mon, 24 Jul 2017 16:31:22 +0530
Message-ID: <20170724110122.GX352@vireshk-i7>
References: <cover.1499927699.git.viresh.kumar@linaro.org>
 <0f950529a63fb95e87944644c4854be4fcfaea38.1499927699.git.viresh.kumar@linaro.org>
 <20170721130349.mv7soic62jdnirq5@hirez.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pg0-f51.google.com ([74.125.83.51]:36183 "EHLO
        mail-pg0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752510AbdGXLB1 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 24 Jul 2017 07:01:27 -0400
Received: by mail-pg0-f51.google.com with SMTP id 125so55719893pgi.3
        for <linux-pm@vger.kernel.org>; Mon, 24 Jul 2017 04:01:27 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20170721130349.mv7soic62jdnirq5@hirez.programming.kicks-ass.net>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Peter Zijlstra <peterz@infradead.org>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Len Brown <lenb@kernel.org>, Ingo Molnar <mingo@redhat.com>, linux-pm@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>, smuckle.linux@gmail.com, juri.lelli@arm.com, Morten.Rasmussen@arm.com, patrick.bellasi@arm.com, eas-dev@lists.linaro.org, linux-kernel@vger.kernel.org

On 21-07-17, 15:03, Peter Zijlstra wrote:
> On Thu, Jul 13, 2017 at 12:14:37PM +0530, Viresh Kumar wrote:

> > @@ -42,6 +42,7 @@ void cpufreq_add_update_util_hook(int cpu, struct update_util_data *data,
> >  		return;
> >  
> >  	data->func = func;
> > +	data->cpu = cpu;
> >  	rcu_assign_pointer(per_cpu(cpufreq_update_util_data, cpu), data);
> >  }
> >  EXPORT_SYMBOL_GPL(cpufreq_add_update_util_hook);
> 
> redundant.

Actually we will still need it. We pass hook->cpu to sugov_get_util()
in the 2nd patch of this series and there is no work around possible
around that.

> > diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_schedutil.c
> > index 29a397067ffa..ed9c589e5386 100644
> > --- a/kernel/sched/cpufreq_schedutil.c
> > +++ b/kernel/sched/cpufreq_schedutil.c
> > @@ -218,6 +218,10 @@ static void sugov_update_single(struct update_util_data *hook, u64 time,
> >  	unsigned int next_f;
> >  	bool busy;
> >  
> > +	/* Remote callbacks aren't allowed for policies which aren't shared */
> > +	if (smp_processor_id() != hook->cpu)
> > +		return;
> > +
> >  	sugov_set_iowait_boost(sg_cpu, time, flags);
> >  	sg_cpu->last_update = time;
> >  
> > @@ -290,6 +294,10 @@ static void sugov_update_shared(struct update_util_data *hook, u64 time,
> >  	unsigned long util, max;
> >  	unsigned int next_f;
> >  
> > +	/* Don't allow remote callbacks */
> > +	if (smp_processor_id() != hook->cpu)
> > +		return;
> > +
> >  	sugov_get_util(&util, &max);
> >  
> >  	raw_spin_lock(&sg_policy->update_lock);
> 
> 
> Given the whole rq->lock thing, I suspect we could actually not do these
> two.

You meant sugov_get_util() and raw_spin_lock()? Why?

The locking is required here in the shared-policy case to make sure
only one CPU is updating the frequency for the entire policy. And we
can't really avoid that even with the rq->lock guarantees from the
scheduler for the target CPU. 

> That would then continue to process the iowait and other accounting
> stuff, but stall the moment we call into the actual driver, which will
> then drop the request on the floor as per the first few hunks.

I am not sure I understood your comment completely though.

> This seems ok. Except of course you'll have conflicts with Juri's patch
> set, but that should be trivial to sort out.

Yeah, I wouldn't mind rebasing if his series gets in first.

-- 
viresh
