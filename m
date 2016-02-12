From: Vincent Guittot <vincent.guittot@linaro.org>
Subject: Re: [PATCH 0/3] cpufreq: Replace timers with utilization update callbacks
Date: Fri, 12 Feb 2016 15:48:54 +0100
Message-ID: <CAKfTPtA42zK+2pm71gDpodynYWXtKBqc-G5bFBh8aCKU=GPh_g@mail.gmail.com>
References: <3071836.JbNxX8hU6x@vostro.rjw.lan> <56B93548.9090006@linaro.org>
 <CAJZ5v0gJwLVezLTLwGX=GDrsGeH6X040JmOaW6_uX2XzQwO9mg@mail.gmail.com>
 <5387313.xAhVpzgZCg@vostro.rjw.lan> <56BA8C29.4090905@linaro.org>
 <20160211115959.GI6357@twins.programming.kicks-ass.net> <20160211122429.GM11415@e106622-lin>
 <20160211152625.GM6357@twins.programming.kicks-ass.net> <CAKfTPtCRAyqx96rNuotHD2qtxBQkBa6K+-kk5bGQB2VbMq+k2A@mail.gmail.com>
 <20160212140415.GS6357@twins.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-lf0-f50.google.com ([209.85.215.50]:35021 "EHLO
	mail-lf0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750945AbcBLOtQ (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 12 Feb 2016 09:49:16 -0500
Received: by mail-lf0-f50.google.com with SMTP id l143so53115829lfe.2
        for <linux-pm@vger.kernel.org>; Fri, 12 Feb 2016 06:49:15 -0800 (PST)
In-Reply-To: <20160212140415.GS6357@twins.programming.kicks-ass.net>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Peter Zijlstra <peterz@infradead.org>
Cc: Juri Lelli <juri.lelli@arm.com>, Steve Muckle <steve.muckle@linaro.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, "Rafael J. Wysocki" <rafael@kernel.org>, Linux PM list <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Viresh Kumar <viresh.kumar@linaro.org>, Thomas Gleixner <tglx@linutronix.de>

On 12 February 2016 at 15:04, Peter Zijlstra <peterz@infradead.org> wrote:
> On Thu, Feb 11, 2016 at 07:23:55PM +0100, Vincent Guittot wrote:
>> I agree that using rt_avg is not the best choice to evaluate the
>> capacity that is used by RT tasks but it has the advantage of been
>> already there. Do you mean that we should use another way to compute
>> the capacity that is used by rt tasks to then select the frequency  ?
>
> Nope, RR/FIFO simply do not contain enough information to compute
> anything from.
>
>> Or do you mean that we can't do anything else than asking for max
>> frequency ?
>
> Yep.
>
>> Trying to set max frequency just before scheduling RT task is not
>> really doable on a lot of platform because the sequence that changes
>> the frequency can sleep and takes more time than the run time of the
>> task.
>
> So what people do today is shoot cpufreq in the head and not use it,
> maybe that's the 'right' thing on these platforms.
>
>> At the end, we will have set max frequency once the task has
>> finished to run. There is no other solution than increasing the
>> min_freq of cpufreq to a level that will ensure enough compute
>> capacity for RT task with such high constraints that cpufreq can't
>> react.
>
> But you cannot a priori tell how much time RR/FIFO tasks will require,
> that's the entire problem with them. We can compute a hysterical
> average, but that _will_ mis predict the future and get you
> underruns/deadline misses.
>
>> For other RT tasks, we can probably found a way to set a
>> frequency that can fit both RT constraints and power consumption.
>
> You cannot, not without adding a lot more information about what these
> tasks are doing, and that is not captured in the task model.

Another point to take into account is that the RT tasks will "steal"
the compute capacity that has been requested by the cfs tasks.

Let takes the example of a CPU with 3 OPP on which run 2 rt tasks A
and B and 1 cfs task C.
Let assume that the real time constraint of RT task A is too agressive
for the lowest OPP0 and that the change of the frequency of the core
is too slow compare to this constraint but the real time constraint of
RT task B can be handle whatever the OPP. System don't have other
choice than setting the cpufreq min freq to OPP1 to be sure that
constraint of task A will be covered at anytime. Then, we still have 2
possible OPPs. The CFS task asks for compute capacity that fits in
OPP1 but a part of this capacity will be stolen by RT tasks. If we
monitor the load of RT tasks and request capacity for these RT tasks
according to their current utilization, we can decide to switch to
highest OPP2 to ensure that task C will have enough remaining
capacity. A lot of embedded platform faces such kind of use cases
