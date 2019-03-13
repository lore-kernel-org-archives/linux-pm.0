From: Alexandre Bailon <abailon@baylibre.com>
Subject: [RFC PATCH 2/3] drivers: interconnect: imx: Add support of i.MX8MM
Date: Wed, 13 Mar 2019 20:34:07 +0100
Message-ID: <20190313193408.23740-3-abailon@baylibre.com>
References: <20190313193408.23740-1-abailon@baylibre.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190313193408.23740-1-abailon@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-pm@vger.kernel.org, georgi.djakov@linaro.org
Cc: mturquette@baylibre.com, ptitiano@baylibre.com, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, zening.wang@nxp.com, aisheng.dong@nxp.com, khilman@baylibre.com, ccaione@baylibre.com, Alexandre Bailon <abailon@baylibre.com>
List-Id: linux-pm@vger.kernel.org

This adds a platform driver for the i.MX8MM SoC.

Signed-off-by: Alexandre Bailon <abailon@baylibre.com>
---
 drivers/interconnect/imx/Kconfig          |   4 +
 drivers/interconnect/imx/Makefile         |   1 +
 drivers/interconnect/imx/busfreq-imx8mm.c | 132 ++++++++++++++++++++++
 include/dt-bindings/interconnect/imx8mm.h |  37 ++++++
 4 files changed, 174 insertions(+)
 create mode 100644 drivers/interconnect/imx/busfreq-imx8mm.c
 create mode 100644 include/dt-bindings/interconnect/imx8mm.h

diff --git a/drivers/interconnect/imx/Kconfig b/drivers/interconnect/imx/Kconfig
index afd7b71bbd82..b569d40e5ca0 100644
--- a/drivers/interconnect/imx/Kconfig
+++ b/drivers/interconnect/imx/Kconfig
@@ -11,3 +11,7 @@ config BUSFREQ
 	  A generic interconnect driver that could be used for any i.MX.
 	  This provides a way to register master and slave and some opp
 	  to use when one or more master are in use.
+
+config BUSFREQ_IMX8MM
+	bool "i.MX8MM busfreq driver"
+	depends on BUSFREQ
diff --git a/drivers/interconnect/imx/Makefile b/drivers/interconnect/imx/Makefile
index fea647183815..a92fea6e042d 100644
--- a/drivers/interconnect/imx/Makefile
+++ b/drivers/interconnect/imx/Makefile
@@ -1 +1,2 @@
 obj-$(CONFIG_BUSFREQ) += busfreq.o
