From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH] bq24735-charger: Delete an error message for a failed memory
 allocation in two functions
Date: Sun, 17 Dec 2017 21:27:26 +0100
Message-ID: <d5366c73-4f02-8966-ed8d-3665f201354e@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mout.web.de ([212.227.15.4]:50580 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1757336AbdLQU1d (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Sun, 17 Dec 2017 15:27:33 -0500
Content-Language: en-GB
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org, Sebastian Reichel <sre@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Sun, 17 Dec 2017 21:23:23 +0100

Omit an extra message for a memory allocation failure in these functions.

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 drivers/power/supply/bq24735-charger.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/drivers/power/supply/bq24735-charger.c b/drivers/power/supply/bq24735-charger.c
index 6931e1d826f5..c9fd9275dfae 100644
--- a/drivers/power/supply/bq24735-charger.c
+++ b/drivers/power/supply/bq24735-charger.c
@@ -326,11 +326,8 @@ static struct bq24735_platform *bq24735_parse_dt_data(struct i2c_client *client)
 	int ret;
 
 	pdata = devm_kzalloc(&client->dev, sizeof(*pdata), GFP_KERNEL);
-	if (!pdata) {
-		dev_err(&client->dev,
-			"Memory alloc for bq24735 pdata failed\n");
+	if (!pdata)
 		return NULL;
-	}
 
 	ret = of_property_read_u32(np, "ti,charge-current", &val);
 	if (!ret)
@@ -379,10 +376,8 @@ static int bq24735_charger_probe(struct i2c_client *client,
 		name = devm_kasprintf(&client->dev, GFP_KERNEL,
 				      "bq24735@%s",
 				      dev_name(&client->dev));
-		if (!name) {
-			dev_err(&client->dev, "Failed to alloc device name\n");
+		if (!name)
 			return -ENOMEM;
-		}
 	}
 
 	charger->client = client;
-- 
2.15.1
