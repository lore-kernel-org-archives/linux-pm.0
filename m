From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [RFC][PATCH 2/2] cpufreq: schedutil: Force max frequency on busy CPUs
Date: Mon, 20 Mar 2017 13:59:58 +0100
Message-ID: <3315477.nk1LFSfS7V@aspire.rjw.lan>
References: <4366682.tsferJN35u@aspire.rjw.lan> <20170320035745.GC25659@vireshk-i7> <CAKfTPtD8bp-mB=9Rjufeyj3weg6T3b1J-o+Sc2Oe2EMGX3zKzQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:52832 "EHLO
        cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753882AbdCTNFe (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 20 Mar 2017 09:05:34 -0400
In-Reply-To: <CAKfTPtD8bp-mB=9Rjufeyj3weg6T3b1J-o+Sc2Oe2EMGX3zKzQ@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Vincent Guittot <vincent.guittot@linaro.org>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, Linux PM <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Juri Lelli <juri.lelli@arm.com>, Patrick Bellasi <patrick.bellasi@arm.com>, Joel Fernandes <joelaf@google.com>, Morten Rasmussen <morten.rasmussen@arm.com>, Ingo Molnar <mingo@redhat.com>

On Monday, March 20, 2017 09:26:34 AM Vincent Guittot wrote:
> On 20 March 2017 at 04:57, Viresh Kumar <viresh.kumar@linaro.org> wrote:
> > On 19-03-17, 14:34, Rafael J. Wysocki wrote:
> >> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> >>
> >> The PELT metric used by the schedutil governor underestimates the
> >> CPU utilization in some cases.  The reason for that may be time spent
> >> in interrupt handlers and similar which is not accounted for by PELT.
> 
> Are you sure of the root cause  described above (time stolen by irq
> handler) or is it just a hypotheses ? That would be good to be sure of
> the root cause

No, I'm not sure.  That's why I said "may be". :-)

> Furthermore, IIRC the time spent in irq context is also accounted as
> run time for the running cfs task but not RT and deadline task running
> time

OK

Anyway, the problem is that we have a 100% busy CPU which quite evidently
is not reported as 100% busy by the metric we use.

Now, if I was sure about the root cause, I would fix it rather than suggest
workarounds.

> So I'm not really aligned with the description of your problem: PELT
> metric underestimates the load of the CPU.  The PELT is just about
> tracking CFS task utilization but not whole CPU utilization and
> according to your description of the problem (time stolen by irq),
> your problem doesn't come from an underestimation of CFS task but from
> time spent in something else but not accounted in the value used by
> schedutil

That's fair enough, but the assumption was that PELT would be sufficient for
that.  To me, it clearly isn't, so the assumption was incorrect.

> That would be good to be sure of what is running during this not
> accounted time and find a way to account them

Yes, I agree.

I'm not sure if I can carry out full investigation of that any time soon, however.

I sent this mostly to let everybody know that there was a problem and how it
could be worked around.  That's why it is an RFC.

> 
> >>
> >> That can be easily demonstrated by running kernel compilation on
> >> a Sandy Bridge Intel processor, running turbostat in parallel with
> >> it and looking at the values written to the MSR_IA32_PERF_CTL
> >> register.  Namely, the expected result would be that when all CPUs
> >> were 100% busy, all of them would be requested to run in the maximum
> >> P-state, but observation shows that this clearly isn't the case.
> >> The CPUs run in the maximum P-state for a while and then are
> >> requested to run slower and go back to the maximum P-state after
> >> a while again.  That causes the actual frequency of the processor to
> >> visibly oscillate below the sustainable maximum in a jittery fashion
> >> which clearly is not desirable.
> >>
> >> To work around this issue use the observation that, from the
> >> schedutil governor's perspective, CPUs that are never idle should
> >> always run at the maximum frequency and make that happen.
> >>
> >> To that end, add a counter of idle calls to struct sugov_cpu and
> >> modify cpuidle_idle_call() to increment that counter every time it
> >> is about to put the given CPU into an idle state.  Next, make the
> >> schedutil governor look at that counter for the current CPU every
> >> time before it is about to start heavy computations.  If the counter
> >> has not changed for over SUGOV_BUSY_THRESHOLD time (equal to 50 ms),
> >> the CPU has not been idle for at least that long and the governor
> >> will choose the maximum frequency for it without looking at the PELT
> >> metric at all.
> >
> > Looks like we are fixing a PELT problem with a schedutil Hack :)
> 
> I would not say that it's a PELT problem (at least based on current
> description) but more that we don't track all
> activities of CPU

I generally agree.  PELT does what it does.

However, using PELT the way we do that in schedutil turns out to be problematic.

Thanks,
Rafael
