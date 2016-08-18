From: Finlye Xiao <finley.xiao-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
Subject: [PATCH v2 4/4] PM / AVS: rockchip-cpu-avs: add driver handling
 Rockchip cpu avs
Date: Thu, 18 Aug 2016 16:52:21 +0800
Message-ID: <1471510341-63926-5-git-send-email-finley.xiao@rock-chips.com>
References: <1471510341-63926-1-git-send-email-finley.xiao@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-rockchip-bounces+glpar-linux-rockchip=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
In-Reply-To: <1471510341-63926-1-git-send-email-finley.xiao-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-rockchip>,
 <mailto:linux-rockchip-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-rockchip/>
List-Post: <mailto:linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Help: <mailto:linux-rockchip-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-rockchip>,
 <mailto:linux-rockchip-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=subscribe>
Sender: "Linux-rockchip" <linux-rockchip-bounces-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
Errors-To: linux-rockchip-bounces+glpar-linux-rockchip=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: srinivas.kandagatla-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org, heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, frowand.list-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, dbaryshkov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, khilman-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, nm-l0cyMroinI0@public.gmane.org, rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org, viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, sboyd-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org
Cc: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, tim.chen-TNX95d0MmH7DzftRWevZcw@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, lin.huang-TNX95d0MmH7DzftRWevZcw@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, tony.xie-TNX95d0MmH7DzftRWevZcw@public.gmane.org, Finley Xiao <finley.xiao-TNX95d0MmH7DzftRWevZcw@public.gmane.org>, ulysses.huang-TNX95d0MmH7DzftRWevZcw@public.gmane.org, rocky.hao-TNX95d0MmH7DzftRWevZcw@public.gmane.org, jay.xu-TNX95d0MmH7DzftRWevZcw@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, wxt-TNX95d0MmH7DzftRWevZcw@public.gmane.org
List-Id: linux-pm@vger.kernel.org

From: Finley Xiao <finley.xiao-TNX95d0MmH7DzftRWevZcw@public.gmane.org>

This patch supports adjusting opp's voltage according to leakage

Signed-off-by: Finley Xiao <finley.xiao-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
---
 drivers/power/avs/Kconfig            |   9 +
 drivers/power/avs/Makefile           |   1 +
 drivers/power/avs/rockchip-cpu-avs.c | 331 +++++++++++++++++++++++++++++++++++
 3 files changed, 341 insertions(+)
 create mode 100644 drivers/power/avs/rockchip-cpu-avs.c

diff --git a/drivers/power/avs/Kconfig b/drivers/power/avs/Kconfig
index a67eeac..dea13801 100644
--- a/drivers/power/avs/Kconfig
+++ b/drivers/power/avs/Kconfig
@@ -18,3 +18,12 @@ config ROCKCHIP_IODOMAIN
           Say y here to enable support io domains on Rockchip SoCs. It is
           necessary for the io domain setting of the SoC to match the
           voltage supplied by the regulators.
+
+config ROCKCHIP_CPU_AVS
+        bool "Rockchip CPU AVS support"
+        depends on POWER_AVS && ARCH_ROCKCHIP && OF && CPU_FREQ
+        depends on (ARM_CPU_TOPOLOGY || ARM64) && ROCKCHIP_EFUSE
+        help
+          Say y here to enable support CPU AVS on Rockchip SoCs.
+          The cpu's operating voltage is adapted depending on leakage
+          or pvtm.
diff --git a/drivers/power/avs/Makefile b/drivers/power/avs/Makefile
index ba4c7bc..11ce242 100644
--- a/drivers/power/avs/Makefile
+++ b/drivers/power/avs/Makefile
@@ -1,2 +1,3 @@
 obj-$(CONFIG_POWER_AVS_OMAP)		+= smartreflex.o
 obj-$(CONFIG_ROCKCHIP_IODOMAIN)		+= rockchip-io-domain.o
