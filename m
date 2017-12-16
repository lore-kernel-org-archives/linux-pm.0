From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH] tps65090-charger: Delete an error message for a failed memory
 allocation in two functions
Date: Sat, 16 Dec 2017 19:43:07 +0100
Message-ID: <aa138aa9-d8c9-c6e3-7071-9fc642e7b248@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mout.web.de ([212.227.15.14]:53336 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753577AbdLPSnP (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Sat, 16 Dec 2017 13:43:15 -0500
Content-Language: en-GB
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org, Sebastian Reichel <sre@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Sat, 16 Dec 2017 19:32:02 +0100

Omit an extra message for a memory allocation failure in these functions.

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 drivers/power/supply/tps65090-charger.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/power/supply/tps65090-charger.c b/drivers/power/supply/tps65090-charger.c
index 1b4b5e09538e..43c44d2eaeca 100644
--- a/drivers/power/supply/tps65090-charger.c
+++ b/drivers/power/supply/tps65090-charger.c
@@ -202,10 +202,8 @@ static struct tps65090_platform_data *
 	unsigned int prop;
 
 	pdata = devm_kzalloc(&pdev->dev, sizeof(*pdata), GFP_KERNEL);
-	if (!pdata) {
-		dev_err(&pdev->dev, "Memory alloc for tps65090_pdata failed\n");
+	if (!pdata)
 		return NULL;
-	}
 
 	prop = of_property_read_bool(np, "ti,enable-low-current-chrg");
 	pdata->enable_low_current_chrg = prop;
@@ -257,10 +255,8 @@ static int tps65090_charger_probe(struct platform_device *pdev)
 	}
 
 	cdata = devm_kzalloc(&pdev->dev, sizeof(*cdata), GFP_KERNEL);
-	if (!cdata) {
-		dev_err(&pdev->dev, "failed to allocate memory status\n");
+	if (!cdata)
 		return -ENOMEM;
-	}
 
 	platform_set_drvdata(pdev, cdata);
 
-- 
2.15.1
