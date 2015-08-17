From: Petr Cvek <petr.cvek@tul.cz>
Subject: [PATCH v2 11/21] ARM: pxa: magician: Add MAX1586 Vcore regulator
 support
Date: Tue, 18 Aug 2015 00:01:48 +0200
Message-ID: <55D259CC.6040307@tul.cz>
References: <cover.1439843482.git.petr.cvek@tul.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: 7bit
Return-path: <linux-leds-owner@vger.kernel.org>
In-Reply-To: <cover.1439843482.git.petr.cvek@tul.cz>
Sender: linux-leds-owner@vger.kernel.org
To: robert.jarzmik@free.fr, philipp.zabel@gmail.com, daniel@zonque.org, haojian.zhuang@gmail.com, sameo@linux.intel.com, lee.jones@linaro.org, cooloney@gmail.com, rpurdie@rpsys.net, j.anaszewski@samsung.com, linux@arm.linux.org.uk, sre@kernel.org, dbaryshkov@gmail.com, dwmw2@infradead.org
Cc: linux-leds@vger.kernel.org, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-pm@vger.kernel.org

Add support for MAX1586 Vcore regulator.

Signed-off-by: Petr Cvek <petr.cvek@tul.cz>
---
 arch/arm/mach-pxa/magician.c | 50 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 50 insertions(+)

diff --git a/arch/arm/mach-pxa/magician.c b/arch/arm/mach-pxa/magician.c
index 9decd86..8ca0b67 100644
--- a/arch/arm/mach-pxa/magician.c
+++ b/arch/arm/mach-pxa/magician.c
@@ -96,6 +96,8 @@
 
 #include <sound/uda1380.h>
 
+#include <linux/regulator/max1586.h>
+
 #include "devices.h"
 #include "generic.h"
 
@@ -864,6 +866,52 @@ static struct platform_device vads7846_device = {
 };
 
 /*
+ * Vcore regulator MAX1587A
+ */
+
+static struct regulator_consumer_supply magician_max1587a_consumers[] = {
+	REGULATOR_SUPPLY("vcc_core", NULL),
+};
+
+static struct regulator_init_data magician_max1587a_v3_info = {
+	.constraints = {
+		.name		= "vcc_core range",
+		.min_uV		= 700000,
+		.max_uV		= 1500000,
+		.always_on	= 1,
+		.valid_ops_mask	= REGULATOR_CHANGE_VOLTAGE,
+	},
+	.consumer_supplies	= magician_max1587a_consumers,
+	.num_consumer_supplies	= ARRAY_SIZE(magician_max1587a_consumers),
+};
+
+static struct max1586_subdev_data magician_max1587a_subdevs[] = {
+	{
+		.name		= "vcc_core",
+		.id		= MAX1586_V3,
+		.platform_data	= &magician_max1587a_v3_info,
+	}
+};
+
+static struct max1586_platform_data magician_max1587a_info = {
+	.subdevs     = magician_max1587a_subdevs,
+	.num_subdevs = ARRAY_SIZE(magician_max1587a_subdevs),
+	/*
+	 * NOTICE measured directly on the PCB (board_id == 0x3a), but
+	 * if R24 is present, it will boost the voltage
+	 * (write 1.475V, get 1.645V and smoke)
+	 */
+	.v3_gain     = MAX1586_GAIN_NO_R24,
+};
+
+static struct i2c_board_info magician_pwr_i2c_board_info[] __initdata = {
+	{
+		I2C_BOARD_INFO("max1586", 0x14),
+		.platform_data	= &magician_max1587a_info,
+	},
+};
+
+/*
  * MMC/SD
  */
 
@@ -1173,6 +1221,8 @@ static void __init magician_init(void)
 	pxa_set_i2c_info(&i2c_info);
 	i2c_register_board_info(0,
 		ARRAY_AND_SIZE(magician_audio_i2c_devices));
+	i2c_register_board_info(1,
+		ARRAY_AND_SIZE(magician_pwr_i2c_board_info));
 
 	pxa_set_mci_info(&magician_mci_info);
 	pxa_set_ohci_info(&magician_ohci_info);
-- 
1.7.12.1
