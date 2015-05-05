From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH 15/27] power: Allow compile test of GPIO consumers if !GPIOLIB
Date: Tue,  5 May 2015 18:32:31 +0200
Message-ID: <1430843563-18615-15-git-send-email-geert@linux-m68k.org>
References: <1430836404-15513-1-git-send-email-geert@linux-m68k.org>
 <1430843563-18615-1-git-send-email-geert@linux-m68k.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1430843563-18615-1-git-send-email-geert@linux-m68k.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <gnurou@gmail.com>, Arnd Bergmann <arnd@arndb.de>
Cc: linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, Geert Uytterhoeven <geert@linux-m68k.org>, Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

The GPIO subsystem provides dummy GPIO consumer functions if GPIOLIB is
not enabled. Hence drivers that depend on GPIOLIB, but use GPIO consumer
functionality only, can still be compiled if GPIOLIB is not enabled.

Relax the dependency on GPIOLIB if COMPILE_TEST is enabled, where
appropriate.

Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Sebastian Reichel <sre@kernel.org>
Cc: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
Cc: David Woodhouse <dwmw2@infradead.org>
Cc: linux-pm@vger.kernel.org
---
 drivers/power/Kconfig | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/power/Kconfig b/drivers/power/Kconfig
index 4091fb092d067aca..19bb57c2623882df 100644
--- a/drivers/power/Kconfig
+++ b/drivers/power/Kconfig
@@ -326,7 +326,7 @@ config CHARGER_LP8788
 
 config CHARGER_GPIO
 	tristate "GPIO charger"
-	depends on GPIOLIB
+	depends on GPIOLIB || COMPILE_TEST
 	help
 	  Say Y to include support for chargers which report their online status
 	  through a GPIO pin.
@@ -384,13 +384,15 @@ config CHARGER_BQ2415X
 
 config CHARGER_BQ24190
 	tristate "TI BQ24190 battery charger driver"
-	depends on I2C && GPIOLIB
+	depends on I2C
+	depends on GPIOLIB || COMPILE_TEST
 	help
 	  Say Y to enable support for the TI BQ24190 battery charger.
 
 config CHARGER_BQ24735
 	tristate "TI BQ24735 battery charger support"
-	depends on I2C && GPIOLIB
+	depends on I2C
+	depends on GPIOLIB || COMPILE_TEST
 	help
 	  Say Y to enable support for the TI BQ24735 battery charger.
 
-- 
1.9.1
