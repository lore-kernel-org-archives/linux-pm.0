From: "pi-cheng.chen" <pi-cheng.chen@linaro.org>
Subject: [PATCH v2 3/4] cpufreq: mediatek: add Mediatek cpufreq driver
Date: Wed,  4 Mar 2015 16:49:15 +0800
Message-ID: <1425458956-20665-4-git-send-email-pi-cheng.chen@linaro.org>
References: <1425458956-20665-1-git-send-email-pi-cheng.chen@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1425458956-20665-1-git-send-email-pi-cheng.chen@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>, Matthias Brugger <matthias.bgg@gmail.com>, Rob Herring <robh+dt@kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Cc: Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, "pi-cheng.chen" <pi-cheng.chen@linaro.org>, "Joe.C" <yingjoe.chen@mediatek.com>, Eddie Huang <eddie.huang@mediatek.com>, Howard Chen <ibanezchen@gmail.com>, Ashwin Chaugule <ashwin.chaugule@linaro.org>, Mike Turquette <mturquette@linaro.org>, fan.chen@mediatek.com, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, linaro-kernel@lists.linaro.org, linux-mediatek@lists.infradead.org
List-Id: linux-pm@vger.kernel.org

In this patch, some SoC specific voltage scaling flow is implemented in the
cpufreq notifier of mtk-cpufreq driver.

Signed-off-by: pi-cheng.chen <pi-cheng.chen@linaro.org>
---
 drivers/cpufreq/Kconfig.arm   |   6 +
 drivers/cpufreq/Makefile      |   1 +
 drivers/cpufreq/mtk-cpufreq.c | 346 ++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 353 insertions(+)
 create mode 100644 drivers/cpufreq/mtk-cpufreq.c

diff --git a/drivers/cpufreq/Kconfig.arm b/drivers/cpufreq/Kconfig.arm
index 1b06fc4..f421653 100644
--- a/drivers/cpufreq/Kconfig.arm
+++ b/drivers/cpufreq/Kconfig.arm
@@ -263,3 +263,9 @@ config ARM_PXA2xx_CPUFREQ
 	  This add the CPUFreq driver support for Intel PXA2xx SOCs.
 
 	  If in doubt, say N.
+
+config ARM_MTK_CPUFREQ
+	bool "Mediatek CPUFreq support"
+	depends on ARCH_MEDIATEK && CPUFREQ_DT && REGULATOR
+	help
+	  This adds the CPUFreq driver support for Mediatek SoCs.
diff --git a/drivers/cpufreq/Makefile b/drivers/cpufreq/Makefile
index 82a1821..05cb596 100644
--- a/drivers/cpufreq/Makefile
+++ b/drivers/cpufreq/Makefile
@@ -62,6 +62,7 @@ obj-$(CONFIG_ARM_HIGHBANK_CPUFREQ)	+= highbank-cpufreq.o
 obj-$(CONFIG_ARM_IMX6Q_CPUFREQ)		+= imx6q-cpufreq.o
 obj-$(CONFIG_ARM_INTEGRATOR)		+= integrator-cpufreq.o
 obj-$(CONFIG_ARM_KIRKWOOD_CPUFREQ)	+= kirkwood-cpufreq.o
+obj-$(CONFIG_ARM_MTK_CPUFREQ)		+= mtk-cpufreq.o
 obj-$(CONFIG_ARM_OMAP2PLUS_CPUFREQ)	+= omap-cpufreq.o
 obj-$(CONFIG_ARM_PXA2xx_CPUFREQ)	+= pxa2xx-cpufreq.o
 obj-$(CONFIG_PXA3xx)			+= pxa3xx-cpufreq.o
