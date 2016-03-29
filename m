From: Wei Ni <wni@nvidia.com>
Subject: [PATCH V9 04/14] thermal: tegra: split tegra_soctherm driver
Date: Tue, 29 Mar 2016 17:16:57 +0800
Message-ID: <1459243017-25255-1-git-send-email-wni@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: edubezval@gmail.com, rui.zhang@intel.com, thierry.reding@gmail.com
Cc: MLongnecker@nvidia.com, swarren@wwwdotorg.org, mikko.perttunen@kapsi.fi, linux-tegra@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Wei Ni <wni@nvidia.com>
List-Id: linux-pm@vger.kernel.org

Split most of the Tegra124 data and code into a Tegra124-specific
file.
Split most of the fuse-related code into a fuse-related source file.
This is in preparation for adding a Tegra210-specific driver in a
future patch.

Beyond the maintainability improvements, this is intended to separate
chip-specific ATE and characterization-related hacks into chip-specific
files, in the hopes that they won't pollute code for other chips.

Signed-off-by: Wei Ni <wni@nvidia.com>
---
 drivers/thermal/tegra/Kconfig             |   2 +-
 drivers/thermal/tegra/Makefile            |   3 +
 drivers/thermal/tegra/soctherm-fuse.c     | 158 +++++++++
 drivers/thermal/tegra/soctherm.c          | 310 ++++++++++++++++
 drivers/thermal/tegra/soctherm.h          | 110 ++++++
 drivers/thermal/tegra/tegra-soctherm.c    | 565 ------------------------------
 drivers/thermal/tegra/tegra124-soctherm.c | 172 +++++++++
 7 files changed, 754 insertions(+), 566 deletions(-)
 create mode 100644 drivers/thermal/tegra/soctherm-fuse.c
 create mode 100644 drivers/thermal/tegra/soctherm.c
 create mode 100644 drivers/thermal/tegra/soctherm.h
 delete mode 100644 drivers/thermal/tegra/tegra-soctherm.c
 create mode 100644 drivers/thermal/tegra/tegra124-soctherm.c

diff --git a/drivers/thermal/tegra/Kconfig b/drivers/thermal/tegra/Kconfig
index bed898858d02..cec586ec7e4b 100644
--- a/drivers/thermal/tegra/Kconfig
+++ b/drivers/thermal/tegra/Kconfig
@@ -5,7 +5,7 @@ config TEGRA_SOCTHERM
 	tristate "Tegra SOCTHERM thermal management"
 	help
 	  Enable this option for integrated thermal management support on NVIDIA
-	  Tegra124 systems-on-chip. The driver supports four thermal zones
+	  Tegra systems-on-chip. The driver supports four thermal zones
 	  (CPU, GPU, MEM, PLLX). Cooling devices can be bound to the thermal
 	  zones to manage temperatures. This option is also required for the
 	  emergency thermal reset (thermtrip) feature to function.
diff --git a/drivers/thermal/tegra/Makefile b/drivers/thermal/tegra/Makefile
index d4dc4e7f279e..d5fb15377b97 100644
--- a/drivers/thermal/tegra/Makefile
+++ b/drivers/thermal/tegra/Makefile
@@ -1 +1,4 @@
 obj-$(CONFIG_TEGRA_SOCTHERM)	+= tegra-soctherm.o
