From: Quentin Schulz <quentin.schulz-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Subject: [PATCH v6 2/6] power: supply: add battery driver for
 AXP20X and AXP22X PMICs
Date: Tue, 18 Apr 2017 09:34:17 +0200
Message-ID: <20170418073421.31351-3-quentin.schulz@free-electrons.com>
References: <20170418073421.31351-1-quentin.schulz@free-electrons.com>
Reply-To: quentin.schulz-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-sunxi+bncBCLZXSNY5IDBBHME27DQKGQEFXPCLMI-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
In-Reply-To: <20170418073421.31351-1-quentin.schulz-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
List-Post: <https://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <https://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <https://groups.google.com/group/linux-sunxi
List-Subscribe: <https://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <https://groups.google.com/group/linux-sunxi/subscribe>
To: sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, wens-jdAy2FN1RRM@public.gmane.org, linux-I+IVW8TIWO2tmTQ+vhA3Yw@public.gmane.org, maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org
Cc: Quentin Schulz <quentin.schulz-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org, icenowy-ymACFijhrKM@public.gmane.org, liam-RYWXG+zxWwBdeoIcmNTgJF6hYfS7NtTn@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-pm@vger.kernel.org

The X-Powers AXP20X and AXP22X PMICs can have a battery as power supply.

This patch adds the battery power supply driver to get various data from
the PMIC, such as the battery status (charging, discharging, full,
dead), current max limit, current current, battery capacity (in
percentage), voltage max and min limits, current voltage and battery
capacity (in Ah).

This battery driver uses the AXP20X/AXP22X ADC driver as PMIC data
provider.

Signed-off-by: Quentin Schulz <quentin.schulz-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Acked-by: Jonathan Cameron <jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Acked-by: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Acked-by: Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>
Acked-by: Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
---

v5:
 - removed support for constant charge current setting from DT,
 - added a function to compute the constant charge current depending on the
 PMIC variant,

v4:
 - removed useless axp20x_dev variable in struct axp20x_batt_ps,
 - added struct device and maximum constant current charge variables in str=
uct
 axp20x_batt_ps,
 - fixed wrong maximum constant current charge formula for AXP22X (forgot t=
o add
 a custom formula so it was calculated like the AXP209),
 - when a battery node in DT does not have a valid constant current charge =
or
 there is no battery, the maximum current constant current charge are set t=
o the
 lowest possible value,
 - it is possible to set maximum constant current charge now but a warn mes=
sage
 is printed when trying to increase it to inform people it is risky,
 - added a check to verify the constant current charge to be set is under t=
he
 maximum allowed,
 - lower the current constant charge current if it is higher than the maxim=
um
 current value to be set,

v3:
 - added axp20x_set_voltage_min_design function so it can be reused,
 - used power_supply_get_battery_info for setting constant charge current
 instead of x-powers,constant-charge-current introduced in v2,
 - used power_supply_get_battery_info for setting voltage min design of
 the battery,

v2:
 - changed BIT(x) to 1 << x when describing bits purpose for which 2 <<
 x or 3 << x exists, to be consistent,
 - switched from POWER_SUPPLY_PROP_CURRENT_MAX to
 POWER_SUPPLY_PROP_CONSTANT_CHARGE_CURRENT,
 - added POWER_SUPPLY_PROP_CONSTANT_CHARGE_CURRENT_MAX to the list of
 readable properties,
 - replaced =C2=B5 character by a common u for micro units to make checkpat=
ch
 happy,
 - factorized code in axp20x_battery_set_max_voltage,
 - added a axp20x_set_constant_charge_current function to be used when
 setting the value from sysfs and from the DT,
 - removed some dead code,
 - added a DT property to set constant current charge of the battery
 (x-powers,constant-charge-current),
 - migrated to dev_get_regmap instead of manually looking for the regmap
 in the drvdata of the parent,
 - switched from int to uintptr_t cast to make sure the cast is always
 for the same size type (make build on 64bits platforms happy mainly),

 drivers/power/supply/Kconfig          |  12 +
 drivers/power/supply/Makefile         |   1 +
 drivers/power/supply/axp20x_battery.c | 502 ++++++++++++++++++++++++++++++=
