From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH] generic-adc-battery: Delete an error message for a failed
 memory allocation in gab_probe()
Date: Sun, 17 Dec 2017 21:15:46 +0100
Message-ID: <250aa766-6be2-bc11-1d16-7e6b2b369169@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mout.web.de ([212.227.15.3]:64036 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1757370AbdLQUPy (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Sun, 17 Dec 2017 15:15:54 -0500
Content-Language: en-GB
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org, Sebastian Reichel <sre@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Sun, 17 Dec 2017 21:10:51 +0100

Omit an extra message for a memory allocation failure in this function.

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 drivers/power/supply/generic-adc-battery.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/power/supply/generic-adc-battery.c b/drivers/power/supply/generic-adc-battery.c
index 28dc056eaafa..bac71719091a 100644
--- a/drivers/power/supply/generic-adc-battery.c
+++ b/drivers/power/supply/generic-adc-battery.c
@@ -247,10 +247,8 @@ static int gab_probe(struct platform_device *pdev)
 	int index = 0;
 
 	adc_bat = devm_kzalloc(&pdev->dev, sizeof(*adc_bat), GFP_KERNEL);
-	if (!adc_bat) {
-		dev_err(&pdev->dev, "failed to allocate memory\n");
+	if (!adc_bat)
 		return -ENOMEM;
-	}
 
 	psy_cfg.drv_data = adc_bat;
 	psy_desc = &adc_bat->psy_desc;
-- 
2.15.1
