From: Morten Rasmussen <morten.rasmussen@arm.com>
Subject: Re: [RFC PATCH 06/16] arm: topology: Define TC2 sched energy and
 provide it to scheduler
Date: Mon, 9 Jun 2014 09:27:39 +0100
Message-ID: <20140609082739.GY29593@e103034-lin>
References: <2484761.vkWavnsDx3@vostro.rjw.lan>
 <20140605065205.GA3213@twins.programming.kicks-ass.net>
 <539086B3.2010804@gmail.com>
 <20140605202930.GA15484@intel.com>
 <20140606080543.GR6758@twins.programming.kicks-ass.net>
 <20140606003520.GB22261@intel.com>
 <20140606105036.GQ3213@twins.programming.kicks-ass.net>
 <20140606121305.GA8571@gmail.com>
 <20140606122740.GA9318@gmail.com>
 <alpine.LFD.2.11.1406062224090.25775@knanqh.ubzr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <alpine.LFD.2.11.1406062224090.25775@knanqh.ubzr>
Sender: linux-kernel-owner@vger.kernel.org
To: Nicolas Pitre <nicolas.pitre@linaro.org>
Cc: Ingo Molnar <mingo@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Yuyang Du <yuyang.du@intel.com>, Dirk Brandewie <dirk.brandewie@gmail.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "vincent.guittot@linaro.org" <vincent.guittot@linaro.org>, "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>, "preeti@linux.vnet.ibm.com" <preeti@linux.vnet.ibm.com>, Dietmar Eggemann <Dietmar.Eggemann@arm.com>, "len.brown@intel.com" <len.brown@intel.com>, "jacob.jun.pan@linux.intel.com" <jacob.jun.pan@linux.intel.com>
List-Id: linux-pm@vger.kernel.org

On Sat, Jun 07, 2014 at 03:33:58AM +0100, Nicolas Pitre wrote:
> On Fri, 6 Jun 2014, Ingo Molnar wrote:
> 
> > In any case, even with turbo frequencies, switching power use is 
> > probably an order of magnitude higher than leakage current power use, 
> > on any marketable chip, so we should concentrate on being able to 
> > cover this first order effect (P/work ~ V^2), before considering any 
> > second order effects (leakage current).
> 
> Just so that people are aware... We'll have to introduce thermal 
> constraint management into the scheduler mix as well at some point.  
> Right now what we have is an ad hoc subsystem that simply monitors 
> temperature and apply crude cooling strategies when some thresholds are 
> met. But a better strategy would imply thermal "provisioning".

There is already work going on to improve thermal management:

http://lwn.net/Articles/599598/

The proposal is based on power/energy models (too). The goal is to
allocate power intelligently based on performance requirements.

While it is related to energy-aware scheduling and I fully agree that it
is something we need to consider, I think it is worth developing the two
ideas in parallel and look at sharing things like the power model later
once things mature. Energy-aware scheduling is complex enough on its
own to keep us entertained for a while :-)

Morten
