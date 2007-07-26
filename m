From: Adam Belay <abelay@novell.com>
Subject: [PATCH] CPUIDLE - A Framework for Idle CPU PM
Date: Thu, 26 Jul 2007 01:43:56 -0400
Message-ID: <1185428636.4013.75.camel@callisto.site>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

Hi All,

Cpuidle is a generic framework for idle processor power management that
Venki Pallipadi, Shaohua Li, and I developed collaboratively.  It is a
layered architecture that separates platform-specific processor power
drivers from higher level policy governors.  In this sense, it is
analogous to cpufreq.  However, it manages nonoperative idle states
rather than frequency and voltage operating points.

I've attached the most recent version of cpuidle as a stand alone patch
against 2.6.22.  This new code is much lighter weight than the initial
release.  It includes the core cpuidle infrastructure, an ACPI processor
driver, and some modifications to the tick implementation to help better
predict the time remaining until the next break event.  I look forward
to any questions, comments, or suggestions.

Cheers,
Adam

Summary of changes:
 arch/i386/Kconfig                  |    2
 arch/x86_64/Kconfig                |    2
 drivers/Makefile                   |    1
 drivers/acpi/processor_core.c      |   22
 drivers/acpi/processor_idle.c      |  923 ++++++++++++++-----------------------
 drivers/cpuidle/Kconfig            |   39 +
 drivers/cpuidle/Makefile           |    5
 drivers/cpuidle/cpuidle.c          |  297 +++++++++++
 drivers/cpuidle/cpuidle.h          |   33 +
 drivers/cpuidle/driver.c           |   69 ++
 drivers/cpuidle/governor.c         |  141 +++++
 drivers/cpuidle/governors/Makefile |    6
 drivers/cpuidle/governors/ladder.c |  210 ++++++++
 drivers/cpuidle/governors/menu.c   |  147 +++++
 drivers/cpuidle/sysfs.c            |  364 ++++++++++++++
 include/acpi/processor.h           |    4
 include/linux/cpuidle.h            |  184 +++++++
 include/linux/tick.h               |    9
 kernel/time/tick-sched.c           |   16
 19 files changed, 1912 insertions(+), 562 deletions(-)
---

diff -urN linux-2.6.22/arch/i386/Kconfig linux-cpuidle/arch/i386/Kconfig
--- linux-2.6.22/arch/i386/Kconfig	2007-07-19 20:05:59.000000000 -0400
+++ linux-cpuidle/arch/i386/Kconfig	2007-07-17 04:19:17.000000000 -0400
@@ -1053,6 +1053,8 @@
 
 source "arch/i386/kernel/cpu/cpufreq/Kconfig"
 
+source "drivers/cpuidle/Kconfig"
+
 endmenu
 
 menu "Bus options (PCI, PCMCIA, EISA, MCA, ISA)"
diff -urN linux-2.6.22/arch/x86_64/Kconfig linux-cpuidle/arch/x86_64/Kconfig
--- linux-2.6.22/arch/x86_64/Kconfig	2007-07-19 20:05:59.000000000 -0400
+++ linux-cpuidle/arch/x86_64/Kconfig	2007-07-17 04:19:17.000000000 -0400
@@ -698,6 +698,8 @@
 
 source "arch/x86_64/kernel/cpufreq/Kconfig"
 
+source "drivers/cpuidle/Kconfig"
+
 endmenu
 
 menu "Bus options (PCI etc.)"
diff -urN linux-2.6.22/drivers/acpi/processor_core.c linux-cpuidle/drivers/acpi/processor_core.c
--- linux-2.6.22/drivers/acpi/processor_core.c	2007-07-19 20:05:59.000000000 -0400
+++ linux-cpuidle/drivers/acpi/processor_core.c	2007-07-17 04:19:22.000000000 -0400
@@ -44,6 +44,7 @@
 #include <linux/seq_file.h>
 #include <linux/dmi.h>
 #include <linux/moduleparam.h>
+#include <linux/cpuidle.h>
 
 #include <asm/io.h>
 #include <asm/system.h>
@@ -1010,11 +1011,13 @@
 		return -ENOMEM;
 	acpi_processor_dir->owner = THIS_MODULE;
 
+	result = cpuidle_register_driver(&acpi_idle_driver);
+	if (result < 0)
+		goto out_proc;
+
 	result = acpi_bus_register_driver(&acpi_processor_driver);
-	if (result < 0) {
-		remove_proc_entry(ACPI_PROCESSOR_CLASS, acpi_root_dir);
-		return result;
-	}
+	if (result < 0)
+		goto out_cpuidle;
 
 	acpi_processor_install_hotplug_notify();
 
@@ -1023,11 +1026,18 @@
 	acpi_processor_ppc_init();
 
 	return 0;
