From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH 1/3] pm2301-charger: Delete an error message for a failed
 memory allocation in pm2xxx_wall_charger_probe()
Date: Sat, 16 Dec 2017 21:11:54 +0100
Message-ID: <6841b772-84ad-8f41-af0c-e797bc68a015@users.sourceforge.net>
References: <b11627bc-502d-b3af-ee96-ac2a693448a7@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mout.web.de ([212.227.15.4]:60729 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1757095AbdLPUL7 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Sat, 16 Dec 2017 15:11:59 -0500
In-Reply-To: <b11627bc-502d-b3af-ee96-ac2a693448a7@users.sourceforge.net>
Content-Language: en-GB
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org, Sebastian Reichel <sre@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Sat, 16 Dec 2017 20:30:26 +0100

Omit an extra message for a memory allocation failure in this function.

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 drivers/power/supply/pm2301_charger.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/power/supply/pm2301_charger.c b/drivers/power/supply/pm2301_charger.c
index 78561b6884fc..0a0c2da936cf 100644
--- a/drivers/power/supply/pm2301_charger.c
+++ b/drivers/power/supply/pm2301_charger.c
@@ -991,10 +991,8 @@ static int pm2xxx_wall_charger_probe(struct i2c_client *i2c_client,
 	}
 
 	pm2 = kzalloc(sizeof(struct pm2xxx_charger), GFP_KERNEL);
-	if (!pm2) {
-		dev_err(&i2c_client->dev, "pm2xxx_charger allocation failed\n");
+	if (!pm2)
 		return -ENOMEM;
-	}
 
 	/* get parent data */
 	pm2->dev = &i2c_client->dev;
-- 
2.15.1