++++
 3 files changed, 515 insertions(+)
 create mode 100644 drivers/power/supply/axp20x_battery.c

diff --git a/drivers/power/supply/Kconfig b/drivers/power/supply/Kconfig
index da922756149f..4b718e90b3ca 100644
--- a/drivers/power/supply/Kconfig
+++ b/drivers/power/supply/Kconfig
@@ -238,6 +238,18 @@ config CHARGER_AXP20X
 	  This driver can also be built as a module. If so, the module will be
 	  called axp20x_ac_power.
=20
+config BATTERY_AXP20X
+	tristate "X-Powers AXP20X battery driver"
+	depends on MFD_AXP20X
+	depends on AXP20X_ADC
+	depends on IIO
+	help
+	  Say Y here to enable support for X-Powers AXP20X PMICs' battery power
+	  supply.
+
+	  This driver can also be built as a module. If so, the module will be
+	  called axp20x_battery.
+
 config AXP288_CHARGER
 	tristate "X-Powers AXP288 Charger"
 	depends on MFD_AXP20X && EXTCON_AXP288
diff --git a/drivers/power/supply/Makefile b/drivers/power/supply/Makefile
index 39fc733e6cc4..a39126d7a6ce 100644
--- a/drivers/power/supply/Makefile
+++ b/drivers/power/supply/Makefile
@@ -18,6 +18,7 @@ obj-$(CONFIG_TEST_POWER)	+=3D test_power.o
=20
 obj-$(CONFIG_BATTERY_88PM860X)	+=3D 88pm860x_battery.o
 obj-$(CONFIG_BATTERY_ACT8945A)	+=3D act8945a_charger.o
+obj-$(CONFIG_BATTERY_AXP20X)	+=3D axp20x_battery.o
 obj-$(CONFIG_CHARGER_AXP20X)	+=3D axp20x_ac_power.o
 obj-$(CONFIG_BATTERY_DS2760)	+=3D ds2760_battery.o
 obj-$(CONFIG_BATTERY_DS2780)	+=3D ds2780_battery.o