+obj-$(CONFIG_BUSFREQ_IMX8MM) += busfreq-imx8mm.o
diff --git a/drivers/interconnect/imx/busfreq-imx8mm.c b/drivers/interconnect/imx/busfreq-imx8mm.c
new file mode 100644
index 000000000000..c3b10a49dc29
--- /dev/null
+++ b/drivers/interconnect/imx/busfreq-imx8mm.c
@@ -0,0 +1,132 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Interconnect framework driver for i.MX SoC
+ *
+ * Copyright (c) 2019, BayLibre
+ * Author: Alexandre Bailon <abailon@baylibre.com>
+ */
+
+#include <linux/device.h>
+#include <linux/module.h>
+#include <linux/of_platform.h>
+#include <linux/platform_device.h>
+
+#include <dt-bindings/interconnect/imx8mm.h>
+
+#include "busfreq.h"
+
+static struct busfreq_icc_node imx8mm_icc_nodes[] = {
+	/* NOC */
+	DEFINE_BUS_MASTER("A53-0", IMX8MM_CPU_0, IMX8MM_NOC),
+	DEFINE_BUS_MASTER("A53-1", IMX8MM_CPU_1, IMX8MM_NOC),
+	DEFINE_BUS_MASTER("A53-2", IMX8MM_CPU_2, IMX8MM_NOC),
+	DEFINE_BUS_MASTER("A53-3", IMX8MM_CPU_3, IMX8MM_NOC),
+	DEFINE_BUS_MASTER("VPU H1", IMX8MM_VPU_H1, IMX8MM_NOC),
+	DEFINE_BUS_MASTER("VPU G1", IMX8MM_VPU_G1, IMX8MM_NOC),
+	DEFINE_BUS_MASTER("VPU G2", IMX8MM_VPU_G2, IMX8MM_NOC),
+	DEFINE_BUS_MASTER("MIPI", IMX8MM_MIPI, IMX8MM_NOC),
+	DEFINE_BUS_MASTER("USB-1", IMX8MM_USB_1, IMX8MM_NOC),
+	DEFINE_BUS_MASTER("USB-2", IMX8MM_USB_1, IMX8MM_NOC),
+	DEFINE_BUS_MASTER("GPU", IMX8MM_GPU, IMX8MM_NOC),
+	DEFINE_BUS_MASTER("PCIE", IMX8MM_PCIE, IMX8MM_NOC),
+	DEFINE_BUS_SLAVE("DRAM", IMX8MM_DRAM),
+	DEFINE_BUS_INTERCONNECT("NOC", IMX8MM_NOC, 1, IMX8MM_DRAM),
+
+	/* PL301 */
+	DEFINE_BUS_MASTER("SAI-1", IMX8MM_SAI1, IMX8MM_PL301),
+	DEFINE_BUS_MASTER("SAI-2", IMX8MM_SAI2, IMX8MM_PL301),
+	DEFINE_BUS_MASTER("SAI-3", IMX8MM_SAI3, IMX8MM_PL301),
+	DEFINE_BUS_MASTER("SAI-4", IMX8MM_SAI4, IMX8MM_PL301),
+	DEFINE_BUS_MASTER("SAI-5", IMX8MM_SAI5, IMX8MM_PL301),
+	DEFINE_BUS_MASTER("SAI-6", IMX8MM_SAI6, IMX8MM_PL301),
+	DEFINE_BUS_MASTER("SPDIF", IMX8MM_SPDIF, IMX8MM_PL301),
+	DEFINE_BUS_MASTER("FEC", IMX8MM_FEC, IMX8MM_PL301),
+	DEFINE_BUS_INTERCONNECT("PL301", IMX8MM_PL301, 1, IMX8MM_NOC),
+};
+
+static struct busfreq_opp_clk imx8mm_low_freq_clks[] = {
+	DEFINE_OPP_CLOCK("dram-alt", 100000000),
+	DEFINE_OPP_CLOCK("dram-apb", 40000000),
+	DEFINE_OPP_CLOCK("dram-core", 25000000),
+	DEFINE_OPP_CLOCK("noc", 150000000),
+	DEFINE_OPP_CLOCK("ahb", 22222222),
+	DEFINE_OPP_CLOCK("axi", 24000000),
+};
+
+static struct busfreq_opp_clk imx8mm_audio_freq_clks[] = {
+	DEFINE_OPP_CLOCK("dram-alt", 400000000),
+	DEFINE_OPP_CLOCK("dram-apb", 40000000),
+	DEFINE_OPP_CLOCK("dram-core", 100000000),
+	DEFINE_OPP_CLOCK("noc", 150000000),
+	DEFINE_OPP_CLOCK("ahb", 22222222),
+	DEFINE_OPP_CLOCK("axi", 24000000),
+};
+
+static struct busfreq_opp_bw imx8mm_audio_freq_nodes[] = {
+	DEFINE_OPP_NODE(IMX8MM_SAI1),
+	DEFINE_OPP_NODE(IMX8MM_SAI2),
+	DEFINE_OPP_NODE(IMX8MM_SAI3),
+	DEFINE_OPP_NODE(IMX8MM_SAI4),
+	DEFINE_OPP_NODE(IMX8MM_SAI5),
+	DEFINE_OPP_NODE(IMX8MM_SAI6),
+	DEFINE_OPP_NODE(IMX8MM_SPDIF),
+};
+
+static struct busfreq_opp_clk imx8mm_high_freq_clks[] = {
+	DEFINE_OPP_CLOCK("dram-apb", 800000000),
+	DEFINE_OPP_CLOCK("dram-core", 750000000),
+	DEFINE_OPP_CLOCK("noc", 750000000),
+	DEFINE_OPP_CLOCK("ahb", 133333333),
+	DEFINE_OPP_CLOCK("axi", 333000000),
+};
+
+static struct busfreq_opp_bw imx8mm_high_freq_nodes[] = {
+	DEFINE_OPP_NODE(IMX8MM_SAI1),
+	DEFINE_OPP_NODE(IMX8MM_SAI2),
+	DEFINE_OPP_NODE(IMX8MM_SAI3),
+	DEFINE_OPP_NODE(IMX8MM_SAI4),
+	DEFINE_OPP_NODE(IMX8MM_SAI5),
+	DEFINE_OPP_NODE(IMX8MM_SAI6),
+	DEFINE_OPP_NODE(IMX8MM_SPDIF),
+	DEFINE_OPP_NODE(IMX8MM_MIPI),
+};
+
+static struct busfreq_plat_opp imx8mm_opps[] = {
+	DEFINE_OPP_NO_NODES(imx8mm_low_freq_clks, false),
+	DEFINE_OPP(imx8mm_audio_freq_clks, imx8mm_audio_freq_nodes, false),
+	DEFINE_OPP(imx8mm_high_freq_clks, imx8mm_high_freq_nodes, true),
+};
+
+static int imx8mm_busfreq_probe(struct platform_device *pdev)
+{
+	int ret;
+
+	ret = busfreq_register(pdev, imx8mm_icc_nodes,
+			       ARRAY_SIZE(imx8mm_icc_nodes),
+			       imx8mm_opps, ARRAY_SIZE(imx8mm_opps));
+	return ret;
+}
+
+static int imx8mm_busfreq_remove(struct platform_device *pdev)
+{
+	return busfreq_unregister(pdev);
+}
+
+static const struct of_device_id busfreq_of_match[] = {
+	{ .compatible = "fsl,busfreq-imx8mm" },
+	{ },
+};
+MODULE_DEVICE_TABLE(of, busfreq_of_match);
+
+static struct platform_driver imx8mm_busfreq_driver = {
+	.probe = imx8mm_busfreq_probe,
+	.remove = imx8mm_busfreq_remove,
+	.driver = {
+		.name = "busfreq-imx8mm",
+		.of_match_table = busfreq_of_match,
+	},
+};
+
+builtin_platform_driver(imx8mm_busfreq_driver);
+MODULE_AUTHOR("Alexandre Bailon <abailon@baylibre.com>");
+MODULE_LICENSE("GPL v2");
diff --git a/include/dt-bindings/interconnect/imx8mm.h b/include/dt-bindings/interconnect/imx8mm.h
new file mode 100644
index 000000000000..4318ed319edc
--- /dev/null
+++ b/include/dt-bindings/interconnect/imx8mm.h
@@ -0,0 +1,37 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Interconnect framework driver for i.MX SoC
+ *
+ * Copyright (c) 2019, BayLibre
+ * Author: Alexandre Bailon <abailon@baylibre.com>
+ */
+
+#ifndef __IMX8MM_INTERCONNECT_IDS_H
+#define __IMX8MM_INTERCONNECT_IDS_H
+
+#define IMX8MM_NOC	0
+#define IMX8MM_CPU_0	1
+#define IMX8MM_CPU_1	2
+#define IMX8MM_CPU_2	3
+#define IMX8MM_CPU_3	4
+#define IMX8MM_VPU_H1	5
+#define IMX8MM_VPU_G1	6
+#define IMX8MM_VPU_G2	7
+#define IMX8MM_MIPI	8
+#define IMX8MM_USB_1	9
+#define IMX8MM_USB_2	10
+#define IMX8MM_PCIE	11
+#define IMX8MM_GPU	12
+#define IMX8MM_DRAM	13
+
+#define IMX8MM_PL301	100
+#define IMX8MM_SAI1	101
+#define IMX8MM_SAI2	102
+#define IMX8MM_SAI3	103
+#define IMX8MM_SAI4	104
+#define IMX8MM_SAI5	105
+#define IMX8MM_SAI6	106
+#define IMX8MM_SPDIF	107
+#define IMX8MM_FEC	108
+
+#endif /* __IMX8MM_INTERCONNECT_IDS_H */
-- 
2.19.2
