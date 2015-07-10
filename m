From: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Subject: [PATCH] thermal: Drop owner assignment from platform_driver
Date: Fri, 10 Jul 2015 15:35:00 +0900
Message-ID: <1436510100-5368-1-git-send-email-k.kozlowski@samsung.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>, "open list:THERMAL" <linux-pm@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
Cc: Krzysztof Kozlowski <k.kozlowski@samsung.com>
List-Id: linux-pm@vger.kernel.org

platform_driver does not need to set an owner because
platform_driver_register() will set it.

Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>

---

The coccinelle script which generated the patch was sent here:
http://www.spinics.net/lists/kernel/msg2029903.html
---
 drivers/thermal/hisi_thermal.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/thermal/hisi_thermal.c b/drivers/thermal/hisi_thermal.c
index d5dd357ba57c..b49f97c734d0 100644
--- a/drivers/thermal/hisi_thermal.c
+++ b/drivers/thermal/hisi_thermal.c
@@ -405,7 +405,6 @@ static SIMPLE_DEV_PM_OPS(hisi_thermal_pm_ops,
 static struct platform_driver hisi_thermal_driver = {
 	.driver = {
 		.name		= "hisi_thermal",
-		.owner		= THIS_MODULE,
 		.pm		= &hisi_thermal_pm_ops,
 		.of_match_table = of_hisi_thermal_match,
 	},
-- 
1.9.1
