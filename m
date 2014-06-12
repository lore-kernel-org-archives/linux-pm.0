From: Vince Weaver <vince@deater.net>
Subject: Re: [RFC PATCH 06/16] arm: topology: Define TC2 sched energy and
 provide it to scheduler
Date: Thu, 12 Jun 2014 11:05:12 -0400 (EDT)
Message-ID: <alpine.DEB.2.10.1406121101110.23499@pianoman.cluster.toy>
References: <1400869003-27769-1-git-send-email-morten.rasmussen@arm.com> <1400869003-27769-7-git-send-email-morten.rasmussen@arm.com> <20140603114428.GY11096@twins.programming.kicks-ass.net> <20140604154227.GR29593@e103034-lin> <20140604161618.GQ30445@twins.programming.kicks-ass.net>
 <20140606131510.GV29593@e103034-lin> <20140606134303.GQ13930@laptop.programming.kicks-ass.net> <20140606142958.GX29593@e103034-lin>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20140606142958.GX29593@e103034-lin>
Sender: linux-kernel-owner@vger.kernel.org
To: Morten Rasmussen <morten.rasmussen@arm.com>
Cc: Peter Zijlstra <peterz@infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "mingo@kernel.org" <mingo@kernel.org>, "rjw@rjwysocki.net" <rjw@rjwysocki.net>, "vincent.guittot@linaro.org" <vincent.guittot@linaro.org>, "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>, "preeti@linux.vnet.ibm.com" <preeti@linux.vnet.ibm.com>, Dietmar Eggemann <Dietmar.Eggemann@arm.com>
List-Id: linux-pm@vger.kernel.org

On Fri, 6 Jun 2014, Morten Rasmussen wrote:

> On Fri, Jun 06, 2014 at 02:43:03PM +0100, Peter Zijlstra wrote:
> > On Fri, Jun 06, 2014 at 02:15:10PM +0100, Morten Rasmussen wrote:
> > > > > ARM TC2 has on-chip energy counters for counting energy consumed by the
> > > > > A7 and A15 clusters. They are fairly accurate. 
> > > > 
> > > > Recent Intel chips have that too; they come packaged as:
> > > > 
> > > >   perf stat -a -e "power/energy-cores/" -- cmd
> > > > 
> > > > (through the perf_event_intel_rapl.c driver), It would be ideal if the
> > > > ARM equivalent was available through a similar interface.
> > > > 
> > > > http://lwn.net/Articles/573602/
> > > 
> > > Nice. On ARM it is not mandatory to have energy counters and what they
> > > actually measure if they are implemented is implementation dependent.
> > > However, each vendor does extensive evaluation and characterization of
> > > their implementation already, so I don't think would be a problem for
> > > them to provide the numbers.
> > 
> > How is the ARM energy thing exposed? Through the regular PMU but with
> > vendor specific events, or through a separate interface, entirely vendor
> > specific?
> 
> There is an upstream hwmon driver for TC2 already with an easy to use
> sysfs interface for all the energy counters. So it is somewhat vendor
> specific at the moment unfortunately.

What is the plan about future interfaces for energy info?

Intel RAPL of course has a perf_event interface.

However AMD's (somewhat unfortunately acronymed) Application Power 
Management exports similar information via hwmon and the fam15h_power
driver.

And it sounds like ARM systems also put things in hwmon.

User tools like PAPI can sort of abstract this (for example it supports 
getting RAPL data from perf_event while it also has a driver for getting 
info from hwmon).  But users stuck with perf end up having to use multiple 
tools to get energy and performance info simultaneously on non-intel 
hardware.

Vince
