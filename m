From: Chris Lapa <chris@lapa.com.au>
Subject: [PATCH v3 6/7] max8903: remove unnecessary 'out of memory' error message.
Date: Fri, 17 Jun 2016 15:00:25 +1000
Message-ID: <1466139626-51434-7-git-send-email-chris@lapa.com.au>
References: <1464849897-21527-3-git-send-email-chris@lapa.com.au>
 <1466139626-51434-1-git-send-email-chris@lapa.com.au>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1466139626-51434-1-git-send-email-chris@lapa.com.au>
In-Reply-To: <1464849897-21527-3-git-send-email-chris@lapa.com.au>
References: <1464849897-21527-3-git-send-email-chris@lapa.com.au>
Sender: linux-kernel-owner@vger.kernel.org
To: k.kozlowski@samsung.com, dwmw2@infradead.org, dbaryshkov@gmail.com, sre@kernel.org, mark.rutland@arm.com, robh+dt@kernel.org
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Chris Lapa <chris@lapa.com.au>
List-Id: linux-pm@vger.kernel.org

From: Chris Lapa <chris@lapa.com.au>

Remove the 'out of memory' error message as it is printed by the core.

Signed-off-by: Chris Lapa <chris@lapa.com.au>
---
 drivers/power/max8903_charger.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/power/max8903_charger.c b/drivers/power/max8903_charger.c
index bfb81a2..5ddc667 100644
--- a/drivers/power/max8903_charger.c
+++ b/drivers/power/max8903_charger.c
@@ -196,10 +196,8 @@ static int max8903_probe(struct platform_device *pdev)
 	}
 
 	data = devm_kzalloc(dev, sizeof(struct max8903_data), GFP_KERNEL);
-	if (data == NULL) {
-		dev_err(dev, "Cannot allocate memory.\n");
+	if (!data)
 		return -ENOMEM;
-	}
 
 	data->pdata = pdev->dev.platform_data;
 	data->dev = dev;
-- 
1.9.1
