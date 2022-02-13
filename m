Return-Path: <linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D31DFC433F5
	for <linux-pm@archiver.kernel.org>; Sun, 13 Feb 2022 11:55:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235776AbiBMLzG (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Sun, 13 Feb 2022 06:55:06 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:58426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234887AbiBMLzF (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 13 Feb 2022 06:55:05 -0500
Received: from smtp.smtpout.orange.fr (smtp08.smtpout.orange.fr [80.12.242.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 939355B899
        for <linux-pm@vger.kernel.org>; Sun, 13 Feb 2022 03:54:59 -0800 (PST)
Received: from pop-os.home ([90.126.236.122])
        by smtp.orange.fr with ESMTPA
        id JDSznPi4gHZHJJDSznOoWw; Sun, 13 Feb 2022 12:54:58 +0100
X-ME-Helo: pop-os.home
X-ME-Auth: YWZlNiIxYWMyZDliZWIzOTcwYTEyYzlhMmU3ZiQ1M2U2MzfzZDfyZTMxZTBkMTYyNDBjNDJlZmQ3ZQ==
X-ME-Date: Sun, 13 Feb 2022 12:54:58 +0100
X-ME-IP: 90.126.236.122
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     Sebastian Reichel <sre@kernel.org>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        linux-pm@vger.kernel.org
Subject: [PATCH] power: supply: max14656: Use devm_work_autocancel()
Date:   Sun, 13 Feb 2022 12:54:56 +0100
Message-Id: <e73d025d989444354d3e9a4c44feb806653424dd.1644753283.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Use devm_delayed_work_autocancel() instead of hand writing it.
It saves a few lines of code.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 drivers/power/supply/max14656_charger_detector.c | 15 ++++-----------
 1 file changed, 4 insertions(+), 11 deletions(-)

diff --git a/drivers/power/supply/max14656_charger_detector.c b/drivers/power/supply/max14656_charger_detector.c
index 3f49b29f3c88..fc36828895bf 100644
--- a/drivers/power/supply/max14656_charger_detector.c
+++ b/drivers/power/supply/max14656_charger_detector.c
@@ -18,6 +18,7 @@
 #include <linux/of_device.h>
 #include <linux/workqueue.h>
 #include <linux/power_supply.h>
+#include <linux/devm-helpers.h>
 
 #define MAX14656_MANUFACTURER	"Maxim Integrated"
 #define MAX14656_NAME		"max14656"
@@ -233,14 +234,6 @@ static enum power_supply_property max14656_battery_props[] = {
 	POWER_SUPPLY_PROP_MANUFACTURER,
 };
 
-static void stop_irq_work(void *data)
-{
-	struct max14656_chip *chip = data;
-
-	cancel_delayed_work_sync(&chip->irq_work);
-}
-
-
 static int max14656_probe(struct i2c_client *client,
 			  const struct i2c_device_id *id)
 {
@@ -286,10 +279,10 @@ static int max14656_probe(struct i2c_client *client,
 		return -EINVAL;
 	}
 
-	INIT_DELAYED_WORK(&chip->irq_work, max14656_irq_worker);
-	ret = devm_add_action(dev, stop_irq_work, chip);
+	ret = devm_delayed_work_autocancel(dev, &chip->irq_work,
+					   max14656_irq_worker);
 	if (ret) {
-		dev_err(dev, "devm_add_action %d failed\n", ret);
+		dev_err(dev, "devm_delayed_work_autocancel %d failed\n", ret);
 		return ret;
 	}
 
-- 
2.32.0

