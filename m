From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [PATCH 1/4] PM / s2idle: Rename PM_SUSPEND_FREEZE to PM_SUSPEND_S2IDLE
Date: Sat, 05 Aug 2017 14:56:43 +0200
Message-ID: <3267088.f3JVtvJoiF@aspire.rjw.lan>
References: <1912685.WjJGzNPQ5e@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1912685.WjJGzNPQ5e@aspire.rjw.lan>
Sender: linux-kernel-owner@vger.kernel.org
To: Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux ACPI <linux-acpi@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>, Thomas Gleixner <tglx@linutronix.de>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Jacob Pan <jacob.jun.pan@linux.intel.com>, Len Brown <lenb@kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>
List-Id: linux-pm@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

To make it clear that the symbol in question refers to
suspend-to-idle, rename it from PM_SUSPEND_FREEZE to
PM_SUSPEND_S2IDLE.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/acpi/sleep.c             |    2 -
 drivers/regulator/of_regulator.c |    2 -
 include/linux/suspend.h          |    4 +--
 kernel/power/suspend.c           |   44 +++++++++++++++++++--------------------
 kernel/power/suspend_test.c      |    4 +--
 5 files changed, 28 insertions(+), 28 deletions(-)

Index: linux-pm/include/linux/suspend.h
===================================================================
--- linux-pm.orig/include/linux/suspend.h
+++ linux-pm/include/linux/suspend.h
@@ -33,10 +33,10 @@ static inline void pm_restore_console(vo
 typedef int __bitwise suspend_state_t;
 
 #define PM_SUSPEND_ON		((__force suspend_state_t) 0)
-#define PM_SUSPEND_FREEZE	((__force suspend_state_t) 1)
+#define PM_SUSPEND_S2IDLE	((__force suspend_state_t) 1)
 #define PM_SUSPEND_STANDBY	((__force suspend_state_t) 2)
 #define PM_SUSPEND_MEM		((__force suspend_state_t) 3)
-#define PM_SUSPEND_MIN		PM_SUSPEND_FREEZE
+#define PM_SUSPEND_MIN		PM_SUSPEND_S2IDLE
 #define PM_SUSPEND_MAX		((__force suspend_state_t) 4)
 
 enum suspend_stat_step {
Index: linux-pm/kernel/power/suspend.c
===================================================================
--- linux-pm.orig/kernel/power/suspend.c
+++ linux-pm/kernel/power/suspend.c
@@ -35,19 +35,19 @@
 #include "power.h"
 
 const char * const pm_labels[] = {
-	[PM_SUSPEND_FREEZE] = "freeze",
+	[PM_SUSPEND_S2IDLE] = "freeze",
 	[PM_SUSPEND_STANDBY] = "standby",
 	[PM_SUSPEND_MEM] = "mem",
 };
 const char *pm_states[PM_SUSPEND_MAX];
 static const char * const mem_sleep_labels[] = {
-	[PM_SUSPEND_FREEZE] = "s2idle",
+	[PM_SUSPEND_S2IDLE] = "s2idle",
 	[PM_SUSPEND_STANDBY] = "shallow",
 	[PM_SUSPEND_MEM] = "deep",
 };
 const char *mem_sleep_states[PM_SUSPEND_MAX];
 
-suspend_state_t mem_sleep_current = PM_SUSPEND_FREEZE;
+suspend_state_t mem_sleep_current = PM_SUSPEND_S2IDLE;
 suspend_state_t mem_sleep_default = PM_SUSPEND_MAX;
 suspend_state_t pm_suspend_target_state;
 EXPORT_SYMBOL_GPL(pm_suspend_target_state);
@@ -76,7 +76,7 @@ static void freeze_begin(void)
 
 static void freeze_enter(void)
 {
-	trace_suspend_resume(TPS("machine_suspend"), PM_SUSPEND_FREEZE, true);
+	trace_suspend_resume(TPS("machine_suspend"), PM_SUSPEND_S2IDLE, true);
 
 	spin_lock_irq(&suspend_freeze_lock);
 	if (pm_wakeup_pending())
@@ -103,7 +103,7 @@ static void freeze_enter(void)
 	suspend_freeze_state = FREEZE_STATE_NONE;
 	spin_unlock_irq(&suspend_freeze_lock);
 
-	trace_suspend_resume(TPS("machine_suspend"), PM_SUSPEND_FREEZE, false);
+	trace_suspend_resume(TPS("machine_suspend"), PM_SUSPEND_S2IDLE, false);
 }
 
 static void s2idle_loop(void)
@@ -175,19 +175,19 @@ void __init pm_states_init(void)
 {
 	/* "mem" and "freeze" are always present in /sys/power/state. */
 	pm_states[PM_SUSPEND_MEM] = pm_labels[PM_SUSPEND_MEM];
-	pm_states[PM_SUSPEND_FREEZE] = pm_labels[PM_SUSPEND_FREEZE];
+	pm_states[PM_SUSPEND_S2IDLE] = pm_labels[PM_SUSPEND_S2IDLE];
 	/*
 	 * Suspend-to-idle should be supported even without any suspend_ops,
 	 * initialize mem_sleep_states[] accordingly here.
 	 */
-	mem_sleep_states[PM_SUSPEND_FREEZE] = mem_sleep_labels[PM_SUSPEND_FREEZE];
+	mem_sleep_states[PM_SUSPEND_S2IDLE] = mem_sleep_labels[PM_SUSPEND_S2IDLE];
 }
 
 static int __init mem_sleep_default_setup(char *str)
 {
 	suspend_state_t state;
 
-	for (state = PM_SUSPEND_FREEZE; state <= PM_SUSPEND_MEM; state++)
+	for (state = PM_SUSPEND_S2IDLE; state <= PM_SUSPEND_MEM; state++)
 		if (mem_sleep_labels[state] &&
 		    !strcmp(str, mem_sleep_labels[state])) {
 			mem_sleep_default = state;
@@ -239,48 +239,48 @@ EXPORT_SYMBOL_GPL(suspend_valid_only_mem
 
 static bool sleep_state_supported(suspend_state_t state)
 {
-	return state == PM_SUSPEND_FREEZE || (suspend_ops && suspend_ops->enter);
+	return state == PM_SUSPEND_S2IDLE || (suspend_ops && suspend_ops->enter);
 }
 
 static int platform_suspend_prepare(suspend_state_t state)
 {
-	return state != PM_SUSPEND_FREEZE && suspend_ops->prepare ?
+	return state != PM_SUSPEND_S2IDLE && suspend_ops->prepare ?
 		suspend_ops->prepare() : 0;
 }
 
 static int platform_suspend_prepare_late(suspend_state_t state)
 {
-	return state == PM_SUSPEND_FREEZE && freeze_ops && freeze_ops->prepare ?
+	return state == PM_SUSPEND_S2IDLE && freeze_ops && freeze_ops->prepare ?
 		freeze_ops->prepare() : 0;
 }
 
 static int platform_suspend_prepare_noirq(suspend_state_t state)
 {
-	return state != PM_SUSPEND_FREEZE && suspend_ops->prepare_late ?
+	return state != PM_SUSPEND_S2IDLE && suspend_ops->prepare_late ?
 		suspend_ops->prepare_late() : 0;
 }
 
 static void platform_resume_noirq(suspend_state_t state)
 {
-	if (state != PM_SUSPEND_FREEZE && suspend_ops->wake)
+	if (state != PM_SUSPEND_S2IDLE && suspend_ops->wake)
 		suspend_ops->wake();
 }
 
 static void platform_resume_early(suspend_state_t state)
 {
-	if (state == PM_SUSPEND_FREEZE && freeze_ops && freeze_ops->restore)
+	if (state == PM_SUSPEND_S2IDLE && freeze_ops && freeze_ops->restore)
 		freeze_ops->restore();
 }
 
 static void platform_resume_finish(suspend_state_t state)
 {
-	if (state != PM_SUSPEND_FREEZE && suspend_ops->finish)
+	if (state != PM_SUSPEND_S2IDLE && suspend_ops->finish)
 		suspend_ops->finish();
 }
 
 static int platform_suspend_begin(suspend_state_t state)
 {
-	if (state == PM_SUSPEND_FREEZE && freeze_ops && freeze_ops->begin)
+	if (state == PM_SUSPEND_S2IDLE && freeze_ops && freeze_ops->begin)
 		return freeze_ops->begin();
 	else if (suspend_ops && suspend_ops->begin)
 		return suspend_ops->begin(state);
@@ -290,7 +290,7 @@ static int platform_suspend_begin(suspen
 
 static void platform_resume_end(suspend_state_t state)
 {
-	if (state == PM_SUSPEND_FREEZE && freeze_ops && freeze_ops->end)
+	if (state == PM_SUSPEND_S2IDLE && freeze_ops && freeze_ops->end)
 		freeze_ops->end();
 	else if (suspend_ops && suspend_ops->end)
 		suspend_ops->end();
@@ -298,13 +298,13 @@ static void platform_resume_end(suspend_
 
 static void platform_recover(suspend_state_t state)
 {
-	if (state != PM_SUSPEND_FREEZE && suspend_ops->recover)
+	if (state != PM_SUSPEND_S2IDLE && suspend_ops->recover)
 		suspend_ops->recover();
 }
 
 static bool platform_suspend_again(suspend_state_t state)
 {
-	return state != PM_SUSPEND_FREEZE && suspend_ops->suspend_again ?
+	return state != PM_SUSPEND_S2IDLE && suspend_ops->suspend_again ?
 		suspend_ops->suspend_again() : false;
 }
 
@@ -400,7 +400,7 @@ static int suspend_enter(suspend_state_t
 	if (error)
 		goto Devices_early_resume;
 
-	if (state == PM_SUSPEND_FREEZE && pm_test_level != TEST_PLATFORM) {
+	if (state == PM_SUSPEND_S2IDLE && pm_test_level != TEST_PLATFORM) {
 		s2idle_loop();
 		goto Platform_early_resume;
 	}
@@ -538,7 +538,7 @@ static int enter_state(suspend_state_t s
 	int error;
 
 	trace_suspend_resume(TPS("suspend_enter"), state, true);
-	if (state == PM_SUSPEND_FREEZE) {
+	if (state == PM_SUSPEND_S2IDLE) {
 #ifdef CONFIG_PM_DEBUG
 		if (pm_test_level != TEST_NONE && pm_test_level <= TEST_CPUS) {
 			pr_warn("Unsupported test mode for suspend to idle, please choose none/freezer/devices/platform.\n");
@@ -551,7 +551,7 @@ static int enter_state(suspend_state_t s
 	if (!mutex_trylock(&pm_mutex))
 		return -EBUSY;
 
-	if (state == PM_SUSPEND_FREEZE)
+	if (state == PM_SUSPEND_S2IDLE)
 		freeze_begin();
 
 #ifndef CONFIG_SUSPEND_SKIP_SYNC
Index: linux-pm/kernel/power/suspend_test.c
===================================================================
--- linux-pm.orig/kernel/power/suspend_test.c
+++ linux-pm/kernel/power/suspend_test.c
@@ -104,9 +104,9 @@ repeat:
 		printk(info_test, pm_states[state]);
 		status = pm_suspend(state);
 		if (status < 0)
-			state = PM_SUSPEND_FREEZE;
+			state = PM_SUSPEND_S2IDLE;
 	}
-	if (state == PM_SUSPEND_FREEZE) {
+	if (state == PM_SUSPEND_S2IDLE) {
 		printk(info_test, pm_states[state]);
 		status = pm_suspend(state);
 	}
Index: linux-pm/drivers/regulator/of_regulator.c
===================================================================
--- linux-pm.orig/drivers/regulator/of_regulator.c
+++ linux-pm/drivers/regulator/of_regulator.c
@@ -150,7 +150,7 @@ static void of_get_regulation_constraint
 			suspend_state = &constraints->state_disk;
 			break;
 		case PM_SUSPEND_ON:
-		case PM_SUSPEND_FREEZE:
+		case PM_SUSPEND_S2IDLE:
 		case PM_SUSPEND_STANDBY:
 		default:
 			continue;
Index: linux-pm/drivers/acpi/sleep.c
===================================================================
--- linux-pm.orig/drivers/acpi/sleep.c
+++ linux-pm/drivers/acpi/sleep.c
@@ -719,7 +719,7 @@ static int lps0_device_attach(struct acp
 			 * suspend mode was not set from the command line.
 			 */
 			if (mem_sleep_default > PM_SUSPEND_MEM)
-				mem_sleep_current = PM_SUSPEND_FREEZE;
+				mem_sleep_current = PM_SUSPEND_S2IDLE;
 		}
 
 		acpi_handle_debug(adev->handle, "_DSM function mask: 0x%x\n",
