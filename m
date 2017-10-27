From: Ramesh Thomas <ramesh.thomas@intel.com>
Subject: [PATCH v2] cpuidle: ladder: Add per CPU PM QoS resume latency support
Date: Thu, 26 Oct 2017 19:01:34 -0700
Message-ID: <20171027020124.GA10233@intel.com>
Reply-To: ramesh.thomas@intel.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:5193 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751548AbdJ0CIM (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 26 Oct 2017 22:08:12 -0400
Content-Disposition: inline
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: linux-pm@vger.kernel.org, rafael.j.wysocki@intel.com, alex.shi@linaro.org, daniel.lezcano@linaro.org

Individual CPUs may have special requirements to not enter
deep idle states. For example, a CPU running real time
applications would not want to enter deep idle states to
avoid latency impacts. At the same time other CPUs that
do not have such a requirement could allow deep idle
states to save power.

This was already implemented in the menu governor.
Implementing similar changes in the ladder governor which
gets selected when CONFIG_NO_HZ and CONFIG_NO_HZ_IDLE are not
set. Refer following commits for the menu governor changes.

commit 9908859acaa9 ("cpuidle/menu: add per CPU PM QoS resume
latency consideration")
commit 6dbf5cea05a7 ("cpuidle: menu: Avoid taking spinlock for
accessing QoS values")

Signed-off-by: Ramesh Thomas <ramesh.thomas@intel.com>
---

v2:
  - use PM_QOS_RESUME_LATENCY_NO_CONSTRAINT for "no constraint" value
  Should be applied over https://patchwork.kernel.org/patch/10024157/

 drivers/cpuidle/governors/ladder.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/cpuidle/governors/ladder.c b/drivers/cpuidle/governors/ladder.c
index ce1a2ff..1ad8745 100644
--- a/drivers/cpuidle/governors/ladder.c
+++ b/drivers/cpuidle/governors/ladder.c
@@ -17,6 +17,7 @@
 #include <linux/pm_qos.h>
 #include <linux/jiffies.h>
 #include <linux/tick.h>
+#include <linux/cpu.h>
 
 #include <asm/io.h>
 #include <linux/uaccess.h>
@@ -67,10 +68,16 @@ static int ladder_select_state(struct cpuidle_driver *drv,
 				struct cpuidle_device *dev)
 {
 	struct ladder_device *ldev = this_cpu_ptr(&ladder_devices);
+	struct device *device = get_cpu_device(dev->cpu);
 	struct ladder_device_state *last_state;
 	int last_residency, last_idx = ldev->last_state_idx;
 	int first_idx = drv->states[0].flags & CPUIDLE_FLAG_POLLING ? 1 : 0;
 	int latency_req = pm_qos_request(PM_QOS_CPU_DMA_LATENCY);
+	int resume_latency = dev_pm_qos_raw_read_value(device);
+
+	if (resume_latency < latency_req &&
+	    resume_latency != PM_QOS_RESUME_LATENCY_NO_CONSTRAINT)
+		latency_req = resume_latency;
 
 	/* Special case when user has set very strict latency requirement */
 	if (unlikely(latency_req == 0)) {
-- 
2.7.4
