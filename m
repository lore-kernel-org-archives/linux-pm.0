From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v4 7/9] ata: hpt366: convert to use match_string() helper
Date: Thu, 28 Jan 2016 15:14:23 +0200
Message-ID: <1453986865-133572-8-git-send-email-andriy.shevchenko@linux.intel.com>
References: <1453986865-133572-1-git-send-email-andriy.shevchenko@linux.intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1453986865-133572-1-git-send-email-andriy.shevchenko@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tejun Heo <tj@kernel.org>, Linus Walleij <linus.walleij@linaro.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, "David S . Miller" <davem@davemloft.net>, David Airlie <airlied@linux.ie>, Andrew Morton <akpm@linux-foundation.org>, Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
List-Id: linux-pm@vger.kernel.org

The new helper returns index of the mathing string in an array. We would use it
here.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Acked-by: Tejun Heo <tj@kernel.org>
---
 drivers/ata/pata_hpt366.c | 13 +++++--------
 1 file changed, 5 insertions(+), 8 deletions(-)

diff --git a/drivers/ata/pata_hpt366.c b/drivers/ata/pata_hpt366.c
index 0038dc4..e5fb752 100644
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
+	i = match_string(list, -1, model_num);
+	if (i >= 0) {
+		pr_warn("%s is not supported for %s\n", modestr, list[i]);
+		return 1;
 	}
 	return 0;
 }
-- 
2.7.0.rc3
