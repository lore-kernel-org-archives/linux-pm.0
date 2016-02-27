From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [RFCv7 PATCH 03/10] sched: scheduler-driven cpu frequency selection
Date: Sat, 27 Feb 2016 01:08:02 +0100
Message-ID: <1743951.Hhdov0yvNG@vostro.rjw.lan>
References: <1456190570-4475-1-git-send-email-smuckle@linaro.org> <1792311.cuUNhUde5n@vostro.rjw.lan> <20160226091843.GX6356@twins.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:41495 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1752176AbcB0AG0 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 26 Feb 2016 19:06:26 -0500
In-Reply-To: <20160226091843.GX6356@twins.programming.kicks-ass.net>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Peter Zijlstra <peterz@infradead.org>
Cc: Steve Muckle <steve.muckle@linaro.org>, Ingo Molnar <mingo@redhat.com>, "Rafael J. Wysocki" <rafael@kernel.org>, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>, Morten Rasmussen <morten.rasmussen@arm.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>, Juri Lelli <Juri.Lelli@arm.com>, Patrick Bellasi <patrick.bellasi@arm.com>, Michael Turquette <mturquette@baylibre.com>, Ricky Liang <jcliang@chromium.org>

On Friday, February 26, 2016 10:18:43 AM Peter Zijlstra wrote:
> On Thu, Feb 25, 2016 at 10:08:48PM +0100, Rafael J. Wysocki wrote:
> > On Thursday, February 25, 2016 10:28:37 AM Peter Zijlstra wrote:
> > > Its vile though; one should not spray IPIs if one can avoid it. Such
> > > things are much better done with RCU. Sure sync_sched() takes a little
> > > longer, but this isn't a fast path by any measure.
> > 
> > I see, thanks!
> > 
> > BTW, when cpufreq_update_util() callbacks are removed, I use synchronize_rcu()
> > to wait for the running ones, but would it be better to use synchronize_sched()
> > in there instead?
> 
> So I think we only call the callback with rq->lock held, in which case
> sync_sched() is good enough.
> 
> It would allow you to get rid of the rcu_read_{,un}lock() calls as well.
> 
> The down-side is that it all makes the code a little harder to get,
> because you're relying on caller context to DTRT.

OK, so what about the below (on top of linux-next)?

It has passed my cursory testing.

---
From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Subject: [PATCH] cpufreq: Reduce cpufreq_update_util() overhead a bit

Use the observation that cpufreq_update_util() is only called
by the scheduler with rq->lock held, so the callers of
cpufreq_set_update_util_data() can use synchronize_sched()
instead of synchronize_rcu() to wait for cpufreq_update_util()
to complete.  Moreover, if they are updated to do that,
rcu_read_(un)lock() calls in cpufreq_update_util() might be
replaced with rcu_read_(un)lock_sched(), respectively, but
those aren't really necessary, because the scheduler calls
that function from RCU-sched read-side critical sections
already.

In addition to that, if cpufreq_set_update_util_data() checks
the func field in the struct update_util_data before setting
the per-CPU pointer to it, the data->func check may be dropped
from cpufreq_update_util() as well.

Make the above changes to reduce the overhead from
cpufreq_update_util() in the scheduler paths invoking it
and to make the cleanup after removing its callbacks less
heavy-weight somewhat.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/cpufreq/cpufreq.c          |   21 +++++++++++++--------
 drivers/cpufreq/cpufreq_governor.c |    2 +-
 drivers/cpufreq/intel_pstate.c     |    4 ++--
 3 files changed, 16 insertions(+), 11 deletions(-)

Index: linux-pm/drivers/cpufreq/cpufreq.c
===================================================================
--- linux-pm.orig/drivers/cpufreq/cpufreq.c
+++ linux-pm/drivers/cpufreq/cpufreq.c
@@ -77,12 +77,15 @@ static DEFINE_PER_CPU(struct update_util
  * to call from cpufreq_update_util().  That function will be called from an RCU
  * read-side critical section, so it must not sleep.
  *
- * Callers must use RCU callbacks to free any memory that might be accessed
- * via the old update_util_data pointer or invoke synchronize_rcu() right after
- * this function to avoid use-after-free.
+ * Callers must use RCU-sched callbacks to free any memory that might be
+ * accessed via the old update_util_data pointer or invoke synchronize_sched()
+ * right after this function to avoid use-after-free.
  */
 void cpufreq_set_update_util_data(int cpu, struct update_util_data *data)
 {
+	if (WARN_ON(data && !data->func))
+		return;
+
 	rcu_assign_pointer(per_cpu(cpufreq_update_util_data, cpu), data);
 }
 EXPORT_SYMBOL_GPL(cpufreq_set_update_util_data);
@@ -95,18 +98,20 @@ EXPORT_SYMBOL_GPL(cpufreq_set_update_uti
  *
  * This function is called by the scheduler on every invocation of
  * update_load_avg() on the CPU whose utilization is being updated.
+ *
+ * It can only be called from RCU-sched read-side critical sections.
  */
 void cpufreq_update_util(u64 time, unsigned long util, unsigned long max)
 {
 	struct update_util_data *data;
 
-	rcu_read_lock();
-
 	data = rcu_dereference(*this_cpu_ptr(&cpufreq_update_util_data));
-	if (data && data->func)
+	/*
+	 * If this isn't inside of an RCU-sched read-side critical section, data
+	 * may become NULL after the check below.
+	 */
+	if (data)
 		data->func(data, time, util, max);
-
-	rcu_read_unlock();
 }
 
 /* Flag to suspend/resume CPUFreq governors */
Index: linux-pm/drivers/cpufreq/cpufreq_governor.c
===================================================================
--- linux-pm.orig/drivers/cpufreq/cpufreq_governor.c
+++ linux-pm/drivers/cpufreq/cpufreq_governor.c
@@ -280,7 +280,7 @@ static inline void gov_clear_update_util
 	for_each_cpu(i, policy->cpus)
 		cpufreq_set_update_util_data(i, NULL);
 
-	synchronize_rcu();
+	synchronize_sched();
 }
 
 static void gov_cancel_work(struct cpufreq_policy *policy)
Index: linux-pm/drivers/cpufreq/intel_pstate.c
===================================================================
--- linux-pm.orig/drivers/cpufreq/intel_pstate.c
+++ linux-pm/drivers/cpufreq/intel_pstate.c
@@ -1171,7 +1171,7 @@ static void intel_pstate_stop_cpu(struct
 	pr_debug("intel_pstate: CPU %d exiting\n", cpu_num);
 
 	cpufreq_set_update_util_data(cpu_num, NULL);
-	synchronize_rcu();
+	synchronize_sched();
 
 	if (hwp_active)
 		return;
@@ -1429,7 +1429,7 @@ out:
 	for_each_online_cpu(cpu) {
 		if (all_cpu_data[cpu]) {
 			cpufreq_set_update_util_data(cpu, NULL);
-			synchronize_rcu();
+			synchronize_sched();
 			kfree(all_cpu_data[cpu]);
 		}
 	}

