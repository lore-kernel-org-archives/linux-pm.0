From: Lee Jones <lee.jones@linaro.org>
Subject: [PATCH 7/8] cpufreq: st: Provide runtime initialised driver for ST's platforms
Date: Mon, 22 Jun 2015 16:43:56 +0100
Message-ID: <1434987837-24212-8-git-send-email-lee.jones@linaro.org>
References: <1434987837-24212-1-git-send-email-lee.jones@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wg0-f46.google.com ([74.125.82.46]:32996 "EHLO
	mail-wg0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754191AbbFVPoP (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 22 Jun 2015 11:44:15 -0400
Received: by wgck11 with SMTP id k11so17799692wgc.0
        for <linux-pm@vger.kernel.org>; Mon, 22 Jun 2015 08:44:13 -0700 (PDT)
In-Reply-To: <1434987837-24212-1-git-send-email-lee.jones@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc: kernel@stlinux.com, rjw@rjwysocki.net, viresh.kumar@linaro.org, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, ajitpal.singh@st.com, Lee Jones <lee.jones@linaro.org>

The bootloader is charged with the responsibility to provide platform
specific Dynamic Voltage and Frequency Scaling (DVFS) information via
Device Tree.  This driver takes the supplied configuration and loads
it into the generic OPP subsystem to it can be used as part of the
CPUFreq framework.

Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/cpufreq/Kconfig.arm  |   7 +
 drivers/cpufreq/Makefile     |   1 +
 drivers/cpufreq/st-cpufreq.c | 450 +++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 458 insertions(+)
 create mode 100644 drivers/cpufreq/st-cpufreq.c

diff --git a/drivers/cpufreq/Kconfig.arm b/drivers/cpufreq/Kconfig.arm
index 4f3dbc8..1408884 100644
--- a/drivers/cpufreq/Kconfig.arm
+++ b/drivers/cpufreq/Kconfig.arm
@@ -258,6 +258,13 @@ config ARM_SPEAR_CPUFREQ
 	help
 	  This adds the CPUFreq driver support for SPEAr SOCs.
 
+config ARM_ST_CPUFREQ
+	bool "ST CPUFreq support"
+	depends on SOC_STIH407
+	help
+	  OPP list for cpufreq-dt driver can be provided through DT or can be
+	  created at runtime.  Select this if you want create OPP list at runtime.
+
 config ARM_TEGRA_CPUFREQ
 	bool "TEGRA CPUFreq support"
 	depends on ARCH_TEGRA
diff --git a/drivers/cpufreq/Makefile b/drivers/cpufreq/Makefile
index cdce92a..7d3f47b 100644
--- a/drivers/cpufreq/Makefile
+++ b/drivers/cpufreq/Makefile
@@ -77,6 +77,7 @@ obj-$(CONFIG_ARM_S5PV210_CPUFREQ)	+= s5pv210-cpufreq.o
 obj-$(CONFIG_ARM_SA1100_CPUFREQ)	+= sa1100-cpufreq.o
 obj-$(CONFIG_ARM_SA1110_CPUFREQ)	+= sa1110-cpufreq.o
 obj-$(CONFIG_ARM_SPEAR_CPUFREQ)		+= spear-cpufreq.o
+obj-$(CONFIG_ARM_ST_CPUFREQ)		+= st-cpufreq.o
 obj-$(CONFIG_ARM_TEGRA_CPUFREQ)		+= tegra-cpufreq.o
 obj-$(CONFIG_ARM_VEXPRESS_SPC_CPUFREQ)	+= vexpress-spc-cpufreq.o
 
diff --git a/drivers/cpufreq/st-cpufreq.c b/drivers/cpufreq/st-cpufreq.c
new file mode 100644
index 0000000..167062f
--- /dev/null
+++ b/drivers/cpufreq/st-cpufreq.c
@@ -0,0 +1,450 @@
+/*
+ * Create CPUFreq OPP list
+ *
+ * Author: Ajit Pal Singh <ajitpal.singh@st.com>
+ *         Lee Jones <lee.jones@linaro.org>
+ *
+ * Copyright (C) 2015 STMicroelectronics (R&D) Limited
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ */
+
+#include <linux/cpu.h>
+#include <linux/clk.h>
+#include <linux/module.h>
+#include <linux/io.h>
+#include <linux/pm_opp.h>
+#include <linux/of.h>
+#include <linux/of_platform.h>
+#include <linux/mfd/syscon.h>
+#include <linux/platform_device.h>
+#include <linux/regmap.h>
+#include <linux/regulator/consumer.h>
+#include <linux/sort.h>
+
+#include <linux/cpufreq.h>
+
+#define VERSION_SHIFT		28
+#define PCODE_INDEX		1
+#define MAJOR_ID_INDEX		1
+#define MINOR_ID_INDEX		2
+
+enum {
+	PCODE = 0,
+	SUBSTRATE,
+	DVFS_MAX_REGFIELDS,
+};
+
+#define STI_DVFS_TAB_MAX	8
+
+struct st_dvfs_tab {
+	unsigned int freq;
+	unsigned int avs;
+};
+
+/**
+ * ST CPUFreq Driver Data
+ *
+ * @dvfs_tab		Supported Voltage/Frequency table
+ * @dvfs_tab_count	Number of entries in the table above
+ * @pcode		Device's Process Code determines the running voltage
+ * @substrate		Device's Substrate version -- as above
+ * @regmap_eng		Engineering Syscon register map
+ *
+ */
+struct st_cpufreq_ddata {
+	struct st_dvfs_tab dvfs_tab[STI_DVFS_TAB_MAX];
+	int dvfs_tab_count;
+	int pcode;
+	int substrate;
+	struct regmap *regmap_eng;
+
+};
+
+struct sti_dvfs_cdata {
+	const struct reg_field *reg_fields;
+};
+
+static int st_cpufreq_cmp(const void *a, const void *b)
+{
+	const struct st_dvfs_tab *a_tab = a, *b_tab = b;
+
+	if (a_tab->freq > b_tab->freq)
+		return -1;
+
+	if (a_tab->freq < b_tab->freq)
+		return 1;
+
+	return 0;
+}
+
+static int st_cpufreq_check_if_matches(struct device_node *child,
+				       const char *prop,
+				       unsigned int match)
+{
+	unsigned int dt_major, dt_minor;
+	unsigned int soc_major, soc_minor;
+	const __be32 *tmp;
+	unsigned int val;
+	int len = 0;
+	int i;
+
+	tmp = of_get_property(child, prop , &len);
+	if (!tmp || !len)
+		return -EINVAL;
+
+	val = be32_to_cpup(tmp);
+
+	len /= sizeof(u32);
+	if (len == 1 && val == 0xff)
+		/*
+		 * If 'cuts' or 'substrate' value is 0xff, it means that
+		 * the entry is valid for ALL cuts and substrates
+		 */
+		goto matchfound;
+
+	/* Check if this opp node is for us */
+	for (i = 0; i < len; i++) {
+		if (match == val)
+			goto matchfound;
+
+		if (!strcmp(prop, "st,cuts")) {
+			dt_major  = val & 0xff;;
+			dt_minor  = val >> 8 & 0xff;
+			soc_major = match & 0xff;
+			soc_minor = match >> 8 & 0xff;
+
+			if (dt_major == soc_major &&
+			    (!dt_minor || (dt_minor == soc_minor)))
+				goto matchfound;
+		}
+		val++;
+	}
+
+	/* No match found */
+	return -EINVAL;
+
+matchfound:
+	return 0;
+}
+
+static int st_cpufreq_get_version(struct platform_device *pdev,
+				  unsigned int *minor, unsigned int *major)
+{
+	struct st_cpufreq_ddata *ddata = platform_get_drvdata(pdev);
+	struct device_node *np = pdev->dev.of_node;
+	struct regmap *syscfg_regmap;
+	unsigned int minor_offset, major_offset;
+	unsigned int socid, minid;
+	int ret;
+
+	/* Get Major */
+	syscfg_regmap = syscon_regmap_lookup_by_phandle(np, "st,syscfg");
+	if (IS_ERR(syscfg_regmap)) {
+		dev_err(&pdev->dev,
+			"No syscfg phandle specified in %s [%li]\n",
+			np->full_name, PTR_ERR(syscfg_regmap));
+		return PTR_ERR(syscfg_regmap);
+	}
+
+	ret = of_property_read_u32_index(np, "st,syscfg",
+					 MAJOR_ID_INDEX, &major_offset);
+	if (ret) {
+		dev_err(&pdev->dev,
+			"No minor number offset provided in %s [%d]\n",
+			np->full_name, ret);
+		return ret;
+	}
+
+	ret = regmap_read(syscfg_regmap, major_offset, &socid);
+	if (ret)
+		return ret;
+
+	/* Get Minor */
+	ret = of_property_read_u32_index(np, "st,syscfg-eng",
+					 MINOR_ID_INDEX, &minor_offset);
+	if (ret) {
+		dev_err(&pdev->dev, "No minor number offset provided %s [%d]\n",
+			np->full_name, ret);
+		return ret;
+	}
+
+	ret = regmap_read(ddata->regmap_eng, minor_offset, &minid);
+	if (ret) {
+		dev_err(&pdev->dev,
+			"Failed to read the minor number from syscon [%d]\n",
+			ret);
+		return ret;
+	}
+
+	*major = ((socid >> VERSION_SHIFT) & 0xf) + 1;
+	*minor = minid & 0xf;
+
+	return 0;
+}
+
+static int st_cpufreq_get_dvfs_info(struct platform_device *pdev)
+{
+	struct st_cpufreq_ddata *ddata = platform_get_drvdata(pdev);
+	struct st_dvfs_tab *dvfs_tab = &ddata->dvfs_tab[0];
+	struct device_node *np = pdev->dev.of_node;
+	struct device_node *opplist, *opp;
+	unsigned int minor = 0, major = 0;
+	int err, ret = 0;
+
+	opplist = of_get_child_by_name(np, "opp-list");
+	if (!opplist) {
+		dev_err(&pdev->dev, "opp-list node missing\n");
+		return -ENODATA;
+	}
+
+	ret = st_cpufreq_get_version(pdev, &minor, &major);
+	if (ret) {
+		dev_err(&pdev->dev, "No OPP match found for this platform\n");
+		return ret;
+	}
+
+	for_each_child_of_node(opplist, opp) {
+		if (ddata->dvfs_tab_count == STI_DVFS_TAB_MAX) {
+			dev_err(&pdev->dev, "Too many DVFS entries found\n");
+			ret = -EOVERFLOW;
+			break;
+		}
+
+		/* Cut version e.g. 2.0 [major.minor] */
+		err = st_cpufreq_check_if_matches(opp, "st,cuts",
+						  (minor << 8) | major);
+		if (err)
+			continue;
+
+		ret = st_cpufreq_check_if_matches(opp, "st,substrate",
+						  ddata->substrate);
+		if (err)
+			continue;
+
+		ret = of_property_read_u32(opp, "st,freq", &dvfs_tab->freq);
+		if (ret) {
+			dev_err(&pdev->dev, "Can't read frequency: %d\n", ret);
+			goto out;
+		}
+		dvfs_tab->freq *= 1000;
+
+		ret = of_property_read_u32_index(opp, "st,avs",
+						 ddata->pcode,
+						 &dvfs_tab->avs);
+		if (ret) {
+			dev_err(&pdev->dev, "Can't read AVS: %d\n", ret);
+			goto out;
+		}
+
+		dvfs_tab++;
+		ddata->dvfs_tab_count++;
+	}
+
+	sort(&ddata->dvfs_tab[0], ddata->dvfs_tab_count,
+	     sizeof(struct st_dvfs_tab), st_cpufreq_cmp, NULL);
+
+out:
+	of_node_put(opplist);
+
+	if (!ddata->dvfs_tab_count) {
+		dev_err(&pdev->dev, "No suitable AVS table found\n");
+		return -EINVAL;
+	}
+
+	return ret;
+}
+
+static int sti_cpufreq_voltage_scaling_init(struct platform_device *pdev)
+{
+	struct st_cpufreq_ddata *ddata = platform_get_drvdata(pdev);
+	struct st_dvfs_tab *dvfs_tab = &ddata->dvfs_tab[0];
+	struct device *cpu_dev;
+	struct dev_pm_opp *opp;
+	unsigned long highest_freq = 0;
+	int ret;
+	int i;
+
+	cpu_dev = get_cpu_device(0);
+	if (!cpu_dev) {
+		dev_err(&pdev->dev, "Failed to get cpu0 device\n");
+		return -ENODEV;
+	}
+
+	/* Populate OPP table with default non-AVS frequency values */
+	of_init_opp_table(cpu_dev);
+
+	/*
+	 * Disable, but keep default values -- this prevents the framework from
+	 * erroneously re-adding and enabling entries with missing voltage rates
+	 */
+	while (1) {
+		highest_freq++;
+
+		opp = dev_pm_opp_find_freq_ceil(cpu_dev, &highest_freq);
+		if (IS_ERR(opp))
+			break;
+
+		ret = dev_pm_opp_disable(cpu_dev, highest_freq);
+		if (ret) {
+			dev_err(&pdev->dev, "Failed to disable freq: %li\n",
+				highest_freq);
+			return ret;
+		}
+	}
+
+	for (i = 0; i < ddata->dvfs_tab_count; i++, dvfs_tab++) {
+		unsigned int f = dvfs_tab->freq * 1000;
+		unsigned int v = dvfs_tab->avs * 1000;
+
+		opp = dev_pm_opp_find_freq_exact(cpu_dev, f, false);
+
+		/* Remove existing voltage-less OPP entry */
+		if (!IS_ERR(opp))
+			dev_pm_opp_remove(cpu_dev, f);
+
+		/* Supply new fully populated OPP entry */
+		ret = dev_pm_opp_add(cpu_dev, f, v);
+		if (ret) {
+			dev_err(&pdev->dev, "Failed to add OPP %u\n", f);
+			return ret;
+		}
+	}
+
+	return 0;
+}
+
+static int st_cpufreq_fetch_regmap_field(struct platform_device *pdev,
+					 const struct reg_field *reg_fields,
+					 int pcode_offset, int field)
+{
+	struct st_cpufreq_ddata *ddata = platform_get_drvdata(pdev);
+	struct regmap_field *regmap_field;
+	struct reg_field reg_field = reg_fields[field];
+	unsigned int value;
+	int ret;
+
+	reg_field.reg = pcode_offset;
+	regmap_field = devm_regmap_field_alloc(&pdev->dev,
+					       ddata->regmap_eng,
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
+static struct of_device_id sti_cpufreq_of_match[] = {
+	{
+		.compatible = "st,stih407-cpufreq",
+		.data = &sti_stih407_dvfs_regfields,
+	},
+	{ }
+};
+MODULE_DEVICE_TABLE(of, sti_cpufreq_of_match);
+
+/* Find process code -- calibrated per-SoC */
+static void sti_cpufreq_get_pcode(struct platform_device *pdev)
+{
+	struct st_cpufreq_ddata *ddata = platform_get_drvdata(pdev);
+	struct device_node *np = pdev->dev.of_node;
+	const struct reg_field *reg_fields;
+	const struct of_device_id *match;
+	int pcode_offset;
+	int ret;
+
+	ddata->regmap_eng = syscon_regmap_lookup_by_phandle(np, "st,syscfg-eng");
+	if (IS_ERR(ddata->regmap_eng)) {
+		dev_warn(&pdev->dev, "\"st,syscfg-eng\" not supplied\n");
+		goto set_default;
+	}
+
+	ret = of_property_read_u32_index(np, "st,syscfg-eng",
+					 PCODE_INDEX, &pcode_offset);
+	if (ret) {
+		dev_warn(&pdev->dev, "Process code offset is required\n");
+		goto set_default;
+	}
+
+	match = of_match_node(sti_cpufreq_of_match, np);
+	if (!match) {
+		dev_warn(&pdev->dev, "Failed to match device\n");
+		goto set_default;
+	}
+	reg_fields = match->data;
+
+	ddata->pcode = st_cpufreq_fetch_regmap_field(pdev, reg_fields,
+						     pcode_offset,
+						     PCODE);
+	if (ddata->pcode < 0)
+		goto set_default;
+
+	ddata->substrate = st_cpufreq_fetch_regmap_field(pdev, reg_fields,
+							 pcode_offset,
+							 SUBSTRATE);
+	if (ddata->substrate < 0)
+		goto set_default;
+
+	return;
+
+set_default:
+	dev_warn(&pdev->dev,
+		 "Setting pcode to highest tolerance/voltage for safety\n");
+	ddata->pcode = 0;
+	ddata->substrate = 0;
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
+	sti_cpufreq_get_pcode(pdev);
+
+	ret = st_cpufreq_get_dvfs_info(pdev);
+	if (ret)
+		dev_warn(&pdev->dev, "Not doing voltage scaling [%d]\n", ret);
+	else
+		sti_cpufreq_voltage_scaling_init(pdev);
+
+	platform_device_register_simple("cpufreq-dt", -1, NULL, 0);
+
+	return 0;
+}
+
+static struct platform_driver sti_cpufreq = {
+	.driver = {
+		.name = "sti_cpufreq",
+		.of_match_table = sti_cpufreq_of_match,
+	},
+	.probe = sti_cpufreq_probe,
+};
+module_platform_driver(sti_cpufreq);
+
+MODULE_AUTHOR("Ajitpal Singh <ajitpal.singh@st.com>");
+MODULE_DESCRIPTION("Creates an OPP list for cpufreq-cpu0 at runtime");
+MODULE_LICENSE("GPL v2");
+
-- 
1.9.1

--
To unsubscribe from this list: send the line "unsubscribe linux-pm" in
