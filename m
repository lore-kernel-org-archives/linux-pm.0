From: Steve Muckle <steve.muckle@linaro.org>
Subject: Re: [PATCH 1/2] sched/fair: move cpufreq hook to
 update_cfs_rq_load_avg()
Date: Wed, 13 Apr 2016 10:53:30 -0700
Message-ID: <570E879A.90008@linaro.org>
References: <56F97856.4040804@arm.com> <56F98832.3030207@linaro.org>
 <20160330193544.GD407@worktop> <56FC807C.80204@linaro.org>
 <20160331073743.GF3408@twins.programming.kicks-ass.net>
 <56FD95EE.6090007@linaro.org>
 <20160401092019.GN3430@twins.programming.kicks-ass.net>
 <570BFAE2.4080301@linaro.org>
 <CAJZ5v0imtij-smQBds1aTNMuFsNbbzvoyAJ5-=Pp8Ae1GSNWvQ@mail.gmail.com>
 <CAJZ5v0gNt5kMV8jjQuASTxUBE=FZ45x2Go0RNsyaZMLk+dAsKQ@mail.gmail.com>
 <20160412193857.GA22643@graphite.smuckle.net>
 <CAJZ5v0gRaP9s_B6ttEpBSqBcGRX-j+kNetyaKo07C2XpY81EEQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f178.google.com ([209.85.192.178]:34743 "EHLO
	mail-pf0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750913AbcDMRxd (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 13 Apr 2016 13:53:33 -0400
Received: by mail-pf0-f178.google.com with SMTP id c20so37227106pfc.1
        for <linux-pm@vger.kernel.org>; Wed, 13 Apr 2016 10:53:33 -0700 (PDT)
In-Reply-To: <CAJZ5v0gRaP9s_B6ttEpBSqBcGRX-j+kNetyaKo07C2XpY81EEQ@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Dietmar Eggemann <dietmar.eggemann@arm.com>, Ingo Molnar <mingo@redhat.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Vincent Guittot <vincent.guittot@linaro.org>, Morten Rasmussen <morten.rasmussen@arm.com>, Juri Lelli <Juri.Lelli@arm.com>, Patrick Bellasi <patrick.bellasi@arm.com>, Michael Turquette <mturquette@baylibre.com>

On 04/13/2016 07:45 AM, Rafael J. Wysocki wrote:
>> I'm concerned generally with the latency to react to changes in
>> > required capacity due to remote wakeups, which are quite common on SMP
>> > platforms with shared cache. Unless the hook is called it could take
>> > up to a tick to react AFAICS if the target CPU is running some other
>> > task that does not get preempted by the wakeup.
>
> So the scenario seems to be that CPU A is running task X and CPU B
> wakes up task Y on it remotely, but that task has to wait for CPU A to
> get to it, so you want to increase the frequency of CPU A at the
> wakeup time so as to reduce the time the woken up task has to wait.
> 
> In that case task X would not be giving the CPU away (ie. no
> invocations of schedule()) for the whole tick, so it would be
> CPU/memory bound.  In that case I would expect CPU A to be running at
> full capacity already unless this is the first tick period in which
> task X behaves this way which looks like a corner case to me.

This situation is fairly common in bursty workloads (such as UI driven
ones).

> Moreover, sending an IPI to CPU A in that case looks like the right
> thing to do to me anyway.

Sorry I didn't follow - sending an IPI to do what exactly? Perform the
wakeup operation on the target CPU?

thanks,
Steve