+
+out_cpuidle:
+	cpuidle_unregister_driver(&acpi_idle_driver);
+
+out_proc:
+	remove_proc_entry(ACPI_PROCESSOR_CLASS, acpi_root_dir);
+
+	return result;
 }
 
 static void __exit acpi_processor_exit(void)
 {
-
 	acpi_processor_ppc_exit();
 
 	acpi_thermal_cpufreq_exit();
@@ -1036,6 +1046,8 @@
 
 	acpi_bus_unregister_driver(&acpi_processor_driver);
 
+	cpuidle_unregister_driver(&acpi_idle_driver);
+
 	remove_proc_entry(ACPI_PROCESSOR_CLASS, acpi_root_dir);
 
 	return;
diff -urN linux-2.6.22/drivers/acpi/processor_idle.c linux-cpuidle/drivers/acpi/processor_idle.c
--- linux-2.6.22/drivers/acpi/processor_idle.c	2007-07-19 20:05:59.000000000 -0400
+++ linux-cpuidle/drivers/acpi/processor_idle.c	2007-07-17 04:19:22.000000000 -0400
@@ -40,6 +40,7 @@
 #include <linux/sched.h>	/* need_resched() */
 #include <linux/latency.h>
 #include <linux/clockchips.h>
+#include <linux/cpuidle.h>
 
 /*
  * Include the apic definitions for x86 to have the APIC timer related defines
@@ -62,30 +63,15 @@
 #define _COMPONENT              ACPI_PROCESSOR_COMPONENT
 ACPI_MODULE_NAME("processor_idle");
 #define ACPI_PROCESSOR_FILE_POWER	"power"
-#define US_TO_PM_TIMER_TICKS(t)		((t * (PM_TIMER_FREQUENCY/1000)) / 1000)
-#define C2_OVERHEAD			4	/* 1us (3.579 ticks per us) */
-#define C3_OVERHEAD			4	/* 1us (3.579 ticks per us) */
-static void (*pm_idle_save) (void) __read_mostly;
-module_param(max_cstate, uint, 0644);
+#define PM_TIMER_TICKS_TO_US(p)		(((p) * 1000)/(PM_TIMER_FREQUENCY/1000))
+#define C2_OVERHEAD			1	/* 1us */
+#define C3_OVERHEAD			1	/* 1us */
 
+module_param(max_cstate, uint, 0644);
 static unsigned int nocst __read_mostly;
 module_param(nocst, uint, 0000);
 
 /*
- * bm_history -- bit-mask with a bit per jiffy of bus-master activity
- * 1000 HZ: 0xFFFFFFFF: 32 jiffies = 32ms
- * 800 HZ: 0xFFFFFFFF: 32 jiffies = 40ms
- * 100 HZ: 0x0000000F: 4 jiffies = 40ms
- * reduce history for more aggressive entry into C3
- */
-static unsigned int bm_history __read_mostly =
-    (HZ >= 800 ? 0xFFFFFFFF : ((1U << (HZ / 25)) - 1));
-module_param(bm_history, uint, 0644);
-/* --------------------------------------------------------------------------
-                                Power Management
-   -------------------------------------------------------------------------- */
-
-/*
  * IBM ThinkPad R40e crashes mysteriously when going into C2 or C3.
  * For now disable this. Probably a bug somewhere else.
  *
@@ -166,88 +152,6 @@
 	{},
 };
 
-static inline u32 ticks_elapsed(u32 t1, u32 t2)
-{
-	if (t2 >= t1)
-		return (t2 - t1);
-	else if (!(acpi_gbl_FADT.flags & ACPI_FADT_32BIT_TIMER))
-		return (((0x00FFFFFF - t1) + t2) & 0x00FFFFFF);
-	else
-		return ((0xFFFFFFFF - t1) + t2);
-}
-
-static void
-acpi_processor_power_activate(struct acpi_processor *pr,
-			      struct acpi_processor_cx *new)
-{
-	struct acpi_processor_cx *old;
-
-	if (!pr || !new)
-		return;
-
-	old = pr->power.state;
-
-	if (old)
-		old->promotion.count = 0;
-	new->demotion.count = 0;
-
-	/* Cleanup from old state. */
-	if (old) {
-		switch (old->type) {
-		case ACPI_STATE_C3:
-			/* Disable bus master reload */
-			if (new->type != ACPI_STATE_C3 && pr->flags.bm_check)
-				acpi_set_register(ACPI_BITREG_BUS_MASTER_RLD, 0);
-			break;
-		}
-	}
-
-	/* Prepare to use new state. */
-	switch (new->type) {
-	case ACPI_STATE_C3:
-		/* Enable bus master reload */
-		if (old->type != ACPI_STATE_C3 && pr->flags.bm_check)
-			acpi_set_register(ACPI_BITREG_BUS_MASTER_RLD, 1);
-		break;
-	}
-
-	pr->power.state = new;
-
-	return;
-}
-
-static void acpi_safe_halt(void)
-{
-	current_thread_info()->status &= ~TS_POLLING;
-	/*
-	 * TS_POLLING-cleared state must be visible before we
-	 * test NEED_RESCHED:
-	 */
-	smp_mb();
-	if (!need_resched())
-		safe_halt();
-	current_thread_info()->status |= TS_POLLING;
-}
-
-static atomic_t c3_cpu_count;
-
-/* Common C-state entry for C2, C3, .. */
-static void acpi_cstate_enter(struct acpi_processor_cx *cstate)
-{
-	if (cstate->space_id == ACPI_CSTATE_FFH) {
-		/* Call into architectural FFH based C-state */
-		acpi_processor_ffh_cstate_enter(cstate);
-	} else {
-		int unused;
-		/* IO port based C-state */
-		inb(cstate->address);
-		/* Dummy wait op - must do something useless after P_LVL2 read
-		   because chipsets cannot guarantee that STPCLK# signal
-		   gets asserted in time to freeze execution properly. */
-		unused = inl(acpi_gbl_FADT.xpm_timer_block.address);
-	}
-}
-
 #ifdef ARCH_APICTIMER_STOPS_ON_C3
 
 /*
@@ -324,377 +228,6 @@
 
 #endif
 
-static void acpi_processor_idle(void)
-{
-	struct acpi_processor *pr = NULL;
-	struct acpi_processor_cx *cx = NULL;
-	struct acpi_processor_cx *next_state = NULL;
-	int sleep_ticks = 0;
-	u32 t1, t2 = 0;
-
-	/*
-	 * Interrupts must be disabled during bus mastering calculations and
-	 * for C2/C3 transitions.
-	 */
-	local_irq_disable();
-
-	pr = processors[smp_processor_id()];
-	if (!pr) {
-		local_irq_enable();
-		return;
-	}
-
-	/*
-	 * Check whether we truly need to go idle, or should
-	 * reschedule:
-	 */
-	if (unlikely(need_resched())) {
-		local_irq_enable();
-		return;
-	}
-
-	cx = pr->power.state;
-	if (!cx) {
-		if (pm_idle_save)
-			pm_idle_save();
-		else
-			acpi_safe_halt();
-		return;
-	}
-
-	/*
-	 * Check BM Activity
-	 * -----------------
-	 * Check for bus mastering activity (if required), record, and check
-	 * for demotion.
-	 */
-	if (pr->flags.bm_check) {
-		u32 bm_status = 0;
-		unsigned long diff = jiffies - pr->power.bm_check_timestamp;
-
-		if (diff > 31)
-			diff = 31;
-
-		pr->power.bm_activity <<= diff;
-
-		acpi_get_register(ACPI_BITREG_BUS_MASTER_STATUS, &bm_status);
-		if (bm_status) {
-			pr->power.bm_activity |= 0x1;
-			acpi_set_register(ACPI_BITREG_BUS_MASTER_STATUS, 1);
-		}
-		/*
-		 * PIIX4 Erratum #18: Note that BM_STS doesn't always reflect
-		 * the true state of bus mastering activity; forcing us to
-		 * manually check the BMIDEA bit of each IDE channel.
-		 */
-		else if (errata.piix4.bmisx) {
-			if ((inb_p(errata.piix4.bmisx + 0x02) & 0x01)
-			    || (inb_p(errata.piix4.bmisx + 0x0A) & 0x01))
-				pr->power.bm_activity |= 0x1;
-		}
-
-		pr->power.bm_check_timestamp = jiffies;
-
-		/*
-		 * If bus mastering is or was active this jiffy, demote
-		 * to avoid a faulty transition.  Note that the processor
-		 * won't enter a low-power state during this call (to this
-		 * function) but should upon the next.
-		 *
-		 * TBD: A better policy might be to fallback to the demotion
-		 *      state (use it for this quantum only) istead of
-		 *      demoting -- and rely on duration as our sole demotion
-		 *      qualification.  This may, however, introduce DMA
-		 *      issues (e.g. floppy DMA transfer overrun/underrun).
-		 */
-		if ((pr->power.bm_activity & 0x1) &&
-		    cx->demotion.threshold.bm) {
-			local_irq_enable();
-			next_state = cx->demotion.state;
-			goto end;
-		}
-	}
-
-#ifdef CONFIG_HOTPLUG_CPU
-	/*
-	 * Check for P_LVL2_UP flag before entering C2 and above on
-	 * an SMP system. We do it here instead of doing it at _CST/P_LVL
-	 * detection phase, to work cleanly with logical CPU hotplug.
-	 */
-	if ((cx->type != ACPI_STATE_C1) && (num_online_cpus() > 1) && 
-	    !pr->flags.has_cst && !(acpi_gbl_FADT.flags & ACPI_FADT_C2_MP_SUPPORTED))
-		cx = &pr->power.states[ACPI_STATE_C1];
-#endif
-
-	/*
-	 * Sleep:
-	 * ------
-	 * Invoke the current Cx state to put the processor to sleep.
-	 */
-	if (cx->type == ACPI_STATE_C2 || cx->type == ACPI_STATE_C3) {
-		current_thread_info()->status &= ~TS_POLLING;
-		/*
-		 * TS_POLLING-cleared state must be visible before we
-		 * test NEED_RESCHED:
-		 */
-		smp_mb();
-		if (need_resched()) {
-			current_thread_info()->status |= TS_POLLING;
-			local_irq_enable();
-			return;
-		}
-	}
-
-	switch (cx->type) {
-
-	case ACPI_STATE_C1:
-		/*
-		 * Invoke C1.
-		 * Use the appropriate idle routine, the one that would
-		 * be used without acpi C-states.
-		 */
-		if (pm_idle_save)
-			pm_idle_save();
-		else
-			acpi_safe_halt();
-
-		/*
-		 * TBD: Can't get time duration while in C1, as resumes
-		 *      go to an ISR rather than here.  Need to instrument
-		 *      base interrupt handler.
-		 */
-		sleep_ticks = 0xFFFFFFFF;
-		break;
-
-	case ACPI_STATE_C2:
-		/* Get start time (ticks) */
-		t1 = inl(acpi_gbl_FADT.xpm_timer_block.address);
-		/* Invoke C2 */
-		acpi_state_timer_broadcast(pr, cx, 1);
-		acpi_cstate_enter(cx);
-		/* Get end time (ticks) */
-		t2 = inl(acpi_gbl_FADT.xpm_timer_block.address);
-
-#ifdef CONFIG_GENERIC_TIME
-		/* TSC halts in C2, so notify users */
-		mark_tsc_unstable("possible TSC halt in C2");
-#endif
-		/* Re-enable interrupts */
-		local_irq_enable();
-		current_thread_info()->status |= TS_POLLING;
-		/* Compute time (ticks) that we were actually asleep */
-		sleep_ticks =
-		    ticks_elapsed(t1, t2) - cx->latency_ticks - C2_OVERHEAD;
-		acpi_state_timer_broadcast(pr, cx, 0);
-		break;
-
-	case ACPI_STATE_C3:
-
-		if (pr->flags.bm_check) {
-			if (atomic_inc_return(&c3_cpu_count) ==
-			    num_online_cpus()) {
-				/*
-				 * All CPUs are trying to go to C3
-				 * Disable bus master arbitration
-				 */
-				acpi_set_register(ACPI_BITREG_ARB_DISABLE, 1);
-			}
-		} else {
-			/* SMP with no shared cache... Invalidate cache  */
-			ACPI_FLUSH_CPU_CACHE();
-		}
-
-		/* Get start time (ticks) */
-		t1 = inl(acpi_gbl_FADT.xpm_timer_block.address);
-		/* Invoke C3 */
-		acpi_state_timer_broadcast(pr, cx, 1);
-		acpi_cstate_enter(cx);
-		/* Get end time (ticks) */
-		t2 = inl(acpi_gbl_FADT.xpm_timer_block.address);
-		if (pr->flags.bm_check) {
-			/* Enable bus master arbitration */
-			atomic_dec(&c3_cpu_count);
-			acpi_set_register(ACPI_BITREG_ARB_DISABLE, 0);
-		}
-
-#ifdef CONFIG_GENERIC_TIME
-		/* TSC halts in C3, so notify users */
-		mark_tsc_unstable("TSC halts in C3");
-#endif
-		/* Re-enable interrupts */
-		local_irq_enable();
-		current_thread_info()->status |= TS_POLLING;
-		/* Compute time (ticks) that we were actually asleep */
-		sleep_ticks =
-		    ticks_elapsed(t1, t2) - cx->latency_ticks - C3_OVERHEAD;
-		acpi_state_timer_broadcast(pr, cx, 0);
-		break;
-
-	default:
-		local_irq_enable();
-		return;
-	}
-	cx->usage++;
-	if ((cx->type != ACPI_STATE_C1) && (sleep_ticks > 0))
-		cx->time += sleep_ticks;
-
-	next_state = pr->power.state;
-
-#ifdef CONFIG_HOTPLUG_CPU
-	/* Don't do promotion/demotion */
-	if ((cx->type == ACPI_STATE_C1) && (num_online_cpus() > 1) &&
-	    !pr->flags.has_cst && !(acpi_gbl_FADT.flags & ACPI_FADT_C2_MP_SUPPORTED)) {
-		next_state = cx;
-		goto end;
-	}
-#endif
-
-	/*
-	 * Promotion?
-	 * ----------
-	 * Track the number of longs (time asleep is greater than threshold)
-	 * and promote when the count threshold is reached.  Note that bus
-	 * mastering activity may prevent promotions.
-	 * Do not promote above max_cstate.
-	 */
-	if (cx->promotion.state &&
-	    ((cx->promotion.state - pr->power.states) <= max_cstate)) {
-		if (sleep_ticks > cx->promotion.threshold.ticks &&
-		  cx->promotion.state->latency <= system_latency_constraint()) {
-			cx->promotion.count++;
-			cx->demotion.count = 0;
-			if (cx->promotion.count >=
-			    cx->promotion.threshold.count) {
-				if (pr->flags.bm_check) {
-					if (!
-					    (pr->power.bm_activity & cx->
-					     promotion.threshold.bm)) {
-						next_state =
-						    cx->promotion.state;
-						goto end;
-					}
-				} else {
-					next_state = cx->promotion.state;
-					goto end;
-				}
-			}
-		}
-	}
-
-	/*
-	 * Demotion?
-	 * ---------
-	 * Track the number of shorts (time asleep is less than time threshold)
-	 * and demote when the usage threshold is reached.
-	 */
-	if (cx->demotion.state) {
-		if (sleep_ticks < cx->demotion.threshold.ticks) {
-			cx->demotion.count++;
-			cx->promotion.count = 0;
-			if (cx->demotion.count >= cx->demotion.threshold.count) {
-				next_state = cx->demotion.state;
-				goto end;
-			}
-		}
-	}
-
-      end:
-	/*
-	 * Demote if current state exceeds max_cstate
-	 * or if the latency of the current state is unacceptable
-	 */
-	if ((pr->power.state - pr->power.states) > max_cstate ||
-		pr->power.state->latency > system_latency_constraint()) {
-		if (cx->demotion.state)
-			next_state = cx->demotion.state;
-	}
-
-	/*
-	 * New Cx State?
-	 * -------------
-	 * If we're going to start using a new Cx state we must clean up
-	 * from the previous and prepare to use the new.
-	 */
-	if (next_state != pr->power.state)
-		acpi_processor_power_activate(pr, next_state);
-}
-
-static int acpi_processor_set_power_policy(struct acpi_processor *pr)
-{
-	unsigned int i;
-	unsigned int state_is_set = 0;
-	struct acpi_processor_cx *lower = NULL;
-	struct acpi_processor_cx *higher = NULL;
-	struct acpi_processor_cx *cx;
-
-
-	if (!pr)
-		return -EINVAL;
-
-	/*
-	 * This function sets the default Cx state policy (OS idle handler).
-	 * Our scheme is to promote quickly to C2 but more conservatively
-	 * to C3.  We're favoring C2  for its characteristics of low latency
-	 * (quick response), good power savings, and ability to allow bus
-	 * mastering activity.  Note that the Cx state policy is completely
-	 * customizable and can be altered dynamically.
-	 */
-
-	/* startup state */
-	for (i = 1; i < ACPI_PROCESSOR_MAX_POWER; i++) {
-		cx = &pr->power.states[i];
-		if (!cx->valid)
-			continue;
-
-		if (!state_is_set)
-			pr->power.state = cx;
-		state_is_set++;
-		break;
-	}
-
-	if (!state_is_set)
-		return -ENODEV;
-
-	/* demotion */
-	for (i = 1; i < ACPI_PROCESSOR_MAX_POWER; i++) {
-		cx = &pr->power.states[i];
-		if (!cx->valid)
-			continue;
-
-		if (lower) {
-			cx->demotion.state = lower;
-			cx->demotion.threshold.ticks = cx->latency_ticks;
-			cx->demotion.threshold.count = 1;
-			if (cx->type == ACPI_STATE_C3)
-				cx->demotion.threshold.bm = bm_history;
-		}
-
-		lower = cx;
-	}
-
-	/* promotion */
-	for (i = (ACPI_PROCESSOR_MAX_POWER - 1); i > 0; i--) {
-		cx = &pr->power.states[i];
-		if (!cx->valid)
-			continue;
-
-		if (higher) {
-			cx->promotion.state = higher;
-			cx->promotion.threshold.ticks = cx->latency_ticks;
-			if (cx->type >= ACPI_STATE_C2)
-				cx->promotion.threshold.count = 4;
-			else
-				cx->promotion.threshold.count = 10;
-			if (higher->type == ACPI_STATE_C3)
-				cx->promotion.threshold.bm = bm_history;
-		}
-
-		higher = cx;
-	}
-
-	return 0;
-}
-
 static int acpi_processor_get_power_info_fadt(struct acpi_processor *pr)
 {
 
@@ -711,7 +244,7 @@
 #ifndef CONFIG_HOTPLUG_CPU
 	/*
 	 * Check for P_LVL2_UP flag before entering C2 and above on
-	 * an SMP system. 
+	 * an SMP system.
 	 */
 	if ((num_online_cpus() > 1) &&
 	    !(acpi_gbl_FADT.flags & ACPI_FADT_C2_MP_SUPPORTED))
@@ -912,7 +445,7 @@
 	 * Normalize the C2 latency to expidite policy
 	 */
 	cx->valid = 1;
-	cx->latency_ticks = US_TO_PM_TIMER_TICKS(cx->latency);
+	cx->latency_ticks = cx->latency;
 
 	return;
 }
@@ -986,7 +519,7 @@
 	 * use this in our C3 policy
 	 */
 	cx->valid = 1;
-	cx->latency_ticks = US_TO_PM_TIMER_TICKS(cx->latency);
+	cx->latency_ticks = cx->latency;
 
 	return;
 }
@@ -1052,18 +585,6 @@
 	pr->power.count = acpi_processor_power_verify(pr);
 
 	/*
-	 * Set Default Policy
-	 * ------------------
-	 * Now that we know which states are supported, set the default
-	 * policy.  Note that this policy can be changed dynamically
-	 * (e.g. encourage deeper sleeps to conserve battery life when
-	 * not on AC).
-	 */
-	result = acpi_processor_set_power_policy(pr);
-	if (result)
-		return result;
-
-	/*
 	 * if one state of type C2 or C3 is available, mark this
 	 * CPU as being "idle manageable"
 	 */
@@ -1078,35 +599,6 @@
 	return 0;
 }
 
