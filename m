From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH v2 05/11] power: Allow compile test of GPIO consumers if !GPIOLIB
Date: Sun,  2 Aug 2015 11:09:50 +0200
Message-ID: <1438506590-31673-1-git-send-email-geert@linux-m68k.org>
References: <1438506475-31012-1-git-send-email-geert@linux-m68k.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from andre.telenet-ops.be ([195.130.132.53]:42128 "EHLO
	andre.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752180AbbHBJJv (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sun, 2 Aug 2015 05:09:51 -0400
In-Reply-To: <1438506475-31012-1-git-send-email-geert@linux-m68k.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>
Cc: linux-pm@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <gnurou@gmail.com>, linux-gpio@vger.kernel.org, Geert Uytterhoeven <geert@linux-m68k.org>

The GPIO subsystem provides dummy GPIO consumer functions if GPIOLIB is
not enabled. Hence drivers that depend on GPIOLIB, but use GPIO consumer
functionality only, can still be compiled if GPIOLIB is not enabled.

Relax the dependency on GPIOLIB if COMPILE_TEST is enabled, where
appropriate.

Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
Acked-by: Linus Walleij <linus.walleij@linaro.org>
---
v2:
  - Add Acked-by,
  - Add recently added CHARGER_BQ24257, CHARGER_BQ25890, and
    CHARGER_RT9455.
---
 drivers/power/Kconfig | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/drivers/power/Kconfig b/drivers/power/Kconfig
index 08beeed5485d3067..f8758d6febf818a7 100644
--- a/drivers/power/Kconfig
+++ b/drivers/power/Kconfig
@@ -333,7 +333,7 @@ config CHARGER_LP8788
 
 config CHARGER_GPIO
 	tristate "GPIO charger"
-	depends on GPIOLIB
+	depends on GPIOLIB || COMPILE_TEST
 	help
 	  Say Y to include support for chargers which report their online status
 	  through a GPIO pin.
@@ -391,26 +391,30 @@ config CHARGER_BQ2415X
 
 config CHARGER_BQ24190
 	tristate "TI BQ24190 battery charger driver"
-	depends on I2C && GPIOLIB
+	depends on I2C
+	depends on GPIOLIB || COMPILE_TEST
 	help
 	  Say Y to enable support for the TI BQ24190 battery charger.
 
 config CHARGER_BQ24257
 	tristate "TI BQ24257 battery charger driver"
-	depends on I2C && GPIOLIB
+	depends on I2C
+	depends on GPIOLIB || COMPILE_TEST
 	depends on REGMAP_I2C
 	help
 	  Say Y to enable support for the TI BQ24257 battery charger.
 
 config CHARGER_BQ24735
 	tristate "TI BQ24735 battery charger support"
-	depends on I2C && GPIOLIB
+	depends on I2C
+	depends on GPIOLIB || COMPILE_TEST
 	help
 	  Say Y to enable support for the TI BQ24735 battery charger.
 
 config CHARGER_BQ25890
 	tristate "TI BQ25890 battery charger driver"
-	depends on I2C && GPIOLIB
+	depends on I2C
+	depends on GPIOLIB || COMPILE_TEST
 	select REGMAP_I2C
 	help
 	  Say Y to enable support for the TI BQ25890 battery charger.
@@ -462,7 +466,8 @@ config BATTERY_RT5033
 
 config CHARGER_RT9455
 	tristate "Richtek RT9455 battery charger driver"
-	depends on I2C && GPIOLIB
+	depends on I2C
+	depends on GPIOLIB || COMPILE_TEST
 	select REGMAP_I2C
 	help
 	  Say Y to enable support for Richtek RT9455 battery charger.
-- 
1.9.1

