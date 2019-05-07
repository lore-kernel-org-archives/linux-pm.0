From: Leonard Crestez <leonard.crestez@nxp.com>
Subject: [PATCH v3 1/4] cpufreq: Add imx-cpufreq-dt driver
Date: Tue, 7 May 2019 13:52:22 +0000
Message-ID: <607242a278a4532d0b4285e0fb56abfd5767fdd1.1557236799.git.leonard.crestez@nxp.com>
References: <cover.1557236799.git.leonard.crestez@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <cover.1557236799.git.leonard.crestez@nxp.com>
Content-Language: en-US
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Viresh Kumar <viresh.kumar@linaro.org>, Lucas Stach <l.stach@pengutronix.de>, Rob Herring <robh+dt@kernel.org>
Cc: Aisheng Dong <aisheng.dong@nxp.com>, Mark Rutland <mark.rutland@arm.com>, Jacky Bai <ping.bai@nxp.com>, Anson Huang <anson.huang@nxp.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "Rafael
 J. Wysocki" <rjw@rjwysocki.net>, dl-linux-imx <linux-imx@nxp.com>, "kernel@pengutronix.de" <kernel@pengutronix.de>, Fabio Estevam <fabio.estevam@nxp.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Abel Vesa <abel.vesa@nxp.com>
List-Id: linux-pm@vger.kernel.org

Right now in upstream imx8m cpufreq support just lists a common subset
of OPPs because the higher ones should only be attempted after checking
speed grading in fuses.

Add a small driver which checks speed grading from nvmem cells before
registering cpufreq-dt.

This driver allows unlocking all frequencies for imx8mm and imx8mq and
could be applied to other chips like imx7d

Signed-off-by: Leonard Crestez <leonard.crestez@nxp.com>

---
 drivers/cpufreq/Kconfig.arm          | 10 +++
 drivers/cpufreq/Makefile             |  1 +
 drivers/cpufreq/cpufreq-dt-platdev.c |  3 +
 drivers/cpufreq/imx-cpufreq-dt.c     | 96 ++++++++++++++++++++++++++++
 drivers/soc/imx/soc-imx8.c           |  3 +
 5 files changed, 113 insertions(+)
 create mode 100644 drivers/cpufreq/imx-cpufreq-dt.c

diff --git a/drivers/cpufreq/Kconfig.arm b/drivers/cpufreq/Kconfig.arm
index 179a1d302f48..78ed9ef49e68 100644
--- a/drivers/cpufreq/Kconfig.arm
+++ b/drivers/cpufreq/Kconfig.arm
@@ -90,10 +90,20 @@ config ARM_IMX6Q_CPUFREQ
 	help
 	  This adds cpufreq driver support for Freescale i.MX6 series SoCs.
 
 	  If in doubt, say N.
 
+config ARM_IMX_CPUFREQ_DT
+	tristate "Freescale i.MX8M cpufreq support"
+	depends on ARCH_MXC && CPUFREQ_DT
+	default m if ARCH_MXC && CPUFREQ_DT
+	help
+	  This adds cpufreq driver support for Freescale i.MX8M series SoCs,
+	  based on cpufreq-dt.
+
+	  If in doubt, say N.
+
 config ARM_KIRKWOOD_CPUFREQ
 	def_bool MACH_KIRKWOOD
 	help
 	  This adds the CPUFreq driver for Marvell Kirkwood
 	  SoCs.
diff --git a/drivers/cpufreq/Makefile b/drivers/cpufreq/Makefile
index 689b26c6f949..7bcda2273d0c 100644
--- a/drivers/cpufreq/Makefile
+++ b/drivers/cpufreq/Makefile
@@ -54,10 +54,11 @@ obj-$(CONFIG_ARM_ARMADA_8K_CPUFREQ)	+= armada-8k-cpufreq.o
 obj-$(CONFIG_ARM_BRCMSTB_AVS_CPUFREQ)	+= brcmstb-avs-cpufreq.o
 obj-$(CONFIG_ACPI_CPPC_CPUFREQ)		+= cppc_cpufreq.o
 obj-$(CONFIG_ARCH_DAVINCI)		+= davinci-cpufreq.o
 obj-$(CONFIG_ARM_HIGHBANK_CPUFREQ)	+= highbank-cpufreq.o
 obj-$(CONFIG_ARM_IMX6Q_CPUFREQ)		+= imx6q-cpufreq.o
+obj-$(CONFIG_ARM_IMX_CPUFREQ_DT)	+= imx-cpufreq-dt.o
 obj-$(CONFIG_ARM_KIRKWOOD_CPUFREQ)	+= kirkwood-cpufreq.o
 obj-$(CONFIG_ARM_MEDIATEK_CPUFREQ)	+= mediatek-cpufreq.o
 obj-$(CONFIG_MACH_MVEBU_V7)		+= mvebu-cpufreq.o
 obj-$(CONFIG_ARM_OMAP2PLUS_CPUFREQ)	+= omap-cpufreq.o
 obj-$(CONFIG_ARM_PXA2xx_CPUFREQ)	+= pxa2xx-cpufreq.o
