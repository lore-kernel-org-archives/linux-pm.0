From: Geert Uytterhoeven <geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>
Subject: [PATCH v2 5/7] staging: board: Add support for devices with complex dependencies
Date: Wed, 17 Jun 2015 10:38:54 +0200
Message-ID: <1434530336-15073-6-git-send-email-geert+renesas@glider.be>
References: <1434530336-15073-1-git-send-email-geert+renesas@glider.be>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1434530336-15073-1-git-send-email-geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Simon Horman <horms+renesas-/R6kz+dDXgpPR4JQBCEnsQ@public.gmane.org>, Magnus Damm <damm+renesas-yzvPICuk2ACczHhG9Qg4qA@public.gmane.org>
Cc: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, Laurent Pinchart <Laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>, Kuninori Morimoto <kuninori.morimoto.gx-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>, Marc Zyngier <marc.zyngier-5wv7dgnIgG8@public.gmane.org>, devel-gWbeCf7V1WCQmaza687I9mD2FQJk+8+b@public.gmane.org, linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Geert Uytterhoeven <geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

Add support for easy registering of one ore more platform devices that
may:
  - need clocks that are described in DT,
  - be part of a PM Domain.

All these dependencies are optional.

Signed-off-by: Geert Uytterhoeven <geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>
---
v2:
  - Drop support for pinctrl, use standard pinctrl in DT instead,
  - Drop support for configured GPIOs, use "gpio-hog" in DT instead,
  - Use clk_add_alias() instead of open coding,
  - Update for changed function names,
  - Drop RFC status.
---
 drivers/staging/board/board.c | 56 +++++++++++++++++++++++++++++++++++++++++++
 drivers/staging/board/board.h | 20 ++++++++++++++++
 2 files changed, 76 insertions(+)

diff --git a/drivers/staging/board/board.c b/drivers/staging/board/board.c
index 8712f566b31196e0..29d456e29f38feac 100644
--- a/drivers/staging/board/board.c
+++ b/drivers/staging/board/board.c
@@ -9,6 +9,7 @@
 
 #define pr_fmt(fmt)	"board_staging: "  fmt
 
+#include <linux/clkdev.h>
 #include <linux/init.h>
 #include <linux/irq.h>
 #include <linux/device.h>
@@ -16,6 +17,8 @@
 #include <linux/of.h>
 #include <linux/of_address.h>
 #include <linux/of_irq.h>
+#include <linux/platform_device.h>
+#include <linux/pm_domain.h>
 
 #include "board.h"
 
@@ -118,3 +121,56 @@ void __init board_staging_gic_fixup_resources(struct resource *res,
 	for (i = 0; i < nres; i++)
 		gic_fixup_resource(&res[i]);
 }
+
+int __init board_staging_register_clock(const struct board_staging_clk *bsc)
+{
+	int error;
+
+	pr_debug("Aliasing clock %s for con_id %s dev_id %s\n", bsc->clk,
+		 bsc->con_id, bsc->dev_id);
+	error = clk_add_alias(bsc->con_id, bsc->dev_id, bsc->clk, NULL);
+	if (error)
+		pr_err("Failed to alias clock %s (%d)\n", bsc->clk, error);
+
+	return error;
+}
+
+int __init board_staging_register_device(const struct board_staging_dev *dev)
+{
+	struct platform_device *pdev = dev->pdev;
+	unsigned int i;
+	int error;
+
+	pr_debug("Trying to register device %s\n", pdev->name);
+	if (board_staging_dt_node_available(pdev->resource,
+					    pdev->num_resources)) {
+		pr_warn("Skipping %s, already in DT\n", pdev->name);
+		return -EEXIST;
+	}
+
+	board_staging_gic_fixup_resources(pdev->resource, pdev->num_resources);
+
+	for (i = 0; i < dev->nclocks; i++)
+		board_staging_register_clock(&dev->clocks[i]);
+
+	error = platform_device_register(pdev);
+	if (error) {
+		pr_err("Failed to register device %s (%d)\n", pdev->name,
+		       error);
+		return error;
+	}
+
+	if (dev->domain)
+		__pm_genpd_name_add_device(dev->domain, &pdev->dev, NULL);
+
+	return error;
+}
+
+void __init board_staging_register_devices(const struct board_staging_dev *devs,
+					   unsigned int ndevs)
+{
+	unsigned int i;
+
+	for (i = 0; i < ndevs; i++)
+		board_staging_register_device(&devs[i]);
+}
diff --git a/drivers/staging/board/board.h b/drivers/staging/board/board.h
index 3af6dbe22f91ebdc..42ed125132201327 100644
--- a/drivers/staging/board/board.h
+++ b/drivers/staging/board/board.h
@@ -4,12 +4,32 @@
 #include <linux/init.h>
 #include <linux/of.h>
 
+struct board_staging_clk {
+	const char *clk;
+	const char *con_id;
+	const char *dev_id;
+};
+
+struct board_staging_dev {
+	/* Platform Device */
+	struct platform_device *pdev;
+	/* Clocks (optional) */
+	const struct board_staging_clk *clocks;
+	unsigned int nclocks;
+	/* Generic PM Domain (optional) */
+	const char *domain;
+};
+
 struct resource;
 
 bool board_staging_dt_node_available(const struct resource *resource,
 				     unsigned int num_resources);
 int board_staging_gic_setup_xlate(const char *gic_match, unsigned int base);
 void board_staging_gic_fixup_resources(struct resource *res, unsigned int nres);
+int board_staging_register_clock(const struct board_staging_clk *bsc);
+int board_staging_register_device(const struct board_staging_dev *dev);
+void board_staging_register_devices(const struct board_staging_dev *devs,
+				    unsigned int ndevs);
 
 #define board_staging(str, fn)			\
 static int __init runtime_board_check(void)	\
-- 
1.9.1

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
