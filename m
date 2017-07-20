From: Georgi Djakov <georgi.djakov@linaro.org>
Subject: [PATCH v2 2/2] interconnect: Add Qualcomm msm8916 interconnect provider driver
Date: Thu, 20 Jul 2017 22:52:50 +0300
Message-ID: <20170720195250.13462-3-georgi.djakov@linaro.org>
References: <20170720195250.13462-1-georgi.djakov@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170720195250.13462-1-georgi.djakov@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: rjw@rjwysocki.net, robh+dt@kernel.org, khilman@baylibre.com, mturquette@baylibre.com, gregkh@linuxfoundation.org, vincent.guittot@linaro.org, skannan@codeaurora.org, sboyd@codeaurora.org, andy.gross@linaro.org, mark.rutland@arm.com, lorenzo.pieralisi@arm.com, seansw@qti.qualcomm.com, davidai@quicinc.com, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org, georgi.djakov@linaro.org
List-Id: linux-pm@vger.kernel.org

Add driver for the Qualcomm interconnect buses found in msm8916 based
platforms. This patch contains only a partial topology to make reviewing
easier.

Signed-off-by: Georgi Djakov <georgi.djakov@linaro.org>
---
 drivers/interconnect/Kconfig                     |   5 +
 drivers/interconnect/Makefile                    |   1 +
 drivers/interconnect/qcom/Kconfig                |  12 +
 drivers/interconnect/qcom/Makefile               |   2 +
 drivers/interconnect/qcom/interconnect_msm8916.c | 390 +++++++++++++++++++++++
 include/linux/interconnect/qcom-noc.h            |  92 ++++++
 6 files changed, 502 insertions(+)
 create mode 100644 drivers/interconnect/qcom/Kconfig
 create mode 100644 drivers/interconnect/qcom/Makefile
 create mode 100644 drivers/interconnect/qcom/interconnect_msm8916.c
 create mode 100644 include/linux/interconnect/qcom-noc.h

diff --git a/drivers/interconnect/Kconfig b/drivers/interconnect/Kconfig
index 1e50e951cdc1..b123a76e2f9d 100644
--- a/drivers/interconnect/Kconfig
+++ b/drivers/interconnect/Kconfig
@@ -8,3 +8,8 @@ menuconfig INTERCONNECT
 
 	  If unsure, say no.
 
+if INTERCONNECT
+
+source "drivers/interconnect/qcom/Kconfig"
+
+endif
diff --git a/drivers/interconnect/Makefile b/drivers/interconnect/Makefile
index d9da6a6c3560..62a01de24aeb 100644
--- a/drivers/interconnect/Makefile
+++ b/drivers/interconnect/Makefile
@@ -1 +1,2 @@
 obj-$(CONFIG_INTERCONNECT)  += interconnect.o
