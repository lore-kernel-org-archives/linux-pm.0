From: Jonghwa Lee <jonghwa3.lee@samsung.com>
Subject: =?UTF-8?q?=5BPATCH=203/3=5D=20power=3A=20of=5Fbattery=3A=20Initial=20support=20for=20of-based=20battery=20specification=20driver=2E?=
Date: Tue, 07 Oct 2014 19:58:38 +0900
Message-ID: <1412679518-21499-4-git-send-email-jonghwa3.lee@samsung.com>
References: <1412679518-21499-1-git-send-email-jonghwa3.lee@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <1412679518-21499-1-git-send-email-jonghwa3.lee@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: linux-pm@vger.kernel.org, sre@kernel.org, dbaryshkov@gmail.com, dwmw2@infradead.org, anton@enomsg.org, pavel@ucw.cz, jenny.tc@intel.com, Jonghwa Lee <jonghwa3.lee@samsung.com>
List-Id: linux-pm@vger.kernel.org

This driver supports battery specification through the generic interfac=
e of
power_supply subsystem. All data are parsed from device tree and it exa=
ctly
matches with power_supply_info's content.

Signed-off-by: Jonghwa Lee <jonghwa3.lee@samsung.com>
---
 .../bindings/power_supply/of_battery.txt           |   34 +++++++
 drivers/power/Kconfig                              |    7 ++
 drivers/power/Makefile                             |    1 +
 drivers/power/of_battery.c                         |  100 ++++++++++++=
++++++++
 4 files changed, 142 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/power_supply/of_b=
attery.txt
 create mode 100644 drivers/power/of_battery.c

