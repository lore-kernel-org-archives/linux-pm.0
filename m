From: Thomas Renninger <trenn@suse.de>
Subject: [PATCH 1/2] PERF(kernel): Cleanup power events
Date: Fri,  1 Oct 2010 17:04:23 +0200
Message-ID: <1285945464-10884-2-git-send-email-trenn__22647.7650496692$1285945532$gmane$org@suse.de>
References: <1285945464-10884-1-git-send-email-trenn@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1285945464-10884-1-git-send-email-trenn@suse.de>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: linux-trace-users@vger.kernel.org, linux-pm@lists.linux-foundation.org, linux-perf-users@vger.kernel.org, mingo@elte.hu, arjan@linux.intel.com, rjw@sisk.pl, jean.pihet@ne
Cc: Peter Zijlstra <peterz@infradead.org>, Frank Eigler <fche@redhat.com>, Steven Rostedt <rostedt@goodmis.org>
List-Id: linux-pm@vger.kernel.org

New power trace events:
power:processor_idle
power:processor_frequency
power:machine_suspend


C-state/idle accounting events:
  power:power_start
  power:power_end
are replaced with:
  power:processor_idle

and
  power:power_frequency
is replaced with:
  power:processor_frequency

power:machine_suspend
is newly introduced, a first implementation
comes from the ARM side, but it's easy to add these events
in X86 as well if needed.

the type= field got removed from both, it was never
used and the type is differed by the event type itself.

perf timechart
userspace tool gets adjusted in a separate patch.

Signed-off-by: Thomas Renninger <trenn@suse.de>
CC: Jean Pihet <jean.pihet@newoldbits.com>
CC: Arjan van de Ven <arjan@linux.intel.com>
CC: Peter Zijlstra <peterz@infradead.org>
CC: Ingo Molnar <mingo@elte.hu>
CC: linux-perf-users@vger.kernel.org
CC: linux-trace-users@vger.kernel.org
CC: linux-pm@lists.linux-foundation.org
CC: Kevin Hilman <khilman@deeprootsystems.com>
CC: Steven Rostedt <rostedt@goodmis.org>
CC: Frank Eigler <fche@redhat.com>
CC: Rafael Wysocki <rjw@sisk.pl>
---
 arch/x86/kernel/process.c    |    8 ++----
 arch/x86/kernel/process_64.c |    2 +-
 drivers/cpufreq/cpufreq.c    |    2 +-
 drivers/cpuidle/cpuidle.c    |    2 +-
 drivers/idle/intel_idle.c    |    6 ++--
 include/trace/events/power.h |   45 +++++++++++++++--------------------------
 kernel/trace/power-traces.c  |    3 +-
 7 files changed, 27 insertions(+), 41 deletions(-)

