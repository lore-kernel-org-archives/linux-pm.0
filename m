From: Steve Muckle <steve.muckle@linaro.org>
Subject: Re: sched-freq locking
Date: Thu, 21 Jan 2016 11:29:30 -0800
Message-ID: <56A1319A.80005@linaro.org>
References: <CAKfTPtCYUWBm_=GQ-NLLZ01xJqG+83vy4uapxRLjqMx_61HSew@mail.gmail.com>
 <569E90CF.9050503@linaro.org>
 <CAEG3pND5kHqJhrvwVjsnCnfT-nSrV8SrUaNk2p=ZfEx0MmmB=A@mail.gmail.com>
 <569EB225.4040707@linaro.org>
 <CAEG3pNBgpsdX8Lk7_3nHd31_bsq2sLB_f+=4_xiFFbiAWiKsxg@mail.gmail.com>
 <569EE1E1.3050407@linaro.org> <20160120121801.GR8573@e106622-lin>
 <569F9EB3.60600@linaro.org> <20160120155829.GV8573@e106622-lin>
 <569FF21C.9070502@linaro.org> <20160121094513.GW8573@e106622-lin>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160121094513.GW8573@e106622-lin>
Sender: linux-kernel-owner@vger.kernel.org
To: Juri Lelli <Juri.Lelli@arm.com>
Cc: Michael Turquette <mturquette@baylibre.com>, Vincent Guittot <vincent.guittot@linaro.org>, Patrick Bellasi <patrick.bellasi@arm.com>, Morten Rasmussen <morten.rasmussen@arm.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>, Viresh Kumar <viresh.kumar@linaro.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Javi Merino <Javi.Merino@arm.com>, Punit Agrawal <punit.agrawal@arm.com>
List-Id: linux-pm@vger.kernel.org

On 01/21/2016 01:45 AM, Juri Lelli wrote:
>>> Mmm, can't the fact that the scheduler might think it can still request
>>> a frequency above max be problematic?
>>
>> I don't think so because cpufreq is going to clamp the incoming request
>> to be within policy->min and policy->max anyway (see
>> __cpufreq_driver_target() near the top). So nothing's going to
>> break/catch fire.
>>
> 
> Right. I wasn't worried about this, but rather by the fact that the
> scheduler might think there is enough space in a CPU (and balance tasks
> accordingly) when that space has actually been restricted by thermal.
> But, I also think there are ways to prevent this from happening, we just
> need to be aware of such a problem.

Ah ok. This seems to me like an issue strictly between scheduler and
thermal.

>
...
>>>> Currently schedfreq has to go through two stages of aggregation. The
>>>> first is aggregating the capacity request votes from the different sched
>>>> classes within a CPU. The second is aggregating the capacity request
>>>> votes from the CPUs within a frequency domain. I'm looking to solve the
>>>> locking issues with both of these stages as well as those with calling
>>>> into cpufreq in the fast path.
>>>>
>>>> For the first stage, currently we assume that the rq lock is held. This
>>>> is the case for the existing calls into schedfreq (the load balancer
>>>> required a minor change). There are a few more hooks that need to go
>>>> into migration paths in core.c which will be slightly more painful, but
>>>> they are IMO doable.
>>>>
>>>> For the second stage I believe an internal schedfreq spinlock is
>>>> required, for one thing to protect against competing updates within the
>>>> same frequency domain from different CPUs, but also so that we can
>>>> guarantee the cpufreq policy is valid, which can be done if the
>>>> governor_start/stop callbacks take the spinlock as well.
>>>>
>>>
>>> Does this need to nest within the rq lock?
>>
>> I think it will have to because I suspect releasing the rq lock to run
>> the second stage, then re-acquiring it afterwards, will cause breakage
>> in the scheduler paths from which this is all being called.
>>
> 
> Right, that's what I was thinking too. However, we need to be aware that
> we might add some overhead caused by contention on this new spinlock.
> 
>> Otherwise I don't see a requirement within schedfreq for it to be nested.
>>
> 
> OTOH, doesn't second stage happen on the kthread (when we need to
> sleep)?

The second stage of aggregation currently happens in the fast path as well.

The frequency transition occurs either in the fast or slow path
depending on driver capability, throttling, and whether a request is
currently in progress.

> 
...
>>> OTOH, all the needed aggregation could make the fast path not so fast in
>>> the end. So, maybe having a fast and a slow path is always good?
>>
>> Sorry I didn't follow... What do you mean by having a fast and a slow path?
> 
> Sorry, I wasn't clear enough. What I was trying to say is that having
> two different paths, one fast where we aggregate locally and fire a
> request and a second one slower where we aggregate per frequency domain,
> compute the new request and call cpufreq, might be always desirable;
> even on system that could issue frequency changes without sleeping.

I think this is going to result in too much overhead because you'll have
to wake up the kthread most of the time. Any time the local CPU's
capacity request change equates to a different required CPU frequency,
you'll need to wake up the kthread to aggregate the CPU votes. If
another CPU in the domain has a higher or equal frequency request (a
common occurance) the kthread will wake to do nothing. And
waking/context switching to/running a thread seems very costly.

The next step from that is to make a note of the current max request in
the freq domain as MikeT suggested. This would be done during
aggregation in the slow path and then the fast path could avoid waking
the kthread when its capacity change request wouldn't impact the overall
frequency. I think this will need some further complexity to work such
as a mask of CPUs which are currently requesting the max frequency (or
at least a bit saying there's more than one). But it might lessen the
work in the fast path. I'd like to get the locking addressed and send
out another RFC prior to exploring that change though. Another internal
schedfreq lock will be required either way.

thanks,
Steve
