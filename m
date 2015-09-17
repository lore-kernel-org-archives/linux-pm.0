From: Petr Cvek <petr.cvek@tul.cz>
Subject: [PATCH v3 13/26] ARM: pxa: magician: Fix and add charging detection
 functions
Date: Thu, 17 Sep 2015 06:59:12 +0200
Message-ID: <55FA48A0.9090709@tul.cz>
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

This patch fixes the charging detection functions for pda_power driver
(according to newly discovered EGPIOs) and add NiCd backup accumulator
charging support.

Signed-off-by: Petr Cvek <petr.cvek@tul.cz>
---
 arch/arm/mach-pxa/magician.c | 57 ++++++++++++++++++++++++++++++++++++++------
 1 file changed, 50 insertions(+), 7 deletions(-)

diff --git a/arch/arm/mach-pxa/magician.c b/arch/arm/mach-pxa/magician.c
index b645288..906df6d 100644
--- a/arch/arm/mach-pxa/magician.c
+++ b/arch/arm/mach-pxa/magician.c
@@ -596,18 +596,59 @@ static struct platform_device gpio_vbus = {
  * External power
  */
 
-static int power_supply_init(struct device *dev)
+static int magician_supply_init(struct device *dev)
 {
-	return gpio_request(EGPIO_MAGICIAN_CABLE_TYPE, "Cable USB/AC type");
+	int ret = -1;
+
+	ret = gpio_request(EGPIO_MAGICIAN_CABLE_TYPE, "Cable is AC charger");
+	if (ret) {
+		pr_err("Cannot request AC/USB charger GPIO (%i)\n", ret);
+		goto err_ac;
+	}
+
+	ret = gpio_request(EGPIO_MAGICIAN_CABLE_INSERTED, "Cable inserted");
+	if (ret) {
+		pr_err("Cannot request cable detection GPIO (%i)\n", ret);
+		goto err_usb;
+	}
+
+	return 0;
+
+err_usb:
+	gpio_free(EGPIO_MAGICIAN_CABLE_TYPE);
+err_ac:
+	return ret;
+}
+
+static void magician_set_charge(int flags)
+{
+	if (flags & PDA_POWER_CHARGE_AC) {
+		pr_debug("Charging from AC\n");
+		gpio_set_value(EGPIO_MAGICIAN_NICD_CHARGE, 1);
+	} else if (flags & PDA_POWER_CHARGE_USB) {
+		pr_debug("Charging from USB\n");
+		gpio_set_value(EGPIO_MAGICIAN_NICD_CHARGE, 1);
+	} else {
+		pr_debug("Charging disabled\n");
+		gpio_set_value(EGPIO_MAGICIAN_NICD_CHARGE, 0);
+	}
 }
 
 static int magician_is_ac_online(void)
 {
-	return gpio_get_value(EGPIO_MAGICIAN_CABLE_TYPE);
+	return gpio_get_value(EGPIO_MAGICIAN_CABLE_INSERTED) &&
+		gpio_get_value(EGPIO_MAGICIAN_CABLE_TYPE); /* AC=1 */
+}
+
+static int magician_is_usb_online(void)
+{
+	return gpio_get_value(EGPIO_MAGICIAN_CABLE_INSERTED) &&
+		(!gpio_get_value(EGPIO_MAGICIAN_CABLE_TYPE)); /* USB=0 */
 }
 
-static void power_supply_exit(struct device *dev)
+static void magician_supply_exit(struct device *dev)
 {
+	gpio_free(EGPIO_MAGICIAN_CABLE_INSERTED);
 	gpio_free(EGPIO_MAGICIAN_CABLE_TYPE);
 }
 
@@ -616,9 +657,11 @@ static char *magician_supplicants[] = {
 };
 
 static struct pda_power_pdata power_supply_info = {
-	.init			= power_supply_init,
+	.init			= magician_supply_init,
+	.exit			= magician_supply_exit,
 	.is_ac_online		= magician_is_ac_online,
-	.exit			= power_supply_exit,
+	.is_usb_online		= magician_is_usb_online,
+	.set_charge		= magician_set_charge,
 	.supplied_to		= magician_supplicants,
 	.num_supplicants	= ARRAY_SIZE(magician_supplicants),
 };
@@ -683,7 +726,7 @@ static struct gpio_regulator_config bq24022_info = {
 
 	.enable_gpio		= GPIO30_MAGICIAN_BQ24022_nCHARGE_EN,
 	.enable_high		= 0,
-	.enabled_at_boot	= 0,
+	.enabled_at_boot	= 1,
 
 	.gpios			= bq24022_gpios,
 	.nr_gpios		= ARRAY_SIZE(bq24022_gpios),
-- 
1.7.12.1
