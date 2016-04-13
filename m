From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH 1/2] sched/fair: move cpufreq hook to update_cfs_rq_load_avg()
Date: Wed, 13 Apr 2016 06:48:21 +0200
Message-ID: <CAJZ5v0hx6mG5EzU4q-OFxcKQP3CZcY+H_+PqYVfL4aAPkxmoDA@mail.gmail.com>
References: <56F97856.4040804@arm.com>
	<56F98832.3030207@linaro.org>
	<20160330193544.GD407@worktop>
	<56FC807C.80204@linaro.org>
	<20160331073743.GF3408@twins.programming.kicks-ass.net>
	<56FD95EE.6090007@linaro.org>
	<20160401092019.GN3430@twins.programming.kicks-ass.net>
	<570BFAE2.4080301@linaro.org>
	<CAJZ5v0imtij-smQBds1aTNMuFsNbbzvoyAJ5-=Pp8Ae1GSNWvQ@mail.gmail.com>
	<CAJZ5v0gNt5kMV8jjQuASTxUBE=FZ45x2Go0RNsyaZMLk+dAsKQ@mail.gmail.com>
	<20160413000824.GB22643@graphite.smuckle.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-lf0-f66.google.com ([209.85.215.66]:35352 "EHLO
	mail-lf0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757537AbcDMEsX (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 13 Apr 2016 00:48:23 -0400
In-Reply-To: <20160413000824.GB22643@graphite.smuckle.net>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Steve Muckle <steve.muckle@linaro.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Dietmar Eggemann <dietmar.eggemann@arm.com>, Ingo Molnar <mingo@redhat.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Vincent Guittot <vincent.guittot@linaro.org>, Morten Rasmussen <morten.rasmussen@arm.com>, Juri Lelli <Juri.Lelli@arm.com>, Patrick Bellasi <patrick.bellasi@arm.com>, Michael Turquette <mturquette@baylibre.com>

On Wed, Apr 13, 2016 at 2:08 AM, Steve Muckle <steve.muckle@linaro.org> wrote:
> On Tue, Apr 12, 2016 at 04:29:06PM +0200, Rafael J. Wysocki wrote:
>> This is rather fundamental.
>>
>> For example, if you look at cpufreq_update_util(), it does this:
>>
>> data = rcu_dereference_sched(*this_cpu_ptr(&cpufreq_update_util_data));
>>
>> meaning that it will run the current CPU's utilization update
>> callback.  Of course, that won't work cross-CPU, because in principle
>> different CPUs may use different governors and therefore different
>> util update callbacks.
>
> Will something like the attached (unfinished patches) work? It seems
> to for me, but I haven't tested it much beyond confirming the hook is
> working on remote wakeups.

No, they are not sufficient.

First of all, you need to take all of the governors into account and
they all make assumptions about updates being run on the CPU being
updated.

That should be easy to take into account for ondemand/conservative,
but intel_pstate is a different story.

> I'm relying on the previous comment that it's up to cpufreq drivers to
> run stuff on the target policy's CPUs if the driver needs that.

That's not the case for the fast frequency switching though, which has
to happen on the CPU running the code.

> There's still some more work, fixing up some more smp_processor_id()
> usage in schedutil, but it should be easy (trace, slow path irq_work
> target).
>
>> If you want to do remote updates, I guess that will require an
>> irq_work to run the update on the target CPU, but then you'll probably
>> want to neglect the rate limit on it as well, so it looks like a
>> "need_update" flag in struct update_util_data will be useful for that.
>
> Why is it required to run the update on the target CPU?

The fast switching and intel_pstate are the main reason.

They both have to write to registers of the target CPU and the code to
do that needs to run on that CPU.

Thanks,
Rafael