+
+tegra-soctherm-y				:= soctherm.o soctherm-fuse.o
+tegra-soctherm-$(CONFIG_ARCH_TEGRA_124_SOC)	+= tegra124-soctherm.o
diff --git a/drivers/thermal/tegra/soctherm-fuse.c b/drivers/thermal/tegra/soctherm-fuse.c
new file mode 100644
index 000000000000..931c299ab0e8
--- /dev/null
+++ b/drivers/thermal/tegra/soctherm-fuse.c
@@ -0,0 +1,158 @@
+/*
+ * Copyright (c) 2014-2016, NVIDIA CORPORATION.  All rights reserved.
+ *
+ * This software is licensed under the terms of the GNU General Public
+ * License version 2, as published by the Free Software Foundation, and
+ * may be copied, distributed, and modified under those terms.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ */
+
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <soc/tegra/fuse.h>
+
+#include "soctherm.h"
+
+#define NOMINAL_CALIB_FT			105
+#define NOMINAL_CALIB_CP			25
+
+#define FUSE_TSENSOR_CALIB_CP_TS_BASE_MASK	0x1fff
+#define FUSE_TSENSOR_CALIB_FT_TS_BASE_MASK	(0x1fff << 13)
+#define FUSE_TSENSOR_CALIB_FT_TS_BASE_SHIFT	13
+
+#define FUSE_TSENSOR_COMMON			0x180
+
+/*
+ * Tegra12x, etc:
+ * FUSE_TSENSOR_COMMON:
+ *    3                   2                   1                   0
+ *  1 0 9 8 7 6 5 4 3 2 1 0 9 8 7 6 5 4 3 2 1 0 9 8 7 6 5 4 3 2 1 0
+ * +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
+ * |-----------| SHFT_FT |       BASE_FT       |      BASE_CP      |
+ * +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
+ *
+ * FUSE_SPARE_REALIGNMENT_REG:
+ *    3                   2                   1                   0
+ *  1 0 9 8 7 6 5 4 3 2 1 0 9 8 7 6 5 4 3 2 1 0 9 8 7 6 5 4 3 2 1 0
+ * +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
+ * |---------------------------------------------------| SHIFT_CP  |
+ * +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
+ */
+
+#define CALIB_COEFFICIENT 1000000LL
+
+/**
+ * div64_s64_precise() - wrapper for div64_s64()
+ * @a:  the dividend
+ * @b:  the divisor
+ *
+ * Implements division with fairly accurate rounding instead of truncation by
+ * shifting the dividend to the left by 16 so that the quotient has a
+ * much higher precision.
+ *
+ * Return: the quotient of a / b.
+ */
+static s64 div64_s64_precise(s64 a, s32 b)
+{
+	s64 r, al;
+
+	/* Scale up for increased precision division */
+	al = a << 16;
+
+	r = div64_s64(al * 2 + 1, 2 * b);
+	return r >> 16;
+}
+
+int tegra_calc_shared_calib(const struct tegra_soctherm_fuse *tfuse,
+			    struct tsensor_shared_calib *shared)
+{
+	u32 val;
+	s32 shifted_cp, shifted_ft;
+	int err;
+
+	err = tegra_fuse_readl(FUSE_TSENSOR_COMMON, &val);
+	if (err)
+		return err;
+
+	shared->base_cp = (val & tfuse->fuse_base_cp_mask) >>
+			  tfuse->fuse_base_cp_shift;
+	shared->base_ft = (val & tfuse->fuse_base_ft_mask) >>
+			  tfuse->fuse_base_ft_shift;
+
+	shifted_ft = (val & tfuse->fuse_shift_ft_mask) >>
+		     tfuse->fuse_shift_ft_shift;
+	shifted_ft = sign_extend32(shifted_ft, 4);
+
+	if (tfuse->fuse_spare_realignment) {
+		err = tegra_fuse_readl(tfuse->fuse_spare_realignment, &val);
+		if (err)
+			return err;
+	}
+
+	shifted_cp = sign_extend32(val, 5);
+
+	shared->actual_temp_cp = 2 * NOMINAL_CALIB_CP + shifted_cp;
+	shared->actual_temp_ft = 2 * NOMINAL_CALIB_FT + shifted_ft;
+
+	return 0;
+}
+
+int tegra_calc_tsensor_calib(const struct tegra_tsensor *sensor,
+			     const struct tsensor_shared_calib *shared,
+			     u32 *calibration)
+{
+	const struct tegra_tsensor_group *sensor_group;
+	u32 val, calib;
+	s32 actual_tsensor_ft, actual_tsensor_cp;
+	s32 delta_sens, delta_temp;
+	s32 mult, div;
+	s16 therma, thermb;
+	s64 temp;
+	int err;
+
+	sensor_group = sensor->group;
+
+	err = tegra_fuse_readl(sensor->calib_fuse_offset, &val);
+	if (err)
+		return err;
+
+	actual_tsensor_cp = (shared->base_cp * 64) + sign_extend32(val, 12);
+	val = (val & FUSE_TSENSOR_CALIB_FT_TS_BASE_MASK) >>
+	      FUSE_TSENSOR_CALIB_FT_TS_BASE_SHIFT;
+	actual_tsensor_ft = (shared->base_ft * 32) + sign_extend32(val, 12);
+
+	delta_sens = actual_tsensor_ft - actual_tsensor_cp;
+	delta_temp = shared->actual_temp_ft - shared->actual_temp_cp;
+
+	mult = sensor_group->pdiv * sensor->config->tsample_ate;
+	div = sensor->config->tsample * sensor_group->pdiv_ate;
+
+	temp = (s64)delta_temp * (1LL << 13) * mult;
+	therma = div64_s64_precise(temp, (s64)delta_sens * div);
+
+	temp = ((s64)actual_tsensor_ft * shared->actual_temp_cp) -
+		((s64)actual_tsensor_cp * shared->actual_temp_ft);
+	thermb = div64_s64_precise(temp, delta_sens);
+
+	temp = (s64)therma * sensor->fuse_corr_alpha;
+	therma = div64_s64_precise(temp, CALIB_COEFFICIENT);
+
+	temp = (s64)thermb * sensor->fuse_corr_alpha + sensor->fuse_corr_beta;
+	thermb = div64_s64_precise(temp, CALIB_COEFFICIENT);
+
+	calib = ((u16)therma << SENSOR_CONFIG2_THERMA_SHIFT) |
+		((u16)thermb << SENSOR_CONFIG2_THERMB_SHIFT);
+
+	*calibration = calib;
+
+	return 0;
+}
+
+MODULE_AUTHOR("Wei Ni <wni@nvidia.com>");
+MODULE_DESCRIPTION("Tegra SOCTHERM fuse management");
+MODULE_LICENSE("GPL v2");
diff --git a/drivers/thermal/tegra/soctherm.c b/drivers/thermal/tegra/soctherm.c
new file mode 100644
index 000000000000..d9b23cded69f
--- /dev/null
+++ b/drivers/thermal/tegra/soctherm.c
@@ -0,0 +1,310 @@
+/*
+ * Copyright (c) 2014, NVIDIA CORPORATION.  All rights reserved.
+ *
+ * Author:
+ *	Mikko Perttunen <mperttunen@nvidia.com>
+ *
+ * This software is licensed under the terms of the GNU General Public
+ * License version 2, as published by the Free Software Foundation, and
+ * may be copied, distributed, and modified under those terms.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ */
+
+#include <linux/bitops.h>
+#include <linux/clk.h>
+#include <linux/delay.h>
+#include <linux/err.h>
+#include <linux/interrupt.h>
+#include <linux/io.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/platform_device.h>
+#include <linux/reset.h>
+#include <linux/thermal.h>
+
+#include <dt-bindings/thermal/tegra124-soctherm.h>
+
+#include "soctherm.h"
+
+#define SENSOR_CONFIG0				0
+#define SENSOR_CONFIG0_STOP			BIT(0)
+#define SENSOR_CONFIG0_TALL_SHIFT		8
+#define SENSOR_CONFIG0_TCALC_OVER		BIT(4)
+#define SENSOR_CONFIG0_OVER			BIT(3)
+#define SENSOR_CONFIG0_CPTR_OVER		BIT(2)
+
+#define SENSOR_CONFIG1				4
+#define SENSOR_CONFIG1_TSAMPLE_SHIFT		0
+#define SENSOR_CONFIG1_TIDDQ_EN_SHIFT		15
+#define SENSOR_CONFIG1_TEN_COUNT_SHIFT		24
+#define SENSOR_CONFIG1_TEMP_ENABLE		BIT(31)
+
+/*
+ * SENSOR_CONFIG2 is defined in soctherm.h
+ * because, it will be used by tegra_soctherm_fuse.c
+ */
+
+#define READBACK_VALUE_MASK			0xff00
+#define READBACK_VALUE_SHIFT			8
+#define READBACK_ADD_HALF			BIT(7)
+#define READBACK_NEGATE				BIT(0)
+
+/* get val from register(r) mask bits(m) */
+#define REG_GET_MASK(r, m)	(((r) & (m)) >> (ffs(m) - 1))
+/* set val(v) to mask bits(m) of register(r) */
+#define REG_SET_MASK(r, m, v)	(((r) & ~(m)) | \
+				 (((v) & (m >> (ffs(m) - 1))) << (ffs(m) - 1)))
+
+struct tegra_thermctl_zone {
+	void __iomem *reg;
+	u32 mask;
+};
+
+struct tegra_soctherm {
+	struct reset_control *reset;
+	struct clk *clock_tsensor;
+	struct clk *clock_soctherm;
+	void __iomem *regs;
+
+	u32 *calib;
+	struct tegra_soctherm_soc *soc;
+};
+
+static int enable_tsensor(struct tegra_soctherm *tegra,
+			  unsigned int i,
+			  const struct tsensor_shared_calib *shared)
+{
+	const struct tegra_tsensor *sensor = &tegra->soc->tsensors[i];
+	void __iomem *base = tegra->regs + sensor->base;
+	u32 *calib = &tegra->calib[i];
+	unsigned int val;
+	int err;
+
+	err = tegra_calc_tsensor_calib(sensor, shared, calib);
+	if (err)
+		return err;
+
+	val = sensor->config->tall << SENSOR_CONFIG0_TALL_SHIFT;
+	writel(val, base + SENSOR_CONFIG0);
+
+	val  = (sensor->config->tsample - 1) << SENSOR_CONFIG1_TSAMPLE_SHIFT;
+	val |= sensor->config->tiddq_en << SENSOR_CONFIG1_TIDDQ_EN_SHIFT;
+	val |= sensor->config->ten_count << SENSOR_CONFIG1_TEN_COUNT_SHIFT;
+	val |= SENSOR_CONFIG1_TEMP_ENABLE;
+	writel(val, base + SENSOR_CONFIG1);
+
+	writel(*calib, base + SENSOR_CONFIG2);
+
+	return 0;
+}
+
+/*
+ * Translate from soctherm readback format to millicelsius.
+ * The soctherm readback format in bits is as follows:
+ *   TTTTTTTT H______N
+ * where T's contain the temperature in Celsius,
+ * H denotes an addition of 0.5 Celsius and N denotes negation
+ * of the final value.
+ */
+static int translate_temp(u16 val)
+{
+	int t;
+
+	t = ((val & READBACK_VALUE_MASK) >> READBACK_VALUE_SHIFT) * 1000;
+	if (val & READBACK_ADD_HALF)
+		t += 500;
+	if (val & READBACK_NEGATE)
+		t *= -1;
+
+	return t;
+}
+
+static int tegra_thermctl_get_temp(void *data, int *out_temp)
+{
+	struct tegra_thermctl_zone *zone = data;
+	u32 val;
+
+	val = readl(zone->reg);
+	val = REG_GET_MASK(val, zone->mask);
+	*out_temp = translate_temp(val);
+
+	return 0;
+}
+
+static const struct thermal_zone_of_device_ops tegra_of_thermal_ops = {
+	.get_temp = tegra_thermctl_get_temp,
+};
+
+static const struct of_device_id tegra_soctherm_of_match[] = {
+#ifdef CONFIG_ARCH_TEGRA_124_SOC
+	{
+		.compatible = "nvidia,tegra124-soctherm",
+		.data = &tegra124_soctherm,
+	},
+#endif
+	{ },
+};
+MODULE_DEVICE_TABLE(of, tegra_soctherm_of_match);
+
+static int tegra_soctherm_probe(struct platform_device *pdev)
+{
+	const struct of_device_id *match;
+	struct tegra_soctherm *tegra;
+	struct thermal_zone_device *z;
+	struct tsensor_shared_calib shared_calib;
+	struct resource *res;
+	struct tegra_soctherm_soc *soc;
+	unsigned int i;
+	int err;
+	u32 pdiv, hotspot;
+
+	match = of_match_node(tegra_soctherm_of_match, pdev->dev.of_node);
+	if (!match)
+		return -ENODEV;
+
+	soc = (struct tegra_soctherm_soc *)match->data;
+	if (soc->num_ttgs > TEGRA124_SOCTHERM_SENSOR_NUM)
+		return -EINVAL;
+
+	tegra = devm_kzalloc(&pdev->dev, sizeof(*tegra), GFP_KERNEL);
+	if (!tegra)
+		return -ENOMEM;
+
+	dev_set_drvdata(&pdev->dev, tegra);
+
+	tegra->soc = soc;
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	tegra->regs = devm_ioremap_resource(&pdev->dev, res);
+	if (IS_ERR(tegra->regs))
+		return PTR_ERR(tegra->regs);
+
+	tegra->reset = devm_reset_control_get(&pdev->dev, "soctherm");
+	if (IS_ERR(tegra->reset)) {
+		dev_err(&pdev->dev, "can't get soctherm reset\n");
+		return PTR_ERR(tegra->reset);
+	}
+
+	tegra->clock_tsensor = devm_clk_get(&pdev->dev, "tsensor");
+	if (IS_ERR(tegra->clock_tsensor)) {
+		dev_err(&pdev->dev, "can't get tsensor clock\n");
+		return PTR_ERR(tegra->clock_tsensor);
+	}
+
+	tegra->clock_soctherm = devm_clk_get(&pdev->dev, "soctherm");
+	if (IS_ERR(tegra->clock_soctherm)) {
+		dev_err(&pdev->dev, "can't get soctherm clock\n");
+		return PTR_ERR(tegra->clock_soctherm);
+	}
+
+	reset_control_assert(tegra->reset);
+
+	err = clk_prepare_enable(tegra->clock_soctherm);
+	if (err)
+		return err;
+
+	err = clk_prepare_enable(tegra->clock_tsensor);
+	if (err) {
+		clk_disable_unprepare(tegra->clock_soctherm);
+		return err;
+	}
+
+	reset_control_deassert(tegra->reset);
+
+	/* Initialize raw sensors */
+
+	tegra->calib = devm_kzalloc(&pdev->dev,
+				    sizeof(u32) * soc->num_tsensors,
+				    GFP_KERNEL);
+	if (!tegra->calib) {
+		err = -ENOMEM;
+		goto disable_clocks;
+	}
+
+	err = tegra_calc_shared_calib(soc->tfuse, &shared_calib);
+	if (err)
+		goto disable_clocks;
+
+	for (i = 0; i < soc->num_tsensors; ++i) {
+		err = enable_tsensor(tegra, i, &shared_calib);
+		if (err)
+			goto disable_clocks;
+	}
+
+	/* Program pdiv and hotspot offsets per THERM */
+	pdiv = readl(tegra->regs + SENSOR_PDIV);
+	hotspot = readl(tegra->regs + SENSOR_HOTSPOT_OFF);
+	for (i = 0; i < soc->num_ttgs; ++i) {
+		pdiv = REG_SET_MASK(pdiv, soc->ttgs[i]->pdiv_mask,
+				    soc->ttgs[i]->pdiv);
+		/* hotspot offset from PLLX, doesn't need to configure PLLX */
+		if (soc->ttgs[i]->id == TEGRA124_SOCTHERM_SENSOR_PLLX)
+			continue;
+		hotspot =  REG_SET_MASK(hotspot,
+					soc->ttgs[i]->pllx_hotspot_mask,
+					soc->ttgs[i]->pllx_hotspot_diff);
+	}
+	writel(pdiv, tegra->regs + SENSOR_PDIV);
+	writel(hotspot, tegra->regs + SENSOR_HOTSPOT_OFF);
+
+	/* Initialize thermctl sensors */
+
+	for (i = 0; i < soc->num_ttgs; ++i) {
+		struct tegra_thermctl_zone *zone =
+			devm_kzalloc(&pdev->dev, sizeof(*zone), GFP_KERNEL);
+		if (!zone) {
+			err = -ENOMEM;
+			goto disable_clocks;
+		}
+
+		zone->reg = tegra->regs + soc->ttgs[i]->sensor_temp_offset;
+		zone->mask = soc->ttgs[i]->sensor_temp_mask;
+
+		z = devm_thermal_zone_of_sensor_register(&pdev->dev,
+							 soc->ttgs[i]->id, zone,
+							 &tegra_of_thermal_ops);
+		if (IS_ERR(z)) {
+			err = PTR_ERR(z);
+			dev_err(&pdev->dev, "failed to register sensor: %d\n",
+				err);
+			goto disable_clocks;
+		}
+	}
+
+	return 0;
+
+disable_clocks:
+	clk_disable_unprepare(tegra->clock_tsensor);
+	clk_disable_unprepare(tegra->clock_soctherm);
+
+	return err;
+}
+
+static int tegra_soctherm_remove(struct platform_device *pdev)
+{
+	struct tegra_soctherm *tegra = platform_get_drvdata(pdev);
+
+	clk_disable_unprepare(tegra->clock_tsensor);
+	clk_disable_unprepare(tegra->clock_soctherm);
+
+	return 0;
+}
+
+static struct platform_driver tegra_soctherm_driver = {
+	.probe = tegra_soctherm_probe,
+	.remove = tegra_soctherm_remove,
+	.driver = {
+		.name = "tegra_soctherm",
+		.of_match_table = tegra_soctherm_of_match,
+	},
+};
+module_platform_driver(tegra_soctherm_driver);
+
+MODULE_AUTHOR("Mikko Perttunen <mperttunen@nvidia.com>");
+MODULE_DESCRIPTION("NVIDIA Tegra SOCTHERM thermal management driver");
+MODULE_LICENSE("GPL v2");
diff --git a/drivers/thermal/tegra/soctherm.h b/drivers/thermal/tegra/soctherm.h
new file mode 100644
index 000000000000..f80ee1492ddb
--- /dev/null
+++ b/drivers/thermal/tegra/soctherm.h
@@ -0,0 +1,110 @@
+/*
+ * Copyright (c) 2014-2016, NVIDIA CORPORATION.  All rights reserved.
+ *
+ * This software is licensed under the terms of the GNU General Public
+ * License version 2, as published by the Free Software Foundation, and
+ * may be copied, distributed, and modified under those terms.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ */
+
+#ifndef __DRIVERS_THERMAL_TEGRA_SOCTHERM_H
+#define __DRIVERS_THERMAL_TEGRA_SOCTHERM_H
+
+#define SENSOR_CONFIG2                          8
+#define SENSOR_CONFIG2_THERMA_SHIFT		16
+#define SENSOR_CONFIG2_THERMB_SHIFT		0
+
+#define SENSOR_PDIV				0x1c0
+#define SENSOR_PDIV_CPU_MASK			(0xf << 12)
+#define SENSOR_PDIV_GPU_MASK			(0xf << 8)
+#define SENSOR_PDIV_MEM_MASK			(0xf << 4)
+#define SENSOR_PDIV_PLLX_MASK			(0xf << 0)
+
+#define SENSOR_HOTSPOT_OFF			0x1c4
+#define SENSOR_HOTSPOT_CPU_MASK			(0xff << 16)
+#define SENSOR_HOTSPOT_GPU_MASK			(0xff << 8)
+#define SENSOR_HOTSPOT_MEM_MASK			(0xff << 0)
+
+#define SENSOR_TEMP1				0x1c8
+#define SENSOR_TEMP1_CPU_TEMP_MASK		(0xffff << 16)
+#define SENSOR_TEMP1_GPU_TEMP_MASK		0xffff
+#define SENSOR_TEMP2				0x1cc
+#define SENSOR_TEMP2_MEM_TEMP_MASK		(0xffff << 16)
+#define SENSOR_TEMP2_PLLX_TEMP_MASK		0xffff
+
+/**
+ * struct tegra_tsensor_group - SOC_THERM sensor group data
+ * @name: short name of the temperature sensor group
+ * @id: numeric ID of the temperature sensor group
+ * @sensor_temp_offset: offset of the SENSOR_TEMP* register
+ * @sensor_temp_mask: bit mask for this sensor group in SENSOR_TEMP* register
+ * @pdiv: the sensor count post-divider to use during runtime
+ * @pdiv_ate: the sensor count post-divider used during automated test
+ * @pdiv_mask: register bitfield mask for the PDIV field for this sensor
+ * @pllx_hotspot_diff: hotspot offset from the PLLX sensor, must be 0 for
+    PLLX sensor group
+ * @pllx_hotspot_mask: register bitfield mask for the HOTSPOT field
+ */
+struct tegra_tsensor_group {
+	const char *name;
+	u8 id;
+	u16 sensor_temp_offset;
+	u32 sensor_temp_mask;
+	u32 pdiv, pdiv_ate, pdiv_mask;
+	u32 pllx_hotspot_diff, pllx_hotspot_mask;
+};
+
+struct tegra_tsensor_configuration {
+	u32 tall, tiddq_en, ten_count, pdiv, pdiv_ate, tsample, tsample_ate;
+};
+
+struct tegra_tsensor {
+	const char *name;
+	const u32 base;
+	const struct tegra_tsensor_configuration *config;
+	const u32 calib_fuse_offset;
+	/*
+	 * Correction values used to modify values read from
+	 * calibration fuses
+	 */
+	const s32 fuse_corr_alpha, fuse_corr_beta;
+	const struct tegra_tsensor_group *group;
+};
+
+struct tegra_soctherm_fuse {
+	u32 fuse_base_cp_mask, fuse_base_cp_shift;
+	u32 fuse_base_ft_mask, fuse_base_ft_shift;
+	u32 fuse_shift_ft_mask, fuse_shift_ft_shift;
+	u32 fuse_spare_realignment;
+};
+
+struct tsensor_shared_calib {
+	u32 base_cp, base_ft;
+	u32 actual_temp_cp, actual_temp_ft;
+};
+
+struct tegra_soctherm_soc {
+	const struct tegra_tsensor *tsensors;
+	const unsigned int num_tsensors;
+	const struct tegra_tsensor_group **ttgs;
+	const unsigned int num_ttgs;
+	const struct tegra_soctherm_fuse *tfuse;
+};
+
+int tegra_calc_shared_calib(const struct tegra_soctherm_fuse *tfuse,
+			    struct tsensor_shared_calib *shared);
+int tegra_calc_tsensor_calib(const struct tegra_tsensor *sensor,
+			     const struct tsensor_shared_calib *shared,
+			     u32 *calib);
+
+#ifdef CONFIG_ARCH_TEGRA_124_SOC
+extern const struct tegra_soctherm_soc tegra124_soctherm;
+#endif
+
+#endif
+
diff --git a/drivers/thermal/tegra/tegra-soctherm.c b/drivers/thermal/tegra/tegra-soctherm.c
deleted file mode 100644
index e486d034adb4..000000000000
--- a/drivers/thermal/tegra/tegra-soctherm.c
+++ /dev/null
@@ -1,565 +0,0 @@
-/*
- * Copyright (c) 2014, NVIDIA CORPORATION.  All rights reserved.
- *
- * Author:
- *	Mikko Perttunen <mperttunen@nvidia.com>
- *
- * This software is licensed under the terms of the GNU General Public
- * License version 2, as published by the Free Software Foundation, and
- * may be copied, distributed, and modified under those terms.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- */
-
-#include <linux/bitops.h>
-#include <linux/clk.h>
-#include <linux/delay.h>
-#include <linux/err.h>
-#include <linux/interrupt.h>
-#include <linux/io.h>
-#include <linux/module.h>
-#include <linux/of.h>
-#include <linux/platform_device.h>
-#include <linux/reset.h>
-#include <linux/thermal.h>
-
-#include <soc/tegra/fuse.h>
-#include <dt-bindings/thermal/tegra124-soctherm.h>
-
-#define SENSOR_CONFIG0				0
-#define SENSOR_CONFIG0_STOP			BIT(0)
-#define SENSOR_CONFIG0_TALL_SHIFT		8
-#define SENSOR_CONFIG0_TCALC_OVER		BIT(4)
-#define SENSOR_CONFIG0_OVER			BIT(3)
-#define SENSOR_CONFIG0_CPTR_OVER		BIT(2)
-
-#define SENSOR_CONFIG1				4
-#define SENSOR_CONFIG1_TSAMPLE_SHIFT		0
-#define SENSOR_CONFIG1_TIDDQ_EN_SHIFT		15
-#define SENSOR_CONFIG1_TEN_COUNT_SHIFT		24
-#define SENSOR_CONFIG1_TEMP_ENABLE		BIT(31)
-
-#define SENSOR_CONFIG2				8
-#define SENSOR_CONFIG2_THERMA_SHIFT		16
-#define SENSOR_CONFIG2_THERMB_SHIFT		0
-
-#define SENSOR_PDIV				0x1c0
-#define SENSOR_PDIV_CPU_MASK			(0xf << 12)
-#define SENSOR_PDIV_GPU_MASK			(0xf << 8)
-#define SENSOR_PDIV_MEM_MASK			(0xf << 4)
-#define SENSOR_PDIV_PLLX_MASK			(0xf << 0)
-
-#define SENSOR_HOTSPOT_OFF			0x1c4
-#define SENSOR_HOTSPOT_CPU_MASK			(0xff << 16)
-#define SENSOR_HOTSPOT_GPU_MASK			(0xff << 8)
-#define SENSOR_HOTSPOT_MEM_MASK			(0xff << 0)
-
-#define SENSOR_TEMP1				0x1c8
-#define SENSOR_TEMP1_CPU_TEMP_MASK		(0xffff << 16)
-#define SENSOR_TEMP1_GPU_TEMP_MASK		0xffff
-#define SENSOR_TEMP2				0x1cc
-#define SENSOR_TEMP2_MEM_TEMP_MASK		(0xffff << 16)
-#define SENSOR_TEMP2_PLLX_TEMP_MASK		0xffff
-
-#define READBACK_VALUE_MASK			0xff00
-#define READBACK_VALUE_SHIFT			8
-#define READBACK_ADD_HALF			BIT(7)
-#define READBACK_NEGATE				BIT(0)
-
-#define FUSE_TSENSOR8_CALIB			0x180
-#define FUSE_SPARE_REALIGNMENT_REG_0		0x1fc
-
-#define FUSE_TSENSOR_CALIB_CP_TS_BASE_MASK	0x1fff
-#define FUSE_TSENSOR_CALIB_FT_TS_BASE_MASK	(0x1fff << 13)
-#define FUSE_TSENSOR_CALIB_FT_TS_BASE_SHIFT	13
-
-#define FUSE_TSENSOR8_CALIB_CP_TS_BASE_MASK	0x3ff
-#define FUSE_TSENSOR8_CALIB_FT_TS_BASE_MASK	(0x7ff << 10)
-#define FUSE_TSENSOR8_CALIB_FT_TS_BASE_SHIFT	10
-
-#define FUSE_SPARE_REALIGNMENT_REG_SHIFT_CP_MASK 0x3f
-#define FUSE_SPARE_REALIGNMENT_REG_SHIFT_FT_MASK (0x1f << 21)
-#define FUSE_SPARE_REALIGNMENT_REG_SHIFT_FT_SHIFT 21
-
-#define NOMINAL_CALIB_FT_T124			105
-#define NOMINAL_CALIB_CP_T124			25
-
-/* get val from register(r) mask bits(m) */
-#define REG_GET_MASK(r, m)	(((r) & (m)) >> (ffs(m) - 1))
-/* set val(v) to mask bits(m) of register(r) */
-#define REG_SET_MASK(r, m, v)	(((r) & ~(m)) | \
-				 (((v) & (m >> (ffs(m) - 1))) << (ffs(m) - 1)))
-
-/**
- * struct tegra_tsensor_group - SOC_THERM sensor group data
- * @name: short name of the temperature sensor group
- * @id: numeric ID of the temperature sensor group
- * @sensor_temp_offset: offset of the SENSOR_TEMP* register
- * @sensor_temp_mask: bit mask for this sensor group in SENSOR_TEMP* register
- * @pdiv: the sensor count post-divider to use during runtime
- * @pdiv_ate: the sensor count post-divider used during automated test
- * @pdiv_mask: register bitfield mask for the PDIV field for this sensor
- * @pllx_hotspot_diff: hotspot offset from the PLLX sensor, must be 0 for
-    PLLX sensor group
- * @pllx_hotspot_mask: register bitfield mask for the HOTSPOT field
- */
-struct tegra_tsensor_group {
-	const char	*name;
-	u8		id;
-	u16		sensor_temp_offset;
-	u32		sensor_temp_mask;
-	u32		pdiv, pdiv_ate, pdiv_mask;
-	u32		pllx_hotspot_diff, pllx_hotspot_mask;
-};
-
-struct tegra_tsensor_configuration {
-	u32 tall, tiddq_en, ten_count, tsample, tsample_ate;
-};
-
-struct tegra_tsensor {
-	const struct tegra_tsensor_configuration *config;
-	u32 base, calib_fuse_offset;
-	/* Correction values used to modify values read from calibration fuses */
-	s32 fuse_corr_alpha, fuse_corr_beta;
-	const struct tegra_tsensor_group *group;
-};
-
-struct tegra_thermctl_zone {
-	void __iomem *reg;
-	u32 mask;
-};
-
-static const struct tegra_tsensor_configuration t124_tsensor_config = {
-	.tall = 16300,
-	.tiddq_en = 1,
-	.ten_count = 1,
-	.tsample = 120,
-	.tsample_ate = 480,
-};
-
-static const struct tegra_tsensor_group tegra124_tsensor_group_cpu = {
-	.id				= TEGRA124_SOCTHERM_SENSOR_CPU,
-	.name				= "cpu",
-	.sensor_temp_offset		= SENSOR_TEMP1,
-	.sensor_temp_mask		= SENSOR_TEMP1_CPU_TEMP_MASK,
-	.pdiv				= 8,
-	.pdiv_ate			= 8,
-	.pdiv_mask			= SENSOR_PDIV_CPU_MASK,
-	.pllx_hotspot_diff		= 10,
-	.pllx_hotspot_mask		= SENSOR_HOTSPOT_CPU_MASK,
-};
-
-static const struct tegra_tsensor_group tegra124_tsensor_group_gpu = {
-	.id				= TEGRA124_SOCTHERM_SENSOR_GPU,
-	.name				= "gpu",
-	.sensor_temp_offset		= SENSOR_TEMP1,
-	.sensor_temp_mask		= SENSOR_TEMP1_GPU_TEMP_MASK,
-	.pdiv				= 8,
-	.pdiv_ate			= 8,
-	.pdiv_mask			= SENSOR_PDIV_GPU_MASK,
-	.pllx_hotspot_diff		= 5,
-	.pllx_hotspot_mask		= SENSOR_HOTSPOT_GPU_MASK,
-};
-
-static const struct tegra_tsensor_group tegra124_tsensor_group_pll = {
-	.id				= TEGRA124_SOCTHERM_SENSOR_PLLX,
-	.name				= "pll",
-	.sensor_temp_offset		= SENSOR_TEMP2,
-	.sensor_temp_mask		= SENSOR_TEMP2_PLLX_TEMP_MASK,
-	.pdiv				= 8,
-	.pdiv_ate			= 8,
-	.pdiv_mask			= SENSOR_PDIV_PLLX_MASK,
-	.pllx_hotspot_diff		= 0,
-	.pllx_hotspot_mask		= SENSOR_HOTSPOT_MEM_MASK,
-};
-
-static const struct tegra_tsensor_group tegra124_tsensor_group_mem = {
-	.id				= TEGRA124_SOCTHERM_SENSOR_MEM,
-	.name				= "mem",
-	.sensor_temp_offset		= SENSOR_TEMP2,
-	.sensor_temp_mask		= SENSOR_TEMP2_MEM_TEMP_MASK,
-	.pdiv				= 8,
-	.pdiv_ate			= 8,
-	.pdiv_mask			= SENSOR_PDIV_MEM_MASK,
-};
-
-static const struct tegra_tsensor_group *
-tegra124_tsensor_groups[TEGRA124_SOCTHERM_SENSOR_NUM] = {
-	&tegra124_tsensor_group_cpu,
-	&tegra124_tsensor_group_gpu,
-	&tegra124_tsensor_group_pll,
-	&tegra124_tsensor_group_mem,
-};
-
-static const struct tegra_tsensor t124_tsensors[] = {
-	{
-		.config = &t124_tsensor_config,
-		.base = 0xc0,
-		.calib_fuse_offset = 0x098,
-		.fuse_corr_alpha = 1135400,
-		.fuse_corr_beta = -6266900,
-		.group = &tegra124_tsensor_group_cpu,
-	},
-	{
-		.config = &t124_tsensor_config,
-		.base = 0xe0,
-		.calib_fuse_offset = 0x084,
-		.fuse_corr_alpha = 1122220,
-		.fuse_corr_beta = -5700700,
-		.group = &tegra124_tsensor_group_cpu,
-	},
-	{
-		.config = &t124_tsensor_config,
-		.base = 0x100,
-		.calib_fuse_offset = 0x088,
-		.fuse_corr_alpha = 1127000,
-		.fuse_corr_beta = -6768200,
-		.group = &tegra124_tsensor_group_cpu,
-	},
-	{
-		.config = &t124_tsensor_config,
-		.base = 0x120,
-		.calib_fuse_offset = 0x12c,
-		.fuse_corr_alpha = 1110900,
-		.fuse_corr_beta = -6232000,
-		.group = &tegra124_tsensor_group_cpu,
-	},
-	{
-		.config = &t124_tsensor_config,
-		.base = 0x140,
-		.calib_fuse_offset = 0x158,
-		.fuse_corr_alpha = 1122300,
-		.fuse_corr_beta = -5936400,
-		.group = &tegra124_tsensor_group_mem,
-	},
-	{
-		.config = &t124_tsensor_config,
-		.base = 0x160,
-		.calib_fuse_offset = 0x15c,
-		.fuse_corr_alpha = 1145700,
-		.fuse_corr_beta = -7124600,
-		.group = &tegra124_tsensor_group_mem,
-	},
-	{
-		.config = &t124_tsensor_config,
-		.base = 0x180,
-		.calib_fuse_offset = 0x154,
-		.fuse_corr_alpha = 1120100,
-		.fuse_corr_beta = -6000500,
-		.group = &tegra124_tsensor_group_gpu,
-	},
-	{
-		.config = &t124_tsensor_config,
-		.base = 0x1a0,
-		.calib_fuse_offset = 0x160,
-		.fuse_corr_alpha = 1106500,
-		.fuse_corr_beta = -6729300,
-		.group = &tegra124_tsensor_group_pll,
-	},
-};
-
-struct tegra_soctherm {
-	struct reset_control *reset;
-	struct clk *clock_tsensor;
-	struct clk *clock_soctherm;
-	void __iomem *regs;
-};
-
-struct tsensor_shared_calibration {
-	u32 base_cp, base_ft;
-	u32 actual_temp_cp, actual_temp_ft;
-};
-
-static int calculate_shared_calibration(struct tsensor_shared_calibration *r)
-{
-	u32 val, shifted_cp, shifted_ft;
-	int err;
-
-	err = tegra_fuse_readl(FUSE_TSENSOR8_CALIB, &val);
-	if (err)
-		return err;
-	r->base_cp = val & FUSE_TSENSOR8_CALIB_CP_TS_BASE_MASK;
-	r->base_ft = (val & FUSE_TSENSOR8_CALIB_FT_TS_BASE_MASK)
-		>> FUSE_TSENSOR8_CALIB_FT_TS_BASE_SHIFT;
-	val = ((val & FUSE_SPARE_REALIGNMENT_REG_SHIFT_FT_MASK)
-		>> FUSE_SPARE_REALIGNMENT_REG_SHIFT_FT_SHIFT);
-	shifted_ft = sign_extend32(val, 4);
-
-	err = tegra_fuse_readl(FUSE_SPARE_REALIGNMENT_REG_0, &val);
-	if (err)
-		return err;
-	shifted_cp = sign_extend32(val, 5);
-
-	r->actual_temp_cp = 2 * NOMINAL_CALIB_CP_T124 + shifted_cp;
-	r->actual_temp_ft = 2 * NOMINAL_CALIB_FT_T124 + shifted_ft;
-
-	return 0;
-}
-
-static s64 div64_s64_precise(s64 a, s64 b)
-{
-	s64 r, al;
-
-	/* Scale up for increased precision division */
-	al = a << 16;
-
-	r = div64_s64(al * 2 + 1, 2 * b);
-	return r >> 16;
-}
-
-static int
-calculate_tsensor_calibration(const struct tegra_tsensor *sensor,
-			      const struct tsensor_shared_calibration *shared,
-			      u32 *calib)
-{
-	u32 val;
-	s32 actual_tsensor_ft, actual_tsensor_cp, delta_sens, delta_temp,
-	    mult, div;
-	s16 therma, thermb;
-	s64 tmp;
-	int err;
-
-	err = tegra_fuse_readl(sensor->calib_fuse_offset, &val);
-	if (err)
-		return err;
-
-	actual_tsensor_cp = (shared->base_cp * 64) + sign_extend32(val, 12);
-	val = (val & FUSE_TSENSOR_CALIB_FT_TS_BASE_MASK)
-		>> FUSE_TSENSOR_CALIB_FT_TS_BASE_SHIFT;
-	actual_tsensor_ft = (shared->base_ft * 32) + sign_extend32(val, 12);
-
-	delta_sens = actual_tsensor_ft - actual_tsensor_cp;
-	delta_temp = shared->actual_temp_ft - shared->actual_temp_cp;
-
-	mult = sensor->group->pdiv * sensor->config->tsample_ate;
-	div = sensor->config->tsample * sensor->group->pdiv_ate;
-
-	therma = div64_s64_precise((s64) delta_temp * (1LL << 13) * mult,
-				   (s64) delta_sens * div);
-
-	tmp = (s64)actual_tsensor_ft * shared->actual_temp_cp -
-	      (s64)actual_tsensor_cp * shared->actual_temp_ft;
-	thermb = div64_s64_precise(tmp, (s64)delta_sens);
-
-	therma = div64_s64_precise((s64)therma * sensor->fuse_corr_alpha,
-				   (s64)1000000LL);
-	thermb = div64_s64_precise((s64)thermb * sensor->fuse_corr_alpha +
-				   sensor->fuse_corr_beta, (s64)1000000LL);
-
-	*calib = ((u16)therma << SENSOR_CONFIG2_THERMA_SHIFT) |
-		 ((u16)thermb << SENSOR_CONFIG2_THERMB_SHIFT);
-
-	return 0;
-}
-
-static int enable_tsensor(struct tegra_soctherm *tegra,
-			  const struct tegra_tsensor *sensor,
-			  const struct tsensor_shared_calibration *shared)
-{
-	void __iomem *base = tegra->regs + sensor->base;
-	unsigned int val;
-	u32 calib;
-	int err;
-
-	err = calculate_tsensor_calibration(sensor, shared, &calib);
-	if (err)
-		return err;
-
-	val = sensor->config->tall << SENSOR_CONFIG0_TALL_SHIFT;
-	writel(val, base + SENSOR_CONFIG0);
-
-	val  = (sensor->config->tsample - 1) << SENSOR_CONFIG1_TSAMPLE_SHIFT;
-	val |= sensor->config->tiddq_en << SENSOR_CONFIG1_TIDDQ_EN_SHIFT;
-	val |= sensor->config->ten_count << SENSOR_CONFIG1_TEN_COUNT_SHIFT;
-	val |= SENSOR_CONFIG1_TEMP_ENABLE;
-	writel(val, base + SENSOR_CONFIG1);
-
-	writel(calib, base + SENSOR_CONFIG2);
-
-	return 0;
-}
-
-/*
- * Translate from soctherm readback format to millicelsius.
- * The soctherm readback format in bits is as follows:
- *   TTTTTTTT H______N
- * where T's contain the temperature in Celsius,
- * H denotes an addition of 0.5 Celsius and N denotes negation
- * of the final value.
- */
-static int translate_temp(u16 val)
-{
-	long t;
-
-	t = ((val & READBACK_VALUE_MASK) >> READBACK_VALUE_SHIFT) * 1000;
-	if (val & READBACK_ADD_HALF)
-		t += 500;
-	if (val & READBACK_NEGATE)
-		t *= -1;
-
-	return t;
-}
-
-static int tegra_thermctl_get_temp(void *data, int *out_temp)
-{
-	struct tegra_thermctl_zone *zone = data;
-	u32 val;
-
-	val = readl(zone->reg);
-	val = REG_GET_MASK(val, zone->mask);
-	*out_temp = translate_temp(val);
-
-	return 0;
-}
-
-static const struct thermal_zone_of_device_ops tegra_of_thermal_ops = {
-	.get_temp = tegra_thermctl_get_temp,
-};
-
-static const struct of_device_id tegra_soctherm_of_match[] = {
-	{ .compatible = "nvidia,tegra124-soctherm" },
-	{ },
-};
-MODULE_DEVICE_TABLE(of, tegra_soctherm_of_match);
-
-static int tegra_soctherm_probe(struct platform_device *pdev)
-{
-	struct tegra_soctherm *tegra;
-	struct thermal_zone_device *z;
-	struct tsensor_shared_calibration shared_calib;
-	struct resource *res;
-	unsigned int i;
-	int err;
-	u32 pdiv, hotspot;
-
-	const struct tegra_tsensor *tsensors = t124_tsensors;
-	const struct tegra_tsensor_group **ttgs = tegra124_tsensor_groups;
-
-	tegra = devm_kzalloc(&pdev->dev, sizeof(*tegra), GFP_KERNEL);
-	if (!tegra)
-		return -ENOMEM;
-
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	tegra->regs = devm_ioremap_resource(&pdev->dev, res);
-	if (IS_ERR(tegra->regs))
-		return PTR_ERR(tegra->regs);
-
-	tegra->reset = devm_reset_control_get(&pdev->dev, "soctherm");
-	if (IS_ERR(tegra->reset)) {
-		dev_err(&pdev->dev, "can't get soctherm reset\n");
-		return PTR_ERR(tegra->reset);
-	}
-
-	tegra->clock_tsensor = devm_clk_get(&pdev->dev, "tsensor");
-	if (IS_ERR(tegra->clock_tsensor)) {
-		dev_err(&pdev->dev, "can't get tsensor clock\n");
-		return PTR_ERR(tegra->clock_tsensor);
-	}
-
-	tegra->clock_soctherm = devm_clk_get(&pdev->dev, "soctherm");
-	if (IS_ERR(tegra->clock_soctherm)) {
-		dev_err(&pdev->dev, "can't get soctherm clock\n");
-		return PTR_ERR(tegra->clock_soctherm);
-	}
-
-	reset_control_assert(tegra->reset);
-
-	err = clk_prepare_enable(tegra->clock_soctherm);
-	if (err)
-		return err;
-
-	err = clk_prepare_enable(tegra->clock_tsensor);
-	if (err) {
-		clk_disable_unprepare(tegra->clock_soctherm);
-		return err;
-	}
-
-	reset_control_deassert(tegra->reset);
-
-	/* Initialize raw sensors */
-
-	err = calculate_shared_calibration(&shared_calib);
-	if (err)
-		goto disable_clocks;
-
-	for (i = 0; i < ARRAY_SIZE(t124_tsensors); ++i) {
-		err = enable_tsensor(tegra, tsensors + i, &shared_calib);
-		if (err)
-			goto disable_clocks;
-	}
-
-	/* Program pdiv and hotspot offsets per THERM */
-	pdiv = readl(tegra->regs + SENSOR_PDIV);
-	hotspot = readl(tegra->regs + SENSOR_HOTSPOT_OFF);
-	for (i = 0; i < TEGRA124_SOCTHERM_SENSOR_NUM; ++i) {
-		pdiv = REG_SET_MASK(pdiv, ttgs[i]->pdiv_mask,
-				    ttgs[i]->pdiv);
-		/* hotspot offset from PLLX, doesn't need to configure PLLX */
-		if (ttgs[i]->id != TEGRA124_SOCTHERM_SENSOR_PLLX)
-			hotspot =  REG_SET_MASK(hotspot,
-						ttgs[i]->pllx_hotspot_mask,
-						ttgs[i]->pllx_hotspot_diff);
-	}
-	writel(pdiv, tegra->regs + SENSOR_PDIV);
-	writel(hotspot, tegra->regs + SENSOR_HOTSPOT_OFF);
-
-	/* Initialize thermctl sensors */
-
-	for (i = 0; i < TEGRA124_SOCTHERM_SENSOR_NUM; ++i) {
-		struct tegra_thermctl_zone *zone =
-			devm_kzalloc(&pdev->dev, sizeof(*zone), GFP_KERNEL);
-		if (!zone) {
-			err = -ENOMEM;
-			goto disable_clocks;
-		}
-
-		zone->reg = tegra->regs + ttgs[i]->sensor_temp_offset;
-		zone->mask = ttgs[i]->sensor_temp_mask;
-
-		z = devm_thermal_zone_of_sensor_register(&pdev->dev,
-							 ttgs[i]->id, zone,
-							 &tegra_of_thermal_ops);
-		if (IS_ERR(z)) {
-			err = PTR_ERR(z);
-			dev_err(&pdev->dev, "failed to register sensor: %d\n",
-				err);
-			goto disable_clocks;
-		}
-	}
-
-	return 0;
-
-disable_clocks:
-	clk_disable_unprepare(tegra->clock_tsensor);
-	clk_disable_unprepare(tegra->clock_soctherm);
-
-	return err;
-}
-
-static int tegra_soctherm_remove(struct platform_device *pdev)
-{
-	struct tegra_soctherm *tegra = platform_get_drvdata(pdev);
-
-	clk_disable_unprepare(tegra->clock_tsensor);
-	clk_disable_unprepare(tegra->clock_soctherm);
-
-	return 0;
-}
-
-static struct platform_driver tegra_soctherm_driver = {
-	.probe = tegra_soctherm_probe,
-	.remove = tegra_soctherm_remove,
-	.driver = {
-		.name = "tegra-soctherm",
-		.of_match_table = tegra_soctherm_of_match,
-	},
-};
-module_platform_driver(tegra_soctherm_driver);
-
-MODULE_AUTHOR("Mikko Perttunen <mperttunen@nvidia.com>");
-MODULE_DESCRIPTION("NVIDIA Tegra SOCTHERM thermal management driver");
-MODULE_LICENSE("GPL v2");
diff --git a/drivers/thermal/tegra/tegra124-soctherm.c b/drivers/thermal/tegra/tegra124-soctherm.c
new file mode 100644
index 000000000000..06aad13a979f
--- /dev/null
+++ b/drivers/thermal/tegra/tegra124-soctherm.c
@@ -0,0 +1,172 @@
+/*
+ * Copyright (c) 2014-2016, NVIDIA CORPORATION.  All rights reserved.
+ *
+ * This software is licensed under the terms of the GNU General Public
+ * License version 2, as published by the Free Software Foundation, and
+ * may be copied, distributed, and modified under those terms.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ */
+
+#include <linux/module.h>
+#include <linux/platform_device.h>
+
+#include <dt-bindings/thermal/tegra124-soctherm.h>
+
+#include "soctherm.h"
+
+static const struct tegra_tsensor_configuration tegra124_tsensor_config = {
+	.tall = 16300,
+	.tiddq_en = 1,
+	.ten_count = 1,
+	.tsample = 120,
+	.tsample_ate = 480,
+};
+
+static const struct tegra_tsensor_group tegra124_tsensor_group_cpu = {
+	.id = TEGRA124_SOCTHERM_SENSOR_CPU,
+	.name	= "cpu",
+	.sensor_temp_offset	= SENSOR_TEMP1,
+	.sensor_temp_mask	= SENSOR_TEMP1_CPU_TEMP_MASK,
+	.pdiv = 8,
+	.pdiv_ate = 8,
+	.pdiv_mask = SENSOR_PDIV_CPU_MASK,
+	.pllx_hotspot_diff = 10,
+	.pllx_hotspot_mask = SENSOR_HOTSPOT_CPU_MASK,
+};
+
+static const struct tegra_tsensor_group tegra124_tsensor_group_gpu = {
+	.id = TEGRA124_SOCTHERM_SENSOR_GPU,
+	.name = "gpu",
+	.sensor_temp_offset = SENSOR_TEMP1,
+	.sensor_temp_mask = SENSOR_TEMP1_GPU_TEMP_MASK,
+	.pdiv = 8,
+	.pdiv_ate = 8,
+	.pdiv_mask = SENSOR_PDIV_GPU_MASK,
+	.pllx_hotspot_diff = 5,
+	.pllx_hotspot_mask = SENSOR_HOTSPOT_GPU_MASK,
+};
+
+static const struct tegra_tsensor_group tegra124_tsensor_group_pll = {
+	.id = TEGRA124_SOCTHERM_SENSOR_PLLX,
+	.name = "pll",
+	.sensor_temp_offset = SENSOR_TEMP2,
+	.sensor_temp_mask = SENSOR_TEMP2_PLLX_TEMP_MASK,
+	.pdiv = 8,
+	.pdiv_ate = 8,
+	.pdiv_mask = SENSOR_PDIV_PLLX_MASK,
+};
+
+static const struct tegra_tsensor_group tegra124_tsensor_group_mem = {
+	.id = TEGRA124_SOCTHERM_SENSOR_MEM,
+	.name = "mem",
+	.sensor_temp_offset = SENSOR_TEMP2,
+	.sensor_temp_mask = SENSOR_TEMP2_MEM_TEMP_MASK,
+	.pdiv = 8,
+	.pdiv_ate = 8,
+	.pdiv_mask = SENSOR_PDIV_MEM_MASK,
+	.pllx_hotspot_diff = 0,
+	.pllx_hotspot_mask = SENSOR_HOTSPOT_MEM_MASK,
+};
+
+static const struct tegra_tsensor_group *tegra124_tsensor_groups[] = {
+	&tegra124_tsensor_group_cpu,
+	&tegra124_tsensor_group_gpu,
+	&tegra124_tsensor_group_pll,
+	&tegra124_tsensor_group_mem,
+};
+
+static const struct tegra_tsensor tegra124_tsensors[] = {
+	{
+		.name = "cpu0",
+		.base = 0xc0,
+		.config = &tegra124_tsensor_config,
+		.calib_fuse_offset = 0x098,
+		.fuse_corr_alpha = 1135400,
+		.fuse_corr_beta = -6266900,
+		.group = &tegra124_tsensor_group_cpu,
+	}, {
+		.name = "cpu1",
+		.base = 0xe0,
+		.config = &tegra124_tsensor_config,
+		.calib_fuse_offset = 0x084,
+		.fuse_corr_alpha = 1122220,
+		.fuse_corr_beta = -5700700,
+		.group = &tegra124_tsensor_group_cpu,
+	}, {
+		.name = "cpu2",
+		.base = 0x100,
+		.config = &tegra124_tsensor_config,
+		.calib_fuse_offset = 0x088,
+		.fuse_corr_alpha = 1127000,
+		.fuse_corr_beta = -6768200,
+		.group = &tegra124_tsensor_group_cpu,
+	}, {
+		.name = "cpu3",
+		.base = 0x120,
+		.config = &tegra124_tsensor_config,
+		.calib_fuse_offset = 0x12c,
+		.fuse_corr_alpha = 1110900,
+		.fuse_corr_beta = -6232000,
+		.group = &tegra124_tsensor_group_cpu,
+	}, {
+		.name = "mem0",
+		.base = 0x140,
+		.config = &tegra124_tsensor_config,
+		.calib_fuse_offset = 0x158,
+		.fuse_corr_alpha = 1122300,
+		.fuse_corr_beta = -5936400,
+		.group = &tegra124_tsensor_group_mem,
+	}, {
+		.name = "mem1",
+		.base = 0x160,
+		.config = &tegra124_tsensor_config,
+		.calib_fuse_offset = 0x15c,
+		.fuse_corr_alpha = 1145700,
+		.fuse_corr_beta = -7124600,
+		.group = &tegra124_tsensor_group_mem,
+	}, {
+		.name = "gpu",
+		.base = 0x180,
+		.config = &tegra124_tsensor_config,
+		.calib_fuse_offset = 0x154,
+		.fuse_corr_alpha = 1120100,
+		.fuse_corr_beta = -6000500,
+		.group = &tegra124_tsensor_group_gpu,
+	}, {
+		.name = "pllx",
+		.base = 0x1a0,
+		.config = &tegra124_tsensor_config,
+		.calib_fuse_offset = 0x160,
+		.fuse_corr_alpha = 1106500,
+		.fuse_corr_beta = -6729300,
+		.group = &tegra124_tsensor_group_pll,
+	},
+};
+
+/*
+ * Mask/shift bits in FUSE_TSENSOR_COMMON and
+ * FUSE_TSENSOR_COMMON, which are described in
+ * tegra_soctherm_fuse.c
+ */
+static const struct tegra_soctherm_fuse tegra124_soctherm_fuse = {
+	.fuse_base_cp_mask = 0x3ff,
+	.fuse_base_cp_shift = 0,
+	.fuse_base_ft_mask = 0x7ff << 10,
+	.fuse_base_ft_shift = 10,
+	.fuse_shift_ft_mask = 0x1f << 21,
+	.fuse_shift_ft_shift = 21,
+	.fuse_spare_realignment = 0x1fc,
+};
+
+const struct tegra_soctherm_soc tegra124_soctherm = {
+	.tsensors = tegra124_tsensors,
+	.num_tsensors = ARRAY_SIZE(tegra124_tsensors),
+	.ttgs = tegra124_tsensor_groups,
+	.num_ttgs = ARRAY_SIZE(tegra124_tsensor_groups),
+	.tfuse = &tegra124_soctherm_fuse,
+};
-- 
1.9.1
