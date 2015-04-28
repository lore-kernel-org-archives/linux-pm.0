From: Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>
Subject: [PATCH v2 2/2] cpufreq: powernv: Register for OCC related opal_message notification
Date: Tue, 28 Apr 2015 11:53:34 +0530
Message-ID: <1430202214-13807-3-git-send-email-shilpa.bhat@linux.vnet.ibm.com>
References: <1430202214-13807-1-git-send-email-shilpa.bhat@linux.vnet.ibm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1430202214-13807-1-git-send-email-shilpa.bhat@linux.vnet.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org
Cc: Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>, Preeti U Murthy <preeti@linux.vnet.ibm.com>, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

OCC is an On-Chip-Controller which takes care of power and thermal
safety of the chip. During runtime due to power failure or
overtemperature the OCC may throttle the frequencies of the CPUs to
remain within the power budget.

We want the cpufreq driver to be aware of such situations to be able
to report it to the user. We register to opal_message_notifier to
receive OCC messages from opal.

powernv_cpufreq_throttle_check() reports any frequency throttling and
this patch will report the reason or event that caused throttling. We
can be throttled if OCC is reset or OCC limits Pmax due to power or
thermal reasons. We are also notified of unthrottling after an OCC
reset or if OCC restores Pmax on the chip.

Signed-off-by: Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>
CC: "Rafael J. Wysocki" <rjw@rjwysocki.net>
CC: Viresh Kumar <viresh.kumar@linaro.org>
CC: Preeti U Murthy <preeti@linux.vnet.ibm.com>
CC: linux-pm@vger.kernel.org
---
Changes from v1:
- Add macros to define OCC_RESET, OCC_LOAD and OCC_THROTTLE
- Define a structure to store chip id, chip mask which has bits set
  for cpus present in the chip, throttled state and a work_struct.
- Modify powernv_cpufreq_throttle_check() to be called via smp_call()
- On Pmax throttling/unthrottling update 'chip.throttled' and not the
  global 'throttled' as Pmax capping is local to the chip.
- Remove the condition which checks if local pstate is less than Pmin
  while checking for Psafe frequency. When OCC becomes active after
  reset we update 'thottled' to false and when the cpufreq governor
  initiates a pstate change, the local pstate will be in Psafe and we
  will be reporting a false positive when we are not throttled.
- Schedule a kworker on receiving throttling/unthrottling OCC message
  for that chip and schedule on all chips after receiving active.
- After an OCC reset all the cpus will be in Psafe frequency. So call
  target() and restore the frequency to policy->cur after OCC_ACTIVE
  and Pmax unthrottling
- Taken care of Viresh and Preeti's comments.

 drivers/cpufreq/powernv-cpufreq.c | 181 ++++++++++++++++++++++++++++++++++----
 1 file changed, 166 insertions(+), 15 deletions(-)

diff --git a/drivers/cpufreq/powernv-cpufreq.c b/drivers/cpufreq/powernv-cpufreq.c
index ebef0d8..b356c9d 100644
--- a/drivers/cpufreq/powernv-cpufreq.c
+++ b/drivers/cpufreq/powernv-cpufreq.c
@@ -27,20 +27,33 @@
 #include <linux/smp.h>
 #include <linux/of.h>
 #include <linux/reboot.h>
+#include <linux/slab.h>
 
 #include <asm/cputhreads.h>
 #include <asm/firmware.h>
 #include <asm/reg.h>
 #include <asm/smp.h> /* Required for cpu_sibling_mask() in UP configs */
+#include <asm/opal.h>
 
 #define POWERNV_MAX_PSTATES	256
 #define PMSR_PSAFE_ENABLE	(1UL << 30)
 #define PMSR_SPR_EM_DISABLE	(1UL << 31)
 #define PMSR_MAX(x)		((x >> 32) & 0xFF)
-#define PMSR_LP(x)		((x >> 48) & 0xFF)
+#define OCC_RESET		0
+#define OCC_LOAD		1
+#define OCC_THROTTLE		2
 
 static struct cpufreq_frequency_table powernv_freqs[POWERNV_MAX_PSTATES+1];
