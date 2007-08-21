From: Adam Belay <abelay@novell.com>
Subject: [PATCH 3/6] CPUIDLE: handle BM detection inside the ACPI
	Processor driver
Date: Tue, 21 Aug 2007 18:25:40 -0400
Message-ID: <1187735140.7199.51.camel__20000.3320155249$1187740243$gmane$org@callisto.site>
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
To: Brown@smtp2.linux-foundation.org, Len <len.brown@intel.com>
Cc: linux acpi <linux-acpi@vger.kernel.org>, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

This patch updates the ACPI processor driver to detect BM activity and
limit state entry depth internally, rather than exposing such
requirements to CPUIDLE.  As a result, CPUIDLE can drop this
ACPI-specific interface and become more platform independent.  BM
activity is now handled much more aggressively than it was in the
original implementation, so some testing coverage may be needed to
verify that this doesn't introduce any DMA buffer under-run issues.

Please Apply,
Adam

Change Summary:
 drivers/acpi/processor_idle.c |  124 ++++++++++++++++++++++--------------------
 include/acpi/processor.h      |    1
 2 files changed, 67 insertions(+), 58 deletions(-)
---

diff -urN a/drivers/acpi/processor_idle.c b/drivers/acpi/processor_idle.c
--- a/drivers/acpi/processor_idle.c	2007-08-13 00:02:10.000000000 -0400
+++ b/drivers/acpi/processor_idle.c	2007-08-14 14:58:19.000000000 -0400
@@ -708,6 +708,29 @@
 }
 
 /**
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
+/**
  * acpi_idle_update_bm_rld - updates the BM_RLD bit depending on target state
  * @pr: the processor
  * @target: the new target state
@@ -782,12 +805,12 @@
 }
 
 /**
- * acpi_idle_enter_c2 - enters an ACPI C2 state-type
+ * acpi_idle_enter_simple - enters an ACPI state without BM handling
  * @dev: the target CPU
  * @state: the state data
  */
-static int acpi_idle_enter_c2(struct cpuidle_device *dev,
-			      struct cpuidle_state *state)
+static int acpi_idle_enter_simple(struct cpuidle_device *dev,
+				  struct cpuidle_state *state)
 {
 	struct acpi_processor *pr;
 	struct acpi_processor_cx *cx = cpuidle_get_statedata(state);
@@ -814,14 +837,17 @@
 		return 0;
 	}
 
+	if (cx->type == ACPI_STATE_C3)
+		ACPI_FLUSH_CPU_CACHE();
+
 	t1 = inl(acpi_gbl_FADT.xpm_timer_block.address);
 	acpi_state_timer_broadcast(pr, cx, 1);
 	acpi_idle_do_entry(cx);
 	t2 = inl(acpi_gbl_FADT.xpm_timer_block.address);
 
 #if defined (CONFIG_GENERIC_TIME) && defined (CONFIG_X86_TSC)
-	/* TSC halts in C2, so notify users */
-	mark_tsc_unstable("possible TSC halt in C2");
+	/* TSC could halt in idle, so notify users */
+	mark_tsc_unstable("TSC halts in idle");;
 #endif
 
 	local_irq_enable();
@@ -838,13 +864,13 @@
 static DEFINE_SPINLOCK(c3_lock);
 
 /**
- * acpi_idle_enter_c3 - enters an ACPI C3 state-type
+ * acpi_idle_enter_bm - enters C3 with proper BM handling
  * @dev: the target CPU
  * @state: the state data
  *
- * Similar to C2 entry, except special bus master handling is needed.
+ * If BM is detected, the deepest non-C3 idle state is entered instead.
  */
