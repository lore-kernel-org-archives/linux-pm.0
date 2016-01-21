From: Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>
Subject: [PATCH v5 4/5] cpufreq: powernv: Replace pr_info with trace print for throttle event
Date: Thu, 21 Jan 2016 15:08:58 +0530
Message-ID: <1453369139-10203-5-git-send-email-shilpa.bhat@linux.vnet.ibm.com>
References: <1453369139-10203-1-git-send-email-shilpa.bhat@linux.vnet.ibm.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from e23smtp05.au.ibm.com ([202.81.31.147]:34133 "EHLO
	e23smtp05.au.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759260AbcAUJkV (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 21 Jan 2016 04:40:21 -0500
Received: from localhost
	by e23smtp05.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-pm@vger.kernel.org> from <shilpa.bhat@linux.vnet.ibm.com>;
	Thu, 21 Jan 2016 19:40:19 +1000
In-Reply-To: <1453369139-10203-1-git-send-email-shilpa.bhat@linux.vnet.ibm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org
Cc: rjw@rjwysocki.net, viresh.kumar@linaro.org, linux-pm@vger.kernel.org, pc@us.ibm.com, anton@samba.org, ego@linux.vnet.ibm.com, shreyas@linux.vnet.ibm.com, Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>

Currently we use printk message to notify the throttle event. But this
can flood the console if the cpu is throttled frequently. So replace the
printk with the tracepoint to notify the throttle event. And also events
like throttle below nominal frequency and OCC_RESET are reduced to
pr_warn/pr_warn_once as pointed by MFG to not mark them as critical
messages. This patch adds 'throt_reason' to struct chip to store the
throttle reason.

Signed-off-by: Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>
Reviewed-by: Gautham R. Shenoy <ego@linux.vnet.ibm.com>
---
Changes from v4:
- Taken care of Gautham's comments to remove the new function
  powernv_cpufreq_check_pmax()
- Modified commit message

Changes from v3:
- Separate this patch to contain trace_point changes
- Move struct chip member 'restore' of type bool above 'mask' to reduce
  structure padding.

No changes from v2.

Changes from v1:
- As suggested by Paul Clarke replaced char * throttle_reason[][30] by 
  const char * const throttle_reason[].

 drivers/cpufreq/powernv-cpufreq.c | 73 ++++++++++++++++++---------------------
 1 file changed, 34 insertions(+), 39 deletions(-)

diff --git a/drivers/cpufreq/powernv-cpufreq.c b/drivers/cpufreq/powernv-cpufreq.c
index 5ea103d..0ed7d82 100644
--- a/drivers/cpufreq/powernv-cpufreq.c
+++ b/drivers/cpufreq/powernv-cpufreq.c
@@ -28,6 +28,7 @@
 #include <linux/of.h>
 #include <linux/reboot.h>
 #include <linux/slab.h>
+#include <trace/events/power.h>
 
 #include <asm/cputhreads.h>
 #include <asm/firmware.h>
@@ -44,12 +45,22 @@ static struct cpufreq_frequency_table powernv_freqs[POWERNV_MAX_PSTATES+1];
 static bool rebooting, throttled, occ_reset;
 static unsigned int *core_to_chip_map;
 
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
@@ -330,17 +341,17 @@ static void powernv_cpufreq_throttle_check(void *data)
 			goto next;
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
 
 	/* Check if Psafe_mode_active is set in PMSR. */
@@ -358,7 +369,7 @@ next:
 
 	if (throttled) {
 		pr_info("PMSR = %16lx\n", pmsr);
-		pr_crit("CPU Frequency could be throttled\n");
+		pr_warn("CPU Frequency could be throttled\n");
 	}
 }
 
@@ -451,15 +462,6 @@ out:
 	put_online_cpus();
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
@@ -485,7 +487,7 @@ static int powernv_cpufreq_occ_msg(struct notifier_block *nb,
 		 */
 		if (!throttled) {
 			throttled = true;
-			pr_crit("CPU frequency is throttled for duration\n");
+			pr_warn("CPU frequency is throttled for duration\n");
 		}
 
 		break;
@@ -509,23 +511,18 @@ static int powernv_cpufreq_occ_msg(struct notifier_block *nb,
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
@@ -580,16 +577,14 @@ static int init_chip_info(void)
 		cpumask_andnot(&cpu_mask, &cpu_mask, cpu_sibling_mask(cpu));
 	}
 
-	chips = kmalloc_array(nr_chips, sizeof(struct chip), GFP_KERNEL);
+	chips = kcalloc(nr_chips, sizeof(struct chip), GFP_KERNEL);
 	if (!chips)
 		goto free_chip_map;
 
 	for (i = 0; i < nr_chips; i++) {
 		chips[i].id = chip[i];
-		chips[i].throttled = false;
 		cpumask_copy(&chips[i].mask, cpumask_of_node(chip[i]));
 		INIT_WORK(&chips[i].throttle, powernv_cpufreq_work_fn);
-		chips[i].restore = false;
 	}
 
 	return 0;
-- 
1.9.3

