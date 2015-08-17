From: Petr Cvek <petr.cvek@tul.cz>
Subject: [PATCH v2 08/21] ARM: pxa: magician: Add StrataFlash Vpp GPIO and
 alternative driver
Date: Tue, 18 Aug 2015 00:00:40 +0200
Message-ID: <55D25988.1090109@tul.cz>
References: <cover.1439843482.git.petr.cvek@tul.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from bubo.tul.cz ([147.230.16.1]:50018 "EHLO bubo.tul.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750759AbbHQV5t (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Mon, 17 Aug 2015 17:57:49 -0400
In-Reply-To: <cover.1439843482.git.petr.cvek@tul.cz>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: robert.jarzmik@free.fr, philipp.zabel@gmail.com, daniel@zonque.org, haojian.zhuang@gmail.com, sameo@linux.intel.com, lee.jones@linaro.org, cooloney@gmail.com, rpurdie@rpsys.net, j.anaszewski@samsung.com, linux@arm.linux.org.uk, sre@kernel.org, dbaryshkov@gmail.com, dwmw2@infradead.org
Cc: linux-leds@vger.kernel.org, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Add StrataFlash Vpp GPIO and alternative driver.

Signed-off-by: Petr Cvek <petr.cvek@tul.cz>
---
 arch/arm/mach-pxa/magician.c | 76 ++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 73 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-pxa/magician.c b/arch/arm/mach-pxa/magician.c
index 7519238..7331b34 100644
--- a/arch/arm/mach-pxa/magician.c
+++ b/arch/arm/mach-pxa/magician.c
@@ -845,20 +845,66 @@ static struct pxaohci_platform_data magician_ohci_info = {
  * StrataFlash
  */
 
+static int magician_flash_init(struct platform_device *pdev)
+{
+	int ret = gpio_request(EGPIO_MAGICIAN_FLASH_VPP, "flash Vpp enable");
+
+	if (ret) {
+		pr_err("Cannot request flash enable GPIO (%i)\n", ret);
+		return ret;
+	}
+
+	ret = gpio_direction_output(EGPIO_MAGICIAN_FLASH_VPP, 1);
+	if (ret) {
+		pr_err("Cannot set direction for flash enable (%i)\n", ret);
+		gpio_free(EGPIO_MAGICIAN_FLASH_VPP);
+	}
+
+	return ret;
+}
+
 static void magician_set_vpp(struct platform_device *pdev, int vpp)
 {
 	gpio_set_value(EGPIO_MAGICIAN_FLASH_VPP, vpp);
 }
 
+static void magician_flash_exit(struct platform_device *pdev)
+{
+	gpio_free(EGPIO_MAGICIAN_FLASH_VPP);
+}
+
 static struct resource strataflash_resource = {
 	.start	= PXA_CS0_PHYS,
 	.end	= PXA_CS0_PHYS + SZ_64M - 1,
 	.flags	= IORESOURCE_MEM,
 };
 
+static struct mtd_partition magician_flash_parts[] = {
+	{
+		.name		= "Bootloader",
+		.offset		= 0x0,
+		.size		= 0x40000,
+		.mask_flags	= MTD_WRITEABLE,	/* EXPERIMENTAL */
+	},
+	{
+		.name	= "Linux Kernel",
+		.offset	= 0x40000,
+		.size	= MTDPART_SIZ_FULL,
+	},
+};
+
+#if 1	/* Choose which one fits you better */
+/*
+ * physmap-flash driver
+ */
+
 static struct physmap_flash_data strataflash_data = {
-	.width = 4,
-	.set_vpp = magician_set_vpp,
+	.width		= 4,
+	.init		= magician_flash_init,
+	.set_vpp	= magician_set_vpp,
+	.exit		= magician_flash_exit,
+	.parts		= magician_flash_parts,
+	.nr_parts	= ARRAY_SIZE(magician_flash_parts),
 };
 
 static struct platform_device strataflash = {
@@ -871,6 +917,30 @@ static struct platform_device strataflash = {
 	},
 };
 
+#else
+
+/*
+ * pxa2xx-flash driver
+ */
+
+static struct flash_platform_data magician_flash_data = {
+	.map_name	= "cfi_probe",
+	.parts		= magician_flash_parts,
+	.nr_parts	= ARRAY_SIZE(magician_flash_parts),
+	.width		= 4,
+};
+
+static struct platform_device strataflash = {
+	.name	= "pxa2xx-flash",
+	.id	= -1,
+	.dev = {
+		.platform_data = &magician_flash_data,
+	},
+	.resource = &strataflash_resource,
+	.num_resources = 1,
+};
+#endif
+
 /*
  * PXA I2C normal controller (main)
  */
@@ -960,13 +1030,13 @@ static struct spi_board_info ads7846_spi_board_info[] __initdata = {
 static struct platform_device *devices[] __initdata = {
 	&gpio_keys,
 	&egpio,
+	&strataflash,
 	&pwm_backlight,
 	&pasic3,
 	&vads7846_device,
 	&bq24022,
 	&gpio_vbus,
 	&power_supply,
-	&strataflash,
 	&leds_gpio,
 
 	/* NOTICE mutually exclusive with PXA I2C */
-- 
1.7.12.1

