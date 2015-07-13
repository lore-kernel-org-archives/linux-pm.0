From: Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>
Subject: [PATCH v4 4/6] cpufreq: powernv: Call throttle_check() on receiving OCC_THROTTLE
Date: Mon, 13 Jul 2015 19:40:00 +0530
Message-ID: <1436796602-10228-5-git-send-email-shilpa.bhat@linux.vnet.ibm.com>
References: <1436796602-10228-1-git-send-email-shilpa.bhat@linux.vnet.ibm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1436796602-10228-1-git-send-email-shilpa.bhat@linux.vnet.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: rjw@rjwysocki.net
Cc: viresh.kumar@linaro.org, linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>
List-Id: linux-pm@vger.kernel.org

Re-evaluate the chip's throttled state on recieving OCC_THROTTLE
notification by executing *throttle_check() on any one of the cpu on
the chip. This is a sanity check to verify if we were indeed
throttled/unthrottled after receiving OCC_THROTTLE notification.

We cannot call *throttle_check() directly from the notification
handler because we could be handling chip1's notification in chip2. So
initiate an smp_call to execute *throttle_check(). We are irq-disabled
in the notification handler, so use a worker thread to smp_call
throttle_check() on any of the cpu in the chipmask.

Signed-off-by: Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>
---
Changes from v3:
- Refer to the members of 'struct opal_occ_msg' in the patch.
  Replace 'chip_id' with 'omsg.chip'

 drivers/cpufreq/powernv-cpufreq.c | 28 ++++++++++++++++++++++++++--
 1 file changed, 26 insertions(+), 2 deletions(-)

diff --git a/drivers/cpufreq/powernv-cpufreq.c b/drivers/cpufreq/powernv-cpufreq.c
index 1f59958..f2da30a 100644
--- a/drivers/cpufreq/powernv-cpufreq.c
+++ b/drivers/cpufreq/powernv-cpufreq.c
@@ -47,6 +47,8 @@ static bool rebooting, throttled, occ_reset;
 static struct chip {
 	unsigned int id;
 	bool throttled;
+	cpumask_t mask;
+	struct work_struct throttle;
 } *chips;
 
 static int nr_chips;
@@ -307,8 +309,9 @@ static inline unsigned int get_nominal_index(void)
 	return powernv_pstate_info.max - powernv_pstate_info.nominal;
 }
 
-static void powernv_cpufreq_throttle_check(unsigned int cpu)
+static void powernv_cpufreq_throttle_check(void *data)
 {
+	unsigned int cpu = smp_processor_id();
 	unsigned long pmsr;
 	int pmsr_pmax, pmsr_lp, i;
 
@@ -370,7 +373,7 @@ static int powernv_cpufreq_target_index(struct cpufreq_policy *policy,
 		return 0;
 
 	if (!throttled)
-		powernv_cpufreq_throttle_check(smp_processor_id());
+		powernv_cpufreq_throttle_check(NULL);
 
 	freq_data.pstate_id = powernv_freqs[new_index].driver_data;
 
@@ -415,6 +418,14 @@ static struct notifier_block powernv_cpufreq_reboot_nb = {
 	.notifier_call = powernv_cpufreq_reboot_notifier,
 };
 
+void powernv_cpufreq_work_fn(struct work_struct *work)
+{
+	struct chip *chip = container_of(work, struct chip, throttle);
+
+	smp_call_function_any(&chip->mask,
+			      powernv_cpufreq_throttle_check, NULL, 0);
+}
+
 static char throttle_reason[][30] = {
 					"No throttling",
 					"Power Cap",
@@ -429,6 +440,7 @@ static int powernv_cpufreq_occ_msg(struct notifier_block *nb,
 {
 	struct opal_msg *msg = _msg;
 	struct opal_occ_msg omsg;
+	int i;
 
 	if (msg_type != OPAL_MSG_OCC)
 		return 0;
@@ -459,6 +471,10 @@ static int powernv_cpufreq_occ_msg(struct notifier_block *nb,
 			occ_reset = false;
 			throttled = false;
 			pr_info("OCC: Active\n");
+
+			for (i = 0; i < nr_chips; i++)
+				schedule_work(&chips[i].throttle);
+
 			return 0;
 		}
 
@@ -470,6 +486,12 @@ static int powernv_cpufreq_occ_msg(struct notifier_block *nb,
 		else if (!omsg.throttle_status)
 			pr_info("OCC: Chip %u %s\n", (unsigned int)omsg.chip,
 				throttle_reason[omsg.throttle_status]);
+		else
+			return 0;
+
+		for (i = 0; i < nr_chips; i++)
+			if (chips[i].id == omsg.chip)
+				schedule_work(&chips[i].throttle);
 	}
 	return 0;
 }
@@ -521,6 +543,8 @@ static int init_chip_info(void)
 	for (i = 0; i < nr_chips; i++) {
 		chips[i].id = chip[i];
 		chips[i].throttled = false;
+		cpumask_copy(&chips[i].mask, cpumask_of_node(chip[i]));
+		INIT_WORK(&chips[i].throttle, powernv_cpufreq_work_fn);
 	}
 
 	return 0;
-- 
1.9.3
