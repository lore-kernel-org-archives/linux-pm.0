From: Petr Cvek <petr.cvek@tul.cz>
Subject: [PATCH v2 10/21] ARM: pxa: magician: Add UDA1380 sound support
Date: Tue, 18 Aug 2015 00:01:27 +0200
Message-ID: <55D259B7.90703@tul.cz>
References: <cover.1439843482.git.petr.cvek@tul.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from bubo.tul.cz ([147.230.16.1]:50115 "EHLO bubo.tul.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750759AbbHQV6g (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Mon, 17 Aug 2015 17:58:36 -0400
In-Reply-To: <cover.1439843482.git.petr.cvek@tul.cz>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: robert.jarzmik@free.fr, philipp.zabel@gmail.com, daniel@zonque.org, haojian.zhuang@gmail.com, sameo@linux.intel.com, lee.jones@linaro.org, cooloney@gmail.com, rpurdie@rpsys.net, j.anaszewski@samsung.com, linux@arm.linux.org.uk, sre@kernel.org, dbaryshkov@gmail.com, dwmw2@infradead.org
Cc: linux-leds@vger.kernel.org, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Add support for UDA1380 sound.

Signed-off-by: Petr Cvek <petr.cvek@tul.cz>
---
 arch/arm/mach-pxa/magician.c | 31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/arch/arm/mach-pxa/magician.c b/arch/arm/mach-pxa/magician.c
index 63604e1..9decd86 100644
--- a/arch/arm/mach-pxa/magician.c
+++ b/arch/arm/mach-pxa/magician.c
@@ -94,6 +94,8 @@
 #include <linux/platform_data/camera-pxa.h>
 #include <media/soc_camera.h>
 
+#include <sound/uda1380.h>
+
 #include "devices.h"
 #include "generic.h"
 
@@ -887,6 +889,31 @@ static struct pxamci_platform_data magician_mci_info = {
 	.gpio_power	= EGPIO_MAGICIAN_SD_POWER,
 };
 
+/*
+ * AUDIO codec UDA1380
+ */
+
+static struct uda1380_platform_data uda1380_info = {
+	.gpio_power	= EGPIO_MAGICIAN_CODEC_POWER,
+	.gpio_reset	= EGPIO_MAGICIAN_CODEC_RESET,
+	.dac_clk	= UDA1380_DAC_CLK_WSPLL,
+};
+
+static struct i2c_board_info magician_audio_i2c_devices[] = {
+	{
+		I2C_BOARD_INFO("uda1380", 0x18),
+		.platform_data = &uda1380_info,
+	},
+};
+
+/*
+ * Magician Audio controller
+ */
+
+static struct platform_device magician_audio_device = {
+	.name = "magician-audio",
+	.id = -1,
+};
 
 /*
  * USB OHCI
@@ -1096,6 +1123,7 @@ static struct platform_device *devices[] __initdata = {
 	&power_supply,
 	&leds_gpio,
 	&magician_camera,
+	&magician_audio_device,
 
 	/* NOTICE mutually exclusive with PXA I2C */
 	&i2c_gpio_bus_alt,
@@ -1143,6 +1171,9 @@ static void __init magician_init(void)
 	pxa_set_ficp_info(&magician_ficp_info);
 	pxa27x_set_i2c_power_info(&magician_i2c_power_info);
 	pxa_set_i2c_info(&i2c_info);
+	i2c_register_board_info(0,
+		ARRAY_AND_SIZE(magician_audio_i2c_devices));
+
 	pxa_set_mci_info(&magician_mci_info);
 	pxa_set_ohci_info(&magician_ohci_info);
 
-- 
1.7.12.1

