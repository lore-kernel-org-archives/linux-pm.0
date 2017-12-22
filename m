From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v3 0/6] cpufreq: schedutil: fixes for flags updates
Date: Fri, 22 Dec 2017 11:06:27 +0100
Message-ID: <20171222100626.7g5yklspjofcp2we@hirez.programming.kicks-ass.net>
References: <20171130114723.29210-1-patrick.bellasi@arm.com>
 <20171220153029.dqrtjbyowhqdl56r@hirez.programming.kicks-ass.net>
 <20171220173814.GC22246@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20171220173814.GC22246@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
To: Juri Lelli <juri.lelli@redhat.com>
Cc: Patrick Bellasi <patrick.bellasi@arm.com>, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Ingo Molnar <mingo@redhat.com>, "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, Viresh Kumar <viresh.kumar@linaro.org>, Vincent Guittot <vincent.guittot@linaro.org>, Dietmar Eggemann <dietmar.eggemann@arm.com>, Morten Rasmussen <morten.rasmussen@arm.com>, Todd Kjos <tkjos@android.com>, Joel Fernandes <joelaf@google.com>
List-Id: linux-pm@vger.kernel.org

On Wed, Dec 20, 2017 at 06:38:14PM +0100, Juri Lelli wrote:
> On 20/12/17 16:30, Peter Zijlstra wrote:
> 
> [...]
> 
> > @@ -327,12 +331,7 @@ static unsigned int sugov_next_freq_shar
> >  		if (delta_ns > TICK_NSEC) {
> >  			j_sg_cpu->iowait_boost = 0;
> >  			j_sg_cpu->iowait_boost_pending = false;
> > -			j_sg_cpu->util_cfs = 0;
> > -			if (j_sg_cpu->util_dl == 0)
> > -				continue;
> >  		}
> 
> This goes away because with Brendan/Vincent fix we don't need the
> workaround for stale CFS util contribution for idle CPUs anymore?

An easy fix would be something like the below I suppose (also folded a
change from Viresh).

This way it completely ignores the demand from idle CPUs. Which I
suppose is exactly what you want, no?

diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_schedutil.c
index ab84d2261554..9736b537386a 100644
--- a/kernel/sched/cpufreq_schedutil.c
+++ b/kernel/sched/cpufreq_schedutil.c
@@ -315,8 +315,8 @@ static unsigned int sugov_next_freq_shared(struct sugov_cpu *sg_cpu, u64 time)
 		unsigned long j_util, j_max;
 		s64 delta_ns;
 
-		if (j_sg_cpu != sg_cpu)
-			sugov_get_util(j_sg_cpu);
+		if (idle_cpu(j))
+			continue;
 
 		/*
 		 * If the CFS CPU utilization was last updated before the
@@ -354,7 +354,6 @@ static void sugov_update_shared(struct update_util_data *hook, u64 time,
 
 	raw_spin_lock(&sg_policy->update_lock);
 
-	sugov_get_util(sg_cpu);
 	sugov_set_iowait_boost(sg_cpu, time, flags);
 	sg_cpu->last_update = time;
 