-static bool rebooting, throttled;
+static bool rebooting, throttled, occ_reset;
+
+static struct chip {
+	int id;
+	bool throttled;
+	cpumask_t mask;
+	struct work_struct throttle;
+} *chips;
+
+static int nr_chips;
 
 /*
  * Note: The set of pstates consists of contiguous integers, the
@@ -298,28 +311,33 @@ static inline unsigned int get_nominal_index(void)
 	return powernv_pstate_info.max - powernv_pstate_info.nominal;
 }
 
-static void powernv_cpufreq_throttle_check(unsigned int cpu)
+static void powernv_cpufreq_throttle_check(void *data)
 {
+	unsigned int cpu = smp_processor_id();
 	unsigned long pmsr;
-	int pmsr_pmax, pmsr_lp;
+	int pmsr_pmax, i;
 
 	pmsr = get_pmspr(SPRN_PMSR);
 
+	for (i = 0; i < nr_chips; i++)
+		if (chips[i].id == cpu_to_chip_id(cpu))
+			break;
+
 	/* Check for Pmax Capping */
 	pmsr_pmax = (s8)PMSR_MAX(pmsr);
 	if (pmsr_pmax != powernv_pstate_info.max) {
-		throttled = true;
-		pr_info("CPU %d Pmax is reduced to %d\n", cpu, pmsr_pmax);
-		pr_info("Max allowed Pstate is capped\n");
+		if (chips[i].throttled)
+			goto next;
+		chips[i].throttled = true;
+		pr_info("CPU %d on chip %d Pmax is reduced to %d\n", cpu,
+			chips[i].id, pmsr_pmax);
+	} else {
+		chips[i].throttled = false;
 	}
 
