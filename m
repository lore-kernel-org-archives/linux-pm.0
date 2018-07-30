From: Jia-Ju Bai <baijiaju1990@gmail.com>
Subject: [PATCH] power: reset: piix4-poweroff: Replace mdelay() with msleep() and usleep_range() in piix4_poweroff()
Date: Mon, 30 Jul 2018 21:48:38 +0800
Message-ID: <20180730134838.9124-1-baijiaju1990@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: sre@kernel.org
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Jia-Ju Bai <baijiaju1990@gmail.com>
List-Id: linux-pm@vger.kernel.org

piix4_poweroff() is never called in atomic context.
It calls mdelay() to busily wait, which is not necessary.
mdelay() can be replaced with msleep() and usleep_range().

This is found by a static analysis tool named DCNS written by myself.

Signed-off-by: Jia-Ju Bai <baijiaju1990@gmail.com>
---
 drivers/power/reset/piix4-poweroff.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/power/reset/piix4-poweroff.c b/drivers/power/reset/piix4-poweroff.c
index 20ce3ff5e039..5d4c72992d2c 100644
--- a/drivers/power/reset/piix4-poweroff.c
+++ b/drivers/power/reset/piix4-poweroff.c
@@ -47,7 +47,7 @@ static void piix4_poweroff(void)
 	     io_offset + PIIX4_FUNC3IO_PMCNTRL);
 
 	/* If the special cycle occurs too soon this doesn't work... */
-	mdelay(10);
+	usleep_range(10000, 11000);
 
 	/*
 	 * The PIIX4 will enter the suspend state only after seeing a special
@@ -59,7 +59,7 @@ static void piix4_poweroff(void)
 				   PIIX4_SUSPEND_MAGIC);
 
 	/* Give the system some time to power down, then error */
-	mdelay(1000);
+	msleep(1000);
 	pr_emerg("Unable to poweroff system\n");
 }
 
-- 
2.17.0
