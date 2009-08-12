From: Magnus Damm <magnus.damm@gmail.com>
Subject: [PATCH 01/01] PM: Runtime PM v15 - Platform Device Bus
	Support
Date: Wed, 12 Aug 2009 19:09:02 +0900
Message-ID: <20090812100902.26365.3186.sendpatchset@rx1.opensource.se>
References: <20090812100853.26365.57240.sendpatchset@rx1.opensource.se>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20090812100853.26365.57240.sendpatchset@rx1.opensource.se>
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
Cc: gregkh@suse.de
List-Id: linux-pm@vger.kernel.org

From: Magnus Damm <damm@igel.co.jp>

This patch adds default Runtime PM callbacks to the dev_pm_ops
belonging to the platform bus. The callbacks are weak symbols
that architecture specific code can override.

Allows Runtime PM even though CONFIG_PM_SLEEP=n.

Signed-off-by: Magnus Damm <damm@igel.co.jp>
---

 Needed by the SuperH Mobile Runtime PM implementation. Depends on
 "PM: Introduce core framework for run-time PM of I/O devices (rev. 15)"

 Changes since 20090807:
 - removed pm_runtime_enable()

 Changes since 20090731:
 - Based on "Driver Core: Runtime PM callbacks for the Platform Bus V2"
 - Reworked to handle CONFIG_PM_SLEEP=n case

 drivers/base/platform.c |   45 ++++++++++++++++++++++++++++++++++++---------
 1 file changed, 36 insertions(+), 9 deletions(-)

--- 0001/drivers/base/platform.c
+++ work/drivers/base/platform.c	2009-08-11 14:35:47.000000000 +0900
@@ -17,6 +17,7 @@
 #include <linux/bootmem.h>
 #include <linux/err.h>
 #include <linux/slab.h>
+#include <linux/pm_runtime.h>
 
 #include "base.h"
 
@@ -683,6 +684,13 @@ static void platform_pm_complete(struct 
 		drv->pm->complete(dev);
 }
 
+#else /* !CONFIG_PM_SLEEP */
+
+#define platform_pm_prepare		NULL
+#define platform_pm_complete		NULL
+
+#endif /* !CONFIG_PM_SLEEP */
+
 #ifdef CONFIG_SUSPEND
 
 static int platform_pm_suspend(struct device *dev)
@@ -925,6 +933,30 @@ static int platform_pm_restore_noirq(str
 
 #endif /* !CONFIG_HIBERNATION */
 
+#ifdef CONFIG_PM_RUNTIME
+
+int __weak platform_pm_runtime_suspend(struct device *dev)
+{
+	return -ENOSYS;
+};
+
+int __weak platform_pm_runtime_resume(struct device *dev)
+{
+	return -ENOSYS;
+};
+
+void __weak platform_pm_runtime_idle(struct device *dev)
+{
+};
+
+#else /* !CONFIG_PM_RUNTIME */
+
+#define platform_pm_runtime_suspend NULL
+#define platform_pm_runtime_resume NULL
+#define platform_pm_runtime_idle NULL
+
+#endif /* !CONFIG_PM_RUNTIME */
+
 static struct dev_pm_ops platform_dev_pm_ops = {
 	.prepare = platform_pm_prepare,
 	.complete = platform_pm_complete,
@@ -940,22 +972,17 @@ static struct dev_pm_ops platform_dev_pm
 	.thaw_noirq = platform_pm_thaw_noirq,
 	.poweroff_noirq = platform_pm_poweroff_noirq,
 	.restore_noirq = platform_pm_restore_noirq,
+	.runtime_suspend = platform_pm_runtime_suspend,
+	.runtime_resume = platform_pm_runtime_resume,
+	.runtime_idle = platform_pm_runtime_idle,
 };
 
-#define PLATFORM_PM_OPS_PTR	(&platform_dev_pm_ops)
-
-#else /* !CONFIG_PM_SLEEP */
-
-#define PLATFORM_PM_OPS_PTR	NULL
-
-#endif /* !CONFIG_PM_SLEEP */
-
 struct bus_type platform_bus_type = {
 	.name		= "platform",
 	.dev_attrs	= platform_dev_attrs,
 	.match		= platform_match,
 	.uevent		= platform_uevent,
-	.pm		= PLATFORM_PM_OPS_PTR,
+	.pm		= &platform_dev_pm_ops,
 };
 EXPORT_SYMBOL_GPL(platform_bus_type);
 
