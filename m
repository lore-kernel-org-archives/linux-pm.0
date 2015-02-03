From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [PATCH 2/2] ACPI / cpuidle: Common callback routine for entering states
Date: Tue, 03 Feb 2015 22:15:47 +0100
Message-ID: <2697166.UnmvnKYZSU@vostro.rjw.lan>
References: <2355370.OryAt3A2Tj@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:50498 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S932280AbbBCUxB (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 3 Feb 2015 15:53:01 -0500
In-Reply-To: <2355370.OryAt3A2Tj@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Linux PM list <linux-pm@vger.kernel.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Len Brown <len.brown@intel.com>, Peter Zijlstra <peterz@infradead.org>

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Introduce a common ->enter callback routine for the ACPI cpuidle
driver, acpi_idle_enter(), which helps to reduce code complexity,
size and duplication and prevents theoretically possible failues that
an incorrect routine may be run to enter the given idle state due to
a firmware bug (eg. when _CST returns a different set of states for
each processor).

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/acpi/processor_idle.c |  118 ++++++++++++++++--------------------------
 1 file changed, 45 insertions(+), 73 deletions(-)

Index: linux-pm/drivers/acpi/processor_idle.c
===================================================================
--- linux-pm.orig/drivers/acpi/processor_idle.c
+++ linux-pm/drivers/acpi/processor_idle.c
@@ -737,74 +737,17 @@ static bool acpi_idle_fallback_to_c1(str
 		!pr->flags.has_cst;
 }
 
-/**
- * acpi_idle_enter_simple - enters a CPU idle state without BM handling
- * @dev: the target CPU
- * @drv: cpuidle driver with cpuidle state information
- * @index: the index of suggested state
- */
-static int acpi_idle_enter_simple(struct cpuidle_device *dev,
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
-	if (cx->type != ACPI_STATE_C1 && acpi_idle_fallback_to_c1(pr)) {
-		index = CPUIDLE_DRIVER_STATE_START;
-		cx = per_cpu(acpi_cstate[index], dev->cpu);
-	}
-
-	lapic_timer_state_broadcast(pr, cx, 1);
-
-	if (cx->type == ACPI_STATE_C3)
-		ACPI_FLUSH_CPU_CACHE();
-
-	acpi_idle_do_entry(cx);
-
-	lapic_timer_state_broadcast(pr, cx, 0);
-	return index;
-}
-
 static int c3_cpu_count;
 static DEFINE_RAW_SPINLOCK(c3_lock);
 
 /**
  * acpi_idle_enter_bm - enters C3 with proper BM handling
- * @dev: the target CPU
- * @drv: cpuidle driver containing state data
- * @index: the index of suggested state
- *
- * If BM is detected, the deepest non-C3 idle state is entered instead.
+ * @pr: Target processor
+ * @cx: Target state context
  */
-static int acpi_idle_enter_bm(struct cpuidle_device *dev,
-		struct cpuidle_driver *drv, int index)
+static void acpi_idle_enter_bm(struct acpi_processor *pr,
+			       struct acpi_processor_cx *cx)
 {
-	struct acpi_processor *pr;
-	struct acpi_processor_cx *cx = per_cpu(acpi_cstate[index], dev->cpu);
-
-	pr = __this_cpu_read(processors);
-
-	if (unlikely(!pr))
-		return -EINVAL;
-
-	if (acpi_idle_fallback_to_c1(pr))
-		return acpi_idle_enter_simple(dev, drv, CPUIDLE_DRIVER_STATE_START);
-
-	if (!cx->bm_sts_skip && acpi_idle_bm_check()) {
-		if (drv->safe_state_index >= 0) {
-			return drv->states[drv->safe_state_index].enter(dev,
-						drv, drv->safe_state_index);
-		} else {
-			acpi_safe_halt();
-			return -EBUSY;
-		}
-	}
-
 	acpi_unlazy_tlb(smp_processor_id());
 
 	/*
@@ -842,6 +785,45 @@ static int acpi_idle_enter_bm(struct cpu
 	}
 
 	lapic_timer_state_broadcast(pr, cx, 0);
+}
+
+static int acpi_idle_enter(struct cpuidle_device *dev,
+			   struct cpuidle_driver *drv, int index)
+{
+	struct acpi_processor_cx *cx = per_cpu(acpi_cstate[index], dev->cpu);
+	struct acpi_processor *pr;
+
+	pr = __this_cpu_read(processors);
+	if (unlikely(!pr))
+		return -EINVAL;
+
+	if (cx->type != ACPI_STATE_C1) {
+		if (acpi_idle_fallback_to_c1(pr)) {
+			index = CPUIDLE_DRIVER_STATE_START;
+			cx = per_cpu(acpi_cstate[index], dev->cpu);
+		} else if (cx->type == ACPI_STATE_C3 && pr->flags.bm_check) {
+			if (cx->bm_sts_skip || !acpi_idle_bm_check()) {
+				acpi_idle_enter_bm(pr, cx);
+				return index;
+			} else if (drv->safe_state_index >= 0) {
+				index = drv->safe_state_index;
+				cx = per_cpu(acpi_cstate[index], dev->cpu);
+			} else {
+				acpi_safe_halt();
+				return -EBUSY;
+			}
+		}
+	}
+
+	lapic_timer_state_broadcast(pr, cx, 1);
+
+	if (cx->type == ACPI_STATE_C3)
+		ACPI_FLUSH_CPU_CACHE();
+
+	acpi_idle_do_entry(cx);
+
+	lapic_timer_state_broadcast(pr, cx, 0);
+
 	return index;
 }
 
@@ -936,22 +918,12 @@ static int acpi_processor_setup_cpuidle_
 		strncpy(state->desc, cx->desc, CPUIDLE_DESC_LEN);
 		state->exit_latency = cx->latency;
 		state->target_residency = cx->latency * latency_factor;
+		state->enter = acpi_idle_enter;
 
 		state->flags = 0;
-		switch (cx->type) {
-
-		case ACPI_STATE_C1:
-		case ACPI_STATE_C2:
-			state->enter = acpi_idle_enter_simple;
+		if (cx->type == ACPI_STATE_C1 || cx->type == ACPI_STATE_C2) {
 			state->enter_dead = acpi_idle_play_dead;
 			drv->safe_state_index = count;
-			break;
-
-		case ACPI_STATE_C3:
-			state->enter = pr->flags.bm_check ?
-					acpi_idle_enter_bm :
-					acpi_idle_enter_simple;
-			break;
 		}
 
 		count++;