-int acpi_processor_cst_has_changed(struct acpi_processor *pr)
-{
-	int result = 0;
-
-
-	if (!pr)
-		return -EINVAL;
-
-	if (nocst) {
-		return -ENODEV;
-	}
-
-	if (!pr->flags.power_setup_done)
-		return -ENODEV;
-
-	/* Fall back to the default idle loop */
-	pm_idle = pm_idle_save;
-	synchronize_sched();	/* Relies on interrupts forcing exit from idle. */
-
-	pr->flags.power = 0;
-	result = acpi_processor_get_power_info(pr);
-	if ((pr->flags.power == 1) && (pr->flags.power_setup_done))
-		pm_idle = acpi_processor_idle;
-
-	return result;
-}
-
-/* proc interface */
-
 static int acpi_processor_power_seq_show(struct seq_file *seq, void *offset)
 {
 	struct acpi_processor *pr = seq->private;
@@ -1188,29 +680,365 @@
 	.release = single_release,
 };
 
-#ifdef CONFIG_SMP
-static void smp_callback(void *v)
+static inline u32 ticks_elapsed_in_us(u32 t1, u32 t2)
 {
-	/* we already woke the CPU up, nothing more to do */
+	if (t2 >= t1)
+		return PM_TIMER_TICKS_TO_US(t2 - t1);
+	else if (!(acpi_gbl_FADT.flags & ACPI_FADT_32BIT_TIMER))
+		return PM_TIMER_TICKS_TO_US(((0x00FFFFFF - t1) + t2) & 0x00FFFFFF);
+	else
+		return PM_TIMER_TICKS_TO_US((0xFFFFFFFF - t1) + t2);
 }
 
-/*
- * This function gets called when a part of the kernel has a new latency
- * requirement.  This means we need to get all processors out of their C-state,
- * and then recalculate a new suitable C-state. Just do a cross-cpu IPI; that
- * wakes them all right up.
+static inline u32 ticks_elapsed(u32 t1, u32 t2)
+{
+	if (t2 >= t1)
+		return (t2 - t1);
+	else if (!(acpi_gbl_FADT.flags & ACPI_FADT_32BIT_TIMER))
+		return (((0x00FFFFFF - t1) + t2) & 0x00FFFFFF);
+	else
+		return ((0xFFFFFFFF - t1) + t2);
+}
+
+/**
+ * acpi_idle_update_bm_rld - updates the BM_RLD bit depending on target state
+ * @pr: the processor
+ * @target: the new target state
  */
-static int acpi_processor_latency_notify(struct notifier_block *b,
-		unsigned long l, void *v)
+static inline void acpi_idle_update_bm_rld(struct acpi_processor *pr,
+					   struct acpi_processor_cx *target)
 {
-	smp_call_function(smp_callback, NULL, 0, 1);
-	return NOTIFY_OK;
+	if (pr->flags.bm_rld_set && target->type != ACPI_STATE_C3) {
+		acpi_set_register(ACPI_BITREG_BUS_MASTER_RLD, 0);
+		pr->flags.bm_rld_set = 0;
+	}
+
+	if (!pr->flags.bm_rld_set && target->type == ACPI_STATE_C3) {
+		acpi_set_register(ACPI_BITREG_BUS_MASTER_RLD, 1);
+		pr->flags.bm_rld_set = 1;
+	}
 }
 
-static struct notifier_block acpi_processor_latency_notifier = {
-	.notifier_call = acpi_processor_latency_notify,
+/**
+ * acpi_idle_do_entry - a helper function that does C2 and C3 type entry
+ * @cx: cstate data
+ */
+static inline void acpi_idle_do_entry(struct acpi_processor_cx *cx)
+{
+	if (cx->space_id == ACPI_CSTATE_FFH) {
+		/* Call into architectural FFH based C-state */
+		acpi_processor_ffh_cstate_enter(cx);
+	} else {
+		int unused;
+		/* IO port based C-state */
+		inb(cx->address);
+		/* Dummy wait op - must do something useless after P_LVL2 read
+		   because chipsets cannot guarantee that STPCLK# signal
+		   gets asserted in time to freeze execution properly. */
+		unused = inl(acpi_gbl_FADT.xpm_timer_block.address);
+	}
+}
+
+/**
+ * acpi_idle_enter_c1 - enters an ACPI C1 state-type
+ * @dev: the target CPU
+ * @state: the state data
+ *
+ * This is equivalent to the HALT instruction.
+ */
+static int acpi_idle_enter_c1(struct cpuidle_device *dev,
+			      struct cpuidle_state *state)
+{
+	struct acpi_processor *pr;
+	struct acpi_processor_cx *cx = cpuidle_get_statedata(state);
+	pr = processors[smp_processor_id()];
+
+	if (unlikely(!pr))
+		return 0;
+
+	if (pr->flags.bm_check)
+		acpi_idle_update_bm_rld(pr, cx);
+
+	current_thread_info()->status &= ~TS_POLLING;
+	/*
+	 * TS_POLLING-cleared state must be visible before we test
+	 * NEED_RESCHED:
+	 */
+	smp_mb();
+	if (!need_resched())
+		safe_halt();
+	current_thread_info()->status |= TS_POLLING;
+
+	cx->usage++;
+
+	return 0;
+}
+
+/**
+ * acpi_idle_enter_c2 - enters an ACPI C2 state-type
+ * @dev: the target CPU
+ * @state: the state data
+ */
+static int acpi_idle_enter_c2(struct cpuidle_device *dev,
+			      struct cpuidle_state *state)
+{
+	struct acpi_processor *pr;
+	struct acpi_processor_cx *cx = cpuidle_get_statedata(state);
+	u32 t1, t2;
+	pr = processors[smp_processor_id()];
+
+	if (unlikely(!pr))
+		return 0;
+
+	if (pr->flags.bm_check)
+		acpi_idle_update_bm_rld(pr, cx);
+
+	local_irq_disable();
+	current_thread_info()->status &= ~TS_POLLING;
+	/*
+	 * TS_POLLING-cleared state must be visible before we test
+	 * NEED_RESCHED:
+	 */
+	smp_mb();
+
+	if (unlikely(need_resched())) {
+		current_thread_info()->status |= TS_POLLING;
+		local_irq_enable();
+		return 0;
+	}
+
+	t1 = inl(acpi_gbl_FADT.xpm_timer_block.address);
+	acpi_state_timer_broadcast(pr, cx, 1);
+	acpi_idle_do_entry(cx);
+	t2 = inl(acpi_gbl_FADT.xpm_timer_block.address);
+
+#ifdef CONFIG_GENERIC_TIME
+	/* TSC halts in C2, so notify users */
+	mark_tsc_unstable("possible TSC halt in C2");
+#endif
+
+	local_irq_enable();
+	current_thread_info()->status |= TS_POLLING;
+
+	cx->usage++;
+
+	acpi_state_timer_broadcast(pr, cx, 0);
+	cx->time += ticks_elapsed(t1, t2);
+	return ticks_elapsed_in_us(t1, t2);
+}
+
+static int c3_cpu_count;
+static DEFINE_SPINLOCK(c3_lock);
+
+/**
+ * acpi_idle_enter_c3 - enters an ACPI C3 state-type
+ * @dev: the target CPU
+ * @state: the state data
+ *
+ * Similar to C2 entry, except special bus master handling is needed.
+ */
+static int acpi_idle_enter_c3(struct cpuidle_device *dev,
+			      struct cpuidle_state *state)
+{
+	struct acpi_processor *pr;
+	struct acpi_processor_cx *cx = cpuidle_get_statedata(state);
+	u32 t1, t2;
+	pr = processors[smp_processor_id()];
+
+	if (unlikely(!pr))
+		return 0;
+
+	if (pr->flags.bm_check)
+		acpi_idle_update_bm_rld(pr, cx);
+
+	local_irq_disable();
+	current_thread_info()->status &= ~TS_POLLING;
+	/*
+	 * TS_POLLING-cleared state must be visible before we test
+	 * NEED_RESCHED:
+	 */
+	smp_mb();
+
+	if (unlikely(need_resched())) {
+		current_thread_info()->status |= TS_POLLING;
+		local_irq_enable();
+		return 0;
+	}
+
+	/*
+	 * Must be done before busmaster disable as we might need to
+	 * access HPET !
+	 */
+	acpi_state_timer_broadcast(pr, cx, 1);
+
+	/* disable bus master */
+	if (pr->flags.bm_check) {
+		spin_lock(&c3_lock);
+			c3_cpu_count++;
+		if (c3_cpu_count == num_online_cpus()) {
+			/*
+			 * All CPUs are trying to go to C3
+			 * Disable bus master arbitration
+			 */
+			acpi_set_register(ACPI_BITREG_ARB_DISABLE, 1);
+		}
+		spin_unlock(&c3_lock);
+	} else {
+		/* SMP with no shared cache... Invalidate cache  */
+		ACPI_FLUSH_CPU_CACHE();
+	}
+
+	/* Get start time (ticks) */
+	t1 = inl(acpi_gbl_FADT.xpm_timer_block.address);
+	acpi_idle_do_entry(cx);
+	t2 = inl(acpi_gbl_FADT.xpm_timer_block.address);
+
+	if (pr->flags.bm_check) {
+		spin_lock(&c3_lock);
+		/* Enable bus master arbitration */
+		if (c3_cpu_count == num_online_cpus())
+			acpi_set_register(ACPI_BITREG_ARB_DISABLE, 0);
+		c3_cpu_count--;
+		spin_unlock(&c3_lock);
+	}
+
+#ifdef CONFIG_GENERIC_TIME
+	/* TSC halts in C3, so notify users */
+	mark_tsc_unstable("TSC halts in C3");
+#endif
+
+	local_irq_enable();
+	current_thread_info()->status |= TS_POLLING;
+
+	cx->usage++;
+
+	acpi_state_timer_broadcast(pr, cx, 0);
+	cx->time += ticks_elapsed(t1, t2);
+	return ticks_elapsed_in_us(t1, t2);
+}
+
+/**
+ * acpi_idle_bm_check - checks if bus master activity was detected
+ */
+static int acpi_idle_bm_check(void)
+{
+	u32 bm_status = 0;
+
+	acpi_get_register(ACPI_BITREG_BUS_MASTER_STATUS, &bm_status);
+	if (bm_status)
+		acpi_set_register(ACPI_BITREG_BUS_MASTER_STATUS, 1);
+	/*
+	 * PIIX4 Erratum #18: Note that BM_STS doesn't always reflect
+	 * the true state of bus mastering activity; forcing us to
+	 * manually check the BMIDEA bit of each IDE channel.
+	 */
+	else if (errata.piix4.bmisx) {
+		if ((inb_p(errata.piix4.bmisx + 0x02) & 0x01)
+		    || (inb_p(errata.piix4.bmisx + 0x0A) & 0x01))
+			bm_status = 1;
+	}
+	return bm_status;
+}
+
+struct cpuidle_driver acpi_idle_driver = {
+	.name =		"acpi_idle",
+	.bm_check =	acpi_idle_bm_check,
+	.owner =	THIS_MODULE,
 };
+
+/**
+ * acpi_processor_setup_cpuidle - prepares and configures CPUIDLE
+ * @pr: the ACPI processor
+ */
+static int acpi_processor_setup_cpuidle(struct acpi_processor *pr)
+{
+	int i, count = 0;
+	struct acpi_processor_cx *cx;
+	struct cpuidle_state *state;
+	struct cpuidle_device *dev = &pr->power.dev;
+
+	if (!pr->flags.power_setup_done)
+		return -EINVAL;
+
+	if (pr->flags.power == 0) {
+		return -EINVAL;
+	}
+
+	for (i = 1; i < ACPI_PROCESSOR_MAX_POWER && i <= max_cstate; i++) {
+		cx = &pr->power.states[i];
+		state = &dev->states[count];
+
+		if (!cx->valid)
+			continue;
+
+#ifdef CONFIG_HOTPLUG_CPU
+		if ((cx->type != ACPI_STATE_C1) && (num_online_cpus() > 1) &&
+		    !pr->flags.has_cst &&
+		    !(acpi_gbl_FADT.flags & ACPI_FADT_C2_MP_SUPPORTED))
+			continue;
 #endif
+		cpuidle_set_statedata(state, cx);
+
+		snprintf(state->name, CPUIDLE_NAME_LEN, "C%d", i);
+		state->exit_latency = cx->latency;
+		state->target_residency = cx->latency * 6;
+		state->power_usage = cx->power;
+
+		state->flags = 0;
+		switch (cx->type) {
+			case ACPI_STATE_C1:
+			state->flags |= CPUIDLE_FLAG_SHALLOW;
+			state->enter = acpi_idle_enter_c1;
+			break;
+
+			case ACPI_STATE_C2:
+			state->flags |= CPUIDLE_FLAG_BALANCED;
+			state->flags |= CPUIDLE_FLAG_TIME_VALID;
+			state->enter = acpi_idle_enter_c2;
+			break;
+
+			case ACPI_STATE_C3:
+			state->flags |= CPUIDLE_FLAG_DEEP;
+			state->flags |= CPUIDLE_FLAG_TIME_VALID;
+			state->flags |= CPUIDLE_FLAG_CHECK_BM;
+			state->enter = acpi_idle_enter_c3;
+			break;
+		}
+
+		count++;
+	}
+
+	dev->state_count = count;
+
+	if (!count)
+		return -EINVAL;
+
+	return 0;
+}
+
+int acpi_processor_cst_has_changed(struct acpi_processor *pr)
+{
+	int ret;
+
+	if (!pr)
+		return -EINVAL;
+
+	if (nocst) {
+		return -ENODEV;
+	}
+
+	if (!pr->flags.power_setup_done)
+		return -ENODEV;
+
+	cpuidle_pause_and_lock();
+	cpuidle_disable_device(&pr->power.dev);
+	acpi_processor_get_power_info(pr);
+	acpi_processor_setup_cpuidle(pr);
+	ret = cpuidle_enable_device(&pr->power.dev);
+	cpuidle_resume_and_unlock();
+
+	return ret;
+}
 
 int __cpuinit acpi_processor_power_init(struct acpi_processor *pr,
 			      struct acpi_device *device)
@@ -1228,9 +1056,6 @@
 			       "ACPI: processor limited to max C-state %d\n",
 			       max_cstate);
 		first_run++;
