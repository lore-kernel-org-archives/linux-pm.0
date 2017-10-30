From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH 1/2] max8997_charger: Use common error handling code in
 max8997_battery_probe()
Date: Mon, 30 Oct 2017 22:35:25 +0100
Message-ID: <d60769d4-97cc-5965-d282-8484987f019e@users.sourceforge.net>
References: <286b1fea-ccff-5fed-5e2d-fc3b0064cd4d@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <kernel-janitors-owner@vger.kernel.org>
In-Reply-To: <286b1fea-ccff-5fed-5e2d-fc3b0064cd4d@users.sourceforge.net>
Content-Language: en-GB
Sender: kernel-janitors-owner@vger.kernel.org
To: linux-pm@vger.kernel.org, Sebastian Reichel <sre@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Mon, 30 Oct 2017 22:14:52 +0100

Add a jump target so that a specific error message is stored only once
at the end of this function implementation.
Replace two calls of the function "dev_err" by goto statements.

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 drivers/power/supply/max8997_charger.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/power/supply/max8997_charger.c b/drivers/power/supply/max8997_charger.c
index fa861003fece..38a01706a56b 100644
--- a/drivers/power/supply/max8997_charger.c
+++ b/drivers/power/supply/max8997_charger.c
@@ -113,10 +113,8 @@ static int max8997_battery_probe(struct platform_device *pdev)
 
 		ret = max8997_update_reg(iodev->i2c,
 				MAX8997_REG_MBCCTRL5, val, 0xf);
-		if (ret < 0) {
-			dev_err(&pdev->dev, "Cannot use i2c bus.\n");
-			return ret;
-		}
+		if (ret < 0)
+			goto report_bus_failure;
 	}
 
 	switch (pdata->timeout) {
@@ -141,10 +139,8 @@ static int max8997_battery_probe(struct platform_device *pdev)
 				pdata->timeout);
 		return -EINVAL;
 	}
-	if (ret < 0) {
-		dev_err(&pdev->dev, "Cannot use i2c bus.\n");
-		return ret;
-	}
+	if (ret < 0)
+		goto report_bus_failure;
 
 	charger = devm_kzalloc(&pdev->dev, sizeof(struct charger_data),
 				GFP_KERNEL);
@@ -168,6 +164,10 @@ static int max8997_battery_probe(struct platform_device *pdev)
 	}
 
 	return 0;
+
+report_bus_failure:
+	dev_err(&pdev->dev, "Cannot use i2c bus.\n");
+	return ret;
 }
 
 static const struct platform_device_id max8997_battery_id[] = {
-- 
2.14.3