-	/*
-	 * Check for Psafe by reading LocalPstate
-	 * or check if Psafe_mode_active is set in PMSR.
-	 */
-	pmsr_lp = (s8)PMSR_LP(pmsr);
-	if ((pmsr_lp < powernv_pstate_info.min) ||
-				(pmsr & PMSR_PSAFE_ENABLE)) {
+	/* Check if Psafe_mode_active is set in PMSR. */
+next:
+	if (pmsr & PMSR_PSAFE_ENABLE) {
 		throttled = true;
 		pr_info("Pstate set to safe frequency\n");
 	}
@@ -350,7 +368,7 @@ static int powernv_cpufreq_target_index(struct cpufreq_policy *policy,
 		return 0;
 
 	if (!throttled)
-		powernv_cpufreq_throttle_check(smp_processor_id());
+		powernv_cpufreq_throttle_check(NULL);
 
 	freq_data.pstate_id = powernv_freqs[new_index].driver_data;
 
@@ -395,6 +413,104 @@ static struct notifier_block powernv_cpufreq_reboot_nb = {
 	.notifier_call = powernv_cpufreq_reboot_notifier,
 };
 
+void powernv_cpufreq_work_fn(struct work_struct *work)
+{
+	struct chip *c = container_of(work, struct chip, throttle);
+	unsigned int cpu;
+
+	smp_call_function_any(&c->mask,
+			      powernv_cpufreq_throttle_check, NULL, 0);
+
+	for_each_cpu(cpu, &c->mask) {
+		int index;
+		struct cpufreq_frequency_table *freq_table;
+		struct cpufreq_policy cpu_policy;
+
+		if (!cpu_online(cpu))
+			continue;
+
+		cpufreq_get_policy(&cpu_policy, cpu);
+		freq_table = cpufreq_frequency_get_table(cpu_policy.cpu);
+		cpufreq_frequency_table_target(&cpu_policy, freq_table,
+					       cpu_policy.cur,
+					       CPUFREQ_RELATION_C, &index);
+		powernv_cpufreq_target_index(&cpu_policy, index);
+	}
+}
+
+static char throttle_reason[][30] = {
+					"No throttling",
+					"Power Cap",
+					"Processor Over Temperature",
+					"Power Supply Failure",
+					"Over Current",
+					"OCC Reset"
+				     };
+
+static int powernv_cpufreq_occ_msg(struct notifier_block *nb,
+				   unsigned long msg_type, void *msg)
+{
+	struct opal_msg *occ_msg = msg;
+	uint64_t token;
+	uint64_t chip_id, reason;
+	int i;
+
+	if (msg_type != OPAL_MSG_OCC)
+		return 0;
+
+	token = be64_to_cpu(occ_msg->params[0]);
+
+	switch (token) {
+	case OCC_RESET:
+		occ_reset = true;
+		/*
+		 * powernv_cpufreq_throttle_check() is called in
+		 * target() callback which can detect the throttle state
+		 * for governors like ondemand.
+		 * But static governors will not call target() often thus
+		 * report throttling here.
+		 */
+		if (!throttled) {
+			throttled = true;
+			pr_crit("CPU Frequency is throttled\n");
+		}
+		pr_info("OCC: Reset\n");
+		break;
+	case OCC_LOAD:
+		pr_info("OCC: Loaded\n");
+		break;
+	case OCC_THROTTLE:
+		chip_id = be64_to_cpu(occ_msg->params[1]);
+		reason = be64_to_cpu(occ_msg->params[2]);
+
+		if (occ_reset) {
+			occ_reset = false;
+			throttled = false;
+			pr_info("OCC: Active\n");
+			for (i = 0; i < nr_chips; i++)
+				schedule_work(&chips[i].throttle);
+			return 0;
+		}
+
+		if (reason && reason <= 5)
+			pr_info("OCC: Chip %d Pmax reduced due to %s\n",
+				(int)chip_id, throttle_reason[reason]);
+		else
+			pr_info("OCC: Chip %d %s\n", (int)chip_id,
+				throttle_reason[reason]);
+		for (i = 0; i < nr_chips; i++)
+			if (chips[i].id == (int)chip_id)
+				schedule_work(&chips[i].throttle);
+	}
+	return 0;
+}
+
+static struct notifier_block powernv_cpufreq_opal_nb = {
+	.notifier_call	= powernv_cpufreq_occ_msg,
+	.next		= NULL,
+	.priority	= 0,
+};
+
 static void powernv_cpufreq_stop_cpu(struct cpufreq_policy *policy)
 {
 	struct powernv_smp_call_data freq_data;
@@ -414,6 +530,35 @@ static struct cpufreq_driver powernv_cpufreq_driver = {
 	.attr		= powernv_cpu_freq_attr,
 };
 
+static int init_chip_info(void)
+{
+	int chip[256], i = 0, cpu;
+	int prev_chip_id = INT_MAX;
+
+	for_each_possible_cpu(cpu) {
+		int c = cpu_to_chip_id(cpu);
+
+		if (prev_chip_id != c) {
+			prev_chip_id = c;
+			chip[nr_chips++] = c;
+		}
+	}
+
+	chips = kmalloc_array(nr_chips, sizeof(struct chip), GFP_KERNEL);
+
+	if (!chips)
+		return -ENOMEM;
+
+	for (i = 0; i < nr_chips; i++) {
+		chips[i].id = chip[i];
+		cpumask_copy(&chips[i].mask, cpumask_of_node(chip[i]));
+		chips[i].throttled = false;
+		INIT_WORK(&chips[i].throttle, powernv_cpufreq_work_fn);
+	}
+
+	return 0;
+}
+
 static int __init powernv_cpufreq_init(void)
 {
 	int rc = 0;
@@ -429,7 +574,13 @@ static int __init powernv_cpufreq_init(void)
 		return rc;
 	}
 
+	/* Populate chip info */
+	rc = init_chip_info();
+	if (rc)
+		return rc;
+
 	register_reboot_notifier(&powernv_cpufreq_reboot_nb);
+	opal_message_notifier_register(OPAL_MSG_OCC, &powernv_cpufreq_opal_nb);
 	return cpufreq_register_driver(&powernv_cpufreq_driver);
 }
 module_init(powernv_cpufreq_init);
-- 
1.9.3
