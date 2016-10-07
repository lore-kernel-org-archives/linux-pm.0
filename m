From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Subject: [PATCH 2/2] power/reset: at91-poweroff: timely shitdown LPDDR memories
Date: Fri,  7 Oct 2016 18:34:27 +0200
Message-ID: <20161007163427.11454-3-alexandre.belloni@free-electrons.com>
References: <20161007163427.11454-1-alexandre.belloni@free-electrons.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20161007163427.11454-1-alexandre.belloni@free-electrons.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
Cc: Nicolas Ferre <nicolas.ferre@atmel.com>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Alexandre Belloni <alexandre.belloni@free-electrons.com>
List-Id: linux-pm@vger.kernel.org

LPDDR memories can only handle up to 400 uncontrolled power off. Ensure the
proper power off sequence is used before shutting down the platform.

Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
---
 drivers/power/reset/at91-poweroff.c      | 52 +++++++++++++++++++++++++++++++-
 drivers/power/reset/at91-sama5d2_shdwc.c | 48 ++++++++++++++++++++++++++++-
 2 files changed, 98 insertions(+), 2 deletions(-)

diff --git a/drivers/power/reset/at91-poweroff.c b/drivers/power/reset/at91-poweroff.c
index e9e24df35f26..bf97390e6cd7 100644
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
@@ -73,6 +77,28 @@ static void at91_poweroff(void)
 	writel(AT91_SHDW_KEY | AT91_SHDW_SHDW, at91_shdwc_base + AT91_SHDW_CR);
 }
 
+static void at91_lpddr_poweroff(void)
+{
+	asm volatile(
+		/* Align to cache lines */
+		".balign 32\n\t"
+
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
@@ -124,6 +150,8 @@ static void at91_poweroff_dt_set_wakeup_mode(struct platform_device *pdev)
 static int __init at91_poweroff_probe(struct platform_device *pdev)
 {
 	struct resource *res;
+	struct device_node *np;
+	u32 ddr_type;
 	int ret;
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
@@ -150,12 +178,29 @@ static int __init at91_poweroff_probe(struct platform_device *pdev)
 
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
@@ -163,6 +208,11 @@ static int __exit at91_poweroff_remove(struct platform_device *pdev)
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
index 8a5ac9706c9c..5736f360b374 100644
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
@@ -108,6 +112,28 @@ static void at91_poweroff(void)
 	       at91_shdwc->at91_shdwc_base + AT91_SHDW_CR);
 }
 
+static void at91_lpddr_poweroff(void)
+{
+	asm volatile(
+		/* Align to cache lines */
+		".balign 32\n\t"
+
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
@@ -212,6 +238,8 @@ static int __init at91_shdwc_probe(struct platform_device *pdev)
 {
 	struct resource *res;
 	const struct of_device_id *match;
+	struct device_node *np;
+	u32 ddr_type;
 	int ret;
 
 	if (!pdev->dev.of_node)
@@ -249,6 +277,23 @@ static int __init at91_shdwc_probe(struct platform_device *pdev)
 
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
 
@@ -256,7 +301,8 @@ static int __exit at91_shdwc_remove(struct platform_device *pdev)
 {
 	struct shdwc *shdw = platform_get_drvdata(pdev);
 
-	if (pm_power_off == at91_poweroff)
+	if (pm_power_off == at91_poweroff ||
+	    pm_power_off == at91_lpddr_poweroff)
 		pm_power_off = NULL;
 
 	/* Reset values to disable wake-up features  */
-- 
2.9.3
