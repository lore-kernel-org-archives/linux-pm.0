From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH] jz4740-battery: Delete an error message for a failed memory
 allocation in jz_battery_probe()
Date: Sun, 17 Dec 2017 20:30:24 +0100
Message-ID: <54d86c99-fea3-ced3-12fa-b92b340228b0@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Language: en-GB
Sender: linux-kernel-owner@vger.kernel.org
To: linux-pm@vger.kernel.org, Sebastian Reichel <sre@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Sun, 17 Dec 2017 20:23:28 +0100

Omit an extra message for a memory allocation failure in this function.

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 drivers/power/supply/jz4740-battery.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/power/supply/jz4740-battery.c b/drivers/power/supply/jz4740-battery.c
index 88f04f4d1a70..5210c9a92e2d 100644
--- a/drivers/power/supply/jz4740-battery.c
+++ b/drivers/power/supply/jz4740-battery.c
@@ -254,10 +254,8 @@ static int jz_battery_probe(struct platform_device *pdev)
 	}
 
 	jz_battery = devm_kzalloc(&pdev->dev, sizeof(*jz_battery), GFP_KERNEL);
-	if (!jz_battery) {
-		dev_err(&pdev->dev, "Failed to allocate driver structure\n");
+	if (!jz_battery)
 		return -ENOMEM;
-	}
 
 	jz_battery->cell = mfd_get_cell(pdev);
 
-- 
2.15.1
