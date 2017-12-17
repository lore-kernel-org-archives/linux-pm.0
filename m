From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH] bq24190-charger: Delete an error message for a failed memory
 allocation in bq24190_probe()
Date: Sun, 17 Dec 2017 21:42:53 +0100
Message-ID: <acf2dc0e-4d62-3eb2-1872-96946c06b842@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <kernel-janitors-owner@vger.kernel.org>
Content-Language: en-GB
Sender: kernel-janitors-owner@vger.kernel.org
To: linux-pm@vger.kernel.org, Sebastian Reichel <sre@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Sun, 17 Dec 2017 21:38:55 +0100

Omit an extra message for a memory allocation failure in this function.

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 drivers/power/supply/bq24190_charger.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/power/supply/bq24190_charger.c b/drivers/power/supply/bq24190_charger.c
index 35ff406aca48..eda6f996b67a 100644
--- a/drivers/power/supply/bq24190_charger.c
+++ b/drivers/power/supply/bq24190_charger.c
@@ -1775,10 +1775,8 @@ static int bq24190_probe(struct i2c_client *client,
 	}
 
 	bdi = devm_kzalloc(dev, sizeof(*bdi), GFP_KERNEL);
-	if (!bdi) {
-		dev_err(dev, "Can't alloc bdi struct\n");
+	if (!bdi)
 		return -ENOMEM;
-	}
 
 	bdi->client = client;
 	bdi->dev = dev;
-- 
2.15.1

