From: Juri Lelli <juri.lelli@arm.com>
Subject: Re: [RFC PATCH v1 8/8] sched/deadline: make bandwidth enforcement
 scale-invariant
Date: Wed, 19 Jul 2017 10:20:29 +0100
Message-ID: <20170719092029.oakmetq3u52e4rfw@e106622-lin>
References: <20170705085905.6558-1-juri.lelli@arm.com>
 <20170705085905.6558-9-juri.lelli@arm.com>
 <20170719072143.lploljodns3kfucf@hirez.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170719072143.lploljodns3kfucf@hirez.programming.kicks-ass.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Zijlstra <peterz@infradead.org>
Cc: mingo@redhat.com, rjw@rjwysocki.net, viresh.kumar@linaro.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, tglx@linutronix.de, vincent.guittot@linaro.org, rostedt@goodmis.org, luca.abeni@santannapisa.it, claudio@evidence.eu.com, tommaso.cucinotta@santannapisa.it, bristot@redhat.com, mathieu.poirier@linaro.org, tkjos@android.com, joelaf@google.com, andresoportus@google.com, morten.rasmussen@arm.com, dietmar.eggemann@arm.com, patrick.bellasi@arm.com, Ingo Molnar <mingo@kernel.org>, "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>
List-Id: linux-pm@vger.kernel.org

On 19/07/17 09:21, Peter Zijlstra wrote:
> On Wed, Jul 05, 2017 at 09:59:05AM +0100, Juri Lelli wrote:
> > @@ -1156,9 +1157,26 @@ static void update_curr_dl(struct rq *rq)
> >  	if (unlikely(dl_entity_is_special(dl_se)))
> >  		return;
> >  
> > -	if (unlikely(dl_se->flags & SCHED_FLAG_RECLAIM))
> > -		delta_exec = grub_reclaim(delta_exec, rq, &curr->dl);
> > -	dl_se->runtime -= delta_exec;
> > +	/*
> > +	 * For tasks that participate in GRUB, we implement GRUB-PA: the
> > +	 * spare reclaimed bandwidth is used to clock down frequency.
> > +	 *
> > +	 * For the others, we still need to scale reservation parameters
> > +	 * according to current frequency and CPU maximum capacity.
> > +	 */
> > +	if (unlikely(dl_se->flags & SCHED_FLAG_RECLAIM)) {
> > +		scaled_delta_exec = grub_reclaim(delta_exec,
> > +						 rq,
> > +						 &curr->dl);
> > +	} else {
> > +		unsigned long scale_freq = arch_scale_freq_capacity(cpu);
> > +		unsigned long scale_cpu = arch_scale_cpu_capacity(NULL, cpu);
> > +
> > +		scaled_delta_exec = cap_scale(delta_exec, scale_freq);
> > +		scaled_delta_exec = cap_scale(scaled_delta_exec, scale_cpu);
> > +	}
> > +
> > +	dl_se->runtime -= scaled_delta_exec;
> >  
> 
> This I don't get... 


Considering that we use GRUB's active utilization to drive clock
frequency selection, rationale is that GRUB tasks don't need any special
scaling, as their delta_exec is already scaled according to GRUB rules.
OTOH, normal tasks need to have their runtime (delta_exec) explicitly
scaled considering current frequency (and CPU max capacity), otherwise
they are going to receive less runtime than granted at AC, when
frequency is reduced.
