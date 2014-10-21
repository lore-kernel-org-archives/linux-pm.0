From: Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH v2 15/47] mfd: dm355evm_msp: Register with kernel poweroff handler
Date: Mon, 20 Oct 2014 21:12:31 -0700
Message-ID: <1413864783-3271-16-git-send-email-linux@roeck-us.net>
References: <1413864783-3271-1-git-send-email-linux@roeck-us.net>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1413864783-3271-1-git-send-email-linux@roeck-us.net>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: linux-pm@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>, Samuel Ortiz <sameo@linux.intel.com>, Lee Jones <lee.jones@linaro.org>
List-Id: linux-pm@vger.kernel.org

Register with kernel poweroff handler instead of setting pm_power_off
directly. Register with low priority to reflect that the original code
only sets pm_power_off if it was not already set.

Cc: Samuel Ortiz <sameo@linux.intel.com>
Cc: Lee Jones <lee.jones@linaro.org>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
v2:
- Use define to specify poweroff handler priority
- Use dev_warn instead of dev_err

 drivers/mfd/dm355evm_msp.c | 18 +++++++++++++++---
 1 file changed, 15 insertions(+), 3 deletions(-)

diff --git a/drivers/mfd/dm355evm_msp.c b/drivers/mfd/dm355evm_msp.c
index 4c826f7..3ec49a7 100644
--- a/drivers/mfd/dm355evm_msp.c
+++ b/drivers/mfd/dm355evm_msp.c
@@ -14,6 +14,8 @@
 #include <linux/platform_device.h>
 #include <linux/clk.h>
 #include <linux/module.h>
+#include <linux/notifier.h>
+#include <linux/pm.h>
 #include <linux/err.h>
 #include <linux/gpio.h>
 #include <linux/leds.h>
@@ -352,14 +354,22 @@ static void dm355evm_command(unsigned command)
 				command, status);
 }
 
-static void dm355evm_power_off(void)
+static int dm355evm_power_off(struct notifier_block *this,
+			      unsigned long unused1, void *unused2)
 {
 	dm355evm_command(MSP_COMMAND_POWEROFF);
+
+	return NOTIFY_DONE;
 }
 
+static struct notifier_block dm355evm_msp_poweroff_nb = {
+	.notifier_call = dm355evm_power_off,
+	.priority = POWEROFF_PRIORITY_LOW,
+};
+
 static int dm355evm_msp_remove(struct i2c_client *client)
 {
-	pm_power_off = NULL;
+	unregister_power_off_handler(&dm355evm_msp_poweroff_nb);
 	msp430 = NULL;
 	return 0;
 }
@@ -398,7 +408,9 @@ dm355evm_msp_probe(struct i2c_client *client, const struct i2c_device_id *id)
 		goto fail;
 
 	/* PM hookup */
-	pm_power_off = dm355evm_power_off;
+	status = register_power_off_handler(&dm355evm_msp_poweroff_nb);
+	if (status)
+		dev_warn(&client->dev, "Failed to register poweroff handler\n");
 
 	return 0;
 
-- 
1.9.1
