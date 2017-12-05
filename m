From: Juri Lelli <juri.lelli@redhat.com>
Subject: Re: [RFC PATCH v2 3/8] sched/cpufreq_schedutil: make worker kthread
 be SCHED_DEADLINE
Date: Tue, 5 Dec 2017 13:34:00 +0100
Message-ID: <20171205123400.GA15085@localhost.localdomain>
References: <20171204102325.5110-1-juri.lelli@redhat.com>
 <20171204102325.5110-4-juri.lelli@redhat.com>
 <20171205115509.GK31247@e110439-lin>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20171205115509.GK31247@e110439-lin>
Sender: linux-kernel-owner@vger.kernel.org
To: Patrick Bellasi <patrick.bellasi@arm.com>
Cc: peterz@infradead.org, mingo@redhat.com, rjw@rjwysocki.net, viresh.kumar@linaro.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, tglx@linutronix.de, vincent.guittot@linaro.org, rostedt@goodmis.org, luca.abeni@santannapisa.it, claudio@evidence.eu.com, tommaso.cucinotta@santannapisa.it, bristot@redhat.com, mathieu.poirier@linaro.org, tkjos@android.com, joelaf@google.com, morten.rasmussen@arm.com, dietmar.eggemann@arm.com, alessio.balsini@arm.com, Juri Lelli <juri.lelli@arm.com>, Ingo Molnar <mingo@kernel.org>, "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>
List-Id: linux-pm@vger.kernel.org

Hi,

On 05/12/17 11:55, Patrick Bellasi wrote:
> Hi Juri,
> 
> On 04-Dec 11:23, Juri Lelli wrote:
> [...]
> 
> > diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_schedutil.c
> > index de1ad1fffbdc..c22457868ee6 100644
> > --- a/kernel/sched/cpufreq_schedutil.c
> > +++ b/kernel/sched/cpufreq_schedutil.c
> > @@ -475,7 +475,20 @@ static void sugov_policy_free(struct sugov_policy *sg_policy)
> >  static int sugov_kthread_create(struct sugov_policy *sg_policy)
> >  {
> >  	struct task_struct *thread;
> > -	struct sched_param param = { .sched_priority = MAX_USER_RT_PRIO / 2 };
> > +	struct sched_attr attr = {
> > +		.size = sizeof(struct sched_attr),
> > +		.sched_policy = SCHED_DEADLINE,
> > +		.sched_flags = SCHED_FLAG_SUGOV,
> > +		.sched_nice = 0,
> > +		.sched_priority = 0,
> > +		/*
> > +		 * Fake (unused) bandwidth; workaround to "fix"
> > +		 * priority inheritance.
> > +		 */
> > +		.sched_runtime	=  1000000,
> > +		.sched_deadline = 10000000,
> > +		.sched_period	= 10000000,
> 
> Why not assigning a minimal (but yet CBS accounted) bandwidth to
> this DL task?
> 
> I understand that it should be a minimal task which bandwidth
> requirement is likely into the "noise".
> Is there any other more specific reason?
> 

At least two, IMHO.

1. Throttling: assigning any sort of bandwidth is difficult (every
platform is different), and if that is too small the task responsible
for changing frequency might be throttled and delayed; if too big you
are wasting resources.

2. Affinity: some platform affine these kthreads to related_cpus; and it
is something you might want to do to save power anyway. Problem with DL
is that (at least currently) you are not free to change a task's
affinity mask without creating an exclusive cpuset.

[...]

> > +static inline
> > +void add_rq_bw(struct sched_dl_entity *dl_se, struct dl_rq *dl_rq)
> > +{
> > +	if (!(dl_se->flags & SCHED_FLAG_SUGOV))
> > +		__add_rq_bw(dl_se->dl_bw, dl_rq);
> 
> What about using for all these wrappers the same utility function you
> already use in this source file? I.e.
> 
>         if (unlikely(dl_entity_is_special(dl_se)))
>                 return;
>         __add_rq_bw(dl_se->dl_bw, dl_rq);

Should work. I'll try to do the change.

[...]

> > @@ -2436,6 +2472,9 @@ int sched_dl_overflow(struct task_struct *p, int policy,
> >  	u64 new_bw = dl_policy(policy) ? to_ratio(period, runtime) : 0;
> >  	int cpus, err = -1;
> >  
> > +	if (attr->sched_flags & SCHED_FLAG_SUGOV)
> > +		return 0;
> > +
> 
> Same note on using:
> 
>         if (unlikely(dl_entity_is_special(dl_se)))
> 
> here and in the next chunk too.

OK.

> 
> >  	/* !deadline task may carry old deadline bandwidth */
> >  	if (new_bw == p->dl.dl_bw && task_has_dl_policy(p))
> >  		return 0;
> > @@ -2522,6 +2561,10 @@ void __getparam_dl(struct task_struct *p, struct sched_attr *attr)
> >   */
> >  bool __checkparam_dl(const struct sched_attr *attr)
> >  {
> > +	/* special dl tasks don't actually use any parameter */
> > +	if (attr->sched_flags & SCHED_FLAG_SUGOV)
> > +		return true;
> > +
> >  	/* deadline != 0 */
> >  	if (attr->sched_deadline == 0)
> >  		return false;
> > diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
> > index a1730e39cbc6..280b421a82e8 100644
> > --- a/kernel/sched/sched.h
> > +++ b/kernel/sched/sched.h
> > @@ -156,13 +156,33 @@ static inline int task_has_dl_policy(struct task_struct *p)
> >  	return dl_policy(p->policy);
> >  }
> >  
> > +/*
> > + * !! For sched_setattr_nocheck() (kernel) only !!
> > + *
> > + * This is actually gross. :(
> > + *
> > + * It is used to make schedutil kworker(s) higher priority than SCHED_DEADLINE
> > + * tasks, but still be able to sleep. We need this on platforms that cannot
> > + * atomically change clock frequency. Remove once fast switching will be
> > + * available on such platforms.
> > + *
> > + * SUGOV stands for SchedUtil GOVernor.
> > + */
> > +#define SCHED_FLAG_SUGOV	0x10000000
> > +
> > +static inline int dl_entity_is_special(struct sched_dl_entity *dl_se)
> 
> This should better return a bool...
> 
> 
> > +{
> 
> ... and maybe it can optimize some builds via constants propagations to add:
> 
> #ifdef CONFIG_CPU_FREQ_GOV_SCHEDUTIL
> > +	return dl_se->flags & SCHED_FLAG_SUGOV;
> #else
>         return false;
> #endif

Sure.

> 
> > +}
> > +
> >  /*
> >   * Tells if entity @a should preempt entity @b.
> >   */
> >  static inline bool
> >  dl_entity_preempt(struct sched_dl_entity *a, struct sched_dl_entity *b)
> >  {
> > -	return dl_time_before(a->deadline, b->deadline);
> > +	return dl_entity_is_special(a) ||
> > +	       dl_time_before(a->deadline, b->deadline);
> 
> Given that being special is less likely, perhaps better to have:
> 
>        return dl_time_before(a->deadline, b->deadline) ||
>               dl_entity_is_special(a);

OK.

Thanks for the review!

Best,

- Juri
