From: Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH v6 15/48] mfd: dm355evm_msp: Register with kernel power-off handler
Date: Sun,  9 Nov 2014 17:42:32 -0800
Message-ID: <1415583785-6980-16-git-send-email-linux@roeck-us.net>
References: <1415583785-6980-1-git-send-email-linux@roeck-us.net>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:38982 "EHLO
	bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752234AbaKJBn6 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sun, 9 Nov 2014 20:43:58 -0500
Received: from mailnull by bh-25.webhostbox.net with sa-checked (Exim 4.82)
	(envelope-from <linux@roeck-us.net>)
	id 1Xne1O-000UZk-9W
	for linux-pm@vger.kernel.org; Mon, 10 Nov 2014 01:43:58 +0000
In-Reply-To: <1415583785-6980-1-git-send-email-linux@roeck-us.net>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: linux-pm@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>, Samuel Ortiz <sameo@linux.intel.com>, Lee Jones <lee.jones@linaro.org>

Register with kernel power-off handler instead of setting pm_power_off
directly. Register with low priority to reflect that the original code
only sets pm_power_off if it was not already set.

Cc: Samuel Ortiz <sameo@linux.intel.com>
Cc: Lee Jones <lee.jones@linaro.org>
Acked-by: Lee Jones <lee.jones@linaro.org>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
v6:
- This patch: No change.
  Global: Replaced priority defines with enum.
v5:
- Rebase to v3.18-rc3
v4:
- Do not use notifiers but internal functions and data structures to manage
  the list of power-off handlers. Drop unused parameters from callbacks, and
  make the power-off function type void
v3:
- Replace poweroff in all newly introduced variables and in text
  with power_off or power-off as appropriate
- Replace POWEROFF_PRIORITY_xxx with POWER_OFF_PRIORITY_xxx
v2:
- Use define to specify poweroff handler priority
- Use dev_warn instead of dev_err

 drivers/mfd/dm355evm_msp.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/drivers/mfd/dm355evm_msp.c b/drivers/mfd/dm355evm_msp.c
index 4c826f7..d9ec1e6 100644
--- a/drivers/mfd/dm355evm_msp.c
+++ b/drivers/mfd/dm355evm_msp.c
@@ -14,6 +14,7 @@
 #include <linux/platform_device.h>
 #include <linux/clk.h>
 #include <linux/module.h>
+#include <linux/pm.h>
 #include <linux/err.h>
 #include <linux/gpio.h>
 #include <linux/leds.h>
@@ -352,14 +353,19 @@ static void dm355evm_command(unsigned command)
 				command, status);
 }
 
-static void dm355evm_power_off(void)
+static void dm355evm_power_off(struct power_off_handler_block *this)
 {
 	dm355evm_command(MSP_COMMAND_POWEROFF);
 }
 
+static struct power_off_handler_block dm355evm_msp_power_off_hb = {
+	.handler = dm355evm_power_off,
+	.priority = POWER_OFF_PRIORITY_LOW,
+};
+
 static int dm355evm_msp_remove(struct i2c_client *client)
 {
-	pm_power_off = NULL;
+	unregister_power_off_handler(&dm355evm_msp_power_off_hb);
 	msp430 = NULL;
 	return 0;
 }
@@ -398,7 +404,9 @@ dm355evm_msp_probe(struct i2c_client *client, const struct i2c_device_id *id)
 		goto fail;
 
 	/* PM hookup */
-	pm_power_off = dm355evm_power_off;
+	status = register_power_off_handler(&dm355evm_msp_power_off_hb);
+	if (status)
+		dev_warn(&client->dev, "Failed to register power-off handler\n");
 
 	return 0;
 
-- 
1.9.1

