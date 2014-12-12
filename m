From: Chanwoo Choi <cw00.choi@samsung.com>
Subject: [RFC PATCHv3 3/7] devfreq: event: Add exynos-ppmu devfreq event driver
Date: Fri, 12 Dec 2014 17:27:28 +0900
Message-ID: <1418372852-12454-4-git-send-email-cw00.choi@samsung.com>
References: <1418372852-12454-1-git-send-email-cw00.choi@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-reply-to: <1418372852-12454-1-git-send-email-cw00.choi@samsung.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: myungjoo.ham@samsung.com, kyungmin.park@samsung.com
Cc: devicetree@vger.kernel.org, k.kozlowski@samsung.com, kgene.kim@samsung.com, b.zolnierkie@samsung.com, linux-pm@vger.kernel.org, rafael.j.wysocki@intel.com, tomasz.figa@gmail.com, linux-kernel@vger.kernel.org, cw00.choi@samsung.com, linux-samsung-soc@vger.kernel.org, a.kesavan@samsung.com, linux-arm-kernel@lists.infradead.org
List-Id: linux-pm@vger.kernel.org

This patch adds exynos-ppmu devfreq-event driver to get performance data
of each IP for Samsung Exynos SoC. These event from Exynos PPMU provide
useful information about the behavior of the SoC that you can use when
analyzing system performance, and made visible and can be counted using
logic in each IP.

This patch is based on existing drivers/devfreq/exynos/exynos-ppmu.c

Cc: MyungJoo Ham <myungjoo.ham@samsung.com>
Cc: Kyungmin Park <kyungmin.park@samsung.com>
Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
---
 drivers/devfreq/Kconfig             |   9 +
 drivers/devfreq/event/Makefile      |   1 +
 drivers/devfreq/event/exynos-ppmu.c | 404 ++++++++++++++++++++++++++++++++++++
 3 files changed, 414 insertions(+)
 create mode 100644 drivers/devfreq/event/exynos-ppmu.c

diff --git a/drivers/devfreq/Kconfig b/drivers/devfreq/Kconfig
index 4d15b62..d4559f7 100644
--- a/drivers/devfreq/Kconfig
+++ b/drivers/devfreq/Kconfig
@@ -89,4 +89,13 @@ config ARM_EXYNOS5_BUS_DEVFREQ
 
 comment "DEVFREQ Event Drivers"
 
+config DEVFREQ_EVENT_EXYNOS_PPMU
+	bool "EXYNOS PPMU (Performance Profiling Monitoring Unit) DEVFREQ event Driver"
+	depends on ARCH_EXYNOS
+	select PM_OPP
+	help
+	 This add the DEVFREQ event driver for Exynos SoC. It provides PPMU
+	 (Performance Profiling Monitoring Unit) counters to estimate the
+	 utilization of each module.
+
 endif # PM_DEVFREQ
diff --git a/drivers/devfreq/event/Makefile b/drivers/devfreq/event/Makefile
index dc56005..be146ea 100644
--- a/drivers/devfreq/event/Makefile
+++ b/drivers/devfreq/event/Makefile
@@ -1 +1,2 @@
 # Exynos DEVFREQ Event Drivers
