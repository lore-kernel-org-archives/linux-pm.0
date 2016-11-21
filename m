From: Nicola Saenz Julienne <nicolas.saenz@prodys.net>
Subject: [PATCH 1/2] power: supply: sbs-battery: use fixed device name
Date: Mon, 21 Nov 2016 19:04:50 +0100
Message-ID: <1479751491-8849-2-git-send-email-nicolas.saenz@prodys.net>
References: <1479751491-8849-1-git-send-email-nicolas.saenz@prodys.net>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from host.prodys.net ([89.248.106.65]:55325 "EHLO host.prodys.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753471AbcKUSLy (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 21 Nov 2016 13:11:54 -0500
In-Reply-To: <1479751491-8849-1-git-send-email-nicolas.saenz@prodys.net>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: sre@kernel.org
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, nicolas.saenz@prodys.net

The current device name for sbs-battery is derived from it's i2c address.
This is not acceptable if we want to be able to trigger the
"external_power_changed()" routine from a charger driver.

Signed-off-by: Nicola Saenz Julienne <nicolas.saenz@prodys.net>
---
 drivers/power/supply/sbs-battery.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/power/supply/sbs-battery.c b/drivers/power/supply/sbs-battery.c
index 8bb2eb3..9565c696 100644
--- a/drivers/power/supply/sbs-battery.c
+++ b/drivers/power/supply/sbs-battery.c
@@ -740,6 +740,7 @@ static void sbs_delayed_work(struct work_struct *work)
 }
 
 static const struct power_supply_desc sbs_default_desc = {
+	.name = "sbs-battery",
 	.type = POWER_SUPPLY_TYPE_BATTERY,
 	.properties = sbs_properties,
 	.num_properties = ARRAY_SIZE(sbs_properties),
@@ -762,11 +763,6 @@ static int sbs_probe(struct i2c_client *client,
 	if (!sbs_desc)
 		return -ENOMEM;
 
-	sbs_desc->name = devm_kasprintf(&client->dev, GFP_KERNEL, "sbs-%s",
-			dev_name(&client->dev));
-	if (!sbs_desc->name)
-		return -ENOMEM;
-
 	chip = devm_kzalloc(&client->dev, sizeof(struct sbs_info), GFP_KERNEL);
 	if (!chip)
 		return -ENOMEM;
-- 
2.7.4

