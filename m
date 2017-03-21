From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [RFC][PATCH v2 2/2] cpufreq: schedutil: Avoid decreasing frequency of busy CPUs
Date: Tue, 21 Mar 2017 16:18:52 +0100
Message-ID: <2131318.dozmYt7JVU@aspire.rjw.lan>
References: <4366682.tsferJN35u@aspire.rjw.lan> <1844525.jBn1oKmyb6@aspire.rjw.lan> <20170321150403.GU3093@worktop>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:57805 "EHLO
        cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1756607AbdCUPY0 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 21 Mar 2017 11:24:26 -0400
In-Reply-To: <20170321150403.GU3093@worktop>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Peter Zijlstra <peterz@infradead.org>
Cc: Patrick Bellasi <patrick.bellasi@arm.com>, Vincent Guittot <vincent.guittot@linaro.org>, Linux PM <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Viresh Kumar <viresh.kumar@linaro.org>, Juri Lelli <juri.lelli@arm.com>, Joel Fernandes <joelaf@google.com>, Morten Rasmussen <morten.rasmussen@arm.com>, Ingo Molnar <mingo@redhat.com>

On Tuesday, March 21, 2017 04:04:03 PM Peter Zijlstra wrote:
> On Tue, Mar 21, 2017 at 03:46:07PM +0100, Rafael J. Wysocki wrote:
> > @@ -207,6 +212,8 @@ static void sugov_update_single(struct u
> >  	if (!sugov_should_update_freq(sg_policy, time))
> >  		return;
> >  
> > +	sg_policy->overload = this_rq()->rd->overload;
> > +
> 
> Same problem as before; rd->overload is set if _any_ CPU in the root
> domain has more than 1 runnable task at a random point in history (when
> we ran the load balance tick -- and since that is the same tick used for
> timers, there's a bias to over-account there).

OK

What about the one below then?

It checks both the idle calls count and overload and only then it will prevent
the frequency from being decreased.

It is sufficient for the case at hand.

I guess if rd->overload is not set, this means that none of the CPUs is
oversubscribed and we just saturate the capacity in a one-task-per-CPU kind
of fashion.  Right?

---
 include/linux/tick.h             |    1 +
 kernel/sched/cpufreq_schedutil.c |   27 +++++++++++++++++++++++++++
 kernel/time/tick-sched.c         |   12 ++++++++++++
 3 files changed, 40 insertions(+)

Index: linux-pm/kernel/sched/cpufreq_schedutil.c
===================================================================
--- linux-pm.orig/kernel/sched/cpufreq_schedutil.c
+++ linux-pm/kernel/sched/cpufreq_schedutil.c
@@ -37,6 +37,7 @@ struct sugov_policy {
 	s64 freq_update_delay_ns;
 	unsigned int next_freq;
 	unsigned int cached_raw_freq;
+	bool busy;
 
 	/* The next fields are only needed if fast switch cannot be used. */
 	struct irq_work irq_work;
@@ -56,11 +57,15 @@ struct sugov_cpu {
 	unsigned long iowait_boost;
 	unsigned long iowait_boost_max;
 	u64 last_update;
+#ifdef CONFIG_NO_HZ_COMMON
+	unsigned long saved_idle_calls;
+#endif
 
 	/* The fields below are only needed when sharing a policy. */
 	unsigned long util;
 	unsigned long max;
 	unsigned int flags;
+	bool busy;
 };
 
 static DEFINE_PER_CPU(struct sugov_cpu, sugov_cpu);
@@ -93,6 +98,9 @@ static void sugov_update_commit(struct s
 {
 	struct cpufreq_policy *policy = sg_policy->policy;
 
+	if (sg_policy->busy && next_freq < sg_policy->next_freq)
+		next_freq = sg_policy->next_freq;
+
 	if (policy->fast_switch_enabled) {
 		if (sg_policy->next_freq == next_freq) {
 			trace_cpu_frequency(policy->cur, smp_processor_id());
@@ -192,6 +200,19 @@ static void sugov_iowait_boost(struct su
 	sg_cpu->iowait_boost >>= 1;
 }
 
+#ifdef CONFIG_NO_HZ_COMMON
+static bool sugov_cpu_is_busy(struct sugov_cpu *sg_cpu)
+{
+	unsigned long idle_calls = tick_nohz_get_idle_calls();
+	bool not_idle = idle_calls == sg_cpu->saved_idle_calls;
+
+	sg_cpu->saved_idle_calls = idle_calls;
+	return not_idle && this_rq()->rd->overload;
+}
+#else
+static inline bool sugov_cpu_is_busy(struct sugov_cpu *sg_cpu) { return false; }
+#endif /* CONFIG_NO_HZ_COMMON */
+
 static void sugov_update_single(struct update_util_data *hook, u64 time,
 				unsigned int flags)
 {
@@ -207,6 +228,8 @@ static void sugov_update_single(struct u
 	if (!sugov_should_update_freq(sg_policy, time))
 		return;
 
+	sg_policy->busy = sugov_cpu_is_busy(sg_cpu);
+
 	if (flags & SCHED_CPUFREQ_RT_DL) {
 		next_f = policy->cpuinfo.max_freq;
 	} else {
@@ -225,6 +248,8 @@ static unsigned int sugov_next_freq_shar
 	unsigned long util = 0, max = 1;
 	unsigned int j;
 
+	sg_policy->busy = false;
+
 	for_each_cpu(j, policy->cpus) {
 		struct sugov_cpu *j_sg_cpu = &per_cpu(sugov_cpu, j);
 		unsigned long j_util, j_max;
@@ -253,6 +278,7 @@ static unsigned int sugov_next_freq_shar
 		}
 
 		sugov_iowait_boost(j_sg_cpu, &util, &max);
+		sg_policy->busy = sg_policy->busy || sg_cpu->busy;
 	}
 
 	return get_next_freq(sg_policy, util, max);
@@ -273,6 +299,7 @@ static void sugov_update_shared(struct u
 	sg_cpu->util = util;
 	sg_cpu->max = max;
 	sg_cpu->flags = flags;
+	sg_cpu->busy = sugov_cpu_is_busy(sg_cpu);
 
 	sugov_set_iowait_boost(sg_cpu, time, flags);
 	sg_cpu->last_update = time;
Index: linux-pm/include/linux/tick.h
===================================================================
--- linux-pm.orig/include/linux/tick.h
+++ linux-pm/include/linux/tick.h
@@ -117,6 +117,7 @@ extern void tick_nohz_idle_enter(void);
 extern void tick_nohz_idle_exit(void);
 extern void tick_nohz_irq_exit(void);
 extern ktime_t tick_nohz_get_sleep_length(void);
+extern unsigned long tick_nohz_get_idle_calls(void);
 extern u64 get_cpu_idle_time_us(int cpu, u64 *last_update_time);
 extern u64 get_cpu_iowait_time_us(int cpu, u64 *last_update_time);
 #else /* !CONFIG_NO_HZ_COMMON */
Index: linux-pm/kernel/time/tick-sched.c
===================================================================
--- linux-pm.orig/kernel/time/tick-sched.c
+++ linux-pm/kernel/time/tick-sched.c
@@ -993,6 +993,18 @@ ktime_t tick_nohz_get_sleep_length(void)
 	return ts->sleep_length;
 }
 
+/**
+ * tick_nohz_get_idle_calls - return the current idle calls counter value
+ *
+ * Called from the schedutil frequency scaling governor in scheduler context.
+ */
+unsigned long tick_nohz_get_idle_calls(void)
+{
+	struct tick_sched *ts = this_cpu_ptr(&tick_cpu_sched);
+
+	return ts->idle_calls;
+}
+
 static void tick_nohz_account_idle_ticks(struct tick_sched *ts)
 {
 #ifndef CONFIG_VIRT_CPU_ACCOUNTING_NATIVE
