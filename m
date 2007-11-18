From: Ingo Molnar <mingo@elte.hu>
Subject: Re: [BUG] Strange 1-second pauses during Resume-from-RAM
Date: Sun, 18 Nov 2007 17:21:26 +0100
Message-ID: <20071118162126.GA29080__1277.13684128157$1195402982$gmane$org@elte.hu>
References: <32209efe0711122242m3a5f081asf1c11a38b24db10c@mail.gmail.com>
	<20071113031553.3c7b5c16.akpm@linux-foundation.org>
	<4739ADA2.4060604@rtr.ca>
	<alpine.LFD.0.9999.0711131521590.3265@localhost.localdomain>
	<4739E347.30406@rtr.ca> <473C7495.40805@rtr.ca>
	<47406400.5070804@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <47406400.5070804@rtr.ca>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Mark Lord <lkml@rtr.ca>
Cc: len.brown@intel.com, Andrew Morton <akpm@linux-foundation.org>, Linux Kernel <linux-kernel@vger.kernel.org>, Mark Lord <liml@rtr.ca>, Thomas Gleixner <tglx@linutronix.de>, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org


* Mark Lord <lkml@rtr.ca> wrote:

> Since Ingo's latency trace patches lock up the machine on resume, the 
> next thing I'll try instead is to re-enable CONFIG_IRQBALANCE=y.

hm, which patch did you try? Could you check whether all chunks from the 
patch below are applied? (these are the fixed i did when i was doing 
cross-suspend traces - this is not something i've done before, so the 
tracer had to be adjusted)

i suspect if you turn off CONFIG_FUNCTION_TRACING then you wont get any 
hung resume - and the resulting trace would still be pretty useful. (it 
will show scheduling and irq activities, etc.)

	Ingo

---
 arch/x86/kernel/stacktrace.c     |    2 +-
 arch/x86/power/cpu.c             |    3 ++-
 drivers/acpi/namespace/nsutils.c |    2 +-
 drivers/acpi/namespace/nswalk.c  |    2 +-
 include/linux/sched.h            |    2 ++
 kernel/latency_trace.c           |   26 +++++++++++++++++++++++---
 kernel/softirq.c                 |    6 +++---
 7 files changed, 33 insertions(+), 10 deletions(-)

Index: linux/arch/x86/kernel/stacktrace.c
===================================================================
--- linux.orig/arch/x86/kernel/stacktrace.c
+++ linux/arch/x86/kernel/stacktrace.c
@@ -22,7 +22,7 @@ static int save_stack_stack(void *data, 
 	return -1;
 }
 
