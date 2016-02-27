From: Steve Muckle <steve.muckle@linaro.org>
Subject: Re: [RFCv7 PATCH 03/10] sched: scheduler-driven cpu frequency
 selection
Date: Fri, 26 Feb 2016 20:17:46 -0800
Message-ID: <56D1236A.3030301@linaro.org>
References: <1456190570-4475-1-git-send-email-smuckle@linaro.org>
 <8427745.Y8N2bqC3SO@vostro.rjw.lan> <56CF9D8F.7010607@linaro.org>
 <2385082.eyZDGGeAFk@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <2385082.eyZDGGeAFk@vostro.rjw.lan>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, "Rafael J. Wysocki" <rafael@kernel.org>, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>, Morten Rasmussen <morten.rasmussen@arm.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>, Juri Lelli <Juri.Lelli@arm.com>, Patrick Bellasi <patrick.bellasi@arm.com>, Michael Turquette <mturquette@baylibre.com>, Ricky Liang <jcliang@chromium.org>
List-Id: linux-pm@vger.kernel.org

On 02/26/2016 06:39 PM, Rafael J. Wysocki wrote:
>>> One thing I personally like in the RCU-based approach is its universality.  The
>>> callbacks may be installed by different entities in a uniform way: intel_pstate
>>> can do that, the old governors can do that, my experimental schedutil code can
>>> do that and your code could have done that too in principle.  And this is very
>>> nice, because it is a common underlying mechanism that can be used by everybody
>>> regardless of their particular implementations on the other side.
>>>
>>> Why would I want to use something different, then?
>>
>> I've got nothing against a callback registration mechanism. As you
>> mentioned in another mail it could itself use static keys, enabling the
>> static key when a callback is registered and disabling it otherwise to
>> avoid calling into cpufreq_update_util().
> 
> But then it would only make a difference if cpufreq_update_util() was not
> used at all (ie. no callbacks installed for any policies by anyone).  The
> only reason why it may matter is that the total number of systems using
> the performance governor is quite large AFAICS and they would benefit from
> that.

I'd think that's a benefit worth preserving, but I guess that's Peter
and Ingo's call.

> 
...
>>>> +/*
>>>> + * Capacity margin added to CFS and RT capacity requests to provide
>>>> + * some head room if task utilization further increases.
>>>> + */
>>>
>>> OK, where does this number come from?
>>
>> Someone's posterior :) .
>>
>> This really should be a tunable IMO, but there's a fairly strong
>> anti-tunable sentiment, so it's been left hard-coded in an attempt to
>> provide something that "just works."
> 
> Ouch.
> 
>> At the least I can add a comment saying that the 20% idle headroom
>> requirement was an off the cuff estimate and that at this time, we don't
>> have significant data to suggest it's the best number.
> 
> Well, in this area, every number has to be justified.  Otherwise we end
> up with things that sort of work, but nobody actually understands why.

It's just a starting point. There's a lot of profiling and tuning that
has yet to happen. We figured there were larger design issues to discuss
prior to spending a lot of time tweaking the headroom value.

