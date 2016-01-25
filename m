From: Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH] power: collie_battery: hide unused variable
Date: Mon, 25 Jan 2016 16:45:49 +0100
Message-ID: <1453736756-1959377-2-git-send-email-arnd@arndb.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, Arnd Bergmann <arnd@arndb.de>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

The 'wakeup_enabled' variable in this driver is only accessed
by the optional power management functions and we get a warning
when they are disabled:

drivers/power/collie_battery.c:29:12: error: 'wakeup_enabled' defined but not used [-Werror=unused-variable]

This moves the definition next to the users inside the same #ifdef,
which avoids the warning.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/power/collie_battery.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/power/collie_battery.c b/drivers/power/collie_battery.c
index 8a971b3dbe58..3a0bc608d4b5 100644
--- a/drivers/power/collie_battery.c
+++ b/drivers/power/collie_battery.c
@@ -26,7 +26,6 @@
 static DEFINE_MUTEX(bat_lock); /* protects gpio pins */
 static struct work_struct bat_work;
 static struct ucb1x00 *ucb;
-static int wakeup_enabled;
 
 struct collie_bat {
 	int status;
@@ -291,6 +290,8 @@ static struct gpio collie_batt_gpios[] = {
 };
 
 #ifdef CONFIG_PM
+static int wakeup_enabled;
+
 static int collie_bat_suspend(struct ucb1x00_dev *dev)
 {
 	/* flush all pending status updates */
-- 
2.7.0
