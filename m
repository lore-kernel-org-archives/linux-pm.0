From: Lina Iyer <lina.iyer@linaro.org>
Subject: [PATCH] kernel/cpu_pm: fix cpu_cluster_pm_exit comment
Date: Wed,  2 Sep 2015 16:18:57 -0600
Message-ID: <1441232337-12615-1-git-send-email-lina.iyer@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: rjw@rjwysocki.net
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Lina Iyer <lina.iyer@linaro.org>, Nicolas Pitre <nicolas.pitre@linaro.org>
List-Id: linux-pm@vger.kernel.org

cpu_cluster_pm_exit() must be sent after cpu_cluster_pm_enter() has been
sent for the cluster and before any cpu_pm_exit() notifications are sent
for any CPU.

Cc: Nicolas Pitre <nicolas.pitre@linaro.org>
Acked-by: Kevin Hilman <khilman@linaro.org>
Signed-off-by: Lina Iyer <lina.iyer@linaro.org>
---
 kernel/cpu_pm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/cpu_pm.c b/kernel/cpu_pm.c
index 9656a3c..009cc9a 100644
--- a/kernel/cpu_pm.c
+++ b/kernel/cpu_pm.c
@@ -180,7 +180,7 @@ EXPORT_SYMBOL_GPL(cpu_cluster_pm_enter);
  * low power state that may have caused some blocks in the same power domain
  * to reset.
  *
- * Must be called after cpu_pm_exit has been called on all cpus in the power
+ * Must be called after cpu_cluster_pm_enter has been called for the power
  * domain, and before cpu_pm_exit has been called on any cpu in the power
  * domain. Notified drivers can include VFP co-processor, interrupt controller
  * and its PM extensions, local CPU timers context save/restore which
-- 
2.1.4
