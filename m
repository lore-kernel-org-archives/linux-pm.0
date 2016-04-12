From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH 1/2] sched/fair: move cpufreq hook to update_cfs_rq_load_avg()
Date: Tue, 12 Apr 2016 16:29:06 +0200
Message-ID: <CAJZ5v0gNt5kMV8jjQuASTxUBE=FZ45x2Go0RNsyaZMLk+dAsKQ@mail.gmail.com>
References: <1458606068-7476-1-git-send-email-smuckle@linaro.org>
	<56F91D56.4020007@arm.com>
	<56F95D10.4070400@linaro.org>
	<56F97856.4040804@arm.com>
	<56F98832.3030207@linaro.org>
	<20160330193544.GD407@worktop>
	<56FC807C.80204@linaro.org>
	<20160331073743.GF3408@twins.programming.kicks-ass.net>
	<56FD95EE.6090007@linaro.org>
	<20160401092019.GN3430@twins.programming.kicks-ass.net>
	<570BFAE2.4080301@linaro.org>
	<CAJZ5v0imtij-smQBds1aTNMuFsNbbzvoyAJ5-=Pp8Ae1GSNWvQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-lf0-f66.google.com ([209.85.215.66]:33687 "EHLO
	mail-lf0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932996AbcDLO3I (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 12 Apr 2016 10:29:08 -0400
In-Reply-To: <CAJZ5v0imtij-smQBds1aTNMuFsNbbzvoyAJ5-=Pp8Ae1GSNWvQ@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Steve Muckle <steve.muckle@linaro.org>, Peter Zijlstra <peterz@infradead.org>, Dietmar Eggemann <dietmar.eggemann@arm.com>, Ingo Molnar <mingo@redhat.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Vincent Guittot <vincent.guittot@linaro.org>, Morten Rasmussen <morten.rasmussen@arm.com>, Juri Lelli <Juri.Lelli@arm.com>, Patrick Bellasi <patrick.bellasi@arm.com>, Michael Turquette <mturquette@baylibre.com>

On Mon, Apr 11, 2016 at 11:20 PM, Rafael J. Wysocki <rafael@kernel.org> wrote:
> On Mon, Apr 11, 2016 at 9:28 PM, Steve Muckle <steve.muckle@linaro.org> wrote:
>> Hi Rafael,
>>
>> On 04/01/2016 02:20 AM, Peter Zijlstra wrote:
>>>> > My thinking was in CFS we get rid of the (cpu == smp_processor_id())
>>>> > condition for calling the cpufreq hook.
>>>> >
>>>> > The sched governor can then calculate utilization and frequency required
>>>> > for cpu. If (cpu == smp_processor_id()), the update is processed
>>>> > normally. If (cpu != smp_processor_id()) and the new frequency is higher
>>>> > than cpu's Fcur, the sched gov IPIs cpu to continue running the update
>>>> > operation. Otherwise, the update is dropped.
>>>> >
>>>> > Does that sound plausible?
>>>
>>> Can be done I suppose..
>>
>> Currently we drop schedutil updates for a target CPU which do not occur
>> on that CPU.
>>
>> Is this solely due to platforms which must run the cpufreq driver on the
>> target CPU?
>
> The current code assumes that the CPU running the update will always
> be the one that gets updated.  Anything else would require extra
> synchronization.


This is rather fundamental.

For example, if you look at cpufreq_update_util(), it does this:

data = rcu_dereference_sched(*this_cpu_ptr(&cpufreq_update_util_data));

meaning that it will run the current CPU's utilization update
callback.  Of course, that won't work cross-CPU, because in principle
different CPUs may use different governors and therefore different
util update callbacks.

If you want to do remote updates, I guess that will require an
irq_work to run the update on the target CPU, but then you'll probably
want to neglect the rate limit on it as well, so it looks like a
"need_update" flag in struct update_util_data will be useful for that.

I think I can prototype something along these lines, but can you
please tell me more about the case you have in mind?

Thanks,
Rafael
