From: Abel Vesa <abel.vesa@nxp.com>
Subject: [PATCH 2/2] soc: imx8: Add cpufreq registering and speed grading
 check for i.MX8MQ
Date: Tue, 12 Feb 2019 12:21:36 +0000
Message-ID: <1549974071-8284-2-git-send-email-abel.vesa@nxp.com>
References: <1549974071-8284-1-git-send-email-abel.vesa@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1549974071-8284-1-git-send-email-abel.vesa@nxp.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>, Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <kernel@pengutronix.de>
Cc: Fabio Estevam <fabio.estevam@nxp.com>, dl-linux-imx <linux-imx@nxp.com>, Lucas Stach <l.stach@pengutronix.de>, Rob Herring <robh@kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Anson Huang <anson.huang@nxp.com>, Abel Vesa <abel.vesa@nxp.com>
List-Id: linux-pm@vger.kernel.org

From: Anson Huang <Anson.Huang@nxp.com>

Register cpu-freq platform driver for i.MX8.
i.MX8MQ has different parts like consumer, industrial and auto etc.,
different parts have different cpufreq set-points, this patch adds
fuse check to select correct cpufreq set-points for each part. The
default dtb has all set-points available, then kernel will check fuse
to disable those unused set-points, definition as below:

OCOTP offset 0x440, bit [7:6]

'00' - Consumer 0C to 95C
'01' - Ext. Consumer -20C to 105C
'10' - Industrial -40C to 105C
'11' - Automotive -40C to 125C

cpu-freq set-points definition as below (datasheet Rev-E):

		Normal		Over-Drive
Consumer	1GHz@0.9V	1.5GHz@1V
Industrial	800MHz@0.9V	1.3GHz@1V

Signed-off-by: Anson Huang <anson.huang@nxp.com>
Signed-off-by: Abel Vesa <abel.vesa@nxp.com>
---
 drivers/soc/imx/Makefile   |   1 +
 drivers/soc/imx/soc-imx8.c | 107 +++++++++++++++++++++++++++++++++++++++++=
++++
 2 files changed, 108 insertions(+)
 create mode 100644 drivers/soc/imx/soc-imx8.c

diff --git a/drivers/soc/imx/Makefile b/drivers/soc/imx/Makefile
index 506a6f3..d6b529e0 100644
--- a/drivers/soc/imx/Makefile
+++ b/drivers/soc/imx/Makefile
@@ -1,2 +1,3 @@
 obj-$(CONFIG_HAVE_IMX_GPC) +=3D gpc.o
 obj-$(CONFIG_IMX_GPCV2_PM_DOMAINS) +=3D gpcv2.o
+obj-$(CONFIG_ARCH_MXC) +=3D soc-imx8.o
diff --git a/drivers/soc/imx/soc-imx8.c b/drivers/soc/imx/soc-imx8.c
new file mode 100644
index 0000000..3896310
--- /dev/null
+++ b/drivers/soc/imx/soc-imx8.c
@@ -0,0 +1,107 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright 2019 NXP.
+ */
+
+#include <linux/cpu.h>
+#include <linux/init.h>
+#include <linux/io.h>
+#include <linux/of_address.h>
+#include <linux/pm_opp.h>
+#include <linux/slab.h>
+#include <linux/sys_soc.h>
+#include <linux/platform_device.h>
+#include <linux/of.h>
+
+#define OCOTP_CFG3			0x440
+#define OCOTP_CFG3_MKT_SEGMENT_SHIFT	6
+#define OCOTP_CFG3_CONSUMER		0
+#define OCOTP_CFG3_EXT_CONSUMER		1
+#define OCOTP_CFG3_INDUSTRIAL		2
+#define OCOTP_CFG3_AUTO			3
+
+static void __init imx8mq_opp_check_speed_grading(struct device *cpu_dev)
+{
+	struct device_node *np;
+	void __iomem *base;
+	u32 val;
+
+	np =3D of_find_compatible_node(NULL, NULL, "fsl,imx8mq-ocotp");
+	if (!np) {
+		pr_warn("failed to find ocotp node\n");
+		return;
+	}
+
+	base =3D of_iomap(np, 0);
+	if (!base) {
+		pr_warn("failed to map ocotp\n");
+		goto put_node;
+	}
+	val =3D readl_relaxed(base + OCOTP_CFG3);
+	val >>=3D OCOTP_CFG3_MKT_SEGMENT_SHIFT;
+	val &=3D 0x3;
+
+	switch (val) {
+	case OCOTP_CFG3_CONSUMER:
+		if (dev_pm_opp_disable(cpu_dev, 800000000))
+			pr_warn("failed to disable 800MHz OPP!\n");
+		if (dev_pm_opp_disable(cpu_dev, 1300000000))
+			pr_warn("failed to disable 1.3GHz OPP!\n");
+		break;
+	case OCOTP_CFG3_INDUSTRIAL:
+		if (dev_pm_opp_disable(cpu_dev, 1000000000))
+			pr_warn("failed to disable 1GHz OPP!\n");
+		if (dev_pm_opp_disable(cpu_dev, 1500000000))
+			pr_warn("failed to disable 1.5GHz OPP!\n");
+		break;
+	default:
+		/* consumer part for default */
+		if (dev_pm_opp_disable(cpu_dev, 800000000))
+			pr_warn("failed to disable 800MHz OPP!\n");
+		if (dev_pm_opp_disable(cpu_dev, 1300000000))
+			pr_warn("failed to disable 1.3GHz OPP!\n");
+		break;
+	}
+
+	iounmap(base);
+
+put_node:
+	of_node_put(np);
+}
+
+static void __init imx8mq_opp_init(void)
+{
+	struct device_node *np;
+	struct device *cpu_dev =3D get_cpu_device(0);
+
+	if (!cpu_dev) {
+		pr_warn("failed to get cpu0 device\n");
+		return;
+	}
+	np =3D of_node_get(cpu_dev->of_node);
+	if (!np) {
+		pr_warn("failed to find cpu0 node\n");
+		return;
+	}
+
+	if (dev_pm_opp_of_add_table(cpu_dev)) {
+		pr_warn("failed to init OPP table\n");
+		goto put_node;
+	}
+
+	imx8mq_opp_check_speed_grading(cpu_dev);
+
+put_node:
+	of_node_put(np);
+}
+
+static int __init imx8_register_cpufreq(void)
+{
+	if (of_machine_is_compatible("fsl,imx8mq")) {
+		imx8mq_opp_init();
+		platform_device_register_simple("imx8mq-cpufreq", -1, NULL, 0);
+	}
+
+	return 0;
+}
+late_initcall(imx8_register_cpufreq);
--=20
2.7.4
