From: Colin King <colin.king@canonical.com>
Subject: [PATCH] thermal: rcar: check for NULL return of of_match_device
Date: Sat, 20 Feb 2016 22:23:27 +0000
Message-ID: <1456007007-11200-1-git-send-email-colin.king@canonical.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from youngberry.canonical.com ([91.189.89.112]:37762 "EHLO
	youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753119AbcBTWX3 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sat, 20 Feb 2016 17:23:29 -0500
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>, linux-pm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

of_match_device can potentially return NULL, so we need to check for
this case to avoid a null pointer dereference on of_id

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/thermal/rcar_thermal.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/thermal/rcar_thermal.c b/drivers/thermal/rcar_thermal.c
index 0e735ac..5943881 100644
--- a/drivers/thermal/rcar_thermal.c
+++ b/drivers/thermal/rcar_thermal.c
@@ -431,13 +431,17 @@ static int rcar_thermal_probe(struct platform_device *pdev)
 	struct device *dev = &pdev->dev;
 	struct resource *res, *irq;
 	const struct of_device_id *of_id = of_match_device(rcar_thermal_dt_ids, dev);
-	unsigned long of_data = (unsigned long)of_id->data;
+	unsigned long of_data;
 	int mres = 0;
 	int i;
 	int ret = -ENODEV;
 	int idle = IDLE_INTERVAL;
 	u32 enr_bits = 0;
 
+	if (!of_id)
+		return ret;
+	of_data = (unsigned long)of_id->data;
+
 	common = devm_kzalloc(dev, sizeof(*common), GFP_KERNEL);
 	if (!common)
 		return -ENOMEM;
-- 
2.7.0

