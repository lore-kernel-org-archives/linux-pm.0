From: Richard Cochran <rcochran@linutronix.de>
Subject: [PATCH 3/5] thermal: x86_pkg_temp: Handle the FROZEN hot plug notifier actions.
Date: Fri, 18 Mar 2016 22:26:09 +0100
Message-ID: <1458336371-17748-3-git-send-email-rcochran@linutronix.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: rt@linutronix.de, Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

When performing a suspend operation, the kernel brings all of the
non-boot CPUs offline, calling the hot plug notifiers with the flag,
CPU_TASKS_FROZEN, set in the action code.  Similarly, during resume,
the CPUs are brought back online, but again the notifiers have the
FROZEN flag set.

While some very few drivers really need to treat suspend/resume
specially, this driver unintentionally ignores the notifications.

This patch changes the driver to cancel its work item when the CPU
goes down, even during a suspend operation.  As a result, the
suspended state is no longer a special case.

Cc: Zhang Rui <rui.zhang@intel.com>
Cc: Eduardo Valentin <edubezval@gmail.com>
Cc: linux-pm@vger.kernel.org
Signed-off-by: Richard Cochran <rcochran@linutronix.de>
---
 drivers/thermal/x86_pkg_temp_thermal.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/thermal/x86_pkg_temp_thermal.c b/drivers/thermal/x86_pkg_temp_thermal.c
index 7fc919f..97f0a2b 100644
--- a/drivers/thermal/x86_pkg_temp_thermal.c
+++ b/drivers/thermal/x86_pkg_temp_thermal.c
@@ -555,7 +555,7 @@ static int pkg_temp_thermal_cpu_callback(struct notifier_block *nfb,
 {
 	unsigned int cpu = (unsigned long) hcpu;
 
-	switch (action) {
+	switch (action & ~CPU_TASKS_FROZEN) {
 	case CPU_ONLINE:
 	case CPU_DOWN_FAILED:
 		get_core_online(cpu);
-- 
2.1.4
