From: Wei Ni <wni@nvidia.com>
Subject: [PATCH v2 1/9] thermal: tegra: add Tegra132 specific SOC_THERM driver
Date: Wed, 27 Apr 2016 11:25:46 +0800
Message-ID: <1461727554-15065-2-git-send-email-wni@nvidia.com>
References: <1461727554-15065-1-git-send-email-wni@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1461727554-15065-1-git-send-email-wni@nvidia.com>
Sender: linux-kernel-owner@vger.kernel.org
To: edubezval@gmail.com, thierry.reding@gmail.com, robh+dt@kernel.org, rui.zhang@intel.com
Cc: MLongnecker@nvidia.com, swarren@wwwdotorg.org, mikko.perttunen@kapsi.fi, linux-tegra@vger.kernel.org, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Wei Ni <wni@nvidia.com>
List-Id: linux-pm@vger.kernel.org

add Tegra132 specific SOC_THERM driver.

Signed-off-by: Wei Ni <wni@nvidia.com>
---
 drivers/thermal/tegra/Makefile            |   1 +
 drivers/thermal/tegra/soctherm.c          |   6 +
 drivers/thermal/tegra/soctherm.h          |   4 +
 drivers/thermal/tegra/tegra132-soctherm.c | 196 ++++++++++++++++++++++++++++++
 4 files changed, 207 insertions(+)
 create mode 100644 drivers/thermal/tegra/tegra132-soctherm.c

diff --git a/drivers/thermal/tegra/Makefile b/drivers/thermal/tegra/Makefile
index bf9e028eba28..1ce1af2cf0f5 100644
--- a/drivers/thermal/tegra/Makefile
+++ b/drivers/thermal/tegra/Makefile
@@ -2,4 +2,5 @@ obj-$(CONFIG_TEGRA_SOCTHERM)	+= tegra-soctherm.o
 
 tegra-soctherm-y				:= soctherm.o soctherm-fuse.o
 tegra-soctherm-$(CONFIG_ARCH_TEGRA_124_SOC)	+= tegra124-soctherm.o
+tegra-soctherm-$(CONFIG_ARCH_TEGRA_132_SOC)	+= tegra132-soctherm.o
 tegra-soctherm-$(CONFIG_ARCH_TEGRA_210_SOC)	+= tegra210-soctherm.o
diff --git a/drivers/thermal/tegra/soctherm.c b/drivers/thermal/tegra/soctherm.c
index 2b0417d7b754..b8651726201e 100644
--- a/drivers/thermal/tegra/soctherm.c
+++ b/drivers/thermal/tegra/soctherm.c
@@ -484,6 +484,12 @@ static const struct of_device_id tegra_soctherm_of_match[] = {
 		.data = &tegra124_soctherm,
 	},
 #endif
