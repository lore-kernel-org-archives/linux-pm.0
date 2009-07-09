From: Magnus Damm <magnus.damm@gmail.com>
Subject: [PATCH 01/06] Driver Core: Runtime PM callbacks for the
	Platform Bus
Date: Fri, 10 Jul 2009 00:19:35 +0900
Message-ID: <20090709151935.8385.71812.sendpatchset__44089.3069761389$1247153075$gmane$org@rx1.opensource.se>
References: <20090709151926.8385.92800.sendpatchset@rx1.opensource.se>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20090709151926.8385.92800.sendpatchset@rx1.opensource.se>
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
Cc: linux-sh@vger.kernel.org, gregkh@suse.de
List-Id: linux-pm@vger.kernel.org

From: Magnus Damm <damm@igel.co.jp>

This patch adds default Runtime PM callbacks to the dev_pm_ops
belonging to the platform bus. The callbacks are weak symbols
that architecture specific code may override. Also, call
pm_runtime_enable() for the platform bus struct device.

Signed-off-by: Magnus Damm <damm@igel.co.jp>
---

 drivers/base/platform.c |   31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

--- 0001/drivers/base/platform.c
+++ work/drivers/base/platform.c	2009-06-25 18:58:56.000000000 +0900
@@ -17,6 +17,7 @@
 #include <linux/bootmem.h>
 #include <linux/err.h>
 #include <linux/slab.h>
+#include <linux/pm_runtime.h>
 
 #include "base.h"
 
@@ -925,6 +926,30 @@ static int platform_pm_restore_noirq(str
 
 #endif /* !CONFIG_HIBERNATION */
 
+#ifdef CONFIG_PM_RUNTIME
+
+int __weak platform_pm_runtime_suspend(struct device *dev)
+{
+	return -EINVAL;
+};
+
+int __weak platform_pm_runtime_resume(struct device *dev)
+{
+	return -EINVAL;
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
@@ -940,6 +965,9 @@ static struct dev_pm_ops platform_dev_pm
 	.thaw_noirq = platform_pm_thaw_noirq,
 	.poweroff_noirq = platform_pm_poweroff_noirq,
 	.restore_noirq = platform_pm_restore_noirq,
+	.runtime_suspend = platform_pm_runtime_suspend,
+	.runtime_resume = platform_pm_runtime_resume,
+	.runtime_idle = platform_pm_runtime_idle,
 };
 
 #define PLATFORM_PM_OPS_PTR	(&platform_dev_pm_ops)
@@ -968,6 +996,9 @@ int __init platform_bus_init(void)
 	error = device_register(&platform_bus);
 	if (error)
 		return error;
+
+	pm_runtime_enable(&platform_bus);
+
 	error =  bus_register(&platform_bus_type);
 	if (error)
 		device_unregister(&platform_bus);
