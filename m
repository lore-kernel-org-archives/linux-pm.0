From: Juri Lelli <juri.lelli@arm.com>
Subject: Re: [PATCH 0/3] cpufreq: Replace timers with utilization update
 callbacks
Date: Tue, 1 Mar 2016 14:17:06 +0000
Message-ID: <20160301141706.GJ18792@e106622-lin>
References: <CAJZ5v0gJwLVezLTLwGX=GDrsGeH6X040JmOaW6_uX2XzQwO9mg@mail.gmail.com>
 <5387313.xAhVpzgZCg@vostro.rjw.lan>
 <56BA8C29.4090905@linaro.org>
 <20160211115959.GI6357@twins.programming.kicks-ass.net>
 <20160211122429.GM11415@e106622-lin>
 <20160211152625.GM6357@twins.programming.kicks-ass.net>
 <CAKfTPtCRAyqx96rNuotHD2qtxBQkBa6K+-kk5bGQB2VbMq+k2A@mail.gmail.com>
 <20160212140415.GS6357@twins.programming.kicks-ass.net>
 <CAKfTPtA42zK+2pm71gDpodynYWXtKBqc-G5bFBh8aCKU=GPh_g@mail.gmail.com>
 <20160301135811.GQ6356@twins.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:51434 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753513AbcCAOQE (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Tue, 1 Mar 2016 09:16:04 -0500
Content-Disposition: inline
In-Reply-To: <20160301135811.GQ6356@twins.programming.kicks-ass.net>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Peter Zijlstra <peterz@infradead.org>
Cc: Vincent Guittot <vincent.guittot@linaro.org>, Steve Muckle <steve.muckle@linaro.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, "Rafael J. Wysocki" <rafael@kernel.org>, Linux PM list <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Viresh Kumar <viresh.kumar@linaro.org>, Thomas Gleixner <tglx@linutronix.de>

On 01/03/16 14:58, Peter Zijlstra wrote:
> On Fri, Feb 12, 2016 at 03:48:54PM +0100, Vincent Guittot wrote:
> 
> > Another point to take into account is that the RT tasks will "steal"
> > the compute capacity that has been requested by the cfs tasks.
> > 
> > Let takes the example of a CPU with 3 OPP on which run 2 rt tasks A
> > and B and 1 cfs task C.
> 
> > Let assume that the real time constraint of RT task A is too agressive
> > for the lowest OPP0 and that the change of the frequency of the core
> > is too slow compare to this constraint but the real time constraint of
> > RT task B can be handle whatever the OPP. System don't have other
> > choice than setting the cpufreq min freq to OPP1 to be sure that
> > constraint of task A will be covered at anytime.
> 
> > Then, we still have 2
> > possible OPPs. The CFS task asks for compute capacity that fits in
> > OPP1 but a part of this capacity will be stolen by RT tasks. If we
> > monitor the load of RT tasks and request capacity for these RT tasks
> > according to their current utilization, we can decide to switch to
> > highest OPP2 to ensure that task C will have enough remaining
> > capacity. A lot of embedded platform faces such kind of use cases
> 
> Still doesn't make sense. How would you know the constraint of RT task
> A, and that it cannot be satisfied by OPP0 ? The only information you
> have in the task model is a static priority.
> 

But, can't we have the problem Vincent describes if we s/RT/DL/ ?

Thanks,

- Juri
