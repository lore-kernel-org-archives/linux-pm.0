Return-Path: <linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A393C433FE
	for <linux-pm@archiver.kernel.org>; Sun, 13 Feb 2022 17:07:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234318AbiBMRHU (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Sun, 13 Feb 2022 12:07:20 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:55602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237192AbiBMRHT (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 13 Feb 2022 12:07:19 -0500
Received: from smtp.smtpout.orange.fr (smtp08.smtpout.orange.fr [80.12.242.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA19CDFEC
        for <linux-pm@vger.kernel.org>; Sun, 13 Feb 2022 09:07:12 -0800 (PST)
Received: from pop-os.home ([90.126.236.122])
        by smtp.orange.fr with ESMTPA
        id JIL8nd3atuvBOJIL8nOEXk; Sun, 13 Feb 2022 18:07:11 +0100
X-ME-Helo: pop-os.home
X-ME-Auth: YWZlNiIxYWMyZDliZWIzOTcwYTEyYzlhMmU3ZiQ1M2U2MzfzZDfyZTMxZTBkMTYyNDBjNDJlZmQ3ZQ==
X-ME-Date: Sun, 13 Feb 2022 18:07:11 +0100
X-ME-IP: 90.126.236.122
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     Sebastian Reichel <sre@kernel.org>,
        Nicolas Saenz Julienne <nicolas.saenz@prodys.net>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        linux-pm@vger.kernel.org
Subject: [PATCH] power: supply: sbs-charger: Don't cancel work that is not initialized
Date:   Sun, 13 Feb 2022 18:07:03 +0100
Message-Id: <6a6b4c9ce80b0edb4c4c6a52d8b9a618a4325d42.1644772001.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

This driver can use an interrupt or polling in order get the charger's
status.

When using polling, a delayed work is used.

However, the remove() function unconditionally call
cancel_delayed_work_sync(), even if the delayed work is not used and is not
initialized.

In order to fix it, use devm_delayed_work_autocancel() and remove the now
useless remove() function.

Fixes: feb583e37f8a ("power: supply: add sbs-charger driver")
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
2 more comments:
   - i2c_set_clientdata() looks now useless and could be removed as well.
     I've left it because removing such assigned already played me some
     unexpected trick.

   - Should this be backported, devm_delayed_work_autocancel() is not
     really old and may not be available in older kernel.
     In this case a "if (!client->irq)" in the remove function would also
     fix the issue
---
 drivers/power/supply/sbs-charger.c | 18 +++++++-----------
 1 file changed, 7 insertions(+), 11 deletions(-)

diff --git a/drivers/power/supply/sbs-charger.c b/drivers/power/supply/sbs-charger.c
index 6fa65d118ec1..b08f7d0c4181 100644
--- a/drivers/power/supply/sbs-charger.c
+++ b/drivers/power/supply/sbs-charger.c
@@ -18,6 +18,7 @@
 #include <linux/interrupt.h>
 #include <linux/regmap.h>
 #include <linux/bitops.h>
+#include <linux/devm-helpers.h>
 
 #define SBS_CHARGER_REG_SPEC_INFO		0x11
 #define SBS_CHARGER_REG_STATUS			0x13
@@ -209,7 +210,12 @@ static int sbs_probe(struct i2c_client *client,
 		if (ret)
 			return dev_err_probe(&client->dev, ret, "Failed to request irq\n");
 	} else {
-		INIT_DELAYED_WORK(&chip->work, sbs_delayed_work);
+		ret = devm_delayed_work_autocancel(&client->dev, &chip->work,
+						   sbs_delayed_work);
+		if (ret)
+			return dev_err_probe(&client->dev, ret,
+					     "Failed to init work for polling\n");
+
 		schedule_delayed_work(&chip->work,
 				      msecs_to_jiffies(SBS_CHARGER_POLL_TIME));
 	}
@@ -220,15 +226,6 @@ static int sbs_probe(struct i2c_client *client,
 	return 0;
 }
 
-static int sbs_remove(struct i2c_client *client)
-{
-	struct sbs_info *chip = i2c_get_clientdata(client);
-
-	cancel_delayed_work_sync(&chip->work);
-
-	return 0;
-}
-
 #ifdef CONFIG_OF
 static const struct of_device_id sbs_dt_ids[] = {
 	{ .compatible = "sbs,sbs-charger" },
@@ -245,7 +242,6 @@ MODULE_DEVICE_TABLE(i2c, sbs_id);
 
 static struct i2c_driver sbs_driver = {
 	.probe		= sbs_probe,
-	.remove		= sbs_remove,
 	.id_table	= sbs_id,
 	.driver = {
 		.name	= "sbs-charger",
-- 
2.32.0

