From: Icenowy Zheng <icenowy-ymACFijhrKM@public.gmane.org>
Subject: Re: [PATCH 2/4] power: add axp20x-battery driver
Date: Tue, 05 Jul 2016 16:33:31 +0800
Message-ID: <4101467707611@web7h.yandex.ru>
References: <20160701092926.32005-1-icenowy@aosc.xyz>
	 <20160701092926.32005-2-icenowy@aosc.xyz> <577B44FD.6040404@mailbox.org>
Reply-To: icenowy-ymACFijhrKM@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-sunxi+bncBCZLPFN5Q4OBBYXB5W5QKGQEZQAK2UQ-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
In-Reply-To: <577B44FD.6040404-cl+VPiYnx/1AfugRpC6u6w@public.gmane.org>
List-Post: <https://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <https://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <https://groups.google.com/group/linux-sunxi
List-Subscribe: <https://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <https://groups.google.com/group/linux-sunxi/subscribe>
To: Michael Haas <michael.haas-cl+VPiYnx/1AfugRpC6u6w@public.gmane.org>, "wens-jdAy2FN1RRM@public.gmane.org" <wens-jdAy2FN1RRM@public.gmane.org>, "maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org" <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, "sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org" <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, "dbaryshkov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" <dbaryshkov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org" <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>
Cc: "robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org" <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, "mark.rutland-5wv7dgnIgG8@public.gmane.org" <mark.rutland-5wv7dgnIgG8@public.gmane.org>, "linux-I+IVW8TIWO2tmTQ+vhA3Yw@public.gmane.org" <linux-I+IVW8TIWO2tmTQ+vhA3Yw@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org" <linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Id: linux-pm@vger.kernel.org



