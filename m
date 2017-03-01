From: Georgi Djakov <georgi.djakov@linaro.org>
Subject: [RFC v0 2/2] interconnect: Add Qualcomm msm8916 interconnect provider driver
Date: Wed,  1 Mar 2017 20:22:35 +0200
Message-ID: <20170301182235.19154-3-georgi.djakov@linaro.org>
References: <20170301182235.19154-1-georgi.djakov@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170301182235.19154-1-georgi.djakov@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-pm@vger.kernel.org, rjw@rjwysocki.net, robh+dt@kernel.org
Cc: gregkh@linuxfoundation.org, khilman@baylibre.com, mturquette@baylibre.com, vincent.guittot@linaro.org, skannan@codeaurora.org, sboyd@codeaurora.org, andy.gross@linaro.org, seansw@qti.qualcomm.com, davidai@quicinc.com, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org, georgi.djakov@linaro.org
List-Id: linux-pm@vger.kernel.org

Add driver for the Qualcomm interconnect controllers found in
msm8916 based platforms.

Signed-off-by: Georgi Djakov <georgi.djakov@linaro.org>
---
 drivers/interconnect/Kconfig                     |   1 +
 drivers/interconnect/Makefile                    |   2 +
 drivers/interconnect/qcom/Kconfig                |  11 +
 drivers/interconnect/qcom/Makefile               |   2 +
 drivers/interconnect/qcom/interconnect_msm8916.c | 473 +++++++++++++++++++++++
 include/dt-bindings/interconnect/qcom,msm8916.h  |  87 +++++
 6 files changed, 576 insertions(+)
 create mode 100644 drivers/interconnect/qcom/Kconfig
 create mode 100644 drivers/interconnect/qcom/Makefile
 create mode 100644 drivers/interconnect/qcom/interconnect_msm8916.c
 create mode 100644 include/dt-bindings/interconnect/qcom,msm8916.h

diff --git a/drivers/interconnect/Kconfig b/drivers/interconnect/Kconfig
index 103524b59905..e2d017540fa1 100644
--- a/drivers/interconnect/Kconfig
+++ b/drivers/interconnect/Kconfig
@@ -8,3 +8,4 @@ menuconfig INTERCONNECT
 
 	  If unsure, say no.
 
+source "drivers/interconnect/qcom/Kconfig"
diff --git a/drivers/interconnect/Makefile b/drivers/interconnect/Makefile
index 184da73ce0d2..005067d319bc 100644
--- a/drivers/interconnect/Makefile
+++ b/drivers/interconnect/Makefile
@@ -1 +1,3 @@
 obj-y  += interconnect.o