diff --git a/drivers/power/supply/axp20x_battery.c b/drivers/power/supply/a=
xp20x_battery.c
new file mode 100644
index 000000000000..5d29b2eab8fc
--- /dev/null
+++ b/drivers/power/supply/axp20x_battery.c
@@ -0,0 +1,502 @@
+/*
+ * Battery power supply driver for X-Powers AXP20X and AXP22X PMICs
+ *
+ * Copyright 2016 Free Electrons NextThing Co.
+ *	Quentin Schulz <quentin.schulz-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
+ *
+ * This driver is based on a previous upstreaming attempt by:
+ *	Bruno Pr=C3=A9mont <bonbons-ud5FBsm0p/xEiooADzr8i9i2O/JbrIOy@public.gmane.org>
+ *
+ * This file is subject to the terms and conditions of the GNU General
+ * Public License. See the file "COPYING" in the main directory of this
+ * archive for more details.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
+ * GNU General Public License for more details.
+ */
+
+#include <linux/err.h>
+#include <linux/interrupt.h>
+#include <linux/irq.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/of_device.h>
+#include <linux/platform_device.h>
+#include <linux/power_supply.h>
+#include <linux/regmap.h>
+#include <linux/slab.h>
+#include <linux/time.h>
+#include <linux/iio/iio.h>
+#include <linux/iio/consumer.h>
+#include <linux/mfd/axp20x.h>
+
+#define AXP20X_PWR_STATUS_BAT_CHARGING	BIT(2)
+
+#define AXP20X_PWR_OP_BATT_PRESENT	BIT(5)
+#define AXP20X_PWR_OP_BATT_ACTIVATED	BIT(3)
+
+#define AXP209_FG_PERCENT		GENMASK(6, 0)
+#define AXP22X_FG_VALID			BIT(7)
+
+#define AXP20X_CHRG_CTRL1_TGT_VOLT	GENMASK(6, 5)
+#define AXP20X_CHRG_CTRL1_TGT_4_1V	(0 << 5)
+#define AXP20X_CHRG_CTRL1_TGT_4_15V	(1 << 5)
+#define AXP20X_CHRG_CTRL1_TGT_4_2V	(2 << 5)
+#define AXP20X_CHRG_CTRL1_TGT_4_36V	(3 << 5)
+
+#define AXP22X_CHRG_CTRL1_TGT_4_22V	(1 << 5)
+#define AXP22X_CHRG_CTRL1_TGT_4_24V	(3 << 5)
+
+#define AXP20X_CHRG_CTRL1_TGT_CURR	GENMASK(3, 0)
+
+#define AXP20X_V_OFF_MASK		GENMASK(2, 0)
+
+struct axp20x_batt_ps {
+	struct regmap *regmap;
+	struct power_supply *batt;
+	struct device *dev;
+	struct iio_channel *batt_chrg_i;
+	struct iio_channel *batt_dischrg_i;
+	struct iio_channel *batt_v;
+	u8 axp_id;
+};
+
+static int axp20x_battery_get_max_voltage(struct axp20x_batt_ps *axp20x_ba=
tt,
+					  int *val)
+{
+	int ret, reg;
+
+	ret =3D regmap_read(axp20x_batt->regmap, AXP20X_CHRG_CTRL1, &reg);
+	if (ret)
+		return ret;
+
+	switch (reg & AXP20X_CHRG_CTRL1_TGT_VOLT) {
+	case AXP20X_CHRG_CTRL1_TGT_4_1V:
+		*val =3D 4100000;
+		break;
+	case AXP20X_CHRG_CTRL1_TGT_4_15V:
+		*val =3D 4150000;
+		break;
+	case AXP20X_CHRG_CTRL1_TGT_4_2V:
+		*val =3D 4200000;
+		break;
+	case AXP20X_CHRG_CTRL1_TGT_4_36V:
+		*val =3D 4360000;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static int axp22x_battery_get_max_voltage(struct axp20x_batt_ps *axp20x_ba=
tt,
+					  int *val)
+{
+	int ret, reg;
+
+	ret =3D regmap_read(axp20x_batt->regmap, AXP20X_CHRG_CTRL1, &reg);
+	if (ret)
+		return ret;
+
+	switch (reg & AXP20X_CHRG_CTRL1_TGT_VOLT) {
+	case AXP20X_CHRG_CTRL1_TGT_4_1V:
+		*val =3D 4100000;
+		break;
+	case AXP20X_CHRG_CTRL1_TGT_4_2V:
+		*val =3D 4200000;
+		break;
+	case AXP22X_CHRG_CTRL1_TGT_4_22V:
+		*val =3D 4220000;
+		break;
+	case AXP22X_CHRG_CTRL1_TGT_4_24V:
+		*val =3D 4240000;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static void raw_to_constant_charge_current(struct axp20x_batt_ps *axp, int=
 *val)
+{
+	if (axp->axp_id =3D=3D AXP209_ID)
+		*val =3D *val * 100000 + 300000;
+	else
+		*val =3D *val * 150000 + 300000;
+}
+
+static int axp20x_get_constant_charge_current(struct axp20x_batt_ps *axp,
+					      int *val)
+{
+	int ret;
+
+	ret =3D regmap_read(axp->regmap, AXP20X_CHRG_CTRL1, val);
+	if (ret)
+		return ret;
+
+	*val &=3D AXP20X_CHRG_CTRL1_TGT_CURR;
+
+	raw_to_constant_charge_current(axp, val);
+
+	return 0;
+}
+
+static int axp20x_battery_get_prop(struct power_supply *psy,
+				   enum power_supply_property psp,
+				   union power_supply_propval *val)
+{
+	struct axp20x_batt_ps *axp20x_batt =3D power_supply_get_drvdata(psy);
+	struct iio_channel *chan;
+	int ret =3D 0, reg, val1;
+
+	switch (psp) {
+	case POWER_SUPPLY_PROP_PRESENT:
+	case POWER_SUPPLY_PROP_ONLINE:
+		ret =3D regmap_read(axp20x_batt->regmap, AXP20X_PWR_OP_MODE,
+				  &reg);
+		if (ret)
+			return ret;
+
+		val->intval =3D !!(reg & AXP20X_PWR_OP_BATT_PRESENT);
+		break;
+
+	case POWER_SUPPLY_PROP_STATUS:
+		ret =3D regmap_read(axp20x_batt->regmap, AXP20X_PWR_INPUT_STATUS,
+				  &reg);
+		if (ret)
+			return ret;
+
+		if (reg & AXP20X_PWR_STATUS_BAT_CHARGING) {
+			val->intval =3D POWER_SUPPLY_STATUS_CHARGING;
+			return 0;
+		}
+
+		ret =3D iio_read_channel_processed(axp20x_batt->batt_dischrg_i,
+						 &val1);
+		if (ret)
+			return ret;
+
+		if (val1) {
+			val->intval =3D POWER_SUPPLY_STATUS_DISCHARGING;
+			return 0;
+		}
+
+		ret =3D regmap_read(axp20x_batt->regmap, AXP20X_FG_RES, &val1);
+		if (ret)
+			return ret;
+
+		/*
+		 * Fuel Gauge data takes 7 bits but the stored value seems to be
+		 * directly the raw percentage without any scaling to 7 bits.
+		 */
+		if ((val1 & AXP209_FG_PERCENT) =3D=3D 100)
+			val->intval =3D POWER_SUPPLY_STATUS_FULL;
+		else
+			val->intval =3D POWER_SUPPLY_STATUS_NOT_CHARGING;
+		break;
+
+	case POWER_SUPPLY_PROP_HEALTH:
+		ret =3D regmap_read(axp20x_batt->regmap, AXP20X_PWR_OP_MODE,
+				  &val1);
+		if (ret)
+			return ret;
+
+		if (val1 & AXP20X_PWR_OP_BATT_ACTIVATED) {
+			val->intval =3D POWER_SUPPLY_HEALTH_DEAD;
+			return 0;
+		}
+
+		val->intval =3D POWER_SUPPLY_HEALTH_GOOD;
+		break;
+
+	case POWER_SUPPLY_PROP_CONSTANT_CHARGE_CURRENT:
+		ret =3D axp20x_get_constant_charge_current(axp20x_batt,
+							 &val->intval);
+		if (ret)
+			return ret;
+		break;
+
+	case POWER_SUPPLY_PROP_CONSTANT_CHARGE_CURRENT_MAX:
+		val->intval =3D AXP20X_CHRG_CTRL1_TGT_CURR;
+		raw_to_constant_charge_current(axp20x_batt, &val->intval);
+
+		break;
+
+	case POWER_SUPPLY_PROP_CURRENT_NOW:
+		ret =3D regmap_read(axp20x_batt->regmap, AXP20X_PWR_INPUT_STATUS,
+				  &reg);
+		if (ret)
+			return ret;
+
+		if (reg & AXP20X_PWR_STATUS_BAT_CHARGING)
+			chan =3D axp20x_batt->batt_chrg_i;
+		else
+			chan =3D axp20x_batt->batt_dischrg_i;
+
+		ret =3D iio_read_channel_processed(chan, &val->intval);
+		if (ret)
+			return ret;
+
+		/* IIO framework gives mA but Power Supply framework gives uA */
+		val->intval *=3D 1000;
+		break;
+
+	case POWER_SUPPLY_PROP_CAPACITY:
+		/* When no battery is present, return capacity is 100% */
+		ret =3D regmap_read(axp20x_batt->regmap, AXP20X_PWR_OP_MODE,
+				  &reg);
+		if (ret)
+			return ret;
+
+		if (!(reg & AXP20X_PWR_OP_BATT_PRESENT)) {
+			val->intval =3D 100;
+			return 0;
+		}
+
+		ret =3D regmap_read(axp20x_batt->regmap, AXP20X_FG_RES, &reg);
+		if (ret)
+			return ret;
+
+		if (axp20x_batt->axp_id =3D=3D AXP221_ID &&
+		    !(reg & AXP22X_FG_VALID))
+			return -EINVAL;
+
+		/*
+		 * Fuel Gauge data takes 7 bits but the stored value seems to be
+		 * directly the raw percentage without any scaling to 7 bits.
+		 */
+		val->intval =3D reg & AXP209_FG_PERCENT;
+		break;
+
+	case POWER_SUPPLY_PROP_VOLTAGE_MAX_DESIGN:
+		if (axp20x_batt->axp_id =3D=3D AXP209_ID)
+			return axp20x_battery_get_max_voltage(axp20x_batt,
+							      &val->intval);
+		return axp22x_battery_get_max_voltage(axp20x_batt,
+						      &val->intval);
+
+	case POWER_SUPPLY_PROP_VOLTAGE_MIN_DESIGN:
+		ret =3D regmap_read(axp20x_batt->regmap, AXP20X_V_OFF, &reg);
+		if (ret)
+			return ret;
+
+		val->intval =3D 2600000 + 100000 * (reg & AXP20X_V_OFF_MASK);
+		break;
+
+	case POWER_SUPPLY_PROP_VOLTAGE_NOW:
+		ret =3D iio_read_channel_processed(axp20x_batt->batt_v,
+						 &val->intval);
+		if (ret)
+			return ret;
+
+		/* IIO framework gives mV but Power Supply framework gives uV */
+		val->intval *=3D 1000;
+		break;
+
+	default:
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static int axp20x_battery_set_max_voltage(struct axp20x_batt_ps *axp20x_ba=
tt,
+					  int val)
+{
+	switch (val) {
+	case 4100000:
+		val =3D AXP20X_CHRG_CTRL1_TGT_4_1V;
+		break;
+
+	case 4150000:
+		if (axp20x_batt->axp_id =3D=3D AXP221_ID)
+			return -EINVAL;
+
+		val =3D AXP20X_CHRG_CTRL1_TGT_4_15V;
+		break;
+
+	case 4200000:
+		val =3D AXP20X_CHRG_CTRL1_TGT_4_2V;
+		break;
+
+	default:
+		/*
+		 * AXP20x max voltage can be set to 4.36V and AXP22X max voltage
+		 * can be set to 4.22V and 4.24V, but these voltages are too
+		 * high for Lithium based batteries (AXP PMICs are supposed to
+		 * be used with these kinds of battery).
+		 */
+		return -EINVAL;
+	}
+
+	return regmap_update_bits(axp20x_batt->regmap, AXP20X_CHRG_CTRL1,
+				  AXP20X_CHRG_CTRL1_TGT_VOLT, val);
+}
+
+static int axp20x_set_constant_charge_current(struct axp20x_batt_ps *axp_b=
att,
+					      int charge_current)
+{
+	if (axp_batt->axp_id =3D=3D AXP209_ID)
+		charge_current =3D (charge_current - 300000) / 100000;
+	else
+		charge_current =3D (charge_current - 300000) / 150000;
+
+	if (charge_current > AXP20X_CHRG_CTRL1_TGT_CURR || charge_current < 0)
+		return -EINVAL;
+
+	return regmap_update_bits(axp_batt->regmap, AXP20X_CHRG_CTRL1,
+				  AXP20X_CHRG_CTRL1_TGT_CURR, charge_current);
+}
+
+static int axp20x_set_voltage_min_design(struct axp20x_batt_ps *axp_batt,
+					 int min_voltage)
+{
+	int val1 =3D (min_voltage - 2600000) / 100000;
+
+	if (val1 < 0 || val1 > AXP20X_V_OFF_MASK)
+		return -EINVAL;
+
+	return regmap_update_bits(axp_batt->regmap, AXP20X_V_OFF,
+				  AXP20X_V_OFF_MASK, val1);
+}
+
+static int axp20x_battery_set_prop(struct power_supply *psy,
+				   enum power_supply_property psp,
+				   const union power_supply_propval *val)
+{
+	struct axp20x_batt_ps *axp20x_batt =3D power_supply_get_drvdata(psy);
+
+	switch (psp) {
+	case POWER_SUPPLY_PROP_VOLTAGE_MIN_DESIGN:
+		return axp20x_set_voltage_min_design(axp20x_batt, val->intval);
+
+	case POWER_SUPPLY_PROP_VOLTAGE_MAX_DESIGN:
+		return axp20x_battery_set_max_voltage(axp20x_batt, val->intval);
+
+	case POWER_SUPPLY_PROP_CONSTANT_CHARGE_CURRENT:
+		return axp20x_set_constant_charge_current(axp20x_batt,
+							  val->intval);
+
+	default:
+		return -EINVAL;
+	}
+}
+
+static enum power_supply_property axp20x_battery_props[] =3D {
+	POWER_SUPPLY_PROP_PRESENT,
+	POWER_SUPPLY_PROP_ONLINE,
+	POWER_SUPPLY_PROP_STATUS,
+	POWER_SUPPLY_PROP_VOLTAGE_NOW,
+	POWER_SUPPLY_PROP_CURRENT_NOW,
+	POWER_SUPPLY_PROP_CONSTANT_CHARGE_CURRENT,
+	POWER_SUPPLY_PROP_CONSTANT_CHARGE_CURRENT_MAX,
+	POWER_SUPPLY_PROP_HEALTH,
+	POWER_SUPPLY_PROP_VOLTAGE_MAX_DESIGN,
+	POWER_SUPPLY_PROP_VOLTAGE_MIN_DESIGN,
+	POWER_SUPPLY_PROP_CAPACITY,
+};
+
+static int axp20x_battery_prop_writeable(struct power_supply *psy,
+					 enum power_supply_property psp)
+{
+	return psp =3D=3D POWER_SUPPLY_PROP_VOLTAGE_MIN_DESIGN ||
+	       psp =3D=3D POWER_SUPPLY_PROP_VOLTAGE_MAX_DESIGN ||
+	       psp =3D=3D POWER_SUPPLY_PROP_CONSTANT_CHARGE_CURRENT;
+}
+
+static const struct power_supply_desc axp20x_batt_ps_desc =3D {
+	.name =3D "axp20x-battery",
+	.type =3D POWER_SUPPLY_TYPE_BATTERY,
+	.properties =3D axp20x_battery_props,
+	.num_properties =3D ARRAY_SIZE(axp20x_battery_props),
+	.property_is_writeable =3D axp20x_battery_prop_writeable,
+	.get_property =3D axp20x_battery_get_prop,
+	.set_property =3D axp20x_battery_set_prop,
+};
+
+static const struct of_device_id axp20x_battery_ps_id[] =3D {
+	{
+		.compatible =3D "x-powers,axp209-battery-power-supply",
+		.data =3D (void *)AXP209_ID,
+	}, {
+		.compatible =3D "x-powers,axp221-battery-power-supply",
+		.data =3D (void *)AXP221_ID,
+	}, { /* sentinel */ },
+};
+MODULE_DEVICE_TABLE(of, axp20x_battery_ps_id);
+
+static int axp20x_power_probe(struct platform_device *pdev)
+{
+	struct axp20x_batt_ps *axp20x_batt;
+	struct power_supply_config psy_cfg =3D {};
+
+	if (!of_device_is_available(pdev->dev.of_node))
+		return -ENODEV;
+
+	axp20x_batt =3D devm_kzalloc(&pdev->dev, sizeof(*axp20x_batt),
+				   GFP_KERNEL);
+	if (!axp20x_batt)
+		return -ENOMEM;
+
+	axp20x_batt->dev =3D &pdev->dev;
+
+	axp20x_batt->batt_v =3D devm_iio_channel_get(&pdev->dev, "batt_v");
+	if (IS_ERR(axp20x_batt->batt_v)) {
+		if (PTR_ERR(axp20x_batt->batt_v) =3D=3D -ENODEV)
+			return -EPROBE_DEFER;
+		return PTR_ERR(axp20x_batt->batt_v);
+	}
+
+	axp20x_batt->batt_chrg_i =3D devm_iio_channel_get(&pdev->dev,
+							"batt_chrg_i");
+	if (IS_ERR(axp20x_batt->batt_chrg_i)) {
+		if (PTR_ERR(axp20x_batt->batt_chrg_i) =3D=3D -ENODEV)
+			return -EPROBE_DEFER;
+		return PTR_ERR(axp20x_batt->batt_chrg_i);
+	}
+
+	axp20x_batt->batt_dischrg_i =3D devm_iio_channel_get(&pdev->dev,
+							   "batt_dischrg_i");
+	if (IS_ERR(axp20x_batt->batt_dischrg_i)) {
+		if (PTR_ERR(axp20x_batt->batt_dischrg_i) =3D=3D -ENODEV)
+			return -EPROBE_DEFER;
+		return PTR_ERR(axp20x_batt->batt_dischrg_i);
+	}
+
+	axp20x_batt->regmap =3D dev_get_regmap(pdev->dev.parent, NULL);
+	platform_set_drvdata(pdev, axp20x_batt);
+
+	psy_cfg.drv_data =3D axp20x_batt;
+	psy_cfg.of_node =3D pdev->dev.of_node;
+
+	axp20x_batt->axp_id =3D (uintptr_t)of_device_get_match_data(&pdev->dev);
+
+	axp20x_batt->batt =3D devm_power_supply_register(&pdev->dev,
+						       &axp20x_batt_ps_desc,
+						       &psy_cfg);
+	if (IS_ERR(axp20x_batt->batt)) {
+		dev_err(&pdev->dev, "failed to register power supply: %ld\n",
+			PTR_ERR(axp20x_batt->batt));
+		return PTR_ERR(axp20x_batt->batt);
+	}
+
+	return 0;
+}
+
+static struct platform_driver axp20x_batt_driver =3D {
+	.probe    =3D axp20x_power_probe,
+	.driver   =3D {
+		.name  =3D "axp20x-battery-power-supply",
+		.of_match_table =3D axp20x_battery_ps_id,
+	},
+};
+
+module_platform_driver(axp20x_batt_driver);
+
+MODULE_DESCRIPTION("Battery power supply driver for AXP20X and AXP22X PMIC=
s");
+MODULE_AUTHOR("Quentin Schulz <quentin.schulz-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>");
+MODULE_LICENSE("GPL");
--=20
2.11.0

--=20
You received this message because you are subscribed to the Google Groups "=
linux-sunxi" group.
To unsubscribe from this group and stop receiving emails from it, send an e=
mail to linux-sunxi+unsubscribe-/JYPxA39Uh5TLH3MbocFF+G/Ez6ZCGd0@public.gmane.org
For more options, visit https://groups.google.com/d/optout.
