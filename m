From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [RFC PATCH 3/3] idle: store the idle state index in the struct rq
Date: Mon, 3 Feb 2014 15:56:05 +0100
Message-ID: <20140203145605.GL8874@twins.programming.kicks-ass.net>
References: <52EA8B07.6020206@linaro.org>
 <CAM4v1pPwmRUOtNeGh5sZmj+wAsC8RstofNA5Gx862SEECvW-Lg@mail.gmail.com>
 <20140131090230.GM5002@laptop.programming.kicks-ass.net>
 <52EB6F65.8050008@linux.vnet.ibm.com>
 <52EBBC23.8020603@linux.intel.com>
 <52EBC33A.6080101@linaro.org>
 <52EBC645.2040607@linux.intel.com>
 <alpine.LFD.2.11.1401311236470.2312@knanqh.ubzr>
 <20140203125441.GD19029@e103034-lin>
 <52EFA9D3.1030601@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from merlin.infradead.org ([205.233.59.134]:47316 "EHLO
	merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752222AbaBCO4X (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 3 Feb 2014 09:56:23 -0500
Content-Disposition: inline
In-Reply-To: <52EFA9D3.1030601@linux.intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Arjan van de Ven <arjan@linux.intel.com>
Cc: Morten Rasmussen <morten.rasmussen@arm.com>, Nicolas Pitre <nicolas.pitre@linaro.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, Preeti U Murthy <preeti@linux.vnet.ibm.com>, Len Brown <len.brown@intel.com>, Preeti Murthy <preeti.lkml@gmail.com>, "mingo@redhat.com" <mingo@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, LKML <linux-kernel@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Lists linaro-kernel <linaro-kernel@lists.linaro.org>


Arjan, could you have a look at teaching your Thunderpants to wrap lines
at ~80 chars please?

On Mon, Feb 03, 2014 at 06:38:11AM -0800, Arjan van de Ven wrote:
> On 2/3/2014 4:54 AM, Morten Rasmussen wrote:
> 
> >
> >I'm therefore not convinced that idle state index is the right thing to
> >give the scheduler. Using a cost metric would be better in my
> >opinion.
> 
> 
> I totally agree with this, and we may need two separate cost metrics
> 
> 1) A latency driven one
> 2) A performance impact on
> 
> first one is pretty much the exit latency related time, sort of a
> "expected time to first instruction" (currently menuidle has the
> 99.999% worst case number, which is not useful for this, but is a
> first approximation). This is obviously the dominating number for
> expected-short running tasks
> 
> second on is more of a "is there any cache/TLB left or is it flushed"
> kind of metric. It's more tricky to compute, since what is the cost of
> an empty cache (or even a cache migration) after all....  .... but I
> suspect it's in part what the scheduler will care about more for
> expected-long  running tasks.

Yeah, so currently we 'assume' cache hotness based on runtime; see
task_hot(). A hint that the CPU wiped its caches might help there.

We also used to measure the entire cache migration cost between all
topologies in the system. That got ripped out when CFS got introduced,
but there's been a few people wanting to bring that back because the
single migration cost thingy simply doesn't work too well for some
workloads.

The reason Ingo took it out was that these measured numbers would
slightly vary from boot to boot making it hard to compare performance
numbers across boots.

There's something to be said for either case I suppose.
