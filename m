From: Petr Cvek <petr.cvek@tul.cz>
Subject: [PATCH v2 20/21] ARM: pxa: magician: Re-add pdata for new leds-pasic3
 driver
Date: Tue, 18 Aug 2015 00:06:42 +0200
Message-ID: <55D25AF2.1080408@tul.cz>
References: <cover.1439843482.git.petr.cvek@tul.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from bubo.tul.cz ([147.230.16.1]:50635 "EHLO bubo.tul.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751297AbbHQWDt (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Mon, 17 Aug 2015 18:03:49 -0400
In-Reply-To: <cover.1439843482.git.petr.cvek@tul.cz>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: robert.jarzmik@free.fr, philipp.zabel@gmail.com, daniel@zonque.org, haojian.zhuang@gmail.com, sameo@linux.intel.com, lee.jones@linaro.org, cooloney@gmail.com, rpurdie@rpsys.net, j.anaszewski@samsung.com, linux@arm.linux.org.uk, sre@kernel.org, dbaryshkov@gmail.com, dwmw2@infradead.org
Cc: linux-leds@vger.kernel.org, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Re-add definition of LEDs PASIC3 to magician.c.

Signed-off-by: Petr Cvek <petr.cvek@tul.cz>
---
 arch/arm/mach-pxa/magician.c | 54 +++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 53 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-pxa/magician.c b/arch/arm/mach-pxa/magician.c
index d8994dd..5f02ce4 100644
--- a/arch/arm/mach-pxa/magician.c
+++ b/arch/arm/mach-pxa/magician.c
@@ -597,6 +597,58 @@ static struct platform_device leds_gpio = {
 };
 
 /*
+ * PASIC3 LEDs
+ */
+
+static struct pasic3_led magician_pasic3_leds[] = {
+	{
+		.hw_num = 0,
+		.name = "magician:red",
+		.default_trigger = "ds2760-battery.0-charging",
+		.bit_blink_en	= R06_CH0_EN,
+		.bit_force_on	= R06_CH0_FORCE_ON,
+		.bit_mask	= MASK_CH0,
+		.reg_delay_on	= PASIC3_CH0_DELAY_ON,
+		.reg_delay_off	= PASIC3_CH0_DELAY_OFF,
+	},
+	{
+		.hw_num = 1,
+		.name = "magician:green",
+		.default_trigger = "ds2760-battery.0-charging-or-full",
+		.bit_blink_en	= R06_CH1_EN,
+		.bit_force_on	= R06_CH1_FORCE_ON,
+		.bit_mask	= MASK_CH1,
+		.reg_delay_on	= PASIC3_CH1_DELAY_ON,
+		.reg_delay_off	= PASIC3_CH1_DELAY_OFF,
+	},
+	{
+		.hw_num = 2,
+		.name = "magician:blue",
+		.default_trigger = "bluetooth",
+		.bit_blink_en	= R06_CH2_EN,
+		.bit_force_on	= R06_CH2_FORCE_ON,
+		.bit_mask	= MASK_CH2,
+		.reg_delay_on	= PASIC3_CH2_DELAY_ON,
+		.reg_delay_off	= PASIC3_CH2_DELAY_OFF,
+	},
+};
+
+static struct pasic3_leds_pdata magician_pasic3_led_pdata = {
+	.leds		= magician_pasic3_leds,
+	.num_leds	= ARRAY_SIZE(magician_pasic3_leds),
+	/* Green LED doesn't use power_gpio */
+	.power_gpio	= EGPIO_MAGICIAN_LED_POWER,
+};
+
+static struct platform_device pasic3_leds = {
+	.name	= "leds-pasic3",
+	.id	= -1,
+	.dev = {
+		.platform_data = &magician_pasic3_led_pdata,
+	},
+};
+
+/*
  * PASIC3 DS1WM
  */
 
@@ -616,7 +668,7 @@ static struct resource pasic3_resources[] = {
 
 static struct pasic3_platform_data pasic3_platform_data = {
 	.clock_rate	= 4000000,
-/*	.led_pdata	= &pasic3_leds_info, */
+	.pasic3_leds	= &pasic3_leds,
 };
 
 static struct platform_device pasic3 = {
-- 
1.7.12.1

