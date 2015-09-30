From: Luiz Capitulino <lcapitulino@redhat.com>
Subject: Re: [RFC 0/3] sched/idle: run-time support for setting idle polling
Date: Wed, 30 Sep 2015 13:16:10 -0400
Message-ID: <20150930131610.1c2ba9c2@redhat.com>
References: <1442954062-28578-1-git-send-email-lcapitulino@redhat.com>
	<1593595.NpzC8TsdGC@vostro.rjw.lan>
	<20150930154835.GP3604@twins.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:50947 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753337AbbI3RQP (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Wed, 30 Sep 2015 13:16:15 -0400
In-Reply-To: <20150930154835.GP3604@twins.programming.kicks-ass.net>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Peter Zijlstra <peterz@infradead.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-kernel@vger.kernel.org, riel@redhat.com, rafael.j.wysocki@intel.com, mingo@kernel.org, Linux PM list <linux-pm@vger.kernel.org>, Len Brown <len.brown@intel.com>, Thomas Gleixner <tglx@linutronix.de>

On Wed, 30 Sep 2015 17:48:35 +0200
Peter Zijlstra <peterz@infradead.org> wrote:

> On Wed, Sep 23, 2015 at 03:17:59AM +0200, Rafael J. Wysocki wrote:
> > On Tuesday, September 22, 2015 04:34:19 PM Luiz Capitulino wrote:
> > > Hi,
> > 
> > Hi,
> > 
> > Please always CC patches related to power management to linux-pm@vger.kernel.org.
> >
> > Also CCing Len Brown who's the maintainer of the intel_idle driver and Peter Z.
> 
> And the sched people for touching kernel/sched (thanks Rafael)!
> 
> > > Some archs allow the system administrator to set the
> > > idle thread behavior to spin instead of entering
> > > sleep states. The x86 arch, for example, has a idle=
> > > command-line parameter for this purpose.
> > > 
> > > However, the command-line parameter has two problems:
> > > 
> > >  1. You have to reboot if you change your mind
> > >  2. This setting affects all system cores
> > > 
> > > The second point is relevant for systems where cores
> > > are partitioned into bookkeeping and low-latency cores.
> > > Usually, it's OK for bookkeeping cores to enter deeper
> > > sleep states. It's only the low-latency cores that should
> > > poll when entering idle.
> > 
> > This looks like a use case for PM QoS to me rather.  You'd need to make it
> > work per-CPU rather than globally, but that really is about asking for
> > minimum latency.
> 
> Agreed, this should very much hook into the PM QoS stuff.
> 
> > 
> > > This series adds the following file:
> > > 
> > >  /sys/devices/system/cpu/cpu_idle
> > > 
> > > This file outputs and stores a cpumask of the cores
> > > which will have idle polling behavior.
> > 
> > I don't like this interface at all.
> > 
> > You have a cpuidle directory per core already, so what's the reason to add an
> 
> Yeah this should very much not be exposed like this.
> 
> Ideally every cpuidle driver would get 'polling' as a
> default state and the QoS constraints might select it if nothing else
> matches.

So, I didn't know we had support for polling from the idle
thread via cpuidle. This solves the first part of the problem.

The second part is having this available in KVM guests. Looks
like there's work being done to have PV idle support in KVM,
so this solves the second problem.

No need for this series then.

> 
> And no mucking about with the force polling flag at _all_.
> 