diff --git a/Documentation/devicetree/bindings/power_supply/of_battery.=
txt b/Documentation/devicetree/bindings/power_supply/of_battery.txt
new file mode 100644
index 0000000..5ccd2a1
--- /dev/null
+++ b/Documentation/devicetree/bindings/power_supply/of_battery.txt
@@ -0,0 +1,34 @@
+of_battery bindings
+~~~~~~~~~~~~~~~~~~~
+
+This documentation describes how to define data in device tree
+to use of_battery driver. All properties are just matched with
+power_supply_info's.
+
+Required properties :
+ - battery-name : battery's name for identifying.
+
+Optional properties :
+ - voltage_max : Maximum voltage of the battery (uV).
+ - voltage_min : Minimum voltage of the battery (uV).
+ - charge_full : Full capacity of the battery (uAh).
+ - charge_empty : Empty capacity of the battery (uAh).
+ - energy_full : Full capacity of the battery (uWh).
+ - energy_empty : Empty capacity of the battery (uWh).
+ - temperature_max : Maximum temperature for the battery (deci 'C)
+ - temperature_min : Minium temperature for the battery (deci 'C)
+
+Example:
+	battery {
+		main-battery {
+			battery-name =3D "battery";
+			voltage-max =3D <4350000>;
+			charge-full =3D <2500000>;
+			temperature_max =3D <600>;
+			temperature_min =3D <(-100)>;
+		};
+		backup-battery {
+			battery-name =3D "coin-battery";
+			voltage-max =3D <3000000>;
+		};
+	};
diff --git a/drivers/power/Kconfig b/drivers/power/Kconfig
index 73cfcdf..c324ac6 100644
--- a/drivers/power/Kconfig
+++ b/drivers/power/Kconfig
@@ -36,6 +36,13 @@ config GENERIC_ADC_BATTERY
 	  Say Y here to enable support for the generic battery driver
 	  which uses IIO framework to read adc.
=20
+config BATTERY_OF
+	tristate "Generic of-based battery specification driver"
+	depends on OF
+	help
+	  Say Y here to enable support for the of-based generic battery
+	  specification driver which gives static battery data.
+
 config MAX8925_POWER
 	tristate "MAX8925 battery charger support"
 	depends on MFD_MAX8925
diff --git a/drivers/power/Makefile b/drivers/power/Makefile
index dfa8942..38a83aa 100644
--- a/drivers/power/Makefile
+++ b/drivers/power/Makefile
@@ -6,6 +6,7 @@ power_supply-$(CONFIG_LEDS_TRIGGERS)	+=3D power_supply_=
leds.o
=20
 obj-$(CONFIG_POWER_SUPPLY)	+=3D power_supply.o
 obj-$(CONFIG_GENERIC_ADC_BATTERY)	+=3D generic-adc-battery.o
+obj-$(CONFIG_BATTERY_OF)	+=3D of_battery.o
=20
 obj-$(CONFIG_PDA_POWER)		+=3D pda_power.o
 obj-$(CONFIG_APM_POWER)		+=3D apm_power.o
diff --git a/drivers/power/of_battery.c b/drivers/power/of_battery.c
new file mode 100644
index 0000000..3c66765
--- /dev/null
+++ b/drivers/power/of_battery.c
@@ -0,0 +1,100 @@
+/*
+ * OF-based battery specification driver
+ *
+ * This driver supports generic interface to get static battery data.
+ *
+ * Copyright =C2=A9 2014 Jonghwa Lee <jonghwa3.lee@samsung.com>
+ *
+ * This program is free software; you can redistribute it and/or modif=
y
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
+
+#include <linux/power_supply.h>
+#include <linux/module.h>
+#include <linux/slab.h>
+#include <linux/of.h>
+
+static struct power_supply_info *of_get_battery_info(struct device_nod=
e *np)
+{
+	struct power_supply_info *info;
+
+	info =3D kzalloc(sizeof(*info), GFP_KERNEL);
+	if (!info)
+		return ERR_PTR(-ENOMEM);
+
+	if (of_property_read_string(np, "battery-name", &info->name)) {
+		kfree(info);
+		return ERR_PTR(-EINVAL);
+	}
+
+	of_property_read_u32(np, "voltage_max", &info->voltage_max_design);
+	of_property_read_u32(np, "voltage_min", &info->voltage_min_design);
+	of_property_read_u32(np, "charge_full", &info->charge_full_design);
+	of_property_read_u32(np, "charge_empty", &info->charge_empty_design);
+	of_property_read_u32(np, "energy_full", &info->energy_full_design);
+	of_property_read_u32(np, "energy_empty", &info->energy_empty_design);
+	of_property_read_u32(np, "temperature_max", &info->temperature_max);
+	of_property_read_u32(np, "temperature_min", &info->temperature_min);
+
+	return info;
+}
+
+static int __init psy_of_battery_init(void)
+{
+	struct power_supply_info *info;
+	struct device_node *np, *child;
+	int ret;
+
+	np =3D of_find_node_by_name(NULL, "battery");
+	if (!np)
+		return -ENODEV;
+
+	for_each_child_of_node(np, child) {
+		info =3D of_get_battery_info(child);
+		if (IS_ERR(info)) {
+			pr_err("Failed to get battery information (%ld)\n",
+				PTR_ERR(info));
+			continue;
+		}
+		ret =3D psy_register_battery_info(info);
+		if (ret) {
+			pr_err("Failed to register battery information (%d)\n",
+				ret);
+			kfree(info);
+			continue;
+		}
+	}
+
+	return 0;
+}
+module_init(psy_of_battery_init);
+
+static void __exit psy_of_battery_exit(void)
+{
+	struct power_supply_info *info;
+	struct device_node *np, *child;
+	const char *name;
+
+	np =3D of_find_node_by_name(NULL, "battery");
+	if (!np)
+		return;
+
+	for_each_child_of_node(np, child) {
+		if (!of_property_read_string(np, "battery-name", &name))
+			continue;
+
+		info =3D psy_get_battery_info(name);
+		if (IS_ERR(info))
+			continue;
+
+		psy_unregister_battery_info(info);
+	}
+}
+module_exit(psy_of_battery_exit);
+
+MODULE_AUTHOR("Jonghwa Lee <jonhgwa3.lee@samsung.com>");
+MODULE_DESCRIPTION("of battery specification driver");
+MODULE_LICENSE("GPL");
--=20
1.7.9.5
