From: Ohad Ben-Cohen <ohad@wizery.com>
Subject: [PATCH] PM: lenient generic runtime pm callbacks
Date: Tue,  7 Sep 2010 01:20:42 +0300
Message-ID: <1283811642-18837-1-git-send-email-ohad@wizery.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: linux-pm@lists.linux-foundation.org
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: linux-pm@vger.kernel.org

Allow drivers, that belong to subsystems which use the generic
runtime pm callbacks, not to define runtime pm suspend/resume handlers,
by implicitly assuming success in such cases.

This is needed to eliminate nop handlers that would otherwise be
necessary by drivers which enable runtime pm, but don't need
to do anything when their devices are runtime-suspended/resumed.

Signed-off-by: Ohad Ben-Cohen <ohad@wizery.com>
---
 drivers/base/power/generic_ops.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/base/power/generic_ops.c b/drivers/base/power/generic_ops.c
index 4b29d49..81f2c84 100644
--- a/drivers/base/power/generic_ops.c
+++ b/drivers/base/power/generic_ops.c
@@ -46,7 +46,7 @@ int pm_generic_runtime_suspend(struct device *dev)
 	const struct dev_pm_ops *pm = dev->driver ? dev->driver->pm : NULL;
 	int ret;
 
-	ret = pm && pm->runtime_suspend ? pm->runtime_suspend(dev) : -EINVAL;
+	ret = pm && pm->runtime_suspend ? pm->runtime_suspend(dev) : 0;
 
 	return ret;
 }
@@ -65,7 +65,7 @@ int pm_generic_runtime_resume(struct device *dev)
 	const struct dev_pm_ops *pm = dev->driver ? dev->driver->pm : NULL;
 	int ret;
 
-	ret = pm && pm->runtime_resume ? pm->runtime_resume(dev) : -EINVAL;
+	ret = pm && pm->runtime_resume ? pm->runtime_resume(dev) : 0;
 
 	return ret;
 }
-- 
1.7.0.4
