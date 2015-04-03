From: Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH/RFC 5/6] staging: board: Add support for devices with complex
 dependencies
Date: Fri,  3 Apr 2015 14:42:02 +0200
Message-ID: <1428064923-24950-6-git-send-email-geert+renesas@glider.be>
References: <1428064923-24950-1-git-send-email-geert+renesas@glider.be>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <driverdev-devel-bounces@linuxdriverproject.org>
In-Reply-To: <1428064923-24950-1-git-send-email-geert+renesas@glider.be>
List-Unsubscribe: <http://driverdev.linuxdriverproject.org/mailman/options/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=unsubscribe>
List-Archive: <http://driverdev.linuxdriverproject.org/pipermail/driverdev-devel/>
List-Post: <mailto:driverdev-devel@linuxdriverproject.org>
List-Help: <mailto:driverdev-devel-request@linuxdriverproject.org?subject=help>
List-Subscribe: <http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=subscribe>
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Magnus Damm <damm+renesas@opensource.se>, Arnd Bergmann <arnd@arndb.de>, Simon Horman <horms+renesas@verge.net.au>, Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: devel@driverdev.osuosl.org, devicetree@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>, linux-pm@vger.kernel.org, Marc Zyngier <marc.zyngier@arm.com>, linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-pm@vger.kernel.org

Add support for easy registering of one ore more platform devices that
may:
  - need clocks that are described in DT,
  - need pin control configuration,
  - rely on a configured GPIO,
  - be part of a PM Domain.

All these dependencies are optional.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/staging/board/board.c | 76 +++++++++++++++++++++++++++++++++++++++++++
 drivers/staging/board/board.h | 31 ++++++++++++++++++
 2 files changed, 107 insertions(+)

diff --git a/drivers/staging/board/board.c b/drivers/staging/board/board.c
index b84ac2837a20bf06..da2469e2d4262fac 100644
--- a/drivers/staging/board/board.c
+++ b/drivers/staging/board/board.c
@@ -9,6 +9,9 @@
 
 #define pr_fmt(fmt)	"board_staging: "  fmt
 
+#include <linux/clk.h>
+#include <linux/clkdev.h>
+#include <linux/gpio.h>
 #include <linux/init.h>
 #include <linux/irq.h>
 #include <linux/device.h>
@@ -16,6 +19,9 @@
 #include <linux/of.h>
 #include <linux/of_address.h>
 #include <linux/of_irq.h>
+#include <linux/pinctrl/machine.h>
+#include <linux/platform_device.h>
+#include <linux/pm_domain.h>
 
 #include "board.h"
 
@@ -104,3 +110,73 @@ void __init board_staging_fixup_irq_resources(struct resource *res,
 			res[i].start = virq;
 		}
 }
+
+int __init board_staging_register_clock(const struct board_staging_clk *bsc)
+{
+	struct clk *clk;
+	int error;
+
+	pr_debug("Registering clock %s for con_id %s dev_id %s\n", bsc->clk,
+		 bsc->con_id, bsc->dev_id);
+	clk = clk_get(NULL, bsc->clk);
+	if (IS_ERR(clk)) {
+		error = PTR_ERR(clk);
+		pr_err("Failed to get clock %s (%d)\n", bsc->clk, error);
+		return error;
+	}
+
+	error = clk_register_clkdev(clk, bsc->con_id, bsc->dev_id);
+	if (error)
+		pr_err("Failed to register clock %s (%d)\n", bsc->clk, error);
+		return error;
+
+	clk_put(clk);
+	return 0;
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
+	board_staging_fixup_irq_resources(pdev->resource, pdev->num_resources);
+
+	for (i = 0; i < dev->nclocks; i++)
+		board_staging_register_clock(&dev->clocks[i]);
+
+	if (dev->npinmaps)
+		pinctrl_register_mappings(dev->pinmaps, dev->npinmaps);
+
+	for (i = 0; i < dev->ngpios; i++)
+		gpio_request_one(dev->gpios[i].gpio, dev->gpios[i].flags,
+				 pdev->name);
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
index 4cedc3c46e287eb7..7aaa0f7d6fafb9e5 100644
--- a/drivers/staging/board/board.h
+++ b/drivers/staging/board/board.h
@@ -4,12 +4,43 @@
 #include <linux/init.h>
 #include <linux/of.h>
 
+struct board_staging_clk {
+	const char *clk;
+	const char *con_id;
+	const char *dev_id;
+};
+
+struct board_staging_gpio {
+	unsigned int gpio;
+	unsigned long flags;	/* See GPIOF_* */
+};
+
+struct board_staging_dev {
+	/* Platform Device */
+	struct platform_device *pdev;
+	/* Clocks (optional) */
+	const struct board_staging_clk *clocks;
+	unsigned int nclocks;
+	/* Pin Control Maps (optional) */
+	const struct pinctrl_map *pinmaps;
+	unsigned int npinmaps;
+	/* GPIOs (optional) */
+	const struct board_staging_gpio *gpios;
+	unsigned int ngpios;
+	/* PM Domain (optional) */
+	const char *domain;
+};
+
 struct resource;
 
 bool board_staging_dt_node_available(const struct resource *resource,
 				     unsigned int num_resources);
 int board_staging_setup_hwirq_xlate(const char *irqc_match, unsigned int base);
 void board_staging_fixup_irq_resources(struct resource *res, unsigned int nres);
+int board_staging_register_clock(const struct board_staging_clk *bsc);
+int board_staging_register_device(const struct board_staging_dev *dev);
+void board_staging_register_devices(const struct board_staging_dev *devs,
+				    unsigned int ndevs);
 
 #define board_staging(str, fn)			\
 static int __init runtime_board_check(void)	\
-- 
1.9.1
