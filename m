From: Yuyang Du <yuyang.du@intel.com>
Subject: Re: [RFC PATCH 06/16] arm: topology: Define TC2 sched energy and
 provide it to scheduler
Date: Fri, 6 Jun 2014 04:29:30 +0800
Message-ID: <20140605202930.GA15484@intel.com>
References: <1400869003-27769-1-git-send-email-morten.rasmussen@arm.com>
 <20140604160230.GS29593@e103034-lin>
 <20140604172712.GJ13930@laptop.programming.kicks-ass.net>
 <2484761.vkWavnsDx3@vostro.rjw.lan>
 <20140605065205.GA3213@twins.programming.kicks-ass.net>
 <539086B3.2010804@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:3908 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750727AbaFFEdt (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Fri, 6 Jun 2014 00:33:49 -0400
Content-Disposition: inline
In-Reply-To: <539086B3.2010804@gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Dirk Brandewie <dirk.brandewie@gmail.com>
Cc: Peter Zijlstra <peterz@infradead.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Morten Rasmussen <morten.rasmussen@arm.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "mingo@kernel.org" <mingo@kernel.org>, "vincent.guittot@linaro.org" <vincent.guittot@linaro.org>, "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>, "preeti@linux.vnet.ibm.com" <preeti@linux.vnet.ibm.com>, Dietmar Eggemann <Dietmar.Eggemann@arm.com>, len.brown@intel.com

On Thu, Jun 05, 2014 at 08:03:15AM -0700, Dirk Brandewie wrote:
> 
> You can request a P state per core but the package does coordination at
> a package level for the P state that will be used based on all requests.
> This is due to the fact that most SKUs have a single VR and PLL. So
> the highest P state wins.  When a core goes idle it loses it's vote
> for the current package P state and that cores clock it turned off.
> 

You need to differentiate Turbo and non-Turbo. The highest P state wins? Not
really. Actually, silicon supports indepdent non-Turbo pstate, but just not enabled.
For Turbo, it basically depends on power budget of both core and gfx (because
they share) for each core to get which Turbo point.

> >
> >And while APERF/MPERF allows observing what it did, its afaik, nigh on
> >impossible to predict wtf its going to do, and therefore any such energy
> >computation is going to be a PRNG at best.
> >
> >Now, given all that I'm not sure what we need that P-state driver for,
> >so supposedly I'm missing something.
> 
> intel_pstate tries to keep the core P state as low as possible to satisfy
> the given load, so when various cores go idle the package P state can be
> as low as possible.  The big power win is a core going idle.
> 

In terms of prediction, it is definitely can't be 100% right. But the
performance of most workloads does scale with pstate (frequency), may not be
linearly. So it is to some point predictable FWIW. And this is all governors
and Intel_pstate's basic assumption.

Thanks,
Yuyang
