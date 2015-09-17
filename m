From: Petr Cvek <petr.cvek@tul.cz>
Subject: [PATCH v3 14/26] ARM: pxa: magician: Fix platform data for both
 PXA27x I2C controllers
Date: Thu, 17 Sep 2015 06:59:41 +0200
Message-ID: <55FA48BD.4050900@tul.cz>
References: <cover.1442462898.git.petr.cvek@tul.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: 7bit
Return-path: <linux-leds-owner@vger.kernel.org>
In-Reply-To: <cover.1442462898.git.petr.cvek@tul.cz>
Sender: linux-leds-owner@vger.kernel.org
To: robert.jarzmik@free.fr, philipp.zabel@gmail.com, daniel@zonque.org, haojian.zhuang@gmail.com, cooloney@gmail.com, rpurdie@rpsys.net, j.anaszewski@samsung.com, linux@arm.linux.org.uk, sre@kernel.org, dbaryshkov@gmail.com, lee.jones@linaro.org, sameo@linux.intel.com, dwmw2@infradead.org, arnd@arndb.de, g.liakhovetski@gmx.de
Cc: linux-leds@vger.kernel.org, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-pm@vger.kernel.org

This patch changes fast_mode settings for the normal and power I2C
controller on the HTC Magician machine.

Connected device on the Power I2C:
- MAX1587A: working in the fast mode

Connected devices on the Normal I2C:
- UDA1380: working in the fast mode
- OV9640: bus became stuck in the fast mode

The OV9640 is not using a standard I2C protocol, but an SCCB variant. Maybe
it is not fully compatible in the fast mode. Therefore fast mode for normal
I2C is disabled. If you not using the OV9640 then you can enable the fast
mode for the UDA1380.

Signed-off-by: Petr Cvek <petr.cvek@tul.cz>
---
 arch/arm/mach-pxa/magician.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-pxa/magician.c b/arch/arm/mach-pxa/magician.c
index 906df6d..86d395d 100644
--- a/arch/arm/mach-pxa/magician.c
+++ b/arch/arm/mach-pxa/magician.c
@@ -818,7 +818,16 @@ static struct platform_device strataflash = {
  */
 
 static struct i2c_pxa_platform_data i2c_info = {
-	.fast_mode = 1,
+	/* FIXME both I2C devices should support fast mode */
+	.fast_mode	= 0,
+};
+
+/*
+ * PXA I2C power controller
+ */
+
+static struct i2c_pxa_platform_data magician_i2c_power_info = {
+	.fast_mode	= 1,
 };
 
 /*
@@ -866,7 +875,7 @@ static void __init magician_init(void)
 	platform_add_devices(ARRAY_AND_SIZE(devices));
 
 	pxa_set_ficp_info(&magician_ficp_info);
-	pxa27x_set_i2c_power_info(NULL);
+	pxa27x_set_i2c_power_info(&magician_i2c_power_info);
 	pxa_set_i2c_info(&i2c_info);
 	pxa_set_mci_info(&magician_mci_info);
 	pxa_set_ohci_info(&magician_ohci_info);
-- 
1.7.12.1
