From: Steve Muckle <steve.muckle@linaro.org>
Subject: Re: sched-freq locking
Date: Wed, 20 Jan 2016 12:46:20 -0800
Message-ID: <569FF21C.9070502@linaro.org>
References: <569D568D.5000500@linaro.org>
 <CAEG3pNDoDHpgO7WdC8n7C8Ri+KNKZqOi9rKHMkTV0c5dkyevOw@mail.gmail.com>
 <CAKfTPtCYUWBm_=GQ-NLLZ01xJqG+83vy4uapxRLjqMx_61HSew@mail.gmail.com>
 <569E90CF.9050503@linaro.org>
 <CAEG3pND5kHqJhrvwVjsnCnfT-nSrV8SrUaNk2p=ZfEx0MmmB=A@mail.gmail.com>
 <569EB225.4040707@linaro.org>
 <CAEG3pNBgpsdX8Lk7_3nHd31_bsq2sLB_f+=4_xiFFbiAWiKsxg@mail.gmail.com>
 <569EE1E1.3050407@linaro.org> <20160120121801.GR8573@e106622-lin>
 <569F9EB3.60600@linaro.org> <20160120155829.GV8573@e106622-lin>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f46.google.com ([209.85.220.46]:35290 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752770AbcATUqX (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 20 Jan 2016 15:46:23 -0500
Received: by mail-pa0-f46.google.com with SMTP id ho8so10222819pac.2
        for <linux-pm@vger.kernel.org>; Wed, 20 Jan 2016 12:46:23 -0800 (PST)
In-Reply-To: <20160120155829.GV8573@e106622-lin>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Juri Lelli <Juri.Lelli@arm.com>
Cc: Michael Turquette <mturquette@baylibre.com>, Vincent Guittot <vincent.guittot@linaro.org>, Patrick Bellasi <patrick.bellasi@arm.com>, Morten Rasmussen <morten.rasmussen@arm.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>, Viresh Kumar <viresh.kumar@linaro.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Javi Merino <Javi.Merino@arm.com>, Punit Agrawal <punit.agrawal@arm.com>

Hi Juri,

On 01/20/2016 07:58 AM, Juri Lelli wrote:
> On 20/01/16 06:50, Steve Muckle wrote:
>> On 01/20/2016 04:18 AM, Juri Lelli wrote:
>>> I fear that caching could break thermal. If everybody was already using
>>> sched-freq interface to control frequency this won't probably be a
>>> problem, but we are not yet there :(. So, IIUC by caching policy->max,
>>> for example, we might affect what thermal expects from cpufreq.
>>
>> I think we could probably just access policy->max without rwsem, as long
>> as we ensure policy is valid. Cpufreq will take care to cap a frequency
>> request to an upper limit put in by thermal anyway so I don't think it's
>> a problematic race. But I haven't spent much time thinking about it.
>>
> 
> Mmm, can't the fact that the scheduler might think it can still request
> a frequency above max be problematic?

I don't think so because cpufreq is going to clamp the incoming request
to be within policy->min and policy->max anyway (see
__cpufreq_driver_target() near the top). So nothing's going to
break/catch fire.

The question to me is, if the system gets throttled (or un-throttled)
just as you are evaluating capacity requests, are you actually better
off using the new policy->max value to scale? I suspect not, because the
recent load tracking statistics and hence the capacity requests will
have been calculated based on the original policy->max rather than the
one that was just written.

Perhaps a decayed version of policy->max could be maintained and used to
scale instead. Not sure if this will be enough of an issue in practice
though to warrant it...

> 
...
> 
>> Currently schedfreq has to go through two stages of aggregation. The
>> first is aggregating the capacity request votes from the different sched
>> classes within a CPU. The second is aggregating the capacity request
>> votes from the CPUs within a frequency domain. I'm looking to solve the
>> locking issues with both of these stages as well as those with calling
>> into cpufreq in the fast path.
>>
>> For the first stage, currently we assume that the rq lock is held. This
>> is the case for the existing calls into schedfreq (the load balancer
>> required a minor change). There are a few more hooks that need to go
>> into migration paths in core.c which will be slightly more painful, but
>> they are IMO doable.
>>
>> For the second stage I believe an internal schedfreq spinlock is
>> required, for one thing to protect against competing updates within the
>> same frequency domain from different CPUs, but also so that we can
>> guarantee the cpufreq policy is valid, which can be done if the
>> governor_start/stop callbacks take the spinlock as well.
>>
> 
> Does this need to nest within the rq lock?

I think it will have to because I suspect releasing the rq lock to run
the second stage, then re-acquiring it afterwards, will cause breakage
in the scheduler paths from which this is all being called.

Otherwise I don't see a requirement within schedfreq for it to be nested.

>
>> As for accessing various things in cpufreq->policy and trying to take
>> rwsem in the fast path, we should be able to either cache some of the
>> items in the governor_start() path, eliminate the references, or access
>> them without locking rwsem (as long as we know the policy is valid,
> 
> If we only need to guarantee existence of the policy, without any direct
> updates, RCU might be a good fit.

It must be guaranteed that policy->cpus and policy->freq_table are
current/synchronized with cpufreq for the duration of the second stage.
I think this precludes the use of RCU.

We're going to need an internal schedfreq spinlock to arbitrate multiple
CPUs in a frequency domain trying to go through the hot path
concurrently anyway, so we're really just extending that critical
section to the governor start and stop callbacks where we can safely
cache some of the policy data.

> 
>> which we do by taking the spinlock in governor_start()). Here are the
>> things we currently reference in the schedfreq set capacity hook and my
>> thoughts on each of them:
>>
>> policy->governor: this is currently tested to see if schedfreq is
>> enabled, but this can be tracked internally to schedfreq and set in the
>> governor_start/stop callbacks
>>
>> policy->governor_data: used to access schedfreq's data for the policy,
>> could be changed to an internal schedfreq percpu pointer
>>
>> policy->cpus, policy->freq_table: these can be cached internally to
>> schedfreq on governor_start/stop
>>
>> policy->max: as mentioned above I *think* we could get away with
>> accessing this without locking rwsem as discussed above
>>
>> policy->transition_ongoing: this isn't strictly required as schedfreq
>> could track internally whether it has a transition outstanding, but we
>> should also be okay to look at this without policy->rwsem since
>> schedfreq is the only one queuing transitions, again assuming we take
>> care to ensure policy is valid as above
>>
>> Finally when actually requesting a frequency change in the fast path, we
>> can trylock policy->rwsem and fall back to the slow path (kthread) if
>> that fails.
>>
> 
> OTOH, all the needed aggregation could make the fast path not so fast in
> the end. So, maybe having a fast and a slow path is always good?

Sorry I didn't follow... What do you mean by having a fast and a slow path?

thanks,
Steve

