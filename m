From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [PATCH 6/9] PM / Runtime: Add subsystem data field to
	struct dev_pm_info
Date: Sun, 24 Apr 2011 23:42:14 +0200
Message-ID: <201104242342.14492.rjw__25873.1189453558$1303682303$gmane$org@sisk.pl>
References: <201104130205.26988.rjw@sisk.pl> <201104170135.19388.rjw@sisk.pl>
	<201104242330.13607.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <201104242330.13607.rjw@sisk.pl>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Linux PM mailing list <linux-pm@lists.linux-foundation.org>
Cc: linux-sh@vger.kernel.org, Greg KH <gregkh@suse.de>, LKML <linux-kernel@vger.kernel.org>, Grant Likely <grant.likely@secretlab.ca>
List-Id: linux-pm@vger.kernel.org

From: Rafael J. Wysocki <rjw@sisk.pl>

Some subsystems need to attach PM-related data to struct device and
they need to use devres for this purpose.  For their convenience
and to make code more straightforward, add a new field called
subsys_data to struct dev_pm_info and let subsystems use it for
attaching PM-related information to devices.

Convert the ARM shmobile platform to using the new field.

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
---
 arch/arm/mach-shmobile/pm_runtime.c |   34 +++++++++++++++++-----------------
 include/linux/pm.h                  |    1 +
 2 files changed, 18 insertions(+), 17 deletions(-)

Index: linux-2.6/include/linux/pm.h
===================================================================
--- linux-2.6.orig/include/linux/pm.h
+++ linux-2.6/include/linux/pm.h
@@ -460,6 +460,7 @@ struct dev_pm_info {
 	unsigned long		active_jiffies;
 	unsigned long		suspended_jiffies;
 	unsigned long		accounting_timestamp;
+	void			*subsys_data;  /* Owned by the subsystem. */
 #endif
 };
 
Index: linux-2.6/arch/arm/mach-shmobile/pm_runtime.c
===================================================================
--- linux-2.6.orig/arch/arm/mach-shmobile/pm_runtime.c
+++ linux-2.6/arch/arm/mach-shmobile/pm_runtime.c
@@ -18,6 +18,7 @@
 #include <linux/clk.h>
 #include <linux/sh_clk.h>
 #include <linux/bitmap.h>
+#include <linux/slab.h>
 
 #ifdef CONFIG_PM_RUNTIME
 #define BIT_ONCE 0
@@ -29,22 +30,9 @@ struct pm_runtime_data {
 	struct clk *clk;
 };
 
-static void __devres_release(struct device *dev, void *res)
-{
-	struct pm_runtime_data *prd = res;
-
-	dev_dbg(dev, "__devres_release()\n");
-
-	if (test_bit(BIT_CLK_ENABLED, &prd->flags))
-		clk_disable(prd->clk);
-
-	if (test_bit(BIT_ACTIVE, &prd->flags))
-		clk_put(prd->clk);
-}
-
 static struct pm_runtime_data *__to_prd(struct device *dev)
 {
-	return devres_find(dev, __devres_release, NULL, NULL);
+	return dev ? dev->power.subsys_data : NULL;
 }
 
 static void platform_pm_runtime_init(struct device *dev,
@@ -121,14 +109,26 @@ static int platform_bus_notify(struct no
 
 	dev_dbg(dev, "platform_bus_notify() %ld !\n", action);
 
-	if (action == BUS_NOTIFY_BIND_DRIVER) {
-		prd = devres_alloc(__devres_release, sizeof(*prd), GFP_KERNEL);
+	switch (action) {
+	case BUS_NOTIFY_BIND_DRIVER:
+		prd = kzalloc(sizeof(*prd), GFP_KERNEL);
 		if (prd) {
-			devres_add(dev, prd);
+			dev->power.subsys_data = prd;
 			dev->pwr_domain = &default_power_domain;
 		} else {
 			dev_err(dev, "unable to alloc memory for runtime pm\n");
 		}
+		break;
+	case BUS_NOTIFY_UNBOUND_DRIVER:
+		prd = __to_prd(dev);
+		if (prd) {
+			if (test_bit(BIT_CLK_ENABLED, &prd->flags))
+				clk_disable(prd->clk);
+
+			if (test_bit(BIT_ACTIVE, &prd->flags))
+				clk_put(prd->clk);
+		}
+		break;
 	}
 
 	return 0;
