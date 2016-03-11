From: Wei Ni <wni@nvidia.com>
Subject: [PATCH V7 05/12] thermal: tegra: add Tegra210 specific SOC_THERM driver
Date: Fri, 11 Mar 2016 11:10:25 +0800
Message-ID: <1457665825-29837-1-git-send-email-wni@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: rui.zhang@intel.com, edubezval@gmail.com, thierry.reding@gmail.com
Cc: MLongnecker@nvidia.com, swarren@wwwdotorg.org, mikko.perttunen@kapsi.fi, linux-tegra@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Wei Ni <wni@nvidia.com>
List-Id: linux-pm@vger.kernel.org

Add Tegra210 specific SOC_THERM driver.

Signed-off-by: Wei Ni <wni@nvidia.com>
---
 drivers/thermal/tegra/Makefile            |   1 +
 drivers/thermal/tegra/soctherm-fuse.c     |  11 ++
 drivers/thermal/tegra/soctherm.c          |   6 ++
 drivers/thermal/tegra/soctherm.h          |   4 +
 drivers/thermal/tegra/tegra210-soctherm.c | 173 ++++++++++++++++++++++++++++++
 5 files changed, 195 insertions(+)
 create mode 100644 drivers/thermal/tegra/tegra210-soctherm.c

diff --git a/drivers/thermal/tegra/Makefile b/drivers/thermal/tegra/Makefile
index d5fb15377b97..bf9e028eba28 100644
--- a/drivers/thermal/tegra/Makefile
+++ b/drivers/thermal/tegra/Makefile
@@ -2,3 +2,4 @@ obj-$(CONFIG_TEGRA_SOCTHERM)	+= tegra-soctherm.o
 
 tegra-soctherm-y				:= soctherm.o soctherm-fuse.o
 tegra-soctherm-$(CONFIG_ARCH_TEGRA_124_SOC)	+= tegra124-soctherm.o
