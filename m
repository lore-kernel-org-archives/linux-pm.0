From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v4 8/9] ide: hpt366: convert to use match_string() helper
Date: Thu, 28 Jan 2016 15:14:24 +0200
Message-ID: <1453986865-133572-9-git-send-email-andriy.shevchenko@linux.intel.com>
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
---
 drivers/ide/hpt366.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/drivers/ide/hpt366.c b/drivers/ide/hpt366.c
index 696b6c1..f94baad 100644
--- a/drivers/ide/hpt366.c
+++ b/drivers/ide/hpt366.c
@@ -531,14 +531,9 @@ static const struct hpt_info hpt371n = {
 	.timings	= &hpt37x_timings
 };
 
-static int check_in_drive_list(ide_drive_t *drive, const char **list)
+static bool check_in_drive_list(ide_drive_t *drive, const char **list)
 {
-	char *m = (char *)&drive->id[ATA_ID_PROD];
-
-	while (*list)
-		if (!strcmp(*list++, m))
-			return 1;
-	return 0;
+	return match_string(list, -1, (char *)&drive->id[ATA_ID_PROD]) >= 0;
 }
 
 static struct hpt_info *hpt3xx_get_info(struct device *dev)
-- 
2.7.0.rc3
