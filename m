From: Enric Balletbo i Serra <enric.balletbo@collabora.com>
Subject: [PATCH 1/2] power: supply: tps65217: remove debug messages for function calls
Date: Mon,  3 Apr 2017 18:44:45 +0200
Message-ID: <20170403164446.28076-1-enric.balletbo@collabora.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from bhuna.collabora.co.uk ([46.235.227.227]:47573 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753993AbdDCQo6 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 3 Apr 2017 12:44:58 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>, Rob Herring <robh+dt@kernel.org>, Lee Jones <lee.jones@linaro.org>
Cc: linux-pm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org

Equivalent information can be nowadays obtained using function tracer.

Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
---
 drivers/power/supply/tps65217_charger.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/power/supply/tps65217_charger.c b/drivers/power/supply/tps65217_charger.c
index 29b61e8..1f52340 100644
--- a/drivers/power/supply/tps65217_charger.c
+++ b/drivers/power/supply/tps65217_charger.c
@@ -58,8 +58,6 @@ static int tps65217_config_charger(struct tps65217_charger *charger)
 {
 	int ret;
 
-	dev_dbg(charger->dev, "%s\n", __func__);
-
 	/*
 	 * tps65217 rev. G, p. 31 (see p. 32 for NTC schematic)
 	 *
@@ -205,8 +203,6 @@ static int tps65217_charger_probe(struct platform_device *pdev)
 	int ret;
 	int i;
 
-	dev_dbg(&pdev->dev, "%s\n", __func__);
-
 	charger = devm_kzalloc(&pdev->dev, sizeof(*charger), GFP_KERNEL);
 	if (!charger)
 		return -ENOMEM;
-- 
2.9.3
