From: Sebastian Reichel <sre@kernel.org>
Subject: [PATCH 2/3] power: bq27xxx_battery: move irq handler to i2c section
Date: Fri, 16 Oct 2015 15:44:11 +0200
Message-ID: <1445003052-31373-3-git-send-email-sre@kernel.org>
References: <1445003052-31373-1-git-send-email-sre@kernel.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from ring0.de ([5.45.105.125]:34732 "EHLO ring0.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753061AbbJPNoz (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Fri, 16 Oct 2015 09:44:55 -0400
In-Reply-To: <1445003052-31373-1-git-send-email-sre@kernel.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>
Cc: =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali.rohar@gmail.com>, "Andrew F . Davis" <afd@ti.com>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org

The IRQ handler is not used by the platform based
code resulting in a 'defined but not used' warning,
if CONFIG_BQ27XXX_I2C is not enabled.

Signed-off-by: Sebastian Reichel <sre@kernel.org>
---
 drivers/power/bq27xxx_battery.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/power/bq27xxx_battery.c b/drivers/power/bq27xxx_battery.c
index 69e6b371a51c..880233ce9343 100644
--- a/drivers/power/bq27xxx_battery.c
+++ b/drivers/power/bq27xxx_battery.c
@@ -762,15 +762,6 @@ static void bq27xxx_battery_update(struct bq27xxx_device_info *di)
 	di->last_update = jiffies;
 }
 
-static irqreturn_t bq27xxx_battery_irq_handler_thread(int irq, void *data)
-{
-	struct bq27xxx_device_info *di = data;
-
-	bq27xxx_battery_update(di);
-
-	return IRQ_HANDLED;
-}
-
 static void bq27xxx_battery_poll(struct work_struct *work)
 {
 	struct bq27xxx_device_info *di =
@@ -1061,6 +1052,15 @@ static void bq27xxx_powersupply_unregister(struct bq27xxx_device_info *di)
 static DEFINE_IDR(battery_id);
 static DEFINE_MUTEX(battery_mutex);
 
+static irqreturn_t bq27xxx_battery_irq_handler_thread(int irq, void *data)
+{
+	struct bq27xxx_device_info *di = data;
+
+	bq27xxx_battery_update(di);
+
+	return IRQ_HANDLED;
+}
+
 static int bq27xxx_battery_i2c_read(struct bq27xxx_device_info *di, u8 reg,
 				    bool single)
 {
-- 
2.6.1

