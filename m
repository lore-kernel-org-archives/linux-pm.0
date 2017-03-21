From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [RFC][PATCH v2 2/2] cpufreq: schedutil: Avoid decreasing frequency of busy CPUs
Date: Tue, 21 Mar 2017 18:17:07 +0100
Message-ID: <1560652.F01cW7lor0@aspire.rjw.lan>
References: <4366682.tsferJN35u@aspire.rjw.lan> <2131318.dozmYt7JVU@aspire.rjw.lan> <20170321170017.tqxcwmtolsqkc4ui@hirez.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:50001 "EHLO
        cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1757292AbdCURWo (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 21 Mar 2017 13:22:44 -0400
In-Reply-To: <20170321170017.tqxcwmtolsqkc4ui@hirez.programming.kicks-ass.net>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Peter Zijlstra <peterz@infradead.org>
Cc: Patrick Bellasi <patrick.bellasi@arm.com>, Vincent Guittot <vincent.guittot@linaro.org>, Linux PM <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Viresh Kumar <viresh.kumar@linaro.org>, Juri Lelli <juri.lelli@arm.com>, Joel Fernandes <joelaf@google.com>, Morten Rasmussen <morten.rasmussen@arm.com>, Ingo Molnar <mingo@redhat.com>

On Tuesday, March 21, 2017 06:00:17 PM Peter Zijlstra wrote:
> On Tue, Mar 21, 2017 at 04:18:52PM +0100, Rafael J. Wysocki wrote:
> > +static bool sugov_cpu_is_busy(struct sugov_cpu *sg_cpu)
> > +{
> > +	unsigned long idle_calls = tick_nohz_get_idle_calls();
> > +	bool not_idle = idle_calls == sg_cpu->saved_idle_calls;
> > +
> > +	sg_cpu->saved_idle_calls = idle_calls;
> > +	return not_idle && this_rq()->rd->overload;
> > +}
> 
> So I really don't understand the rd->overload thing. What is it supposed
> to do here?

The idea was that if the CPU was running one task saturating the capacity which
then was migrated out of it, the frequency should still be reduced.

And since rd->overload covers all CPUs (in general) it kind of tells us whether
or not there are other tasks to replace the migrated one any time soon.

However, if there are no tasks to replace the migrated one, the CPU will go
idle quickly (as there are no taks to run on it), in which case keeping the
current frequency on it shouldn't matter.

In all of the other cases keeping the current frequency is the right thing to
do IMO.

So, it looks like checking this_rq()->rd->overload doesn't really help after all. :-)

Thanks,
Rafael