+obj-$(CONFIG_DEVFREQ_EVENT_EXYNOS_PPMU) += exynos-ppmu.o
diff --git a/drivers/devfreq/event/exynos-ppmu.c b/drivers/devfreq/event/exynos-ppmu.c
new file mode 100644
index 0000000..bf93431
--- /dev/null
+++ b/drivers/devfreq/event/exynos-ppmu.c
@@ -0,0 +1,404 @@
+/*
+ * exynos_ppmu.c - EXYNOS PPMU (Performance Profiling Monitoring Units) support
+ *
+ * Copyright (c) 2014 Samsung Electronics Co., Ltd.
+ * Author : Chanwoo Choi <cw00.choi@samsung.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * This driver is based on drivers/devfreq/exynos/exynos_ppmu.c
+ */
+
+#include <linux/clk.h>
+#include <linux/io.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/mutex.h>
+#include <linux/of_address.h>
+#include <linux/platform_device.h>
+#include <linux/suspend.h>
+#include <linux/devfreq.h>
+
+#define PPMU_ENABLE             BIT(0)
+#define PPMU_DISABLE            0x0
+#define PPMU_CYCLE_RESET        BIT(1)
+#define PPMU_COUNTER_RESET      BIT(2)
+
+#define PPMU_ENABLE_COUNT0      BIT(0)
+#define PPMU_ENABLE_COUNT1      BIT(1)
+#define PPMU_ENABLE_COUNT2      BIT(2)
+#define PPMU_ENABLE_COUNT3      BIT(3)
+#define PPMU_ENABLE_CYCLE       BIT(31)
+
+#define PPMU_CNTENS		0x10
+#define PPMU_FLAG		0x50
+#define PPMU_CCNT_OVERFLOW	BIT(31)
+#define PPMU_CCNT		0x100
+
+#define PPMU_PMCNT0		0x110
+#define PPMU_PMCNT_OFFSET	0x10
+#define PMCNT_OFFSET(x)		(PPMU_PMCNT0 + (PPMU_PMCNT_OFFSET * x))
+
+#define PPMU_BEVT0SEL		0x1000
+#define PPMU_BEVTSEL_OFFSET	0x100
+#define PPMU_BEVTSEL(x)		(PPMU_BEVT0SEL + (x * PPMU_BEVTSEL_OFFSET))
+
+#define RD_DATA_COUNT		0x5
+#define WR_DATA_COUNT		0x6
+#define RDWR_DATA_COUNT		0x7
+
+enum ppmu_counter {
+	PPMU_PMNCNT0 = 0,
+	PPMU_PMNCNT1,
+	PPMU_PMNCNT2,
+	PPMU_PMNCNT3,
+
+	PPMU_PMNCNT_MAX,
+};
+
+struct exynos_ppmu_data {
+	struct devfreq_event_dev **edev;
+	struct devfreq_event_desc *desc;
+	unsigned int num_events;
+
+	struct device *dev;
+	struct clk *clk_ppmu;
+	struct mutex lock;
+
+	struct __exynos_ppmu {
+		void __iomem *base;
+		unsigned int event[PPMU_PMNCNT_MAX];
+		unsigned int count[PPMU_PMNCNT_MAX];
+		bool ccnt_overflow;
+		bool count_overflow[PPMU_PMNCNT_MAX];
+	} ppmu;
+};
+
+struct __exynos_ppmu_events {
+	char *name;
+	int id;
+} ppmu_events[] = {
+	{ "ppmu-dmc0-pmcnt0", PPMU_PMNCNT0 },
+	{ "ppmu-dmc0-pmcnt1", PPMU_PMNCNT1 },
+	{ "ppmu-dmc0-pmcnt2", PPMU_PMNCNT2 },
+	{ "ppmu-dmc0-pmcnt3", PPMU_PMNCNT3 },
+
+	{ "ppmu-dmc1-pmcnt0", PPMU_PMNCNT0 },
+	{ "ppmu-dmc1-pmcnt1", PPMU_PMNCNT1 },
+	{ "ppmu-dmc1-pmcnt2", PPMU_PMNCNT2 },
+	{ "ppmu-dmc1-pmcnt3", PPMU_PMNCNT3 },
+
+	{ "ppmu-cpu-pmcnt0", PPMU_PMNCNT0 },
+	{ "ppmu-cpu-pmcnt1", PPMU_PMNCNT1 },
+	{ "ppmu-cpu-pmcnt2", PPMU_PMNCNT2 },
+	{ "ppmu-cpu-pmcnt3", PPMU_PMNCNT3 },
+
+	{ "ppmu-rightbus-pmcnt0", PPMU_PMNCNT0 },
+	{ "ppmu-rightbus-pmcnt1", PPMU_PMNCNT1 },
+	{ "ppmu-rightbus-pmcnt2", PPMU_PMNCNT2 },
+	{ "ppmu-rightbus-pmcnt3", PPMU_PMNCNT3 },
+
+	{ "ppmu-leftbus-pmcnt0", PPMU_PMNCNT0 },
+	{ "ppmu-leftbus-pmcnt1", PPMU_PMNCNT1 },
+	{ "ppmu-leftbus-pmcnt2", PPMU_PMNCNT2 },
+	{ "ppmu-leftbus-pmcnt3", PPMU_PMNCNT3 },
+
+	{ "ppmu-camif-pmcnt0", PPMU_PMNCNT0 },
+	{ "ppmu-camif-pmcnt1", PPMU_PMNCNT1 },
+	{ "ppmu-camif-pmcnt2", PPMU_PMNCNT2 },
+	{ "ppmu-camif-pmcnt3", PPMU_PMNCNT3 },
+
+	{ "ppmu-lcd0-pmcnt0", PPMU_PMNCNT0 },
+	{ "ppmu-lcd0-pmcnt1", PPMU_PMNCNT1 },
+	{ "ppmu-lcd0-pmcnt2", PPMU_PMNCNT2 },
+	{ "ppmu-lcd0-pmcnt3", PPMU_PMNCNT3 },
+
+	{ "ppmu-g3d-pmcnt0", PPMU_PMNCNT0 },
+	{ "ppmu-g3d-pmcnt1", PPMU_PMNCNT1 },
+	{ "ppmu-g3d-pmcnt2", PPMU_PMNCNT2 },
+	{ "ppmu-g3d-pmcnt3", PPMU_PMNCNT3 },
+
+	{ "ppmu-mfc-pmcnt0", PPMU_PMNCNT0 },
+	{ "ppmu-mfc-pmcnt1", PPMU_PMNCNT1 },
+	{ "ppmu-mfc-pmcnt2", PPMU_PMNCNT2 },
+	{ "ppmu-mfc-pmcnt3", PPMU_PMNCNT3 },
+
+	{ "ppmu-fsys-pmcnt0", PPMU_PMNCNT0 },
+	{ "ppmu-fsys-pmcnt1", PPMU_PMNCNT1 },
+	{ "ppmu-fsys-pmcnt2", PPMU_PMNCNT2 },
+	{ "ppmu-fsys-pmcnt3", PPMU_PMNCNT3 },
+	{ /* sentinel */ },
+};
+
+static int exynos_ppmu_find_ppmu_id(struct devfreq_event_dev *edev)
+{
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(ppmu_events); i++)
+		if (!strcmp(edev->desc->name, ppmu_events[i].name))
+			return ppmu_events[i].id;
+
+	return -EINVAL;
+}
+
+static int exynos_ppmu_reset(struct devfreq_event_dev *edev)
+{
+	struct exynos_ppmu_data *data = devfreq_event_get_drvdata(edev);
+
+	__raw_writel(PPMU_CYCLE_RESET | PPMU_COUNTER_RESET, data->ppmu.base);
+	__raw_writel(PPMU_ENABLE_CYCLE  |
+		     PPMU_ENABLE_COUNT0 |
+		     PPMU_ENABLE_COUNT1 |
+		     PPMU_ENABLE_COUNT2 |
+		     PPMU_ENABLE_COUNT3,
+		     data->ppmu.base + PPMU_CNTENS);
+
+	return 0;
+}
+
+static int exynos_ppmu_set_event(struct devfreq_event_dev *edev,
+				enum devfreq_event_type type)
+{
+	struct exynos_ppmu_data *data = devfreq_event_get_drvdata(edev);
+	int id = exynos_ppmu_find_ppmu_id(edev);
+
+	if (id < 0)
+		return id;
+
+	if (type != edev->desc->type)
+		return -EINVAL;
+
+	/* Reset the performance and cycle counters */
+	exynos_ppmu_reset(edev);
+
+	/* Setup count registers to monitor read/write transactions */
+	__raw_writel(RDWR_DATA_COUNT, data->ppmu.base + PPMU_BEVTSEL(id));
+
+	/* Start monitoring of PPMU IP */
+	__raw_writel(PPMU_ENABLE, data->ppmu.base);
+
+	return 0;
+}
+
+static u64 exynos_ppmu_get_event(struct devfreq_event_dev *edev,
+				enum devfreq_event_type type,
+				u64 *total_event)
+{
+	struct exynos_ppmu_data *data = devfreq_event_get_drvdata(edev);
+	int id = exynos_ppmu_find_ppmu_id(edev);
+	u64 event;
+
+	if (id < 0)
+		return id;
+
+	if (type != edev->desc->type)
+		return -EINVAL;
+
+	/* Stop monitoring of PPMU IP */
+	__raw_writel(PPMU_DISABLE, data->ppmu.base);
+
+	/* Read total count cycle from of PPMU IP */
+	*total_event = __raw_readl(data->ppmu.base + PPMU_CCNT);
+
+	if (id == PPMU_PMNCNT3)
+		event = ((__raw_readl(data->ppmu.base + PMCNT_OFFSET(id)) << 8)
+			| __raw_readl(data->ppmu.base + PMCNT_OFFSET(id + 1)));
+	else
+		event = __raw_readl(data->ppmu.base + PMCNT_OFFSET(id));
+
+	dev_dbg(&edev->dev, "%s (event: %lld/%lld)\n",
+				edev->desc->name, event, *total_event);
+
+	return event;
+}
+
+static struct devfreq_event_ops exynos_ppmu_ops = {
+	.set_event = exynos_ppmu_set_event,
+	.get_event = exynos_ppmu_get_event,
+};
+
+static int of_get_devfreq_events(struct device_node *np,
+				 struct exynos_ppmu_data *data)
+{
+	struct devfreq_event_desc *desc;
+	struct device *dev = data->dev;
+	struct device_node *events_np, *node;
+	int i, j, count;
+
+	events_np = of_get_child_by_name(np, "events");
+	if (!events_np) {
+		dev_err(dev,
+			"failed to get child node of devfreq-event devices\n");
+		return -EINVAL;
+	}
+
+	count = of_get_child_count(events_np);
+	desc = devm_kzalloc(dev, sizeof(*desc) * count, GFP_KERNEL);
+	if (!desc)
+		return -ENOMEM;
+	data->num_events = count;
+
+	j = 0;
+	for_each_child_of_node(events_np, node) {
+		for (i = 0; i < ARRAY_SIZE(ppmu_events); i++) {
+			if (!of_node_cmp(node->name, ppmu_events[i].name))
+				break;
+		}
+
+		if (i == ARRAY_SIZE(ppmu_events)) {
+			dev_warn(dev,
+				"don't know how to configure events : %s\n",
+				node->name);
+			continue;
+		}
+
+		desc[j].ops = &exynos_ppmu_ops;
+		desc[j].driver_data = data;
+		desc[j].type |= DEVFREQ_EVENT_TYPE_RAW_DATA;
+
+		of_property_read_string(node, "event-name", &desc[j].name);
+
+		j++;
+
+		of_node_put(node);
+	}
+	data->desc = desc;
+
+	of_node_put(events_np);
+
+	return 0;
+}
+
+static int exynos_ppmu_parse_dt(struct exynos_ppmu_data *data)
+{
+	struct device *dev = data->dev;
+	struct device_node *np = dev->of_node;
+	int ret = 0;
+
+	if (!np) {
+		dev_err(dev, "failed to find devicetree node\n");
+		return -EINVAL;
+	}
+
+	/* Maps the memory mapped IO to control PPMU register */
+	data->ppmu.base = of_iomap(np, 0);
+	if (IS_ERR_OR_NULL(data->ppmu.base)) {
+		dev_err(dev, "failed to map memory region\n");
+		return -EINVAL;
+	}
+
+	data->clk_ppmu = devm_clk_get(dev, "ppmu");
+	if (IS_ERR(data->clk_ppmu)) {
+		data->clk_ppmu = NULL;
+		dev_warn(dev, "failed to get PPMU clock\n");
+	}
+
+	ret = of_get_devfreq_events(np, data);
+	if (ret < 0) {
+		dev_err(dev, "failed to parse exynos ppmu dt node\n");
+		goto err;
+	}
+
+	return 0;
+
+err:
+	iounmap(data->ppmu.base);
+
+	return ret;
+}
+
+static int exynos_ppmu_probe(struct platform_device *pdev)
+{
+	struct exynos_ppmu_data *data;
+	struct devfreq_event_dev **edev;
+	struct devfreq_event_desc *desc;
+	int i, ret = 0, size;
+
+	data = devm_kzalloc(&pdev->dev, sizeof(*data), GFP_KERNEL);
+	if (!data)
+		return -ENOMEM;
+
+	mutex_init(&data->lock);
+	data->dev = &pdev->dev;
+
+	/* Parse dt data to get resource */
+	ret = exynos_ppmu_parse_dt(data);
+	if (ret < 0) {
+		dev_err(&pdev->dev,
+			"failed to parse devicetree for resource\n");
+		return ret;
+	}
+	desc = data->desc;
+
+	size = sizeof(struct devfreq_event_dev *) * data->num_events;
+	data->edev = devm_kzalloc(&pdev->dev, size, GFP_KERNEL);
+	if (!data->edev) {
+		dev_err(&pdev->dev,
+			"failed to allocate memory devfreq-event devices\n");
+		return -ENOMEM;
+	}
+	edev = data->edev;
+	platform_set_drvdata(pdev, data);
+
+	for (i = 0; i < data->num_events; i++) {
+		edev[i] = devfreq_event_add_edev(&pdev->dev, &desc[i]);
+		if (IS_ERR(edev)) {
+			ret = PTR_ERR(edev);
+			dev_err(&pdev->dev,
+				"failed to add devfreq-event device\n");
+			goto err;
+		}
+	}
+
+	clk_prepare_enable(data->clk_ppmu);
+
+	return 0;
+err:
+	iounmap(data->ppmu.base);
+
+	return ret;
+}
+
+static int exynos_ppmu_remove(struct platform_device *pdev)
+{
+	struct exynos_ppmu_data *data = platform_get_drvdata(pdev);
+	int i, ret = 0;
+
+	for (i = 0; i < data->num_events; i++) {
+		ret = devfreq_event_remove_edev(data->edev[i]);
+		if (ret < 0) {
+			dev_err(&pdev->dev,
+				"failed to remove devfreq-event device\n");
+			goto err;
+		}
+	}
+
+err:
+	clk_disable_unprepare(data->clk_ppmu);
+	iounmap(data->ppmu.base);
+
+	return ret;
+}
+
+static struct of_device_id exynos_ppmu_id_match[] = {
+	{ .compatible = "samsung,exynos-ppmu", },
+	{ /* sentinel */ },
+};
+
+static struct platform_driver exynos_ppmu_driver = {
+	.probe	= exynos_ppmu_probe,
+	.remove	= exynos_ppmu_remove,
+	.driver = {
+		.name	= "exynos-ppmu",
+		.owner	= THIS_MODULE,
+		.of_match_table = exynos_ppmu_id_match,
+	},
+};
+module_platform_driver(exynos_ppmu_driver);
+
+MODULE_DESCRIPTION("Exynos PPMU(Performance Profiling Monitoring Unit) driver");
+MODULE_AUTHOR("Chanwoo Choi <cw00.choi@samsung.com>");
+MODULE_LICENSE("GPL");
+MODULE_ALIAS("platform:exynos-ppmu");
-- 
1.8.5.5
