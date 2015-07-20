From: Josh Wu <josh.wu-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>
Subject: [PATCH v2 1/2] power: reset: at91: add sama5d3 reset function
Date: Mon, 20 Jul 2015 17:32:05 +0800
Message-ID: <1437384726-24927-1-git-send-email-josh.wu@atmel.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Nicolas Ferre <nicolas.ferre-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
Cc: Josh Wu <josh.wu-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>, Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Ben Dooks <ben.dooks-4yDnlxn2s6sWdaTGBSpHTA@public.gmane.org>, Krzysztof Kozlowski <k.kozlowski.k-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Alexandre Belloni <alexandre.belloni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Sudeep Holla <sudeep.holla-5wv7dgnIgG8@public.gmane.org>, Wei Yongjun <yongjun_wei-zrsr2BFq86L20UzCJQGyNP8+0UxHXcjY@public.gmane.org>, Fabian Frederick <fabf-AgBVmzD5pcezQB+pC5nmwQ@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Boris Brezillon <boris.brezillon-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Dmitry Eremin-Solenikov <dbaryshkov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

This patch introduces a new compatible string: "atmel,sama5d3-rstc" and
new reset function for sama5d3 and later chips.

As in sama5d3 or later chips, we don't have to shutdown the DDR
controller before reset. Shutdown the DDR controller before reset is a
workaround to avoid DDR signal driving the bus, but since sama5d3 and
later chips there is no such a conflict.

So in this patch:
   1. the sama5d3 reset function only need to write the rstc register
and return.
   2. we can remove the code related with sama5d3 DDR controller as
we don't use it at all.

Signed-off-by: Josh Wu <josh.wu-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>
Acked-by: Nicolas Ferre <nicolas.ferre-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>
---

Changes in v2:
- aligned the function parameters to be consist with the coding style
- refined the commit log
- add binding document changes
- use of_device_is_compitable() instead

 .../devicetree/bindings/arm/atmel-at91.txt         |  2 +-
 drivers/power/reset/at91-reset.c                   | 26 ++++++++++++++++------
 2 files changed, 20 insertions(+), 8 deletions(-)

diff --git a/Documentation/devicetree/bindings/arm/atmel-at91.txt b/Documentation/devicetree/bindings/arm/atmel-at91.txt
index 424ac8c..dd998b9 100644
--- a/Documentation/devicetree/bindings/arm/atmel-at91.txt
+++ b/Documentation/devicetree/bindings/arm/atmel-at91.txt
@@ -87,7 +87,7 @@ One interrupt per TC channel in a TC block:
 
 RSTC Reset Controller required properties:
 - compatible: Should be "atmel,<chip>-rstc".
-  <chip> can be "at91sam9260" or "at91sam9g45"
+  <chip> can be "at91sam9260" or "at91sam9g45" or "sama5d3"
 - reg: Should contain registers location and length
 
 Example:
diff --git a/drivers/power/reset/at91-reset.c b/drivers/power/reset/at91-reset.c
index 36dc52f..c378d4e 100644
--- a/drivers/power/reset/at91-reset.c
+++ b/drivers/power/reset/at91-reset.c
@@ -123,6 +123,15 @@ static int at91sam9g45_restart(struct notifier_block *this, unsigned long mode,
 	return NOTIFY_DONE;
 }
 
+static int sama5d3_restart(struct notifier_block *this, unsigned long mode,
+			   void *cmd)
+{
+	writel(cpu_to_le32(AT91_RSTC_KEY | AT91_RSTC_PERRST | AT91_RSTC_PROCRST),
+	       at91_rstc_base);
+
+	return NOTIFY_DONE;
+}
+
 static void __init at91_reset_status(struct platform_device *pdev)
 {
 	u32 reg = readl(at91_rstc_base + AT91_RSTC_SR);
@@ -155,13 +164,13 @@ static void __init at91_reset_status(struct platform_device *pdev)
 static const struct of_device_id at91_ramc_of_match[] = {
 	{ .compatible = "atmel,at91sam9260-sdramc", },
 	{ .compatible = "atmel,at91sam9g45-ddramc", },
-	{ .compatible = "atmel,sama5d3-ddramc", },
 	{ /* sentinel */ }
 };
 
 static const struct of_device_id at91_reset_of_match[] = {
 	{ .compatible = "atmel,at91sam9260-rstc", .data = at91sam9260_restart },
 	{ .compatible = "atmel,at91sam9g45-rstc", .data = at91sam9g45_restart },
+	{ .compatible = "atmel,sama5d3-rstc", .data = sama5d3_restart },
 	{ /* sentinel */ }
 };
 
@@ -181,13 +190,16 @@ static int at91_reset_of_probe(struct platform_device *pdev)
 		return -ENODEV;
 	}
 
-	for_each_matching_node(np, at91_ramc_of_match) {
-		at91_ramc_base[idx] = of_iomap(np, 0);
-		if (!at91_ramc_base[idx]) {
-			dev_err(&pdev->dev, "Could not map ram controller address\n");
-			return -ENODEV;
+	if (!of_device_is_compatible(pdev->dev.of_node, "atmel,sama5d3-rstc")) {
+		/* we need to shutdown the ddr controller, so get ramc base */
+		for_each_matching_node(np, at91_ramc_of_match) {
+			at91_ramc_base[idx] = of_iomap(np, 0);
+			if (!at91_ramc_base[idx]) {
+				dev_err(&pdev->dev, "Could not map ram controller address\n");
+				return -ENODEV;
+			}
+			idx++;
 		}
-		idx++;
 	}
 
 	match = of_match_node(at91_reset_of_match, pdev->dev.of_node);
-- 
1.9.1

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