diff --git a/drivers/cpufreq/cpufreq-dt-platdev.c b/drivers/cpufreq/cpufreq-dt-platdev.c
index 47729a22c159..19c1aad57e26 100644
--- a/drivers/cpufreq/cpufreq-dt-platdev.c
+++ b/drivers/cpufreq/cpufreq-dt-platdev.c
@@ -106,10 +106,13 @@ static const struct of_device_id whitelist[] __initconst = {
  */
 static const struct of_device_id blacklist[] __initconst = {
 	{ .compatible = "calxeda,highbank", },
 	{ .compatible = "calxeda,ecx-2000", },
 
+	{ .compatible = "fsl,imx8mq", },
+	{ .compatible = "fsl,imx8mm", },
+
 	{ .compatible = "marvell,armadaxp", },
 
 	{ .compatible = "mediatek,mt2701", },
 	{ .compatible = "mediatek,mt2712", },
 	{ .compatible = "mediatek,mt7622", },
diff --git a/drivers/cpufreq/imx-cpufreq-dt.c b/drivers/cpufreq/imx-cpufreq-dt.c
new file mode 100644
index 000000000000..e1aa346efa10
--- /dev/null
+++ b/drivers/cpufreq/imx-cpufreq-dt.c
@@ -0,0 +1,96 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright 2019 NXP
+ */
+
+#include <linux/cpu.h>
+#include <linux/err.h>
+#include <linux/init.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/nvmem-consumer.h>
+#include <linux/of.h>
+#include <linux/platform_device.h>
+#include <linux/pm_opp.h>
+#include <linux/slab.h>
+
+#define OCOTP_CFG3_SPEED_GRADE_SHIFT	8
+#define OCOTP_CFG3_SPEED_GRADE_MASK	(0x3 << 8)
+#define OCOTP_CFG3_MKT_SEGMENT_SHIFT    6
+#define OCOTP_CFG3_MKT_SEGMENT_MASK     (0x3 << 6)
+
+static const struct of_device_id imx_cpufreq_dt_match_list[] = {
+	{ .compatible = "fsl,imx8mm" },
+	{ .compatible = "fsl,imx8mq" },
+	{}
+};
+
+/* cpufreq-dt device registered by imx-cpufreq-dt */
+static struct platform_device *cpufreq_dt_pdev;
+static struct opp_table *cpufreq_opp_table;
+
+static int imx_cpufreq_dt_probe(struct platform_device *pdev)
+{
+	struct device *cpu_dev = get_cpu_device(0);
+	struct device_node *np;
+	const struct of_device_id *match;
+	u32 cell_value, supported_hw[2];
+	int speed_grade, mkt_segment;
+	int ret;
+
+	np = of_find_node_by_path("/");
+	match = of_match_node(imx_cpufreq_dt_match_list, np);
+	of_node_put(np);
+	if (!match)
+		return -ENODEV;
+
+	ret = nvmem_cell_read_u32(cpu_dev, "speed_grade", &cell_value);
+	if (ret)
+		return ret;
+
+	speed_grade = (cell_value & OCOTP_CFG3_SPEED_GRADE_MASK) >> OCOTP_CFG3_SPEED_GRADE_SHIFT;
+	mkt_segment = (cell_value & OCOTP_CFG3_MKT_SEGMENT_MASK) >> OCOTP_CFG3_MKT_SEGMENT_SHIFT;
+	supported_hw[0] = BIT(speed_grade);
+	supported_hw[1] = BIT(mkt_segment);
+	dev_info(&pdev->dev, "cpu speed grade %d mkt segment %d supported-hw %#x %#x\n",
+			speed_grade, mkt_segment, supported_hw[0], supported_hw[1]);
+
+	cpufreq_opp_table = dev_pm_opp_set_supported_hw(cpu_dev, supported_hw, 2);
+	if (IS_ERR(cpufreq_opp_table)) {
+		ret = PTR_ERR(cpufreq_opp_table);
+		dev_err(&pdev->dev, "Failed to set supported opp: %d\n", ret);
+		return ret;
+	}
+
+	cpufreq_dt_pdev = platform_device_register_data(
+			&pdev->dev, "cpufreq-dt", -1, NULL, 0);
+	if (IS_ERR(cpufreq_dt_pdev)) {
+		dev_pm_opp_put_supported_hw(cpufreq_opp_table);
+		ret = PTR_ERR(cpufreq_dt_pdev);
+		dev_err(&pdev->dev, "Failed to register cpufreq-dt: %d\n", ret);
+		return ret;
+	}
+
+	return 0;
+}
+
+static int imx_cpufreq_dt_remove(struct platform_device *pdev)
+{
+	platform_device_unregister(cpufreq_dt_pdev);
+	dev_pm_opp_put_supported_hw(cpufreq_opp_table);
+
+	return 0;
+}
+
+static struct platform_driver imx_cpufreq_dt_driver = {
+	.probe = imx_cpufreq_dt_probe,
+	.remove = imx_cpufreq_dt_remove,
+	.driver = {
+		.name = "imx-cpufreq-dt",
+	},
+};
+module_platform_driver(imx_cpufreq_dt_driver);
+
+MODULE_ALIAS("platform:imx-cpufreq-dt");
+MODULE_DESCRIPTION("Freescale i.MX cpufreq speed grading driver");
+MODULE_LICENSE("GPL v2");
diff --git a/drivers/soc/imx/soc-imx8.c b/drivers/soc/imx/soc-imx8.c
index cd10726e64e4..02988bdfbb73 100644
--- a/drivers/soc/imx/soc-imx8.c
+++ b/drivers/soc/imx/soc-imx8.c
@@ -130,10 +130,13 @@ static int __init imx8_soc_init(void)
 
 	soc_dev = soc_device_register(soc_dev_attr);
 	if (IS_ERR(soc_dev))
 		goto free_rev;
 
+	if (IS_ENABLED(CONFIG_ARM_IMX_CPUFREQ_DT))
+		platform_device_register_simple("imx-cpufreq-dt", -1, NULL, 0);
+
 	return 0;
 
 free_rev:
 	kfree(soc_dev_attr->revision);
 free_soc:
-- 
2.17.1
