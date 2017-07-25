From: Luca Abeni <luca.abeni@santannapisa.it>
Subject: Re: [RFC PATCH v1 8/8] sched/deadline: make bandwidth enforcement
 scale-invariant
Date: Tue, 25 Jul 2017 09:03:08 +0200
Message-ID: <20170725090308.2cca53c0@luca>
References: <20170705085905.6558-1-juri.lelli@arm.com>
        <20170705085905.6558-9-juri.lelli@arm.com>
        <20170719072143.lploljodns3kfucf@hirez.programming.kicks-ass.net>
        <20170719092029.oakmetq3u52e4rfw@e106622-lin>
        <20170719110028.uggud56bg2jh45ge@hirez.programming.kicks-ass.net>
        <20170719111624.fwcydcklmfeesfgb@e106622-lin>
        <20170724164349.clzsajrwxtobyqkm@hirez.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170724164349.clzsajrwxtobyqkm@hirez.programming.kicks-ass.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Zijlstra <peterz@infradead.org>
Cc: Juri Lelli <juri.lelli@arm.com>, mingo@redhat.com, rjw@rjwysocki.net, viresh.kumar@linaro.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, tglx@linutronix.de, vincent.guittot@linaro.org, rostedt@goodmis.org, claudio@evidence.eu.com, tommaso.cucinotta@santannapisa.it, bristot@redhat.com, mathieu.poirier@linaro.org, tkjos@android.com, joelaf@google.com, andresoportus@google.com, morten.rasmussen@arm.com, dietmar.eggemann@arm.com, patrick.bellasi@arm.com, Ingo Molnar <mingo@kernel.org>, "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>
List-Id: linux-pm@vger.kernel.org

Hi Peter,

On Mon, 24 Jul 2017 18:43:49 +0200
Peter Zijlstra <peterz@infradead.org> wrote:

> On Wed, Jul 19, 2017 at 12:16:24PM +0100, Juri Lelli wrote:
> > On 19/07/17 13:00, Peter Zijlstra wrote:  
> > > On Wed, Jul 19, 2017 at 10:20:29AM +0100, Juri Lelli wrote:  
> > > > On 19/07/17 09:21, Peter Zijlstra wrote:  
> > > > > On Wed, Jul 05, 2017 at 09:59:05AM +0100, Juri Lelli wrote:  
> > > > > > @@ -1156,9 +1157,26 @@ static void update_curr_dl(struct rq *rq)
> > > > > >  	if (unlikely(dl_entity_is_special(dl_se)))
> > > > > >  		return;
> > > > > >  
> > > > > > -	if (unlikely(dl_se->flags & SCHED_FLAG_RECLAIM))
> > > > > > -		delta_exec = grub_reclaim(delta_exec, rq, &curr->dl);
> > > > > > -	dl_se->runtime -= delta_exec;
> > > > > > +	/*
> > > > > > +	 * For tasks that participate in GRUB, we implement GRUB-PA: the
> > > > > > +	 * spare reclaimed bandwidth is used to clock down frequency.
> > > > > > +	 *
> > > > > > +	 * For the others, we still need to scale reservation parameters
> > > > > > +	 * according to current frequency and CPU maximum capacity.
> > > > > > +	 */
> > > > > > +	if (unlikely(dl_se->flags & SCHED_FLAG_RECLAIM)) {
> > > > > > +		scaled_delta_exec = grub_reclaim(delta_exec,
> > > > > > +						 rq,
> > > > > > +						 &curr->dl);
> > > > > > +	} else {
> > > > > > +		unsigned long scale_freq = arch_scale_freq_capacity(cpu);
> > > > > > +		unsigned long scale_cpu = arch_scale_cpu_capacity(NULL, cpu);
> > > > > > +
> > > > > > +		scaled_delta_exec = cap_scale(delta_exec, scale_freq);
> > > > > > +		scaled_delta_exec = cap_scale(scaled_delta_exec, scale_cpu);
> > > > > > +	}
> > > > > > +
> > > > > > +	dl_se->runtime -= scaled_delta_exec;
> > > > > >    
> > > > > 
> > > > > This I don't get...   
> > > > 
> > > > 
> > > > Considering that we use GRUB's active utilization to drive clock
> > > > frequency selection, rationale is that GRUB tasks don't need any special
> > > > scaling, as their delta_exec is already scaled according to GRUB rules.
> > > > OTOH, normal tasks need to have their runtime (delta_exec) explicitly
> > > > scaled considering current frequency (and CPU max capacity), otherwise
> > > > they are going to receive less runtime than granted at AC, when
> > > > frequency is reduced.  
> > > 
> > > I don't think that quite works out. Given that the frequency selection
> > > will never quite end up at exactly the same fraction (if the hardware
> > > listens to your requests at all).
> > >   
> > 
> > It's an approximation yes (how big it depends on the granularity of the
> > available frequencies). But, for the !GRUB tasks it should be OK, as we
> > always select a frequency (among the available ones) bigger than the
> > current active utilization.
> > 
> > Also, for platforms/archs that don't redefine arch_scale_* this is not
> > used. In case they are defined instead the assumption is that either hw
> > listens to requests or scaling factors can be derived in some other ways
> > (avgs?).
> >   
> > > Also, by not scaling the GRUB stuff, don't you run the risk of
> > > attempting to hand out more idle time than there actually is?  
> > 
> > The way I understand it is that for GRUB tasks we always scale
> > considering the "correct" factor. Then frequency could be higher, but
> > this spare idle time will be reclaimed by other GRUB tasks.  
> 
> I'm still confused..
> 
> So GRUB does:
> 
> 	dq = Uact -dt
> 
> right?

