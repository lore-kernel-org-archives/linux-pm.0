From: Lee Jones <lee.jones@linaro.org>
Subject: [PATCH v5 09/11] cpufreq: st: Provide runtime initialised driver for ST's platforms
Date: Tue,  8 Dec 2015 14:32:02 +0000
Message-ID: <1449585124-15596-10-git-send-email-lee.jones@linaro.org>
References: <1449585124-15596-1-git-send-email-lee.jones@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1449585124-15596-1-git-send-email-lee.jones@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc: kernel@stlinux.com, maxime.coquelin@st.com, viresh.kumar@linaro.org, linux-pm@vger.kernel.org, rjw@rjwysocki.net, devicetree@vger.kernel.org, ajitpal.singh@st.com, Lee Jones <lee.jones@linaro.org>
List-Id: linux-pm@vger.kernel.org

The bootloader is charged with the responsibility to provide platform
specific Dynamic Voltage and Frequency Scaling (DVFS) information via
Device Tree.  This driver takes the supplied configuration and
registers it with the new generic OPP framework, to then be used with
CPUFreq.

Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/cpufreq/Kconfig.arm   |   7 +
 drivers/cpufreq/Makefile      |   1 +
 drivers/cpufreq/sti-cpufreq.c | 296 ++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 304 insertions(+)
 create mode 100644 drivers/cpufreq/sti-cpufreq.c

diff --git a/drivers/cpufreq/Kconfig.arm b/drivers/cpufreq/Kconfig.arm
index 1582c1c..ccde41b 100644
--- a/drivers/cpufreq/Kconfig.arm
+++ b/drivers/cpufreq/Kconfig.arm
@@ -216,6 +216,13 @@ config ARM_SPEAR_CPUFREQ
 	help
 	  This adds the CPUFreq driver support for SPEAr SOCs.
 
+config ARM_STI_CPUFREQ
+	tristate "STi CPUFreq support"
+	depends on SOC_STIH407
+	help
+	  OPP list for cpufreq-dt driver can be provided through DT or can be
+	  created at runtime.  Select this if you want create OPP list at runtime.
+
 config ARM_TEGRA20_CPUFREQ
 	bool "Tegra20 CPUFreq support"
 	depends on ARCH_TEGRA
diff --git a/drivers/cpufreq/Makefile b/drivers/cpufreq/Makefile
index c0af1a1..9e63fb1 100644
--- a/drivers/cpufreq/Makefile
+++ b/drivers/cpufreq/Makefile
@@ -73,6 +73,7 @@ obj-$(CONFIG_ARM_SA1100_CPUFREQ)	+= sa1100-cpufreq.o
 obj-$(CONFIG_ARM_SA1110_CPUFREQ)	+= sa1110-cpufreq.o
 obj-$(CONFIG_ARM_SCPI_CPUFREQ)		+= scpi-cpufreq.o
 obj-$(CONFIG_ARM_SPEAR_CPUFREQ)		+= spear-cpufreq.o
+obj-$(CONFIG_ARM_STI_CPUFREQ)		+= sti-cpufreq.o
 obj-$(CONFIG_ARM_TEGRA20_CPUFREQ)	+= tegra20-cpufreq.o
 obj-$(CONFIG_ARM_TEGRA124_CPUFREQ)	+= tegra124-cpufreq.o
 obj-$(CONFIG_ARM_VEXPRESS_SPC_CPUFREQ)	+= vexpress-spc-cpufreq.o
