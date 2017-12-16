From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH 2/3] pm2301-charger: Improve a size determination in
 pm2xxx_wall_charger_probe()
Date: Sat, 16 Dec 2017 21:13:08 +0100
Message-ID: <8b954bef-c66e-2ad9-233c-9cb05ee0871f@users.sourceforge.net>
References: <b11627bc-502d-b3af-ee96-ac2a693448a7@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mout.web.de ([212.227.15.3]:49944 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1756929AbdLPUNN (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Sat, 16 Dec 2017 15:13:13 -0500
In-Reply-To: <b11627bc-502d-b3af-ee96-ac2a693448a7@users.sourceforge.net>
Content-Language: en-GB
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org, Sebastian Reichel <sre@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Sat, 16 Dec 2017 20:33:37 +0100

Replace the specification of a data structure by a pointer dereference
as the parameter for the operator "sizeof" to make the corresponding size
determination a bit safer according to the Linux coding style convention.

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 drivers/power/supply/pm2301_charger.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/power/supply/pm2301_charger.c b/drivers/power/supply/pm2301_charger.c
index 0a0c2da936cf..99a9892f0f68 100644
--- a/drivers/power/supply/pm2301_charger.c
+++ b/drivers/power/supply/pm2301_charger.c
@@ -990,7 +990,7 @@ static int pm2xxx_wall_charger_probe(struct i2c_client *i2c_client,
 		return -EINVAL;
 	}
 
-	pm2 = kzalloc(sizeof(struct pm2xxx_charger), GFP_KERNEL);
+	pm2 = kzalloc(sizeof(*pm2), GFP_KERNEL);
 	if (!pm2)
 		return -ENOMEM;
 
-- 
2.15.1
