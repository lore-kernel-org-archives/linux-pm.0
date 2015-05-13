From: Morten Rasmussen <morten.rasmussen@arm.com>
Subject: Re: [RFCv4 PATCH 00/34] sched: Energy cost model for energy-aware
 scheduling
Date: Wed, 13 May 2015 14:47:53 +0100
Message-ID: <20150513134753.GA26396@e105550-lin.cambridge.arm.com>
References: <1431459549-18343-1-git-send-email-morten.rasmussen@arm.com>
 <5552799E.2060507@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:36055 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S964791AbbEMNq0 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Wed, 13 May 2015 09:46:26 -0400
Content-Disposition: inline
In-Reply-To: <5552799E.2060507@nvidia.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Sai Gurrappadi <sgurrappadi@nvidia.com>
Cc: "peterz@infradead.org" <peterz@infradead.org>, "mingo@redhat.com" <mingo@redhat.com>, "vincent.guittot@linaro.org" <vincent.guittot@linaro.org>, Dietmar Eggemann <Dietmar.Eggemann@arm.com>, "yuyang.du@intel.com" <yuyang.du@intel.com>, "preeti@linux.vnet.ibm.com" <preeti@linux.vnet.ibm.com>, "mturquette@linaro.org" <mturquette@linaro.org>, "rjw@rjwysocki.net" <rjw@rjwysocki.net>, Juri Lelli <Juri.Lelli@arm.com>, "pang.xunlei@zte.com.cn" <pang.xunlei@zte.com.cn>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Peter Boonstoppel <pboonstoppel@nvidia.com>

Hi Sai,

On Tue, May 12, 2015 at 11:07:26PM +0100, Sai Gurrappadi wrote:
> 
> On 05/12/2015 12:38 PM, Morten Rasmussen wrote:
> > Test results for ARM TC2 (2xA15+3xA7) with cpufreq enabled:
> > 
> > sysbench: Single task running for 3 seconds.
> > rt-app [4]: mp3 playback use-case model
> > rt-app [4]: 5 ~[6,13,19,25,31,38,44,50]% periodic (2ms) tasks
> > 
> > Note: % is relative to the capacity of the fastest cpu at the highest
> > frequency, i.e. the more busy ones do not fit on little cpus.
> > 
> > A newer version of rt-app was used which supports a better but slightly
> > different way of modelling the periodic tasks. Numbers are therefore
> > _not_ comparable to the RFCv3 numbers.
> > 
> > Average numbers for 20 runs per test (ARM TC2).
> > 
> > Energy		Mainline	EAS		noEAS
> > 
> > sysbench	100		251*		227*
> > 
> > rt-app mp3	100		63		111
> > 
> > rt-app 6%	100		42		102
> > rt-app 13%	100		58		101
> > rt-app 19%	100		87		101
> > rt-app 25%	100		94		104
> > rt-app 31%	100		93		104
> > rt-app 38%	100		114		117
> > rt-app 44%	100		115		118
> > rt-app 50%	100		125		126
> 
> Hi Morten,
> 
> What is noEAS? From the numbers, noEAS != Mainline?

Sorry, that should have been more clear.

Mainline:	tip/sched/core (not really mainline yet...)
EAS:		tip/sched/core + RFCv4 + EAS enabled.
noEAS:		tip/sched/core + RFCv4 + EAS disabled.

The main differences between plain tip/sched/core and EAS disabled is
that PELT is frequency invariant which affects the decisions in
period/idle/nohz_idle balance.

> Maybe also have some perf numbers to show that perf is in fact preserved
> while lowering power.

Couldn't agree more. Energy numbers on their own do not say much. I
hinted at the sysbench performance in the (trimmed) text further down.
The increase in energy for EAS is due to doing more work (higher
performance). The rt-app runs with task utilization in the lower end
should deliver the same level of performance as none of the cpus are
fully utilized. The little cpus have a capacity of 43% each. At the
higher end I would expect performance to be different. EAS tries its
best to put heavier tasks on the big cpus where mainline may choose a
different task distribution hence performance is likely to be different
like it is for sysbench.

A performance metric for rt-app is under discussion but not there yet.
We will work on getting that sorted as the next thing so we can see any
performance impact.

Thanks,
Morten
