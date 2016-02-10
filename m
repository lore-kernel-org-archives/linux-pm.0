From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH 0/3] cpufreq: Replace timers with utilization update callbacks
Date: Wed, 10 Feb 2016 16:46:15 +0100
Message-ID: <CAJZ5v0icm-3XBArLo1X4CFx1wcZykbhfis7PeW3aS11G5xY_Hw@mail.gmail.com>
References: <3071836.JbNxX8hU6x@vostro.rjw.lan>
	<56B93548.9090006@linaro.org>
	<CAJZ5v0gJwLVezLTLwGX=GDrsGeH6X040JmOaW6_uX2XzQwO9mg@mail.gmail.com>
	<5387313.xAhVpzgZCg@vostro.rjw.lan>
	<20160210123342.GA11415@e106622-lin>
	<CAJZ5v0gWV+Qc2CM6YN90=s+TE2HCDOZVCRH7nOrKFW+kGiOpDA@mail.gmail.com>
	<20160210140315.GD11415@e106622-lin>
	<CAJZ5v0jRSxZyKixTvOc3BDVxBLzx1HVeJhNEzX4UZA7txvEM9A@mail.gmail.com>
	<20160210144607.GG11415@e106622-lin>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-lb0-f193.google.com ([209.85.217.193]:36248 "EHLO
	mail-lb0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751640AbcBJPqR (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 10 Feb 2016 10:46:17 -0500
In-Reply-To: <20160210144607.GG11415@e106622-lin>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Juri Lelli <juri.lelli@arm.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Steve Muckle <steve.muckle@linaro.org>, Peter Zijlstra <peterz@infradead.org>, Linux PM list <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Viresh Kumar <viresh.kumar@linaro.org>, Thomas Gleixner <tglx@linutronix.de>

On Wed, Feb 10, 2016 at 3:46 PM, Juri Lelli <juri.lelli@arm.com> wrote:
> On 10/02/16 15:26, Rafael J. Wysocki wrote:
>> On Wed, Feb 10, 2016 at 3:03 PM, Juri Lelli <juri.lelli@arm.com> wrote:
>> > On 10/02/16 14:23, Rafael J. Wysocki wrote:
>> >> On Wed, Feb 10, 2016 at 1:33 PM, Juri Lelli <juri.lelli@arm.com> wrote:
>> >> > Hi Rafael,
>> >> >
>> >> > On 09/02/16 21:05, Rafael J. Wysocki wrote:
>> >> >
>> >> > [...]
>> >> >
>> >> >> +/**
>> >> >> + * cpufreq_update_util - Take a note about CPU utilization changes.
>> >> >> + * @util: Current utilization.
>> >> >> + * @max: Utilization ceiling.
>> >> >> + *
>> >> >> + * This function is called by the scheduler on every invocation of
>> >> >> + * update_load_avg() on the CPU whose utilization is being updated.
>> >> >> + */
>> >> >> +void cpufreq_update_util(unsigned long util, unsigned long max)
>> >> >> +{
>> >> >> +     struct update_util_data *data;
>> >> >> +
>> >> >> +     rcu_read_lock();
>> >> >> +
>> >> >> +     data = rcu_dereference(*this_cpu_ptr(&cpufreq_update_util_data));
>> >> >> +     if (data && data->func)
>> >> >> +             data->func(data, cpu_clock(smp_processor_id()), util, max);
>> >> >
>> >> > Are util and max used anywhere?
>> >>
>> >> They aren't yet, but they will be.
>> >>
>> >> Maybe not in this cycle (it it takes too much time to integrate the
>> >> preliminary changes), but we definitely are going to use those
>> >> numbers.
>> >>
>> >
>> > Oh OK. However, I was under the impression that this set was only
>> > proposing a way to get rid of timers and use the scheduler as heartbeat
>> > for cpufreq governors. The governors' sample based approach wouldn't
>> > change, though. Am I wrong in assuming this?
>>
>> Your assumption is correct.
>>
>
> In this case. Wouldn't be possible to simply put the kicks in
> sched/core.c? scheduler_tick() seems a good candidate for that, and you
> could complement that with enqueue/dequeue/etc., if needed.

That can be done, but they are not needed for things like idle and
stop, are they?

> I'm actually wondering if a slow CONFIG_HZ might affect governors'
> sampling rate. We might have scheduler tick firing every 40ms and
> sampling rate set to 10 or 20ms, don't we?

The smallest HZ you can get from the standard config is 100.  That
would translate to an update every 10ms roughly if my understanding of
things is correct.

Also I think that the scheduler and cpufreq should really work at the
same pace as they affect each other in any case.

>> The sample-based approach doesn't change at this time, simply to avoid
>> making too many changes in one go.
>>
>> The next step, as I'm seeing it, would be to use the
>> scheduler-provided utilization in the governor computations instead of
>> the load estimation made by governors themselves.
>>
>
> OK. But, I'm not sure what does this buy us. If the end goal is still to
> do sampling, aren't we better off using the (1 - idle) estimation as
> today?

First of all, we can avoid the need to compute this number entirely if
we use the scheduler-provided one.

Second, what if we come up with a different idea about the CPU
utilization than the scheduler has?  Who's right then?

Finally, the way this number is currently computed by cpufreq is based
on some questionable heuristics (and not just in one place), so maybe
it's better to stop doing that?

Also I didn't say that the *final* goal would be to do sampling.  I
was talking about the next step. :-)

Thanks,
Rafael