-static void save_stack_address(void *data, unsigned long addr)
+static void notrace save_stack_address(void *data, unsigned long addr)
 {
 	struct stack_trace *trace = (struct stack_trace *)data;
 	if (trace->skip > 0) {
Index: linux/arch/x86/power/cpu.c
===================================================================
--- linux.orig/arch/x86/power/cpu.c
+++ linux/arch/x86/power/cpu.c
@@ -123,8 +123,9 @@ void __restore_processor_state(struct sa
 	mcheck_init(&boot_cpu_data);
 }
 
-void restore_processor_state(void)
+void notrace restore_processor_state(void)
 {
+	trace_resume();
 	__restore_processor_state(&saved_context);
 }
 
Index: linux/drivers/acpi/namespace/nsutils.c
===================================================================
--- linux.orig/drivers/acpi/namespace/nsutils.c
+++ linux/drivers/acpi/namespace/nsutils.c
@@ -923,7 +923,7 @@ struct acpi_namespace_node *acpi_ns_get_
  *
  ******************************************************************************/
 
-struct acpi_namespace_node *acpi_ns_get_next_valid_node(struct
+struct acpi_namespace_node * notrace acpi_ns_get_next_valid_node(struct
 							acpi_namespace_node
 							*node)
 {
Index: linux/drivers/acpi/namespace/nswalk.c
===================================================================
--- linux.orig/drivers/acpi/namespace/nswalk.c
+++ linux/drivers/acpi/namespace/nswalk.c
@@ -65,7 +65,7 @@ ACPI_MODULE_NAME("nswalk")
  *              within Scope is returned.
  *
  ******************************************************************************/
-struct acpi_namespace_node *acpi_ns_get_next_node(acpi_object_type type, struct acpi_namespace_node
+struct acpi_namespace_node * notrace acpi_ns_get_next_node(acpi_object_type type, struct acpi_namespace_node
 						  *parent_node, struct acpi_namespace_node
 						  *child_node)
 {
Index: linux/include/linux/sched.h
===================================================================
--- linux.orig/include/linux/sched.h
+++ linux/include/linux/sched.h
@@ -337,6 +337,7 @@ static inline void touch_all_softlockup_
   extern long user_trace_stop(void);
   extern void trace_cmdline(void);
   extern void init_tracer(void);
+  extern void trace_resume(void);
 #else
 # define mcount_enabled				0
 # define trace_enabled				0
@@ -358,6 +359,7 @@ static inline void touch_all_softlockup_
 # define user_trace_stop()			do { } while (0)
 # define trace_cmdline()			do { } while (0)
 # define init_tracer()				do { } while (0)
+# define trace_resume()				do { } while (0)
 #endif
 
 #ifdef CONFIG_WAKEUP_TIMING
Index: linux/kernel/latency_trace.c
===================================================================
--- linux.orig/kernel/latency_trace.c
+++ linux/kernel/latency_trace.c
@@ -258,19 +258,28 @@ static struct cpu_trace cpu_traces[NR_CP
 #endif
  } };
 
-static notrace cycle_t now(struct cpu_trace *tr, int monotonic)
+static inline notrace cycle_t __now(int monotonic)
 {
-	cycles_t now, delta, last = tr->last_cycles;
+	cycles_t now;
 
 	if (trace_use_raw_cycles && !monotonic)
 		now = get_cycles();
 	else
 		now = get_monotonic_cycles();
 
+	return now;
+}
+
+static notrace cycle_t now(struct cpu_trace *tr, int monotonic)
+{
+	cycles_t now, delta, last = tr->last_cycles;
+
+	now = __now(monotonic);
+
 	/*
 	 * Protect against time warps:
 	 */
-	if (unlikely(now < last))
+	if (unlikely(now < last || !last))
 		delta = 1;
 	else
 		delta = now - last;
@@ -281,6 +290,17 @@ static notrace cycle_t now(struct cpu_tr
 	return tr->cycles;
 }
 
+/*
+ * Resume callback - ignore any time spent resumed:
+ * (the clocksource readout might be unreliable anyway)
+ */
+void notrace trace_resume(void)
+{
+	struct cpu_trace *tr = cpu_traces + raw_smp_processor_id();
+
+	tr->last_cycles = 0;
+	mcount();
+}
 
 #ifdef CONFIG_EVENT_TRACE
 
Index: linux/kernel/softirq.c
===================================================================
--- linux.orig/kernel/softirq.c
+++ linux/kernel/softirq.c
@@ -91,7 +91,7 @@ static inline void __local_bh_disable(un
 }
 #endif /* CONFIG_TRACE_IRQFLAGS */
 
-void local_bh_disable(void)
+void notrace local_bh_disable(void)
 {
 	__local_bh_disable((unsigned long)__builtin_return_address(0));
 }
@@ -129,7 +129,7 @@ void _local_bh_enable(void)
 
 EXPORT_SYMBOL(_local_bh_enable);
 
-void local_bh_enable(void)
+void notrace local_bh_enable(void)
 {
 #ifdef CONFIG_TRACE_IRQFLAGS
 	unsigned long flags;
@@ -163,7 +163,7 @@ void local_bh_enable(void)
 }
 EXPORT_SYMBOL(local_bh_enable);
 
-void local_bh_enable_ip(unsigned long ip)
+void notrace local_bh_enable_ip(unsigned long ip)
 {
 #ifdef CONFIG_TRACE_IRQFLAGS
 	unsigned long flags;
