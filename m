From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Subject: [PATCH v3 2/2] power/reset: at91-poweroff: timely shutdown LPDDR memories
Date: Tue, 25 Oct 2016 11:37:59 +0200
Message-ID: <20161025093759.20913-3-alexandre.belloni@free-electrons.com>
References: <20161025093759.20913-1-alexandre.belloni@free-electrons.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from up.free-electrons.com ([163.172.77.33]:36944 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1758513AbcJYJiN (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 25 Oct 2016 05:38:13 -0400
In-Reply-To: <20161025093759.20913-1-alexandre.belloni@free-electrons.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
Cc: Nicolas Ferre <nicolas.ferre@atmel.com>, Jean-Jacques Hiblot <jjhiblot@traphandler.com>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Alexandre Belloni <alexandre.belloni@free-electrons.com>, "# 4 . 4+" <stable@vger.kernel.org>

LPDDR memories can only handle up to 400 uncontrolled power off. Ensure the
proper power off sequence is used before shutting down the platform.

Cc: <stable@vger.kernel.org> # 4.4+
Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
---
 drivers/power/reset/Kconfig              |  2 +-
 drivers/power/reset/at91-poweroff.c      | 54 +++++++++++++++++++++++++++++++-
 drivers/power/reset/at91-sama5d2_shdwc.c | 49 ++++++++++++++++++++++++++++-
 3 files changed, 102 insertions(+), 3 deletions(-)

diff --git a/drivers/power/reset/Kconfig b/drivers/power/reset/Kconfig
index c74c3f67b8da..02e46bbcf45d 100644
--- a/drivers/power/reset/Kconfig
+++ b/drivers/power/reset/Kconfig
@@ -32,7 +32,7 @@ config POWER_RESET_AT91_RESET
 
 config POWER_RESET_AT91_SAMA5D2_SHDWC
 	tristate "Atmel AT91 SAMA5D2-Compatible shutdown controller driver"
-	depends on ARCH_AT91 || COMPILE_TEST
+	depends on ARCH_AT91
 	default SOC_SAMA5
 	help
 	  This driver supports the alternate shutdown controller for some Atmel
diff --git a/drivers/power/reset/at91-poweroff.c b/drivers/power/reset/at91-poweroff.c
index e9e24df35f26..2579f025b90b 100644
--- a/drivers/power/reset/at91-poweroff.c
+++ b/drivers/power/reset/at91-poweroff.c
@@ -14,9 +14,12 @@
 #include <linux/io.h>
 #include <linux/module.h>
 #include <linux/of.h>
+#include <linux/of_address.h>
 #include <linux/platform_device.h>
 #include <linux/printk.h>
 
+#include <soc/at91/at91sam9_ddrsdr.h>
+
 #define AT91_SHDW_CR	0x00		/* Shut Down Control Register */
 #define AT91_SHDW_SHDW		BIT(0)			/* Shut Down command */
 #define AT91_SHDW_KEY		(0xa5 << 24)		/* KEY Password */
@@ -50,6 +53,7 @@ static const char *shdwc_wakeup_modes[] = {
 
 static void __iomem *at91_shdwc_base;
 static struct clk *sclk;
+static void __iomem *mpddrc_base;
 
 static void __init at91_wakeup_status(void)
 {
@@ -73,6 +77,29 @@ static void at91_poweroff(void)
 	writel(AT91_SHDW_KEY | AT91_SHDW_SHDW, at91_shdwc_base + AT91_SHDW_CR);
 }
 
+static void at91_lpddr_poweroff(void)
+{
+	asm volatile(
+		/* Align to cache lines */
+		".balign 32\n\t"
+
+		/* Ensure AT91_SHDW_CR is in the TLB by reading it */
+		"	ldr	r6, [%2, #" __stringify(AT91_SHDW_CR) "]\n\t"
+
+		/* Power down SDRAM0 */
+		"	str	%1, [%0, #" __stringify(AT91_DDRSDRC_LPR) "]\n\t"
+		/* Shutdown CPU */
+		"	str	%3, [%2, #" __stringify(AT91_SHDW_CR) "]\n\t"
+
+		"	b	.\n\t"
+		:
+		: "r" (mpddrc_base),
+		  "r" cpu_to_le32(AT91_DDRSDRC_LPDDR2_PWOFF),
+		  "r" (at91_shdwc_base),
+		  "r" cpu_to_le32(AT91_SHDW_KEY | AT91_SHDW_SHDW)
+		: "r0");
+}
+
 static int at91_poweroff_get_wakeup_mode(struct device_node *np)
 {
 	const char *pm;
@@ -124,6 +151,8 @@ static void at91_poweroff_dt_set_wakeup_mode(struct platform_device *pdev)
 static int __init at91_poweroff_probe(struct platform_device *pdev)
 {
 	struct resource *res;
+	struct device_node *np;
+	u32 ddr_type;
 	int ret;
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
@@ -150,12 +179,30 @@ static int __init at91_poweroff_probe(struct platform_device *pdev)
 
 	pm_power_off = at91_poweroff;
 
+	np = of_find_compatible_node(NULL, NULL, "atmel,sama5d3-ddramc");
+	if (!np)
+		return 0;
+
+	mpddrc_base = of_iomap(np, 0);
+	of_node_put(np);
+
+	if (!mpddrc_base)
+		return 0;
+
+	ddr_type = readl(mpddrc_base + AT91_DDRSDRC_MDR) & AT91_DDRSDRC_MD;
+	if ((ddr_type == AT91_DDRSDRC_MD_LPDDR2) ||
+	    (ddr_type == AT91_DDRSDRC_MD_LPDDR3))
+		pm_power_off = at91_lpddr_poweroff;
+	else
+		iounmap(mpddrc_base);
+
 	return 0;
 }
 
 static int __exit at91_poweroff_remove(struct platform_device *pdev)
 {
-	if (pm_power_off == at91_poweroff)
+	if (pm_power_off == at91_poweroff ||
+	    pm_power_off == at91_lpddr_poweroff)
 		pm_power_off = NULL;
 
 	clk_disable_unprepare(sclk);
@@ -163,6 +210,11 @@ static int __exit at91_poweroff_remove(struct platform_device *pdev)
 	return 0;
 }
 
+static const struct of_device_id at91_ramc_of_match[] = {
+	{ .compatible = "atmel,sama5d3-ddramc", },
+	{ /* sentinel */ }
+};
+
 static const struct of_device_id at91_poweroff_of_match[] = {
 	{ .compatible = "atmel,at91sam9260-shdwc", },
 	{ .compatible = "atmel,at91sam9rl-shdwc", },
diff --git a/drivers/power/reset/at91-sama5d2_shdwc.c b/drivers/power/reset/at91-sama5d2_shdwc.c
index 8a5ac9706c9c..90b0b5a70ce5 100644
--- a/drivers/power/reset/at91-sama5d2_shdwc.c
+++ b/drivers/power/reset/at91-sama5d2_shdwc.c
@@ -22,9 +22,12 @@
 #include <linux/io.h>
 #include <linux/module.h>
 #include <linux/of.h>
+#include <linux/of_address.h>
 #include <linux/platform_device.h>
 #include <linux/printk.h>
 
+#include <soc/at91/at91sam9_ddrsdr.h>
+
 #define SLOW_CLOCK_FREQ	32768
 
 #define AT91_SHDW_CR	0x00		/* Shut Down Control Register */
@@ -75,6 +78,7 @@ struct shdwc {
  */
 static struct shdwc *at91_shdwc;
 static struct clk *sclk;
+static void __iomem *mpddrc_base;
 
 static const unsigned long long sdwc_dbc_period[] = {
 	0, 3, 32, 512, 4096, 32768,
@@ -108,6 +112,29 @@ static void at91_poweroff(void)
 	       at91_shdwc->at91_shdwc_base + AT91_SHDW_CR);
 }
 
+static void at91_lpddr_poweroff(void)
+{
+	asm volatile(
+		/* Align to cache lines */
+		".balign 32\n\t"
+
+		/* Ensure AT91_SHDW_CR is in the TLB by reading it */
+		"	ldr	r6, [%2, #" __stringify(AT91_SHDW_CR) "]\n\t"
+
+		/* Power down SDRAM0 */
+		"	str	%1, [%0, #" __stringify(AT91_DDRSDRC_LPR) "]\n\t"
+		/* Shutdown CPU */
+		"	str	%3, [%2, #" __stringify(AT91_SHDW_CR) "]\n\t"
+
+		"	b	.\n\t"
+		:
+		: "r" (mpddrc_base),
+		  "r" cpu_to_le32(AT91_DDRSDRC_LPDDR2_PWOFF),
+		  "r" (at91_shdwc->at91_shdwc_base),
+		  "r" cpu_to_le32(AT91_SHDW_KEY | AT91_SHDW_SHDW)
+		: "r0");
+}
+
 static u32 at91_shdwc_debouncer_value(struct platform_device *pdev,
 				      u32 in_period_us)
 {
@@ -212,6 +239,8 @@ static int __init at91_shdwc_probe(struct platform_device *pdev)
 {
 	struct resource *res;
 	const struct of_device_id *match;
+	struct device_node *np;
+	u32 ddr_type;
 	int ret;
 
 	if (!pdev->dev.of_node)
@@ -249,6 +278,23 @@ static int __init at91_shdwc_probe(struct platform_device *pdev)
 
 	pm_power_off = at91_poweroff;
 
+	np = of_find_compatible_node(NULL, NULL, "atmel,sama5d3-ddramc");
+	if (!np)
+		return 0;
+
+	mpddrc_base = of_iomap(np, 0);
+	of_node_put(np);
+
+	if (!mpddrc_base)
+		return 0;
+
+	ddr_type = readl(mpddrc_base + AT91_DDRSDRC_MDR) & AT91_DDRSDRC_MD;
+	if ((ddr_type == AT91_DDRSDRC_MD_LPDDR2) ||
+	    (ddr_type == AT91_DDRSDRC_MD_LPDDR3))
+		pm_power_off = at91_lpddr_poweroff;
+	else
+		iounmap(mpddrc_base);
+
 	return 0;
 }
 
@@ -256,7 +302,8 @@ static int __exit at91_shdwc_remove(struct platform_device *pdev)
 {
 	struct shdwc *shdw = platform_get_drvdata(pdev);
 
-	if (pm_power_off == at91_poweroff)
+	if (pm_power_off == at91_poweroff ||
+	    pm_power_off == at91_lpddr_poweroff)
 		pm_power_off = NULL;
 
 	/* Reset values to disable wake-up features  */
-- 
2.9.3

