From: Petr Cvek <petr.cvek@tul.cz>
Subject: [PATCH v2 12/21] ARM: pxa: magician: Add PXA27x UDC support
Date: Tue, 18 Aug 2015 00:02:46 +0200
Message-ID: <55D25A06.9030507@tul.cz>
References: <cover.1439843482.git.petr.cvek@tul.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from bubo.tul.cz ([147.230.16.1]:50279 "EHLO bubo.tul.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751387AbbHQV7y (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Mon, 17 Aug 2015 17:59:54 -0400
In-Reply-To: <cover.1439843482.git.petr.cvek@tul.cz>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: robert.jarzmik@free.fr, philipp.zabel@gmail.com, daniel@zonque.org, haojian.zhuang@gmail.com, sameo@linux.intel.com, lee.jones@linaro.org, cooloney@gmail.com, rpurdie@rpsys.net, j.anaszewski@samsung.com, linux@arm.linux.org.uk, sre@kernel.org, dbaryshkov@gmail.com, dwmw2@infradead.org
Cc: linux-leds@vger.kernel.org, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Add support for PXA27x UDC to HTC Magician.

Signed-off-by: Petr Cvek <petr.cvek@tul.cz>
---
 arch/arm/mach-pxa/magician.c | 40 +++++++++++++++++++++++++++++++++++++++-
 1 file changed, 39 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-pxa/magician.c b/arch/arm/mach-pxa/magician.c
index 8ca0b67..23b59a0 100644
--- a/arch/arm/mach-pxa/magician.c
+++ b/arch/arm/mach-pxa/magician.c
@@ -98,6 +98,10 @@
 
 #include <linux/regulator/max1586.h>
 
+#include <linux/platform_data/pxa2xx_udc.h>
+#include <mach/udc.h>
+#include <mach/pxa27x-udc.h>
+
 #include "devices.h"
 #include "generic.h"
 
@@ -698,6 +702,34 @@ static struct platform_device magician_camera = {
  * USB "Transceiver"
  */
 
+#if IS_ENABLED(CONFIG_USB_PXA27X)
+static void magician_udc_command(int cmd)
+{
+	if (cmd == PXA2XX_UDC_CMD_CONNECT)
+		UP2OCR |= UP2OCR_DPPUE | UP2OCR_DPPUBE;
+	else if (cmd == PXA2XX_UDC_CMD_DISCONNECT)
+		UP2OCR &= ~(UP2OCR_DPPUE | UP2OCR_DPPUBE);
+}
+
+/* HACK, shared USB connected state with pda-power */
+int my_usb_online = 1;
+
+static int magician_udc_is_connected(void)
+{
+	/* Shared with pda_power or gpio-vbus */
+	return my_usb_online;
+}
+
+static struct pxa2xx_udc_mach_info magician_udc_info __initdata = {
+	.udc_command		= magician_udc_command,
+	.udc_is_connected	= magician_udc_is_connected,
+	.gpio_pullup		= GPIO27_MAGICIAN_USBC_PUEN,
+};
+
+#else
+
+/* GPIO USB client vbus sensing, when no PXA UDC installed */
+
 static struct resource gpio_vbus_resource = {
 	.flags	= IORESOURCE_IRQ,
 	.start	= IRQ_MAGICIAN_VBUS,
@@ -718,6 +750,7 @@ static struct platform_device gpio_vbus = {
 		.platform_data = &gpio_vbus_info,
 	},
 };
+#endif	/* IS_ENABLED(CONFIG_USB_PXA27X) */
 
 /*
  * Charging functions
@@ -1167,7 +1200,6 @@ static struct platform_device *devices[] __initdata = {
 	&pasic3,
 	&vads7846_device,
 	&bq24022,
-	&gpio_vbus,
 	&power_supply,
 	&leds_gpio,
 	&magician_camera,
@@ -1175,6 +1207,11 @@ static struct platform_device *devices[] __initdata = {
 
 	/* NOTICE mutually exclusive with PXA I2C */
 	&i2c_gpio_bus_alt,
+
+	/* NOTICE mutually exclusive with UDC*/
+#if !(IS_ENABLED(CONFIG_USB_PXA27X))
+	&gpio_vbus,
+#endif
 };
 
 /*
@@ -1226,6 +1263,7 @@ static void __init magician_init(void)
 
 	pxa_set_mci_info(&magician_mci_info);
 	pxa_set_ohci_info(&magician_ohci_info);
+	pxa_set_udc_info(&magician_udc_info);
 
 	/* Check LCD type we have */
 	cpld = ioremap_nocache(PXA_CS3_PHYS, 0x1000);
-- 
1.7.12.1

