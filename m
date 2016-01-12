From: Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>
Subject: [PATCH RESEND v4 3/4] cpufreq: powernv: Add a trace print for the throttle event
Date: Tue, 12 Jan 2016 04:24:26 -0600
Message-ID: <1452594267-12844-4-git-send-email-shilpa.bhat@linux.vnet.ibm.com>
References: <1452594267-12844-1-git-send-email-shilpa.bhat@linux.vnet.ibm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1452594267-12844-1-git-send-email-shilpa.bhat@linux.vnet.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org
Cc: rjw@rjwysocki.net, viresh.kumar@linaro.org, linux-pm@vger.kernel.org, pc@us.ibm.com, anton@samba.org, ego@linux.vnet.ibm.com, shreyas@linux.vnet.ibm.com, Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>
List-Id: linux-pm@vger.kernel.org

Record the throttle event with a trace print replacing the printk,
except for events like throttling below nominal and occ reset
event which print a warning message.

Signed-off-by: Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>
---
Changes from v3:
- Separate this patch to contain trace_point changes
- Move struct chip member 'restore' of type bool above 'mask' to reduce
  structure padding.

No changes from v2.

Changes from v1:
- As suggested by Paul Clarke replaced char * throttle_reason[][30] by 
  const char * const throttle_reason[].

 drivers/cpufreq/powernv-cpufreq.c | 95 ++++++++++++++++++++-------------------
 1 file changed, 49 insertions(+), 46 deletions(-)

diff --git a/drivers/cpufreq/powernv-cpufreq.c b/drivers/cpufreq/powernv-cpufreq.c
index 597a084..c98a6e7 100644
--- a/drivers/cpufreq/powernv-cpufreq.c
+++ b/drivers/cpufreq/powernv-cpufreq.c
@@ -28,6 +28,7 @@
 #include <linux/of.h>
 #include <linux/reboot.h>
 #include <linux/slab.h>
+#include <trace/events/power.h>
 
 #include <asm/cputhreads.h>
 #include <asm/firmware.h>
@@ -44,12 +45,22 @@
 static struct cpufreq_frequency_table powernv_freqs[POWERNV_MAX_PSTATES+1];
 static bool rebooting, throttled, occ_reset;
 
+static const char * const throttle_reason[] = {
+	"No throttling",
+	"Power Cap",
+	"Processor Over Temperature",
+	"Power Supply Failure",
+	"Over Current",
+	"OCC Reset"
+};
+
 static struct chip {
 	unsigned int id;
 	bool throttled;
+	bool restore;
+	u8 throt_reason;
 	cpumask_t mask;
 	struct work_struct throttle;
-	bool restore;
 } *chips;
 
 static int nr_chips;
@@ -310,41 +321,49 @@ static inline unsigned int get_nominal_index(void)
 	return powernv_pstate_info.max - powernv_pstate_info.nominal;
 }
 
