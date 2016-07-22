From: Phil Reid <preid@electromag.com.au>
Subject: [PATCH 1/4] power: sbs-battery: Use devm_kzalloc to alloc data
Date: Fri, 22 Jul 2016 16:42:35 +0800
Message-ID: <1469176958-69804-2-git-send-email-preid@electromag.com.au>
References: <1469176958-69804-1-git-send-email-preid@electromag.com.au>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from 203-59-230-133.perm.iinet.net.au ([203.59.230.133]:38126 "EHLO
	preid-centos7.electromag.com.au" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751824AbcGVIwR (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 22 Jul 2016 04:52:17 -0400
In-Reply-To: <1469176958-69804-1-git-send-email-preid@electromag.com.au>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: sre@kernel.org, dbaryshkov@gmail.com, dwmw2@infradead.org, linux-pm@vger.kernel.org
Cc: Phil Reid <preid@electromag.com.au>

Use devm_kzalloc to allow memory to be freed automatically on
driver probe failure or removal.

Signed-off-by: Phil Reid <preid@electromag.com.au>
---
 drivers/power/sbs-battery.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/drivers/power/sbs-battery.c b/drivers/power/sbs-battery.c
index 768b9fc..20f3be6 100644
--- a/drivers/power/sbs-battery.c
+++ b/drivers/power/sbs-battery.c
@@ -819,7 +819,7 @@ static int sbs_probe(struct i2c_client *client,
 	if (!sbs_desc->name)
 		return -ENOMEM;
 
-	chip = kzalloc(sizeof(struct sbs_info), GFP_KERNEL);
+	chip = devm_kzalloc(&client->dev, sizeof(struct sbs_info), GFP_KERNEL);
 	if (!chip)
 		return -ENOMEM;
 
@@ -920,8 +920,6 @@ exit_psupply:
 	if (chip->gpio_detect)
 		gpio_free(pdata->battery_detect);
 
-	kfree(chip);
-
 	return rc;
 }
 
@@ -938,9 +936,6 @@ static int sbs_remove(struct i2c_client *client)
 
 	cancel_delayed_work_sync(&chip->work);
 
-	kfree(chip);
-	chip = NULL;
-
 	return 0;
 }
 
-- 
1.8.3.1

