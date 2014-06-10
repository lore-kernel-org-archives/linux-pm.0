From: Morten Rasmussen <morten.rasmussen@arm.com>
Subject: Re: [RFC PATCH 02/16] sched: Introduce CONFIG_SCHED_ENERGY
Date: Tue, 10 Jun 2014 12:24:03 +0100
Message-ID: <20140610112403.GC1581@e103034-lin>
References: <1400869003-27769-1-git-send-email-morten.rasmussen@arm.com>
 <1400869003-27769-3-git-send-email-morten.rasmussen@arm.com>
 <20140608060316.GA18179@austad.us>
 <20140609102027.GA29593@e103034-lin>
 <20140610093943.GA6758@twins.programming.kicks-ass.net>
 <20140610100641.GB1581@e103034-lin>
 <20140610102353.GC6758@twins.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from fw-tnat.austin.arm.com ([217.140.110.23]:26409 "EHLO
	collaborate-mta1.arm.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751038AbaFJLYE (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 10 Jun 2014 07:24:04 -0400
Content-Disposition: inline
In-Reply-To: <20140610102353.GC6758@twins.programming.kicks-ass.net>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Peter Zijlstra <peterz@infradead.org>
Cc: Henrik Austad <henrik@austad.us>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "mingo@kernel.org" <mingo@kernel.org>, "rjw@rjwysocki.net" <rjw@rjwysocki.net>, "vincent.guittot@linaro.org" <vincent.guittot@linaro.org>, "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>, "preeti@linux.vnet.ibm.com" <preeti@linux.vnet.ibm.com>, Dietmar Eggemann <Dietmar.Eggemann@arm.com>

On Tue, Jun 10, 2014 at 11:23:53AM +0100, Peter Zijlstra wrote:
> On Tue, Jun 10, 2014 at 11:06:41AM +0100, Morten Rasmussen wrote:
> > How would you like to disable the energy stuff for users for whom
> > latency is everything?
> > 
> > I mean, we are adding some extra load/utilization tracking. While I
> > think we should do everything possible to minimize the overhead, I think
> > it is unrealistic to assume that it will be zero. Is a some extra 'if
> > (energy_enabled)' acceptable?
> > 
> > I'm open for other suggestions.
> 
> We have the jump-label stuff to do self modifying code ;-) The only
> thing we need to be careful with is data-layout.

Thanks. I can see that it is already used in for various bit in
kernel/sched/*. I didn't catch anything in Documentation/static-keys.txt
related to data-layout caveats. Is there some other
documentation/patches I should read before messing everything up? ;-)

> So I'm _hoping_ we can do all this without more CONFIG knobs, because
> {PREEMPT*SMP*CGROUP^3*NUMA^2} is already entirely annoying to
> build and run test, not to mention that distro builds will have no other
> option than to enable everything anyhow.

Fair enough.
