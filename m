From: Morten Rasmussen <morten.rasmussen@arm.com>
Subject: Re: [RFC PATCH 02/16] sched: Introduce CONFIG_SCHED_ENERGY
Date: Tue, 10 Jun 2014 11:06:41 +0100
Message-ID: <20140610100641.GB1581@e103034-lin>
References: <1400869003-27769-1-git-send-email-morten.rasmussen@arm.com>
 <1400869003-27769-3-git-send-email-morten.rasmussen@arm.com>
 <20140608060316.GA18179@austad.us>
 <20140609102027.GA29593@e103034-lin>
 <20140610093943.GA6758@twins.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from fw-tnat.austin.arm.com ([217.140.110.23]:57817 "EHLO
	collaborate-mta1.arm.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1750726AbaFJKGo (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 10 Jun 2014 06:06:44 -0400
Content-Disposition: inline
In-Reply-To: <20140610093943.GA6758@twins.programming.kicks-ass.net>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Peter Zijlstra <peterz@infradead.org>
Cc: Henrik Austad <henrik@austad.us>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "mingo@kernel.org" <mingo@kernel.org>, "rjw@rjwysocki.net" <rjw@rjwysocki.net>, "vincent.guittot@linaro.org" <vincent.guittot@linaro.org>, "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>, "preeti@linux.vnet.ibm.com" <preeti@linux.vnet.ibm.com>, Dietmar Eggemann <Dietmar.Eggemann@arm.com>

On Tue, Jun 10, 2014 at 10:39:43AM +0100, Peter Zijlstra wrote:
> On Mon, Jun 09, 2014 at 11:20:27AM +0100, Morten Rasmussen wrote:
> > On Sun, Jun 08, 2014 at 07:03:16AM +0100, Henrik Austad wrote:
> > > On Fri, May 23, 2014 at 07:16:29PM +0100, Morten Rasmussen wrote:
> > > > The Energy-aware scheduler implementation is guarded by
> > > > CONFIG_SCHED_ENERGY.
> > > > 
> > > > Signed-off-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
> > > > Signed-off-by: Morten Rasmussen <morten.rasmussen@arm.com>
> > > > ---
> > > >  arch/arm/Kconfig |    5 +++++
> > > >  1 file changed, 5 insertions(+)
> > > > 
> > > > diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> > > > index ab438cb..bfc3a85 100644
> > > > --- a/arch/arm/Kconfig
> > > > +++ b/arch/arm/Kconfig
> > > 
> > > Is this going to be duplicate for each architecture enabling this? Why
> > > not make a kernel/Kconfig.energy and link to that from those
> > > architectures using it?
> > 
> > kernel/Kconfig.energy is better I think.
> 
> Well, strictly speaking I'd prefer to not have more sched CONFIG knobs.
> 
> Do we really need to have this CONFIG guarded?

How would you like to disable the energy stuff for users for whom
latency is everything?

I mean, we are adding some extra load/utilization tracking. While I
think we should do everything possible to minimize the overhead, I think
it is unrealistic to assume that it will be zero. Is a some extra 'if
(energy_enabled)' acceptable?

I'm open for other suggestions.
