From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [RFCv7 PATCH 03/10] sched: scheduler-driven cpu frequency selection
Date: Sun, 28 Feb 2016 03:26:21 +0100
Message-ID: <14036594.SVLbCmZIEY@vostro.rjw.lan>
References: <1456190570-4475-1-git-send-email-smuckle@linaro.org> <2385082.eyZDGGeAFk@vostro.rjw.lan> <56D1236A.3030301@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:55013 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S2992732AbcB1CYo (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sat, 27 Feb 2016 21:24:44 -0500
In-Reply-To: <56D1236A.3030301@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Steve Muckle <steve.muckle@linaro.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, "Rafael J. Wysocki" <rafael@kernel.org>, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>, Morten Rasmussen <morten.rasmussen@arm.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>, Juri Lelli <Juri.Lelli@arm.com>, Patrick Bellasi <patrick.bellasi@arm.com>, Michael Turquette <mturquette@baylibre.com>, Ricky Liang <jcliang@chromium.org>

On Friday, February 26, 2016 08:17:46 PM Steve Muckle wrote:
> On 02/26/2016 06:39 PM, Rafael J. Wysocki wrote:
> >>> One thing I personally like in the RCU-based approach is its universality.  The
> >>> callbacks may be installed by different entities in a uniform way: intel_pstate
> >>> can do that, the old governors can do that, my experimental schedutil code can
> >>> do that and your code could have done that too in principle.  And this is very
> >>> nice, because it is a common underlying mechanism that can be used by everybody
> >>> regardless of their particular implementations on the other side.
> >>>
> >>> Why would I want to use something different, then?
> >>
> >> I've got nothing against a callback registration mechanism. As you
> >> mentioned in another mail it could itself use static keys, enabling the
> >> static key when a callback is registered and disabling it otherwise to
> >> avoid calling into cpufreq_update_util().
> > 
> > But then it would only make a difference if cpufreq_update_util() was not
> > used at all (ie. no callbacks installed for any policies by anyone).  The
> > only reason why it may matter is that the total number of systems using
> > the performance governor is quite large AFAICS and they would benefit from
> > that.
> 
> I'd think that's a benefit worth preserving, but I guess that's Peter
> and Ingo's call.

That's exactly what I said to Peter. :-)

[cut]

> > 
> > That said I'm unconvinced about the approach still.
> > 
> > Having more RT threads in a system that already is under RT pressure seems like
> > a recipe for trouble.  Moreover, it's likely that those new RT threads will
> > disturb the system's normal operation somehow even without the RT pressure and
> > have you investigated that?
> 
> Sorry I'm not sure what you mean by disturb normal operation.

That would introduce a number of extra RT threads that would be woken up quite
often and on a regular basis, so there would be some extra RT noise in the
system, especially on systems with one CPU per cpufreq policy and many CPUs.

That's not present ATM and surely need not be completely transparent.

> Generally speaking, increasing the capacity of a heavily loaded system
> seems to me to be something that should run urgently, so that the system
> can potentially get itself out of trouble and meet the workload's needs.
> 
> > Also having them per policy may be overkill and
> > binding them to policy CPUs only is not necessary.
> > 
> > Overall, it looks like a dynamic pool of threads that may run on every CPU
> > might be a better approach, but that would almost duplicate the workqueues
> > subsystem, so is it really worth it?
> > 
> > And is the problem actually visible in practice?  I have no record of any reports
> > mentioning it, although theoretically it's been there forever, so had it been
> > real, someone would have noticed it and complained about it IMO.
> 
> While I don't have a test case drawn up to provide it seems like it'd be
> easy to create one. More importantly the interactive governor in Android
> uses this same kind of model, starting a frequency change thread and
> making it RT. Android is particularly sensitive to latency in frequency
> response. So that's likely one big reason why you're not hearing about
> this issue - some folks have already worked around it.

OK, so Android is the reason. :-)

Fair enough.  I still think that care is needed here, though.

[cut]

> >>
> >> I've nothing against a new fast switch driver interface. It may be nice
> >> to support unmodified drivers in the fast path as well, if it can be
> >> made to work, even though it may not be optimal.
> > 
> > My bet is that you'd need to modify drivers for that anyway, because none of
> > them meet the fast path requirements for the very simple reason that they
> > weren't designed with that in mind.
> > 
> > So if you need to modify them anyway, why not to add a new callback to them
> > in the process?
> 
> This implies to me that there are drivers which can be made to work in
> the fast path (i.e. do not sleep and are reasonably quick) but currently
> do not. Are there really such drivers? Why would they have unnecessary
> blocking or work in them?

