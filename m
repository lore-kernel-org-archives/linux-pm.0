From: Leonard Crestez <leonard.crestez@nxp.com>
Subject: [RFC] cpufreq: Add imx-cpufreq-dt driver
Date: Thu, 25 Apr 2019 10:29:11 +0000
Message-ID: <83a3ade389239bd492ee646aa4868c5e37e65434.1556187603.git.leonard.crestez@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
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
To: Viresh Kumar <viresh.kumar@linaro.org>, Lucas Stach <l.stach@pengutronix.de>
Cc: Aisheng Dong <aisheng.dong@nxp.com>, Abel Vesa <abel.vesa@nxp.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, dl-linux-imx <linux-imx@nxp.com>, "kernel@pengutronix.de" <kernel@pengutronix.de>, Fabio Estevam <fabio.estevam@nxp.com>, Shawn Guo <shawnguo@kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-pm@vger.kernel.org

Right now in upstream imx8m cpufreq support just lists a common subset
of OPPs because the higher ones should only be attempted after checking
speed grading in fuses.

This is not a reasonable limitation and means we must still carry a
separate cpufreq driver in NXP tree.

This is a small driver which checks speed grading from nvmem before
registering cpufreq-dt. Unlike imx6q-cpufreq and various other rejected
imx7/8 cpufreq drivers it contains no actual frequency switching code,
just fuse reading through nvmem API.

Code is inspired by similar cpufreq wrappers from a dozen different
vendors. Currently for imx8mm but same issue applies to imx8mq and
others.

Signed-off-by: Leonard Crestez <leonard.crestez@nxp.com>

---
 drivers/cpufreq/Kconfig.arm          |   5 ++
 drivers/cpufreq/Makefile             |   1 +
 drivers/cpufreq/cpufreq-dt-platdev.c |   2 +
 drivers/cpufreq/imx-cpufreq-dt.c     | 101 +++++++++++++++++++++++++++
 4 files changed, 109 insertions(+)
 create mode 100644 drivers/cpufreq/imx-cpufreq-dt.c

Since nvmem is a module this driver also needs to be turned into a
proper module, right now it will simply fail if nvmem is unavailable at
init time. Let me know if you agree with this approach before I turn it
into a module.

In vendor tree this is done in soc driver but many other vendors do it
in drivers/cpufreq so this is where it belongs.

This is select by default in Kconfig, if anything fails then regular
cpufreq-dt is not available. This is intentional because higher OPPs are
potentially unstable.

diff --git a/drivers/cpufreq/Kconfig.arm b/drivers/cpufreq/Kconfig.arm
index 179a1d302f48..4a098a6befb2 100644
--- a/drivers/cpufreq/Kconfig.arm
+++ b/drivers/cpufreq/Kconfig.arm
@@ -90,10 +90,15 @@ config ARM_IMX6Q_CPUFREQ
 	help
 	  This adds cpufreq driver support for Freescale i.MX6 series SoCs.
 
 	  If in doubt, say N.
 