-#ifdef CONFIG_SMP
-		register_latency_notifier(&acpi_processor_latency_notifier);
-#endif
 	}
 
 	if (!pr)
@@ -1246,6 +1071,7 @@
 	}
 
 	acpi_processor_get_power_info(pr);
+	pr->flags.power_setup_done = 1;
 
 	/*
 	 * Install the idle handler if processor power management is supported.
@@ -1253,17 +1079,17 @@
 	 * platforms that only support C1.
 	 */
 	if ((pr->flags.power) && (!boot_option_idle_override)) {
+		acpi_processor_setup_cpuidle(pr);
+		pr->power.dev.cpu = pr->id;
+		if (cpuidle_register_device(&pr->power.dev))
+			return -EIO;
+
 		printk(KERN_INFO PREFIX "CPU%d (power states:", pr->id);
 		for (i = 1; i <= pr->power.count; i++)
 			if (pr->power.states[i].valid)
 				printk(" C%d[C%d]", i,
 				       pr->power.states[i].type);
 		printk(")\n");
-
-		if (pr->id == 0) {
-			pm_idle_save = pm_idle;
-			pm_idle = acpi_processor_idle;
-		}
 	}
 
 	/* 'power' [R] */
@@ -1277,35 +1103,18 @@
 		entry->owner = THIS_MODULE;
 	}
 
-	pr->flags.power_setup_done = 1;
-
 	return 0;
 }
 
 int acpi_processor_power_exit(struct acpi_processor *pr,
 			      struct acpi_device *device)
 {
-
+	if ((pr->flags.power) && (!boot_option_idle_override))
+		cpuidle_unregister_device(&pr->power.dev);
 	pr->flags.power_setup_done = 0;
 
 	if (acpi_device_dir(device))
 		remove_proc_entry(ACPI_PROCESSOR_FILE_POWER,
 				  acpi_device_dir(device));
-
-	/* Unregister the idle handler when processor #0 is removed. */
-	if (pr->id == 0) {
-		pm_idle = pm_idle_save;
-
-		/*
-		 * We are about to unload the current idle thread pm callback
-		 * (pm_idle), Wait for all processors to update cached/local
-		 * copies of pm_idle before proceeding.
-		 */
-		cpu_idle_wait();
-#ifdef CONFIG_SMP
-		unregister_latency_notifier(&acpi_processor_latency_notifier);
-#endif
-	}
-
 	return 0;
 }
