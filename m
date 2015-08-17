From: Petr Cvek <petr.cvek@tul.cz>
Subject: [PATCH v2 13/21] ARM: pxa: magician: Fix charging source and add NiCd
 backup charging
Date: Tue, 18 Aug 2015 00:03:07 +0200
Message-ID: <55D25A1B.50106@tul.cz>
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

Fix charging (cable insert functionality shared with UDC). Add charging
control for RTC NiCd accu.

Signed-off-by: Petr Cvek <petr.cvek@tul.cz>
---
 arch/arm/mach-pxa/magician.c | 83 ++++++++++++++++++++++++++++++++++++++------
 1 file changed, 73 insertions(+), 10 deletions(-)

diff --git a/arch/arm/mach-pxa/magician.c b/arch/arm/mach-pxa/magician.c
index 23b59a0..50c5325 100644
--- a/arch/arm/mach-pxa/magician.c
+++ b/arch/arm/mach-pxa/magician.c
@@ -756,18 +756,79 @@ static struct platform_device gpio_vbus = {
  * Charging functions
  */
 
-static int power_supply_init(struct device *dev)
+static int magician_supply_init(struct device *dev)
 {
-	return gpio_request(EGPIO_MAGICIAN_CABLE_TYPE, "CABLE_STATE_AC");
+	int ret = -1;
+
+	ret = gpio_request(EGPIO_MAGICIAN_CABLE_TYPE, "AC charger in USB");
+	if (ret) {
+		pr_err("Cannot request AC/USB charger GPIO (%i)\n", ret);
+		goto err_ac;
+	}
+
+	ret = gpio_request(EGPIO_MAGICIAN_CABLE_INSERT1, "Cable inserted");
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
+	/* EGPIO_MAGICIAN_BQ24022_ISET2: =1 500mA, =0 100mA
+	 *
+	 * RTC NiCd voltage can be read from ADS7846
+	 * in0_input=1930, when =0 (after =1 its going up)
+	 * in0_input=1367, when =1
+	 * in0_input=2499, always (without NiCd)
+	 *
+	 * FIXME Will disabled NiCd slow accu discharge?
+	 *
+	 * Charging from USB can be 500mA too
+	 * NOTICE: IrDA=on, Vcore=1V, Fcore=104MHz, everything other=off
+	 *   -> power consumption still over 100mA
+	 */
+
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
+
+	gpio_set_value(EGPIO_MAGICIAN_NICD_CHARGE, 1);
 }
 
 static int magician_is_ac_online(void)
 {
-	return gpio_get_value(EGPIO_MAGICIAN_CABLE_INSERT1);
+	return gpio_get_value(EGPIO_MAGICIAN_CABLE_INSERT1) &&
+		gpio_get_value(EGPIO_MAGICIAN_CABLE_TYPE); /* AC=1 */
+}
+
+static int magician_is_usb_online(void)
+{
+	my_usb_online = gpio_get_value(EGPIO_MAGICIAN_CABLE_INSERT1) &&
+		(!gpio_get_value(EGPIO_MAGICIAN_CABLE_TYPE)); /* USB=0 */
+	return my_usb_online;
 }
 
-static void power_supply_exit(struct device *dev)
+static void magician_supply_exit(struct device *dev)
 {
+	/* HACK FIXME EGPIO pin is used with two drivers */
+	my_usb_online = 1;
+
+	gpio_free(EGPIO_MAGICIAN_CABLE_INSERT1);
 	gpio_free(EGPIO_MAGICIAN_CABLE_TYPE);
 }
 
@@ -780,11 +841,13 @@ static char *magician_supplicants[] = {
  */
 
 static struct pda_power_pdata power_supply_info = {
-	.init		= power_supply_init,
-	.is_ac_online	= magician_is_ac_online,
-	.exit		= power_supply_exit,
-	.supplied_to	= magician_supplicants,
-	.num_supplicants = ARRAY_SIZE(magician_supplicants),
+	.init			= magician_supply_init,
+	.exit			= magician_supply_exit,
+	.is_ac_online		= magician_is_ac_online,
+	.is_usb_online		= magician_is_usb_online,
+	.set_charge		= magician_set_charge,
+	.supplied_to		= magician_supplicants,
+	.num_supplicants	= ARRAY_SIZE(magician_supplicants),
 };
 
 static struct resource power_supply_resources[] = {
@@ -847,7 +910,7 @@ static struct gpio_regulator_config bq24022_info = {
 
 	.enable_gpio = GPIO30_MAGICIAN_BQ24022_nCHARGE_EN,
 	.enable_high = 0,
-	.enabled_at_boot = 0,
+	.enabled_at_boot = 1,
 
 	.gpios = bq24022_gpios,
 	.nr_gpios = ARRAY_SIZE(bq24022_gpios),
-- 
1.7.12.1
