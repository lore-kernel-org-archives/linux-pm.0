From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: [PATCH 4/4] cpuidle : move tlb flag to the cpuidle header
Date: Thu,  5 Jul 2012 15:23:28 +0200
Message-ID: <1341494608-16591-4-git-send-email-daniel.lezcano@linaro.org>
References: <1341494608-16591-1-git-send-email-daniel.lezcano@linaro.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <1341494608-16591-1-git-send-email-daniel.lezcano@linaro.org>
Sender: linux-acpi-owner@vger.kernel.org
To: rjw@sisk.pl, lenb@kernel.org
Cc: linux-acpi@vger.kernel.org, linux-pm@lists.linux-foundation.org, linaro-dev@lists.linaro.org
List-Id: linux-pm@vger.kernel.org

Move this specific flag to the header file.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/idle/intel_idle.c |    8 --------
 include/linux/cpuidle.h   |   16 +++++++++++++---
 2 files changed, 13 insertions(+), 11 deletions(-)

diff --git a/drivers/idle/intel_idle.c b/drivers/idle/intel_idle.c
index fe95d54..3f0eb07 100644
--- a/drivers/idle/intel_idle.c
+++ b/drivers/idle/intel_idle.c
@@ -101,14 +101,6 @@ static int intel_idle_cpu_init(int cpu);
 static struct cpuidle_state *cpuidle_state_table;
 
 /*
- * Set this flag for states where the HW flushes the TLB for us
- * and so we don't need cross-calls to keep it consistent.
- * If this flag is set, SW flushes the TLB, so even if the
- * HW doesn't do the flushing, this flag is safe to use.
- */
-#define CPUIDLE_FLAG_TLB_FLUSHED	0x10000
-
-/*
  * States are indexed by the cstate number,
  * which is also the index into the MWAIT hint array.
  * Thus C0 is a dummy.
diff --git a/include/linux/cpuidle.h b/include/linux/cpuidle.h
index 730e12e..be150c9 100644
--- a/include/linux/cpuidle.h
+++ b/include/linux/cpuidle.h
@@ -67,10 +67,20 @@ struct cpuidle_state {
  *                            the cpuidle core the specified state can use the  *
  *                            enter_dead function.                              *
  *                                                                              *
+ * CPUIDLE_FLAG_TLB_FLUSHED : Set this flag for states where the HW flushes the *
+ *                            TLB for us and so we don't need cross-calls to    *
+ *                            keep it consistent. If this flag is set, SW       *
+ *                            flushes the TLB, so even if the HW doesn't do the *
+ *                            flushing, this flag is safe to use.               *
+ *                                                                              *
  *******************************************************************************/
-#define CPUIDLE_FLAG_TIME_VALID	(0x01)
-#define CPUIDLE_FLAG_COUPLED	(0x02)
-#define CPUIDLE_FLAG_DEAD_VALID (0x04)
+#define CPUIDLE_FLAG_TIME_VALID  (0x01)
+#define CPUIDLE_FLAG_COUPLED     (0x02)
+#define CPUIDLE_FLAG_DEAD_VALID  (0x04)
+#define CPUIDLE_FLAG_TLB_FLUSHED (0x08)
+
+
+
 
 /**
  * cpuidle_get_statedata - retrieves private driver state data
-- 
1.7.5.4

