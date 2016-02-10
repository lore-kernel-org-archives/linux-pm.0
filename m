From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH 0/3] cpufreq: Replace timers with utilization update callbacks
Date: Wed, 10 Feb 2016 04:09:33 +0100
Message-ID: <CAJZ5v0jF4rJVeauZi08FYbDp6qsB4y3g--O4tx=C15go8z9nbw@mail.gmail.com>
References: <3071836.JbNxX8hU6x@vostro.rjw.lan>
	<56B93548.9090006@linaro.org>
	<CAJZ5v0gJwLVezLTLwGX=GDrsGeH6X040JmOaW6_uX2XzQwO9mg@mail.gmail.com>
	<5387313.xAhVpzgZCg@vostro.rjw.lan>
	<56BA8C29.4090905@linaro.org>
	<CAJZ5v0gBzjz9d7eBLZj3bYNLexTCs+UtNpLwWyZMDTA_Gi=zRg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-lb0-f194.google.com ([209.85.217.194]:35619 "EHLO
	mail-lb0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753263AbcBJDJf (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 9 Feb 2016 22:09:35 -0500
In-Reply-To: <CAJZ5v0gBzjz9d7eBLZj3bYNLexTCs+UtNpLwWyZMDTA_Gi=zRg@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Steve Muckle <steve.muckle@linaro.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Peter Zijlstra <peterz@infradead.org>, Linux PM list <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Viresh Kumar <viresh.kumar@linaro.org>, Juri Lelli <juri.lelli@arm.com>, Thomas Gleixner <tglx@linutronix.de>

On Wed, Feb 10, 2016 at 2:57 AM, Rafael J. Wysocki <rafael@kernel.org> wrote:
> On Wed, Feb 10, 2016 at 2:02 AM, Steve Muckle <steve.muckle@linaro.org> wrote:
>> On 02/09/2016 12:05 PM, Rafael J. Wysocki wrote:
>>>>> One concern I had was, given that the lone scheduler update hook is in
>>>>> CFS, is it possible for governor updates to be stalled due to RT or DL
>>>>> task activity?
>>>>
>>>> I don't think they may be completely stalled, but I'd prefer Peter to
>>>> answer that as he suggested to do it this way.
>>>
>>> In any case, if that concern turns out to be significant in practice, it may
>>> be addressed like in the appended modification of patch [1/3] from the $subject
>>> series.
>>>
>>> With that things look like before from the cpufreq side, but the other sched
>>> classes also get a chance to trigger a cpufreq update.  The drawback is the
>>> cpu_clock() call instead of passing the time value from update_load_avg(), but
>>> I guess we can live with that if necessary.
>>>
>>> FWIW, this modification doesn't seem to break things on my test machine.
>>>
>> ...
>>> Index: linux-pm/kernel/sched/rt.c
>>> ===================================================================
>>> --- linux-pm.orig/kernel/sched/rt.c
>>> +++ linux-pm/kernel/sched/rt.c
>>> @@ -2212,6 +2212,9 @@ static void task_tick_rt(struct rq *rq,
>>>
>>>       update_curr_rt(rq);
>>>
>>> +     /* Kick cpufreq to prevent it from stalling. */
>>> +     cpufreq_kick();
>>> +
>>>       watchdog(rq, p);
>>>
>>>       /*
>>> Index: linux-pm/kernel/sched/deadline.c
>>> ===================================================================
>>> --- linux-pm.orig/kernel/sched/deadline.c
>>> +++ linux-pm/kernel/sched/deadline.c
>>> @@ -1197,6 +1197,9 @@ static void task_tick_dl(struct rq *rq,
>>>  {
>>>       update_curr_dl(rq);
>>>
>>> +     /* Kick cpufreq to prevent it from stalling. */
>>> +     cpufreq_kick();
>>> +
>>>       /*
>>>        * Even when we have runtime, update_curr_dl() might have resulted in us
>>>        * not being the leftmost task anymore. In that case NEED_RESCHED will
>>
>> I think additional hooks such as enqueue/dequeue would be needed in
>> RT/DL. The task tick callbacks will only run if a task in that class is
>> executing at the time of the tick. There could be intermittent RT/DL
>> task activity in a frequency domain (the only task activity there, no
>> CFS tasks) that doesn't happen to overlap the tick. Worst case the task
>> activity could be periodic in such a way that it never overlaps the tick
>> and the update is never made.
>
> So if I'm reading this correctly, it would be better to put the hooks
> into update_curr_rt/dl()?

If done this way, I guess we may pass rq_clock_task(rq) as the time
arg to cpufreq_update_util() from there and then the cpu_lock() call
I've added to this prototype won't be necessary any more.

Thanks,
Rafael
