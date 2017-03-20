From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [RFC][PATCH 2/2] cpufreq: schedutil: Force max frequency on busy CPUs
Date: Mon, 20 Mar 2017 14:04:16 +0100
Message-ID: <3708982.k2nGuG987y@aspire.rjw.lan>
References: <4366682.tsferJN35u@aspire.rjw.lan> <1846666.Va7CsUJLIx@aspire.rjw.lan> <20170320125009.nmi3mvrxappjrvgo@hirez.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:48312 "EHLO
        cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1754983AbdCTNQe (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 20 Mar 2017 09:16:34 -0400
In-Reply-To: <20170320125009.nmi3mvrxappjrvgo@hirez.programming.kicks-ass.net>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Peter Zijlstra <peterz@infradead.org>
Cc: Linux PM <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Viresh Kumar <viresh.kumar@linaro.org>, Juri Lelli <juri.lelli@arm.com>, Vincent Guittot <vincent.guittot@linaro.org>, Patrick Bellasi <patrick.bellasi@arm.com>, Joel Fernandes <joelaf@google.com>, Morten Rasmussen <morten.rasmussen@arm.com>, Ingo Molnar <mingo@redhat.com>

On Monday, March 20, 2017 01:50:09 PM Peter Zijlstra wrote:
> On Mon, Mar 20, 2017 at 01:35:12PM +0100, Rafael J. Wysocki wrote:
> > On Monday, March 20, 2017 11:36:45 AM Peter Zijlstra wrote:
> > > On Sun, Mar 19, 2017 at 02:34:32PM +0100, Rafael J. Wysocki wrote:
> > > > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > > > 
> > > > The PELT metric used by the schedutil governor underestimates the
> > > > CPU utilization in some cases.  The reason for that may be time spent
> > > > in interrupt handlers and similar which is not accounted for by PELT.
> > > > 
> > > > That can be easily demonstrated by running kernel compilation on
> > > > a Sandy Bridge Intel processor, running turbostat in parallel with
> > > > it and looking at the values written to the MSR_IA32_PERF_CTL
> > > > register.  Namely, the expected result would be that when all CPUs
> > > > were 100% busy, all of them would be requested to run in the maximum
> > > > P-state, but observation shows that this clearly isn't the case.
> > > > The CPUs run in the maximum P-state for a while and then are
> > > > requested to run slower and go back to the maximum P-state after
> > > > a while again.  That causes the actual frequency of the processor to
> > > > visibly oscillate below the sustainable maximum in a jittery fashion
> > > > which clearly is not desirable.
> > > > 
> > > > To work around this issue use the observation that, from the
> > > > schedutil governor's perspective, CPUs that are never idle should
> > > > always run at the maximum frequency and make that happen.
> > > > 
> > > > To that end, add a counter of idle calls to struct sugov_cpu and
> > > > modify cpuidle_idle_call() to increment that counter every time it
> > > > is about to put the given CPU into an idle state.  Next, make the
> > > > schedutil governor look at that counter for the current CPU every
> > > > time before it is about to start heavy computations.  If the counter
> > > > has not changed for over SUGOV_BUSY_THRESHOLD time (equal to 50 ms),
> > > > the CPU has not been idle for at least that long and the governor
> > > > will choose the maximum frequency for it without looking at the PELT
> > > > metric at all.
> > > 
> > > Why the time limit?
> > 
> > One iteration appeared to be a bit too aggressive, but honestly I think
> > I need to check again if this thing is regarded as viable at all.
> > 
> 
> I don't hate the idea; if we don't hit idle; we shouldn't shift down.

OK

> I just wonder if we don't already keep a idle-seqcount somewhere; NOHZ and
> RCU come to mind as things that might already use something like that.

NOHZ does that, but I did't want this to artificially depend on NOHZ.  That said,
yes, we can use that one too.
