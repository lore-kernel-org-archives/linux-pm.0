From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 7/8] ata: hpt366: convert to use match_string() helper
Date: Thu,  7 Jan 2016 14:06:07 +0200
Message-ID: <1452168368-75630-7-git-send-email-andriy.shevchenko@linux.intel.com>
References: <1452168368-75630-1-git-send-email-andriy.shevchenko@linux.intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1452168368-75630-1-git-send-email-andriy.shevchenko@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tejun Heo <tj@kernel.org>, Linus Walleij <linus.walleij@linaro.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, David Airlie <airlied@linux.ie>, Andrew Morton <akpm@linux-foundation.org>, Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
List-Id: linux-pm@vger.kernel.org

The new helper returns index of the mathing string in an array. We would use it
here.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/ata/pata_hpt366.c | 13 +++++--------
 1 file changed, 5 insertions(+), 8 deletions(-)

diff --git a/drivers/ata/pata_hpt366.c b/drivers/ata/pata_hpt366.c
index 0038dc4..fb85cb2 100644
--- a/drivers/ata/pata_hpt366.c
+++ b/drivers/ata/pata_hpt366.c
@@ -176,17 +176,14 @@ static int hpt_dma_blacklisted(const struct ata_device *dev, char *modestr,
 			       const char * const list[])
 {
 	unsigned char model_num[ATA_ID_PROD_LEN + 1];
-	int i = 0;
+	int i;
 
 	ata_id_c_string(dev->id, model_num, ATA_ID_PROD, sizeof(model_num));
 
-	while (list[i] != NULL) {
-		if (!strcmp(list[i], model_num)) {
-			pr_warn("%s is not supported for %s\n",
-				modestr, list[i]);
-			return 1;
-		}
-		i++;
+	i = match_string(list, 0, model_num);
+	if (i >= 0) {
+		pr_warn("%s is not supported for %s\n", modestr, list[i]);
+		return 1;
 	}
 	return 0;
 }
-- 
2.6.4
