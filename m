From: Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH] power: supply: axp20x_usb_power: add IIO dependency
Date: Thu, 27 Apr 2017 21:11:48 +0200
Message-ID: <20170427191216.2089294-1-arnd@arndb.de>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.126.135]:56174 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756310AbdD0TLr (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 27 Apr 2017 15:11:47 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>, Quentin Schulz <quentin.schulz@free-electrons.com>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org

When CONFIG_IIO=m and the axp20x_usb_power driver is built-in, we get
a link time error:

drivers/power/built-in.o: In function `axp20x_usb_power_get_property':
undefined reference to `iio_read_channel_processed'
drivers/power/built-in.o: In function `axp20x_usb_power_probe':
undefined reference to `devm_iio_channel_get'
undefined reference to `devm_iio_channel_get'

This adds the same dependency that we already have for the AC power driver
to the USB power driver. For consistency, I'm also moving the two closer
together in the Kconfig file.

Fixes: 33863c938caa ("power: supply: axp20x_usb_power: use IIO channels when available")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/power/supply/Kconfig | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/drivers/power/supply/Kconfig b/drivers/power/supply/Kconfig
index da922756149f..ca1eb456cc4f 100644
--- a/drivers/power/supply/Kconfig
+++ b/drivers/power/supply/Kconfig
@@ -238,6 +238,14 @@ config CHARGER_AXP20X
 	  This driver can also be built as a module. If so, the module will be
 	  called axp20x_ac_power.
 
+config AXP20X_POWER
+	tristate "AXP20x power supply driver"
+	depends on MFD_AXP20X
+	depends on IIO
+	help
+	  This driver provides support for the power supply features of
+	  AXP20x PMIC.
+
 config AXP288_CHARGER
 	tristate "X-Powers AXP288 Charger"
 	depends on MFD_AXP20X && EXTCON_AXP288
@@ -541,11 +549,4 @@ config CHARGER_RT9455
 	help
 	  Say Y to enable support for Richtek RT9455 battery charger.
 
-config AXP20X_POWER
-	tristate "AXP20x power supply driver"
-	depends on MFD_AXP20X
-	help
-	  This driver provides support for the power supply features of
-	  AXP20x PMIC.
-
 endif # POWER_SUPPLY
-- 
2.9.0
