From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [PATCH 6/6] ACPI / idle: Implement ->enter_freeze callback routine
Date: Wed, 11 Feb 2015 05:04:57 +0100
Message-ID: <2622717.o1c258ItSq@vostro.rjw.lan>
References: <8292243.ibkmfVtXac@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <8292243.ibkmfVtXac@vostro.rjw.lan>
Sender: linux-acpi-owner@vger.kernel.org
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Peter Zijlstra <peterz@infradead.org>, Alan Cox <alan@linux.intel.com>, "Li, Aubrey" <aubrey.li@linux.intel.com>, LKML <linux-kernel@vger.kernel.org>, Linux PM list <linux-pm@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Kristen Carlson Accardi <kristen@linux.intel.com>, John Stultz <john.stultz@linaro.org>, Len Brown <len.brown@intel.com>
List-Id: linux-pm@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Add an ->enter_freeze callback routine, acpi_idle_enter_freeze(), to
the ACPI cpuidle driver and point ->enter_freeze to it for all the
C2-type and C3-type states that don't need to fall back to C1
(which may be halt-induced and that will re-enable interrupts on
exit from idle, which ->enter_freeze cannot do).

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/acpi/processor_idle.c |   48 +++++++++++++++++++++++++++++++++++-------
 1 file changed, 40 insertions(+), 8 deletions(-)

Index: linux-pm/drivers/acpi/processor_idle.c
===================================================================
--- linux-pm.orig/drivers/acpi/processor_idle.c
+++ linux-pm/drivers/acpi/processor_idle.c
@@ -732,9 +732,8 @@ static int acpi_idle_play_dead(struct cp
 
 static bool acpi_idle_fallback_to_c1(struct acpi_processor *pr)
 {
-	return IS_ENABLED(CONFIG_HOTPLUG_CPU) && num_online_cpus() > 1 &&
-		!(acpi_gbl_FADT.flags & ACPI_FADT_C2_MP_SUPPORTED) &&
-		!pr->flags.has_cst;
+	return IS_ENABLED(CONFIG_HOTPLUG_CPU) && !pr->flags.has_cst &&
+		!(acpi_gbl_FADT.flags & ACPI_FADT_C2_MP_SUPPORTED);
 }
 
 static int c3_cpu_count;
@@ -744,9 +743,10 @@ static DEFINE_RAW_SPINLOCK(c3_lock);
  * acpi_idle_enter_bm - enters C3 with proper BM handling
  * @pr: Target processor
  * @cx: Target state context
+ * @timer_bc: Whether or not to change timer mode to broadcast
  */
 static void acpi_idle_enter_bm(struct acpi_processor *pr,
-			       struct acpi_processor_cx *cx)
+			       struct acpi_processor_cx *cx, bool timer_bc)
 {
 	acpi_unlazy_tlb(smp_processor_id());
 
@@ -754,7 +754,8 @@ static void acpi_idle_enter_bm(struct ac
 	 * Must be done before busmaster disable as we might need to
 	 * access HPET !
 	 */
-	lapic_timer_state_broadcast(pr, cx, 1);
+	if (timer_bc)
+		lapic_timer_state_broadcast(pr, cx, 1);
 
 	/*
 	 * disable bus master
@@ -784,7 +785,8 @@ static void acpi_idle_enter_bm(struct ac
 		raw_spin_unlock(&c3_lock);
 	}
 
-	lapic_timer_state_broadcast(pr, cx, 0);
+	if (timer_bc)
+		lapic_timer_state_broadcast(pr, cx, 0);
 }
 
 static int acpi_idle_enter(struct cpuidle_device *dev,
@@ -798,12 +800,12 @@ static int acpi_idle_enter(struct cpuidl
 		return -EINVAL;
 
 	if (cx->type != ACPI_STATE_C1) {
-		if (acpi_idle_fallback_to_c1(pr)) {
+		if (acpi_idle_fallback_to_c1(pr) && num_online_cpus() > 1) {
 			index = CPUIDLE_DRIVER_STATE_START;
 			cx = per_cpu(acpi_cstate[index], dev->cpu);
 		} else if (cx->type == ACPI_STATE_C3 && pr->flags.bm_check) {
 			if (cx->bm_sts_skip || !acpi_idle_bm_check()) {
-				acpi_idle_enter_bm(pr, cx);
+				acpi_idle_enter_bm(pr, cx, true);
 				return index;
 			} else if (drv->safe_state_index >= 0) {
 				index = drv->safe_state_index;
@@ -827,6 +829,27 @@ static int acpi_idle_enter(struct cpuidl
 	return index;
 }
 
+static void acpi_idle_enter_freeze(struct cpuidle_device *dev,
+				   struct cpuidle_driver *drv, int index)
+{
+	struct acpi_processor_cx *cx = per_cpu(acpi_cstate[index], dev->cpu);
+
+	if (cx->type == ACPI_STATE_C3) {
+		struct acpi_processor *pr = __this_cpu_read(processors);
+
+		if (unlikely(!pr))
+			return;
+
+		if (pr->flags.bm_check) {
+			acpi_idle_enter_bm(pr, cx, false);
+			return;
+		} else {
+			ACPI_FLUSH_CPU_CACHE();
+		}
+	}
+	acpi_idle_do_entry(cx);
+}
+
 struct cpuidle_driver acpi_idle_driver = {
 	.name =		"acpi_idle",
 	.owner =	THIS_MODULE,
@@ -925,6 +948,15 @@ static int acpi_processor_setup_cpuidle_
 			state->enter_dead = acpi_idle_play_dead;
 			drv->safe_state_index = count;
 		}
+		/*
+		 * Halt-induced C1 is not good for ->enter_freeze, because it
+		 * re-enables interrupts on exit.  Moreover, C1 is generally not
+		 * particularly interesting from the suspend-to-idle angle, so
+		 * avoid C1 and the situations in which we may need to fall back
+		 * to it altogether.
+		 */
+		if (cx->type != ACPI_STATE_C1 && !acpi_idle_fallback_to_c1(pr))
+			state->enter_freeze = acpi_idle_enter_freeze;
 
 		count++;
 		if (count == CPUIDLE_STATE_MAX)

