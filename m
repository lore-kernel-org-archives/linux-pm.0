From: Kevin Cernekee <cernekee@gmail.com>
Subject: [PATCH 2/9] power/reset: brcmstb: Use the DT "compatible" string to indicate bit positions
Date: Tue, 25 Nov 2014 16:49:47 -0800
Message-ID: <1416962994-27095-3-git-send-email-cernekee@gmail.com>
References: <1416962994-27095-1-git-send-email-cernekee@gmail.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pd0-f172.google.com ([209.85.192.172]:51517 "EHLO
	mail-pd0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752035AbaKZAv1 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 25 Nov 2014 19:51:27 -0500
In-Reply-To: <1416962994-27095-1-git-send-email-cernekee@gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: sre@kernel.org, dbaryshkov@gmail.com, dwmw2@infradead.org, arnd@arndb.de, linux@prisktech.co.nz, stern@rowland.harvard.edu, gregkh@linuxfoundation.org, f.fainelli@gmail.com
Cc: grant.likely@linaro.org, robh+dt@kernel.org, computersforpeace@gmail.com, marc.ceeeee@gmail.com, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-usb@vger.kernel.org, linux-mips@linux-mips.org

Some of the older chips used different bits to arm and trigger the reset.
Add the infrastructure needed to specify this through the "compatible"
string.

Signed-off-by: Kevin Cernekee <cernekee@gmail.com>
---
 drivers/power/reset/brcmstb-reboot.c | 35 ++++++++++++++++++++++++++++-------
 1 file changed, 28 insertions(+), 7 deletions(-)

diff --git a/drivers/power/reset/brcmstb-reboot.c b/drivers/power/reset/brcmstb-reboot.c
index 3306241..4e61c3f 100644
--- a/drivers/power/reset/brcmstb-reboot.c
+++ b/drivers/power/reset/brcmstb-reboot.c
@@ -11,6 +11,7 @@
  * GNU General Public License for more details.
  */
 
+#include <linux/bitops.h>
 #include <linux/device.h>
 #include <linux/errno.h>
 #include <linux/init.h>
@@ -34,13 +35,20 @@ static struct regmap *regmap;
 static u32 rst_src_en;
 static u32 sw_mstr_rst;
 
+struct reset_reg_mask {
+	u32 rst_src_en_mask;
+	u32 sw_mstr_rst_mask;
+};
+
+static const struct reset_reg_mask *reset_masks;
+
 static int brcmstb_restart_handler(struct notifier_block *this,
 				   unsigned long mode, void *cmd)
 {
 	int rc;
 	u32 tmp;
 
-	rc = regmap_write(regmap, rst_src_en, 1);
+	rc = regmap_write(regmap, rst_src_en, reset_masks->rst_src_en_mask);
 	if (rc) {
 		pr_err("failed to write rst_src_en (%d)\n", rc);
 		return NOTIFY_DONE;
@@ -52,7 +60,7 @@ static int brcmstb_restart_handler(struct notifier_block *this,
 		return NOTIFY_DONE;
 	}
 
-	rc = regmap_write(regmap, sw_mstr_rst, 1);
+	rc = regmap_write(regmap, sw_mstr_rst, reset_masks->sw_mstr_rst_mask);
 	if (rc) {
 		pr_err("failed to write sw_mstr_rst (%d)\n", rc);
 		return NOTIFY_DONE;
@@ -75,10 +83,28 @@ static struct notifier_block brcmstb_restart_nb = {
 	.priority = 128,
 };
 
+static const struct reset_reg_mask reset_bits_40nm = {
+	.rst_src_en_mask = BIT(0),
+	.sw_mstr_rst_mask = BIT(0),
+};
+
+static const struct of_device_id of_match[] = {
+	{ .compatible = "brcm,brcmstb-reboot", .data = &reset_bits_40nm },
+	{},
+};
+
 static int brcmstb_reboot_probe(struct platform_device *pdev)
 {
 	int rc;
 	struct device_node *np = pdev->dev.of_node;
+	const struct of_device_id *of_id;
+
+	of_id = of_match_node(of_match, np);
+	if (!of_id) {
+		pr_err("failed to look up compatible string\n");
+		return -EINVAL;
+	}
+	reset_masks = of_id->data;
 
 	regmap = syscon_regmap_lookup_by_phandle(np, "syscon");
 	if (IS_ERR(regmap)) {
@@ -108,11 +134,6 @@ static int brcmstb_reboot_probe(struct platform_device *pdev)
 	return 0;
 }
 
-static const struct of_device_id of_match[] = {
-	{ .compatible = "brcm,brcmstb-reboot", },
-	{},
-};
-
 static struct platform_driver brcmstb_reboot_driver = {
 	.probe = brcmstb_reboot_probe,
 	.driver = {
-- 
2.1.0

