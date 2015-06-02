From: Frans Klaver <frans.klaver@xsens.com>
Subject: [PATCH] sbs-battery: add option to always register battery
Date: Tue, 2 Jun 2015 15:14:43 +0200
Message-ID: <1433250883-32245-1-git-send-email-frans.klaver@xsens.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from filter1.ibarracuda.nl ([83.247.7.10]:49562 "EHLO
	filter1.ibarracuda.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759108AbbFBNen (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 2 Jun 2015 09:34:43 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>
Cc: Frans Klaver <frans.klaver@xsens.com>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org

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
later on. The current advice in this situation is to probe the device
from userspace if you expect the battery to come on at some point in the
future. The downside of this approach is that userspace needs to be
aware of the backend of its powersupply, which is inconvenient and going
against the point of hardware abstraction.

In some of these cases you do want to register a battery, even if none
are attached at the moment. To facilitate this, add a configuration
option to try to talk to the device, defaulting to y, thus keeping the
current behavior. If unset, the battery will always be registered
without checking the sanity of the connection.

Signed-off-by: Frans Klaver <frans.klaver@xsens.com>
---
If there's a better place to arrange for this all to happen, or to make this
more common across power supplies, I'm perfectly happy to do that work instead.
For now this seems like the logical step to take, especially since using device
tree was (sensibly) shot down last september [0].

[0] https://lkml.org/lkml/2014/9/24/479

 drivers/power/Kconfig       | 8 ++++++++
 drivers/power/sbs-battery.c | 8 ++++++--
 2 files changed, 14 insertions(+), 2 deletions(-)

diff --git a/drivers/power/Kconfig b/drivers/power/Kconfig
index 87f8cb01fbee..9cb74ce26629 100644
--- a/drivers/power/Kconfig
+++ b/drivers/power/Kconfig
@@ -157,6 +157,14 @@ config BATTERY_SBS
 	  Say Y to include support for SBS battery driver for SBS-compliant
 	  gas gauges.
 
+config BATTERY_SBS_TRY_PROBE
+	bool "Try communicating with SBS battery during probe"
+	depends on BATTERY_SBS
+	default y
+	help
+	  Say Y to try to communicate with the SBS battery during probe.
+	  Otherwise, always register the power supply.
+
 config BATTERY_BQ27x00
 	tristate "BQ27x00 battery driver"
 	depends on I2C || I2C=n
diff --git a/drivers/power/sbs-battery.c b/drivers/power/sbs-battery.c
index c7b7b4018df3..5582d5d49ab8 100644
--- a/drivers/power/sbs-battery.c
+++ b/drivers/power/sbs-battery.c
@@ -882,10 +882,14 @@ static int sbs_probe(struct i2c_client *client,
 
 skip_gpio:
 	/*
-	 * Before we register, we need to make sure we can actually talk
+	 * Before we register, we might need to make sure we can actually talk
 	 * to the battery.
 	 */
-	rc = sbs_read_word_data(client, sbs_data[REG_STATUS].addr);
+	if (IS_ENABLED(CONFIG_BATTERY_SBS_TRY_PROBE))
+		rc = sbs_read_word_data(client, sbs_data[REG_STATUS].addr);
+	else
+		rc = 0;
+
 	if (rc < 0) {
 		dev_err(&client->dev, "%s: Failed to get device status\n",
 			__func__);
-- 
2.3.4

