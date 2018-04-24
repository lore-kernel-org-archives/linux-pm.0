From: Mike Looijmans <mike.looijmans@topic.nl>
Subject: [PATCH] gpio-poweroff: Use gpiod_set_value_cansleep
Date: Tue, 24 Apr 2018 13:10:30 +0200
Message-ID: <1524568230-14353-1-git-send-email-mike.looijmans@topic.nl>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-pm@vger.kernel.org, sre@kernel.org
Cc: linux-kernel@vger.kernel.org, Mike Looijmans <mike.looijmans@topic.nl>
List-Id: linux-pm@vger.kernel.org

The power-off call is done in a context that must be able to sleep, so
use gpiod_set_value_cansleep instead of the atomic gpiod_set_value call.

This fixes a kernel warning at shutdown when the gpio is controlled
through an IO expander for example.

Signed-off-by: Mike Looijmans <mike.looijmans@topic.nl>
---
 drivers/power/reset/gpio-poweroff.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/power/reset/gpio-poweroff.c b/drivers/power/reset/gpio-poweroff.c
index 6273ad3..38206c3 100644
--- a/drivers/power/reset/gpio-poweroff.c
+++ b/drivers/power/reset/gpio-poweroff.c
@@ -35,11 +35,11 @@ static void gpio_poweroff_do_poweroff(void)
 	gpiod_direction_output(reset_gpio, 1);
 	mdelay(100);
 	/* drive inactive, also active->inactive edge */
-	gpiod_set_value(reset_gpio, 0);
+	gpiod_set_value_cansleep(reset_gpio, 0);
 	mdelay(100);
 
 	/* drive it active, also inactive->active edge */
-	gpiod_set_value(reset_gpio, 1);
+	gpiod_set_value_cansleep(reset_gpio, 1);
 
 	/* give it some time */
 	mdelay(timeout);
-- 
1.9.1