+config ARM_IMX_CPUFREQ_DT
+	bool "Freescale i.MX8MM cpufreq support"
+	depends on CPUFREQ_DT && ARCH_MXC
+	default y
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
index 47729a22c159..b84baeb1bf1b 100644
--- a/drivers/cpufreq/cpufreq-dt-platdev.c
+++ b/drivers/cpufreq/cpufreq-dt-platdev.c
@@ -106,10 +106,12 @@ static const struct of_device_id whitelist[] __initconst = {
  */
 static const struct of_device_id blacklist[] __initconst = {
 	{ .compatible = "calxeda,highbank", },
 	{ .compatible = "calxeda,ecx-2000", },
 
+	{ .compatible = "fsl,imx8mm", },
+
 	{ .compatible = "marvell,armadaxp", },
 
 	{ .compatible = "mediatek,mt2701", },
 	{ .compatible = "mediatek,mt2712", },
 	{ .compatible = "mediatek,mt7622", },
diff --git a/drivers/cpufreq/imx-cpufreq-dt.c b/drivers/cpufreq/imx-cpufreq-dt.c
new file mode 100644
index 000000000000..c341308a8142
--- /dev/null
+++ b/drivers/cpufreq/imx-cpufreq-dt.c
@@ -0,0 +1,101 @@
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
+
+#define OCOTP_CFG3_MKT_SEGMENT_SHIFT	6
+#define OCOTP_CFG3_MKT_SEGMENT_MASK	(0x3 << 6)
+
+#define OCOTP_CFG3_CONSUMER		0
+#define OCOTP_CFG3_EXT_CONSUMER		1
+#define OCOTP_CFG3_INDUSTRIAL		2
+#define OCOTP_CFG3_AUTO			3
+
+#define OCOTP_CFG3_8MM_SPEED_0P8GHZ	0
+#define OCOTP_CFG3_8MM_SPEED_1P2GHZ	1
+#define OCOTP_CFG3_8MM_SPEED_1P6GHZ	2
+#define OCOTP_CFG3_8MM_SPEED_1P8GHZ	3
+
+static int imx8mm_opp_check_speed_grading(struct device *cpu_dev)
+{
+	u32 val, speed_grade, mkt_segment;
+	int ret = 0;
+
+	ret = nvmem_cell_read_u32(cpu_dev, "speed_grade", &val);
+	if (ret)
+		return ret;
+
+	speed_grade = (val & OCOTP_CFG3_SPEED_GRADE_MASK) >> OCOTP_CFG3_SPEED_GRADE_SHIFT;
+	mkt_segment = (val & OCOTP_CFG3_MKT_SEGMENT_MASK) >> OCOTP_CFG3_MKT_SEGMENT_SHIFT;
+
+	dev_info(cpu_dev, "imx8mm cpu speed grade %d segment %d\n",
+			speed_grade, mkt_segment);
+
+	switch (mkt_segment) {
+	case OCOTP_CFG3_CONSUMER:
+		if (speed_grade < OCOTP_CFG3_8MM_SPEED_1P8GHZ)
+			if (dev_pm_opp_disable(cpu_dev, 1800000000))
+				pr_warn("failed to disable 1.8GHz OPP!\n");
+		if (speed_grade < OCOTP_CFG3_8MM_SPEED_1P6GHZ)
+			if (dev_pm_opp_disable(cpu_dev, 1600000000))
+				pr_warn("failed to disable 1.6GHz OPP!\n");
+		break;
+	case OCOTP_CFG3_INDUSTRIAL:
+		if (dev_pm_opp_disable(cpu_dev, 1800000000))
+			pr_warn("failed to disable 1.8GHz OPP!\n");
+		if (val < OCOTP_CFG3_8MM_SPEED_1P6GHZ)
+			if (dev_pm_opp_disable(cpu_dev, 1600000000))
+				pr_warn("failed to disable 1.6GHz OPP!\n");
+		break;
+	default:
+		break;
+	}
+
+	return ret;
+}
+
+static const struct of_device_id imx_cpufreq_dt_match_list[] __initconst = {
+	{ .compatible = "fsl,imx8mm", .data = imx8mm_opp_check_speed_grading },
+	{}
+};
+
+static int __init imx_cpufreq_dt_init(void)
+{
+	struct device_node *np;
+	const struct of_device_id *id;
+	struct device *cpu_dev = get_cpu_device(0);
+	u32 (*check_speed_grading)(struct device *);
+	int ret;
+
+       	np = of_find_node_by_path("/");
+	id = of_match_node(imx_cpufreq_dt_match_list, np);
+	of_node_put(np);
+	if (!id)
+		return -ENODEV;
+
+	check_speed_grading = id->data;
+	if ((ret = check_speed_grading(cpu_dev))) {
+		dev_err(cpu_dev, "Failed to check speed grading: %d\n", ret);
+		return ret;
+	}
+
+	return PTR_ERR_OR_ZERO(platform_device_register_simple(
+			"cpufreq-dt", -1, NULL, 0));
+}
+late_initcall(imx_cpufreq_dt_init);
+
+MODULE_LICENSE("GPL v2");
-- 
2.17.1
