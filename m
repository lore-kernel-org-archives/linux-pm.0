From: =?UTF-8?q?Giedrius=20Statkevi=C4=8Dius?=
        <giedrius.statkevicius@gmail.com>
Subject: [PATCH] power: supply: lp8788: prevent out of bounds array access
Date: Sat, 25 Mar 2017 18:00:49 +0200
Message-ID: <20170325160049.18943-1-giedrius.statkevicius@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: milo.kim@ti.com, sre@kernel.org
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, =?UTF-8?q?Giedrius=20Statkevi=C4=8Dius?= <giedrius.statkevicius@gmail.com>
List-Id: linux-pm@vger.kernel.org

val might become 7 in which case stime[7] (array of length 7) would be
accessed during the scnprintf call later and that will cause issues.
Obviously, string concatenation is not intended here so just a comma needs
to be added to fix the issue.

Signed-off-by: Giedrius Statkevičius <giedrius.statkevicius@gmail.com>
---
 drivers/power/supply/lp8788-charger.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/power/supply/lp8788-charger.c b/drivers/power/supply/lp8788-charger.c
index 509e2b341bd6..677f7c40b25a 100644
--- a/drivers/power/supply/lp8788-charger.c
+++ b/drivers/power/supply/lp8788-charger.c
@@ -651,7 +651,7 @@ static ssize_t lp8788_show_eoc_time(struct device *dev,
 {
 	struct lp8788_charger *pchg = dev_get_drvdata(dev);
 	char *stime[] = { "400ms", "5min", "10min", "15min",
-			"20min", "25min", "30min" "No timeout" };
+			"20min", "25min", "30min", "No timeout" };
 	u8 val;
 
 	lp8788_read_byte(pchg->lp, LP8788_CHG_EOC, &val);
-- 
2.12.0
