From: Juri Lelli <juri.lelli@arm.com>
Subject: Re: [PATCH RFC 4/8] sched/cpufreq_schedutil: split utilization
 signals
Date: Wed, 24 May 2017 10:01:36 +0100
Message-ID: <20170524090136.6bwwsnfy2a6yicbc@e106622-lin>
References: <20170523085351.18586-1-juri.lelli@arm.com>
 <20170523085351.18586-5-juri.lelli@arm.com>
 <20170523190451.3flxegqt7ttmorw6@hirez.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170523190451.3flxegqt7ttmorw6@hirez.programming.kicks-ass.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Zijlstra <peterz@infradead.org>
Cc: mingo@redhat.com, rjw@rjwysocki.net, viresh.kumar@linaro.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, tglx@linutronix.de, vincent.guittot@linaro.org, rostedt@goodmis.org, luca.abeni@santannapisa.it, claudio@evidence.eu.com, tommaso.cucinotta@santannapisa.it, bristot@redhat.com, mathieu.poirier@linaro.org, tkjos@android.com, joelaf@google.com, andresoportus@google.com, morten.rasmussen@arm.com, dietmar.eggemann@arm.com, patrick.bellasi@arm.com, Ingo Molnar <mingo@kernel.org>, "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>
List-Id: linux-pm@vger.kernel.org

Hi,

On 23/05/17 21:04, Peter Zijlstra wrote:
> On Tue, May 23, 2017 at 09:53:47AM +0100, Juri Lelli wrote:
> > @@ -157,14 +158,13 @@ static unsigned int get_next_freq(struct sugov_policy *sg_policy,
> >  	return cpufreq_driver_resolve_freq(policy, freq);
> >  }
> >  
> > -static void sugov_get_util(unsigned long *util, unsigned long *max)
> > +static void sugov_get_util(struct sugov_cpu *sg_cpu)
> >  {
> >  	struct rq *rq = this_rq();
> > -	unsigned long dl_util = (rq->dl.running_bw * SCHED_CAPACITY_SCALE) >> 20;
> >  
> > -	*max = arch_scale_cpu_capacity(NULL, smp_processor_id());
> > -
> > -	*util = min(rq->cfs.avg.util_avg + dl_util, *max);
> > +	sg_cpu->max = arch_scale_cpu_capacity(NULL, smp_processor_id());
> > +	sg_cpu->util_cfs = rq->cfs.avg.util_avg;
> > +	sg_cpu->util_dl = (rq->dl.running_bw * SCHED_CAPACITY_SCALE) >> 20;
> >  }
> 
> Luca just introduced a nice BW_SHIFT for that '20' thing.

Right, will use that.

Thanks,

- Juri