diff -urN linux-2.6.22/drivers/cpuidle/cpuidle.c linux-cpuidle/drivers/cpuidle/cpuidle.c
--- linux-2.6.22/drivers/cpuidle/cpuidle.c	1969-12-31 19:00:00.000000000 -0500
+++ linux-cpuidle/drivers/cpuidle/cpuidle.c	2007-07-19 19:44:57.000000000 -0400
@@ -0,0 +1,297 @@
+/*
+ * cpuidle.c - core cpuidle infrastructure
+ *
+ * (C) 2006-2007 Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>
+ *               Shaohua Li <shaohua.li@intel.com>
+ *               Adam Belay <abelay@novell.com>
+ *
+ * This code is licenced under the GPL.
+ */
+
+#include <linux/kernel.h>
+#include <linux/mutex.h>
+#include <linux/sched.h>
+#include <linux/notifier.h>
+#include <linux/latency.h>
+#include <linux/cpu.h>
+#include <linux/cpuidle.h>
+
+#include "cpuidle.h"
+
+DEFINE_PER_CPU(struct cpuidle_device *, cpuidle_devices);
+EXPORT_PER_CPU_SYMBOL_GPL(cpuidle_devices);
+
+DEFINE_MUTEX(cpuidle_lock);
+LIST_HEAD(cpuidle_detected_devices);
+static void (*pm_idle_old)(void);
+
+static int enabled_devices;
+
+/**
+ * cpuidle_idle_call - the main idle loop
+ *
+ * NOTE: no locks or semaphores should be used here
+ */
+static void cpuidle_idle_call(void)
+{
+	struct cpuidle_device *dev = __get_cpu_var(cpuidle_devices);
+	struct cpuidle_state *target_state;
+	int next_state;
+
+	/* check if the device is ready */
+	if (!dev || !dev->enabled) {
+		if (pm_idle_old)
+			pm_idle_old();
+		else
+			local_irq_enable();
+		return;
+	}
+
+	/* ask the governor for the next state */
+	next_state = cpuidle_curr_governor->select(dev);
+	if (need_resched())
+		return;
+	target_state = &dev->states[next_state];
+
+	/* enter the state and update stats */
+	dev->last_residency = target_state->enter(dev, target_state);
+	dev->last_state = target_state;
+	target_state->time += dev->last_residency;
+	target_state->usage++;
+
+	/* give the governor an opportunity to reflect on the outcome */
+	if (cpuidle_curr_governor->reflect)
+		cpuidle_curr_governor->reflect(dev);
+}
+
+/**
+ * cpuidle_install_idle_handler - installs the cpuidle idle loop handler
+ */
+void cpuidle_install_idle_handler(void)
+{
+	if (enabled_devices && (pm_idle != cpuidle_idle_call)) {
+		/* Make sure all changes finished before we switch to new idle */
+		smp_wmb();
+		pm_idle = cpuidle_idle_call;
+	}
+}
+
+/**
+ * cpuidle_uninstall_idle_handler - uninstalls the cpuidle idle loop handler
+ */
+void cpuidle_uninstall_idle_handler(void)
+{
+	if (enabled_devices && (pm_idle != pm_idle_old)) {
+		pm_idle = pm_idle_old;
+		cpu_idle_wait();
+	}
+}
+
+/**
+ * cpuidle_pause_and_lock - temporarily disables CPUIDLE
+ */
+void cpuidle_pause_and_lock(void)
+{
+	mutex_lock(&cpuidle_lock);
+	cpuidle_uninstall_idle_handler();
+}
+
+EXPORT_SYMBOL_GPL(cpuidle_pause_and_lock);
+
+/**
+ * cpuidle_resume_and_unlock - resumes CPUIDLE operation
+ */
+void cpuidle_resume_and_unlock(void)
+{
+	cpuidle_install_idle_handler();
+	mutex_unlock(&cpuidle_lock);
+}
+
+EXPORT_SYMBOL_GPL(cpuidle_resume_and_unlock);
+
+/**
+ * cpuidle_enable_device - enables idle PM for a CPU
+ * @dev: the CPU
+ *
+ * This function must be called between cpuidle_pause_and_lock and
+ * cpuidle_resume_and_unlock when used externally.
+ */
+int cpuidle_enable_device(struct cpuidle_device *dev)
+{
+	int ret, i;
+
+	if (dev->enabled)
+		return 0;
+	if (!cpuidle_curr_driver || !cpuidle_curr_governor)
+		return -EIO;
+	if (!dev->state_count)
+		return -EINVAL;
+
+	if ((ret = cpuidle_add_state_sysfs(dev)))
+		return ret;
+
+	if (cpuidle_curr_governor->enable &&
+	    (ret = cpuidle_curr_governor->enable(dev)))
+		goto fail_sysfs;
+
+	for (i = 0; i < dev->state_count; i++) {
+		dev->states[i].usage = 0;
+		dev->states[i].time = 0;
+	}
+	dev->last_residency = 0;
+	dev->last_state = NULL;
+
+	smp_wmb();
+
+	dev->enabled = 1;
+
+	enabled_devices++;
+	return 0;
+
+fail_sysfs:
+	cpuidle_remove_state_sysfs(dev);
+
+	return ret;
+}
+
+EXPORT_SYMBOL_GPL(cpuidle_enable_device);
+
+/**
+ * cpuidle_disable_device - disables idle PM for a CPU
+ * @dev: the CPU
+ *
+ * This function must be called between cpuidle_pause_and_lock and
+ * cpuidle_resume_and_unlock when used externally.
+ */
+void cpuidle_disable_device(struct cpuidle_device *dev)
+{
+	if (!dev->enabled)
+		return;
+	if (!cpuidle_curr_driver || !cpuidle_curr_governor)
+		return;
+
+	dev->enabled = 0;
+
+	if (cpuidle_curr_governor->disable)
+		cpuidle_curr_governor->disable(dev);
+
+	cpuidle_remove_state_sysfs(dev);
+	enabled_devices--;
+}
+
+EXPORT_SYMBOL_GPL(cpuidle_disable_device);
+
+/**
+ * cpuidle_register_device - registers a CPU's idle PM feature
+ * @dev: the cpu
+ */
+int cpuidle_register_device(struct cpuidle_device *dev)
+{
+	int ret;
+	struct sys_device *sys_dev = get_cpu_sysdev((unsigned long)dev->cpu);
+
+	if (!sys_dev)
+		return -EINVAL;
+	if (!try_module_get(cpuidle_curr_driver->owner))
+		return -EINVAL;
+
+	init_completion(&dev->kobj_unregister);
+
+	mutex_lock(&cpuidle_lock);
+
+	per_cpu(cpuidle_devices, dev->cpu) = dev;
+	list_add(&dev->device_list, &cpuidle_detected_devices);
+	if ((ret = cpuidle_add_sysfs(sys_dev))) {
+		list_del(&dev->device_list);
+		per_cpu(cpuidle_devices, dev->cpu) = NULL;
+		mutex_unlock(&cpuidle_lock);
+		module_put(cpuidle_curr_driver->owner);
+		return ret;
+	}
+
+	cpuidle_enable_device(dev);
+	cpuidle_install_idle_handler();
+
+	mutex_unlock(&cpuidle_lock);
+
+	return 0;
+
+}
+
+EXPORT_SYMBOL_GPL(cpuidle_register_device);
+
+/**
+ * cpuidle_unregister_device - unregisters a CPU's idle PM feature
+ * @dev: the cpu
+ */
+void cpuidle_unregister_device(struct cpuidle_device *dev)
+{
+	struct sys_device *sys_dev = get_cpu_sysdev((unsigned long)dev->cpu);
+
+	cpuidle_pause_and_lock();
+
+	cpuidle_disable_device(dev);
+
+	cpuidle_remove_sysfs(sys_dev);
+	list_del(&dev->device_list);
+	wait_for_completion(&dev->kobj_unregister);
+	per_cpu(cpuidle_devices, dev->cpu) = NULL;
+
+	cpuidle_resume_and_unlock();
+
+	module_put(cpuidle_curr_driver->owner);
+}
+
+EXPORT_SYMBOL_GPL(cpuidle_unregister_device);
+
+#ifdef CONFIG_SMP
+
+static void smp_callback(void *v)
+{
+	/* we already woke the CPU up, nothing more to do */
+}
+
+/*
+ * This function gets called when a part of the kernel has a new latency
+ * requirement.  This means we need to get all processors out of their C-state,
+ * and then recalculate a new suitable C-state. Just do a cross-cpu IPI; that
+ * wakes them all right up.
+ */
+static int cpuidle_latency_notify(struct notifier_block *b,
+		unsigned long l, void *v)
+{
+	smp_call_function(smp_callback, NULL, 0, 1);
+	return NOTIFY_OK;
+}
+
+static struct notifier_block cpuidle_latency_notifier = {
+	.notifier_call = cpuidle_latency_notify,
+};
+
+#define latency_notifier_init(x) do { register_latency_notifier(x); } while (0)
+
+#else /* CONFIG_SMP */
+
+#define latency_notifier_init(x) do { } while (0)
+
+#endif /* CONFIG_SMP */
+
+/**
+ * cpuidle_init - core initializer
+ */
+static int __init cpuidle_init(void)
+{
+	int ret;
+
+	pm_idle_old = pm_idle;
+
+	ret = cpuidle_add_class_sysfs(&cpu_sysdev_class);
+	if (ret)
+		return ret;
+
+	latency_notifier_init(&cpuidle_latency_notifier);
+
+	return 0;
+}
+
+core_initcall(cpuidle_init);
diff -urN linux-2.6.22/drivers/cpuidle/cpuidle.h linux-cpuidle/drivers/cpuidle/cpuidle.h
--- linux-2.6.22/drivers/cpuidle/cpuidle.h	1969-12-31 19:00:00.000000000 -0500
+++ linux-cpuidle/drivers/cpuidle/cpuidle.h	2007-07-17 04:19:17.000000000 -0400
@@ -0,0 +1,33 @@
+/*
+ * cpuidle.h - The internal header file
+ */
+
+#ifndef __DRIVER_CPUIDLE_H
+#define __DRIVER_CPUIDLE_H
+
+#include <linux/sysdev.h>
+
+/* For internal use only */
+extern struct cpuidle_governor *cpuidle_curr_governor;
+extern struct cpuidle_driver *cpuidle_curr_driver;
+extern struct list_head cpuidle_governors;
+extern struct list_head cpuidle_detected_devices;
+extern struct mutex cpuidle_lock;
+extern spinlock_t cpuidle_driver_lock;
+
+/* idle loop */
+extern void cpuidle_install_idle_handler(void);
+extern void cpuidle_uninstall_idle_handler(void);
+
+/* governors */
+extern int cpuidle_switch_governor(struct cpuidle_governor *gov);
+
+/* sysfs */
+extern int cpuidle_add_class_sysfs(struct sysdev_class *cls);
+extern void cpuidle_remove_class_sysfs(struct sysdev_class *cls);
+extern int cpuidle_add_state_sysfs(struct cpuidle_device *device);
+extern void cpuidle_remove_state_sysfs(struct cpuidle_device *device);
+extern int cpuidle_add_sysfs(struct sys_device *sysdev);
+extern void cpuidle_remove_sysfs(struct sys_device *sysdev);
+
+#endif /* __DRIVER_CPUIDLE_H */
diff -urN linux-2.6.22/drivers/cpuidle/driver.c linux-cpuidle/drivers/cpuidle/driver.c
--- linux-2.6.22/drivers/cpuidle/driver.c	1969-12-31 19:00:00.000000000 -0500
+++ linux-cpuidle/drivers/cpuidle/driver.c	2007-07-17 04:19:17.000000000 -0400
@@ -0,0 +1,69 @@
+/*
+ * driver.c - driver support
+ *
+ * (C) 2006-2007 Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>
+ *               Shaohua Li <shaohua.li@intel.com>
+ *               Adam Belay <abelay@novell.com>
+ *
+ * This code is licenced under the GPL.
+ */
+
+#include <linux/mutex.h>
+#include <linux/module.h>
+#include <linux/cpuidle.h>
+
+#include "cpuidle.h"
+
+struct cpuidle_driver *cpuidle_curr_driver;
+DEFINE_SPINLOCK(cpuidle_driver_lock);
+
+/**
+ * cpuidle_register_driver - registers a driver
+ * @drv: the driver
+ */
+int cpuidle_register_driver(struct cpuidle_driver *drv)
+{
+	if (!drv)
+		return -EINVAL;
+
+	spin_lock(&cpuidle_driver_lock);
+	if (cpuidle_curr_driver) {
+		spin_unlock(&cpuidle_driver_lock);
+		return -EBUSY;
+	}
+	cpuidle_curr_driver = drv;
+	spin_unlock(&cpuidle_driver_lock);
+
+	return 0;
+}
+
+EXPORT_SYMBOL_GPL(cpuidle_register_driver);
+
+/**
+ * cpuidle_unregister_driver - unregisters a driver
+ * @drv: the driver
+ */
+void cpuidle_unregister_driver(struct cpuidle_driver *drv)
+{
+	if (!drv)
+		return;
+
+	spin_lock(&cpuidle_driver_lock);
+	cpuidle_curr_driver = NULL;
+	spin_unlock(&cpuidle_driver_lock);
+}
+
+EXPORT_SYMBOL_GPL(cpuidle_unregister_driver);
+
+/**
+ * cpuidle_get_bm_activity - determines if BM activity has occured
+ */
+int cpuidle_get_bm_activity(void)
+{
+	if (cpuidle_curr_driver->bm_check)
+		return cpuidle_curr_driver->bm_check();
+	else
+		return 0;
+}
+
+EXPORT_SYMBOL_GPL(cpuidle_get_bm_activity);
diff -urN linux-2.6.22/drivers/cpuidle/governor.c linux-cpuidle/drivers/cpuidle/governor.c
--- linux-2.6.22/drivers/cpuidle/governor.c	1969-12-31 19:00:00.000000000 -0500
+++ linux-cpuidle/drivers/cpuidle/governor.c	2007-07-17 04:19:17.000000000 -0400
@@ -0,0 +1,141 @@
+/*
+ * governor.c - governor support
+ *
+ * (C) 2006-2007 Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>
+ *               Shaohua Li <shaohua.li@intel.com>
+ *               Adam Belay <abelay@novell.com>
+ *
+ * This code is licenced under the GPL.
+ */
+
+#include <linux/mutex.h>
+#include <linux/module.h>
+#include <linux/cpuidle.h>
+
+#include "cpuidle.h"
+
+LIST_HEAD(cpuidle_governors);
+struct cpuidle_governor *cpuidle_curr_governor;
+
+/**
+ * __cpuidle_find_governor - finds a governor of the specified name
+ * @str: the name
+ *
+ * Must be called with cpuidle_lock aquired.
+ */
+static struct cpuidle_governor * __cpuidle_find_governor(const char *str)
+{
+	struct cpuidle_governor *gov;
+
+	list_for_each_entry(gov, &cpuidle_governors, governor_list)
+		if (!strnicmp(str, gov->name, CPUIDLE_NAME_LEN))
+			return gov;
+
+	return NULL;
+}
+
+/**
+ * cpuidle_switch_governor - changes the governor
+ * @gov: the new target governor
+ *
+ * NOTE: "gov" can be NULL to specify disabled
+ * Must be called with cpuidle_lock aquired.
+ */
+int cpuidle_switch_governor(struct cpuidle_governor *gov)
+{
+	struct cpuidle_device *dev;
+
+	if (gov == cpuidle_curr_governor)
+		return 0;
+
+	cpuidle_uninstall_idle_handler();
+
+	if (cpuidle_curr_governor) {
+		list_for_each_entry(dev, &cpuidle_detected_devices, device_list)
+			cpuidle_disable_device(dev);
+		module_put(cpuidle_curr_governor->owner);
+	}
+
+	cpuidle_curr_governor = gov;
+
+	if (gov) {
+		if (!try_module_get(cpuidle_curr_governor->owner))
+			return -EINVAL;
+		list_for_each_entry(dev, &cpuidle_detected_devices, device_list)
+			cpuidle_enable_device(dev);
+		cpuidle_install_idle_handler();
+		printk(KERN_INFO "cpuidle: using governor %s\n", gov->name);
+	}
+
+	return 0;
+}
+
+/**
+ * cpuidle_register_governor - registers a governor
+ * @gov: the governor
+ */
+int cpuidle_register_governor(struct cpuidle_governor *gov)
+{
+	int ret = -EEXIST;
+
+	if (!gov || !gov->select)
+		return -EINVAL;
+
+	mutex_lock(&cpuidle_lock);
+	if (__cpuidle_find_governor(gov->name) == NULL) {
+		ret = 0;
+		list_add_tail(&gov->governor_list, &cpuidle_governors);
+		if (!cpuidle_curr_governor ||
+		    cpuidle_curr_governor->rating < gov->rating)
+			cpuidle_switch_governor(gov);
+	}
+	mutex_unlock(&cpuidle_lock);
+
+	return ret;
+}
+
+EXPORT_SYMBOL_GPL(cpuidle_register_governor);
+
+/**
+ * cpuidle_replace_governor - find a replacement governor
+ * @exclude_rating: the rating that will be skipped while looking for
+ * new governor.
+ */
+static struct cpuidle_governor *cpuidle_replace_governor(int exclude_rating)
+{
+	struct cpuidle_governor *gov;
+	struct cpuidle_governor *ret_gov = NULL;
+	unsigned int max_rating = 0;
+
+	list_for_each_entry(gov, &cpuidle_governors, governor_list) {
+		if (gov->rating == exclude_rating)
+			continue;
+		if (gov->rating > max_rating) {
+			max_rating = gov->rating;
+			ret_gov = gov;
+		}
+	}
+
+	return ret_gov;
+}
+
+/**
+ * cpuidle_unregister_governor - unregisters a governor
+ * @gov: the governor
+ */
+void cpuidle_unregister_governor(struct cpuidle_governor *gov)
+{
+	if (!gov)
+		return;
+
+	mutex_lock(&cpuidle_lock);
+	if (gov == cpuidle_curr_governor) {
+		struct cpuidle_governor *new_gov;
+		new_gov = cpuidle_replace_governor(gov->rating);
+		cpuidle_switch_governor(new_gov);
+	}
+	list_del(&gov->governor_list);
+	mutex_unlock(&cpuidle_lock);
+}
+
+EXPORT_SYMBOL_GPL(cpuidle_unregister_governor);
diff -urN linux-2.6.22/drivers/cpuidle/governors/ladder.c linux-cpuidle/drivers/cpuidle/governors/ladder.c
--- linux-2.6.22/drivers/cpuidle/governors/ladder.c	1969-12-31 19:00:00.000000000 -0500
+++ linux-cpuidle/drivers/cpuidle/governors/ladder.c	2007-07-17 04:19:17.000000000 -0400
@@ -0,0 +1,210 @@
+/*
+ * ladder.c - the residency ladder algorithm
+ *
+ *  Copyright (C) 2001, 2002 Andy Grover <andrew.grover@intel.com>
+ *  Copyright (C) 2001, 2002 Paul Diefenbaugh <paul.s.diefenbaugh@intel.com>
+ *  Copyright (C) 2004, 2005 Dominik Brodowski <linux@brodo.de>
+ *
+ * (C) 2006-2007 Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>
+ *               Shaohua Li <shaohua.li@intel.com>
+ *               Adam Belay <abelay@novell.com>
+ *
+ * This code is licenced under the GPL.
+ */
+
+#include <linux/kernel.h>
+#include <linux/cpuidle.h>
+#include <linux/latency.h>
+#include <linux/moduleparam.h>
+#include <linux/jiffies.h>
+
+#include <asm/io.h>
+#include <asm/uaccess.h>
+
+#define PROMOTION_COUNT 4
+#define DEMOTION_COUNT 1
+
+/*
+ * bm_history -- bit-mask with a bit per jiffy of bus-master activity
+ * 1000 HZ: 0xFFFFFFFF: 32 jiffies = 32ms
+ * 800 HZ: 0xFFFFFFFF: 32 jiffies = 40ms
+ * 100 HZ: 0x0000000F: 4 jiffies = 40ms
+ * reduce history for more aggressive entry into C3
+ */
+static unsigned int bm_history __read_mostly =
+    (HZ >= 800 ? 0xFFFFFFFF : ((1U << (HZ / 25)) - 1));
+module_param(bm_history, uint, 0644);
+
+struct ladder_device_state {
+	struct {
+		u32 promotion_count;
+		u32 demotion_count;
+		u32 promotion_time;
+		u32 demotion_time;
+		u32 bm;
+	} threshold;
+	struct {
+		int promotion_count;
+		int demotion_count;
+	} stats;
+};
+
+struct ladder_device {
+	struct ladder_device_state states[CPUIDLE_STATE_MAX];
+	unsigned int bm_check:1;
+	unsigned long bm_check_timestamp;
+	unsigned long bm_activity; /* FIXME: bm activity should be global */
+	int last_state_idx;
+};
+
+static DEFINE_PER_CPU(struct ladder_device, ladder_devices);
+
+/**
+ * ladder_do_selection - prepares private data for a state change
+ * @ldev: the ladder device
+ * @old_idx: the current state index
+ * @new_idx: the new target state index
+ */
+static inline void ladder_do_selection(struct ladder_device *ldev,
+				       int old_idx, int new_idx)
+{
+	ldev->states[old_idx].stats.promotion_count = 0;
+	ldev->states[old_idx].stats.demotion_count = 0;
+	ldev->last_state_idx = new_idx;
+}
+
+/**
+ * ladder_select_state - selects the next state to enter
+ * @dev: the CPU
+ */
+static int ladder_select_state(struct cpuidle_device *dev)
+{
+	struct ladder_device *ldev = &__get_cpu_var(ladder_devices);
+	struct ladder_device_state *last_state;
+	int last_residency, last_idx = ldev->last_state_idx;
+
+	if (unlikely(!ldev))
+		return 0;
+
+	last_state = &ldev->states[last_idx];
+
+	/* demote if within BM threshold */
+	if (ldev->bm_check) {
+		unsigned long diff;
+
+		diff = jiffies - ldev->bm_check_timestamp;
+		if (diff > 31)
+			diff = 31;
+
+		ldev->bm_activity <<= diff;
+		if (cpuidle_get_bm_activity())
+			ldev->bm_activity |= ((1 << diff) - 1);
+
+		ldev->bm_check_timestamp = jiffies;
+		if ((last_idx > 0) &&
+		    (last_state->threshold.bm & ldev->bm_activity)) {
+			ladder_do_selection(ldev, last_idx, last_idx - 1);
+			return last_idx - 1;
+		}
+	}
+
+	if (dev->states[last_idx].flags & CPUIDLE_FLAG_TIME_VALID)
+		last_residency = cpuidle_get_last_residency(dev) - dev->states[last_idx].exit_latency;
+	else
+		last_residency = last_state->threshold.promotion_time + 1;
+
+	/* consider promotion */
+	if (last_idx < dev->state_count - 1 &&
+	    last_residency > last_state->threshold.promotion_time &&
+	    dev->states[last_idx + 1].exit_latency <= system_latency_constraint()) {
+		last_state->stats.promotion_count++;
+		last_state->stats.demotion_count = 0;
+		if (last_state->stats.promotion_count >= last_state->threshold.promotion_count) {
+			ladder_do_selection(ldev, last_idx, last_idx + 1);
+			return last_idx + 1;
+		}
+	}
+
+	/* consider demotion */
+	if (last_idx > 0 &&
+	    last_residency < last_state->threshold.demotion_time) {
+		last_state->stats.demotion_count++;
+		last_state->stats.promotion_count = 0;
+		if (last_state->stats.demotion_count >= last_state->threshold.demotion_count) {
+			ladder_do_selection(ldev, last_idx, last_idx - 1);
+			return last_idx - 1;
+		}
+	}
+
+	/* otherwise remain at the current state */
+	return last_idx;
+}
+
+/**
+ * ladder_enable_device - setup for the governor
+ * @dev: the CPU
+ */
+static int ladder_enable_device(struct cpuidle_device *dev)
+{
+	int i, bm_check = 0;
+	struct ladder_device *ldev = &per_cpu(ladder_devices, dev->cpu);
+	struct ladder_device_state *lstate;
+	struct cpuidle_state *state;
+
+	ldev->last_state_idx = 0;
+	ldev->bm_check_timestamp = 0;
+	ldev->bm_activity = 0;
+
+	for (i = 0; i < dev->state_count; i++) {
+		state = &dev->states[i];
+		lstate = &ldev->states[i];
+
+		lstate->stats.promotion_count = 0;
+		lstate->stats.demotion_count = 0;
+
+		lstate->threshold.promotion_count = PROMOTION_COUNT;
+		lstate->threshold.demotion_count = DEMOTION_COUNT;
+
+		if (i < dev->state_count - 1)
+			lstate->threshold.promotion_time = state->exit_latency;
+		if (i > 0)
+			lstate->threshold.demotion_time = state->exit_latency;
+		if (state->flags & CPUIDLE_FLAG_CHECK_BM) {
+			lstate->threshold.bm = bm_history;
+			bm_check = 1;
+		} else
+			lstate->threshold.bm = 0;
+	}
+
+	ldev->bm_check = bm_check;
+
+	return 0;
+}
+
+static struct cpuidle_governor ladder_governor = {
+	.name =		"ladder",
+	.rating =	10,
+	.enable =	ladder_enable_device,
+	.select =	ladder_select_state,
+	.owner =	THIS_MODULE,
+};
+
+/**
+ * init_ladder - initializes the governor
+ */
+static int __init init_ladder(void)
+{
+	return cpuidle_register_governor(&ladder_governor);
+}
+
+/**
+ * exit_ladder - exits the governor
+ */
+static void __exit exit_ladder(void)
+{
+	cpuidle_unregister_governor(&ladder_governor);
+}
+
+MODULE_LICENSE("GPL");
+module_init(init_ladder);
+module_exit(exit_ladder);
diff -urN linux-2.6.22/drivers/cpuidle/governors/Makefile linux-cpuidle/drivers/cpuidle/governors/Makefile
--- linux-2.6.22/drivers/cpuidle/governors/Makefile	1969-12-31 19:00:00.000000000 -0500
+++ linux-cpuidle/drivers/cpuidle/governors/Makefile	2007-07-17 04:19:17.000000000 -0400
@@ -0,0 +1,6 @@
+#
+# Makefile for cpuidle governors.
+#
+
+obj-$(CONFIG_CPU_IDLE_GOV_LADDER) += ladder.o
+obj-$(CONFIG_CPU_IDLE_GOV_MENU) += menu.o
diff -urN linux-2.6.22/drivers/cpuidle/governors/menu.c linux-cpuidle/drivers/cpuidle/governors/menu.c
--- linux-2.6.22/drivers/cpuidle/governors/menu.c	1969-12-31 19:00:00.000000000 -0500
+++ linux-cpuidle/drivers/cpuidle/governors/menu.c	2007-07-17 04:19:17.000000000 -0400
@@ -0,0 +1,147 @@
+/*
+ * menu.c - the menu idle governor
+ *
+ * Copyright (C) 2006-2007 Adam Belay <abelay@novell.com>
+ *
+ * This code is licenced under the GPL.
+ */
+
+#include <linux/kernel.h>
+#include <linux/cpuidle.h>
+#include <linux/latency.h>
+#include <linux/time.h>
+#include <linux/ktime.h>
+#include <linux/hrtimer.h>
+#include <linux/tick.h>
+
+#define BM_HOLDOFF	2000	/* 2 ms */
+
+struct menu_device {
+	int	last_state_idx;
+
+	int	predicted_us;
+	int	last_measured_us;
+	int	deepest_bm_state;
+	int	bm_elapsed_us;
+	int	bm_holdoff_us;
+};
+
+static DEFINE_PER_CPU(struct menu_device, menu_devices);
+
+/**
+ * menu_select - selects the next idle state to enter
+ * @dev: the CPU
+ */
+static int menu_select(struct cpuidle_device *dev)
+{
+	struct menu_device *data = &__get_cpu_var(menu_devices);
+	int i, expected_us, max_state = dev->state_count;
+
+	/* determine the expected residency time */
+	expected_us = (s32) ktime_to_ns(tick_nohz_get_sleep_length()) / 1000;
+
+	/* determine the maximum state compatible with current BM status */
+	if (cpuidle_get_bm_activity())
+		data->bm_elapsed_us = 0;
+	if (data->bm_elapsed_us <= data->bm_holdoff_us)
+		max_state = data->deepest_bm_state + 1;
+
+	/* find the deepest idle state that satisfies our constraints */
+	for (i = 1; i < max_state; i++) {
+		struct cpuidle_state *s = &dev->states[i];
+
+		if (s->target_residency > expected_us)
+			break;
+		if (s->target_residency > data->predicted_us)
+			break;
+		if (s->exit_latency > system_latency_constraint())
+			break;
+	}
+
+	data->last_state_idx = i - 1;
+	return i - 1;
+}
+
+/**
+ * menu_reflect - attempts to guess what happened after entry
+ * @dev: the CPU
+ *
+ * NOTE: it's important to be fast here because this operation will add to
+ *       the overall exit latency.
+ */
+static void menu_reflect(struct cpuidle_device *dev)
+{
+	struct menu_device *data = &__get_cpu_var(menu_devices);
+	int last_idx = data->last_state_idx;
+	int measured_us = cpuidle_get_last_residency(dev);
+	struct cpuidle_state *target = &dev->states[last_idx];
+
+	/*
+	 * Ugh, this idle state doesn't support residency measurements, so we
+	 * are basically lost in the dark.  As a compromise, assume we slept
+	 * for one full standard timer tick.  However, be aware that this
+	 * could potentially result in a suboptimal state transition.
+	 */
+	if (!(target->flags & CPUIDLE_FLAG_TIME_VALID))
+		measured_us = USEC_PER_SEC / HZ;
+
+	/* Update time elapsed since last BM detection */
+	if (data->bm_elapsed_us <= data->bm_holdoff_us)
+		data->bm_elapsed_us += measured_us;
+
+	/* Predict time remaining until next break event */
+	data->predicted_us = max(measured_us, data->last_measured_us);
+	data->last_measured_us = measured_us;
+}
+
+/**
+ * menu_enable_device - scans a CPU's states and does setup
+ * @dev: the CPU
+ */
+static int menu_enable_device(struct cpuidle_device *dev)
+{
+	struct menu_device *data = &per_cpu(menu_devices, dev->cpu);
+	int i;
+
+	data->last_state_idx = 0;
+	data->predicted_us = 0;
+	data->last_measured_us = 0;
+	data->bm_elapsed_us = 0;
+	data->bm_holdoff_us = BM_HOLDOFF;
+
+	for (i = 1; i < dev->state_count; i++)
+		if (dev->states[i].flags & CPUIDLE_FLAG_CHECK_BM)
+			break;
+	data->deepest_bm_state = i - 1;
+
+	return 0;
+}
+
+struct cpuidle_governor menu_governor = {
+	.name =		"menu",
+	.rating =	20,
+	.enable =	menu_enable_device,
+	.select =	menu_select,
+	.reflect =	menu_reflect,
+	.owner =	THIS_MODULE,
+};
+
+/**
+ * init_menu - initializes the governor
+ */
+static int __init init_menu(void)
+{
+	return cpuidle_register_governor(&menu_governor);
+}
+
+/**
+ * exit_menu - exits the governor
+ */
+static void __exit exit_menu(void)
+{
+	cpuidle_unregister_governor(&menu_governor);
+}
+
+MODULE_LICENSE("GPL");
+module_init(init_menu);
+module_exit(exit_menu);
diff -urN linux-2.6.22/drivers/cpuidle/Kconfig linux-cpuidle/drivers/cpuidle/Kconfig
--- linux-2.6.22/drivers/cpuidle/Kconfig	1969-12-31 19:00:00.000000000 -0500
+++ linux-cpuidle/drivers/cpuidle/Kconfig	2007-07-17 04:19:17.000000000 -0400
@@ -0,0 +1,39 @@
+menu "CPU idle PM support"
+
+config CPU_IDLE
+	bool "CPU idle PM support"
+	help
+	  CPU idle is a generic framework for supporting software-controlled
+	  idle processor power management.  It includes modular cross-platform
+	  governors that can be swapped during runtime.
+
+	  If you're using a mobile platform that supports CPU idle PM (e.g.
+	  an ACPI-capable notebook), you should say Y here.
+
+if CPU_IDLE
+
+comment "Governors"
+
+config CPU_IDLE_GOV_LADDER
+	tristate "'ladder' governor"
+	depends on CPU_IDLE
+	default y
+	help
+	  This cpuidle governor promotes and demotes through the supported idle
+	  states using residency time and bus master activity as metrics.  This
+	  algorithm was originally introduced in the old ACPI processor driver.
+
+config CPU_IDLE_GOV_MENU
+	tristate "'menu' governor"
+	depends on CPU_IDLE && NO_HZ
+	default y
+	help
+	  This cpuidle governor evaluates all available states and chooses the
+	  deepest state that meets all of the following constraints: BM activity,
+	  expected time until next timer interrupt, and last break event time
+	  delta.  It is designed to minimize power consumption.  Currently
+	  dynticks is required.
+
+endif	# CPU_IDLE
+
+endmenu
diff -urN linux-2.6.22/drivers/cpuidle/Makefile linux-cpuidle/drivers/cpuidle/Makefile
--- linux-2.6.22/drivers/cpuidle/Makefile	1969-12-31 19:00:00.000000000 -0500
+++ linux-cpuidle/drivers/cpuidle/Makefile	2007-07-17 04:19:17.000000000 -0400
@@ -0,0 +1,5 @@
+#
+# Makefile for cpuidle.
+#
+
+obj-y += cpuidle.o driver.o governor.o sysfs.o governors/
diff -urN linux-2.6.22/drivers/cpuidle/sysfs.c linux-cpuidle/drivers/cpuidle/sysfs.c
--- linux-2.6.22/drivers/cpuidle/sysfs.c	1969-12-31 19:00:00.000000000 -0500
+++ linux-cpuidle/drivers/cpuidle/sysfs.c	2007-07-18 02:29:03.000000000 -0400
@@ -0,0 +1,364 @@
+/*
+ * sysfs.c - sysfs support
+ *
+ * (C) 2006-2007 Shaohua Li <shaohua.li@intel.com>
+ *
+ * This code is licenced under the GPL.
+ */
+
+#include <linux/kernel.h>
+#include <linux/cpuidle.h>
+#include <linux/sysfs.h>
+#include <linux/cpu.h>
+
+#include "cpuidle.h"
+
+static unsigned int sysfs_switch;
+static int __init cpuidle_sysfs_setup(char *unused)
+{
+	sysfs_switch = 1;
+	return 1;
+}
+__setup("cpuidle_sysfs_switch", cpuidle_sysfs_setup);
+
+static ssize_t show_available_governors(struct sys_device *dev, char *buf)
+{
+	ssize_t i = 0;
+	struct cpuidle_governor *tmp;
+
+	mutex_lock(&cpuidle_lock);
+	list_for_each_entry(tmp, &cpuidle_governors, governor_list) {
+		if (i >= (ssize_t) ((PAGE_SIZE/sizeof(char)) - CPUIDLE_NAME_LEN - 2))
+			goto out;
+		i += scnprintf(&buf[i], CPUIDLE_NAME_LEN, "%s ", tmp->name);
+	}
+
+out:
+	i+= sprintf(&buf[i], "\n");
+	mutex_unlock(&cpuidle_lock);
+	return i;
+}
+
+static ssize_t show_current_driver(struct sys_device *dev, char *buf)
+{
+	ssize_t ret;
+
+	spin_lock(&cpuidle_driver_lock);
+	if (cpuidle_curr_driver)
+		ret = sprintf(buf, "%s\n", cpuidle_curr_driver->name);
+	else
+		ret = sprintf(buf, "none\n");
+	spin_unlock(&cpuidle_driver_lock);
+
+	return ret;
+}
+
+static ssize_t show_current_governor(struct sys_device *dev, char *buf)
+{
+	ssize_t ret;
+
+	mutex_lock(&cpuidle_lock);
+	if (cpuidle_curr_governor)
+		ret = sprintf(buf, "%s\n", cpuidle_curr_governor->name);
+	else
+		ret = sprintf(buf, "none\n");
+	mutex_unlock(&cpuidle_lock);
+
+	return ret;
+}
+
+static ssize_t store_current_governor(struct sys_device *dev,
+	const char *buf, size_t count)
+{
+	char gov_name[CPUIDLE_NAME_LEN];
+	int ret = -EINVAL;
+	size_t len = count;
+	struct cpuidle_governor *gov;
+
+	if (!len || len >= sizeof(gov_name))
+		return -EINVAL;
+
+	memcpy(gov_name, buf, len);
+	gov_name[len] = '\0';
+
+	len = strlen(gov_name);
+
+	if (len && gov_name[len - 1] == '\n')
+		gov_name[len - 1] = '\0';
+
+	mutex_lock(&cpuidle_lock);
+
+	list_for_each_entry(gov, &cpuidle_governors, governor_list) {
+		if (strlen(gov->name) == len && !strcmp(gov->name, buf)) {
+			ret = cpuidle_switch_governor(gov);
+			break;
+		}
+	}
+
+	mutex_unlock(&cpuidle_lock);
+
+	if (ret)
+		return ret;
+	else
+		return count;
+}
+
+static SYSDEV_ATTR(current_driver, 0444, show_current_driver, NULL);
+static SYSDEV_ATTR(current_governor_ro, 0444, show_current_governor, NULL);
+
+static struct attribute *cpuclass_default_attrs[] = {
+	&attr_current_driver.attr,
+	&attr_current_governor_ro.attr,
+	NULL
+};
+
+static SYSDEV_ATTR(available_governors, 0444, show_available_governors, NULL);
+static SYSDEV_ATTR(current_governor, 0644, show_current_governor,
+	store_current_governor);
+
+static struct attribute *cpuclass_switch_attrs[] = {
+	&attr_available_governors.attr,
+	&attr_current_driver.attr,
+	&attr_current_governor.attr,
+	NULL
+};
+
+static struct attribute_group cpuclass_attr_group = {
+	.attrs = cpuclass_default_attrs,
+	.name = "cpuidle",
+};
+
+/**
+ * cpuidle_add_class_sysfs - add CPU global sysfs attributes
+ */
+int cpuidle_add_class_sysfs(struct sysdev_class *cls)
+{
+	if (sysfs_switch)
+		cpuclass_attr_group.attrs = cpuclass_switch_attrs;
+
+	return sysfs_create_group(&cls->kset.kobj, &cpuclass_attr_group);
+}
+
+/**
+ * cpuidle_remove_class_sysfs - remove CPU global sysfs attributes
+ */
+void cpuidle_remove_class_sysfs(struct sysdev_class *cls)
+{
+	sysfs_remove_group(&cls->kset.kobj, &cpuclass_attr_group);
+}
+
+struct cpuidle_attr {
+	struct attribute attr;
+	ssize_t (*show)(struct cpuidle_device *, char *);
+	ssize_t (*store)(struct cpuidle_device *, const char *, size_t count);
+};
+
+#define define_one_ro(_name, show) \
+	static struct cpuidle_attr attr_##_name = __ATTR(_name, 0444, show, NULL)
+#define define_one_rw(_name, show, store) \
+	static struct cpuidle_attr attr_##_name = __ATTR(_name, 0644, show, store)
+
+#define kobj_to_cpuidledev(k) container_of(k, struct cpuidle_device, kobj)
+#define attr_to_cpuidleattr(a) container_of(a, struct cpuidle_attr, attr)
+static ssize_t cpuidle_show(struct kobject * kobj, struct attribute * attr ,char * buf)
+{
+	int ret = -EIO;
+	struct cpuidle_device *dev = kobj_to_cpuidledev(kobj);
+	struct cpuidle_attr * cattr = attr_to_cpuidleattr(attr);
+
+	if (cattr->show) {
+		mutex_lock(&cpuidle_lock);
+		ret = cattr->show(dev, buf);
+		mutex_unlock(&cpuidle_lock);
+	}
+	return ret;
+}
+
+static ssize_t cpuidle_store(struct kobject * kobj, struct attribute * attr,
+		     const char * buf, size_t count)
+{
+	int ret = -EIO;
+	struct cpuidle_device *dev = kobj_to_cpuidledev(kobj);
+	struct cpuidle_attr * cattr = attr_to_cpuidleattr(attr);
+
+	if (cattr->store) {
+		mutex_lock(&cpuidle_lock);
+		ret = cattr->store(dev, buf, count);
+		mutex_unlock(&cpuidle_lock);
+	}
+	return ret;
+}
+
+static struct sysfs_ops cpuidle_sysfs_ops = {
+	.show = cpuidle_show,
+	.store = cpuidle_store,
+};
+
+static void cpuidle_sysfs_release(struct kobject *kobj)
+{
+	struct cpuidle_device *dev = kobj_to_cpuidledev(kobj);
+
+	complete(&dev->kobj_unregister);
+}
+
+static struct kobj_type ktype_cpuidle = {
+	.sysfs_ops = &cpuidle_sysfs_ops,
+	.release = cpuidle_sysfs_release,
+};
+
+struct cpuidle_state_attr {
+	struct attribute attr;
+	ssize_t (*show)(struct cpuidle_state *, char *);
+	ssize_t (*store)(struct cpuidle_state *, const char *, size_t);
+};
+
+#define define_one_state_ro(_name, show) \
+static struct cpuidle_state_attr attr_##_name = __ATTR(_name, 0444, show, NULL)
+
+#define define_show_state_function(_name) \
+static ssize_t show_state_##_name(struct cpuidle_state *state, char *buf) \
+{ \
+	return sprintf(buf, "%u\n", state->_name);\
+}
+
+static ssize_t show_state_name(struct cpuidle_state *state, char *buf)
+{
+	return sprintf(buf, "%s\n", state->name);
+}
+
+define_show_state_function(exit_latency)
+define_show_state_function(power_usage)
+define_show_state_function(usage)
+define_show_state_function(time)
+define_one_state_ro(name, show_state_name);
+define_one_state_ro(latency, show_state_exit_latency);
+define_one_state_ro(power, show_state_power_usage);
+define_one_state_ro(usage, show_state_usage);
+define_one_state_ro(time, show_state_time);
+
+static struct attribute *cpuidle_state_default_attrs[] = {
+	&attr_name.attr,
+	&attr_latency.attr,
+	&attr_power.attr,
+	&attr_usage.attr,
+	&attr_time.attr,
+	NULL
+};
+
+#define kobj_to_state_obj(k) container_of(k, struct cpuidle_state_kobj, kobj)
+#define kobj_to_state(k) (kobj_to_state_obj(k)->state)
+#define attr_to_stateattr(a) container_of(a, struct cpuidle_state_attr, attr)
+static ssize_t cpuidle_state_show(struct kobject * kobj,
+	struct attribute * attr ,char * buf)
+{
+	int ret = -EIO;
+	struct cpuidle_state *state = kobj_to_state(kobj);
+	struct cpuidle_state_attr * cattr = attr_to_stateattr(attr);
+
+	if (cattr->show)
+		ret = cattr->show(state, buf);
+
+	return ret;
+}
+
+static struct sysfs_ops cpuidle_state_sysfs_ops = {
+	.show = cpuidle_state_show,
+};
+
+static void cpuidle_state_sysfs_release(struct kobject *kobj)
+{
+	struct cpuidle_state_kobj *state_obj = kobj_to_state_obj(kobj);
+
+	complete(&state_obj->kobj_unregister);
+}
+
+static struct kobj_type ktype_state_cpuidle = {
+	.sysfs_ops = &cpuidle_state_sysfs_ops,
+	.default_attrs = cpuidle_state_default_attrs,
+	.release = cpuidle_state_sysfs_release,
+};
+
+static void inline cpuidle_free_state_kobj(struct cpuidle_device *device, int i)
+{
+	kobject_unregister(&device->kobjs[i]->kobj);
+	wait_for_completion(&device->kobjs[i]->kobj_unregister);
+	kfree(device->kobjs[i]);
+	device->kobjs[i] = NULL;
+}
+
+/**
+ * cpuidle_add_driver_sysfs - adds driver-specific sysfs attributes
+ * @device: the target device
+ */
+int cpuidle_add_state_sysfs(struct cpuidle_device *device)
+{
+	int i, ret = -ENOMEM;
+	struct cpuidle_state_kobj *kobj;
+
+	/* state statistics */
+	for (i = 0; i < device->state_count; i++) {
+		kobj = kzalloc(sizeof(struct cpuidle_state_kobj), GFP_KERNEL);
+		if (!kobj)
+			goto error_state;
+		kobj->state = &device->states[i];
+		init_completion(&kobj->kobj_unregister);
+
+		kobj->kobj.parent = &device->kobj;
+		kobj->kobj.ktype = &ktype_state_cpuidle;
+		kobject_set_name(&kobj->kobj, "state%d", i);
+		ret = kobject_register(&kobj->kobj);
+		if (ret) {
+			kfree(kobj);
+			goto error_state;
+		}
+		device->kobjs[i] = kobj;
+	}
+
+	return 0;
+
+error_state:
+	for (i = i - 1; i >= 0; i--)
+		cpuidle_free_state_kobj(device, i);
+	return ret;
+}
+
+/**
+ * cpuidle_remove_driver_sysfs - removes driver-specific sysfs attributes
+ * @device: the target device
+ */
+void cpuidle_remove_state_sysfs(struct cpuidle_device *device)
+{
+	int i;
+
+	for (i = 0; i < device->state_count; i++)
+		cpuidle_free_state_kobj(device, i);
+}
+
+/**
+ * cpuidle_add_sysfs - creates a sysfs instance for the target device
+ * @sysdev: the target device
+ */
+int cpuidle_add_sysfs(struct sys_device *sysdev)
+{
+	int cpu = sysdev->id;
+	struct cpuidle_device *dev;
+
+	dev = per_cpu(cpuidle_devices, cpu);
+	dev->kobj.parent = &sysdev->kobj;
+	dev->kobj.ktype = &ktype_cpuidle;
+	kobject_set_name(&dev->kobj, "%s", "cpuidle");
+	return kobject_register(&dev->kobj);
+}
+
+/**
+ * cpuidle_remove_sysfs - deletes a sysfs instance on the target device
+ * @sysdev: the target device
+ */
+void cpuidle_remove_sysfs(struct sys_device *sysdev)
+{
+	int cpu = sysdev->id;
+	struct cpuidle_device *dev;
+
+	dev = per_cpu(cpuidle_devices, cpu);
+	kobject_unregister(&dev->kobj);
+}
diff -urN linux-2.6.22/drivers/Makefile linux-cpuidle/drivers/Makefile
--- linux-2.6.22/drivers/Makefile	2007-07-19 20:05:59.000000000 -0400
+++ linux-cpuidle/drivers/Makefile	2007-07-17 04:19:17.000000000 -0400
@@ -70,6 +70,7 @@
 obj-$(CONFIG_MCA)		+= mca/
 obj-$(CONFIG_EISA)		+= eisa/
 obj-$(CONFIG_CPU_FREQ)		+= cpufreq/