+#ifdef CONFIG_ARCH_TEGRA_132_SOC
+	{
+		.compatible = "nvidia,tegra132-soctherm",
+		.data = &tegra132_soctherm,
+	},
+#endif
 #ifdef CONFIG_ARCH_TEGRA_210_SOC
 	{
 		.compatible = "nvidia,tegra210-soctherm",
diff --git a/drivers/thermal/tegra/soctherm.h b/drivers/thermal/tegra/soctherm.h
index f6dbbba80367..28e18ec4b4c3 100644
--- a/drivers/thermal/tegra/soctherm.h
+++ b/drivers/thermal/tegra/soctherm.h
@@ -115,6 +115,10 @@ int tegra_calc_tsensor_calib(const struct tegra_tsensor *sensor,
 extern const struct tegra_soctherm_soc tegra124_soctherm;
 #endif
 
+#ifdef CONFIG_ARCH_TEGRA_132_SOC
+extern const struct tegra_soctherm_soc tegra132_soctherm;
+#endif
+
 #ifdef CONFIG_ARCH_TEGRA_210_SOC
 extern const struct tegra_soctherm_soc tegra210_soctherm;
 #endif
diff --git a/drivers/thermal/tegra/tegra132-soctherm.c b/drivers/thermal/tegra/tegra132-soctherm.c
new file mode 100644
index 000000000000..e2aa84e1b307
--- /dev/null
+++ b/drivers/thermal/tegra/tegra132-soctherm.c
@@ -0,0 +1,196 @@
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
+#define TEGRA132_THERMTRIP_ANY_EN_MASK		(0x1 << 28)
+#define TEGRA132_THERMTRIP_MEM_EN_MASK		(0x1 << 27)
+#define TEGRA132_THERMTRIP_GPU_EN_MASK		(0x1 << 26)
+#define TEGRA132_THERMTRIP_CPU_EN_MASK		(0x1 << 25)
+#define TEGRA132_THERMTRIP_TSENSE_EN_MASK	(0x1 << 24)
+#define TEGRA132_THERMTRIP_GPUMEM_THRESH_MASK	(0xff << 16)
+#define TEGRA132_THERMTRIP_CPU_THRESH_MASK	(0xff << 8)
+#define TEGRA132_THERMTRIP_TSENSE_THRESH_MASK	0xff
+
+#define TEGRA132_THRESH_GRAIN			1000
+
+static const struct tegra_tsensor_configuration tegra132_tsensor_config = {
+	.tall = 16300,
+	.tiddq_en = 1,
+	.ten_count = 1,
+	.tsample = 120,
+	.tsample_ate = 480,
+};
+
+static const struct tegra_tsensor_group tegra132_tsensor_group_cpu = {
+	.id = TEGRA124_SOCTHERM_SENSOR_CPU,
+	.name = "cpu",
+	.sensor_temp_offset = SENSOR_TEMP1,
+	.sensor_temp_mask = SENSOR_TEMP1_CPU_TEMP_MASK,
+	.pdiv = 8,
+	.pdiv_ate = 8,
+	.pdiv_mask = SENSOR_PDIV_CPU_MASK,
+	.pllx_hotspot_diff = 10,
+	.pllx_hotspot_mask = SENSOR_HOTSPOT_CPU_MASK,
+	.thermtrip_any_en_mask = TEGRA132_THERMTRIP_ANY_EN_MASK,
+	.thermtrip_enable_mask = TEGRA132_THERMTRIP_CPU_EN_MASK,
+	.thermtrip_threshold_mask = TEGRA132_THERMTRIP_CPU_THRESH_MASK,
+};
+
+static const struct tegra_tsensor_group tegra132_tsensor_group_gpu = {
+	.id = TEGRA124_SOCTHERM_SENSOR_GPU,
+	.name = "gpu",
+	.sensor_temp_offset = SENSOR_TEMP1,
+	.sensor_temp_mask = SENSOR_TEMP1_GPU_TEMP_MASK,
+	.pdiv = 8,
+	.pdiv_ate = 8,
+	.pdiv_mask = SENSOR_PDIV_GPU_MASK,
+	.pllx_hotspot_diff = 5,
+	.pllx_hotspot_mask = SENSOR_HOTSPOT_GPU_MASK,
+	.thermtrip_any_en_mask = TEGRA132_THERMTRIP_ANY_EN_MASK,
+	.thermtrip_enable_mask = TEGRA132_THERMTRIP_GPU_EN_MASK,
+	.thermtrip_threshold_mask = TEGRA132_THERMTRIP_GPUMEM_THRESH_MASK,
+};
+
+static const struct tegra_tsensor_group tegra132_tsensor_group_pll = {
+	.id = TEGRA124_SOCTHERM_SENSOR_PLLX,
+	.name = "pll",
+	.sensor_temp_offset = SENSOR_TEMP2,
+	.sensor_temp_mask = SENSOR_TEMP2_PLLX_TEMP_MASK,
+	.pdiv = 8,
+	.pdiv_ate = 8,
+	.pdiv_mask = SENSOR_PDIV_PLLX_MASK,
+	.thermtrip_any_en_mask = TEGRA132_THERMTRIP_ANY_EN_MASK,
+	.thermtrip_enable_mask = TEGRA132_THERMTRIP_TSENSE_EN_MASK,
+	.thermtrip_threshold_mask = TEGRA132_THERMTRIP_TSENSE_THRESH_MASK,
+};
+
+static const struct tegra_tsensor_group tegra132_tsensor_group_mem = {
+	.id = TEGRA124_SOCTHERM_SENSOR_MEM,
+	.name = "mem",
+	.sensor_temp_offset = SENSOR_TEMP2,
+	.sensor_temp_mask = SENSOR_TEMP2_MEM_TEMP_MASK,
+	.pdiv = 8,
+	.pdiv_ate = 8,
+	.pdiv_mask = SENSOR_PDIV_MEM_MASK,
+	.pllx_hotspot_diff = 0,
+	.pllx_hotspot_mask = SENSOR_HOTSPOT_MEM_MASK,
+	.thermtrip_any_en_mask = TEGRA132_THERMTRIP_ANY_EN_MASK,
+	.thermtrip_enable_mask = TEGRA132_THERMTRIP_MEM_EN_MASK,
+	.thermtrip_threshold_mask = TEGRA132_THERMTRIP_GPUMEM_THRESH_MASK,
+};
+
+static const struct tegra_tsensor_group *tegra132_tsensor_groups[] = {
+	&tegra132_tsensor_group_cpu,
+	&tegra132_tsensor_group_gpu,
+	&tegra132_tsensor_group_pll,
+	&tegra132_tsensor_group_mem,
+};
+
+static struct tegra_tsensor tegra132_tsensors[] = {
+	{
+		.name = "cpu0",
+		.base = 0xc0,
+		.config = &tegra132_tsensor_config,
+		.calib_fuse_offset = 0x098,
+		.fuse_corr_alpha = 1126600,
+		.fuse_corr_beta = -9433500,
+		.group = &tegra132_tsensor_group_cpu,
+	}, {
+		.name = "cpu1",
+		.base = 0xe0,
+		.config = &tegra132_tsensor_config,
+		.calib_fuse_offset = 0x084,
+		.fuse_corr_alpha = 1110800,
+		.fuse_corr_beta = -7383000,
+		.group = &tegra132_tsensor_group_cpu,
+	}, {
+		.name = "cpu2",
+		.base = 0x100,
+		.config = &tegra132_tsensor_config,
+		.calib_fuse_offset = 0x088,
+		.fuse_corr_alpha = 1113800,
+		.fuse_corr_beta = -6215200,
+		.group = &tegra132_tsensor_group_cpu,
+	}, {
+		.name = "cpu3",
+		.base = 0x120,
+		.config = &tegra132_tsensor_config,
+		.calib_fuse_offset = 0x12c,
+		.fuse_corr_alpha = 1129600,
+		.fuse_corr_beta = -8196100,
+		.group = &tegra132_tsensor_group_cpu,
+	}, {
+		.name = "mem0",
+		.base = 0x140,
+		.config = &tegra132_tsensor_config,
+		.calib_fuse_offset = 0x158,
+		.fuse_corr_alpha = 1132900,
+		.fuse_corr_beta = -6755300,
+		.group = &tegra132_tsensor_group_mem,
+	}, {
+		.name = "mem1",
+		.base = 0x160,
+		.config = &tegra132_tsensor_config,
+		.calib_fuse_offset = 0x15c,
+		.fuse_corr_alpha = 1142300,
+		.fuse_corr_beta = -7374200,
+		.group = &tegra132_tsensor_group_mem,
+	}, {
+		.name = "gpu",
+		.base = 0x180,
+		.config = &tegra132_tsensor_config,
+		.calib_fuse_offset = 0x154,
+		.fuse_corr_alpha = 1125100,
+		.fuse_corr_beta = -6350400,
+		.group = &tegra132_tsensor_group_gpu,
+	}, {
+		.name = "pllx",
+		.base = 0x1a0,
+		.config = &tegra132_tsensor_config,
+		.calib_fuse_offset = 0x160,
+		.fuse_corr_alpha = 1118100,
+		.fuse_corr_beta = -8208800,
+		.group = &tegra132_tsensor_group_pll,
+	},
+};
+
+/*
+ * Mask/shift bits in FUSE_TSENSOR_COMMON and
+ * FUSE_TSENSOR_COMMON, which are described in
+ * tegra_soctherm_fuse.c
+ */
+static const struct tegra_soctherm_fuse tegra132_soctherm_fuse = {
+	.fuse_base_cp_mask = 0x3ff,
+	.fuse_base_cp_shift = 0,
+	.fuse_base_ft_mask = 0x7ff << 10,
+	.fuse_base_ft_shift = 10,
+	.fuse_shift_ft_mask = 0x1f << 21,
+	.fuse_shift_ft_shift = 21,
+	.fuse_spare_realignment = 0x1fc,
+};
+
+const struct tegra_soctherm_soc tegra132_soctherm = {
+	.tsensors = tegra132_tsensors,
+	.num_tsensors = ARRAY_SIZE(tegra132_tsensors),
+	.ttgs = tegra132_tsensor_groups,
+	.num_ttgs = ARRAY_SIZE(tegra132_tsensor_groups),
+	.tfuse = &tegra132_soctherm_fuse,
+	.thresh_grain = TEGRA132_THRESH_GRAIN,
+};
-- 
1.9.1
