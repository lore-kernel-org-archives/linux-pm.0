From: Steve Muckle <steve.muckle@linaro.org>
Subject: Re: [PATCH v6 7/7][Resend] cpufreq: schedutil: New governor based on
 scheduler utilization data
Date: Mon, 28 Mar 2016 11:17:44 -0700
Message-ID: <56F97548.1030903@linaro.org>
References: <7262976.zPkLj56ATU@vostro.rjw.lan>
 <6666532.7ULg06hQ7e@vostro.rjw.lan> <56F5E1F2.5090100@linaro.org>
 <CAJZ5v0j=LwOT=sjSOwwzY=sYLqiV1tuvVazzgU+yMwMWXmpR8A@mail.gmail.com>
 <CAJZ5v0i1=P45wWHYHVp9mW=h7w_MywFz7x2qmEs2iiEhJSq-5g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f50.google.com ([209.85.220.50]:34917 "EHLO
	mail-pa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751544AbcC1SRr (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 28 Mar 2016 14:17:47 -0400
Received: by mail-pa0-f50.google.com with SMTP id td3so103290511pab.2
        for <linux-pm@vger.kernel.org>; Mon, 28 Mar 2016 11:17:47 -0700 (PDT)
In-Reply-To: <CAJZ5v0i1=P45wWHYHVp9mW=h7w_MywFz7x2qmEs2iiEhJSq-5g@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux PM list <linux-pm@vger.kernel.org>, Juri Lelli <juri.lelli@arm.com>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Viresh Kumar <viresh.kumar@linaro.org>, Vincent Guittot <vincent.guittot@linaro.org>, Michael Turquette <mturquette@baylibre.com>, Ingo Molnar <mingo@kernel.org>

On 03/26/2016 06:36 PM, Rafael J. Wysocki wrote:
>>>> +static int sugov_limits(struct cpufreq_policy *policy)
>>>> >>> +{
>>>> >>> +     struct sugov_policy *sg_policy = policy->governor_data;
>>>> >>> +
>>>> >>> +     if (!policy->fast_switch_enabled) {
>>>> >>> +             mutex_lock(&sg_policy->work_lock);
>>>> >>> +
>>>> >>> +             if (policy->max < policy->cur)
>>>> >>> +                     __cpufreq_driver_target(policy, policy->max,
>>>> >>> +                                             CPUFREQ_RELATION_H);
>>>> >>> +             else if (policy->min > policy->cur)
>>>> >>> +                     __cpufreq_driver_target(policy, policy->min,
>>>> >>> +                                             CPUFREQ_RELATION_L);
>>>> >>> +
>>>> >>> +             mutex_unlock(&sg_policy->work_lock);
>>>> >>> +     }
>>> >>
>>> >> Is the expectation that in the fast_switch_enabled case we should
>>> >> re-evaluate soon enough that an explicit fixup is not required here?
>> >
>> > Yes, it is.
>> >
>>> >> I'm worried as to whether that will always be true given the possible
>>> >> criticality of applying frequency limits (thermal for example).
>> >
>> > The part of the patch below that you cut actually takes care of that:
>> >
>> >     sg_policy->need_freq_update = true;
>> >
>> > which causes the rate limit to be ignored essentially, so the
>> > frequency will be changed on the first update from the scheduler.

The scenario I'm contemplating is that while a CPU-intensive task is
running a thermal interrupt goes off. The driver for this thermal
interrupt responds by capping fmax. If this happens just after the tick,
it seems possible that we could wait a full tick before changing the
frequency. Given a 10ms tick it could be rather annoying for thermal
management algorithms on some platforms (I'm familiar with a few).

>> > Which also is why the min/max check is before the sg_policy->next_freq
>> > == next_freq check in sugov_update_commit().
>> >
>> > I wanted to avoid locking in the fast switch/one CPU per policy case
>> > which otherwise would be necessary just for the handling of this
>> > thing.  I'd like to keep it the way it is unless it can be clearly
>> > demonstrated that it really would lead to problems in practice in a
>> > real system.
>
> Besides, even if frequency is updated directly from here in the "fast
> switch" case, that still doesn't guarantee that it will be updated
> immediately, because the task running this code may be preempted and
> only scheduled again in the next cycle.
>
> Not to mention the fact that it may not run on the CPU to be updated,
> so it would need to use something like smp_call_function_single() for
> the update and that would complicate things even more.
> 
> Overall, I don't really think that doing the update directly from here
> in the "fast switch" case would improve things much latency-wise and
> it would increase complexity and introduce overhead into the fast
> path.  So this really is a tradeoff and the current choice is the
> right one IMO.

On the desire to avoid locking in the fast switch/one CPU per policy
case, I wondered about whether disabling interrupts in sugov_limits()
would suffice. That's a rarely called function and I was hoping that the
update hook would already have interrupts disabled due to its being
called in scheduler paths that may do raw_spin_lock_irqsave. But I'm not
sure offhand that will always be true. If it isn't though then I'm not
sure what's necessarily stopping say the sched tick calling the hook
while the hook is already in progress from some other path.

Agreed there would need to be some additional complexity somewhere to
get things running on the correct CPU.

Anyway I have nothing against deferring this for now.

thanks,
Steve
