From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH RFC] sched,idle: teach select_idle_sibling about idle
 states
Date: Fri, 3 Oct 2014 09:50:12 +0200
Message-ID: <20141003075012.GF10583@worktop.programming.kicks-ass.net>
References: <1409844730-12273-1-git-send-email-nicolas.pitre@linaro.org>
 <1409844730-12273-3-git-send-email-nicolas.pitre@linaro.org>
 <542B277D.7050103@redhat.com>
 <alpine.LFD.2.11.1409301904150.5311@knanqh.ubzr>
 <20141002131548.6cd377d5@cuia.bos.redhat.com>
 <1412317384.5149.19.camel@marge.simpson.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.9]:45780 "EHLO
	bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750754AbaJCHuT (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 3 Oct 2014 03:50:19 -0400
Content-Disposition: inline
In-Reply-To: <1412317384.5149.19.camel@marge.simpson.net>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Mike Galbraith <umgwanakikbuti@gmail.com>
Cc: Rik van Riel <riel@redhat.com>, Nicolas Pitre <nicolas.pitre@linaro.org>, Ingo Molnar <mingo@redhat.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, linaro-kernel@lists.linaro.org

On Fri, Oct 03, 2014 at 08:23:04AM +0200, Mike Galbraith wrote:
> On Thu, 2014-10-02 at 13:15 -0400, Rik van Riel wrote:
> 
> > Subject: sched,idle: teach select_idle_sibling about idle states
> > 
> > Change select_idle_sibling to take cpu idle exit latency into
> > account.  First preference is to select the cpu with the lowest
> > exit latency from a completely idle sched_group inside the CPU;
> > if that is not available, we pick the CPU with the lowest exit
> > latency in any sched_group.
> > 
> > This increases the total search time of select_idle_sibling,
> > we may want to look into propagating load info up the sched_group
> > tree in some way. That information would also be useful to prevent
> > the wake_affine logic from causing a load imbalance between
> > sched_groups.
> 
> A generic boo hiss aimed in the general direction of all of this let's
> go look at every possibility on every wakeup stuff.  Less is more.

I hear you, can you see actual slowdown with the patch? While the worst
case doesn't change, it does make the average case equal to the worst
case iteration -- where we previously would average out at inspecting
half the CPUs before finding an idle one, we'd now always inspect all of
them in order to compare all idle ones on their properties.

Also, with the latest generation of Haswell Xeons having 18 cores (36
threads) this is one massively painful loop for sure.

I'm just not sure what to do about it.. I suppose we can artificially
split it into smaller groups, but I bet that'll hurt some, but if we can
show it gains more we might still be able to do it. The only real
problem is actual numbers/workloads (isn't it always) :/

One thing I suppose we could try is keeping a 'busy' flag at the
llc domain which is set when all CPUs are busy (we'll clear it from
new_idle) that way we can avoid the entire iteration if we know its
pointless.

Hmm...
