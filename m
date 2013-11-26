From: Jacob Pan <jacob.jun.pan@linux.intel.com>
Subject: [PATCH 3/3] thermal/powerclamp: communicate with pm qos when injecting idle
Date: Tue, 26 Nov 2013 15:20:11 -0800
Message-ID: <1385508011-26914-4-git-send-email-jacob.jun.pan@linux.intel.com>
References: <1385508011-26914-1-git-send-email-jacob.jun.pan@linux.intel.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga14.intel.com ([143.182.124.37]:31266 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757595Ab3KZXUV (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Tue, 26 Nov 2013 18:20:21 -0500
In-Reply-To: <1385508011-26914-1-git-send-email-jacob.jun.pan@linux.intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Linux PM <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Peter Zijlstra <a.p.zijlstra@chello.nl>, Rafael Wysocki <rafael.j.wysocki@intel.com>, Len Brown <len.brown@intel.com>, Arjan van de Ven <arjan@linux.intel.com>, Zhang Rui <rui.zhang@intel.com>
Cc: Jacob Pan <jacob.jun.pan@linux.intel.com>

During idle injection period, CPU PM QOS class shall be ignored.
This will indirectly influence the idle governors to choose the
deepest idle states.

Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
---
 drivers/thermal/intel_powerclamp.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/thermal/intel_powerclamp.c b/drivers/thermal/intel_powerclamp.c
index de90f89..62dbf95 100644
--- a/drivers/thermal/intel_powerclamp.c
+++ b/drivers/thermal/intel_powerclamp.c
@@ -51,6 +51,7 @@
 #include <linux/debugfs.h>
 #include <linux/seq_file.h>
 #include <linux/sched/rt.h>
+#include <linux/pm_qos.h>
 
 #include <asm/nmi.h>
 #include <asm/msr.h>
@@ -483,6 +484,10 @@ static int start_power_clamp(void)
 	clamping = true;
 	schedule_delayed_work(&poll_pkg_cstate_work, 0);
 
+	/* Tell PM QOS all CPU constraints are ignored during idle injection */
+	pm_qos_set_constraint_class_state(PM_QOS_CPU_DMA_LATENCY,
+					PM_QOS_CONSTRAINT_IGNORED);
+
 	/* start one thread per online cpu */
 	for_each_online_cpu(cpu) {
 		struct task_struct **p =
@@ -524,6 +529,9 @@ static void end_power_clamp(void)
 			kthread_stop(thread);
 		}
 	}
+	/* make CPU PM QOS active again */
+	pm_qos_set_constraint_class_state(PM_QOS_CPU_DMA_LATENCY,
+					PM_QOS_CONSTRAINT_AVAILABLE);
 }
 
 static int powerclamp_cpu_callback(struct notifier_block *nfb,
-- 
1.8.1.2