+obj-$(CONFIG_ROCKCHIP_CPU_AVS)		+= rockchip-cpu-avs.o
diff --git a/drivers/power/avs/rockchip-cpu-avs.c b/drivers/power/avs/rockchip-cpu-avs.c
new file mode 100644
index 0000000..7b42b46
--- /dev/null
+++ b/drivers/power/avs/rockchip-cpu-avs.c
@@ -0,0 +1,331 @@
+/*
+  * Rockchip CPU AVS support.
+  *
+  * Copyright (c) 2016 Rockchip Electronics Co. Ltd.
+  * Author: Finley Xiao <finley.xiao-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
+  *
+  * This program is free software; you can redistribute it and/or modify it
+  * under the terms of version 2 of the GNU General Public License as
+  * published by the Free Software Foundation.
+  *
+  * This program is distributed in the hope that it will be useful, but WITHOUT
+  * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+  * FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for
+  * more details.
+  */
+
+#include <linux/cpu.h>
+#include <linux/cpufreq.h>
+#include <linux/cpumask.h>
+#include <linux/err.h>
+#include <linux/init.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/nvmem-consumer.h>
+#include <linux/of.h>
+#include <linux/platform_device.h>
+#include <linux/pm_opp.h>
+#include <linux/slab.h>
+#include <linux/types.h>
+#include "../../base/power/opp/opp.h"
+
+#define MAX_NAME_LEN		22
+#define LEAKAGE_TABLE_END	~1
+#define INVALID_VALUE		0xff
+
+struct leakage_volt_table {
+	int min;
+	int max;
+	int volt;
+};
+
+struct cluster_info {
+	int adjust_volt;
+	unsigned char leakage;
+	struct leakage_volt_table *table;
+};
+
+struct rockchip_cpu_avs {
+	struct device *dev;
+	struct cluster_info *cluster;
+	struct notifier_block cpufreq_notify;
+};
+
+#define notifier_to_avs(_n) container_of(_n, struct rockchip_cpu_avs, \
+	cpufreq_notify)
+
+static int rockchip_get_leakage(struct device *cpu_dev, unsigned char *leakage)
+{
+	struct nvmem_cell *cell;
+	unsigned char *buf;
+	size_t len;
+
+	cell = nvmem_cell_get(cpu_dev, "cpu_leakage");
+	if (IS_ERR(cell)) {
+		dev_err(cpu_dev, "avs failed to get cpu_leakage cell\n");
+		return PTR_ERR(cell);
+	}
+
+	buf = (unsigned char *)nvmem_cell_read(cell, &len);
+
+	nvmem_cell_put(cell);
+
+	if (IS_ERR(buf))
+		return PTR_ERR(buf);
+
+	if (buf[0] == INVALID_VALUE)
+		return -EINVAL;
+
+	*leakage = buf[0];
+	kfree(buf);
+
+	return 0;
+}
+
+static int rockchip_get_offset_volt(unsigned char leakage,
+				    struct leakage_volt_table *table, int *volt)
+{
+	unsigned int i, j;
+
+	if (!table)
+		return -EINVAL;
+
+	for (i = 0; table[i].volt != LEAKAGE_TABLE_END; i++) {
+		if (leakage >= table[i].min)
+			j = i;
+	}
+
+	*volt = table[j].volt;
+
+	return 0;
+}
+
+static int rockchip_adjust_opp_table(struct device *cpu_dev,
+				     struct cpufreq_frequency_table *table,
+				     int volt)
+{
+	struct opp_table *opp_table;
+	struct cpufreq_frequency_table *pos;
+	struct dev_pm_opp *opp;
+
+	if (!volt)
+		return 0;
+
+	rcu_read_lock();
+
+	opp_table = _find_opp_table(cpu_dev);
+	if (IS_ERR(opp_table)) {
+		rcu_read_unlock();
+		return PTR_ERR(opp_table);
+	}
+
+	cpufreq_for_each_valid_entry(pos, table) {
+		opp = dev_pm_opp_find_freq_exact(cpu_dev, pos->frequency * 1000,
+						 true);
+		if (IS_ERR(opp))
+			continue;
+
+		opp->u_volt += volt;
+		opp->u_volt_min += volt;
+		opp->u_volt_max += volt;
+	}
+
+	rcu_read_unlock();
+
+	return 0;
+}
+
+static void rockchip_adjust_volt_by_leakage(struct device *cpu_dev,
+					    struct cpufreq_policy *policy,
+					    struct rockchip_cpu_avs *avs,
+					    int id)
+{
+	struct cluster_info *cluster = &avs->cluster[id];
+	int ret;
+
+	if (cluster->leakage)
+		goto next;
+
+	ret = rockchip_get_leakage(cpu_dev, &cluster->leakage);
+	if (ret) {
+		dev_err(avs->dev, "cpu%d leakage invalid\n", policy->cpu);
+		return;
+	}
+
+	ret = rockchip_get_offset_volt(cluster->leakage, cluster->table,
+				       &cluster->adjust_volt);
+	if (ret) {
+		dev_err(avs->dev, "cpu%d leakage volt table err\n",
+			policy->cpu);
+		return;
+	}
+
+next:
+	ret = rockchip_adjust_opp_table(cpu_dev, policy->freq_table,
+					cluster->adjust_volt);
+	if (ret)
+		dev_err(avs->dev, "cpu%d failed to adjust volt\n", policy->cpu);
+
+	dev_dbg(avs->dev, "cpu%d, leakage=%d, adjust_volt=%d\n", policy->cpu,
+		cluster->leakage, cluster->adjust_volt);
+}
+
+static int rockchip_cpu_avs_notifier(struct notifier_block *nb,
+				     unsigned long event, void *data)
+{
+	struct rockchip_cpu_avs *avs = notifier_to_avs(nb);
+	struct cpufreq_policy *policy = data;
+	struct device *cpu_dev;
+	int cluster_id;
+
+	if (event != CPUFREQ_START)
+		goto out;
+
+	cluster_id = topology_physical_package_id(policy->cpu);
+	if (cluster_id < 0) {
+		dev_err(avs->dev, "cpu%d invalid cluster id\n", policy->cpu);
+		goto out;
+	}
+
+	if (!policy->freq_table) {
+		dev_err(avs->dev, "cpu%d freq table not found\n", policy->cpu);
+		goto out;
+	}
+
+	cpu_dev = get_cpu_device(policy->cpu);
+	if (!cpu_dev) {
+		dev_err(avs->dev, "cpu%d failed to get device\n", policy->cpu);
+		goto out;
+	}
+
+	rockchip_adjust_volt_by_leakage(cpu_dev, policy, avs, cluster_id);
+
+out:
+
+	return NOTIFY_OK;
+}
+
+static int rockchip_get_leakage_volt_table(struct device *dev,
+					   struct leakage_volt_table **table,
+					   const char *name)
+{
+	struct device_node *np = dev->of_node;
+	struct leakage_volt_table *volt_table;
+	const struct property *prop;
+	int count, i;
+
+	prop = of_find_property(np, name, NULL);
+	if (!prop) {
+		dev_err(dev, "failed to find prop %s\n", name);
+		return -EINVAL;
+	}
+	if (!prop->value) {
+		dev_err(dev, "%s value is NULL\n", name);
+		return -ENODATA;
+	}
+
+	count = of_property_count_u32_elems(np, name);
+	if (count < 0) {
+		dev_err(dev, "Invalid %s property (%d)\n", name, count);
+		return -EINVAL;
+	}
+	if (count % 3) {
+		dev_err(dev, "Invalid number of elements in %s property (%d)\n",
+			name, count);
+		return -EINVAL;
+	}
+
+	volt_table = kzalloc(sizeof(*table) * (count / 3 + 1), GFP_KERNEL);
+	if (!volt_table)
+		return -ENOMEM;
+
+	if (volt_table) {
+		for (i = 0; i < count / 3; i++) {
+			of_property_read_s32_index(np, name, 3 * i,
+						   &volt_table[i].min);
+			of_property_read_s32_index(np, name, 3 * i + 1,
+						   &volt_table[i].max);
+			of_property_read_s32_index(np, name, 3 * i + 2,
+						   &volt_table[i].volt);
+		}
+		volt_table[i].min = 0;
+		volt_table[i].max = 0;
+		volt_table[i].volt = LEAKAGE_TABLE_END;
+	}
+
+	*table = volt_table;
+
+	return 0;
+}
+
+static const struct of_device_id rockchip_cpu_avs_match[] = {
+	{
+		.compatible = "rockchip,rk3399-cpu-avs",
+	},
+	{ /* sentinel */ },
+};
+MODULE_DEVICE_TABLE(of, rockchip_cpu_avs_match);
+
+static int rockchip_cpu_avs_probe(struct platform_device *pdev)
+{
+	struct rockchip_cpu_avs *avs;
+	char name[MAX_NAME_LEN];
+	int i, ret, cpu, id;
+	int last_id = -1;
+	int cluster_num = 0;
+
+	for_each_online_cpu(cpu) {
+		id = topology_physical_package_id(cpu);
+		if (id < 0)
+			return -EINVAL;
+		if (id != last_id) {
+			last_id = id;
+			cluster_num++;
+		}
+	}
+
+	avs = devm_kzalloc(&pdev->dev, sizeof(struct rockchip_cpu_avs),
+			   GFP_KERNEL);
+	if (!avs)
+		return -ENOMEM;
+
+	avs->dev = &pdev->dev;
+	avs->cpufreq_notify.notifier_call = rockchip_cpu_avs_notifier;
+	avs->cluster = devm_kzalloc(&pdev->dev,
+		sizeof(struct cluster_info) * cluster_num, GFP_KERNEL);
+	if (!avs->cluster)
+		return -ENOMEM;
+
+	for (i = 0; i < cluster_num; i++) {
+		snprintf(name, MAX_NAME_LEN, "leakage-volt-cluster%d", i);
+		ret = rockchip_get_leakage_volt_table(&pdev->dev,
+						      &avs->cluster[i].table,
+						      name);
+		if (ret)
+			continue;
+	}
+
+	return cpufreq_register_notifier(&avs->cpufreq_notify,
+		CPUFREQ_POLICY_NOTIFIER);
+}
+
+static struct platform_driver rockchip_cpu_avs_driver = {
+	.probe   = rockchip_cpu_avs_probe,
+	.driver  = {
+		.name  = "rockchip-cpu-avs",
+		.of_match_table = rockchip_cpu_avs_match,
+		.suppress_bind_attrs = true,
+	},
+};
+
+static int __init rockchip_cpu_avs_module_init(void)
+{
+	return platform_driver_probe(&rockchip_cpu_avs_driver,
+				     rockchip_cpu_avs_probe);
+}
+
+subsys_initcall(rockchip_cpu_avs_module_init);
+
+MODULE_DESCRIPTION("Rockchip CPU AVS driver");
+MODULE_AUTHOR("Finley Xiao <finley.xiao-TNX95d0MmH7DzftRWevZcw@public.gmane.org>");
+MODULE_LICENSE("GPL v2");
-- 
1.9.1
