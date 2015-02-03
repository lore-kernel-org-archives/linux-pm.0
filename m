From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [PATCH 1/2] ACPI / cpuidle: Merge acpi_idle_enter_c1() and acpi_idle_enter_simple()
Date: Tue, 03 Feb 2015 22:15:06 +0100
Message-ID: <2134241.Uv7kpARlXM@vostro.rjw.lan>
References: <2355370.OryAt3A2Tj@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <2355370.OryAt3A2Tj@vostro.rjw.lan>
Sender: linux-acpi-owner@vger.kernel.org
To: Linux PM list <linux-pm@vger.kernel.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Len Brown <len.brown@intel.com>, Peter Zijlstra <peterz@infradead.org>
List-Id: linux-pm@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

acpi_idle_enter_c1() and acpi_idle_enter_simple() are close enough to
each other that they can be merged into one function which reduces
duplication of code quite a bit.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/acpi/processor_idle.c |   43 +++++-------------------------------------
 1 file changed, 6 insertions(+), 37 deletions(-)

Index: linux-pm/drivers/acpi/processor_idle.c
===================================================================
--- linux-pm.orig/drivers/acpi/processor_idle.c
+++ linux-pm/drivers/acpi/processor_idle.c
@@ -704,34 +704,6 @@ static void acpi_idle_do_entry(struct ac
 }
 
 /**
- * acpi_idle_enter_c1 - enters an ACPI C1 state-type
- * @dev: the target CPU
- * @drv: cpuidle driver containing cpuidle state info
- * @index: index of target state
- *
- * This is equivalent to the HALT instruction.
- */
-static int acpi_idle_enter_c1(struct cpuidle_device *dev,
-		struct cpuidle_driver *drv, int index)
-{
-	struct acpi_processor *pr;
-	struct acpi_processor_cx *cx = per_cpu(acpi_cstate[index], dev->cpu);
-
-	pr = __this_cpu_read(processors);
-
-	if (unlikely(!pr))
-		return -EINVAL;
-
-	lapic_timer_state_broadcast(pr, cx, 1);
-	acpi_idle_do_entry(cx);
-
-	lapic_timer_state_broadcast(pr, cx, 0);
-
-	return index;
-}
-
-
-/**
  * acpi_idle_play_dead - enters an ACPI state for long-term idle (i.e. off-lining)
  * @dev: the target CPU
  * @index: the index of suggested state
@@ -766,7 +738,7 @@ static bool acpi_idle_fallback_to_c1(str
 }
 
 /**
- * acpi_idle_enter_simple - enters an ACPI state without BM handling
+ * acpi_idle_enter_simple - enters a CPU idle state without BM handling
  * @dev: the target CPU
  * @drv: cpuidle driver with cpuidle state information
  * @index: the index of suggested state
@@ -782,8 +754,10 @@ static int acpi_idle_enter_simple(struct
 	if (unlikely(!pr))
 		return -EINVAL;
 
-	if (acpi_idle_fallback_to_c1(pr))
-		return acpi_idle_enter_c1(dev, drv, CPUIDLE_DRIVER_STATE_START);
+	if (cx->type != ACPI_STATE_C1 && acpi_idle_fallback_to_c1(pr)) {
+		index = CPUIDLE_DRIVER_STATE_START;
+		cx = per_cpu(acpi_cstate[index], dev->cpu);
+	}
 
 	lapic_timer_state_broadcast(pr, cx, 1);
 
@@ -819,7 +793,7 @@ static int acpi_idle_enter_bm(struct cpu
 		return -EINVAL;
 
 	if (acpi_idle_fallback_to_c1(pr))
-		return acpi_idle_enter_c1(dev, drv, CPUIDLE_DRIVER_STATE_START);
+		return acpi_idle_enter_simple(dev, drv, CPUIDLE_DRIVER_STATE_START);
 
 	if (!cx->bm_sts_skip && acpi_idle_bm_check()) {
 		if (drv->safe_state_index >= 0) {
@@ -967,11 +941,6 @@ static int acpi_processor_setup_cpuidle_
 		switch (cx->type) {
 
 		case ACPI_STATE_C1:
-			state->enter = acpi_idle_enter_c1;
-			state->enter_dead = acpi_idle_play_dead;
-			drv->safe_state_index = count;
-			break;
-
 		case ACPI_STATE_C2:
 			state->enter = acpi_idle_enter_simple;
 			state->enter_dead = acpi_idle_play_dead;

