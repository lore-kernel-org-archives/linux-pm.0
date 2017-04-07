From: Colin King <colin.king@canonical.com>
Subject: [PATCH] power: supply: lp8788: add missing comma between literal strings
Date: Sat,  8 Apr 2017 00:33:36 +0100
Message-ID: <20170407233336.9583-1-colin.king@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Return-path: <kernel-janitors-owner@vger.kernel.org>
Sender: kernel-janitors-owner@vger.kernel.org
To: Milo Kim <milo.kim@ti.com>, Sebastian Reichel <sre@kernel.org>, linux-pm@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

There is a missing comma between the last two literal strings in
array stime, so add it in.

Detected by PVS-Studio, warning: V653

Signed-off-by: Colin Ian King <colin.king@canonical.com>
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
2.11.0