+obj-$(CONFIG_CPU_IDLE)		+= cpuidle/
 obj-$(CONFIG_MMC)		+= mmc/
 obj-$(CONFIG_NEW_LEDS)		+= leds/
 obj-$(CONFIG_INFINIBAND)	+= infiniband/
diff -urN linux-2.6.22/include/acpi/processor.h linux-cpuidle/include/acpi/processor.h
--- linux-2.6.22/include/acpi/processor.h	2007-07-19 20:05:59.000000000 -0400
+++ linux-cpuidle/include/acpi/processor.h	2007-07-17 04:19:22.000000000 -0400
@@ -3,6 +3,7 @@
 
 #include <linux/kernel.h>
 #include <linux/cpu.h>
+#include <linux/cpuidle.h>
 
 #include <asm/acpi.h>
 
@@ -73,6 +74,7 @@
 };
 
 struct acpi_processor_power {
+	struct cpuidle_device dev;
 	struct acpi_processor_cx *state;
 	unsigned long bm_check_timestamp;
 	u32 default_state;
@@ -161,6 +163,7 @@
 	u8 bm_check:1;
 	u8 has_cst:1;
 	u8 power_setup_done:1;
+	u8 bm_rld_set:1;
 };
 
 struct acpi_processor {
@@ -279,6 +282,7 @@
 int acpi_processor_cst_has_changed(struct acpi_processor *pr);
 int acpi_processor_power_exit(struct acpi_processor *pr,
 			      struct acpi_device *device);
+extern struct cpuidle_driver acpi_idle_driver;
 
 /* in processor_thermal.c */
 int acpi_processor_get_limit_info(struct acpi_processor *pr);
diff -urN linux-2.6.22/include/linux/cpuidle.h linux-cpuidle/include/linux/cpuidle.h
--- linux-2.6.22/include/linux/cpuidle.h	1969-12-31 19:00:00.000000000 -0500
+++ linux-cpuidle/include/linux/cpuidle.h	2007-07-19 20:05:45.000000000 -0400
@@ -0,0 +1,184 @@
+/*
+ * cpuidle.h - a generic framework for CPU idle power management
+ *
+ * (C) 2007 Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>
+ *          Shaohua Li <shaohua.li@intel.com>
+ *          Adam Belay <abelay@novell.com>
+ *
+ * This code is licenced under the GPL.
+ */
+
+#ifndef _LINUX_CPUIDLE_H
+#define _LINUX_CPUIDLE_H
+
+#include <linux/percpu.h>
+#include <linux/list.h>
+#include <linux/module.h>
+#include <linux/kobject.h>
+#include <linux/completion.h>
+
+#define CPUIDLE_STATE_MAX	8
+#define CPUIDLE_NAME_LEN	16
+
+struct cpuidle_device;
+
+
+/****************************
+ * CPUIDLE DEVICE INTERFACE *
+ ****************************/
+
+struct cpuidle_state {
+	char		name[CPUIDLE_NAME_LEN];
+	void		*driver_data;
+
+	unsigned int	flags;
+	unsigned int	exit_latency; /* in US */
+	unsigned int	power_usage; /* in mW */
+	unsigned int	target_residency; /* in US */
+
+	unsigned int	usage;
+	unsigned int	time; /* in US */
+
+	int (*enter)	(struct cpuidle_device *dev,
+			 struct cpuidle_state *state);
+};
+
+/* Idle State Flags */
+#define CPUIDLE_FLAG_TIME_VALID	(0x01) /* is residency time measurable? */
+#define CPUIDLE_FLAG_CHECK_BM	(0x02) /* BM activity will exit state */
+#define CPUIDLE_FLAG_SHALLOW	(0x10) /* low latency, minimal savings */
+#define CPUIDLE_FLAG_BALANCED	(0x20) /* medium latency, moderate savings */
+#define CPUIDLE_FLAG_DEEP	(0x40) /* high latency, large savings */
+
+#define CPUIDLE_DRIVER_FLAGS_MASK (0xFFFF0000)
+
+/**
+ * cpuidle_get_statedata - retrieves private driver state data
+ * @state: the state
+ */
+static inline void * cpuidle_get_statedata(struct cpuidle_state *state)
+{
+	return state->driver_data;
+}
+
+/**
+ * cpuidle_set_statedata - stores private driver state data
+ * @state: the state
+ * @data: the private data
+ */
+static inline void
+cpuidle_set_statedata(struct cpuidle_state *state, void *data)
+{
+	state->driver_data = data;
+}
+
+struct cpuidle_state_kobj {
+	struct cpuidle_state *state;
+	struct completion kobj_unregister;
+	struct kobject kobj;
+};
+
+struct cpuidle_device {
+	int			enabled:1;
+	unsigned int		cpu;
+
+	int			last_residency;
+	int			state_count;
+	struct cpuidle_state	states[CPUIDLE_STATE_MAX];
+	struct cpuidle_state_kobj *kobjs[CPUIDLE_STATE_MAX];
+	struct cpuidle_state	*last_state;
+
+	struct list_head 	device_list;
+	struct kobject		kobj;
+	struct completion	kobj_unregister;
+	void			*governor_data;
+};
+
+DECLARE_PER_CPU(struct cpuidle_device *, cpuidle_devices);
+
+/**
+ * cpuidle_get_last_residency - retrieves the last state's residency time
+ * @dev: the target CPU
+ *
+ * NOTE: this value is invalid if CPUIDLE_FLAG_TIME_VALID isn't set
+ */
+static inline int cpuidle_get_last_residency(struct cpuidle_device *dev)
+{
+	return dev->last_residency;
+}
+
+
+/****************************
+ * CPUIDLE DRIVER INTERFACE *
+ ****************************/
+
+struct cpuidle_driver {
+	char			name[CPUIDLE_NAME_LEN];
+	int  (*bm_check)	(void);
+	struct module 		*owner;
+};
+
+#ifdef CONFIG_CPU_IDLE
+
+extern int cpuidle_register_driver(struct cpuidle_driver *drv);
+extern void cpuidle_unregister_driver(struct cpuidle_driver *drv);
+extern int cpuidle_register_device(struct cpuidle_device *dev);
+extern void cpuidle_unregister_device(struct cpuidle_device *dev);
+
+extern void cpuidle_pause_and_lock(void);
+extern void cpuidle_resume_and_unlock(void);
+extern int cpuidle_enable_device(struct cpuidle_device *dev);
+extern void cpuidle_disable_device(struct cpuidle_device *dev);
+
+#else
+
+static inline int cpuidle_register_driver(struct cpuidle_driver *drv)
+{return -EIO;}
+static inline void cpuidle_unregister_driver(struct cpuidle_driver *drv) { }
+static inline int cpuidle_register_device(struct cpuidle_device *dev)
+{return -EIO;}
+static inline void cpuidle_unregister_device(struct cpuidle_device *dev) { }
+
+static void cpuidle_pause_and_lock(void) { }
+static void cpuidle_resume_and_unlock(void) { }
+static inline int cpuidle_enable_device(struct cpuidle_device *dev)
+{return -EIO;}
+static inline void cpuidle_disable_device(struct cpuidle_device *dev) { }
+
+#endif
+
+/******************************
+ * CPUIDLE GOVERNOR INTERFACE *
+ ******************************/
+
+struct cpuidle_governor {
+	char			name[CPUIDLE_NAME_LEN];
+	struct list_head 	governor_list;
+	unsigned int		rating;
+
+	int  (*enable)		(struct cpuidle_device *dev);
+	void (*disable)		(struct cpuidle_device *dev);
+
+	int  (*select)		(struct cpuidle_device *dev);
+	void (*reflect)		(struct cpuidle_device *dev);
+
+	struct module 		*owner;
+};
+
+#ifdef CONFIG_CPU_IDLE
+
+extern int cpuidle_register_governor(struct cpuidle_governor *gov);
+extern void cpuidle_unregister_governor(struct cpuidle_governor *gov);
+extern int cpuidle_get_bm_activity(void);
+
+#else
+
+static inline int cpuidle_register_governor(struct cpuidle_governor *gov)
+{return 0;}
+static inline void cpuidle_unregister_governor(struct cpuidle_governor *gov) { }
+static inline int cpuidle_get_bm_activity(void)
+{return 0;}
+
+#endif
+
+#endif /* _LINUX_CPUIDLE_H */
diff -urN linux-2.6.22/include/linux/tick.h linux-cpuidle/include/linux/tick.h
--- linux-2.6.22/include/linux/tick.h	2007-07-19 20:05:59.000000000 -0400
+++ linux-cpuidle/include/linux/tick.h	2007-07-17 22:07:33.000000000 -0400
@@ -40,6 +40,7 @@
  * @idle_sleeps:	Number of idle calls, where the sched tick was stopped
  * @idle_entrytime:	Time when the idle call was entered
  * @idle_sleeptime:	Sum of the time slept in idle with sched tick stopped
+ * @sleep_length:	Duration of the current idle sleep
  */
 struct tick_sched {
 	struct hrtimer			sched_timer;
@@ -52,6 +53,7 @@
 	unsigned long			idle_sleeps;
 	ktime_t				idle_entrytime;
 	ktime_t				idle_sleeptime;
+	ktime_t				sleep_length;
 	unsigned long			last_jiffies;
 	unsigned long			next_jiffies;
 	ktime_t				idle_expires;
@@ -100,10 +102,17 @@
 extern void tick_nohz_stop_sched_tick(void);
 extern void tick_nohz_restart_sched_tick(void);
 extern void tick_nohz_update_jiffies(void);
+extern ktime_t tick_nohz_get_sleep_length(void);
 # else
 static inline void tick_nohz_stop_sched_tick(void) { }
 static inline void tick_nohz_restart_sched_tick(void) { }
 static inline void tick_nohz_update_jiffies(void) { }
+static inline ktime_t tick_nohz_get_sleep_length(void)
+{
+	ktime_t len = { .tv64 = NSEC_PER_SEC/HZ };
+
+	return len;
+}
 # endif /* !NO_HZ */
 
 #endif
diff -urN linux-2.6.22/kernel/time/tick-sched.c linux-cpuidle/kernel/time/tick-sched.c
--- linux-2.6.22/kernel/time/tick-sched.c	2007-07-19 20:05:59.000000000 -0400
+++ linux-cpuidle/kernel/time/tick-sched.c	2007-07-17 22:07:33.000000000 -0400
@@ -153,6 +153,7 @@
 	unsigned long seq, last_jiffies, next_jiffies, delta_jiffies, flags;
 	struct tick_sched *ts;
 	ktime_t last_update, expires, now, delta;
+	struct clock_event_device *dev = __get_cpu_var(tick_cpu_device).evtdev;
 	int cpu;
 
 	local_irq_save(flags);
@@ -290,11 +291,26 @@
 out:
 	ts->next_jiffies = next_jiffies;
 	ts->last_jiffies = last_jiffies;
+	ts->sleep_length = ktime_sub(dev->next_event, now);
 end:
 	local_irq_restore(flags);
 }
 
 /**
+ * tick_nohz_get_sleep_length - return the length of the current sleep
+ *
+ * Called from power state control code with interrupts disabled
+ */
+ktime_t tick_nohz_get_sleep_length(void)
+{
+	struct tick_sched *ts = &__get_cpu_var(tick_cpu_sched);
+
+	return ts->sleep_length;
+}
+
+EXPORT_SYMBOL_GPL(tick_nohz_get_sleep_length);
+
+/**
  * nohz_restart_sched_tick - restart the idle tick from the idle task
  *
  * Restart the idle tick when the CPU is woken up from idle
