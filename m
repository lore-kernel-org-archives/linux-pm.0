From: Morten Rasmussen <morten.rasmussen@arm.com>
Subject: Re: [RFCv5 PATCH 25/46] sched: Add over-utilization/tipping point
 indicator
Date: Fri, 14 Aug 2015 14:02:48 +0100
Message-ID: <20150814130247.GD29326@e105550-lin.cambridge.arm.com>
References: <1436293469-25707-1-git-send-email-morten.rasmussen@arm.com>
 <1436293469-25707-26-git-send-email-morten.rasmussen@arm.com>
 <20150813173533.GZ19282@twins.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:38220 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751856AbbHNM71 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Fri, 14 Aug 2015 08:59:27 -0400
Content-Disposition: inline
In-Reply-To: <20150813173533.GZ19282@twins.programming.kicks-ass.net>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Peter Zijlstra <peterz@infradead.org>
Cc: mingo@redhat.com, vincent.guittot@linaro.org, daniel.lezcano@linaro.org, Dietmar Eggemann <Dietmar.Eggemann@arm.com>, yuyang.du@intel.com, mturquette@baylibre.com, rjw@rjwysocki.net, Juri Lelli <Juri.Lelli@arm.com>, sgurrappadi@nvidia.com, pang.xunlei@zte.com.cn, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org

On Thu, Aug 13, 2015 at 07:35:33PM +0200, Peter Zijlstra wrote:
> On Tue, Jul 07, 2015 at 07:24:08PM +0100, Morten Rasmussen wrote:
> > Energy-aware scheduling is only meant to be active while the system is
> > _not_ over-utilized. That is, there are spare cycles available to shift
> > tasks around based on their actual utilization to get a more
> > energy-efficient task distribution without depriving any tasks. When
> > above the tipping point task placement is done the traditional way,
> > spreading the tasks across as many cpus as possible based on priority
> > scaled load to preserve smp_nice.
> > 
> > The over-utilization condition is conservatively chosen to indicate
> > over-utilization as soon as one cpu is fully utilized at it's highest
> > frequency. We don't consider groups as lumping usage and capacity
> > together for a group of cpus may hide the fact that one or more cpus in
> > the group are over-utilized while group-siblings are partially idle. The
> > tasks could be served better if moved to another group with completely
> > idle cpus. This is particularly problematic if some cpus have a
> > significantly reduced capacity due to RT/IRQ pressure or if the system
> > has cpus of different capacity (e.g. ARM big.LITTLE).
> 
> I might be tired, but I'm having a very hard time deciphering this
> second paragraph.

I can see why, let me try again :-)

It is essentially about when do we make balancing decisions based on
load_avg and util_avg (using the new names in Yuyang's rewrite). As you
mentioned in another thread recently, we want to use util_avg until the
system is over-utilized and then switch to load_avg. We need to define
the conditions that determine the switch.

The util_avg for each cpu converges towards 100% (1024) regardless of
how many task additional task we may put on it. If we define
over-utilized as being something like:

sum_{cpus}(rq::cfs::avg::util_avg) + margin > sum_{cpus}(rq::capacity)

some individual cpus may be over-utilized running multiple tasks even
when the above condition is false. That should be okay as long as we try
to spread the tasks out to avoid per-cpu over-utilization as much as
possible and if all tasks have the _same_ priority. If the latter isn't
true, we have to consider priority to preserve smp_nice.

For example, we could have n_cpus nice=-10 util_avg=55% tasks and
n_cpus/2 nice=0 util_avg=60%. Balancing based on util_avg we are likely
to end up with nice=-10 sharing cpus and nice=0 getting their own as we
1.5*n_cpus tasks in total and 55%+55% is less over-utilized than 55%+60%
for those cpus that have to be shared. The system utilization is only
85% of the system capacity, but we are breaking smp_nice.

To be sure not to break smp_nice, we have defined over-utilization as
when:

cpu_rq(any)::cfs::avg::util_avg + margin > cpu_rq(any)::capacity

is true for any cpu in the system. IOW, as soon as one cpu is (nearly)
100% utilized, we switch to load_avg to factor in priority.

Now with this definition, we can skip periodic load-balance as no cpu
has an always-running task when the system is not over-utilized. All
tasks will be periodic and we can balance them at wake-up. This
conservative condition does however mean that some scenarios that could
benefit from energy-aware decisions even if one cpu is fully utilized
would not get those benefits.

For system where some cpus might have reduced capacity on some cpus
(RT-pressure and/or big.LITTLE), we want periodic load-balance checks as
soon a just a single cpu is fully utilized as it might one of those with
reduced capacity and in that case we want to migrate it.

I haven't found any reasonably easy-to-track conditions that would work
better. Suggestions are very welcome.

