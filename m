From: Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>
Subject: [PATCH 2/2] cpufreq: powernv: Register for OCC related opal_message notification
Date: Wed, 22 Apr 2015 22:34:25 +0530
Message-ID: <1429722265-2953-2-git-send-email-shilpa.bhat@linux.vnet.ibm.com>
References: <1429722265-2953-1-git-send-email-shilpa.bhat@linux.vnet.ibm.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from e28smtp02.in.ibm.com ([122.248.162.2]:43511 "EHLO
	e28smtp02.in.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965881AbbDVRGs (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 22 Apr 2015 13:06:48 -0400
Received: from /spool/local
	by e28smtp02.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-pm@vger.kernel.org> from <shilpa.bhat@linux.vnet.ibm.com>;
	Wed, 22 Apr 2015 22:36:46 +0530
In-Reply-To: <1429722265-2953-1-git-send-email-shilpa.bhat@linux.vnet.ibm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org
Cc: Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org

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
CC: linux-pm@vger.kernel.org
---
 drivers/cpufreq/powernv-cpufreq.c | 70 ++++++++++++++++++++++++++++++++++++++-
 1 file changed, 69 insertions(+), 1 deletion(-)

diff --git a/drivers/cpufreq/powernv-cpufreq.c b/drivers/cpufreq/powernv-cpufreq.c
index ebef0d8..5718765 100644
--- a/drivers/cpufreq/powernv-cpufreq.c
+++ b/drivers/cpufreq/powernv-cpufreq.c
@@ -32,6 +32,7 @@
 #include <asm/firmware.h>
 #include <asm/reg.h>
 #include <asm/smp.h> /* Required for cpu_sibling_mask() in UP configs */
+#include <asm/opal.h>
 
 #define POWERNV_MAX_PSTATES	256
 #define PMSR_PSAFE_ENABLE	(1UL << 30)
@@ -40,7 +41,7 @@
 #define PMSR_LP(x)		((x >> 48) & 0xFF)
 
 static struct cpufreq_frequency_table powernv_freqs[POWERNV_MAX_PSTATES+1];
-static bool rebooting, throttled;
+static bool rebooting, throttled, occ_reset;
 
 /*
  * Note: The set of pstates consists of contiguous integers, the
@@ -395,6 +396,72 @@ static struct notifier_block powernv_cpufreq_reboot_nb = {
 	.notifier_call = powernv_cpufreq_reboot_notifier,
 };
 
+static char throttle_reason[6][50] = {	"No throttling",
+					"Power Cap",
+					"Processor Over Temperature",
+					"Power Supply Failure",
+					"OverCurrent",
+					"OCC Reset"
+				     };
+
+static int powernv_cpufreq_occ_msg(struct notifier_block *nb,
+		unsigned long msg_type, void *msg)
+{
+	struct opal_msg *occ_msg = msg;
+	uint64_t token;
+	uint64_t chip_id, reason;
+
+	if (msg_type != OPAL_MSG_OCC)
+		return 0;
+	token = be64_to_cpu(occ_msg->params[0]);
+	switch (token) {
+	case 0:
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
+		pr_info("OCC in Reset\n");
+		break;
+	case 1:
+		pr_info("OCC is Loaded\n");
+		break;
+	case 2:
+		chip_id = be64_to_cpu(occ_msg->params[1]);
+		reason = be64_to_cpu(occ_msg->params[2]);
+		if (occ_reset) {
+			occ_reset = false;
+			throttled = false;
+			pr_info("OCC is Active\n");
+			/* Sanity check for static governors */
+			powernv_cpufreq_throttle_check(smp_processor_id());
+		} else if (reason) {
+			throttled = true;
+			pr_info("Pmax reduced due to %s on chip %x\n",
+					throttle_reason[reason], (int)chip_id);
+		} else {
+			throttled = false;
+			pr_info("%s on chip %x\n",
+					throttle_reason[reason], (int)chip_id);
+		}
+		break;
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
@@ -430,6 +497,7 @@ static int __init powernv_cpufreq_init(void)
 	}
 
 	register_reboot_notifier(&powernv_cpufreq_reboot_nb);
+	opal_message_notifier_register(OPAL_MSG_OCC, &powernv_cpufreq_opal_nb);
 	return cpufreq_register_driver(&powernv_cpufreq_driver);
 }
 module_init(powernv_cpufreq_init);
-- 
1.9.3

