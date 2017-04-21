From: raitosyo@gmail.com
Subject: [PATCH] power: supply: sbs-battery: fix the sbs interrupt request
Date: Fri, 21 Apr 2017 12:13:17 +0900
Message-ID: <1492744397-7105-1-git-send-email-raitosyo@gmail.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-io0-f193.google.com ([209.85.223.193]:33572 "EHLO
        mail-io0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1034901AbdDUDN5 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 20 Apr 2017 23:13:57 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: sre@kernel.org
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org

From: Ryosuke Saito <raitosyo@gmail.com>

Since we use the default primary handler for the irq, IRQF_ONESHOT must
be set. Otherwise the request fails and the following errors are
displayed:

genirq: Threaded irq requested with handler=NULL and !ONESHOT for irq 129
sbs-battery 0-000b: Failed to request irq: -22

Signed-off-by: Ryosuke Saito <raitosyo@gmail.com>
---
 drivers/power/supply/sbs-battery.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/power/supply/sbs-battery.c b/drivers/power/supply/sbs-battery.c
index 8bb2eb3..e07d570 100644
--- a/drivers/power/supply/sbs-battery.c
+++ b/drivers/power/supply/sbs-battery.c
@@ -820,7 +820,7 @@ static int sbs_probe(struct i2c_client *client,
 	}
 
 	rc = devm_request_threaded_irq(&client->dev, irq, NULL, sbs_irq,
-		IRQF_TRIGGER_RISING | IRQF_TRIGGER_FALLING,
+		IRQF_TRIGGER_RISING | IRQF_TRIGGER_FALLING | IRQF_ONESHOT,
 		dev_name(&client->dev), chip);
 	if (rc) {
 		dev_warn(&client->dev, "Failed to request irq: %d\n", rc);
-- 
2.7.4