+
+obj-$(CONFIG_INTERCONNECT_QCOM)                += qcom/
diff --git a/drivers/interconnect/qcom/Kconfig b/drivers/interconnect/qcom/Kconfig
new file mode 100644
index 000000000000..3f727be2a236
--- /dev/null
+++ b/drivers/interconnect/qcom/Kconfig
@@ -0,0 +1,11 @@
+config INTERCONNECT_QCOM
+	tristate "Qualcomm Network-on-Chip interconnect drivers"
+	depends on OF
+	depends on ARCH_QCOM || COMPILE_TEST
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
index 000000000000..270bc389ed06
--- /dev/null
+++ b/drivers/interconnect/qcom/interconnect_msm8916.c
@@ -0,0 +1,473 @@
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
+#include <linux/module.h>
+#include <linux/of_device.h>
+#include <linux/of_platform.h>
+#include <linux/interconnect-provider.h>
+#include <linux/platform_device.h>
+#include <linux/slab.h>
+#include <dt-bindings/interconnect/qcom,msm8916.h>
+
+#define to_qcom_icp(_icp) container_of(_icp, struct qcom_interconnect_provider, icp)
+#define to_qcom_node(_node) container_of(_node, struct qcom_interconnect_node, node)
+
+#define BW_TO_CLK_FREQ_HZ(width, bw) msm_bus_div64(width, bw)
+
+enum qcom_bus_type {
+	QCOM_BUS_TYPE_NOC = 0,
+	QCOM_BUS_TYPE_MEM,
+	QCOM_BUS_TYPE_MAX,
+};
+
+struct qcom_interconnect_provider {
+	struct icp		icp;
+	void __iomem		*base;
+	enum qcom_bus_type	type;
+	u32			base_offset;
+	u32			qos_offset;
+	struct clk		*bus_clk;
+	struct clk		*bus_a_clk;
+};
+
+struct qcom_interconnect_node {
+	unsigned int id;
+	struct interconnect_node node;
+	unsigned char *name;
+	unsigned int links[8];
+	int num_links;
+	int port;
+	int buswidth;
+	u64 ib;
+	u64 ab;
+	u64 rate;
+};
+
+struct qcom_interconnect_desc {
+	struct qcom_interconnect_node **nodes;
+	size_t num_nodes;
+};
+
+static struct qcom_interconnect_node snoc_int_0 = {
+	.id = 10004,
+	.name = "snoc-int-0",
+	.links = { 588, 519, 10027 }, /* slv_qdss_stm, slv_imem, snoc_pnoc_mas */
+	.num_links = 3,
+	.buswidth = 8,
+};
+
+static struct qcom_interconnect_node snoc_int_1 = {
+	.id = 10005,
+	.name = "snoc-int-1",
+	.links = { 517, 663, 664 }, /* slv_apss, slv_cats_0, slv_cats_1 */
+	.num_links = 3,
+	.buswidth = 8,
+};
+
+static struct qcom_interconnect_node snoc_int_bimc = {
+	.id = 10006,
+	.name = "snoc-bimc",
+	.links = { 10007 }, /* snoc_bimc_0_mas */
+	.num_links = 1,
+	.buswidth = 8,
+};
+
+static struct qcom_interconnect_node snoc_bimc_0_mas = {
+	.id = 10007,
+	.name = "snoc-bimc-0-mas",
+	.links = { 10025 }, /* snoc_bimc_0_slv */
+	.num_links = 1,
+	.buswidth = 8,
+};
+
+static struct qcom_interconnect_node pnoc_snoc_slv = {
+	.id = 10011,
+	.name = "snoc-pnoc",
+	.links = { 10004, 10006, 10005 }, /* snoc_int_0, snoc_int_bimc, snoc_int_1 */
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
+static const struct qcom_interconnect_desc msm8916_snoc = {
+	.nodes = msm8916_snoc_nodes,
+	.num_nodes = ARRAY_SIZE(msm8916_snoc_nodes),
+};
+
+static struct qcom_interconnect_node snoc_bimc_0_slv = {
+	.id = 10025,
+	.name = "snoc_bimc_0_slv",
+	.links = { 512 }, /* slv_ebi_ch0 */
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
+	.links = { 10010 }, /* pnoc_snoc_mas */
+	.num_links = 1,
+	.buswidth = 8,
+};
+
+static struct qcom_interconnect_node mas_pnoc_sdcc_1 = {
+	.id = 78,
+	.name = "mas-pnoc-sdcc-1",
+	.links = { 10013 }, /* pnoc_int_1 */
+	.num_links = 1,
+	.port = 7,
+	.buswidth = 8,
+};
+
+static struct qcom_interconnect_node mas_pnoc_sdcc_2 = {
+	.id = 81,
+	.name = "mas-pnoc-sdcc-2",
+	.links = { 10013 }, /* pnoc_int_1 */
+	.num_links = 1,
+	.port = 8,
+	.buswidth = 8,
+};
+
+static struct qcom_interconnect_node pnoc_snoc_mas = {
+	.id = 10010,
+	.name = "pnoc-snoc-mas",
+	.links = { 10011 }, /* pnoc_snoc_slv */
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
+static const struct qcom_interconnect_desc msm8916_pnoc = {
+	.nodes = msm8916_pnoc_nodes,
+	.num_nodes = ARRAY_SIZE(msm8916_pnoc_nodes),
+};
+
+static int qcom_interconnect_init(struct interconnect_node *node)
+{
+	struct qcom_interconnect_node *qn = to_qcom_node(node);
+
+	if (!qn->buswidth)
+		qn->buswidth = 8;
+
+	/* TODO: init qos and priority */
+
+	return 0;
+}
+
+static uint64_t qcom_div64(unsigned int w, uint64_t bw)
+{
+	uint64_t *b = &bw;
+
+	if ((bw > 0) && (bw < w))
+		return 1;
+
+	switch (w) {
+	case 0:
+		WARN(1, "AXI: Divide by 0 attempted\n");
+	case 1: return bw;
+	case 2: return (bw >> 1);
+	case 4: return (bw >> 2);
+	case 8: return (bw >> 3);
+	case 16: return (bw >> 4);
+	case 32: return (bw >> 5);
+	}
+
+	do_div(*b, w);
+	return *b;
+}
+
+static u64 arbitrate_bus_req(struct qcom_interconnect_node *qn)
+{
+	struct icp *icp = qn->node.icp;
+	struct interconnect_node *node;
+	u64 max_ib = 0;
+	u64 sum_ab = 0;
+	u64 bw_max_hz = 0;
+
+	list_for_each_entry(node, &icp->nodes, icn_list) {
+		struct qcom_interconnect_node *tmp = to_qcom_node(node);
+
+		max_ib = max(max_ib, tmp->ib);
+		sum_ab += tmp->ab;
+	}
+
+	sum_ab *= 100;
+	sum_ab = qcom_div64(100, sum_ab);
+	max_ib *= 100;
+	max_ib = qcom_div64(100, max_ib);
+
+	/* TODO: account for multiple channels if any */
+
+	bw_max_hz = max(max_ib, sum_ab);
+	bw_max_hz = qcom_div64(qn->buswidth, bw_max_hz);
+
+	return bw_max_hz;
+}
+
+static int qcom_interconnect_set(struct interconnect_node *node, u32 bandwidth)
+{
+	struct qcom_interconnect_node *qn = to_qcom_node(node);
+	struct qcom_interconnect_provider *qicp = to_qcom_icp(node->icp);
+	struct icn_qos *req;
+	u64 rate;
+	int ret;
+
+	/* aggregate bandwidth requests */
+	hlist_for_each_entry(req, &node->qos_list, node) {
+		req->bandwidth += bandwidth;
+	}
+
+	if (qn->ab != bandwidth)
+		qn->ab = bandwidth;
+
+	rate = arbitrate_bus_req(qn);
+
+	if (qn->rate != rate) {
+
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
+	/* TODO: set bw */
+
+	/* TODO: commit */
+
+	return ret;
+}
+
+static struct qcom_interconnect_node *get_qcom_node_by_id(struct qcom_interconnect_provider *qicp,
+							  unsigned int id)
+{
+	struct qcom_interconnect_node *qn;
+	struct interconnect_node *node;
+
+	list_for_each_entry(node, &qicp->icp.nodes, icn_list) {
+		qn = to_qcom_node(node);
+		if (qn->id == id)
+			return qn;
+	}
+
+	return NULL;
+}
+
+struct interconnect_onecell_data {
+	struct interconnect_node **nodes;
+	unsigned int num_nodes;
+};
+
+static struct interconnect_node *qcom_xlate(struct of_phandle_args *spec, void *data)
+{
+	struct interconnect_onecell_data *pdata = data;
+	unsigned int idx = spec->args[0];
+
+	if (spec->args_count != 1)
+		return ERR_PTR(-EINVAL);
+
+	if (idx >= pdata->num_nodes)
+		return ERR_PTR(-ENXIO);
+
+	if (!pdata->nodes[idx])
+		return ERR_PTR(-ENOENT);
+
+	return pdata->nodes[idx];
+}
+
+static const struct icp_ops qcom_ops = {
+	.set = qcom_interconnect_set,
+	.xlate = qcom_xlate,
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
+	struct interconnect_node *node;
+	struct qcom_interconnect_node **nodes;
+	struct interconnect_onecell_data *data;
+	u32 type, base_offset, qos_offset = 0;
+
+	desc = of_device_get_match_data(&pdev->dev);
+	if (!desc)
+		return -EINVAL;
+
+	nodes = desc->nodes;
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
+		return PTR_ERR(bus_clk);
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
+	icp->name = np->name;
+	icp->of_node = of_node_get(np);
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
+	data->nodes = devm_kcalloc(dev, num_nodes, sizeof(*node), GFP_KERNEL);
+	if (!data->nodes)
+		return -ENOMEM;
+
+	for (i = 0; i < num_nodes; i++) {
+		struct qcom_interconnect_node *qn;
+		int ret;
+
+		if (!nodes[i])
+			continue;
+
+		qn = devm_kzalloc(dev, sizeof(*qn), GFP_KERNEL);
+		qn->node.icp = icp;
+		qn->node.num_links = nodes[i]->num_links;
+		qn->node.links = devm_kcalloc(dev, qn->node.num_links,
+					      sizeof(*qn->node.links),
+					      GFP_KERNEL);
+		if (!qn->node.links)
+			return -ENOMEM;
+
+		qn->id = nodes[i]->id;
+		qn->name = nodes[i]->name;
+		qn->buswidth = nodes[i]->buswidth;
+		qn->port = nodes[i]->port;
+
+		data->nodes[i] = &qn->node;
+		list_add_tail(&qn->node.icn_list, &icp->nodes);
+		dev_info(&pdev->dev, "registered interconnect node %p %s\n",
+			 &qn->node, qn->name);
+
+		ret = qcom_interconnect_init(&qn->node);
+		if (ret)
+			dev_err(&pdev->dev, "%s node init error\n", qn->name);
+	}
+
+	/* populate links */
+	for (i = 0; i < data->num_nodes; i++) {
+		struct interconnect_node *pn = data->nodes[i];
+		size_t j;
+
+		if (!pn || !pn->num_links)
+			continue;
+
+		for (j = 0; j < pn->num_links; j++) {
+			struct qcom_interconnect_node *dst;
+
+			dst = get_qcom_node_by_id(qicp, nodes[i]->links[j]);
+			if (dst) {
+				pn->links[j] = &dst->node;
+			} else {
+				pr_err("%s: link not found %u\n", icp->name,
+				       nodes[i]->links[j]);
+			}
+		}
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
diff --git a/include/dt-bindings/interconnect/qcom,msm8916.h b/include/dt-bindings/interconnect/qcom,msm8916.h
new file mode 100644
index 000000000000..ea772b34ac96
--- /dev/null
+++ b/include/dt-bindings/interconnect/qcom,msm8916.h
@@ -0,0 +1,87 @@
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
