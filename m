From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [PATCH 9/9] PM: Revert "driver core: platform_bus: allow
	runtime override of dev_pm_ops"
Date: Sun, 17 Apr 2011 01:44:14 +0200
Message-ID: <201104170144.15043.rjw__13300.8991404951$1302997718$gmane$org@sisk.pl>
References: <201104130205.26988.rjw@sisk.pl> <201104170135.19388.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <201104170135.19388.rjw@sisk.pl>
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

From: Kevin Hilman <khilman@ti.com>

The platform_bus_set_pm_ops() operation is deprecated in favor of the
new device power domain infrastructre implemented in commit
7538e3db6e015e890825fbd9f8659952896ddd5b (PM: add support for device
power domains)

Signed-off-by: Kevin Hilman <khilman@ti.com>
Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
---
 drivers/base/platform.c         |   35 -----------------------------------
 include/linux/platform_device.h |    3 ---
 2 files changed, 38 deletions(-)

Index: linux-2.6/drivers/base/platform.c
===================================================================
--- linux-2.6.orig/drivers/base/platform.c
+++ linux-2.6/drivers/base/platform.c
@@ -916,41 +916,6 @@ struct bus_type platform_bus_type = {
 };
 EXPORT_SYMBOL_GPL(platform_bus_type);
 
-/**
- * platform_bus_get_pm_ops() - return pointer to busses dev_pm_ops
- *
- * This function can be used by platform code to get the current
- * set of dev_pm_ops functions used by the platform_bus_type.
- */
-const struct dev_pm_ops * __init platform_bus_get_pm_ops(void)
-{
-	return platform_bus_type.pm;
-}
-
-/**
- * platform_bus_set_pm_ops() - update dev_pm_ops for the platform_bus_type
- *
- * @pm: pointer to new dev_pm_ops struct to be used for platform_bus_type
- *
- * Platform code can override the dev_pm_ops methods of
- * platform_bus_type by using this function.  It is expected that
- * platform code will first do a platform_bus_get_pm_ops(), then
- * kmemdup it, then customize selected methods and pass a pointer to
- * the new struct dev_pm_ops to this function.
- *
- * Since platform-specific code is customizing methods for *all*
- * devices (not just platform-specific devices) it is expected that
- * any custom overrides of these functions will keep existing behavior
- * and simply extend it.  For example, any customization of the
- * runtime PM methods should continue to call the pm_generic_*
- * functions as the default ones do in addition to the
- * platform-specific behavior.
- */
-void __init platform_bus_set_pm_ops(const struct dev_pm_ops *pm)
-{
-	platform_bus_type.pm = pm;
-}
-
 int __init platform_bus_init(void)
 {
 	int error;
Index: linux-2.6/include/linux/platform_device.h
===================================================================
--- linux-2.6.orig/include/linux/platform_device.h
+++ linux-2.6/include/linux/platform_device.h
@@ -150,9 +150,6 @@ extern struct platform_device *platform_
 					struct resource *res, unsigned int n_res,
 					const void *data, size_t size);
 
-extern const struct dev_pm_ops * platform_bus_get_pm_ops(void);
-extern void platform_bus_set_pm_ops(const struct dev_pm_ops *pm);
-
 /* early platform driver interface */
 struct early_platform_driver {
 	const char *class_str;