+tegra-soctherm-$(CONFIG_ARCH_TEGRA_210_SOC)	+= tegra210-soctherm.o
diff --git a/drivers/thermal/tegra/soctherm-fuse.c b/drivers/thermal/tegra/soctherm-fuse.c
index 931c299ab0e8..29963180c453 100644
--- a/drivers/thermal/tegra/soctherm-fuse.c
+++ b/drivers/thermal/tegra/soctherm-fuse.c
@@ -28,7 +28,18 @@
 #define FUSE_TSENSOR_COMMON			0x180
 
 /*
+ * Tegra210: Layout of bits in FUSE_TSENSOR_COMMON:
+ *    3                   2                   1                   0
+ *  1 0 9 8 7 6 5 4 3 2 1 0 9 8 7 6 5 4 3 2 1 0 9 8 7 6 5 4 3 2 1 0
+ * +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
+ * |       BASE_FT       |      BASE_CP      | SHFT_FT | SHIFT_CP  |
+ * +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
+ *
  * Tegra12x, etc:
+ * In chips prior to Tegra210, this fuse was incorrectly sized as 26 bits,
+ * and didn't hold SHIFT_CP in [31:26]. Therefore these missing six bits
+ * were obtained via the FUSE_SPARE_REALIGNMENT_REG register [5:0].
+ *
  * FUSE_TSENSOR_COMMON:
  *    3                   2                   1                   0
  *  1 0 9 8 7 6 5 4 3 2 1 0 9 8 7 6 5 4 3 2 1 0 9 8 7 6 5 4 3 2 1 0
diff --git a/drivers/thermal/tegra/soctherm.c b/drivers/thermal/tegra/soctherm.c
index f56e5a11384e..52a33760e8e8 100644
--- a/drivers/thermal/tegra/soctherm.c
+++ b/drivers/thermal/tegra/soctherm.c
@@ -147,6 +147,12 @@ static const struct of_device_id tegra_soctherm_of_match[] = {
 		.data = &tegra124_soctherm,
 	},
 #endif
+#ifdef CONFIG_ARCH_TEGRA_210_SOC
+	{
+		.compatible = "nvidia,tegra210-soctherm",
+		.data = &tegra210_soctherm,
+	},
+#endif
 	{ },
 };
 MODULE_DEVICE_TABLE(of, tegra_soctherm_of_match);
diff --git a/drivers/thermal/tegra/soctherm.h b/drivers/thermal/tegra/soctherm.h
index f80ee1492ddb..69d317269af1 100644
--- a/drivers/thermal/tegra/soctherm.h
+++ b/drivers/thermal/tegra/soctherm.h
@@ -106,5 +106,9 @@ int tegra_calc_tsensor_calib(const struct tegra_tsensor *sensor,
 extern const struct tegra_soctherm_soc tegra124_soctherm;
 #endif
 
+#ifdef CONFIG_ARCH_TEGRA_210_SOC
+extern const struct tegra_soctherm_soc tegra210_soctherm;
+#endif
+
 #endif
 
diff --git a/drivers/thermal/tegra/tegra210-soctherm.c b/drivers/thermal/tegra/tegra210-soctherm.c
new file mode 100644
index 000000000000..0e76a89c557d
--- /dev/null
+++ b/drivers/thermal/tegra/tegra210-soctherm.c
@@ -0,0 +1,173 @@
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
+#include <dt-bindings/thermal/tegra124-soctherm.h>
+
+#include "soctherm.h"
+
+static const struct tegra_tsensor_configuration tegra210_tsensor_config = {
+	.tall = 16300,
+	.tiddq_en = 1,
+	.ten_count = 1,
+	.tsample = 120,
+	.tsample_ate = 480,
+};
+
+static const struct tegra_tsensor_group tegra210_tsensor_group_cpu = {
+	.id = TEGRA124_SOCTHERM_SENSOR_CPU,
+	.name = "cpu",
+	.sensor_temp_offset = SENSOR_TEMP1,
+	.sensor_temp_mask = SENSOR_TEMP1_CPU_TEMP_MASK,
+	.pdiv = 8,
+	.pdiv_ate = 8,
+	.pdiv_mask = SENSOR_PDIV_CPU_MASK,
+	.pllx_hotspot_diff = 10,
+	.pllx_hotspot_mask = SENSOR_HOTSPOT_CPU_MASK,
+};
+
+static const struct tegra_tsensor_group tegra210_tsensor_group_gpu = {
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
+static const struct tegra_tsensor_group tegra210_tsensor_group_pll = {
+	.id = TEGRA124_SOCTHERM_SENSOR_PLLX,
+	.name = "pll",
+	.sensor_temp_offset = SENSOR_TEMP2,
+	.sensor_temp_mask = SENSOR_TEMP2_PLLX_TEMP_MASK,
+	.pdiv = 8,
+	.pdiv_ate = 8,
+	.pdiv_mask = SENSOR_PDIV_PLLX_MASK,
+};
+
+static const struct tegra_tsensor_group tegra210_tsensor_group_mem = {
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
+static const struct tegra_tsensor_group *tegra210_tsensor_groups[] = {
+	&tegra210_tsensor_group_cpu,
+	&tegra210_tsensor_group_gpu,
+	&tegra210_tsensor_group_pll,
+	&tegra210_tsensor_group_mem,
+};
+
+static const struct tegra_tsensor tegra210_tsensors[] = {
+	{
+		.name = "cpu0",
+		.base = 0xc0,
+		.config = &tegra210_tsensor_config,
+		.calib_fuse_offset = 0x098,
+		.fuse_corr_alpha = 1085000,
+		.fuse_corr_beta = 3244200,
+		.group = &tegra210_tsensor_group_cpu,
+	}, {
+		.name = "cpu1",
+		.base = 0xe0,
+		.config = &tegra210_tsensor_config,
+		.calib_fuse_offset = 0x084,
+		.fuse_corr_alpha = 1126200,
+		.fuse_corr_beta = -67500,
+		.group = &tegra210_tsensor_group_cpu,
+	}, {
+		.name = "cpu2",
+		.base = 0x100,
+		.config = &tegra210_tsensor_config,
+		.calib_fuse_offset = 0x088,
+		.fuse_corr_alpha = 1098400,
+		.fuse_corr_beta = 2251100,
+		.group = &tegra210_tsensor_group_cpu,
+	}, {
+		.name = "cpu3",
+		.base = 0x120,
+		.config = &tegra210_tsensor_config,
+		.calib_fuse_offset = 0x12c,
+		.fuse_corr_alpha = 1108000,
+		.fuse_corr_beta = 602700,
+		.group = &tegra210_tsensor_group_cpu,
+	}, {
+		.name = "mem0",
+		.base = 0x140,
+		.config = &tegra210_tsensor_config,
+		.calib_fuse_offset = 0x158,
+		.fuse_corr_alpha = 1069200,
+		.fuse_corr_beta = 3549900,
+		.group = &tegra210_tsensor_group_mem,
+	}, {
+		.name = "mem1",
+		.base = 0x160,
+		.config = &tegra210_tsensor_config,
+		.calib_fuse_offset = 0x15c,
+		.fuse_corr_alpha = 1173700,
+		.fuse_corr_beta = -6263600,
+		.group = &tegra210_tsensor_group_mem,
+	}, {
+		.name = "gpu",
+		.base = 0x180,
+		.config = &tegra210_tsensor_config,
+		.calib_fuse_offset = 0x154,
+		.fuse_corr_alpha = 1074300,
+		.fuse_corr_beta = 2734900,
+		.group = &tegra210_tsensor_group_gpu,
+	}, {
+		.name = "pllx",
+		.base = 0x1a0,
+		.config = &tegra210_tsensor_config,
+		.calib_fuse_offset = 0x160,
+		.fuse_corr_alpha = 1039700,
+		.fuse_corr_beta = 6829100,
+		.group = &tegra210_tsensor_group_pll,
+	},
+};
+
+/*
+ * Mask/shift bits in FUSE_TSENSOR_COMMON and
+ * FUSE_TSENSOR_COMMON, which are described in
+ * tegra_soctherm_fuse.c
+ */
+static const struct tegra_soctherm_fuse tegra210_soctherm_fuse = {
+	.fuse_base_cp_mask = 0x3ff << 11,
+	.fuse_base_cp_shift = 11,
+	.fuse_base_ft_mask = 0x7ff << 21,
+	.fuse_base_ft_shift = 21,
+	.fuse_shift_ft_mask = 0x1f << 6,
+	.fuse_shift_ft_shift = 6,
+	.fuse_spare_realignment = 0,
+};
+
+const struct tegra_soctherm_soc tegra210_soctherm = {
+	.tsensors = tegra210_tsensors,
+	.num_tsensors = ARRAY_SIZE(tegra210_tsensors),
+	.ttgs = tegra210_tsensor_groups,
+	.num_ttgs = ARRAY_SIZE(tegra210_tsensor_groups),
+	.tfuse = &tegra210_soctherm_fuse,
+};
-- 
1.9.1
