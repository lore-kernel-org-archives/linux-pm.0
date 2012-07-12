From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: [PATCH 2/5] acpi : remove index from acpi_processor_cx
	structure
Date: Thu, 12 Jul 2012 17:30:00 +0200
Message-ID: <1342107003-9811-2-git-send-email-daniel.lezcano@linaro.org>
References: <1342107003-9811-1-git-send-email-daniel.lezcano@linaro.org>
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1342107003-9811-1-git-send-email-daniel.lezcano@linaro.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/linux-pm/>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: rjw@sisk.pl
Cc: linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

Remove the index field. It could be given without adding extra
information in the cx structure.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 arch/x86/kernel/acpi/cstate.c |   18 +++++++++---------
 drivers/acpi/processor_idle.c |   15 +++++++--------
 include/acpi/processor.h      |   11 +++++------
 3 files changed, 21 insertions(+), 23 deletions(-)

diff --git a/arch/x86/kernel/acpi/cstate.c b/arch/x86/kernel/acpi/cstate.c
index d2b7f27..faa7f50 100644
--- a/arch/x86/kernel/acpi/cstate.c
+++ b/arch/x86/kernel/acpi/cstate.c
@@ -112,8 +112,8 @@ out:
 	return retval;
 }
 
-int acpi_processor_ffh_cstate_probe(unsigned int cpu,
-		struct acpi_processor_cx *cx, struct acpi_power_register *reg)
+int acpi_processor_ffh_cstate_probe(unsigned int cpu, struct acpi_processor_cx *cx,
+				    int index, struct acpi_power_register *reg)
 {
 	struct cstate_entry *percpu_entry;
 	struct cpuinfo_x86 *c = &cpu_data(cpu);
@@ -126,16 +126,16 @@ int acpi_processor_ffh_cstate_probe(unsigned int cpu,
 		return -1;
 
 	percpu_entry = per_cpu_ptr(cpu_cstate_entry, cpu);
-	percpu_entry->states[cx->index].eax = 0;
-	percpu_entry->states[cx->index].ecx = 0;
+	percpu_entry->states[index].eax = 0;
+	percpu_entry->states[index].ecx = 0;
 
 	/* Make sure we are running on right CPU */
 
 	retval = work_on_cpu(cpu, acpi_processor_ffh_cstate_probe_cpu, cx);
 	if (retval == 0) {
 		/* Use the hint in CST */
-		percpu_entry->states[cx->index].eax = cx->address;
-		percpu_entry->states[cx->index].ecx = MWAIT_ECX_INTERRUPT_BREAK;
+		percpu_entry->states[index].eax = cx->address;
+		percpu_entry->states[index].ecx = MWAIT_ECX_INTERRUPT_BREAK;
 	}
 
 	/*
@@ -173,14 +173,14 @@ void mwait_idle_with_hints(unsigned long ax, unsigned long cx)
 	}
 }
 
-void acpi_processor_ffh_cstate_enter(struct acpi_processor_cx *cx)
+void acpi_processor_ffh_cstate_enter(int index)
 {
 	unsigned int cpu = smp_processor_id();
 	struct cstate_entry *percpu_entry;
 
 	percpu_entry = per_cpu_ptr(cpu_cstate_entry, cpu);
-	mwait_idle_with_hints(percpu_entry->states[cx->index].eax,
-	                      percpu_entry->states[cx->index].ecx);
+	mwait_idle_with_hints(percpu_entry->states[index].eax,
+	                      percpu_entry->states[index].ecx);
 }
 EXPORT_SYMBOL_GPL(acpi_processor_ffh_cstate_enter);
 
diff --git a/drivers/acpi/processor_idle.c b/drivers/acpi/processor_idle.c
index 9ef007d..0922143 100644
--- a/drivers/acpi/processor_idle.c
+++ b/drivers/acpi/processor_idle.c
@@ -430,12 +430,11 @@ static int acpi_processor_get_power_info_cst(struct acpi_processor *pr)
 			current_count++;
 
 		cx.address = reg->address;
-		cx.index = current_count + 1;
 
 		cx.entry_method = ACPI_CSTATE_SYSTEMIO;
 		if (reg->space_id == ACPI_ADR_SPACE_FIXED_HARDWARE) {
-			if (acpi_processor_ffh_cstate_probe
-					(pr->id, &cx, reg) == 0) {
+			if (acpi_processor_ffh_cstate_probe(
+				    pr->id, &cx, current_count + 1, reg) == 0) {
 				cx.entry_method = ACPI_CSTATE_FFH;
 			} else if (cx.type == ACPI_STATE_C1) {
 				/*
@@ -704,13 +703,13 @@ static int acpi_idle_bm_check(void)
  *
  * Caller disables interrupt before call and enables interrupt after return.
  */
-static inline void acpi_idle_do_entry(struct acpi_processor_cx *cx)
+static inline void acpi_idle_do_entry(struct acpi_processor_cx *cx, int index)
 {
 	/* Don't trace irqs off for idle */
 	stop_critical_timings();
 	if (cx->entry_method == ACPI_CSTATE_FFH) {
 		/* Call into architectural FFH based C-state */
-		acpi_processor_ffh_cstate_enter(cx);
+		acpi_processor_ffh_cstate_enter(index);
 	} else if (cx->entry_method == ACPI_CSTATE_HALT) {
 		acpi_safe_halt();
 	} else {
@@ -752,7 +751,7 @@ static int acpi_idle_enter_c1(struct cpuidle_device *dev,
 
 	lapic_timer_state_broadcast(pr, cx, 1);
 	kt1 = ktime_get_real();
-	acpi_idle_do_entry(cx);
+	acpi_idle_do_entry(cx, index);
 	kt2 = ktime_get_real();
 	idle_time =  ktime_to_us(ktime_sub(kt2, kt1));
 
@@ -847,7 +846,7 @@ static int acpi_idle_enter_simple(struct cpuidle_device *dev,
 	kt1 = ktime_get_real();
 	/* Tell the scheduler that we are going deep-idle: */
 	sched_clock_idle_sleep_event();
-	acpi_idle_do_entry(cx);
+	acpi_idle_do_entry(cx, index);
 	kt2 = ktime_get_real();
 	idle_time_ns = ktime_to_ns(ktime_sub(kt2, kt1));
 	idle_time = idle_time_ns;
@@ -960,7 +959,7 @@ static int acpi_idle_enter_bm(struct cpuidle_device *dev,
 		ACPI_FLUSH_CPU_CACHE();
 	}
 
-	acpi_idle_do_entry(cx);
+	acpi_idle_do_entry(cx, index);
 
 	/* Re-enable bus master arbitration */
 	if (pr->flags.bm_check && pr->flags.bm_control) {
diff --git a/include/acpi/processor.h b/include/acpi/processor.h
index 19423c3..d2016a1 100644
--- a/include/acpi/processor.h
+++ b/include/acpi/processor.h
@@ -57,7 +57,6 @@ struct acpi_processor_cx {
 	u8 type;
 	u32 address;
 	u8 entry_method;
-	u8 index;
 	u32 latency;
 	u32 power;
 	u32 usage;
@@ -249,8 +248,9 @@ void acpi_processor_power_init_bm_check(struct acpi_processor_flags *flags,
 					unsigned int cpu);
 int acpi_processor_ffh_cstate_probe(unsigned int cpu,
 				    struct acpi_processor_cx *cx,
+				    int index,
 				    struct acpi_power_register *reg);
-void acpi_processor_ffh_cstate_enter(struct acpi_processor_cx *cstate);
+void acpi_processor_ffh_cstate_enter(int index);
 #else
 static inline void acpi_processor_power_init_bm_check(struct
 						      acpi_processor_flags
@@ -261,13 +261,12 @@ static inline void acpi_processor_power_init_bm_check(struct
 }
 static inline int acpi_processor_ffh_cstate_probe(unsigned int cpu,
 						  struct acpi_processor_cx *cx,
-						  struct acpi_power_register
-						  *reg)
+						  int index,
+						  struct acpi_power_register *reg)
 {
 	return -1;
 }
-static inline void acpi_processor_ffh_cstate_enter(struct acpi_processor_cx
-						   *cstate)
+static inline void acpi_processor_ffh_cstate_enter(int index)
 {
 	return;
 }
-- 
1.7.5.4
