From: Chris Lapa <chris@lapa.com.au>
Subject: [PATCH v2 4/4] max8903: remove unnecessary malloc failed message print out.
Date: Fri, 10 Jun 2016 22:32:50 +1000
Message-ID: <1465561970-18377-5-git-send-email-chris@lapa.com.au>
References: <1464849897-21527-3-git-send-email-chris@lapa.com.au>
 <1465561970-18377-1-git-send-email-chris@lapa.com.au>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1465561970-18377-1-git-send-email-chris@lapa.com.au>
Sender: linux-kernel-owner@vger.kernel.org
To: k.kozlowski@samsung.com
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Chris Lapa <chris@lapa.com.au>
List-Id: linux-pm@vger.kernel.org

From: Chris Lapa <chris@lapa.com.au>

Signed-off-by: Chris Lapa <chris@lapa.com.au>
---
 drivers/power/max8903_charger.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/power/max8903_charger.c b/drivers/power/max8903_charger.c
index 20d4b55..d60f9b2 100644
--- a/drivers/power/max8903_charger.c
+++ b/drivers/power/max8903_charger.c
@@ -246,10 +246,8 @@ static int max8903_probe(struct platform_device *pdev)
 	int usb_in = 0;
 
 	charger = devm_kzalloc(dev, sizeof(struct max8903_data), GFP_KERNEL);
-	if (charger == NULL) {
-		dev_err(dev, "Cannot allocate memory.\n");
+	if (!charger)
 		return -ENOMEM;
-	}
 
 	charger->pdata = pdev->dev.platform_data;
 	if (IS_ENABLED(CONFIG_OF) && !charger->pdata && dev->of_node) {
-- 
1.9.1