The ACPI driver is an example here.  It uses smp_call_function_many() to
run stuff on policy CPUs and that cannot be called from the fast path,
so the driver has to be modified.

> I would have thought that if a driver sleeps or is slow, it is because
> of platform limitations (like a blocking call to adjust a regulator)
> which are unavoidable.

Well, if you don't need to worry about sleeping, it's common to use
things like mutexes for synchronization etc.  Quite simply, if you don't
expect that the given piece of code will ever be run from interrupt
context, you'll not code for that and the scheduler paths have even more
restrictions than typical interrupt handlers.

> >>>
> >>>> +		mutex_unlock(&gd->slowpath_lock);
> >>>> +	}
> >>>> +
> >>>> +out:
> >>>> +	raw_spin_unlock(&gd->fastpath_lock);
> >>>> +}
> >>>> +
> >>>> +void update_cpu_capacity_request(int cpu, bool request)
> >>>> +{
> >>>> +	unsigned long new_capacity;
> >>>> +	struct sched_capacity_reqs *scr;
> >>>> +
> >>>> +	/* The rq lock serializes access to the CPU's sched_capacity_reqs. */
> >>>> +	lockdep_assert_held(&cpu_rq(cpu)->lock);
> >>>> +
> >>>> +	scr = &per_cpu(cpu_sched_capacity_reqs, cpu);
> >>>> +
> >>>> +	new_capacity = scr->cfs + scr->rt;
> >>>> +	new_capacity = new_capacity * capacity_margin
> >>>> +		/ SCHED_CAPACITY_SCALE;
> >>>> +	new_capacity += scr->dl;
> >>>
> >>> Can you please explain the formula here?
> >>
> >> The deadline class is expected to provide precise enough capacity
> >> requirements (since tasks admitted to it have CPU bandwidth parameters)
> >> such that it does not require additional CPU headroom.
> >>
> >> So we're applying the CPU headroom to the CFS and RT capacity requests
> >> only, then adding the DL request.
> >>
> >> I'll add a comment here.
> > 
> > One thing that has escaped me: How do you take policy->min into account?
> > In particular, what if you end up with a frequency below policy->min?
> 
> __cpufreq_driver_target will floor the request with policy->min.

I see.

> > 
> > [cut]
> > 
> >>>> +	/*
> >>>> +	 * Ensure that all CPUs currently part of this policy are out
> >>>> +	 * of the hot path so that if this policy exits we can free gd.
> >>>> +	 */
> >>>> +	preempt_disable();
> >>>> +	smp_call_function_many(policy->cpus, dummy, NULL, true);
> >>>> +	preempt_enable();
> >>>
> >>> I'm not sure how this works, can you please tell me?
> >>
> >> Peter correctly interpreted my intentions.
> >>
> >> The RCU possibility also crossed my mind. They both seemed like a bit of
> >> a hack to me - this wouldn't really be doing any RCU per se, rather
> >> relying on its implementation. I'll switch to RCU since that seems to be
> >> preferred though. It's certainly cleaner to write.
> > 
> > Well, in that case you simply can switch over to using cpufreq_update_util()
> > callbacks and then you'll get that part for free.
> 
> I'm not sure. Removing the callbacks by itself doesn't guarantee all the
> CPUs are out of them - don't you still need something to synchronize
> with that?

The update_util pointers are dereferenced and checked against NULL and the
callbacks are run (if present) in the same RCU read-side critical section.
synchronize_rcu() ensures that (a) all of the previously running read-side
critical sections complete before it returns and (b) all of the read-side
critical sections that begin after it has returned will see the new value
of the pointer.  This guarantees that the callbacks will not be running
after clearing the update_util pointers and executing synchronize_rcu().

> > Overall, sorry to say that, I don't quite see much to salvage in this patch.
> > 
> > The throttling implementation is a disaster.  The idea of having RT worker
> > threads per policy is questionable for a few reasons.  The idea of invoking
> > the existing driver callbacks from the fast path is not a good one and
> > trying to use __cpufreq_driver_target() for that only makes it worse.
> > The mutex manipulations under a raw spinlock are firmly in the "don't do
> > that" category and the static keys won't be useful any more or need to be
> > used elsewhere.
> > 
> > The way that you compute the frequency to ask for kind of might be defended,
> > but it has problems too, like arbitrary factors coming out of thin air.
> > 
> > So what's left then, realistically?
> 
> Aside from the throttling, which I agree was a last minute and
> not-well-thought-out addition and needs to be fixed, I'd still challenge
> the statements above. But I don't think there's much point. I'm happy to
> work towards enabling ARM in schedutil.

Cool! :-)

> I have some review comments which I am just finishing up and will send shortly.

I've responded to those already I think.

Thanks,
Rafael

