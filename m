From: Jia-Ju Bai <baijiaju1990@gmail.com>
Subject: [PATCH] power: reset: gpio-poweroff: Replace mdelay() with msleep() in gpio_poweroff_do_poweroff()
Date: Mon, 30 Jul 2018 21:46:14 +0800
Message-ID: <20180730134614.9016-1-baijiaju1990@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: sre@kernel.org
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Jia-Ju Bai <baijiaju1990@gmail.com>
List-Id: linux-pm@vger.kernel.org

gpio_poweroff_do_poweroff() is never called in atomic context.
It calls mdelay() to busily wait, which is not necessary.
mdelay() can be replaced with msleep().

This is found by a static analysis tool named DCNS written by myself.

Signed-off-by: Jia-Ju Bai <baijiaju1990@gmail.com>
---
 drivers/power/reset/gpio-poweroff.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/power/reset/gpio-poweroff.c b/drivers/power/reset/gpio-poweroff.c
index 6273ad3b411d..bbe55cfa87d0 100644
--- a/drivers/power/reset/gpio-poweroff.c
+++ b/drivers/power/reset/gpio-poweroff.c
@@ -33,16 +33,16 @@ static void gpio_poweroff_do_poweroff(void)
 
 	/* drive it active, also inactive->active edge */
 	gpiod_direction_output(reset_gpio, 1);
-	mdelay(100);
+	msleep(100);
 	/* drive inactive, also active->inactive edge */
 	gpiod_set_value(reset_gpio, 0);
-	mdelay(100);
+	msleep(100);
 
 	/* drive it active, also inactive->active edge */
 	gpiod_set_value(reset_gpio, 1);
 
 	/* give it some time */
-	mdelay(timeout);
+	msleep(timeout);
 
 	WARN_ON(1);
 }
-- 
2.17.0
