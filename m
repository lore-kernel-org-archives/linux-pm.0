From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH V11 6/7] OPP: qcom: Add support to get performance states corresponding to OPPs
Date: Wed, 11 Oct 2017 12:54:18 +0530
Message-ID: <18686bc52546e9d73e5a08d6875dd80828cdd95e.1507703370.git.viresh.kumar@linaro.org>
References: <cover.1507703370.git.viresh.kumar@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1507703370.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1507703370.git.viresh.kumar@linaro.org>
References: <cover.1507703370.git.viresh.kumar@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>, ulf.hansson@linaro.org, Kevin Hilman <khilman@kernel.org>, Stephen Boyd <sboyd@codeaurora.org>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>, Nishanth Menon <nm@ti.com>, robh+dt@kernel.org, lina.iyer@linaro.org, rnayak@codeaurora.org, sudeep.holla@arm.com, linux-kernel@vger.kernel.org, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, Andy Gross <andy.gross@linaro.org>, David Brown <david.brown@linaro.org>
List-Id: linux-pm@vger.kernel.org

NOT FOR MERGE.

The OPP core needs to know the performance state for each OPP that the
device supports, if we want to update performance states of the device's
PM domain.

Add support for Qualcomm's rpmpd for the same.

Signed-off-by: Rajendra Nayak <rnayak@codeaurora.org>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/opp/Makefile     |   2 +
 drivers/opp/qcom-rpmpd.c | 107 +++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 109 insertions(+)
 create mode 100644 drivers/opp/qcom-rpmpd.c

diff --git a/drivers/opp/Makefile b/drivers/opp/Makefile
index e70ceb406fe9..b565031ce10f 100644
--- a/drivers/opp/Makefile
+++ b/drivers/opp/Makefile
@@ -2,3 +2,5 @@ ccflags-$(CONFIG_DEBUG_DRIVER)	:= -DDEBUG
 obj-y				+= core.o cpu.o
 obj-$(CONFIG_OF)		+= of.o
 obj-$(CONFIG_DEBUG_FS)		+= debugfs.o
+
+obj-$(CONFIG_QCOM_RPMPD)	+= qcom-rpmpd.o
diff --git a/drivers/opp/qcom-rpmpd.c b/drivers/opp/qcom-rpmpd.c
new file mode 100644
index 000000000000..ef301d7003d8
--- /dev/null
+++ b/drivers/opp/qcom-rpmpd.c
@@ -0,0 +1,107 @@
+/*
+ * Copyright (c) 2017, The Linux Foundation. All rights reserved.
+ *
+ * This software is licensed under the terms of the GNU General Public
+ * License version 2, as published by the Free Software Foundation, and
+ * may be copied, distributed, and modified under those terms.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ */
+
+#include <linux/err.h>
+#include <linux/init.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/of_platform.h>
+#include <linux/pm_opp.h>
+
+struct device;
+
+enum rpmpd_levels {
+	NONE,
+	LOWER,          /* SVS2 */
+	LOW,            /* SVS */
+	NOMINAL,        /* NOMINAL */
+	HIGH,           /* Turbo */
+	MAX_LEVEL,
+};
+
+struct rpmpd_freq_map {
+	struct device *dev;
+	unsigned long freq[MAX_LEVEL];
+};
+
+enum msm8996_devices {
+	SDHCI,
+};
+
+static struct rpmpd_freq_map msm8996_rpmpd_freq_map[] = {
+	[SDHCI] = {
+		.freq[LOWER] = 19200000,
+		.freq[LOW] = 200000000,
+		.freq[NOMINAL] = 400000000,
+	},
+};
+
+static int get_pstate(struct device *dev, unsigned long rate)
+{
+	int i, j;
+
+	for (i = 0; i < ARRAY_SIZE(msm8996_rpmpd_freq_map); i++) {
+		if (dev != msm8996_rpmpd_freq_map[i].dev)
+			continue;
+
+		for (j = 0; j < MAX_LEVEL; j++) {
+			if (msm8996_rpmpd_freq_map[i].freq[j] >= rate)
+				return j;
+		}
+
+		return MAX_LEVEL;
+	}
+
+	/* Bug */
+	WARN_ON(1);
+
+	return 0;
+}
+
+static const struct of_device_id devices[] = {
+	{ .compatible = "qcom,sdhci-msm-v4", .data = (void *)SDHCI },
+	{ }
+};
+
+static int __init rpmpd_opp_init(void)
+{
+	struct platform_device *pdev;
+	struct device_node *np;
+	int i, index;
+
+	if (!of_machine_is_compatible("qcom,msm8996-mtp"))
+		return 0;
+
+	for (i = 0; i < ARRAY_SIZE(devices); i++) {
+		np = of_find_compatible_node(NULL, NULL, devices[i].compatible);
+		if (!np)
+			continue;
+
+		pdev = of_find_device_by_node(np);
+		if (!pdev)
+			pdev = of_platform_device_create(np, NULL, NULL);
+
+		of_node_put(np);
+
+		if (!pdev)
+			continue;
+
+		index = (enum msm8996_devices)(devices[i].data);
+		msm8996_rpmpd_freq_map[index].dev = &pdev->dev;
+
+		dev_pm_opp_register_get_pstate_helper(&pdev->dev, get_pstate);
+	}
+
+	return 0;
+}
+subsys_initcall(rpmpd_opp_init);
-- 
2.7.4
