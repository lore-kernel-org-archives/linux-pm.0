From: Steve Muckle <steve.muckle@linaro.org>
Subject: Re: [PATCH 1/2] sched/fair: move cpufreq hook to
 update_cfs_rq_load_avg()
Date: Mon, 11 Apr 2016 12:28:34 -0700
Message-ID: <570BFAE2.4080301@linaro.org>
References: <1458606068-7476-1-git-send-email-smuckle@linaro.org>
 <56F91D56.4020007@arm.com> <56F95D10.4070400@linaro.org>
 <56F97856.4040804@arm.com> <56F98832.3030207@linaro.org>
 <20160330193544.GD407@worktop> <56FC807C.80204@linaro.org>
 <20160331073743.GF3408@twins.programming.kicks-ass.net>
 <56FD95EE.6090007@linaro.org>
 <20160401092019.GN3430@twins.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f42.google.com ([209.85.220.42]:36642 "EHLO
	mail-pa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755215AbcDKT2h (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 11 Apr 2016 15:28:37 -0400
Received: by mail-pa0-f42.google.com with SMTP id bx7so110828535pad.3
        for <linux-pm@vger.kernel.org>; Mon, 11 Apr 2016 12:28:36 -0700 (PDT)
In-Reply-To: <20160401092019.GN3430@twins.programming.kicks-ass.net>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Dietmar Eggemann <dietmar.eggemann@arm.com>, Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>, Morten Rasmussen <morten.rasmussen@arm.com>, Juri Lelli <Juri.Lelli@arm.com>, Patrick Bellasi <patrick.bellasi@arm.com>, Michael Turquette <mturquette@baylibre.com>

Hi Rafael,

On 04/01/2016 02:20 AM, Peter Zijlstra wrote:
>> > My thinking was in CFS we get rid of the (cpu == smp_processor_id())
>> > condition for calling the cpufreq hook.
>> > 
>> > The sched governor can then calculate utilization and frequency required
>> > for cpu. If (cpu == smp_processor_id()), the update is processed
>> > normally. If (cpu != smp_processor_id()) and the new frequency is higher
>> > than cpu's Fcur, the sched gov IPIs cpu to continue running the update
>> > operation. Otherwise, the update is dropped.
>> >
>> > Does that sound plausible?
>
> Can be done I suppose..

Currently we drop schedutil updates for a target CPU which do not occur
on that CPU.

Is this solely due to platforms which must run the cpufreq driver on the
target CPU?

Are there also shared cpufreq policies where the driver needs to run on
any CPU in the affected policy/freq domain?

thanks,
Steve
