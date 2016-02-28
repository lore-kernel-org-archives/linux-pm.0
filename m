From: Maarten ter Huurne <maarten@treewalker.org>
Subject: [PATCH] jz4740-battery: Correct voltage change check
Date: Sun, 28 Feb 2016 17:05:48 +0100
Message-ID: <1456675548-16692-1-git-send-email-maarten@treewalker.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Maarten ter Huurne <maarten@treewalker.org>
List-Id: linux-pm@vger.kernel.org

The check is supposed to avoid redundant update notifications, so it
should check for the difference between old and new voltage exceeding
a threshold.

Also make sure the result of a failed read is never stored.

Signed-off-by: Maarten ter Huurne <maarten@treewalker.org>
---
 drivers/power/jz4740-battery.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/power/jz4740-battery.c b/drivers/power/jz4740-battery.c
index abdfc21..88f04f4 100644
--- a/drivers/power/jz4740-battery.c
+++ b/drivers/power/jz4740-battery.c
@@ -208,7 +208,7 @@ static void jz_battery_update(struct jz_battery *jz_battery)
 	}
 
 	voltage = jz_battery_read_voltage(jz_battery);
-	if (abs(voltage - jz_battery->voltage) < 50000) {
+	if (voltage >= 0 && abs(voltage - jz_battery->voltage) > 50000) {
 		jz_battery->voltage = voltage;
 		has_changed = true;
 	}
-- 
2.6.2
