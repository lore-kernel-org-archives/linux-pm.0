From: Joel Fernandes <joel@joelfernandes.org>
Subject: Re: [PATCH RFC] schedutil: Allow cpufreq requests to be made even
 when kthread kicked
Date: Thu, 17 May 2018 06:11:55 -0700
Message-ID: <20180517131155.GB139147@joelaf.mtv.corp.google.com>
References: <20180516224518.109891-1-joel@joelfernandes.org>
 <20180517050611.yj2alkzckl3ximzu@vireshk-i7>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180517050611.yj2alkzckl3ximzu@vireshk-i7>
Sender: linux-kernel-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: linux-kernel@vger.kernel.org, "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Patrick Bellasi <patrick.bellasi@arm.com>, Juri Lelli <juri.lelli@redhat.com>, Luca Abeni <luca.abeni@santannapisa.it>, kernel-team@android.com, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Thu, May 17, 2018 at 10:36:11AM +0530, Viresh Kumar wrote:
> On 16-05-18, 15:45, Joel Fernandes (Google) wrote:
> >  kernel/sched/cpufreq_schedutil.c | 36 +++++++++++++++++++++++++-------
> >  1 file changed, 28 insertions(+), 8 deletions(-)
> > 
> > diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_schedutil.c
> > index e13df951aca7..a87fc281893d 100644
> > --- a/kernel/sched/cpufreq_schedutil.c
> > +++ b/kernel/sched/cpufreq_schedutil.c
> > @@ -92,9 +92,6 @@ static bool sugov_should_update_freq(struct sugov_policy *sg_policy, u64 time)
> >  	    !cpufreq_can_do_remote_dvfs(sg_policy->policy))
> >  		return false;
> >  
> > -	if (sg_policy->work_in_progress)
> > -		return false;
> > -
> >  	if (unlikely(sg_policy->need_freq_update)) {
> >  		sg_policy->need_freq_update = false;
> >  		/*
> > @@ -129,8 +126,11 @@ static void sugov_update_commit(struct sugov_policy *sg_policy, u64 time,
> >  		policy->cur = next_freq;
> >  		trace_cpu_frequency(next_freq, smp_processor_id());
> >  	} else {
> > -		sg_policy->work_in_progress = true;
> > -		irq_work_queue(&sg_policy->irq_work);
> > +		/* Don't queue request if one was already queued */
> > +		if (!sg_policy->work_in_progress) {
> 
> Merge it above to make it "else if".

Sure.

> > +			sg_policy->work_in_progress = true;
> > +			irq_work_queue(&sg_policy->irq_work);
> > +		}
> >  	}
> >  }
> >  
> > @@ -291,6 +291,15 @@ static void sugov_update_single(struct update_util_data *hook, u64 time,
> >  
> >  	ignore_dl_rate_limit(sg_cpu, sg_policy);
> >  
> > +	/*
> > +	 * For slow-switch systems, single policy requests can't run at the
> > +	 * moment if the governor thread is already processing a pending
> > +	 * frequency switch request, this can be fixed by acquiring update_lock
> > +	 * while updating next_freq and work_in_progress but we prefer not to.
> > +	 */
> > +	if (sg_policy->work_in_progress)
> > +		return;
> > +
> 
> @Rafael: Do you think its worth start using the lock now for unshared
> policies ?

Will wait for confirmation before next revision.

> >  	if (!sugov_should_update_freq(sg_policy, time))
> >  		return;
> >  
> > @@ -382,13 +391,24 @@ sugov_update_shared(struct update_util_data *hook, u64 time, unsigned int flags)
> >  static void sugov_work(struct kthread_work *work)
> >  {
> >  	struct sugov_policy *sg_policy = container_of(work, struct sugov_policy, work);
> > +	unsigned int freq;
> > +	unsigned long flags;
> > +
> > +	/*
> > +	 * Hold sg_policy->update_lock shortly to handle the case where:
> > +	 * incase sg_policy->next_freq is read here, and then updated by
> > +	 * sugov_update_shared just before work_in_progress is set to false
> > +	 * here, we may miss queueing the new update.
> > +	 */
> > +	raw_spin_lock_irqsave(&sg_policy->update_lock, flags);
> > +	freq = sg_policy->next_freq;
> > +	sg_policy->work_in_progress = false;
> > +	raw_spin_unlock_irqrestore(&sg_policy->update_lock, flags);
> >  
> >  	mutex_lock(&sg_policy->work_lock);
> > -	__cpufreq_driver_target(sg_policy->policy, sg_policy->next_freq,
> > +	__cpufreq_driver_target(sg_policy->policy, freq,
> >  				CPUFREQ_RELATION_L);
> 
> No need of line break anymore.

Yes, will fix.

> >  	mutex_unlock(&sg_policy->work_lock);
> > -
> > -	sg_policy->work_in_progress = false;
> >  }
> >  
> >  static void sugov_irq_work(struct irq_work *irq_work)
> 
> LGTM.

Cool, thanks.

- Joel
