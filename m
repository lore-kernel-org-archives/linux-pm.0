From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH 1/2] sched/fair: move cpufreq hook to update_cfs_rq_load_avg()
Date: Mon, 11 Apr 2016 23:20:55 +0200
Message-ID: <CAJZ5v0imtij-smQBds1aTNMuFsNbbzvoyAJ5-=Pp8Ae1GSNWvQ@mail.gmail.com>
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
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-lf0-f65.google.com ([209.85.215.65]:36348 "EHLO
	mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753148AbcDKVU5 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 11 Apr 2016 17:20:57 -0400
In-Reply-To: <570BFAE2.4080301@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Steve Muckle <steve.muckle@linaro.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Dietmar Eggemann <dietmar.eggemann@arm.com>, Ingo Molnar <mingo@redhat.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Vincent Guittot <vincent.guittot@linaro.org>, Morten Rasmussen <morten.rasmussen@arm.com>, Juri Lelli <Juri.Lelli@arm.com>, Patrick Bellasi <patrick.bellasi@arm.com>, Michael Turquette <mturquette@baylibre.com>

On Mon, Apr 11, 2016 at 9:28 PM, Steve Muckle <steve.muckle@linaro.org> wrote:
> Hi Rafael,
>
> On 04/01/2016 02:20 AM, Peter Zijlstra wrote:
>>> > My thinking was in CFS we get rid of the (cpu == smp_processor_id())
>>> > condition for calling the cpufreq hook.
>>> >
>>> > The sched governor can then calculate utilization and frequency required
>>> > for cpu. If (cpu == smp_processor_id()), the update is processed
>>> > normally. If (cpu != smp_processor_id()) and the new frequency is higher
>>> > than cpu's Fcur, the sched gov IPIs cpu to continue running the update
>>> > operation. Otherwise, the update is dropped.
>>> >
>>> > Does that sound plausible?
>>
>> Can be done I suppose..
>
> Currently we drop schedutil updates for a target CPU which do not occur
> on that CPU.
>
> Is this solely due to platforms which must run the cpufreq driver on the
> target CPU?

The current code assumes that the CPU running the update will always
be the one that gets updated.  Anything else would require extra
synchronization.

> Are there also shared cpufreq policies where the driver needs to run on
> any CPU in the affected policy/freq domain?

Yes, there are, AFAICS, but drivers are expected to cope with that (if
I understand the question correctly).

Thanks,
Rafael
