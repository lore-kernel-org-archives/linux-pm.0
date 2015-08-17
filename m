From: Petr Cvek <petr.cvek@tul.cz>
Subject: [PATCH v2 16/21] ARM: pxa: magician: Add support for alternative LCD
 backlight
Date: Tue, 18 Aug 2015 00:04:16 +0200
Message-ID: <55D25A60.7000900@tul.cz>
References: <cover.1439843482.git.petr.cvek@tul.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from bubo.tul.cz ([147.230.16.1]:50453 "EHLO bubo.tul.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751548AbbHQWBY (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Mon, 17 Aug 2015 18:01:24 -0400
In-Reply-To: <cover.1439843482.git.petr.cvek@tul.cz>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: robert.jarzmik@free.fr, philipp.zabel@gmail.com, daniel@zonque.org, haojian.zhuang@gmail.com, sameo@linux.intel.com, lee.jones@linaro.org, cooloney@gmail.com, rpurdie@rpsys.net, j.anaszewski@samsung.com, linux@arm.linux.org.uk, sre@kernel.org, dbaryshkov@gmail.com, dwmw2@infradead.org
Cc: linux-leds@vger.kernel.org, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Add support for alternative LCD backlight with GPIO (no brightness).

Signed-off-by: Petr Cvek <petr.cvek@tul.cz>
---
 arch/arm/mach-pxa/magician.c | 22 +++++++++++++++++++++-
 1 file changed, 21 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-pxa/magician.c b/arch/arm/mach-pxa/magician.c
index 2ec630e..780cc3d 100644
--- a/arch/arm/mach-pxa/magician.c
+++ b/arch/arm/mach-pxa/magician.c
@@ -102,6 +102,8 @@
 #include <mach/udc.h>
 #include <mach/pxa27x-udc.h>
 
+#include <linux/platform_data/gpio_backlight.h>
+
 #include "devices.h"
 #include "generic.h"
 
@@ -549,6 +551,21 @@ static struct regulator_consumer_supply pwm_backlight_supply[] = {
 	REGULATOR_SUPPLY("power", "pwm_backlight"),
 };
 
+/* Backlight controlled by single GPIO (alternative) */
+static struct gpio_backlight_platform_data gpio_backlight_data = {
+/* .fbdev = &pxa_device_fb.dev, */
+	.gpio		= EGPIO_MAGICIAN_BL_POWER,
+	.def_value	= 1,
+	.name		= "backlight",
+};
+
+static struct platform_device gpio_backlight = {
+	.name = "gpio-backlight",
+	.dev = {
+		.platform_data = &gpio_backlight_data,
+	},
+};
+
 /*
  * LEDs
  */
@@ -1269,7 +1286,6 @@ static struct platform_device *devices[] __initdata = {
 	&gpio_keys,
 	&egpio,
 	&strataflash,
-	&pwm_backlight,
 	&pasic3,
 	&vads7846_device,
 	&bq24022,
@@ -1285,6 +1301,10 @@ static struct platform_device *devices[] __initdata = {
 #if !(IS_ENABLED(CONFIG_USB_PXA27X))
 	&gpio_vbus,
 #endif
+
+	/* NOTICE mutually exclusive */
+	&pwm_backlight,
+	&gpio_backlight,
 };
 
 /*
-- 
1.7.12.1

