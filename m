From: Nicolas Pitre <nicolas.pitre@linaro.org>
Subject: Re: [RFC PATCH 06/16] arm: topology: Define TC2 sched energy and
 provide it to scheduler
Date: Tue, 10 Jun 2014 13:01:42 -0400 (EDT)
Message-ID: <alpine.LFD.2.11.1406101253490.25775@knanqh.ubzr>
References: <20140604160230.GS29593@e103034-lin> <20140604172712.GJ13930@laptop.programming.kicks-ass.net> <2484761.vkWavnsDx3@vostro.rjw.lan> <20140605065205.GA3213@twins.programming.kicks-ass.net> <539086B3.2010804@gmail.com> <20140605202930.GA15484@intel.com>
 <20140606080543.GR6758@twins.programming.kicks-ass.net> <20140606003520.GB22261@intel.com> <20140606105036.GQ3213@twins.programming.kicks-ass.net> <20140607232628.GC22261@intel.com> <20140610101622.GB6758@twins.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20140610101622.GB6758@twins.programming.kicks-ass.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Zijlstra <peterz@infradead.org>
Cc: Yuyang Du <yuyang.du@intel.com>, Dirk Brandewie <dirk.brandewie@gmail.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Morten Rasmussen <morten.rasmussen@arm.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "mingo@kernel.org" <mingo@kernel.org>, "vincent.guittot@linaro.org" <vincent.guittot@linaro.org>, "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>, "preeti@linux.vnet.ibm.com" <preeti@linux.vnet.ibm.com>, Dietmar Eggemann <Dietmar.Eggemann@arm.com>, len.brown@intel.com, jacob.jun.pan@linux.intel.com
List-Id: linux-pm@vger.kernel.org

On Tue, 10 Jun 2014, Peter Zijlstra wrote:

> So the current cpufreq stuff is terminally broken in too many ways; its
> sampling, so it misses a lot of changes, its strictly cpu local, so it
> completely misses SMP information (like the migrations etc..)
> 
> If we move a 50% task from CPU1 to CPU0, a sampling thing takes time to
> adjust on both CPUs, whereas if its scheduler driven, we can instantly
> adjust and be done, because we _know_ what we moved.

Incidentally I submitted a LWN article highlighting those very issues 
and the planned remedies.  No confirmation of a publication date though.

> Now some of that is due to hysterical raisins, and some of that due to
> broken hardware (hardware that needs to schedule in order to change its
> state because its behind some broken bus or other). But we should
> basically kill off cpufreq for anything recent and sane.

EVen if some change has to happen through a kernel thread, you're still 
far better with the scheduler requesting this change proactively than 
waiting for both the cpufreq governor to catch up with the load and then 
wait for the freq change thread to be scheduled.


Nicolas