diff --git a/drivers/cpufreq/sti-cpufreq.c b/drivers/cpufreq/sti-cpufreq.c
new file mode 100644
index 0000000..9f6807e
--- /dev/null
+++ b/drivers/cpufreq/sti-cpufreq.c
@@ -0,0 +1,296 @@
+/*
+ * Create CPUFreq OPP list
+ *
+ * Author: Ajit Pal Singh <ajitpal.singh@st.com>
+ *         Lee Jones <lee.jones@linaro.org>
+ *
+ * Copyright (C) 2015 STMicroelectronics (R&D) Limited
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the version 2 of the GNU General Public License as
+ * published by the Free Software Foundation
+ */
+
+#include <linux/cpu.h>
+#include <linux/clk.h>
+#include <linux/cpufreq.h>
+#include <linux/module.h>
+#include <linux/io.h>
+#include <linux/pm_opp.h>
+#include <linux/of.h>
+#include <linux/of_platform.h>
+#include <linux/mfd/syscon.h>
+#include <linux/platform_device.h>
+#include <linux/regmap.h>
+#include <linux/regulator/consumer.h>
+
+#define VERSION_ELEMENTS	3
+
+#define VERSION_SHIFT		28
+#define HW_INFO_INDEX		1
+#define MAJOR_ID_INDEX		1
+#define MINOR_ID_INDEX		2
+
+/* Only match on "suitable for ALL versions" entries */
+#define DEFAULT_VERSION		31
+
+enum {
+	PCODE = 0,
+	SUBSTRATE,
+	DVFS_MAX_REGFIELDS,
+};
+
+/**
+ * ST CPUFreq Driver Data
+ *
+ * @cpu_node		CPU's OF node
+ * @syscfg_eng		Engineering Syscon register map
+ * @regmap		Syscon register map
+ */
+struct st_cpufreq_ddata {
+	struct device *cpu;
+	struct regmap *syscfg_eng;
+	struct regmap *syscfg;
+};
+
+static int st_cpufreq_fetch_major(struct platform_device *pdev)
+{
+	struct st_cpufreq_ddata *ddata = platform_get_drvdata(pdev);
+	struct device_node *cpu_np = ddata->cpu->of_node;
+	unsigned int major_offset;
+	unsigned int socid;
+	int ret;
+
+	ret = of_property_read_u32_index(cpu_np, "st,syscfg",
+					 MAJOR_ID_INDEX, &major_offset);
+	if (ret) {
+		dev_err(&pdev->dev,
+			"No major number offset provided in %s [%d]\n",
+			cpu_np->full_name, ret);
+		return ret;
+	}
+
+	ret = regmap_read(ddata->syscfg, major_offset, &socid);
+	if (ret) {
+		dev_err(&pdev->dev,
+			"Failed to read the major number from syscon [%d]\n",
+			ret);
+		return ret;
+	}
+
+	return ((socid >> VERSION_SHIFT) & 0xf) + 1;
+}
+
+static int st_cpufreq_fetch_minor(struct platform_device *pdev)
+{
+	struct st_cpufreq_ddata *ddata = platform_get_drvdata(pdev);
+	struct device_node *cpu_np = ddata->cpu->of_node;
+	unsigned int minor_offset;
+	unsigned int minid;
+	int ret;
+
+	ret = of_property_read_u32_index(cpu_np, "st,syscfg-eng",
+					 MINOR_ID_INDEX, &minor_offset);
+	if (ret) {
+		dev_err(&pdev->dev,
+			"No minor number offset provided %s [%d]\n",
+			cpu_np->full_name, ret);
+		return ret;
+	}
+
+	ret = regmap_read(ddata->syscfg_eng, minor_offset, &minid);
+	if (ret) {
+		dev_err(&pdev->dev,
+			"Failed to read the minor number from syscon [%d]\n",
+			ret);
+		return ret;
+	}
+
+	return minid & 0xf;
+}
+
+static int st_cpufreq_fetch_regmap_field(struct platform_device *pdev,
+					 const struct reg_field *reg_fields,
+					 int hw_info_offset, int field)
+{
+	struct st_cpufreq_ddata *ddata = platform_get_drvdata(pdev);
+	struct regmap_field *regmap_field;
+	struct reg_field reg_field = reg_fields[field];
+	unsigned int value;
+	int ret;
+
+	reg_field.reg = hw_info_offset;
+	regmap_field = devm_regmap_field_alloc(&pdev->dev,
+					       ddata->syscfg_eng,
+					       reg_field);
+	if (IS_ERR(regmap_field)) {
+		dev_err(&pdev->dev, "Failed to allocate reg field\n");
+		return PTR_ERR(regmap_field);
+	}
+
+	ret = regmap_field_read(regmap_field, &value);
+	if (ret) {
+		dev_err(&pdev->dev, "Failed to read %s code\n",
+			field ? "SUBSTRATE" : "PCODE");
+		return ret;
+	}
+
+	return value;
+}
+
+static const struct reg_field sti_stih407_dvfs_regfields[DVFS_MAX_REGFIELDS] = {
+	[PCODE]		= REG_FIELD(0, 16, 19),
+	[SUBSTRATE]	= REG_FIELD(0, 0, 2),
+};
+
+static const struct reg_field *sti_cpufreq_match(struct platform_device *pdev)
+{
+	if (of_machine_is_compatible("st,stih407") ||
+	    of_machine_is_compatible("st,stih410"))
+		return sti_stih407_dvfs_regfields;
+
+	return NULL;
+}
+
+static int sti_cpufreq_set_opp_info(struct platform_device *pdev)
+{
+	struct st_cpufreq_ddata *ddata = platform_get_drvdata(pdev);
+	struct device_node *cpu_np = ddata->cpu->of_node;
+	const struct reg_field *reg_fields;
+	unsigned int hw_info_offset;
+	unsigned int version[VERSION_ELEMENTS];
+	int pcode, substrate, major, minor;
+	int ret;
+	char name[7];
+
+	reg_fields = sti_cpufreq_match(pdev);
+	if (!reg_fields) {
+		dev_warn(&pdev->dev, "Machine not supported\n");
+		return -ENODEV;
+	}
+
+	ret = of_property_read_u32_index(cpu_np, "st,syscfg-eng",
+					 HW_INFO_INDEX, &hw_info_offset);
+	if (ret) {
+		dev_warn(&pdev->dev, "Failed to read HW info offset from DT\n");
+		substrate = DEFAULT_VERSION;
+		pcode = 0;
+		goto use_defaults;
+	}
+
+	pcode = st_cpufreq_fetch_regmap_field(pdev, reg_fields,
+					      hw_info_offset,
+					      PCODE);
+	if (pcode < 0) {
+		dev_warn(&pdev->dev, "Failed to obtain process code\n");
+		/* Use default pcode */
+		pcode = 0;
+	}
+
+	substrate = st_cpufreq_fetch_regmap_field(pdev, reg_fields,
+						  hw_info_offset,
+						  SUBSTRATE);
+	if (substrate) {
+		dev_warn(&pdev->dev, "Failed to obtain substrate code\n");
+		/* Use default substrate */
+		substrate = DEFAULT_VERSION;
+	}
+
+use_defaults:
+	major = st_cpufreq_fetch_major(pdev);
+	if (major < 0) {
+		dev_err(&pdev->dev, "Failed to obtain major version\n");
+		/* Use default major number */
+		major = DEFAULT_VERSION;
+	}
+
+	minor = st_cpufreq_fetch_minor(pdev);
+	if (minor < 0) {
+		dev_err(&pdev->dev, "Failed to obtain minor version\n");
+		/* Use default minor number */
+		minor = DEFAULT_VERSION;
+	}
+
+	sprintf(name, "pcode%d", pcode);
+
+	ret = dev_pm_opp_set_prop_name(ddata->cpu, name);
+	if (ret) {
+		dev_err(&pdev->dev, "Failed to set prop name\n");
+		return ret;
+	}
+
+	version[0] = BIT(major);
+	version[1] = BIT(minor);
+	version[2] = BIT(substrate);
+
+	ret = dev_pm_opp_set_supported_hw(ddata->cpu,
+					  version, VERSION_ELEMENTS);
+	if (ret) {
+		dev_err(&pdev->dev, "Failed to set supported hardware\n");
+		return ret;
+	}
+
+	dev_err(&pdev->dev, "pcode: %d major: %d minor: %d substrate: %d\n",
+		pcode, major, minor, substrate);
+	dev_err(&pdev->dev, "version[0]: %x version[1]: %x version[2]: %x\n",
+		version[0], version[1], version[2]);
+
+	return 0;
+}
+
+static void sti_cpufreq_fetch_syscon_regsiters(struct platform_device *pdev)
+{
+	struct st_cpufreq_ddata *ddata = platform_get_drvdata(pdev);
+	struct device_node *cpu_np = ddata->cpu->of_node;
+
+	ddata->syscfg =
+		syscon_regmap_lookup_by_phandle(cpu_np, "st,syscfg");
+	if (IS_ERR(ddata->syscfg))
+		dev_warn(&pdev->dev,  "\"st,syscfg\" not supplied\n");
+
+	ddata->syscfg_eng =
+		syscon_regmap_lookup_by_phandle(cpu_np, "st,syscfg-eng");
+	if (IS_ERR(ddata->syscfg_eng))
+		dev_warn(&pdev->dev, "\"st,syscfg-eng\" not supplied\n");
+}
+
+static int sti_cpufreq_probe(struct platform_device *pdev)
+{
+	struct st_cpufreq_ddata *ddata;
+	int ret;
+
+	ddata = devm_kzalloc(&pdev->dev, sizeof(*ddata), GFP_KERNEL);
+	if (!ddata)
+		return -ENOMEM;
+
+	platform_set_drvdata(pdev, ddata);
+
+	ddata->cpu = get_cpu_device(0);
+	if (!ddata->cpu) {
+		dev_err(&pdev->dev, "Failed to get cpu0 device\n");
+		return -ENODEV;
+	}
+
+	sti_cpufreq_fetch_syscon_regsiters(pdev);
+
+	ret = sti_cpufreq_set_opp_info(pdev);
+	if (ret)
+		dev_warn(&pdev->dev, "Not doing voltage scaling\n");
+
+	platform_device_register_simple("cpufreq-dt", -1, NULL, 0);
+
+	return 0;
+}
+
+static struct platform_driver sti_cpufreq = {
+	.driver = {
+		.name = "sti-cpufreq",
+	},
+	.probe = sti_cpufreq_probe,
+};
+module_platform_driver(sti_cpufreq);
+
+MODULE_DESCRIPTION("STMicroelectronics CPUFreq/OPP driver");
+MODULE_AUTHOR("Ajitpal Singh <ajitpal.singh@st.com>");
+MODULE_AUTHOR("Lee Jones <lee.jones@linaro.org>");
+MODULE_LICENSE("GPL v2");
-- 
1.9.1