+obj-$(CONFIG_INTERCONNECT_QCOM)                += qcom/
diff --git a/drivers/interconnect/qcom/Kconfig b/drivers/interconnect/qcom/Kconfig
new file mode 100644
index 000000000000..1bbbba87549d
--- /dev/null
+++ b/drivers/interconnect/qcom/Kconfig
@@ -0,0 +1,12 @@
+config INTERCONNECT_QCOM
+	bool "Qualcomm Network-on-Chip interconnect drivers"
+	depends on INTERCONNECT
+	depends on ARCH_QCOM || COMPILE_TEST
+	default y
+
+config INTERCONNECT_QCOM_MSM8916
+	tristate "Qualcomm MSM8916 interconnect driver"
+	depends on INTERCONNECT_QCOM
+	help
+	  This is a driver for the Qualcomm Network-on-Chip on msm8916-based platforms.
+
diff --git a/drivers/interconnect/qcom/Makefile b/drivers/interconnect/qcom/Makefile
new file mode 100644
index 000000000000..e5bf8e2b92ac
--- /dev/null
+++ b/drivers/interconnect/qcom/Makefile
@@ -0,0 +1,2 @@
+obj-$(CONFIG_INTERCONNECT_QCOM_MSM8916) += interconnect_msm8916.o
+
diff --git a/drivers/interconnect/qcom/interconnect_msm8916.c b/drivers/interconnect/qcom/interconnect_msm8916.c
new file mode 100644
index 000000000000..ae1cd939dfbb
--- /dev/null
+++ b/drivers/interconnect/qcom/interconnect_msm8916.c
@@ -0,0 +1,390 @@
+/*
+ * Copyright (C) 2017 Linaro Ltd
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 and
+ * only version 2 as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ */
+
+#include <linux/clk.h>
+#include <linux/device.h>
+#include <linux/io.h>
+#include <linux/interconnect-provider.h>
+#include <linux/interconnect/qcom-noc.h>
+#include <linux/module.h>
+#include <linux/of_device.h>
+#include <linux/of_platform.h>
+#include <linux/platform_device.h>
+#include <linux/slab.h>
+
+#define to_qcom_icp(_icp) \
+	container_of(_icp, struct qcom_interconnect_provider, icp)
+#define to_qcom_node(_node) \
+	container_of(_node, struct qcom_interconnect_node, node)
+
+enum qcom_bus_type {
+	QCOM_BUS_TYPE_NOC = 0,
+	QCOM_BUS_TYPE_MEM,
+};
+
+struct qcom_interconnect_provider {
+	struct icp		icp;
+	void __iomem		*base;
+	struct clk		*bus_clk;
+	struct clk		*bus_a_clk;
+	u32			base_offset;
+	u32			qos_offset;
+	enum qcom_bus_type	type;
+};
+
+struct qcom_interconnect_node {
+	struct interconnect_node node;
+	unsigned char *name;
+	struct interconnect_node *links[8];
+	u16 id;
+	u16 num_links;
+	u16 port;
+	u16 buswidth;
+	u64 rate;
+};
+
+static struct qcom_interconnect_node snoc_int_0;
+static struct qcom_interconnect_node snoc_int_1;
+static struct qcom_interconnect_node snoc_int_bimc;
+static struct qcom_interconnect_node snoc_bimc_0_mas;
+static struct qcom_interconnect_node pnoc_snoc_slv;
+
+static struct qcom_interconnect_node snoc_bimc_0_slv;
+static struct qcom_interconnect_node slv_ebi_ch0;
+
+static struct qcom_interconnect_node pnoc_int_1;
+static struct qcom_interconnect_node mas_pnoc_sdcc_1;
+static struct qcom_interconnect_node mas_pnoc_sdcc_2;
+static struct qcom_interconnect_node pnoc_snoc_mas;
+
+struct qcom_interconnect_desc {
+	struct qcom_interconnect_node **nodes;
+	size_t num_nodes;
+};
+
+static struct qcom_interconnect_node snoc_int_0 = {
+	.id = 10004,
+	.name = "snoc-int-0",
+#if 0
+	.links = { &snoc_pnoc_mas.node },
+	.num_links = 1,
+#endif
+	.buswidth = 8,
+};
+
+static struct qcom_interconnect_node snoc_int_1 = {
+	.id = 10005,
+	.name = "snoc-int-1",
+#if 0
+	.links = { &slv_apss.node, &slv_cats_0.node, &slv_cats_1.node },
+	.num_links = 3,
+#endif
+	.buswidth = 8,
+};
+
+static struct qcom_interconnect_node snoc_int_bimc = {
+	.id = 10006,
+	.name = "snoc-bimc",
+	.links = { &snoc_bimc_0_mas.node },
+	.num_links = 1,
+	.buswidth = 8,
+};
+
+static struct qcom_interconnect_node snoc_bimc_0_mas = {
+	.id = 10007,
+	.name = "snoc-bimc-0-mas",
+	.links = { &snoc_bimc_0_slv.node },
+	.num_links = 1,
+	.buswidth = 8,
+};
+
+static struct qcom_interconnect_node pnoc_snoc_slv = {
+	.id = 10011,
+	.name = "snoc-pnoc",
+	.links = { &snoc_int_0.node, &snoc_int_bimc.node, &snoc_int_1.node },
+	.num_links = 3,
+	.buswidth = 8,
+};
+
+static struct qcom_interconnect_node *msm8916_snoc_nodes[] = {
+	[SNOC_INT_0] = &snoc_int_0,
+	[SNOC_INT_1] = &snoc_int_1,
+	[SNOC_INT_BIMC] = &snoc_int_bimc,
+	[SNOC_BIMC_0_MAS] = &snoc_bimc_0_mas,
+	[PNOC_SNOC_SLV] = &pnoc_snoc_slv,
+};
+
+static struct qcom_interconnect_desc msm8916_snoc = {
+	.nodes = msm8916_snoc_nodes,
+	.num_nodes = ARRAY_SIZE(msm8916_snoc_nodes),
+};
+
+static struct qcom_interconnect_node snoc_bimc_0_slv = {
+	.id = 10025,
+	.name = "snoc_bimc_0_slv",
+	.links = { &slv_ebi_ch0.node },
+	.num_links = 1,
+	.buswidth = 8,
+};
+
+static struct qcom_interconnect_node slv_ebi_ch0 = {
+	.id = 512,
+	.name = "slv-ebi-ch0",
+	.buswidth = 8,
+};
+
+static struct qcom_interconnect_node *msm8916_bimc_nodes[] = {
+	[SNOC_BIMC_0_SLV] = &snoc_bimc_0_slv,
+	[SLV_EBI_CH0] = &slv_ebi_ch0,
+};
+
+static struct qcom_interconnect_desc msm8916_bimc = {
+	.nodes = msm8916_bimc_nodes,
+	.num_nodes = ARRAY_SIZE(msm8916_bimc_nodes),
+};
+
+static struct qcom_interconnect_node pnoc_int_1 = {
+	.id = 10013,
+	.name = "pnoc-int-1",
+	.links = { &pnoc_snoc_mas.node },
+	.num_links = 1,
+	.buswidth = 8,
+};
+
+static struct qcom_interconnect_node mas_pnoc_sdcc_1 = {
+	.id = 78,
+	.name = "mas-pnoc-sdcc-1",
+	.links = { &pnoc_int_1.node },
+	.num_links = 1,
+	.port = 7,
+	.buswidth = 8,
+};
+
+static struct qcom_interconnect_node mas_pnoc_sdcc_2 = {
+	.id = 81,
+	.name = "mas-pnoc-sdcc-2",
+	.links = { &pnoc_int_1.node },
+	.num_links = 1,
+	.port = 8,
+	.buswidth = 8,
+};
+
+static struct qcom_interconnect_node pnoc_snoc_mas = {
+	.id = 10010,
+	.name = "pnoc-snoc-mas",
+	.links = { &pnoc_snoc_slv.node },
+	.num_links = 1,
+	.buswidth = 8,
+};
+
+static struct qcom_interconnect_node *msm8916_pnoc_nodes[] = {
+	[PNOC_INT_1] = &pnoc_int_1,
+	[MAS_PNOC_SDCC_1] = &mas_pnoc_sdcc_1,
+	[MAS_PNOC_SDCC_2] = &mas_pnoc_sdcc_2,
+	[PNOC_SNOC_MAS] = &pnoc_snoc_mas,
+};
+
+static struct qcom_interconnect_desc msm8916_pnoc = {
+	.nodes = msm8916_pnoc_nodes,
+	.num_nodes = ARRAY_SIZE(msm8916_pnoc_nodes),
+};
+
+static int qcom_interconnect_init(struct interconnect_node *node)
+{
+	struct qcom_interconnect_node *qn = to_qcom_node(node);
+	int ret = 0;
+
+	/* populate default values */
+	if (!qn->buswidth)
+		qn->buswidth = 8;
+
+	/* TODO: init qos and priority */
+
+	return ret;
+}
+
+static int qcom_interconnect_set(struct interconnect_node *src,
+				 struct interconnect_node *dst,
+				 struct interconnect_creq *creq)
+{
+	struct qcom_interconnect_provider *qicp;
+	struct qcom_interconnect_node *qn;
+	struct interconnect_node *node;
+	struct icp *icp;
+	u64 rate = 0;
+	int ret = 0;
+
+	if (!src && !dst)
+		return -ENODEV;
+
+	if (!src)
+		node = dst;
+	else
+		node = src;
+
+	qn = to_qcom_node(node);
+	icp = qn->node.icp;
+	qicp = to_qcom_icp(node->icp);
+
+	rate = max(icp->creq.avg_bw, icp->creq.peak_bw);
+
+	do_div(rate, qn->buswidth);
+
+	if (qn->rate != rate) {
+		ret = clk_set_rate(qicp->bus_clk, rate);
+		if (ret) {
+			pr_err("set clk rate %lld error %d\n", rate, ret);
+			return ret;
+		}
+
+		ret = clk_set_rate(qicp->bus_a_clk, rate);
+		if (ret) {
+			pr_err("set clk rate %lld error %d\n", rate, ret);
+			return ret;
+		}
+
+		qn->rate = rate;
+	}
+
+	return ret;
+}
+
+struct interconnect_onecell_data {
+	struct interconnect_node **nodes;
+	unsigned int num_nodes;
+};
+
+static const struct icp_ops qcom_ops = {
+	.set = qcom_interconnect_set,
+};
+
+static int qnoc_probe(struct platform_device *pdev)
+{
+	struct qcom_interconnect_provider *qicp;
+	struct icp *icp;
+	struct device *dev = &pdev->dev;
+	struct device_node *np = dev->of_node;
+	struct resource *res;
+	void __iomem *base;
+	struct clk *bus_clk, *bus_a_clk;
+	size_t num_nodes, i;
+	const struct qcom_interconnect_desc *desc;
+	struct qcom_interconnect_node **qnodes;
+	struct interconnect_node *nodes;
+	struct interconnect_onecell_data *data;
+	u32 type, base_offset, qos_offset;
+
+	desc = of_device_get_match_data(&pdev->dev);
+	if (!desc)
+		return -EINVAL;
+
+	qnodes = desc->nodes;
+	num_nodes = desc->num_nodes;
+
+	qicp = devm_kzalloc(dev, sizeof(*qicp), GFP_KERNEL);
+	if (!qicp)
+		return -ENOMEM;
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	base = devm_ioremap_resource(dev, res);
+	if (IS_ERR(base))
+		return PTR_ERR(base);
+
+	bus_clk = devm_clk_get(&pdev->dev, "bus_clk");
+	if (IS_ERR(bus_clk))
+		return PTR_ERR(bus_clk);
+	bus_a_clk = devm_clk_get(&pdev->dev, "bus_a_clk");
+	if (IS_ERR(bus_a_clk))
+		return PTR_ERR(bus_a_clk);
+
+	of_property_read_u32(np, "type", &type);
+	of_property_read_u32(np, "base-offset", &base_offset);
+	of_property_read_u32(np, "qos-offset", &qos_offset);
+
+	qicp->base = base;
+	qicp->type = type;
+	qicp->base_offset = base_offset;
+	qicp->qos_offset = qos_offset;
+	qicp->bus_clk = bus_clk;
+	qicp->bus_a_clk = bus_a_clk;
+	icp = &qicp->icp;
+	icp->dev = dev;
+	icp->ops = &qcom_ops;
+	INIT_LIST_HEAD(&icp->nodes);
+
+	data = devm_kzalloc(dev, sizeof(*data), GFP_KERNEL);
+	if (!data)
+		return -ENOMEM;
+
+	icp->data = data;
+	data->num_nodes = num_nodes;
+
+	data->nodes = devm_kcalloc(dev, num_nodes, sizeof(*nodes), GFP_KERNEL);
+	if (!data->nodes)
+		return -ENOMEM;
+
+	for (i = 0; i < num_nodes; i++) {
+		struct interconnect_node *node;
+		int ret;
+		size_t j;
+
+		if (!qnodes[i])
+			continue;
+
+		node = &qnodes[i]->node;
+		node->dev_id = kstrdup_const(qnodes[i]->name, GFP_KERNEL);
+		node->con_id = qnodes[i]->id;
+		node->icp = icp;
+		node->num_links = qnodes[i]->num_links;
+		node->links = devm_kcalloc(dev, node->num_links,
+				sizeof(*node->links), GFP_KERNEL);
+		if (!node->links)
+			return -ENOMEM;
+
+		/* populate links */
+		for (j = 0; j < node->num_links; j++)
+			node->links[j] = qnodes[i]->links[j];
+
+		/* add node to interconnect provider */
+		data->nodes[i] = node;
+		list_add_tail(&node->icn_list, &icp->nodes);
+		dev_dbg(&pdev->dev, "registered node %p %s %d\n", node,
+			node->dev_id, node->con_id);
+
+		ret = qcom_interconnect_init(node);
+		if (ret)
+			dev_err(&pdev->dev, "node init error (%d)\n", ret);
+	}
+
+	return interconnect_add_provider(icp);
+}
+
+static const struct of_device_id qnoc_of_match[] = {
+	{ .compatible = "qcom,msm-bus-pnoc", .data = &msm8916_pnoc },
+	{ .compatible = "qcom,msm-bus-snoc", .data = &msm8916_snoc },
+	{ .compatible = "qcom,msm-bus-bimc", .data = &msm8916_bimc },
+	{ },
+};
+MODULE_DEVICE_TABLE(of, qnoc_of_match);
+
+static struct platform_driver qnoc_driver = {
+	.probe = qnoc_probe,
+	.driver = {
+		.name = "qcom,qnoc",
+		.of_match_table = qnoc_of_match,
+	},
+};
+module_platform_driver(qnoc_driver);
+MODULE_AUTHOR("Georgi Djakov <georgi.djakov@linaro.org>");
+MODULE_DESCRIPTION("Qualcomm msm8916 NoC driver");
+MODULE_LICENSE("GPL v2");
diff --git a/include/linux/interconnect/qcom-noc.h b/include/linux/interconnect/qcom-noc.h
new file mode 100644
index 000000000000..355582a09bea
--- /dev/null
+++ b/include/linux/interconnect/qcom-noc.h
@@ -0,0 +1,92 @@
+#ifndef __LINUX_INTERCONNECT_QCOM_NOC_H
+#define __LINUX_INTERCONNECT_QCOM_NOC_H
+
+#define MAS_VIDEO				0
+#define MAS_JPEG				1
+#define MAS_VFE					2
+#define MAS_MDP					3
+#define MAS_QDSS_BAM				4
+#define MAS_SNOC_CFG				5
+#define MAS_QDSS_ETR				6
+#define MM_INT_0				7
+#define MM_INT_1				8
+#define MM_INT_2				9
+#define MM_INT_BIMC				10
+#define SNOC_INT_0				11
+#define SNOC_INT_1				12
+#define SNOC_INT_BIMC				13
+#define SNOC_BIMC_0_MAS				14
+#define SNOC_BIMC_1_MAS				15
+#define QDSS_INT				16
+#define BIMC_SNOC_SLV				17
+#define SNOC_PNOC_MAS				18
+#define PNOC_SNOC_SLV				19
+#define SLV_SRVC_SNOC				20
+#define SLV_QDSS_STM				21
+#define SLV_IMEM				22
+#define SLV_APSS				23
+#define SLV_CATS_0				24
+#define SLV_CATS_1				25
+
+#define MAS_APPS				0
+#define MAS_TCU0				1
+#define MAS_TCU1				2
+#define MAS_GFX					3
+#define BIMC_SNOC_MAS				4
+#define SNOC_BIMC_0_SLV				5
+#define SNOC_BIMC_1_SLV				6
+#define SLV_EBI_CH0				7
+#define SLV_APPS_L2				8
+
+#define SNOC_PNOC_SLV				0
+#define PNOC_INT_0				1
+#define PNOC_INT_1				2
+#define PNOC_M_0				3
+#define PNOC_M_1				4
+#define PNOC_S_0				5
+#define PNOC_S_1				6
+#define PNOC_S_2				7
+#define PNOC_S_3				8
+#define PNOC_S_4				9
+#define PNOC_S_8				10
+#define PNOC_S_9				11
+#define SLV_IMEM_CFG				12
+#define SLV_CRYPTO_0_CFG			13
+#define SLV_MSG_RAM				14
+#define SLV_PDM					15
+#define SLV_PRNG				16
+#define SLV_CLK_CTL				17
+#define SLV_MSS					18
+#define SLV_TLMM				19
+#define SLV_TCSR				20
+#define SLV_SECURITY				21
+#define SLV_SPDM				22
+#define SLV_PNOC_CFG				23
+#define SLV_PMIC_ARB				24
+#define SLV_BIMC_CFG				25
+#define SLV_BOOT_ROM				26
+#define SLV_MPM					27
+#define SLV_QDSS_CFG				28
+#define SLV_RBCPR_CFG				29
+#define SLV_SNOC_CFG				30
+#define SLV_DEHR_CFG				31
+#define SLV_VENUS_CFG				32
+#define SLV_DISPLAY_CFG				33
+#define SLV_CAMERA_CFG				34
+#define SLV_USB_HS				35
+#define SLV_SDCC_1				36
+#define SLV_BLSP_1				37
+#define SLV_SDCC_2				38
+#define SLV_GFX_CFG				39
+#define SLV_AUDIO				40
+#define MAS_BLSP_1				41
+#define MAS_SPDM				42
+#define MAS_DEHR				43
+#define MAS_AUDIO				44
+#define MAS_USB_HS				45
+#define MAS_PNOC_CRYPTO_0			46
+#define MAS_PNOC_SDCC_1				47
+#define MAS_PNOC_SDCC_2				48
+#define PNOC_SNOC_MAS				49
+
+#endif
