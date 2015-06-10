From: Frans Klaver <frans.klaver@xsens.com>
Subject: [PATCH v3] sbs-battery: add option to always register battery
Date: Wed, 10 Jun 2015 14:16:56 +0200
Message-ID: <1433938616-18503-1-git-send-email-frans.klaver@xsens.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>
Cc: Frans Klaver <frans.klaver@xsens.com>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Commit a22b41a31e53 ("sbs-battery: Probe should try talking to the
device") introduced a step in probing the SBS battery, that tries to
talk to the device before actually registering it, saying:

    this driver doesn't actually try talking to the device at probe
    time, so if it's incorrectly configured in the device tree or
    platform data (or if the battery has been removed from the system),
    then probe will succeed and every access will sit there and time
    out. The end result is a possibly laggy system that thinks it has a
    battery but can never read status, which isn't very useful.

Which is of course reasonable. However, it is also very well possible
for a device to boot up on wall-power and be connected to a battery
later on. This is a scenario that the driver supported before said patch
was applied, and even easily achieved by booting up with the battery
attached and removing it later on. sbs-battery's 'present' sysfs file
can be used to determine if the device is available or not.

So with automated device detection lacking for now, in some cases it is
possible that one wants to register a battery, even if none are attached
at the moment. To facilitate this, add a module parameter that can be
used to configure forced loading module loading time. If set, the battery
will always be registered without checking the sanity of the connection.

Signed-off-by: Frans Klaver <frans.klaver@xsens.com>
---
v2..v3
 - Switch from Kconfig to module parameter approach
 - Move entire sanity check into if () clause, rather than using 'rc = 0'

v1..v2
  device tree -> Kconfig

 drivers/power/sbs-battery.c | 21 +++++++++++++++------
 1 file changed, 15 insertions(+), 6 deletions(-)

diff --git a/drivers/power/sbs-battery.c b/drivers/power/sbs-battery.c
index c7b7b4018df3..3ccd3f172130 100644
--- a/drivers/power/sbs-battery.c
+++ b/drivers/power/sbs-battery.c
@@ -28,6 +28,7 @@
 #include <linux/interrupt.h>
 #include <linux/gpio.h>
 #include <linux/of.h>
+#include <linux/stat.h>
 
 #include <linux/power/sbs-battery.h>
 
@@ -170,6 +171,7 @@ struct sbs_info {
 
 static char model_name[I2C_SMBUS_BLOCK_MAX + 1];
 static char manufacturer[I2C_SMBUS_BLOCK_MAX + 1];
+static bool force_load;
 
 static int sbs_read_word_data(struct i2c_client *client, u8 address)
 {
@@ -882,14 +884,17 @@ static int sbs_probe(struct i2c_client *client,
 
 skip_gpio:
 	/*
-	 * Before we register, we need to make sure we can actually talk
+	 * Before we register, we might need to make sure we can actually talk
 	 * to the battery.
 	 */
-	rc = sbs_read_word_data(client, sbs_data[REG_STATUS].addr);
-	if (rc < 0) {
-		dev_err(&client->dev, "%s: Failed to get device status\n",
-			__func__);
-		goto exit_psupply;
+	if (!force_load) {
+		rc = sbs_read_word_data(client, sbs_data[REG_STATUS].addr);
+
+		if (rc < 0) {
+			dev_err(&client->dev, "%s: Failed to get device status\n",
+				__func__);
+			goto exit_psupply;
+		}
 	}
 
 	rc = power_supply_register(&client->dev, &chip->power_supply);
@@ -990,3 +995,7 @@ module_i2c_driver(sbs_battery_driver);
 
 MODULE_DESCRIPTION("SBS battery monitor driver");
 MODULE_LICENSE("GPL");
+
+module_param(force_load, bool, S_IRUSR | S_IRGRP | S_IROTH);
+MODULE_PARM_DESC(force_load,
+		 "Attempt to load the driver even if no battery is connected");
-- 
2.3.4