> 
> [cut]
> 
>>>
>>>> +
>>>> +static int cpufreq_sched_thread(void *data)
>>>> +{
>>>
>>> Now, what really is the advantage of having those extra threads vs using
>>> workqueues?
>>>
>>> I guess the underlying concern is that RT tasks may stall workqueues indefinitely
>>> in theory and then the frequency won't be updated, but there's much more kernel
>>> stuff run from workqueues and if that is starved, you won't get very far anyway.
>>>
>>> If you take special measures to prevent frequency change requests from being
>>> stalled by RT tasks, question is why are they so special?  Aren't there any
>>> other kernel activities that also should be protected from that and may be
>>> more important than CPU frequency changes?
>>
>> I think updating the CPU frequency during periods of heavy RT/DL load is
>> one of the most (if not the most) important things. I can't speak for
>> other system activities that may get blocked, but there's an opportunity
>> to protect CPU frequency changes here, and it seems worth taking to me.
> 
> So do it in a general way for everybody and not just for one governor
> that you happen to be working on.
> 
> That said I'm unconvinced about the approach still.
> 
> Having more RT threads in a system that already is under RT pressure seems like
> a recipe for trouble.  Moreover, it's likely that those new RT threads will
> disturb the system's normal operation somehow even without the RT pressure and
> have you investigated that?

Sorry I'm not sure what you mean by disturb normal operation.

Generally speaking, increasing the capacity of a heavily loaded system
seems to me to be something that should run urgently, so that the system
can potentially get itself out of trouble and meet the workload's needs.

> Also having them per policy may be overkill and
> binding them to policy CPUs only is not necessary.
> 
> Overall, it looks like a dynamic pool of threads that may run on every CPU
> might be a better approach, but that would almost duplicate the workqueues
> subsystem, so is it really worth it?
> 
> And is the problem actually visible in practice?  I have no record of any reports
> mentioning it, although theoretically it's been there forever, so had it been
> real, someone would have noticed it and complained about it IMO.

While I don't have a test case drawn up to provide it seems like it'd be
easy to create one. More importantly the interactive governor in Android
uses this same kind of model, starting a frequency change thread and
making it RT. Android is particularly sensitive to latency in frequency
response. So that's likely one big reason why you're not hearing about
this issue - some folks have already worked around it.

> 
>>>
>>> Plus if this really is the problem here, then it also affects the other cpufreq
>>> governors, so maybe it should be solved for everybody in some common way?
>>
>> Agreed, I'd think a freq change thread that serves frequency change
>> requests would be a useful common component. The locking and throttling
>> (slowpath_lock, finish_last_request()) are somewhat specific to this
>> implementation, but could probably be done generically and maybe even
>> used in other governors. If you're okay with it though I'd like to view
>> that as a slightly longer term effort, as I think it would get unwieldy
>> trying to do that as part of this initial change.
> 
> I really am not sure if this is useful at all, so why bother with it initially?

I still think ensuring CPU frequency changes aren't delayed by other
task activity is useful...

> 
...
>>>
>>>> +}
>>>> +
>>>> +static void update_fdomain_capacity_request(int cpu)
>>>> +{
>>>> +	unsigned int freq_new, index_new, cpu_tmp;
>>>> +	struct cpufreq_policy *policy;
>>>> +	struct gov_data *gd = per_cpu(cpu_gov_data, cpu);
>>>> +	unsigned long capacity = 0;
>>>> +
>>>> +	if (!gd)
>>>> +		return;
>>>> +
>>>
>>> Why is this check necessary?
>>
>> As soon as one policy in the system uses scheduler-guided frequency the
>> static key will be enabled and all CPUs will be calling into the
>> scheduler hooks and can potentially come through this path. But some
>> CPUs may not be part of a scheduler-guided frequency policy. Those CPUs
>> will have a NULL gov_data pointer.
>>
>> That being said, I think this test should be moved up into
>> update_cpu_capacity_request() to avoid that computation when it is not
>> required. Better still would be bailing when required in the
>> set_*_cpu_capacity() macros in kernel/sched/sched.h. I'll see if I can
>> do that instead.
> 
> If you switch over to using cpufreq_update_util() callbacks like the other
> governors, you won't need it any more, because then you'll be guaranteed that
> you won't run if the callback hasn't been installed for this CPU.

Sure.

> 
...
>>>> +		irq_work_queue_on(&gd->irq_work, cpu);
>>>
>>> I hope that you are aware of the fact that irq_work_queue_on() explodes
>>> on uniprocessor ARM32 if you run an SMP kernel on it?
>>
>> No, I wasn't. Fortunately I think switching it to irq_work_queue() to
>> run the irq_work on the same CPU as the fast path should be fine
>> (assuming there's no similar landmine there).
> 
> You don't have to run it on the same CPU, though.  It doesn't matter what
> CPU kicks your worker thread, does it?

I don't want to wake a random CPU to potentially just do the kick.

> 
> [cut]
> 
>>>> +	} else {
>>>> +		cpufreq_sched_try_driver_target(policy, freq_new);
>>>
>>> Well, this is supposed to be the fast path AFAICS.
>>>
>>> Did you actually look at what __cpufreq_driver_target() does in general?
>>> Including the wait_event() in cpufreq_freq_transition_begin() to mention just
>>> one suspicious thing?  And how much overhead it generates in the most general
>>> case?
>>>
>>> No, running *that* from the fast path is not a good idea.  Quite honestly,
>>> you'd need a new driver callback and a new way to run it from the cpufreq core
>>> to implement this in a reasonably efficient way.
>>
>> Yes I'm aware of the wait_event(). I've attempted to work around it by
>> ensuring schedfreq does not issue a __cpufreq_driver_target attempt
>> while a transition is in flight (transition_ongoing), and ensuring the
>> slow and fast paths can't race. I'm not sure yet whether this is enough
>> if something like thermal or userspace changes min/max, whether that can
>> independently start a transition that may cause a fast path request here
>> to block. This governor does not use the dbs stuff.
>>
>> While it's not exactly lean, I didn't see anything else in
>> __cpufreq_driver_target() that looked really terrible.
>>
>> I've nothing against a new fast switch driver interface. It may be nice
>> to support unmodified drivers in the fast path as well, if it can be
>> made to work, even though it may not be optimal.
> 
> My bet is that you'd need to modify drivers for that anyway, because none of
> them meet the fast path requirements for the very simple reason that they
> weren't designed with that in mind.
> 
> So if you need to modify them anyway, why not to add a new callback to them
> in the process?

This implies to me that there are drivers which can be made to work in
the fast path (i.e. do not sleep and are reasonably quick) but currently
do not. Are there really such drivers? Why would they have unnecessary
blocking or work in them?

I would have thought that if a driver sleeps or is slow, it is because
of platform limitations (like a blocking call to adjust a regulator)
which are unavoidable.

> 
>>>
>>>> +		mutex_unlock(&gd->slowpath_lock);
>>>> +	}
>>>> +
>>>> +out:
>>>> +	raw_spin_unlock(&gd->fastpath_lock);
>>>> +}
>>>> +
>>>> +void update_cpu_capacity_request(int cpu, bool request)
>>>> +{
>>>> +	unsigned long new_capacity;
>>>> +	struct sched_capacity_reqs *scr;
>>>> +
>>>> +	/* The rq lock serializes access to the CPU's sched_capacity_reqs. */
>>>> +	lockdep_assert_held(&cpu_rq(cpu)->lock);
>>>> +
>>>> +	scr = &per_cpu(cpu_sched_capacity_reqs, cpu);
>>>> +
>>>> +	new_capacity = scr->cfs + scr->rt;
>>>> +	new_capacity = new_capacity * capacity_margin
>>>> +		/ SCHED_CAPACITY_SCALE;
>>>> +	new_capacity += scr->dl;
>>>
>>> Can you please explain the formula here?
>>
>> The deadline class is expected to provide precise enough capacity
>> requirements (since tasks admitted to it have CPU bandwidth parameters)
>> such that it does not require additional CPU headroom.
>>
>> So we're applying the CPU headroom to the CFS and RT capacity requests
>> only, then adding the DL request.
>>
>> I'll add a comment here.
> 
> One thing that has escaped me: How do you take policy->min into account?
> In particular, what if you end up with a frequency below policy->min?

__cpufreq_driver_target will floor the request with policy->min.

> 
> [cut]
> 
>>>> +	/*
>>>> +	 * Ensure that all CPUs currently part of this policy are out
>>>> +	 * of the hot path so that if this policy exits we can free gd.
>>>> +	 */
>>>> +	preempt_disable();
>>>> +	smp_call_function_many(policy->cpus, dummy, NULL, true);
>>>> +	preempt_enable();
>>>
>>> I'm not sure how this works, can you please tell me?
>>
>> Peter correctly interpreted my intentions.
>>
>> The RCU possibility also crossed my mind. They both seemed like a bit of
>> a hack to me - this wouldn't really be doing any RCU per se, rather
>> relying on its implementation. I'll switch to RCU since that seems to be
>> preferred though. It's certainly cleaner to write.
> 
> Well, in that case you simply can switch over to using cpufreq_update_util()
> callbacks and then you'll get that part for free.

I'm not sure. Removing the callbacks by itself doesn't guarantee all the
CPUs are out of them - don't you still need something to synchronize
with that?

> Overall, sorry to say that, I don't quite see much to salvage in this patch.
> 
> The throttling implementation is a disaster.  The idea of having RT worker
> threads per policy is questionable for a few reasons.  The idea of invoking
> the existing driver callbacks from the fast path is not a good one and
> trying to use __cpufreq_driver_target() for that only makes it worse.
> The mutex manipulations under a raw spinlock are firmly in the "don't do
> that" category and the static keys won't be useful any more or need to be
> used elsewhere.
> 
> The way that you compute the frequency to ask for kind of might be defended,
> but it has problems too, like arbitrary factors coming out of thin air.
> 
> So what's left then, realistically?

Aside from the throttling, which I agree was a last minute and
not-well-thought-out addition and needs to be fixed, I'd still challenge
the statements above. But I don't think there's much point. I'm happy to
work towards enabling ARM in schedutil. I have some review comments
which I am just finishing up and will send shortly.

thanks,
Steve
