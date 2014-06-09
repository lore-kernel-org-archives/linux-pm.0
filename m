From: Yuyang Du <yuyang.du@intel.com>
Subject: Re: [RFC PATCH 06/16] arm: topology: Define TC2 sched energy and
 provide it to scheduler
Date: Mon, 9 Jun 2014 10:15:16 +0800
Message-ID: <20140609021516.GE22261@intel.com>
References: <20140604172712.GJ13930@laptop.programming.kicks-ass.net>
 <2484761.vkWavnsDx3@vostro.rjw.lan>
 <20140605065205.GA3213@twins.programming.kicks-ass.net>
 <539086B3.2010804@gmail.com>
 <20140605202930.GA15484@intel.com>
 <20140606080543.GR6758@twins.programming.kicks-ass.net>
 <20140606003520.GB22261@intel.com>
 <20140606105036.GQ3213@twins.programming.kicks-ass.net>
 <20140607232628.GC22261@intel.com>
 <20140609085952.GZ29593@e103034-lin>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:60243 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753950AbaFIKTK (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Mon, 9 Jun 2014 06:19:10 -0400
Content-Disposition: inline
In-Reply-To: <20140609085952.GZ29593@e103034-lin>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Morten Rasmussen <morten.rasmussen@arm.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Dirk Brandewie <dirk.brandewie@gmail.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "mingo@kernel.org" <mingo@kernel.org>, "vincent.guittot@linaro.org" <vincent.guittot@linaro.org>, "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>, "preeti@linux.vnet.ibm.com" <preeti@linux.vnet.ibm.com>, Dietmar Eggemann <Dietmar.Eggemann@arm.com>, "len.brown@intel.com" <len.brown@intel.com>, "jacob.jun.pan@linux.intel.com" <jacob.jun.pan@linux.intel.com>

On Mon, Jun 09, 2014 at 09:59:52AM +0100, Morten Rasmussen wrote:
> IMHO, the per-entity load-tracking does a fair job representing the task
> compute capacity requirements. Sure it isn't perfect, particularly not
> for memory bound tasks, but it is way better than not having any task
> history at all, which was the case before.
> 
> The story is more or less the same for performance scaling. It is not
> taken into account at all in the scheduler at the moment. cpufreq is
> actually messing up load-balancing decisions after task load-tracking
> was introduced. Adding performance scaling awareness should only make
> things better even if predictions are not accurate for all workloads. I
> don't see why it shouldn't given the current state of energy-awareness
> in the scheduler.
> 

Optimized IPC is good for sure (with regard to pstate adjustment). My point is
how it is practical to rightly correlate to scheduler and pstate
power-efficiency. Put another way, with fixed workload, you really can do such
a thing by offline running the workload several times to conclude with a very
power-efficient solution which takes IPC into account. Actually, lots of
people have done that in papers/reports (for SPECXXX or TPC-X for example). But
I can't see how online realtime workload can be done like it.

> > Currently, all freq governors take CPU utilization (load%) as the indicator
> > (target), which can server both: workload and perf scaling.
> 
> With a bunch of hacks on top to make it more reactive because the
> current cpu utilization metric is not responsive enough to deal with
> workload changes. That is at least the case for ondemand and interactive
> (in Android).
> 

To what end it is not responsive enough? And how it is related here?

Thanks,
Yuyang
