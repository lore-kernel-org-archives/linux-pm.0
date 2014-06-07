From: Yuyang Du <yuyang.du@intel.com>
Subject: Re: [RFC PATCH 06/16] arm: topology: Define TC2 sched energy and
 provide it to scheduler
Date: Sun, 8 Jun 2014 07:53:07 +0800
Message-ID: <20140607235307.GD22261@intel.com>
References: <20140604160230.GS29593@e103034-lin>
 <20140604172712.GJ13930@laptop.programming.kicks-ass.net>
 <2484761.vkWavnsDx3@vostro.rjw.lan>
 <20140605065205.GA3213@twins.programming.kicks-ass.net>
 <539086B3.2010804@gmail.com>
 <20140605202930.GA15484@intel.com>
 <20140606080543.GR6758@twins.programming.kicks-ass.net>
 <20140606003520.GB22261@intel.com>
 <20140606105036.GQ3213@twins.programming.kicks-ass.net>
 <20140606121305.GA8571@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20140606121305.GA8571@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Dirk Brandewie <dirk.brandewie@gmail.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Morten Rasmussen <morten.rasmussen@arm.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "vincent.guittot@linaro.org" <vincent.guittot@linaro.org>, "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>, "preeti@linux.vnet.ibm.com" <preeti@linux.vnet.ibm.com>, Dietmar Eggemann <Dietmar.Eggemann@arm.com>, len.brown@intel.com, jacob.jun.pan@linux.intel.com
List-Id: linux-pm@vger.kernel.org

On Fri, Jun 06, 2014 at 02:13:05PM +0200, Ingo Molnar wrote:
> 
> Leakage current typically gets higher with higher frequencies, but 
> it's also highly process dependent AFAIK.
> 

In general, you can assume leakage power ~ V^2.

> If switching power dissipation is the main factor in power use, then 
> we can essentially assume that P ~ V^2, at the same frequency - and 
> scales linearly with frequency - but real work performed also scales 
> semi-linearly with frequency for many workloads, so that's an 
> invariant for everything except highly memory bound workloads.
> 

Agreed. Strictly, Energy ~ V^2.
