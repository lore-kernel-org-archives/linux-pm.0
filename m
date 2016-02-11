From: Vincent Guittot <vincent.guittot@linaro.org>
Subject: Re: [PATCH 0/3] cpufreq: Replace timers with utilization update callbacks
Date: Thu, 11 Feb 2016 19:23:55 +0100
Message-ID: <CAKfTPtCRAyqx96rNuotHD2qtxBQkBa6K+-kk5bGQB2VbMq+k2A@mail.gmail.com>
References: <3071836.JbNxX8hU6x@vostro.rjw.lan> <56B93548.9090006@linaro.org>
 <CAJZ5v0gJwLVezLTLwGX=GDrsGeH6X040JmOaW6_uX2XzQwO9mg@mail.gmail.com>
 <5387313.xAhVpzgZCg@vostro.rjw.lan> <56BA8C29.4090905@linaro.org>
 <20160211115959.GI6357@twins.programming.kicks-ass.net> <20160211122429.GM11415@e106622-lin>
 <20160211152625.GM6357@twins.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-lb0-f182.google.com ([209.85.217.182]:34468 "EHLO
	mail-lb0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750885AbcBKSYR (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 11 Feb 2016 13:24:17 -0500
Received: by mail-lb0-f182.google.com with SMTP id cw1so32709500lbb.1
        for <linux-pm@vger.kernel.org>; Thu, 11 Feb 2016 10:24:16 -0800 (PST)
In-Reply-To: <20160211152625.GM6357@twins.programming.kicks-ass.net>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Peter Zijlstra <peterz@infradead.org>
Cc: Juri Lelli <juri.lelli@arm.com>, Steve Muckle <steve.muckle@linaro.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, "Rafael J. Wysocki" <rafael@kernel.org>, Linux PM list <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Viresh Kumar <viresh.kumar@linaro.org>, Thomas Gleixner <tglx@linutronix.de>

On 11 February 2016 at 16:26, Peter Zijlstra <peterz@infradead.org> wrote:
> On Thu, Feb 11, 2016 at 12:24:29PM +0000, Juri Lelli wrote:
>> Hi Peter,
>>
>> On 11/02/16 12:59, Peter Zijlstra wrote:
>> >
>> > No, for RT (RR/FIFO) we do not have enough information to do anything
>> > useful. Basically RR/FIFO should result in running 100% whenever we
>> > schedule such a task.
>> >
>> > That means RR/FIFO want a hook in pick_next_task_rt() to bump the freq
>> > to 100% and leave it there until something else gets to run.
>> >
>>
>> Vincent is trying to play with rt_avg (in the last sched-freq thread) to
>> see if we can get some information about RT as well. I understand that
>> from a theoretical perspective that's not much we can say of such tasks,
>> and bumping to max can be the only sensible thing to do, but there are
>> users of RT (ehm, Android) that will probably see differences in energy
>> consumption if we do so. Yeah, maybe the should use a different policy,
>> yes.
>
> Can't we just leave broken people get broken results? Trying to use
> rt_avg for this is just insane. We should ensure that people using this
> thing correctly get correct results, the rest can take a hike.
>
> Using rt_avg gets us to the place where people who want to do the right
> thing cannot, and that is bad.

I agree that using rt_avg is not the best choice to evaluate the
capacity that is used by RT tasks but it has the advantage of been
already there. Do you mean that we should use another way to compute
the capacity that is used by rt tasks to then select the frequency  ?
Or do you mean that we can't do anything else than asking for max
frequency ?

Trying to set max frequency just before scheduling RT task is not
really doable on a lot of platform because the sequence that changes
the frequency can sleep and takes more time than the run time of the
task. At the end, we will have set max frequency once the task has
finished to run. There is no other solution than increasing the
min_freq of cpufreq to a level that will ensure enough compute
capacity for RT task with such high constraints that cpufreq can't
react. For other RT tasks, we can probably found a way to set a
frequency that can fit both RT constraints and power consumption.

>
>> > For DL it basically wants to set a minimum freq based on reserved
>> > utilization, so that is __setparam_dl() or somewhere around there.
>> >
>>
>> I think we could do better than this once Luca's reclaiming stuff gets
>> in. The reserved bw is usually somewhat pessimistic. But this is a
>> different discussion, maybe.
>
> Sure, there's cleverer things that can be done. But a simple one would
> indeed be the min guarantee based on accepted bandwidth.
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pm" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