-static int acpi_idle_enter_c3(struct cpuidle_device *dev,
+static int acpi_idle_enter_bm(struct cpuidle_device *dev,
 			      struct cpuidle_state *state)
 {
 	struct acpi_processor *pr;
@@ -855,9 +881,6 @@
 	if (unlikely(!pr))
 		return 0;
 
-	if (pr->flags.bm_check)
-		acpi_idle_update_bm_rld(pr, cx);
-
 	local_irq_disable();
 	current_thread_info()->status &= ~TS_POLLING;
 	/*
@@ -878,31 +901,30 @@
 	 */
 	acpi_state_timer_broadcast(pr, cx, 1);
 
-	/* disable bus master */
-	if (pr->flags.bm_check) {
+	if (acpi_idle_bm_check()) {
+		cx = pr->power.bm_state;
+
+		acpi_idle_update_bm_rld(pr, cx);
+
+		t1 = inl(acpi_gbl_FADT.xpm_timer_block.address);
+		acpi_idle_do_entry(cx);
+		t2 = inl(acpi_gbl_FADT.xpm_timer_block.address);
+	} else {
+		acpi_idle_update_bm_rld(pr, cx);
+
 		spin_lock(&c3_lock);
-			c3_cpu_count++;
-		if (c3_cpu_count == num_online_cpus()) {
-			/*
-			 * All CPUs are trying to go to C3
-			 * Disable bus master arbitration
-			 */
+		c3_cpu_count++;
+		/* Disable bus master arbitration when all CPUs are in C3 */
+		if (c3_cpu_count == num_online_cpus())
 			acpi_set_register(ACPI_BITREG_ARB_DISABLE, 1);
-		}
 		spin_unlock(&c3_lock);
-	} else {
-		/* SMP with no shared cache... Invalidate cache  */
-		ACPI_FLUSH_CPU_CACHE();
-	}
 
-	/* Get start time (ticks) */
-	t1 = inl(acpi_gbl_FADT.xpm_timer_block.address);
-	acpi_idle_do_entry(cx);
-	t2 = inl(acpi_gbl_FADT.xpm_timer_block.address);
+		t1 = inl(acpi_gbl_FADT.xpm_timer_block.address);
+		acpi_idle_do_entry(cx);
+		t2 = inl(acpi_gbl_FADT.xpm_timer_block.address);
 
-	if (pr->flags.bm_check) {
 		spin_lock(&c3_lock);
-		/* Enable bus master arbitration */
+		/* Re-enable bus master arbitration */
 		if (c3_cpu_count == num_online_cpus())
 			acpi_set_register(ACPI_BITREG_ARB_DISABLE, 0);
 		c3_cpu_count--;
@@ -910,8 +932,8 @@
 	}
 
 #if defined (CONFIG_GENERIC_TIME) && defined (CONFIG_X86_TSC)
-	/* TSC halts in C3, so notify users */
-	mark_tsc_unstable("TSC halts in C3");
+	/* TSC could halt in idle, so notify users */
+	mark_tsc_unstable("TSC halts in idle");
 #endif
 
 	local_irq_enable();
@@ -924,32 +946,8 @@
 	return ticks_elapsed_in_us(t1, t2);
 }
 
-/**
- * acpi_idle_bm_check - checks if bus master activity was detected
- */
-static int acpi_idle_bm_check(void)
-{
-	u32 bm_status = 0;
-
-	acpi_get_register(ACPI_BITREG_BUS_MASTER_STATUS, &bm_status);
-	if (bm_status)
-		acpi_set_register(ACPI_BITREG_BUS_MASTER_STATUS, 1);
-	/*
-	 * PIIX4 Erratum #18: Note that BM_STS doesn't always reflect
-	 * the true state of bus mastering activity; forcing us to
-	 * manually check the BMIDEA bit of each IDE channel.
-	 */
-	else if (errata.piix4.bmisx) {
-		if ((inb_p(errata.piix4.bmisx + 0x02) & 0x01)
-		    || (inb_p(errata.piix4.bmisx + 0x0A) & 0x01))
-			bm_status = 1;
-	}
-	return bm_status;
-}
-
 struct cpuidle_driver acpi_idle_driver = {
 	.name =		"acpi_idle",
-	.bm_check =	acpi_idle_bm_check,
 	.owner =	THIS_MODULE,
 };
 
@@ -1001,14 +999,16 @@
 			case ACPI_STATE_C2:
 			state->flags |= CPUIDLE_FLAG_BALANCED;
 			state->flags |= CPUIDLE_FLAG_TIME_VALID;
-			state->enter = acpi_idle_enter_c2;
+			state->enter = acpi_idle_enter_simple;
 			break;
 
 			case ACPI_STATE_C3:
 			state->flags |= CPUIDLE_FLAG_DEEP;
 			state->flags |= CPUIDLE_FLAG_TIME_VALID;
 			state->flags |= CPUIDLE_FLAG_CHECK_BM;
-			state->enter = acpi_idle_enter_c3;
+			state->enter = pr->flags.bm_check ?
+					acpi_idle_enter_bm :
+					acpi_idle_enter_simple;
 			break;
 		}
 
@@ -1020,6 +1020,14 @@
 	if (!count)
 		return -EINVAL;
 
+	/* find the deepest state that can handle active BM */
+	if (pr->flags.bm_check) {
+		for (i = 1; i < ACPI_PROCESSOR_MAX_POWER && i <= max_cstate; i++)
+			if (pr->power.states[i].type == ACPI_STATE_C3)
+				break;
+		pr->power.bm_state = &pr->power.states[i-1];
+	}
+
 	return 0;
 }
 
diff -urN a/include/acpi/processor.h b/include/acpi/processor.h
--- a/include/acpi/processor.h	2007-08-13 00:02:10.000000000 -0400
+++ b/include/acpi/processor.h	2007-08-14 14:25:32.000000000 -0400
@@ -78,6 +78,7 @@
 struct acpi_processor_power {
 	struct cpuidle_device dev;
 	struct acpi_processor_cx *state;
+	struct acpi_processor_cx *bm_state;
 	unsigned long bm_check_timestamp;
 	u32 default_state;
 	u32 bm_activity;
