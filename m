From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [RFC][PATCH v2 2/2] cpufreq: schedutil: Avoid decreasing frequency of busy CPUs
Date: Tue, 21 Mar 2017 15:50:10 +0100
Message-ID: <2491055.bx2pWYvmMQ@aspire.rjw.lan>
References: <4366682.tsferJN35u@aspire.rjw.lan> <20170321143842.GE11054@e110439-lin> <1844525.jBn1oKmyb6@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:58053 "EHLO
        cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1755420AbdCUPCZ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 21 Mar 2017 11:02:25 -0400
In-Reply-To: <1844525.jBn1oKmyb6@aspire.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Patrick Bellasi <patrick.bellasi@arm.com>
Cc: Vincent Guittot <vincent.guittot@linaro.org>, Peter Zijlstra <peterz@infradead.org>, Linux PM <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Viresh Kumar <viresh.kumar@linaro.org>, Juri Lelli <juri.lelli@arm.com>, Joel Fernandes <joelaf@google.com>, Morten Rasmussen <morten.rasmussen@arm.com>, Ingo Molnar <mingo@redhat.com>

On Tuesday, March 21, 2017 03:46:07 PM Rafael J. Wysocki wrote:
> On Tuesday, March 21, 2017 02:38:42 PM Patrick Bellasi wrote:
> > On 21-Mar 15:26, Rafael J. Wysocki wrote:
> > > On Tuesday, March 21, 2017 02:37:08 PM Vincent Guittot wrote:
> > > > On 21 March 2017 at 14:22, Peter Zijlstra <peterz@infradead.org> wrote:
> > > > > On Tue, Mar 21, 2017 at 09:50:28AM +0100, Vincent Guittot wrote:
> > > > >> On 20 March 2017 at 22:46, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> > > > >
> > > > >> > To work around this issue use the observation that, from the
> > > > >> > schedutil governor's perspective, it does not make sense to decrease
> > > > >> > the frequency of a CPU that doesn't enter idle and avoid decreasing
> > > > >> > the frequency of busy CPUs.
> > > > >>
> > > > >> I don't fully agree with that statement.
> > > > >> If there are 2 runnable tasks on CPU A and scheduler migrates the
> > > > >> waiting task to another CPU B so CPU A is less loaded now, it makes
> > > > >> sense to reduce the OPP. That's even for that purpose that we have
> > > > >> decided to use scheduler metrics in cpufreq governor so we can adjust
> > > > >> OPP immediately when tasks migrate.
> > > > >> That being said, i probably know why you see such OPP switches in your
> > > > >> use case. When we migrate a task, we also migrate/remove its
> > > > >> utilization from CPU.
> > > > >> If the CPU is not overloaded, it means that runnable tasks have all
> > > > >> computation that they need and don't have any reason to use more when
> > > > >> a task migrates to another CPU. so decreasing the OPP makes sense
> > > > >> because the utilzation is decreasing
> > > > >> If the CPU is overloaded, it means that runnable tasks have to share
> > > > >> CPU time and probably don't have all computations that they would like
> > > > >> so when a task migrate, the remaining tasks on the CPU will increase
> > > > >> their utilization and fill space left by the task that has just
> > > > >> migrated. So the CPU's utilization will decrease when a task migrates
> > > > >> (and as a result the OPP) but then its utilization will increase with
> > > > >> remaining tasks running more time as well as the OPP
> > > > >>
> > > > >> So you need to make the difference between this 2 cases: Is a CPU
> > > > >> overloaded or not. You can't really rely on the utilization to detect
> > > > >> that but you could take advantage of the load which take into account
> > > > >> the waiting time of tasks
> > > > >
> > > > > I'm confused. What two cases? You only list the overloaded case, but he
> > > > 
> > > > overloaded vs not overloaded use case.
> > > > For the not overloaded case, it makes sense to immediately update to
> > > > OPP to be aligned with the new utilization of the CPU even if it was
> > > > not idle in the past couple of ticks
> > > 
> > > Yes, if the OPP (or P-state if you will) can be changed immediately.  If it can't,
> > > conditions may change by the time we actually update it and in that case It'd
> > > be better to wait and see IMO.
> > > 
> > > In any case, the theory about migrating tasks made sense to me, so below is
> > > what I tested.  It works, and besides it has a nice feature that I don't need
> > > to fetch for the timekeeping data. :-)
> > > 
> > > I only wonder if we want to do this or only prevent the frequency from
> > > decreasing in the overloaded case?
> > > 
> > > ---
> > >  kernel/sched/cpufreq_schedutil.c |    8 +++++---
> > >  1 file changed, 5 insertions(+), 3 deletions(-)
> > > 
> > > Index: linux-pm/kernel/sched/cpufreq_schedutil.c
> > > ===================================================================
> > > --- linux-pm.orig/kernel/sched/cpufreq_schedutil.c
> > > +++ linux-pm/kernel/sched/cpufreq_schedutil.c
> > > @@ -61,6 +61,7 @@ struct sugov_cpu {
> > >  	unsigned long util;
> > >  	unsigned long max;
> > >  	unsigned int flags;
> > > +	bool overload;
> > >  };
> > >  
> > >  static DEFINE_PER_CPU(struct sugov_cpu, sugov_cpu);
> > > @@ -207,7 +208,7 @@ static void sugov_update_single(struct u
> > >  	if (!sugov_should_update_freq(sg_policy, time))
> > >  		return;
> > >  
> > > -	if (flags & SCHED_CPUFREQ_RT_DL) {
> > > +	if ((flags & SCHED_CPUFREQ_RT_DL) || this_rq()->rd->overload) {
> > >  		next_f = policy->cpuinfo.max_freq;
> > 
> > Isn't this going to max OPP every time we have more than 1 task in
> > that CPU?
> > 
> > In that case it will not fit the case: we have two 10% tasks on that CPU.
> 
> Good point.
> 
> > Previous solution was better IMO, apart from using overloaded instead
> > of overutilized (which is not yet there) :-/
> 
> OK, so the one below works too.

Admittedly, we could check the idle condition and the overload flag at the same
time, though.

Let me try that too.

Thanks,
Rafael
