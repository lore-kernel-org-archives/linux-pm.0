From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v2 1/10] cpufreq: Reduce cpufreq_update_util() overhead a
 bit
Date: Wed, 9 Mar 2016 13:39:56 +0100
Message-ID: <20160309123956.GM6356@twins.programming.kicks-ass.net>
References: <2495375.dFbdlAZmA6@vostro.rjw.lan>
 <2409306.qzzMXcm4dm@vostro.rjw.lan>
 <1988425.XTpZIAJINa@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1988425.XTpZIAJINa@vostro.rjw.lan>
Sender: linux-acpi-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Linux PM list <linux-pm@vger.kernel.org>, Juri Lelli <juri.lelli@arm.com>, Steve Muckle <steve.muckle@linaro.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Viresh Kumar <viresh.kumar@linaro.org>, Vincent Guittot <vincent.guittot@linaro.org>, Michael Turquette <mturquette@baylibre.com>, Ingo Molnar <mingo@kernel.org>
List-Id: linux-pm@vger.kernel.org

On Fri, Mar 04, 2016 at 03:58:22AM +0100, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> Use the observation that cpufreq_update_util() is only called
> by the scheduler with rq->lock held, so the callers of
> cpufreq_set_update_util_data() can use synchronize_sched()
> instead of synchronize_rcu() to wait for cpufreq_update_util()
> to complete.  Moreover, if they are updated to do that,
> rcu_read_(un)lock() calls in cpufreq_update_util() might be
> replaced with rcu_read_(un)lock_sched(), respectively, but
> those aren't really necessary, because the scheduler calls
> that function from RCU-sched read-side critical sections
> already.
> 
> In addition to that, if cpufreq_set_update_util_data() checks
> the func field in the struct update_util_data before setting
> the per-CPU pointer to it, the data->func check may be dropped
> from cpufreq_update_util() as well.
> 
> Make the above changes to reduce the overhead from
> cpufreq_update_util() in the scheduler paths invoking it
> and to make the cleanup after removing its callbacks less
> heavy-weight somewhat.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
> 
> Changes from the previous version:
> - Use rcu_dereference_sched() in cpufreq_update_util().

Which I think also shows the WARN_ON I insisted upon is redundant.

In any case, I cannot object to reducing overhead, esp. as this whole
patch was suggested by me in the first place, so:

Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>

That said, how about the below? It avoids a function call.

Ideally the whole thing would be a single direct function call, but
because of the current situation with multiple governors we're stuck
with the indirect call :/


---
 drivers/cpufreq/cpufreq.c | 30 +-----------------------------
 include/linux/cpufreq.h   | 33 +++++++++++++++++++++++++++------
 2 files changed, 28 insertions(+), 35 deletions(-)

diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index b6dd41824368..d594bf18cb02 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -65,7 +65,7 @@ static struct cpufreq_driver *cpufreq_driver;
 static DEFINE_PER_CPU(struct cpufreq_policy *, cpufreq_cpu_data);
 static DEFINE_RWLOCK(cpufreq_driver_lock);
 
-static DEFINE_PER_CPU(struct update_util_data *, cpufreq_update_util_data);
+DEFINE_PER_CPU(struct update_util_data *, cpufreq_update_util_data);
 
 /**
  * cpufreq_set_update_util_data - Populate the CPU's update_util_data pointer.
@@ -90,34 +90,6 @@ void cpufreq_set_update_util_data(int cpu, struct update_util_data *data)
 }
 EXPORT_SYMBOL_GPL(cpufreq_set_update_util_data);
 
-/**
- * cpufreq_update_util - Take a note about CPU utilization changes.
- * @time: Current time.
- * @util: Current utilization.
- * @max: Utilization ceiling.
- *
- * This function is called by the scheduler on every invocation of
- * update_load_avg() on the CPU whose utilization is being updated.
- *
- * It can only be called from RCU-sched read-side critical sections.
- */
-void cpufreq_update_util(u64 time, unsigned long util, unsigned long max)
-{
-	struct update_util_data *data;
-
-#ifdef CONFIG_LOCKDEP
-	WARN_ON(debug_locks && !rcu_read_lock_sched_held());
-#endif
-
-	data = rcu_dereference_sched(*this_cpu_ptr(&cpufreq_update_util_data));
-	/*
-	 * If this isn't inside of an RCU-sched read-side critical section, data
-	 * may become NULL after the check below.
-	 */
-	if (data)
-		data->func(data, time, util, max);
-}
-
 /* Flag to suspend/resume CPUFreq governors */
 static bool cpufreq_suspended;
 
diff --git a/include/linux/cpufreq.h b/include/linux/cpufreq.h
index 277024ff2289..62d2a1d623e9 100644
--- a/include/linux/cpufreq.h
+++ b/include/linux/cpufreq.h
@@ -146,7 +146,33 @@ static inline bool policy_is_shared(struct cpufreq_policy *policy)
 extern struct kobject *cpufreq_global_kobject;
 
 #ifdef CONFIG_CPU_FREQ
-void cpufreq_update_util(u64 time, unsigned long util, unsigned long max);
+
+struct update_util_data {
+	void (*func)(struct update_util_data *data,
+		     u64 time, unsigned long util, unsigned long max);
+};
+
+DECLARE_PER_CPU(struct update_util_data *, cpufreq_update_util_data);
+
+/**
+ * cpufreq_update_util - Take a note about CPU utilization changes.
+ * @time: Current time.
+ * @util: Current utilization.
+ * @max: Utilization ceiling.
+ *
+ * This function is called by the scheduler on every invocation of
+ * update_load_avg() on the CPU whose utilization is being updated.
+ *
+ * It can only be called from RCU-sched read-side critical sections.
+ */
+static inline void cpufreq_update_util(u64 time, unsigned long util, unsigned long max)
+{
+	struct update_util_data *data;
+
+	data = rcu_dereference_sched(*this_cpu_ptr(&cpufreq_update_util_data));
+	if (data)
+		data->func(data, time, util, max);
+}
 
 /**
  * cpufreq_trigger_update - Trigger CPU performance state evaluation if needed.
@@ -169,11 +195,6 @@ static inline void cpufreq_trigger_update(u64 time)
 	cpufreq_update_util(time, ULONG_MAX, 0);
 }
 
-struct update_util_data {
-	void (*func)(struct update_util_data *data,
-		     u64 time, unsigned long util, unsigned long max);
-};
-
 void cpufreq_set_update_util_data(int cpu, struct update_util_data *data);
 
 unsigned int cpufreq_get(unsigned int cpu);
