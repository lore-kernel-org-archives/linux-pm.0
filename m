From: Petr Cvek <petr.cvek@tul.cz>
Subject: [PATCH v2 17/21] ARM: pxa: magician: Remove (temporarily) pasic3 LED
 support
Date: Tue, 18 Aug 2015 00:04:36 +0200
Message-ID: <55D25A74.3030902@tul.cz>
References: <cover.1439843482.git.petr.cvek@tul.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from bubo.tul.cz ([147.230.16.1]:50486 "EHLO bubo.tul.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751559AbbHQWBp (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Mon, 17 Aug 2015 18:01:45 -0400
In-Reply-To: <cover.1439843482.git.petr.cvek@tul.cz>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: robert.jarzmik@free.fr, philipp.zabel@gmail.com, daniel@zonque.org, haojian.zhuang@gmail.com, sameo@linux.intel.com, lee.jones@linaro.org, cooloney@gmail.com, rpurdie@rpsys.net, j.anaszewski@samsung.com, linux@arm.linux.org.uk, sre@kernel.org, dbaryshkov@gmail.com, dwmw2@infradead.org
Cc: linux-leds@vger.kernel.org, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Temporarily remove pasic3 LEDs definition as it is not used (yet).

Signed-off-by: Petr Cvek <petr.cvek@tul.cz>
---
 arch/arm/mach-pxa/magician.c | 45 ++------------------------------------------
 1 file changed, 2 insertions(+), 43 deletions(-)

diff --git a/arch/arm/mach-pxa/magician.c b/arch/arm/mach-pxa/magician.c
index 780cc3d..d8994dd 100644
--- a/arch/arm/mach-pxa/magician.c
+++ b/arch/arm/mach-pxa/magician.c
@@ -567,7 +567,7 @@ static struct platform_device gpio_backlight = {
 };
 
 /*
- * LEDs
+ * Phone keys backlight, vibra
  */
 
 static struct gpio_led gpio_leds[] = {
@@ -597,46 +597,6 @@ static struct platform_device leds_gpio = {
 };
 
 /*
- * PASIC3 LEDs
- */
-
-static struct pasic3_led pasic3_leds[] = {
-	{
-		.led = {
-			.name = "magician:red",
-			.default_trigger = "ds2760-battery.0-charging",
-		},
-		.hw_num	= 0,
-		.bit2	= PASIC3_BIT2_LED0,
-		.mask	= PASIC3_MASK_LED0,
-	},
-	{
-		.led = {
-			.name = "magician:green",
-			.default_trigger = "ds2760-battery.0-charging-or-full",
-		},
-		.hw_num	= 1,
-		.bit2	= PASIC3_BIT2_LED1,
-		.mask	= PASIC3_MASK_LED1,
-	},
-	{
-		.led = {
-			.name = "magician:blue",
-			.default_trigger = "bluetooth",
-		},
-		.hw_num	= 2,
-		.bit2	= PASIC3_BIT2_LED2,
-		.mask	= PASIC3_MASK_LED2,
-	},
-};
-
-static struct pasic3_leds_machinfo pasic3_leds_info = {
-	.num_leds	= ARRAY_SIZE(pasic3_leds),
-	.power_gpio	= EGPIO_MAGICIAN_LED_POWER,
-	.leds		= pasic3_leds,
-};
-
-/*
  * PASIC3 DS1WM
  */
 
@@ -656,7 +616,7 @@ static struct resource pasic3_resources[] = {
 
 static struct pasic3_platform_data pasic3_platform_data = {
 	.clock_rate	= 4000000,
-	.led_pdata	= &pasic3_leds_info,
+/*	.led_pdata	= &pasic3_leds_info, */
 };
 
 static struct platform_device pasic3 = {
@@ -1232,7 +1192,6 @@ static struct platform_device i2c_gpio_bus_alt = {
 	}
 };
 
-
 /*
  * Touchscreen
  */
-- 
1.7.12.1

