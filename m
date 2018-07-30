From: Jia-Ju Bai <baijiaju1990@gmail.com>
Subject: [PATCH] power: reset: syscon-poweroff: Replace mdelay() with msleep() in syscon_poweroff()
Date: Mon, 30 Jul 2018 21:50:29 +0800
Message-ID: <20180730135029.9228-1-baijiaju1990@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: sre@kernel.org
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Jia-Ju Bai <baijiaju1990@gmail.com>
List-Id: linux-pm@vger.kernel.org

syscon_poweroff() is never called in atomic context.
It calls mdelay() to busily wait, which is not necessary.
mdelay() can be replaced with msleep().

This is found by a static analysis tool named DCNS written by myself.

Signed-off-by: Jia-Ju Bai <baijiaju1990@gmail.com>
---
 drivers/power/reset/syscon-poweroff.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/power/reset/syscon-poweroff.c b/drivers/power/reset/syscon-poweroff.c
index f9f1cb54fbf9..b8b154606dbe 100644
--- a/drivers/power/reset/syscon-poweroff.c
+++ b/drivers/power/reset/syscon-poweroff.c
@@ -36,7 +36,7 @@ static void syscon_poweroff(void)
 	/* Issue the poweroff */
 	regmap_update_bits(map, offset, mask, value);
 
-	mdelay(1000);
+	msleep(1000);
 
 	pr_emerg("Unable to poweroff system\n");
 }
-- 
2.17.0