diff --git a/drivers/cpufreq/mtk-cpufreq.c b/drivers/cpufreq/mtk-cpufreq.c
new file mode 100644
index 0000000..344d588
--- /dev/null
+++ b/drivers/cpufreq/mtk-cpufreq.c
@@ -0,0 +1,346 @@
+/*
+* Copyright (c) 2015 Linaro Ltd.
+* Author: Pi-Cheng Chen <pi-cheng.chen@linaro.org>
+*
+* This program is free software; you can redistribute it and/or modify
+* it under the terms of the GNU General Public License version 2 as
+* published by the Free Software Foundation.
+*
+* This program is distributed in the hope that it will be useful,
+* but WITHOUT ANY WARRANTY; without even the implied warranty of
+* MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+* GNU General Public License for more details.
+*/
+
+#include <linux/clk.h>
+#include <linux/cpu.h>
+#include <linux/cpufreq.h>
+#include <linux/cpufreq-dt.h>
+#include <linux/cpumask.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/platform_device.h>
+#include <linux/pm_opp.h>
+#include <linux/regulator/consumer.h>
+#include <linux/slab.h>
+
+#define VOLT_SHIFT_LOWER_LIMIT		100000
+#define VOLT_SHIFT_UPPER_LIMIT		200000
+
+struct cpu_opp_table {
+	unsigned int freq;
+	int vproc;
+	int vsram;
+};
+
+static struct dvfs_info {
+	struct cpumask cpus;
+	struct cpu_opp_table *opp_tbl;
+	struct device *cpu_dev;
+	struct regulator *proc_reg;
+	struct regulator *sram_reg;
+} *dvfs_info;
+
+static int cpu_opp_table_get_freq_index(unsigned int freq)
+{
+	struct cpu_opp_table *opp_tbl = dvfs_info->opp_tbl;
+	int i;
+
+	for (i = 0; opp_tbl[i].freq != 0; i++) {
+		if (opp_tbl[i].freq >= freq)
+			return i;
+	}
+
+	return -1;
+}
+
+static int cpu_opp_table_get_volt_index(unsigned int volt)
+{
+	struct cpu_opp_table *opp_tbl = dvfs_info->opp_tbl;
+	int i;
+
+	for (i = 0; opp_tbl[i].vproc != -1; i++)
+		if (opp_tbl[i].vproc >= volt)
+			return i;
+
+	return -1;
+}
+
+static int get_regulator_voltage_ceil(struct regulator *regulator, int voltage)
+{
+	int cnt, i, volt = -1;
+
+	cnt = regulator_count_voltages(regulator);
+
+	for (i = 0; i < cnt && volt < voltage; i++)
+		volt = regulator_list_voltage(regulator, i);
+
+	return volt;
+}
+
+static int mtk_cpufreq_voltage_trace(int old_index, int new_index)
+{
+	struct cpu_opp_table *opp_tbl = dvfs_info->opp_tbl;
+	int old_vproc, new_vproc, i, j;
+
+	old_vproc = regulator_get_voltage(dvfs_info->proc_reg);
+	new_vproc = opp_tbl[new_index].vproc;
+
+	if (old_vproc > new_vproc) {
+		for (i = old_index; i > new_index;) {
+			for (j = i; j >= new_index; j--)
+				if (opp_tbl[i].vsram - opp_tbl[j].vproc
+				    > VOLT_SHIFT_UPPER_LIMIT)
+					break;
+			i = j + 1;
+
+			regulator_set_voltage_tol(dvfs_info->proc_reg,
+						  opp_tbl[i].vproc, 0);
+			regulator_set_voltage_tol(dvfs_info->sram_reg,
+						  opp_tbl[i].vsram, 0);
+		}
+	} else if (old_vproc < new_vproc) {
+		for (i = old_index; i < new_index;) {
+			for (j = i; j <= new_index; j++)
+				if (opp_tbl[j].vsram - opp_tbl[i].vproc
+				    > VOLT_SHIFT_UPPER_LIMIT)
+					break;
+			i = j - 1;
+
+			regulator_set_voltage_tol(dvfs_info->sram_reg,
+						  opp_tbl[i].vsram, 0);
+			regulator_set_voltage_tol(dvfs_info->proc_reg,
+						  opp_tbl[i].vproc, 0);
+		}
+	}
+
+	return 0;
+}
+
+static int mtk_cpufreq_notify(struct notifier_block *nb,
+			      unsigned long action, void *data)
+{
+	struct cpufreq_freqs *freqs = data;
+	struct cpu_opp_table *opp_tbl = dvfs_info->opp_tbl;
+	int old_vproc, new_vproc, old_index, new_index;
+
+	if (!cpumask_test_cpu(freqs->cpu, &dvfs_info->cpus))
+		return NOTIFY_DONE;
+
+	old_vproc = regulator_get_voltage(dvfs_info->proc_reg);
+	old_index = cpu_opp_table_get_volt_index(old_vproc);
+	new_index = cpu_opp_table_get_freq_index(freqs->new * 1000);
+	new_vproc = opp_tbl[new_index].vproc;
+
+	if (old_vproc == new_vproc)
+		return 0;
+
+	if ((action == CPUFREQ_PRECHANGE && old_vproc < new_vproc) ||
+	    (action == CPUFREQ_POSTCHANGE && old_vproc > new_vproc))
+		mtk_cpufreq_voltage_trace(old_index, new_index);
+
+	return NOTIFY_OK;
+}
+
+static struct notifier_block mtk_cpufreq_nb = {
+	.notifier_call = mtk_cpufreq_notify,
+};
+
+static int cpu_opp_table_init(struct device *dev)
+{
+	struct device *cpu_dev = dvfs_info->cpu_dev;
+	struct cpu_opp_table *opp_tbl;
+	struct dev_pm_opp *opp;
+	int ret, cnt, i;
+	unsigned long rate, vproc, vsram;
+
+	ret = of_init_opp_table(cpu_dev);
+	if (ret) {
+		dev_err(dev, "Failed to init mtk_opp_table: %d\n", ret);
+		return ret;
+	}
+
+	rcu_read_lock();
+
+	cnt = dev_pm_opp_get_opp_count(cpu_dev);
+	if (cnt < 0) {
+		dev_err(cpu_dev, "No OPP table is found: %d", cnt);
+		ret = cnt;
+		goto out_free_opp_tbl;
+	}
+
+	opp_tbl = devm_kcalloc(dev, (cnt + 1), sizeof(struct cpu_opp_table),
+			       GFP_ATOMIC);
+	if (!opp_tbl) {
+		ret = -ENOMEM;
+		goto out_free_opp_tbl;
+	}
+
+	for (i = 0, rate = 0; i < cnt; i++, rate++) {
+		opp = dev_pm_opp_find_freq_ceil(cpu_dev, &rate);
+		if (IS_ERR(opp)) {
+			ret = PTR_ERR(opp);
+			goto out_free_opp_tbl;
+		}
+
+		vproc = dev_pm_opp_get_voltage(opp);
+		vproc = get_regulator_voltage_ceil(dvfs_info->proc_reg, vproc);
+		vsram = vproc + VOLT_SHIFT_LOWER_LIMIT;
+		vsram = get_regulator_voltage_ceil(dvfs_info->sram_reg, vsram);
+
+		if (vproc < 0 || vsram < 0) {
+			ret = -EINVAL;
+			goto out_free_opp_tbl;
+		}
+
+		opp_tbl[i].freq = rate;
+		opp_tbl[i].vproc = vproc;
+		opp_tbl[i].vsram = vsram;
+	}
+
+	opp_tbl[i].freq = 0;
+	opp_tbl[i].vproc = -1;
+	opp_tbl[i].vsram = -1;
+	dvfs_info->opp_tbl = opp_tbl;
+
+out_free_opp_tbl:
+	rcu_read_unlock();
+	of_free_opp_table(cpu_dev);
+
+	return ret;
+}
+
+static struct cpufreq_cpu_domain *get_cpu_domain(struct list_head *domain_list,
+						 int cpu)
+{
+	struct list_head *node;
+
+	list_for_each(node, domain_list) {
+		struct cpufreq_cpu_domain *domain;
+
+		domain = container_of(node, struct cpufreq_cpu_domain, node);
+		if (cpumask_test_cpu(cpu, &domain->cpus))
+			return domain;
+	}
+
+	return NULL;
+}
+
+static int mtk_cpufreq_probe(struct platform_device *pdev)
+{
+	struct clk *inter_clk;
+	struct cpufreq_dt_platform_data *pd;
+	struct platform_device *dev;
+	unsigned long inter_freq;
+	int cpu, ret;
+
+	inter_clk = clk_get(&pdev->dev, NULL);
+	if (IS_ERR(inter_clk)) {
+		if (PTR_ERR(inter_clk) == -EPROBE_DEFER) {
+			dev_warn(&pdev->dev, "clock not ready. defer probeing.\n");
+			return -EPROBE_DEFER;
+		}
+
+		dev_err(&pdev->dev, "Failed to get intermediate clock\n");
+		return -ENODEV;
+	}
+	inter_freq = clk_get_rate(inter_clk);
+
+	pd = devm_kzalloc(&pdev->dev, sizeof(*pd), GFP_KERNEL);
+	if (!pd)
+		return -ENOMEM;
+
+	dvfs_info = devm_kzalloc(&pdev->dev, sizeof(*dvfs_info), GFP_KERNEL);
+	if (!dvfs_info)
+		return -ENOMEM;
+
+	pd->independent_clocks = 1,
+	INIT_LIST_HEAD(&pd->domain_list);
+
+	for_each_possible_cpu(cpu) {
+		struct device *cpu_dev;
+		struct cpufreq_cpu_domain *new_domain;
+		struct regulator *proc_reg, *sram_reg;
+
+		cpu_dev = get_cpu_device(cpu);
+
+		if (!dvfs_info->cpu_dev) {
+			proc_reg = regulator_get_exclusive(cpu_dev, "proc");
+			sram_reg = regulator_get_exclusive(cpu_dev, "sram");
+
+			if (PTR_ERR(proc_reg) == -EPROBE_DEFER ||
+			    PTR_ERR(sram_reg) == -EPROBE_DEFER)
+				return -EPROBE_DEFER;
+
+			if (!IS_ERR_OR_NULL(proc_reg) &&
+			    !IS_ERR_OR_NULL(sram_reg)) {
+				dvfs_info->cpu_dev = cpu_dev;
+				dvfs_info->proc_reg = proc_reg;
+				dvfs_info->sram_reg = sram_reg;
+				cpumask_copy(&dvfs_info->cpus,
+					     &cpu_topology[cpu].core_sibling);
+			}
+		}
+
+		if (get_cpu_domain(&pd->domain_list, cpu))
+			continue;
+
+		new_domain = devm_kzalloc(&pdev->dev, sizeof(*new_domain),
+					  GFP_KERNEL);
+		if (!new_domain)
+			return -ENOMEM;
+
+		cpumask_copy(&new_domain->cpus,
+			     &cpu_topology[cpu].core_sibling);
+		new_domain->intermediate_freq = inter_freq;
+		list_add(&new_domain->node, &pd->domain_list);
+	}
+
+	if (IS_ERR_OR_NULL(dvfs_info->proc_reg) ||
+	    IS_ERR_OR_NULL(dvfs_info->sram_reg)) {
+		dev_err(&pdev->dev, "Failed to get regulators\n");
+		return -ENODEV;
+	}
+
+	ret = cpu_opp_table_init(&pdev->dev);
+	if (ret) {
+		dev_err(&pdev->dev, "Failed to setup cpu_opp_table: %d\n",
+			ret);
+		return ret;
+	}
+
+	ret = cpufreq_register_notifier(&mtk_cpufreq_nb,
+					CPUFREQ_TRANSITION_NOTIFIER);
+	if (ret) {
+		dev_err(&pdev->dev, "Failed to register cpufreq notifier\n");
+		return ret;
+	}
+
+	dev = platform_device_register_data(NULL, "cpufreq-dt", -1, pd,
+					    sizeof(*pd));
+	if (IS_ERR(dev)) {
+		dev_err(&pdev->dev,
+			"Failed to register cpufreq-dt platform device\n");
+		return PTR_ERR(dev);
+	}
+
+	return 0;
+}
+
+static const struct of_device_id mtk_cpufreq_match[] = {
+	{
+		.compatible = "mediatek,mtk-cpufreq",
+	},
+	{}
+};
+MODULE_DEVICE_TABLE(of, mtk_cpufreq_match);
+
+static struct platform_driver mtk_cpufreq_platdrv = {
+	.driver	= {
+		.name	= "mtk-cpufreq",
+		.of_match_table = mtk_cpufreq_match,
+	},
+	.probe	= mtk_cpufreq_probe,
+};
+module_platform_driver(mtk_cpufreq_platdrv);
+
-- 
1.9.1
