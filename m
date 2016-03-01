From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH 0/3] cpufreq: Replace timers with utilization update
 callbacks
Date: Tue, 1 Mar 2016 14:58:11 +0100
Message-ID: <20160301135811.GQ6356@twins.programming.kicks-ass.net>
References: <56B93548.9090006@linaro.org>
 <CAJZ5v0gJwLVezLTLwGX=GDrsGeH6X040JmOaW6_uX2XzQwO9mg@mail.gmail.com>
 <5387313.xAhVpzgZCg@vostro.rjw.lan>
 <56BA8C29.4090905@linaro.org>
 <20160211115959.GI6357@twins.programming.kicks-ass.net>
 <20160211122429.GM11415@e106622-lin>
 <20160211152625.GM6357@twins.programming.kicks-ass.net>
 <CAKfTPtCRAyqx96rNuotHD2qtxBQkBa6K+-kk5bGQB2VbMq+k2A@mail.gmail.com>
 <20160212140415.GS6357@twins.programming.kicks-ass.net>
 <CAKfTPtA42zK+2pm71gDpodynYWXtKBqc-G5bFBh8aCKU=GPh_g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.9]:33832 "EHLO
	bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753859AbcCAN6W (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 1 Mar 2016 08:58:22 -0500
Content-Disposition: inline
In-Reply-To: <CAKfTPtA42zK+2pm71gDpodynYWXtKBqc-G5bFBh8aCKU=GPh_g@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Vincent Guittot <vincent.guittot@linaro.org>
Cc: Juri Lelli <juri.lelli@arm.com>, Steve Muckle <steve.muckle@linaro.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, "Rafael J. Wysocki" <rafael@kernel.org>, Linux PM list <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Viresh Kumar <viresh.kumar@linaro.org>, Thomas Gleixner <tglx@linutronix.de>

On Fri, Feb 12, 2016 at 03:48:54PM +0100, Vincent Guittot wrote:

> Another point to take into account is that the RT tasks will "steal"
> the compute capacity that has been requested by the cfs tasks.
> 
> Let takes the example of a CPU with 3 OPP on which run 2 rt tasks A
> and B and 1 cfs task C.

> Let assume that the real time constraint of RT task A is too agressive
> for the lowest OPP0 and that the change of the frequency of the core
> is too slow compare to this constraint but the real time constraint of
> RT task B can be handle whatever the OPP. System don't have other
> choice than setting the cpufreq min freq to OPP1 to be sure that
> constraint of task A will be covered at anytime.

> Then, we still have 2
> possible OPPs. The CFS task asks for compute capacity that fits in
> OPP1 but a part of this capacity will be stolen by RT tasks. If we
> monitor the load of RT tasks and request capacity for these RT tasks
> according to their current utilization, we can decide to switch to
> highest OPP2 to ensure that task C will have enough remaining
> capacity. A lot of embedded platform faces such kind of use cases

Still doesn't make sense. How would you know the constraint of RT task
A, and that it cannot be satisfied by OPP0 ? The only information you
have in the task model is a static priority.

The only possible choice the kernel has at this point is max OPP. It
doesn't have enough (_any_) information about worst case execution of
that task.

