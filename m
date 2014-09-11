From: Doug Anderson <dianders@chromium.org>
Subject: [PATCH v3] PM / AVS: rockchip-io: add driver handling Rockchip io domains
Date: Thu, 11 Sep 2014 15:48:55 -0700
Message-ID: <1410475735-10278-1-git-send-email-dianders@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pd0-f177.google.com ([209.85.192.177]:33667 "EHLO
	mail-pd0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753461AbaIKWtS (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 11 Sep 2014 18:49:18 -0400
Received: by mail-pd0-f177.google.com with SMTP id y10so6455106pdj.36
        for <linux-pm@vger.kernel.org>; Thu, 11 Sep 2014 15:49:17 -0700 (PDT)
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Heiko Stuebner <heiko@sntech.de>, Kevin Hilman <khilman@linaro.org>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Nishanth Menon <nm@ti.com>, Linus Walleij <linus.walleij@linaro.org>, olof@lixom.net, Arnd Bergmann <arnd@arndb.de>, Mark Brown <broonie@kernel.org>, Addy Ke <addy.ke@rock-chips.com>, Sonny Rao <sonnyrao@chromium.org>, linux-arm-kernel@lists.infradead.org, Doug Anderson <dianders@chromium.org>, robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org, sre@kernel.org, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, dwmw2@infradead.org, grant.likely@linaro.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, linux-rockchip@lists.infradead.org

=46rom: Heiko St=C3=BCbner <heiko@sntech.de>

IO domain voltages on some Rockchip SoCs are variable but need to be
kept in sync between the regulators and the SoC using a special
register.

A specific example using rk3288:
- If the regulator hooked up to a pin like SDMMC0_VDD is 3.3V then
  bit 7 of GRF_IO_VSEL needs to be 0.  If the regulator hooked up to
  that same pin is 1.8V then bit 7 of GRF_IO_VSEL needs to be 1.

Said another way, this driver simply handles keeping bits in the SoC's
general register file (GRF) in sync with the actual value of a voltage
hooked up to the pins.

Note that this driver specifically doesn't include:
- any logic for deciding what voltage we should set regulators to
- any logic for deciding whether regulators (or internal SoC blocks)
  should have power or not have power

If there were some other software that had the smarts of making
decisions about regulators, it would work in conjunction with this
driver.  When that other software adjusted a regulator's voltage then
this driver would handle telling the SoC about it.  A good example is
vqmmc for SD.  In that case the dw_mmc driver simply is told about a
regulator.  It changes the regulator between 3.3V and 1.8V at the
right time.  This driver notices the change and makes sure that the
SoC is on the same page.

Signed-off-by: Heiko St=C3=BCbner <heiko@sntech.de>
Signed-off-by: Doug Anderson <dianders@chromium.org>
Reviewed-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
---
Changes in v3:
- Changed compatible string as per Santosh.
- Added code docs about the slop in 1.8V and 3.3V as per Santosh.
- Moved some #defines to the top as per Santosh.

Changes in v2:
- Regulator patch landed, so just io-domain patch now.
- Now in AVS as per Kevin Hilman.
- Updated commit message to make it clear why I think this driver
  doesn't fit into some other framework.
- Updated bindings to also include better description.

 .../bindings/power/rockchip-io-domain.txt          |  83 +++++
 drivers/power/avs/Kconfig                          |   8 +
 drivers/power/avs/Makefile                         |   1 +
 drivers/power/avs/rockchip-io-domain.c             | 351 +++++++++++++=
++++++++
 4 files changed, 443 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/power/rockchip-io=
-domain.txt
 create mode 100644 drivers/power/avs/rockchip-io-domain.c

diff --git a/Documentation/devicetree/bindings/power/rockchip-io-domain=
=2Etxt b/Documentation/devicetree/bindings/power/rockchip-io-domain.txt
new file mode 100644
index 0000000..6fbf6e7
--- /dev/null
+++ b/Documentation/devicetree/bindings/power/rockchip-io-domain.txt
@@ -0,0 +1,83 @@
+Rockchip SRAM for IO Voltage Domains:
+-------------------------------------
+
+IO domain voltages on some Rockchip SoCs are variable but need to be
+kept in sync between the regulators and the SoC using a special
+register.
+
+A specific example using rk3288:
+- If the regulator hooked up to a pin like SDMMC0_VDD is 3.3V then
+  bit 7 of GRF_IO_VSEL needs to be 0.  If the regulator hooked up to
+  that same pin is 1.8V then bit 7 of GRF_IO_VSEL needs to be 1.
+
+Said another way, this driver simply handles keeping bits in the SoC's
+general register file (GRF) in sync with the actual value of a voltage
+hooked up to the pins.
+
+Note that this driver specifically doesn't include:
+- any logic for deciding what voltage we should set regulators to
+- any logic for deciding whether regulators (or internal SoC blocks)
+  should have power or not have power
+
+If there were some other software that had the smarts of making
+decisions about regulators, it would work in conjunction with this
+driver.  When that other software adjusted a regulator's voltage then
+this driver would handle telling the SoC about it.  A good example is
+vqmmc for SD.  In that case the dw_mmc driver simply is told about a
+regulator.  It changes the regulator between 3.3V and 1.8V at the
+right time.  This driver notices the change and makes sure that the
+SoC is on the same page.
+
+
+Required properties:
+- compatible: should be one of:
+  - "rockchip,rk3188-io-voltage-domain" for rk3188
+  - "rockchip,rk3288-io-voltage-domain" for rk3288
+- rockchip,grf: phandle to the syscon managing the "general register f=
iles"
+
+
+You specify supplies using the standard regulator bindings by includin=
g
+a phandle the the relevant regulator.  All specified supplies must be =
able
+to report their voltage.  The IO Voltage Domain for any non-specified
+supplies will be not be touched.
+
+Possible supplies for rk3188:
+- ap0-supply:    The supply connected to AP0_VCC.
+- ap1-supply:    The supply connected to AP1_VCC.
+- cif-supply:    The supply connected to CIF_VCC.
+- flash-supply:  The supply connected to FLASH_VCC.
+- lcdc0-supply:  The supply connected to LCD0_VCC.
+- lcdc1-supply:  The supply connected to LCD1_VCC.
+- vccio0-supply: The supply connected to VCCIO0.
+- vccio1-supply: The supply connected to VCCIO1.
+                 Sometimes also labeled VCCIO1 and VCCIO2.
+
+Possible supplies for rk3288:
+- audio-supply:  The supply connected to APIO4_VDD.
+- bb-supply:     The supply connected to APIO5_VDD.
+- dvp-supply:    The supply connected to DVPIO_VDD.
+- flash0-supply: The supply connected to FLASH0_VDD.  Typically for eM=
MC
+- flash1-supply: The supply connected to FLASH1_VDD.  Also known as SD=
IO1.
+- gpio30-supply: The supply connected to APIO1_VDD.
+- gpio1830       The supply connected to APIO2_VDD.
+- lcdc-supply:   The supply connected to LCDC_VDD.
+- sdcard-supply: The supply connected to SDMMC0_VDD.
+- wifi-supply:   The supply connected to APIO3_VDD.  Also known as SDI=
O0.
+
+
+Example:
+
+	io-domains {
+		compatible =3D "rockchip,rk3288-io-voltage-domain";
+		rockchip,grf =3D <&grf>;
+
+		audio-supply =3D <&vcc18_codec>;
+		bb-supply =3D <&vcc33_io>;
+		dvp-supply =3D <&vcc_18>;
+		flash0-supply =3D <&vcc18_flashio>;
+		gpio1830-supply =3D <&vcc33_io>;
+		gpio30-supply =3D <&vcc33_pmuio>;
+		lcdc-supply =3D <&vcc33_lcd>;
+		sdcard-supply =3D <&vccio_sd>;
+		wifi-supply =3D <&vcc18_wl>;
+	};
diff --git a/drivers/power/avs/Kconfig b/drivers/power/avs/Kconfig
index 2a1008b..7f3d389 100644
--- a/drivers/power/avs/Kconfig
+++ b/drivers/power/avs/Kconfig
@@ -10,3 +10,11 @@ menuconfig POWER_AVS
 	  AVS is also called SmartReflex on OMAP devices.
=20
 	  Say Y here to enable Adaptive Voltage Scaling class support.
+
+config ROCKCHIP_IODOMAIN
+        tristate "Rockchip IO domain support"
+        depends on ARCH_ROCKCHIP && OF
+        help
+          Say y here to enable support io domains on Rockchip SoCs. It=
 is
+          necessary for the io domain setting of the SoC to match the
+          voltage supplied by the regulators.
diff --git a/drivers/power/avs/Makefile b/drivers/power/avs/Makefile
index 0843386..ba4c7bc 100644
--- a/drivers/power/avs/Makefile
+++ b/drivers/power/avs/Makefile
@@ -1 +1,2 @@
 obj-$(CONFIG_POWER_AVS_OMAP)		+=3D smartreflex.o
+obj-$(CONFIG_ROCKCHIP_IODOMAIN)		+=3D rockchip-io-domain.o
diff --git a/drivers/power/avs/rockchip-io-domain.c b/drivers/power/avs=
/rockchip-io-domain.c
new file mode 100644
index 0000000..aa0a483
--- /dev/null
+++ b/drivers/power/avs/rockchip-io-domain.c
@@ -0,0 +1,351 @@
+/*
+ * Rockchip IO Voltage Domain driver
+ *
+ * Copyright 2014 MundoReader S.L.
+ * Copyright 2014 Google, Inc.
+ *
+ * This software is licensed under the terms of the GNU General Public
+ * License version 2, as published by the Free Software Foundation, an=
d
+ * may be copied, distributed, and modified under those terms.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ */
+
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/err.h>
+#include <linux/mfd/syscon.h>
+#include <linux/of.h>
+#include <linux/platform_device.h>
+#include <linux/regmap.h>
+#include <linux/regulator/consumer.h>
+
+#define MAX_SUPPLIES		16
+
+/*
+ * The max voltage for 1.8V and 3.3V come from the Rockchip datasheet =
under
+ * "Recommended Operating Conditions" for "Digital GPIO".   When the t=
ypical
+ * is 3.3V the max is 3.6V.  When the typical is 1.8V the max is 1.98V=
=2E
+ *
+ * They are used like this:
+ * - If the voltage on a rail is above the "1.8" voltage (1.98V) we'll=
 tell the
+ *   SoC we're at 3.3.
+ * - If the voltage on a rail is above the "3.3" voltage (3.6V) we'll =
consider
+ *   that to be an error.
+ */
+#define MAX_VOLTAGE_1_8		1980000
+#define MAX_VOLTAGE_3_3		3600000
+
+#define RK3288_SOC_CON2			0x24c
+#define RK3288_SOC_CON2_FLASH0		BIT(7)
+#define RK3288_SOC_FLASH_SUPPLY_NUM	2
+
+struct rockchip_iodomain;
+
+/**
+ * @supplies: voltage settings matching the register bits.
+ */
+struct rockchip_iodomain_soc_data {
+	int grf_offset;
+	const char *supply_names[MAX_SUPPLIES];
+	void (*init)(struct rockchip_iodomain *iod);
+};
+
+struct rockchip_iodomain_supply {
+	struct rockchip_iodomain *iod;
+	struct regulator *reg;
+	struct notifier_block nb;
+	int idx;
+};
+
+struct rockchip_iodomain {
+	struct device *dev;
+	struct regmap *grf;
+	struct rockchip_iodomain_soc_data *soc_data;
+	struct rockchip_iodomain_supply supplies[MAX_SUPPLIES];
+};
+
+static int rockchip_iodomain_write(struct rockchip_iodomain_supply *su=
pply,
+				   int uV)
+{
+	struct rockchip_iodomain *iod =3D supply->iod;
+	u32 val;
+	int ret;
+
+	/* set value bit */
+	val =3D (uV > MAX_VOLTAGE_1_8) ? 0 : 1;
+	val <<=3D supply->idx;
+
+	/* apply hiword-mask */
+	val |=3D (BIT(supply->idx) << 16);
+
+	ret =3D regmap_write(iod->grf, iod->soc_data->grf_offset, val);
+	if (ret)
+		dev_err(iod->dev, "Couldn't write to GRF\n");
+
+	return ret;
+}
+
+static int rockchip_iodomain_notify(struct notifier_block *nb,
+				    unsigned long event,
+				    void *data)
+{
+	struct rockchip_iodomain_supply *supply =3D
+			container_of(nb, struct rockchip_iodomain_supply, nb);
+	int uV;
+	int ret;
+
+	/*
+	 * According to Rockchip it's important to keep the SoC IO domain
+	 * higher than (or equal to) the external voltage.  That means we nee=
d
+	 * to change it before external voltage changes happen in the case
+	 * of an increase.
+	 *
+	 * Note that in the "pre" change we pick the max possible voltage tha=
t
+	 * the regulator might end up at (the client requests a range and we
+	 * don't know for certain the exact voltage).  Right now we rely on t=
he
+	 * slop in MAX_VOLTAGE_1_8 and MAX_VOLTAGE_3_3 to save us if clients
+	 * request something like a max of 3.6V when they really want 3.3V.
+	 * We could attempt to come up with better rules if this fails.
+	 */
+	if (event & REGULATOR_EVENT_PRE_VOLTAGE_CHANGE) {
+		struct pre_voltage_change_data *pvc_data =3D data;
+
+		uV =3D max_t(unsigned long, pvc_data->old_uV, pvc_data->max_uV);
+	} else if (event & (REGULATOR_EVENT_VOLTAGE_CHANGE |
+			    REGULATOR_EVENT_ABORT_VOLTAGE_CHANGE)) {
+		uV =3D (unsigned long)data;
+	} else {
+		return NOTIFY_OK;
+	}
+
+	dev_dbg(supply->iod->dev, "Setting to %d\n", uV);
+
+	if (uV > MAX_VOLTAGE_3_3) {
+		dev_err(supply->iod->dev, "Voltage too high: %d\n", uV);
+
+		if (event =3D=3D REGULATOR_EVENT_PRE_VOLTAGE_CHANGE)
+			return NOTIFY_BAD;
+	}
+
+	ret =3D rockchip_iodomain_write(supply, uV);
+	if (ret && event =3D=3D REGULATOR_EVENT_PRE_VOLTAGE_CHANGE)
+		return NOTIFY_BAD;
+
+	dev_info(supply->iod->dev, "Setting to %d done\n", uV);
+	return NOTIFY_OK;
+}
+
+static void rk3288_iodomain_init(struct rockchip_iodomain *iod)
+{
+	int ret;
+	u32 val;
+
+	/* if no flash supply we should leave things alone */
+	if (!iod->supplies[RK3288_SOC_FLASH_SUPPLY_NUM].reg)
+		return;
+
+	/*
+	 * set flash0 iodomain to also use this framework
+	 * instead of a special gpio.
+	 */
+	val =3D RK3288_SOC_CON2_FLASH0 | (RK3288_SOC_CON2_FLASH0 << 16);
+	ret =3D regmap_write(iod->grf, RK3288_SOC_CON2, val);
+	if (ret < 0)
+		dev_warn(iod->dev, "couldn't update flash0 ctrl\n");
+}
+
+/*
+ * On the rk3188 the io-domains are handled by a shared register with =
the
+ * lower 8 bits being still being continuing drive-strength settings.
+ */
+static const struct rockchip_iodomain_soc_data soc_data_rk3188 =3D {
+	.grf_offset =3D 0x104,
+	.supply_names =3D {
+		NULL,
+		NULL,
+		NULL,
+		NULL,
+		NULL,
+		NULL,
+		NULL,
+		NULL,
+		"ap0",
+		"ap1",
+		"cif",
+		"flash",
+		"vccio0",
+		"vccio1",
+		"lcdc0",
+		"lcdc1",
+	},
+};
+
+static const struct rockchip_iodomain_soc_data soc_data_rk3288 =3D {
+	.grf_offset =3D 0x380,
+	.supply_names =3D {
+		"lcdc",		/* LCDC_VDD */
+		"dvp",		/* DVPIO_VDD */
+		"flash0",	/* FLASH0_VDD (emmc) */
+		"flash1",	/* FLASH1_VDD (sdio1) */
+		"wifi",		/* APIO3_VDD  (sdio0) */
+		"bb",		/* APIO5_VDD */
+		"audio",	/* APIO4_VDD */
+		"sdcard",	/* SDMMC0_VDD (sdmmc) */
+		"gpio30",	/* APIO1_VDD */
+		"gpio1830",	/* APIO2_VDD */
+	},
+	.init =3D rk3288_iodomain_init,
+};
+
+static const struct of_device_id rockchip_iodomain_match[] =3D {
+	{
+		.compatible =3D "rockchip,rk3188-io-voltage-domain",
+		.data =3D (void *)&soc_data_rk3188
+	},
+	{
+		.compatible =3D "rockchip,rk3288-io-voltage-domain",
+		.data =3D (void *)&soc_data_rk3288
+	},
+	{ /* sentinel */ },
+};
+
+static int rockchip_iodomain_probe(struct platform_device *pdev)
+{
+	struct device_node *np =3D pdev->dev.of_node;
+	const struct of_device_id *match;
+	struct rockchip_iodomain *iod;
+	int i, ret;
+
+	if (!np)
+		return -ENODEV;
+
+	iod =3D devm_kzalloc(&pdev->dev, sizeof(*iod), GFP_KERNEL);
+	if (!iod)
+		return -ENOMEM;
+
+	iod->dev =3D &pdev->dev;
+	platform_set_drvdata(pdev, iod);
+
+	match =3D of_match_node(rockchip_iodomain_match, np);
+	iod->soc_data =3D (struct rockchip_iodomain_soc_data *)match->data;
+
+	iod->grf =3D syscon_regmap_lookup_by_phandle(np, "rockchip,grf");
+	if (IS_ERR(iod->grf)) {
+		dev_err(&pdev->dev, "couldn't find grf regmap\n");
+		return PTR_ERR(iod->grf);
+	}
+
+	for (i =3D 0; i < MAX_SUPPLIES; i++) {
+		const char *supply_name =3D iod->soc_data->supply_names[i];
+		struct rockchip_iodomain_supply *supply =3D &iod->supplies[i];
+		struct regulator *reg;
+		int uV;
+
+		if (!supply_name)
+			continue;
+
+		reg =3D devm_regulator_get_optional(iod->dev, supply_name);
+		if (IS_ERR(reg)) {
+			ret =3D PTR_ERR(reg);
+
+			/* If a supply wasn't specified, that's OK */
+			if (ret =3D=3D -ENODEV)
+				continue;
+			else if (ret !=3D -EPROBE_DEFER)
+				dev_err(iod->dev, "couldn't get regulator %s\n",
+					supply_name);
+			goto unreg_notify;
+		}
+
+		/* set initial correct value */
+		uV =3D regulator_get_voltage(reg);
+
+		/* must be a regulator we can get the voltage of */
+		if (uV < 0) {
+			dev_err(iod->dev, "Can't determine voltage: %s\n",
+				supply_name);
+			goto unreg_notify;
+		}
+
+		if (uV > MAX_VOLTAGE_3_3) {
+			dev_crit(iod->dev,
+				 "%d uV is too high. May damage SoC!\n",
+				 uV);
+			ret =3D -EINVAL;
+			goto unreg_notify;
+		}
+
+		/* setup our supply */
+		supply->idx =3D i;
+		supply->iod =3D iod;
+		supply->reg =3D reg;
+		supply->nb.notifier_call =3D rockchip_iodomain_notify;
+
+		ret =3D rockchip_iodomain_write(supply, uV);
+		if (ret) {
+			supply->reg =3D NULL;
+			goto unreg_notify;
+		}
+
+		/* register regulator notifier */
+		ret =3D regulator_register_notifier(reg, &supply->nb);
+		if (ret) {
+			dev_err(&pdev->dev,
+				"regulator notifier request failed\n");
+			supply->reg =3D NULL;
+			goto unreg_notify;
+		}
+	}
+
+	if (iod->soc_data->init)
+		iod->soc_data->init(iod);
+
+	return 0;
+
+unreg_notify:
+	for (i =3D MAX_SUPPLIES - 1; i >=3D 0; i--) {
+		struct rockchip_iodomain_supply *io_supply =3D &iod->supplies[i];
+
+		if (io_supply->reg)
+			regulator_unregister_notifier(io_supply->reg,
+						      &io_supply->nb);
+	}
+
+	return ret;
+}
+
+static int rockchip_iodomain_remove(struct platform_device *pdev)
+{
+	struct rockchip_iodomain *iod =3D platform_get_drvdata(pdev);
+	int i;
+
+	for (i =3D MAX_SUPPLIES - 1; i >=3D 0; i--) {
+		struct rockchip_iodomain_supply *io_supply =3D &iod->supplies[i];
+
+		if (io_supply->reg)
+			regulator_unregister_notifier(io_supply->reg,
+						      &io_supply->nb);
+	}
+
+	return 0;
+}
+
+static struct platform_driver rockchip_iodomain_driver =3D {
+	.probe   =3D rockchip_iodomain_probe,
+	.remove  =3D rockchip_iodomain_remove,
+	.driver  =3D {
+		.name  =3D "rockchip-iodomain",
+		.of_match_table =3D rockchip_iodomain_match,
+	},
+};
+
+module_platform_driver(rockchip_iodomain_driver);
+
+MODULE_DESCRIPTION("Rockchip IO-domain driver");
+MODULE_AUTHOR("Heiko Stuebner <heiko@sntech.de>");
+MODULE_AUTHOR("Doug Anderson <dianders@chromium.org>");
+MODULE_LICENSE("GPL v2");
--=20
2.1.0.rc2.206.gedb03e5

