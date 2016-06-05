From: Paul Gortmaker <paul.gortmaker@windriver.com>
Subject: [PATCH] PM / clk: export symbols for existing pm_clk_<...> API fcns
Date: Sun, 5 Jun 2016 13:58:15 -0400
Message-ID: <1465149495-22961-1-git-send-email-paul.gortmaker@windriver.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.windriver.com ([147.11.1.11]:47798 "EHLO
	mail.windriver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751654AbcFER6t (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sun, 5 Jun 2016 13:58:49 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Paul Gortmaker <paul.gortmaker@windriver.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Vinod Koul <vinod.koul@intel.com>, Jon Hunter <jonathanh@nvidia.com>, linux-pm@vger.kernel.org

While trying to convert a DMA driver from bool to tristate, we
encountered the following:

ERROR: "pm_clk_add_clk" [drivers/dma/tegra210-adma.ko] undefined!
ERROR: "pm_clk_create" [drivers/dma/tegra210-adma.ko] undefined!
ERROR: "pm_clk_destroy" [drivers/dma/tegra210-adma.ko] undefined!
ERROR: "pm_clk_suspend" [drivers/dma/tegra210-adma.ko] undefined!
ERROR: "pm_clk_resume" [drivers/dma/tegra210-adma.ko] undefined!

Since in principle there is nothing preventing these functions
from being used in modular code as well as builtin, we add the
export of them.  We expand the scope to also include:

   pm_clk_add
   of_pm_clk_add_clks
   pm_clk_remove
   pm_clk_remove_clk
   pm_clk_init
   pm_clk_runtime_suspend
   pm_clk_runtime_resume
   pm_clk_add_notifier

...since these functions are also non-static and presumably form
part of the existing API used by other drivers that may become
modular in the future.

Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Pavel Machek <pavel@ucw.cz>
Cc: Len Brown <len.brown@intel.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Vinod Koul <vinod.koul@intel.com>
Cc: Jon Hunter <jonathanh@nvidia.com>
Cc: linux-pm@vger.kernel.org
Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
---
 drivers/base/power/clock_ops.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/base/power/clock_ops.c b/drivers/base/power/clock_ops.c
index 3657ac1cb801..761f5c21f9f0 100644
--- a/drivers/base/power/clock_ops.c
+++ b/drivers/base/power/clock_ops.c
@@ -121,6 +121,7 @@ int pm_clk_add(struct device *dev, const char *con_id)
 {
 	return __pm_clk_add(dev, con_id, NULL);
 }
+EXPORT_SYMBOL_GPL(pm_clk_add);
 
 /**
  * pm_clk_add_clk - Start using a device clock for power management.
@@ -136,6 +137,7 @@ int pm_clk_add_clk(struct device *dev, struct clk *clk)
 {
 	return __pm_clk_add(dev, NULL, clk);
 }
+EXPORT_SYMBOL_GPL(pm_clk_add_clk);
 
 
 /**
@@ -192,6 +194,7 @@ error:
 
 	return ret;
 }
+EXPORT_SYMBOL_GPL(of_pm_clk_add_clks);
 
 /**
  * __pm_clk_remove - Destroy PM clock entry.
@@ -252,6 +255,7 @@ void pm_clk_remove(struct device *dev, const char *con_id)
 
 	__pm_clk_remove(ce);
 }
+EXPORT_SYMBOL_GPL(pm_clk_remove);
 
 /**
  * pm_clk_remove_clk - Stop using a device clock for power management.
@@ -285,6 +289,7 @@ void pm_clk_remove_clk(struct device *dev, struct clk *clk)
 
 	__pm_clk_remove(ce);
 }
+EXPORT_SYMBOL_GPL(pm_clk_remove_clk);
 
 /**
  * pm_clk_init - Initialize a device's list of power management clocks.
@@ -299,6 +304,7 @@ void pm_clk_init(struct device *dev)
 	if (psd)
 		INIT_LIST_HEAD(&psd->clock_list);
 }
+EXPORT_SYMBOL_GPL(pm_clk_init);
 
 /**
  * pm_clk_create - Create and initialize a device's list of PM clocks.
@@ -311,6 +317,7 @@ int pm_clk_create(struct device *dev)
 {
 	return dev_pm_get_subsys_data(dev);
 }
+EXPORT_SYMBOL_GPL(pm_clk_create);
 
 /**
  * pm_clk_destroy - Destroy a device's list of power management clocks.
@@ -345,6 +352,7 @@ void pm_clk_destroy(struct device *dev)
 		__pm_clk_remove(ce);
 	}
 }
+EXPORT_SYMBOL_GPL(pm_clk_destroy);
 
 /**
  * pm_clk_suspend - Disable clocks in a device's PM clock list.
@@ -375,6 +383,7 @@ int pm_clk_suspend(struct device *dev)
 
 	return 0;
 }
+EXPORT_SYMBOL_GPL(pm_clk_suspend);
 
 /**
  * pm_clk_resume - Enable clocks in a device's PM clock list.
@@ -400,6 +409,7 @@ int pm_clk_resume(struct device *dev)
 
 	return 0;
 }
+EXPORT_SYMBOL_GPL(pm_clk_resume);
 
 /**
  * pm_clk_notify - Notify routine for device addition and removal.
@@ -480,6 +490,7 @@ int pm_clk_runtime_suspend(struct device *dev)
 
 	return 0;
 }
+EXPORT_SYMBOL_GPL(pm_clk_runtime_suspend);
 
 int pm_clk_runtime_resume(struct device *dev)
 {
@@ -495,6 +506,7 @@ int pm_clk_runtime_resume(struct device *dev)
 
 	return pm_generic_runtime_resume(dev);
 }
+EXPORT_SYMBOL_GPL(pm_clk_runtime_resume);
 
 #else /* !CONFIG_PM_CLK */
 
@@ -598,3 +610,4 @@ void pm_clk_add_notifier(struct bus_type *bus,
 	clknb->nb.notifier_call = pm_clk_notify;
 	bus_register_notifier(bus, &clknb->nb);
 }
+EXPORT_SYMBOL_GPL(pm_clk_add_notifier);
-- 
2.8.0

