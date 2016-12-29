From: Colin King <colin.king@canonical.com>
Subject: [PATCH] power_supply: wm97xx_battery: remove redundant 2nd null check on pdata
Date: Thu, 29 Dec 2016 15:23:12 +0000
Message-ID: <20161229152312.20537-1-colin.king@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from youngberry.canonical.com ([91.189.89.112]:53502 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752311AbcL2PYA (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 29 Dec 2016 10:24:00 -0500
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>, linux-pm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

pdata is being null checked twice, the 2nd check is redundant code
and can be removed.

Fixes CoverityScan CID 1392340 "Logically dead code"

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/power/supply/wm97xx_battery.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/power/supply/wm97xx_battery.c b/drivers/power/supply/wm97xx_battery.c
index e3edb31..bd4f666 100644
--- a/drivers/power/supply/wm97xx_battery.c
+++ b/drivers/power/supply/wm97xx_battery.c
@@ -175,11 +175,6 @@ static int wm97xx_bat_probe(struct platform_device *dev)
 	if (dev->id != -1)
 		return -EINVAL;
 
-	if (!pdata) {
-		dev_err(&dev->dev, "No platform_data supplied\n");
-		return -EINVAL;
-	}
-
 	if (gpio_is_valid(pdata->charge_gpio)) {
 		ret = gpio_request(pdata->charge_gpio, "BATT CHRG");
 		if (ret)
-- 
2.10.2