diff --git a/arch/x86/kernel/process.c b/arch/x86/kernel/process.c
index 57d1868..d0988a3 100644
--- a/arch/x86/kernel/process.c
+++ b/arch/x86/kernel/process.c
@@ -373,7 +373,7 @@ static inline int hlt_use_halt(void)
 void default_idle(void)
 {
 	if (hlt_use_halt()) {
-		trace_power_start(POWER_CSTATE, 1, smp_processor_id());
+		trace_processor_idle(1, smp_processor_id());
 		current_thread_info()->status &= ~TS_POLLING;
 		/*
 		 * TS_POLLING-cleared state must be visible before we
@@ -443,7 +443,7 @@ EXPORT_SYMBOL_GPL(cpu_idle_wait);
  */
 void mwait_idle_with_hints(unsigned long ax, unsigned long cx)
 {
-	trace_power_start(POWER_CSTATE, (ax>>4)+1, smp_processor_id());
+	trace_processor_idle((ax>>4)+1, smp_processor_id());
 	if (!need_resched()) {
 		if (cpu_has(&current_cpu_data, X86_FEATURE_CLFLUSH_MONITOR))
 			clflush((void *)&current_thread_info()->flags);
@@ -459,7 +459,7 @@ void mwait_idle_with_hints(unsigned long ax, unsigned long cx)
 static void mwait_idle(void)
 {
 	if (!need_resched()) {
-		trace_power_start(POWER_CSTATE, 1, smp_processor_id());
+		trace_processor_idle(1, smp_processor_id());
 		if (cpu_has(&current_cpu_data, X86_FEATURE_CLFLUSH_MONITOR))
 			clflush((void *)&current_thread_info()->flags);
 
@@ -480,11 +480,9 @@ static void mwait_idle(void)
  */
 static void poll_idle(void)
 {
-	trace_power_start(POWER_CSTATE, 0, smp_processor_id());
 	local_irq_enable();
 	while (!need_resched())
 		cpu_relax();
-	trace_power_end(0);
 }
 
 /*
diff --git a/arch/x86/kernel/process_64.c b/arch/x86/kernel/process_64.c
index 3d9ea53..b737b65 100644
--- a/arch/x86/kernel/process_64.c
+++ b/arch/x86/kernel/process_64.c
@@ -141,7 +141,7 @@ void cpu_idle(void)
 			pm_idle();
 			start_critical_timings();
 
-			trace_power_end(smp_processor_id());
+			trace_processor_idle(0, smp_processor_id());
 
 			/* In many cases the interrupt that ended idle
 			   has already called exit_idle. But some idle
diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index 199dcb9..8c0dbe6 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -354,7 +354,7 @@ void cpufreq_notify_transition(struct cpufreq_freqs *freqs, unsigned int state)
 		adjust_jiffies(CPUFREQ_POSTCHANGE, freqs);
 		dprintk("FREQ: %lu - CPU: %lu", (unsigned long)freqs->new,
 			(unsigned long)freqs->cpu);
-		trace_power_frequency(POWER_PSTATE, freqs->new, freqs->cpu);
+		trace_processor_frequency(freqs->new, freqs->cpu);
 		srcu_notifier_call_chain(&cpufreq_transition_notifier_list,
 				CPUFREQ_POSTCHANGE, freqs);
 		if (likely(policy) && likely(policy->cpu == freqs->cpu))
diff --git a/drivers/cpuidle/cpuidle.c b/drivers/cpuidle/cpuidle.c
index a507108..7ce9065 100644
--- a/drivers/cpuidle/cpuidle.c
+++ b/drivers/cpuidle/cpuidle.c
@@ -106,7 +106,7 @@ static void cpuidle_idle_call(void)
 	/* give the governor an opportunity to reflect on the outcome */
 	if (cpuidle_curr_governor->reflect)
 		cpuidle_curr_governor->reflect(dev);
-	trace_power_end(smp_processor_id());
+	trace_processor_idle(0, smp_processor_id());
 }
 
 /**
diff --git a/drivers/idle/intel_idle.c b/drivers/idle/intel_idle.c
index a10152b..24ef823 100755
--- a/drivers/idle/intel_idle.c
+++ b/drivers/idle/intel_idle.c
@@ -191,9 +191,9 @@ static int intel_idle(struct cpuidle_device *dev, struct cpuidle_state *state)
 	kt_before = ktime_get_real();
 
 	stop_critical_timings();
-#ifndef MODULE
-	trace_power_start(POWER_CSTATE, (eax >> 4) + 1, cpu);
-#endif
+
+	trace_processor_idle((eax >> 4) + 1, cpu);
+
 	if (!need_resched()) {
 
 		__monitor((void *)&current_thread_info()->flags, 0, 0);
diff --git a/include/trace/events/power.h b/include/trace/events/power.h
index 35a2a6e..217bd31 100644
--- a/include/trace/events/power.h
+++ b/include/trace/events/power.h
@@ -7,66 +7,55 @@
 #include <linux/ktime.h>
 #include <linux/tracepoint.h>
 
-#ifndef _TRACE_POWER_ENUM_
-#define _TRACE_POWER_ENUM_
-enum {
-	POWER_NONE = 0,
-	POWER_CSTATE = 1,
-	POWER_PSTATE = 2,
-};
-#endif
+DECLARE_EVENT_CLASS(processor,
 
-DECLARE_EVENT_CLASS(power,
+	TP_PROTO(unsigned int state, unsigned int cpu_id),
 
-	TP_PROTO(unsigned int type, unsigned int state, unsigned int cpu_id),
-
-	TP_ARGS(type, state, cpu_id),
+	TP_ARGS(state, cpu_id),
 
 	TP_STRUCT__entry(
-		__field(	u64,		type		)
 		__field(	u64,		state		)
 		__field(	u64,		cpu_id		)
 	),
 
 	TP_fast_assign(
-		__entry->type = type;
 		__entry->state = state;
 		__entry->cpu_id = cpu_id;
 	),
 
-	TP_printk("type=%lu state=%lu cpu_id=%lu", (unsigned long)__entry->type,
-		(unsigned long)__entry->state, (unsigned long)__entry->cpu_id)
+	TP_printk("state=%lu cpu_id=%lu", (unsigned long)__entry->state,
+		  (unsigned long)__entry->cpu_id)
 );
 
-DEFINE_EVENT(power, power_start,
+DEFINE_EVENT(processor, processor_idle,
 
-	TP_PROTO(unsigned int type, unsigned int state, unsigned int cpu_id),
+	TP_PROTO(unsigned int state, unsigned int cpu_id),
 
-	TP_ARGS(type, state, cpu_id)
+	     TP_ARGS(state, cpu_id)
 );
 
-DEFINE_EVENT(power, power_frequency,
+DEFINE_EVENT(processor, processor_frequency,
 
-	TP_PROTO(unsigned int type, unsigned int state, unsigned int cpu_id),
+	TP_PROTO(unsigned int frequency, unsigned int cpu_id),
 
-	TP_ARGS(type, state, cpu_id)
+	TP_ARGS(frequency, cpu_id)
 );
 
-TRACE_EVENT(power_end,
+TRACE_EVENT(machine_suspend,
 
-	TP_PROTO(unsigned int cpu_id),
+	TP_PROTO(unsigned int state),
 
-	TP_ARGS(cpu_id),
+	TP_ARGS(state),
 
 	TP_STRUCT__entry(
-		__field(	u64,		cpu_id		)
+		__field(	u64,		state		)
 	),
 
 	TP_fast_assign(
-		__entry->cpu_id = cpu_id;
+		__entry->state = state;
 	),
 
-	TP_printk("cpu_id=%lu", (unsigned long)__entry->cpu_id)
+	TP_printk("state=%lu", (unsigned long)__entry->state)
 
 );
 
diff --git a/kernel/trace/power-traces.c b/kernel/trace/power-traces.c
index a22582a..a5555be 100644
--- a/kernel/trace/power-traces.c
+++ b/kernel/trace/power-traces.c
@@ -13,5 +13,4 @@
 #define CREATE_TRACE_POINTS
 #include <trace/events/power.h>
 
-EXPORT_TRACEPOINT_SYMBOL_GPL(power_frequency);
-
+EXPORT_TRACEPOINT_SYMBOL_GPL(processor_idle);
-- 
1.6.3
