From: "Andrew F. Davis" <afd@ti.com>
Subject: [PATCH v5 6/6] power: bq27xxx_battery: Add interrupt handling support
Date: Tue, 22 Sep 2015 14:35:11 -0500
Message-ID: <1442950511-16122-7-git-send-email-afd@ti.com>
References: <1442950511-16122-1-git-send-email-afd@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1442950511-16122-1-git-send-email-afd@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali.rohar@gmail.com>, Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, "Andrew F. Davis" <afd@ti.com>
List-Id: linux-pm@vger.kernel.org

Some devices have a pin that can generate an interrupt when
the battery's status changes. Add an interrupt handler to
read the new battery status.

Signed-off-by: Andrew F. Davis <afd@ti.com>
---
 drivers/power/bq27xxx_battery.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/drivers/power/bq27xxx_battery.c b/drivers/power/bq27xxx_battery.c
index fe18a2d..473aa2f 100644
--- a/drivers/power/bq27xxx_battery.c
+++ b/drivers/power/bq27xxx_battery.c
@@ -48,6 +48,7 @@
 #include <linux/idr.h>
 #include <linux/i2c.h>
 #include <linux/slab.h>
+#include <linux/interrupt.h>
 #include <asm/unaligned.h>
 
 #include <linux/power/bq27xxx_battery.h>
@@ -761,6 +762,15 @@ static void bq27xxx_battery_update(struct bq27xxx_device_info *di)
 	di->last_update = jiffies;
 }
 
+static irqreturn_t bq27xxx_battery_irq_handler_thread(int irq, void *data)
+{
+	struct bq27xxx_device_info *di = data;
+
+	bq27xxx_battery_update(di);
+
+	return IRQ_HANDLED;
+}
+
 static void bq27xxx_battery_poll(struct work_struct *work)
 {
 	struct bq27xxx_device_info *di =
@@ -1128,6 +1138,19 @@ static int bq27xxx_battery_i2c_probe(struct i2c_client *client,
 
 	i2c_set_clientdata(client, di);
 
+	if (client->irq) {
+		retval = devm_request_threaded_irq(&client->dev, client->irq,
+				NULL, bq27xxx_battery_irq_handler_thread,
+				IRQF_ONESHOT,
+				name, di);
+		if (retval) {
+			dev_err(&client->dev,
+				"Unable to register IRQ %d error %d\n",
+				client->irq, retval);
+			return retval;
+		}
+	}
+
 	return 0;
 
 batt_failed:
-- 
1.9.1