Right. This is what the original (single processor) GRUB did. And this
was used by the "GRUB-PA" algorithm:
https://www.researchgate.net/profile/Giuseppe_Lipari/publication/220800940_Using_resource_reservation_techniques_for_power-aware_scheduling/links/09e41513639b2703fc000000.pdf

(basically, GRUB-PA uses GRUB for reclaiming, and scales the CPU
frequency based on Uact)


> Now, you do DVFS using that same Uact. If we lower the clock, we need
> more time, so would we then not end up with something like:
> 
> 	dq = 1/Uact -dt

Well, in the GRUB-PA algorithm GRUB reclaiming is the mechanism used to
give more runtime to the task... Since Uact is < 1, doing
	dq = - Uact * dt
means that we decrease the current runtime by a smaller amount of time.
And so we end up giving more runtime to the task: instead of giving 
dl_runtime every dl_period, we give "dl_runtime / Uact" every
dl_period... And since the CPU is slower (by a ratio Uact), this is
equivalent to giving dl_runtime at the maximum CPU speed / frequency
(at least, in theory :).


> After all; our budget assignment is such that we're able to complete
> our work at max freq. Therefore, when we lower the frequency, we'll have
> to increase budget pro rata, otherwise we'll not complete our work and
> badness happens.

Right. But instead of increasing dl_runtime, GRUB-PA decreases the
amount of time accounted to the current runtime.


> Say we have a 1 Ghz part and Uact=0.5 we'd select 500 Mhz and need
> double the time to complete.
> 
> Now, if we fold these two together, you'd get:
> 
> 	dq = Uact/Uact -dt = -dt

Not sure why " / Uact"... According to the GRUB-PA algorithm, you just
do
	dq = - Uact * dt = -0.5dt
and you end up giving the CPU to the task for 2 * dl_runtime every
dl_period (as expected)

> Because, after all, if we lowered the clock to consume all idle time,
> there's no further idle time to reclaim.

The idea of GRUB-PA is that you do not change dl_runtime... So, the
task is still "nominally reserved" dl_runtime every dl_period (in
this example, 1/2*dl_period every dl_period)... It is the reclaiming
mechanism that allows the task to execute for dl_runtime/Uact every
dl_period (in this example, for dl_period every dl_period, so it
reclaims 1/2dl_period every dl_period).


> Now, of course, our DVFS assignment isn't as precise nor as
> deterministic as this, so we'll get a slightly different ratio, lets
> call that Udvfs.

This is where GRUB-PA starts to have issues... :)
The implicit assumption is (I think) that is the DVFS mechanism cannot
assign exactly the requested frequency then it makes a "conservative"
assignment (assigning a frequency higher than the requested one).


> So would then not GRUB change into something like:
> 
> 	dq = Uact/Udvfs -dt
> 
> Allowing it to only reclaim that idle time that exists because our DVFS
> level is strictly higher than required?

I think GRUB should still do "dq = -Uact * dt", trying to reclaim all
the idle CPU time (up to the configured limit, of course).



				Luca

> 
> This way, on our 1 GHz part, with Uact=.5 but Udvfs=.6, we'll allow it
> to reclaim just the additional 100Mhz of idle time.
> 
> 
> Or am I completely off the rails now?