-static void powernv_cpufreq_throttle_check(void *data)
+static void powernv_cpufreq_check_pmax(void)
 {
 	unsigned int cpu = smp_processor_id();
 	unsigned int chip_id = pir_to_chip_id(hard_smp_processor_id());
-	unsigned long pmsr;
 	int pmsr_pmax, i;
 
-	pmsr = get_pmspr(SPRN_PMSR);
+	pmsr_pmax = (s8)PMSR_MAX(get_pmspr(SPRN_PMSR));
 
 	for (i = 0; i < nr_chips; i++)
 		if (chips[i].id == chip_id)
 			break;
 
-	/* Check for Pmax Capping */
-	pmsr_pmax = (s8)PMSR_MAX(pmsr);
 	if (pmsr_pmax != powernv_pstate_info.max) {
 		if (chips[i].throttled)
-			goto next;
+			return;
+
 		chips[i].throttled = true;
 		if (pmsr_pmax < powernv_pstate_info.nominal)
-			pr_crit("CPU %d on Chip %u has Pmax reduced below nominal frequency (%d < %d)\n",
-				cpu, chips[i].id, pmsr_pmax,
-				powernv_pstate_info.nominal);
-		else
-			pr_info("CPU %d on Chip %u has Pmax reduced below turbo frequency (%d < %d)\n",
-				cpu, chips[i].id, pmsr_pmax,
-				powernv_pstate_info.max);
+			pr_warn_once("CPU %d on Chip %u has Pmax reduced below nominal frequency (%d < %d)\n",
+				     cpu, chips[i].id, pmsr_pmax,
+				     powernv_pstate_info.nominal);
+
+		trace_powernv_throttle(chips[i].id,
+				       throttle_reason[chips[i].throt_reason],
+				       pmsr_pmax);
 	} else if (chips[i].throttled) {
 		chips[i].throttled = false;
-		pr_info("CPU %d on Chip %u has Pmax restored to %d\n", cpu,
-			chips[i].id, pmsr_pmax);
+		trace_powernv_throttle(chips[i].id,
+				       throttle_reason[chips[i].throt_reason],
+				       pmsr_pmax);
 	}
+}
+
+static void powernv_cpufreq_throttle_check(void *data)
+{
+	unsigned long pmsr;
+
+	pmsr = get_pmspr(SPRN_PMSR);
+
+	/* Check for Pmax Capping */
+	powernv_cpufreq_check_pmax();
 
 	/* Check if Psafe_mode_active is set in PMSR. */
-next:
 	if (pmsr & PMSR_PSAFE_ENABLE) {
 		throttled = true;
 		pr_info("Pstate set to safe frequency\n");
@@ -358,7 +377,7 @@ next:
 
 	if (throttled) {
 		pr_info("PMSR = %16lx\n", pmsr);
-		pr_crit("CPU Frequency could be throttled\n");
+		pr_warn("CPU Frequency could be throttled\n");
 	}
 }
 
@@ -449,15 +468,6 @@ void powernv_cpufreq_work_fn(struct work_struct *work)
 	}
 }
 
-static char throttle_reason[][30] = {
-					"No throttling",
-					"Power Cap",
-					"Processor Over Temperature",
-					"Power Supply Failure",
-					"Over Current",
-					"OCC Reset"
-				     };
-
 static int powernv_cpufreq_occ_msg(struct notifier_block *nb,
 				   unsigned long msg_type, void *_msg)
 {
@@ -483,7 +493,7 @@ static int powernv_cpufreq_occ_msg(struct notifier_block *nb,
 		 */
 		if (!throttled) {
 			throttled = true;
-			pr_crit("CPU frequency is throttled for duration\n");
+			pr_warn("CPU frequency is throttled for duration\n");
 		}
 
 		break;
@@ -507,23 +517,18 @@ static int powernv_cpufreq_occ_msg(struct notifier_block *nb,
 			return 0;
 		}
 
-		if (omsg.throttle_status &&
+		for (i = 0; i < nr_chips; i++)
+			if (chips[i].id == omsg.chip)
+				break;
+
+		if (omsg.throttle_status >= 0 &&
 		    omsg.throttle_status <= OCC_MAX_THROTTLE_STATUS)
-			pr_info("OCC: Chip %u Pmax reduced due to %s\n",
-				(unsigned int)omsg.chip,
-				throttle_reason[omsg.throttle_status]);
-		else if (!omsg.throttle_status)
-			pr_info("OCC: Chip %u %s\n", (unsigned int)omsg.chip,
-				throttle_reason[omsg.throttle_status]);
-		else
-			return 0;
+			chips[i].throt_reason = omsg.throttle_status;
 
-		for (i = 0; i < nr_chips; i++)
-			if (chips[i].id == omsg.chip) {
-				if (!omsg.throttle_status)
-					chips[i].restore = true;
-				schedule_work(&chips[i].throttle);
-			}
+		if (!omsg.throttle_status)
+			chips[i].restore = true;
+
+		schedule_work(&chips[i].throttle);
 	}
 	return 0;
 }
@@ -569,16 +574,14 @@ static int init_chip_info(void)
 		}
 	}
 
-	chips = kmalloc_array(nr_chips, sizeof(struct chip), GFP_KERNEL);
+	chips = kcalloc(nr_chips, sizeof(struct chip), GFP_KERNEL);
 	if (!chips)
 		return -ENOMEM;
 
 	for (i = 0; i < nr_chips; i++) {
 		chips[i].id = chip[i];
-		chips[i].throttled = false;
 		cpumask_copy(&chips[i].mask, cpumask_of_node(chip[i]));
 		INIT_WORK(&chips[i].throttle, powernv_cpufreq_work_fn);
-		chips[i].restore = false;
 	}
 
 	return 0;
-- 
1.9.1
