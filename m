From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [RFC PATCH v1 8/8] sched/deadline: make bandwidth enforcement
 scale-invariant
Date: Mon, 24 Jul 2017 18:43:49 +0200
Message-ID: <20170724164349.clzsajrwxtobyqkm@hirez.programming.kicks-ass.net>
References: <20170705085905.6558-1-juri.lelli@arm.com>
 <20170705085905.6558-9-juri.lelli@arm.com>
 <20170719072143.lploljodns3kfucf@hirez.programming.kicks-ass.net>
 <20170719092029.oakmetq3u52e4rfw@e106622-lin>
 <20170719110028.uggud56bg2jh45ge@hirez.programming.kicks-ass.net>
 <20170719111624.fwcydcklmfeesfgb@e106622-lin>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from merlin.infradead.org ([205.233.59.134]:51986 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753475AbdGXQoK (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 24 Jul 2017 12:44:10 -0400
Content-Disposition: inline
In-Reply-To: <20170719111624.fwcydcklmfeesfgb@e106622-lin>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Juri Lelli <juri.lelli@arm.com>
Cc: mingo@redhat.com, rjw@rjwysocki.net, viresh.kumar@linaro.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, tglx@linutronix.de, vincent.guittot@linaro.org, rostedt@goodmis.org, luca.abeni@santannapisa.it, claudio@evidence.eu.com, tommaso.cucinotta@santannapisa.it, bristot@redhat.com, mathieu.poirier@linaro.org, tkjos@android.com, joelaf@google.com, andresoportus@google.com, morten.rasmussen@arm.com, dietmar.eggemann@arm.com, patrick.bellasi@arm.com, Ingo Molnar <mingo@kernel.org>, "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>

On Wed, Jul 19, 2017 at 12:16:24PM +0100, Juri Lelli wrote:
> On 19/07/17 13:00, Peter Zijlstra wrote:
> > On Wed, Jul 19, 2017 at 10:20:29AM +0100, Juri Lelli wrote:
> > > On 19/07/17 09:21, Peter Zijlstra wrote:
> > > > On Wed, Jul 05, 2017 at 09:59:05AM +0100, Juri Lelli wrote:
> > > > > @@ -1156,9 +1157,26 @@ static void update_curr_dl(struct rq *rq)
> > > > >  	if (unlikely(dl_entity_is_special(dl_se)))
> > > > >  		return;
> > > > >  
> > > > > -	if (unlikely(dl_se->flags & SCHED_FLAG_RECLAIM))
> > > > > -		delta_exec = grub_reclaim(delta_exec, rq, &curr->dl);
> > > > > -	dl_se->runtime -= delta_exec;
> > > > > +	/*
> > > > > +	 * For tasks that participate in GRUB, we implement GRUB-PA: the
> > > > > +	 * spare reclaimed bandwidth is used to clock down frequency.
> > > > > +	 *
> > > > > +	 * For the others, we still need to scale reservation parameters
> > > > > +	 * according to current frequency and CPU maximum capacity.
> > > > > +	 */
> > > > > +	if (unlikely(dl_se->flags & SCHED_FLAG_RECLAIM)) {
> > > > > +		scaled_delta_exec = grub_reclaim(delta_exec,
> > > > > +						 rq,
> > > > > +						 &curr->dl);
> > > > > +	} else {
> > > > > +		unsigned long scale_freq = arch_scale_freq_capacity(cpu);
> > > > > +		unsigned long scale_cpu = arch_scale_cpu_capacity(NULL, cpu);
> > > > > +
> > > > > +		scaled_delta_exec = cap_scale(delta_exec, scale_freq);
> > > > > +		scaled_delta_exec = cap_scale(scaled_delta_exec, scale_cpu);
> > > > > +	}
> > > > > +
> > > > > +	dl_se->runtime -= scaled_delta_exec;
> > > > >  
> > > > 
> > > > This I don't get... 
> > > 
> > > 
> > > Considering that we use GRUB's active utilization to drive clock
> > > frequency selection, rationale is that GRUB tasks don't need any special
> > > scaling, as their delta_exec is already scaled according to GRUB rules.
> > > OTOH, normal tasks need to have their runtime (delta_exec) explicitly
> > > scaled considering current frequency (and CPU max capacity), otherwise
> > > they are going to receive less runtime than granted at AC, when
> > > frequency is reduced.
> > 
> > I don't think that quite works out. Given that the frequency selection
> > will never quite end up at exactly the same fraction (if the hardware
> > listens to your requests at all).
> > 
> 
> It's an approximation yes (how big it depends on the granularity of the
> available frequencies). But, for the !GRUB tasks it should be OK, as we
> always select a frequency (among the available ones) bigger than the
> current active utilization.
> 
> Also, for platforms/archs that don't redefine arch_scale_* this is not
> used. In case they are defined instead the assumption is that either hw
> listens to requests or scaling factors can be derived in some other ways
> (avgs?).
> 
> > Also, by not scaling the GRUB stuff, don't you run the risk of
> > attempting to hand out more idle time than there actually is?
> 
> The way I understand it is that for GRUB tasks we always scale
> considering the "correct" factor. Then frequency could be higher, but
> this spare idle time will be reclaimed by other GRUB tasks.

I'm still confused..

So GRUB does:

	dq = Uact -dt

right? (yeah, I know, the code does something a little more complicated,
but it should still be more or less the same of you take out the 'extra'
bits).

Now, you do DVFS using that same Uact. If we lower the clock, we need
more time, so would we then not end up with something like:

	dq = 1/Uact -dt

After all; our budget assignment is such that we're able to complete
our work at max freq. Therefore, when we lower the frequency, we'll have
to increase budget pro rata, otherwise we'll not complete our work and
badness happens.

Say we have a 1 Ghz part and Uact=0.5 we'd select 500 Mhz and need
double the time to complete.

Now, if we fold these two together, you'd get:

	dq = Uact/Uact -dt = -dt

Because, after all, if we lowered the clock to consume all idle time,
there's no further idle time to reclaim.

Now, of course, our DVFS assignment isn't as precise nor as
deterministic as this, so we'll get a slightly different ratio, lets
call that Udvfs.

So would then not GRUB change into something like:

	dq = Uact/Udvfs -dt

Allowing it to only reclaim that idle time that exists because our DVFS
level is strictly higher than required?

This way, on our 1 GHz part, with Uact=.5 but Udvfs=.6, we'll allow it
to reclaim just the additional 100Mhz of idle time.


Or am I completely off the rails now?
