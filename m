From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [RFC/RFT][PATCH 2/2] cpufreq: schedutil: Utilization aggregation
Date: Tue, 11 Apr 2017 23:03:51 +0200
Message-ID: <CAJZ5v0iApX_LBCr--kOV0LzJyy-LhgYLaNV9hER8zXeF0R3F=Q@mail.gmail.com>
References: <3498238.liCqOyIkGA@aspire.rjw.lan> <2242635.g1ACnTm5vK@aspire.rjw.lan>
 <20170410112607.GD30804@e106622-lin> <CAJZ5v0iR_LvqE7Xa0fyrjwUH2X-H9MaK730QVgZ72xEwEq=FRg@mail.gmail.com>
 <20170411070044.GK30804@e106622-lin>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-oi0-f68.google.com ([209.85.218.68]:33194 "EHLO
        mail-oi0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753273AbdDKVDw (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 11 Apr 2017 17:03:52 -0400
In-Reply-To: <20170411070044.GK30804@e106622-lin>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Juri Lelli <juri.lelli@arm.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux PM <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Viresh Kumar <viresh.kumar@linaro.org>, Vincent Guittot <vincent.guittot@linaro.org>, Patrick Bellasi <patrick.bellasi@arm.com>, Joel Fernandes <joelaf@google.com>, Morten Rasmussen <morten.rasmussen@arm.com>, Thomas Gleixner <tglx@linutronix.de>

On Tue, Apr 11, 2017 at 9:00 AM, Juri Lelli <juri.lelli@arm.com> wrote:
> On 10/04/17 23:13, Rafael J. Wysocki wrote:
>> On Mon, Apr 10, 2017 at 1:26 PM, Juri Lelli <juri.lelli@arm.com> wrote:
>
> [...]
>
>> > Given that for RT (and still for DL as well) the next event is a
>> > periodic tick, couldn't happen that the required frequency transition
>> > for an RT task, that unfortunately woke up before the end of a throttling
>> > period, gets delayed of a tick interval (at least 4ms on ARM)?
>>
>> No, that won't be an entire tick unless it wakes up exactly at the
>> update time AFAICS.
>>
>
> Right. I was trying to think about worst case, as I'm considering RT
> type of tasks.
>
>> > Don't we need to treat such wake up events (RT/DL) in a special way and
>> > maybe set a timer to fire and process them as soon as the current
>> > throttling period elapses? Might be a patch on top of this I guess.
>>
>> Setting a timer won't be a good idea at all, as it would need to be a
>> deferrable one and Thomas would not like that (I'm sure).
>>
>
> Why deferrable? IMHO, we should be servicing RT requestes as soon as the
> HW is capable of. Even a small delay of, say, a couple of ms could be
> causing deadline misses.

If it is not deferrable, it will wake up the CPU from idle, but that's
not a concern here, because we're assuming that the CPU is not idle
anyway, so fair enough.

>> We could in principle add some special casing around that, like for
>> example pass flags to sugov_should_update_freq() and opportunistically
>> ignore freq_update_delay_ns if SCHED_CPUFREQ_RT_DL is set in there,
>> but that would lead to extra overhead on systems where frequency
>> updates happen in-context.
>>
>
> Also, it looks still event driven to me. If the RT task is the only
> thing running, nothing will trigger a potential frequency change
> re-evaluation before the next tick.

If freq_update_delay_ns is opportunistically ignored for
SCHED_CPUFREQ_RT_DL set in the flags by sugov_should_update_freq(),
then all of the updates with that flag set will cause a frequency
update to happen immediately *except* *for* the ones that require us
to wait for work_in_progress to become false, but in that case the
kthread might trigger an update (eg. by scheduling an irq_work) after
it has cleared work_in_progress.

No timers needed I guess after all? :-)

>> Also the case looks somewhat corner to me to be honest.
>>
>
> Sure. Only thinking about potential problems here. However, playing with
> my DL patches I noticed that this can be actually a problem, as for DL,
> for example, we trigger a frequency switch when the task wakes up, but
> then we don't do anything during the tick (because it doesn't seem to
> make sense to do anything :). So, if we missed the opportunity to
> increase frequency at enqueue time, the task is hopelessly done. :(
>
> Anyway, since this looks anyway something that we might want on top of
> your patches, I'll play with the idea when refreshing my set and see
> what I get.

Sounds good.

Thanks,
Rafael