05.07.2016, 13:26, "Michael Haas" <michael.haas-cl+VPiYnx/1AfugRpC6u6w@public.gmane.org>:
> Hi,
>
> nice work! Is this in any way related to Bruno Pr=C3=A9monts driver for t=
he
> axp20x?
>
> I've got a reworked version of that lying around, but it's not quite
> ready for submission. Do you know what pieces are missing in your driver
> for axp20x support - as opposed to axp22x, which is already working?
>
> Michael
>
> On 01.07.2016 11:29, Icenowy Zheng wrote:
>> =C2=A0This driver is the battery power supply driver of axp20x PMIC. Cur=
rently
>> =C2=A0it supports only AXP22x variants.
>>
>> =C2=A0Signed-off-by: Icenowy Zheng <icenowy-ymACFijhrKM@public.gmane.org>
>> =C2=A0---
>> =C2=A0=C2=A0=C2=A0drivers/mfd/axp20x.c | 14 +++
>> =C2=A0=C2=A0=C2=A0drivers/power/Makefile | 1 +
>> =C2=A0=C2=A0=C2=A0drivers/power/axp20x_battery.c | 254 +++++++++++++++++=
++++++++++++++++++++++++
>> =C2=A0=C2=A0=C2=A03 files changed, 269 insertions(+)
>> =C2=A0=C2=A0=C2=A0create mode 100644 drivers/power/axp20x_battery.c
>>
>> =C2=A0diff --git a/drivers/mfd/axp20x.c b/drivers/mfd/axp20x.c
>> =C2=A0index cee5288..064e5015 100644
>> =C2=A0--- a/drivers/mfd/axp20x.c
>> =C2=A0+++ b/drivers/mfd/axp20x.c
>> =C2=A0@@ -166,6 +166,15 @@ static struct resource axp22x_usb_power_suppl=
y_resources[] =3D {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0DEFINE=
_RES_IRQ_NAMED(AXP22X_IRQ_VBUS_REMOVAL, "VBUS_REMOVAL"),
>> =C2=A0=C2=A0=C2=A0};
>>
>> =C2=A0+static struct resource axp22x_battery_resources[] =3D {
>> =C2=A0+ DEFINE_RES_IRQ_NAMED(AXP22X_IRQ_BATT_PLUGIN, "BATT_PLUGIN"),
>> =C2=A0+ DEFINE_RES_IRQ_NAMED(AXP22X_IRQ_BATT_REMOVAL, "BATT_REMOVAL"),
>> =C2=A0+ DEFINE_RES_IRQ_NAMED(AXP22X_IRQ_BATT_ENT_ACT_MODE, "BATT_ENT_ACT=
_MODE"),
>> =C2=A0+ DEFINE_RES_IRQ_NAMED(AXP22X_IRQ_BATT_EXIT_ACT_MODE, "BATT_EXIT_A=
CT_MODE"),
>> =C2=A0+ DEFINE_RES_IRQ_NAMED(AXP22X_IRQ_CHARG, "CHARG"),
>> =C2=A0+ DEFINE_RES_IRQ_NAMED(AXP22X_IRQ_CHARG_DONE, "CHARG_DONE"),
>> =C2=A0+};
>> =C2=A0+
>> =C2=A0=C2=A0=C2=A0static struct resource axp22x_pek_resources[] =3D {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0{
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0.name =3D "PEK_DBR",
>> =C2=A0@@ -538,6 +547,11 @@ static struct mfd_cell axp22x_cells[] =3D {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0.of_compatible =3D "x-powers,axp2=
02-usb-power-supply",
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0.num_resources =3D ARRAY_SIZE(axp=
22x_usb_power_supply_resources),
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0.resources =3D axp22x_usb_power_s=
upply_resources,
>> =C2=A0+ }, {
>> =C2=A0+ .name =3D "axp20x-battery",
>> =C2=A0+ .of_compatible =3D "x-powers,axp202-battery",
>> =C2=A0+ .num_resources =3D ARRAY_SIZE(axp22x_battery_resources),
>> =C2=A0+ .resources =3D axp22x_battery_resources,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0},
>> =C2=A0=C2=A0=C2=A0};
>>
>> =C2=A0diff --git a/drivers/power/Makefile b/drivers/power/Makefile
>> =C2=A0index e46b75d..1452d23 100644
>> =C2=A0--- a/drivers/power/Makefile
>> =C2=A0+++ b/drivers/power/Makefile
>> =C2=A0@@ -10,6 +10,7 @@ obj-$(CONFIG_GENERIC_ADC_BATTERY) +=3D generic-a=
dc-battery.o
>> =C2=A0=C2=A0=C2=A0obj-$(CONFIG_PDA_POWER) +=3D pda_power.o
>> =C2=A0=C2=A0=C2=A0obj-$(CONFIG_APM_POWER) +=3D apm_power.o
>> =C2=A0=C2=A0=C2=A0obj-$(CONFIG_AXP20X_POWER) +=3D axp20x_usb_power.o
>> =C2=A0+obj-$(CONFIG_AXP20X_POWER) +=3D axp20x_battery.o
>> =C2=A0=C2=A0=C2=A0obj-$(CONFIG_MAX8925_POWER) +=3D max8925_power.o
>> =C2=A0=C2=A0=C2=A0obj-$(CONFIG_WM831X_BACKUP) +=3D wm831x_backup.o
>> =C2=A0=C2=A0=C2=A0obj-$(CONFIG_WM831X_POWER) +=3D wm831x_power.o
>> =C2=A0diff --git a/drivers/power/axp20x_battery.c b/drivers/power/axp20x=
_battery.c
>> =C2=A0new file mode 100644
>> =C2=A0index 0000000..8fac2cd
>> =C2=A0--- /dev/null
>> =C2=A0+++ b/drivers/power/axp20x_battery.c
>> =C2=A0@@ -0,0 +1,254 @@
>> =C2=A0+/*
>> =C2=A0+ * AXP20x PMIC battery status driver
>> =C2=A0+ *
>> =C2=A0+ * Copyright (C) 2016 Icenowy Zheng <icenowy-ymACFijhrKM@public.gmane.org>
>> =C2=A0+ * Copyright (C) 2015 Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
>> =C2=A0+ * Copyright (C) 2014 Bruno Pr=C3=A9mont <bonbons@linux-vserver.o=
rg>
>> =C2=A0+ *
>> =C2=A0+ * This program is free software; you can redistribute it and/or =
modify it
>> =C2=A0+ * under the terms of the GNU General Public License as published=
 by the
>> =C2=A0+ * Free Software Foundation; either version 2 of the License, or =
(at your
>> =C2=A0+ * option) any later version.
>> =C2=A0+ */
>> =C2=A0+
>> =C2=A0+#include <linux/device.h>
>> =C2=A0+#include <linux/init.h>
>> =C2=A0+#include <linux/interrupt.h>
>> =C2=A0+#include <linux/kernel.h>
>> =C2=A0+#include <linux/mfd/axp20x.h>
>> =C2=A0+#include <linux/module.h>
>> =C2=A0+#include <linux/of.h>
>> =C2=A0+#include <linux/platform_device.h>
>> =C2=A0+#include <linux/power_supply.h>
>> =C2=A0+#include <linux/regmap.h>
>> =C2=A0+#include <linux/slab.h>
>> =C2=A0+
>> =C2=A0+#define DRVNAME "axp20x-battery"
>> =C2=A0+
>> =C2=A0+#define AXP20X_PWR_STATUS_ACIN_USED BIT(6)
>> =C2=A0+#define AXP20X_PWR_STATUS_VBUS_USED BIT(4)
>> =C2=A0+#define AXP20X_PWR_STATUS_BAT_DIRECTION BIT(2)
>> =C2=A0+
>> =C2=A0+#define AXP20X_OP_MODE_CHARGING BIT(6)
>> =C2=A0+#define AXP20X_OP_MODE_BATTERY_PRESENT BIT(5)
>> =C2=A0+#define AXP20X_OP_MODE_BATTERY_ACTIVE BIT(3)
>> =C2=A0+
>> =C2=A0+#define AXP20X_CAPACITY_CORRECT BIT(7)
>> =C2=A0+
>> =C2=A0+struct axp20x_battery {
>> =C2=A0+ struct axp20x_dev *axp20x;
>> =C2=A0+ struct regmap *regmap;
>> =C2=A0+ struct power_supply *supply;
>> =C2=A0+};
>> =C2=A0+
>> =C2=A0+static irqreturn_t axp20x_battery_irq(int irq, void *devid)
>> =C2=A0+{
>> =C2=A0+ struct axp20x_battery *power =3D devid;
>> =C2=A0+
>> =C2=A0+ power_supply_changed(power->supply);
>> =C2=A0+
>> =C2=A0+ return IRQ_HANDLED;
>> =C2=A0+}
>> =C2=A0+
>> =C2=A0+static int axp20x_battery_get_property(struct power_supply *psy,
>> =C2=A0+ enum power_supply_property psp, union power_supply_propval *val)
>> =C2=A0+{
>> =C2=A0+ struct axp20x_battery *power =3D power_supply_get_drvdata(psy);
>> =C2=A0+ unsigned int input, op_mode, capacity, dh, dl;
>> =C2=A0+ int ret, ext;
>> =C2=A0+
>> =C2=A0+ /* All the properties below need the input-status reg value */
>> =C2=A0+ ret =3D regmap_read(power->regmap, AXP20X_PWR_INPUT_STATUS, &inp=
ut);
>> =C2=A0+ if (ret)
>> =C2=A0+ return ret;
>> =C2=A0+
>> =C2=A0+ ret =3D regmap_read(power->regmap, AXP20X_PWR_OP_MODE, &op_mode)=
;
>> =C2=A0+ if (ret)
>> =C2=A0+ return ret;
>> =C2=A0+
>> =C2=A0+ switch (psp) {
>> =C2=A0+ case POWER_SUPPLY_PROP_HEALTH:
>> =C2=A0+ if (!(op_mode & AXP20X_OP_MODE_BATTERY_PRESENT)) {
>> =C2=A0+ val->intval =3D POWER_SUPPLY_HEALTH_UNKNOWN;
>> =C2=A0+ break;
>> =C2=A0+ }
>> =C2=A0+
>> =C2=A0+ val->intval =3D POWER_SUPPLY_HEALTH_GOOD;
>> =C2=A0+
>> =C2=A0+ if (op_mode & AXP20X_OP_MODE_BATTERY_ACTIVE) {
>> =C2=A0+ /* AXP20X is now trying to re-activate the battery */
>> =C2=A0+ val->intval =3D POWER_SUPPLY_HEALTH_DEAD;
>> =C2=A0+ break;
>> =C2=A0+ }
>> =C2=A0+ break;
>> =C2=A0+ case POWER_SUPPLY_PROP_PRESENT:
>> =C2=A0+ val->intval =3D !!(op_mode & AXP20X_OP_MODE_BATTERY_PRESENT);
>> =C2=A0+ break;
>> =C2=A0+ case POWER_SUPPLY_PROP_CAPACITY:
>> =C2=A0+ ret =3D regmap_read(power->regmap, AXP20X_FG_RES, &capacity);
>> =C2=A0+ if (ret)
>> =C2=A0+ return ret;
>> =C2=A0+ if (capacity & AXP20X_CAPACITY_CORRECT)
>> =C2=A0+ val->intval =3D capacity & (~AXP20X_CAPACITY_CORRECT);
>> =C2=A0+ else
>> =C2=A0+ return -EIO;
>> =C2=A0+ /* from axp_capchange function of Allwinner 3.4 driver */
>> =C2=A0+ if (val->intval =3D=3D 127)
>> =C2=A0+ val->intval =3D 100;
>> =C2=A0+ break;
>> =C2=A0+ case POWER_SUPPLY_PROP_STATUS:
>> =C2=A0+ if (!(op_mode & AXP20X_OP_MODE_BATTERY_PRESENT)) {
>> =C2=A0+ val->intval =3D POWER_SUPPLY_STATUS_UNKNOWN;
>> =C2=A0+ break;
>> =C2=A0+ }
>> =C2=A0+
>> =C2=A0+ ret =3D regmap_read(power->regmap, AXP20X_FG_RES, &capacity);
>> =C2=A0+ if (ret)
>> =C2=A0+ return ret;
>> =C2=A0+
>> =C2=A0+ ext =3D (input & AXP20X_PWR_STATUS_ACIN_USED) ||
>> =C2=A0+ (input & AXP20X_PWR_STATUS_VBUS_USED);
>> =C2=A0+
>> =C2=A0+ if (op_mode & AXP20X_OP_MODE_CHARGING)
>> =C2=A0+ val->intval =3D POWER_SUPPLY_STATUS_CHARGING;
>> =C2=A0+ else if (!(input & AXP20X_PWR_STATUS_BAT_DIRECTION) && !ext)
>> =C2=A0+ val->intval =3D POWER_SUPPLY_STATUS_DISCHARGING;
>> =C2=A0+ else if (capacity =3D=3D (100 | AXP20X_CAPACITY_CORRECT) ||
>> =C2=A0+ capacity =3D=3D (127 | AXP20X_CAPACITY_CORRECT))
>> =C2=A0+ val->intval =3D POWER_SUPPLY_STATUS_FULL;
>> =C2=A0+ else
>> =C2=A0+ val->intval =3D POWER_SUPPLY_STATUS_NOT_CHARGING;
>> =C2=A0+ break;
>> =C2=A0+ case POWER_SUPPLY_PROP_CURRENT_NOW:
>> =C2=A0+ ret =3D regmap_read(power->regmap, AXP20X_BATT_DISCHRG_I_H, &dh)=
;
>> =C2=A0+ if (ret)
>> =C2=A0+ return ret;
>> =C2=A0+ ret =3D regmap_read(power->regmap, AXP20X_BATT_DISCHRG_I_L, &dl)=
;
>> =C2=A0+ if (ret)
>> =C2=A0+ return ret;
>> =C2=A0+ /* it's a 12 bit integer, high 8-bit is stored in dh */
>> =C2=A0+ val->intval =3D dh << 4 | dl >> 4;
>> =C2=A0+ break;
>> =C2=A0+ case POWER_SUPPLY_PROP_VOLTAGE_NOW:
>> =C2=A0+ ret =3D regmap_read(power->regmap, AXP20X_BATT_V_H, &dh);
>> =C2=A0+ if (ret)
>> =C2=A0+ return ret;
>> =C2=A0+ ret =3D regmap_read(power->regmap, AXP20X_BATT_V_L, &dl);
>> =C2=A0+ if (ret)
>> =C2=A0+ return ret;
>> =C2=A0+ /* it's a 12 bit integer, high 8-bit is stored in dh */
>> =C2=A0+ val->intval =3D dh << 4 | dl >> 4;
>> =C2=A0+ /* The formula below is from axp22_vbat_to_mV function
>> =C2=A0+ * of Allwinner 3.4 kernel.
>> =C2=A0+ */
>> =C2=A0+ val->intval =3D val->intval * 1100 / 1000;
>> =C2=A0+ break;
>> =C2=A0+ default:
>> =C2=A0+ return -EINVAL;
>> =C2=A0+ }
>> =C2=A0+
>> =C2=A0+ return 0;
>> =C2=A0+}
>> =C2=A0+
>> =C2=A0+static enum power_supply_property axp22x_battery_properties[] =3D=
 {
>> =C2=A0+ POWER_SUPPLY_PROP_CAPACITY,
>> =C2=A0+ POWER_SUPPLY_PROP_HEALTH,
>> =C2=A0+ POWER_SUPPLY_PROP_PRESENT,
>> =C2=A0+ POWER_SUPPLY_PROP_STATUS,
>> =C2=A0+ POWER_SUPPLY_PROP_CURRENT_NOW,
>> =C2=A0+ POWER_SUPPLY_PROP_VOLTAGE_NOW,
>> =C2=A0+};
>> =C2=A0+
>> =C2=A0+static const struct power_supply_desc axp22x_battery_desc =3D {
>> =C2=A0+ .name =3D "axp20x-battery",
>> =C2=A0+ .type =3D POWER_SUPPLY_TYPE_BATTERY,
>> =C2=A0+ .properties =3D axp22x_battery_properties,
>> =C2=A0+ .num_properties =3D ARRAY_SIZE(axp22x_battery_properties),
>> =C2=A0+ .get_property =3D axp20x_battery_get_property,
>> =C2=A0+};
>> =C2=A0+
>> =C2=A0+static int axp20x_battery_probe(struct platform_device *pdev)
>> =C2=A0+{
>> =C2=A0+ struct axp20x_dev *axp20x =3D dev_get_drvdata(pdev->dev.parent);
>> =C2=A0+ struct power_supply_config psy_cfg =3D {};
>> =C2=A0+ struct axp20x_battery *power;
>> =C2=A0+ static const char * const axp22x_irq_names[] =3D {
>> =C2=A0+ "BATT_PLUGIN", "BATT_REMOVAL", "BATT_ENT_ACT_MODE",
>> =C2=A0+ "BATT_EXIT_ACT_MODE", "CHARG", "CHARG_DONE", NULL };
>> =C2=A0+ static const char * const *irq_names;
>> =C2=A0+ const struct power_supply_desc *battery_desc;
>> =C2=A0+ int i, irq, ret;
>> =C2=A0+
>> =C2=A0+ if (!of_device_is_available(pdev->dev.of_node))
>> =C2=A0+ return -ENODEV;
>> =C2=A0+
>> =C2=A0+ if (!axp20x) {
>> =C2=A0+ dev_err(&pdev->dev, "Parent drvdata not set\n");
>> =C2=A0+ return -EINVAL;
>> =C2=A0+ }
>> =C2=A0+
>> =C2=A0+ power =3D devm_kzalloc(&pdev->dev, sizeof(*power), GFP_KERNEL);
>> =C2=A0+ if (!power)
>> =C2=A0+ return -ENOMEM;
>> =C2=A0+
>> =C2=A0+ power->axp20x =3D axp20x;
>> =C2=A0+ power->regmap =3D axp20x->regmap;
>> =C2=A0+
>> =C2=A0+ switch (power->axp20x->variant) {
>> =C2=A0+ case AXP221_ID:
>> =C2=A0+ case AXP223_ID:
>> =C2=A0+ battery_desc =3D &axp22x_battery_desc;
>> =C2=A0+ irq_names =3D axp22x_irq_names;
>> =C2=A0+ break;
>> =C2=A0+ default:
>> =C2=A0+ dev_err(&pdev->dev, "Unsupported AXP variant: %ld\n",
>> =C2=A0+ axp20x->variant);
>> =C2=A0+ return -EINVAL;
>> =C2=A0+ }
>> =C2=A0+
>> =C2=A0+ psy_cfg.of_node =3D pdev->dev.of_node;
>> =C2=A0+ psy_cfg.drv_data =3D power;
>> =C2=A0+
>> =C2=A0+ power->supply =3D devm_power_supply_register(&pdev->dev, battery=
_desc,
>> =C2=A0+ &psy_cfg);
>> =C2=A0+ if (IS_ERR(power->supply))
>> =C2=A0+ return PTR_ERR(power->supply);
>> =C2=A0+
>> =C2=A0+ /* Request irqs after registering, as irqs may trigger immediate=
ly */
>> =C2=A0+ for (i =3D 0; irq_names[i]; i++) {
>> =C2=A0+ irq =3D platform_get_irq_byname(pdev, irq_names[i]);
>> =C2=A0+ if (irq < 0) {
>> =C2=A0+ dev_warn(&pdev->dev, "No IRQ for %s: %d\n",
>> =C2=A0+ irq_names[i], irq);
>> =C2=A0+ continue;
>> =C2=A0+ }
>> =C2=A0+ irq =3D regmap_irq_get_virq(axp20x->regmap_irqc, irq);
>> =C2=A0+ ret =3D devm_request_any_context_irq(&pdev->dev, irq,
>> =C2=A0+ axp20x_battery_irq, 0, DRVNAME, power);
>> =C2=A0+ if (ret < 0)
>> =C2=A0+ dev_warn(&pdev->dev, "Error requesting %s IRQ: %d\n",
>> =C2=A0+ irq_names[i], ret);
>> =C2=A0+ }
>> =C2=A0+
>> =C2=A0+ return 0;
>> =C2=A0+}
>> =C2=A0+
>> =C2=A0+static const struct of_device_id axp20x_battery_match[] =3D {
>> =C2=A0+ { .compatible =3D "x-powers,axp202-battery" },
>> =C2=A0+ { }
>> =C2=A0+};
>> =C2=A0+MODULE_DEVICE_TABLE(of, axp20x_battery_match);
>> =C2=A0+
>> =C2=A0+static struct platform_driver axp20x_battery_driver =3D {
>> =C2=A0+ .probe =3D axp20x_battery_probe,
>> =C2=A0+ .driver =3D {
>> =C2=A0+ .name =3D DRVNAME,
>> =C2=A0+ .of_match_table =3D axp20x_battery_match,
>> =C2=A0+ },
>> =C2=A0+};
>> =C2=A0+
>> =C2=A0+module_platform_driver(axp20x_battery_driver);
>> =C2=A0+
>> =C2=A0+MODULE_AUTHOR("Icenowy Zheng <icenowy-ymACFijhrKM@public.gmane.org>");
>> =C2=A0+MODULE_DESCRIPTION("AXP20x PMIC battery status driver");
>> =C2=A0+MODULE_LICENSE("GPL");

Therotically, it can run on axp20x. However, I have currently no test devic=
e. (Still waiting for my C.H.I.P.)
So I can only promise it to run on axp22x.

--=20
You received this message because you are subscribed to the Google Groups "=
linux-sunxi" group.
To unsubscribe from this group and stop receiving emails from it, send an e=
mail to linux-sunxi+unsubscribe-/JYPxA39Uh5TLH3MbocFF+G/Ez6ZCGd0@public.gmane.org
For more options, visit https://groups.google.com/d/optout.
