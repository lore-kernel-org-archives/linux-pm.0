From: Jonghwa Lee <jonghwa3.lee@samsung.com>
Subject: [PATCH 2/4] power: max17042_battery: Use devm_* function for
 requesting irq
Date: Thu, 05 Jun 2014 12:46:15 +0900
Message-ID: <1401939977-20328-3-git-send-email-jonghwa3.lee@samsung.com>
References: <1401939977-20328-1-git-send-email-jonghwa3.lee@samsung.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout1.samsung.com ([203.254.224.24]:18603 "EHLO
	mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751328AbaFEDq0 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 4 Jun 2014 23:46:26 -0400
Received: from epcpsbgr4.samsung.com
 (u144.gpu120.samsung.co.kr [203.254.230.144])
 by mailout1.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTP id <0N6O003YFFTCLC70@mailout1.samsung.com> for
 linux-pm@vger.kernel.org; Thu, 05 Jun 2014 12:46:24 +0900 (KST)
In-reply-to: <1401939977-20328-1-git-send-email-jonghwa3.lee@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: dbaryshkov@gmail.com, dwmw2@infradead.org, Jonghwa Lee <jonghwa3.lee@samsung.com>

This patch modifies driver to use devm_request_threaded_irq() to simplify
the driver.

Signed-off-by: Jonghwa Lee <jonghwa3.lee@samsung.com>
Acked-by: Chanwoo Choi <cw00.choi@samsung.com>
Acked-by: MyungJoo Ham <myungjoo.ham@samsung.com>
---
 drivers/power/max17042_battery.c |    6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/power/max17042_battery.c b/drivers/power/max17042_battery.c
index 1266760..cee3912 100644
--- a/drivers/power/max17042_battery.c
+++ b/drivers/power/max17042_battery.c
@@ -745,8 +745,8 @@ static int max17042_probe(struct i2c_client *client,
 	}
 
 	if (client->irq) {
-		ret = request_threaded_irq(client->irq, NULL,
-					max17042_thread_handler,
+		ret = devm_request_threaded_irq(&client->dev, client->irq,
+					NULL, max17042_thread_handler,
 					IRQF_TRIGGER_FALLING | IRQF_ONESHOT,
 					chip->battery.name, chip);
 		if (!ret) {
@@ -776,8 +776,6 @@ static int max17042_remove(struct i2c_client *client)
 {
 	struct max17042_chip *chip = i2c_get_clientdata(client);
 
-	if (client->irq)
-		free_irq(client->irq, chip);
 	power_supply_unregister(&chip->battery);
 	return 0;
 }
-- 
1.7.9.5

