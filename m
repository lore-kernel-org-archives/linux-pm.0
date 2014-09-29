From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH] PM / Domains: Move dev_pm_domain_attach|detach() to pm_domain.h
Date: Mon, 29 Sep 2014 13:58:47 +0200
Message-ID: <1411991927-19654-1-git-send-email-ulf.hansson@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-we0-f180.google.com ([74.125.82.180]:43825 "EHLO
	mail-we0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750717AbaI2L6w (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 29 Sep 2014 07:58:52 -0400
Received: by mail-we0-f180.google.com with SMTP id x48so2037518wes.11
        for <linux-pm@vger.kernel.org>; Mon, 29 Sep 2014 04:58:51 -0700 (PDT)
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, linux-pm@vger.kernel.org
Cc: Geert Uytterhoeven <geert+renesas@glider.be>, Kevin Hilman <khilman@linaro.org>, Tomasz Figa <tomasz.figa@gmail.com>, Philipp Zabel <philipp.zabel@gmail.com>, Russell King <linux@arm.linux.org.uk>, Mark Brown <broonie@kernel.org>, Wolfram Sang <wsa@the-dreams.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Ulf Hansson <ulf.hansson@linaro.org>

The commit below, started using errno values in pm.h header file. It
also failed to include the header for these, thus it caused compiler
errors.

46420dd73b800f87a19af13af5883855cf38cb08
(PM / Domains: Add APIs to attach/detach a PM domain for a device)

Instead of including the errno header to pm.h, let's move the functions
to pm_domain.h, since it's a better match.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/amba/bus.c          |  1 +
 drivers/base/platform.c     |  1 +
 drivers/i2c/i2c-core.c      |  1 +
 drivers/mmc/core/sdio_bus.c |  1 +
 drivers/spi/spi.c           |  1 +
 include/linux/pm.h          | 11 -----------
 include/linux/pm_domain.h   | 11 +++++++++++
 7 files changed, 16 insertions(+), 11 deletions(-)

diff --git a/drivers/amba/bus.c b/drivers/amba/bus.c
index 8f52393..47bbdc1 100644
--- a/drivers/amba/bus.c
+++ b/drivers/amba/bus.c
@@ -15,6 +15,7 @@
 #include <linux/io.h>
 #include <linux/pm.h>
 #include <linux/pm_runtime.h>
+#include <linux/pm_domain.h>
 #include <linux/amba/bus.h>
 #include <linux/sizes.h>
 
diff --git a/drivers/base/platform.c b/drivers/base/platform.c
index 904be3d..b2afc29 100644
--- a/drivers/base/platform.c
+++ b/drivers/base/platform.c
@@ -21,6 +21,7 @@
 #include <linux/err.h>
 #include <linux/slab.h>
 #include <linux/pm_runtime.h>
+#include <linux/pm_domain.h>
 #include <linux/idr.h>
 #include <linux/acpi.h>
 #include <linux/clk/clk-conf.h>
diff --git a/drivers/i2c/i2c-core.c b/drivers/i2c/i2c-core.c
index 3cd8f11..e61a6c5 100644
--- a/drivers/i2c/i2c-core.c
+++ b/drivers/i2c/i2c-core.c
@@ -48,6 +48,7 @@
 #include <linux/irqflags.h>
 #include <linux/rwsem.h>
 #include <linux/pm_runtime.h>
+#include <linux/pm_domain.h>
 #include <linux/acpi.h>
 #include <linux/jump_label.h>
 #include <asm/uaccess.h>
diff --git a/drivers/mmc/core/sdio_bus.c b/drivers/mmc/core/sdio_bus.c
index 1df0fc6..65cf7a7 100644
--- a/drivers/mmc/core/sdio_bus.c
+++ b/drivers/mmc/core/sdio_bus.c
@@ -16,6 +16,7 @@
 #include <linux/export.h>
 #include <linux/slab.h>
 #include <linux/pm_runtime.h>
+#include <linux/pm_domain.h>
 #include <linux/acpi.h>
 
 #include <linux/mmc/card.h>
diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index 72a0beb..3907f14 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -35,6 +35,7 @@
 #include <linux/spi/spi.h>
 #include <linux/of_gpio.h>
 #include <linux/pm_runtime.h>
+#include <linux/pm_domain.h>
 #include <linux/export.h>
 #include <linux/sched/rt.h>
 #include <linux/delay.h>
diff --git a/include/linux/pm.h b/include/linux/pm.h
index c4cbf48..1022ba1 100644
--- a/include/linux/pm.h
+++ b/include/linux/pm.h
@@ -622,17 +622,6 @@ struct dev_pm_domain {
 	void (*detach)(struct device *dev, bool power_off);
 };
 
-#ifdef CONFIG_PM
-extern int dev_pm_domain_attach(struct device *dev, bool power_on);
-extern void dev_pm_domain_detach(struct device *dev, bool power_off);
-#else
-static inline int dev_pm_domain_attach(struct device *dev, bool power_on)
-{
-	return -ENODEV;
-}
-static inline void dev_pm_domain_detach(struct device *dev, bool power_off) {}
-#endif
-
 /*
  * The PM_EVENT_ messages are also used by drivers implementing the legacy
  * suspend framework, based on the ->suspend() and ->resume() callbacks common
diff --git a/include/linux/pm_domain.h b/include/linux/pm_domain.h
index ed4f4a7..9004743 100644
--- a/include/linux/pm_domain.h
+++ b/include/linux/pm_domain.h
@@ -301,4 +301,15 @@ static inline int of_genpd_add_provider_onecell(struct device_node *np,
 	return __of_genpd_add_provider(np, __of_genpd_xlate_onecell, data);
 }
 
+#ifdef CONFIG_PM
+extern int dev_pm_domain_attach(struct device *dev, bool power_on);
+extern void dev_pm_domain_detach(struct device *dev, bool power_off);
+#else
+static inline int dev_pm_domain_attach(struct device *dev, bool power_on)
+{
+	return -ENODEV;
+}
+static inline void dev_pm_domain_detach(struct device *dev, bool power_off) {}
+#endif
+
 #endif /* _LINUX_PM_DOMAIN_H */
-- 
1.9.1

