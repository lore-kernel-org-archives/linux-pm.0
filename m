From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v9 02/15] sched/cpufreq: Prepare schedutil for Energy
 Aware Scheduling
Date: Tue, 20 Nov 2018 16:25:14 +0100
Message-ID: <20181120152514.GD2113@hirez.programming.kicks-ass.net>
References: <20181119141857.8625-1-quentin.perret@arm.com>
 <20181119141857.8625-3-quentin.perret@arm.com>
 <20181120044602.bsfsp4alswbwoweu@vireshk-i7>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20181120044602.bsfsp4alswbwoweu@vireshk-i7>
Sender: linux-kernel-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Quentin Perret <quentin.perret@arm.com>, rjw@rjwysocki.net, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, gregkh@linuxfoundation.org, mingo@redhat.com, dietmar.eggemann@arm.com, morten.rasmussen@arm.com, chris.redpath@arm.com, patrick.bellasi@arm.com, valentin.schneider@arm.com, vincent.guittot@linaro.org, thara.gopinath@linaro.org, tkjos@google.com, joel@joelfernandes.org, smuckle@google.com, adharmap@codeaurora.org, skannan@codeaurora.org, pkondeti@codeaurora.org, juri.lelli@redhat.com, edubezval@gmail.com, srinivas.pandruvada@linux.intel.com, currojerez@riseup.net, javi.merino@kernel.org
List-Id: linux-pm@vger.kernel.org

On Tue, Nov 20, 2018 at 10:16:02AM +0530, Viresh Kumar wrote:
> On 19-11-18, 14:18, Quentin Perret wrote:
> > @@ -223,20 +222,33 @@ static unsigned long sugov_get_util(struct sugov_cpu *sg_cpu)
> 
> > -	if ((util + cpu_util_dl(rq)) >= max)
> > -		return max;
> > +	if (type == FREQUENCY_UTIL) {
> > +		/*
> > +		 * For frequency selection we do not make cpu_util_dl() a
> > +		 * permanent part of this sum because we want to use
> > +		 * cpu_bw_dl() later on, but we need to check if the
> > +		 * CFS+RT+DL sum is saturated (ie. no idle time) such
> > +		 * that we select f_max when there is no idle time.
> > +		 *
> > +		 * NOTE: numerical errors or stop class might cause us
> > +		 * to not quite hit saturation when we should --
> > +		 * something for later.
> > +		 */
> > +
> > +		if ((util + cpu_util_dl(rq)) >= max)
> > +			return max;
> > +	} else {
> > +		/*
> > +		 * OTOH, for energy computation we need the estimated
> > +		 * running time, so include util_dl and ignore dl_bw.
> > +		 */
> > +		util += cpu_util_dl(rq);
> > +		if (util >= max)
> > +			return max;
> > +	}
> 
> Maybe write above as:
> 
>         dl_util = cpu_util_dl(rq);
> 
>         if ((util + dl_util) >= max)
>                 return max;
> 
> 	if (type != FREQUENCY_UTIL)
> 		util += dl_util;
> 
> 
> as both the if/else parts were doing almost the same thing.

A little like so ?

--- a/kernel/sched/cpufreq_schedutil.c
+++ b/kernel/sched/cpufreq_schedutil.c
@@ -201,8 +201,8 @@ static unsigned int get_next_freq(struct
 unsigned long schedutil_freq_util(int cpu, unsigned long util_cfs,
 				  unsigned long max, enum schedutil_type type)
 {
+	unsigned long dl_util, util, irq;
 	struct rq *rq = cpu_rq(cpu);
-	unsigned long util, irq;
 
 	if (type == FREQUENCY_UTIL && rt_rq_is_runnable(&rq->rt))
 		return max;
@@ -225,30 +225,26 @@ unsigned long schedutil_freq_util(int cp
 	util = util_cfs;
 	util += cpu_util_rt(rq);
 
-	if (type == FREQUENCY_UTIL) {
-		/*
-		 * For frequency selection we do not make cpu_util_dl() a
-		 * permanent part of this sum because we want to use
-		 * cpu_bw_dl() later on, but we need to check if the
-		 * CFS+RT+DL sum is saturated (ie. no idle time) such
-		 * that we select f_max when there is no idle time.
-		 *
-		 * NOTE: numerical errors or stop class might cause us
-		 * to not quite hit saturation when we should --
-		 * something for later.
-		 */
-
-		if ((util + cpu_util_dl(rq)) >= max)
-			return max;
-	} else {
-		/*
-		 * OTOH, for energy computation we need the estimated
-		 * running time, so include util_dl and ignore dl_bw.
-		 */
-		util += cpu_util_dl(rq);
-		if (util >= max)
-			return max;
-	}
+	dl_util = cpu_util_dl(rq);
+
+	/*
+	 * NOTE: numerical errors or stop class might cause us to not quite hit
+	 * saturation when we should -- something for later.
+	 */
+	if (util + dl_util > max)
+		return max;
+
+	/*
+	 * For frequency selection we do not make cpu_util_dl() a permanent
+	 * part of this sum because we want to use cpu_bw_dl() later on, but we
+	 * need to check if the CFS+RT+DL sum is saturated (ie. no idle time)
+	 * such that we select f_max when there is no idle time.
+	 *
+	 * OTOH, for energy computation we need the estimated running time, so
+	 * do include util_dl and ignore dl_bw.
+	 */
+	if (type == ENERGY_UTIL)
+		util += dl_util;
 
 	/*
 	 * There is still idle time; further improve the number by using the
@@ -262,21 +258,18 @@ unsigned long schedutil_freq_util(int cp
 	util = scale_irq_capacity(util, irq, max);
 	util += irq;
 
-	if (type == FREQUENCY_UTIL) {
-		/*
-		 * Bandwidth required by DEADLINE must always be granted
-		 * while, for FAIR and RT, we use blocked utilization of
-		 * IDLE CPUs as a mechanism to gracefully reduce the
-		 * frequency when no tasks show up for longer periods of
-		 * time.
-		 *
-		 * Ideally we would like to set bw_dl as min/guaranteed
-		 * freq and util + bw_dl as requested freq. However,
-		 * cpufreq is not yet ready for such an interface. So,
-		 * we only do the latter for now.
-		 */
+	/*
+	 * Bandwidth required by DEADLINE must always be granted while, for
+	 * FAIR and RT, we use blocked utilization of IDLE CPUs as a mechanism
+	 * to gracefully reduce the frequency when no tasks show up for longer
+	 * periods of time.
+	 *
+	 * Ideally we would like to set bw_dl as min/guaranteed freq and util +
+	 * bw_dl as requested freq. However, cpufreq is not yet ready for such
+	 * an interface. So, we only do the latter for now.
+	 */
+	if (type == FREQUENCY_UTIL)
 		util += cpu_bw_dl(rq);
-	}
 
 	return min(max, util);
 }
