From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [RFC V1 2/8] cpufreq: Create cpufreq platform-device based on "compatible" from DT
Date: Mon,  1 Dec 2014 17:11:23 +0530
Message-ID: <061f06ab89fc2b93796edf0b3548022efaf6e760.1417433163.git.viresh.kumar@linaro.org>
References: <cover.1417433163.git.viresh.kumar@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pd0-f172.google.com ([209.85.192.172]:52790 "EHLO
	mail-pd0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753388AbaLALl5 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 1 Dec 2014 06:41:57 -0500
Received: by mail-pd0-f172.google.com with SMTP id y13so10738532pdi.17
        for <linux-pm@vger.kernel.org>; Mon, 01 Dec 2014 03:41:56 -0800 (PST)
In-Reply-To: <cover.1417433163.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1417433163.git.viresh.kumar@linaro.org>
References: <cover.1417433163.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>, Arnd Bergmann <arnd.bergmann@linaro.org>, Rob Herring <rob.herring@linaro.org>, Grant Likely <grant.likely@linaro.org>
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, Nishanth Menon <nm@ti.com>, Sudeep Holla <Sudeep.Holla@arm.com>, Stephen Boyd <sboyd@codeaurora.org>, devicetree@vger.kernel.org, santosh shilimkar <santosh.shilimkar@oracle.com>, Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>, Mike Turquette <mike.turquette@linaro.org>, kesavan.abhilash@gmail.com, catalin.marinas@arm.com, k.chander@samsung.com, olof@lixom.net, ta.omasab@gmail.com, linux-arm-kernel@lists.infradead.org, Viresh Kumar <viresh.kumar@linaro.org>

DT based cpufreq drivers doesn't require much support from platform code now a
days as most of the stuff is moved behind generic APIs. Like clk APIs for
changing clock rates, regulator APIs for changing voltages, etc.

One of the bottleneck still left was how to select which cpufreq driver to probe
for a given platform as there might be multiple drivers available.

Traditionally, we used to create platform devices from machine specific code
which binds with a cpufreq driver. And while we moved towards DT based device
creation, these devices stayed as is.

The problem is getting worse now as we have architectures now with Zero platform
specific code. Forcefully these platforms have to create a new file in
drivers/cpufreq/ to just add these platform devices in order to use the generic
drivers like cpufreq-dt.c.

This has been discussed again and again, but with no solution yet. Last it was
discussed here:

http://lists.infradead.org/pipermail/linux-arm-kernel/2014-May/256154.html

This patch creates a separate file which will be responsible for creating
cpufreq platform device based on the match with "compatible" property from DT.

A Blacklist is also provided for backward compatibility with older DTs.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/Makefile    |  2 +-
 drivers/cpufreq/dt_device.c | 52 +++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 53 insertions(+), 1 deletion(-)
 create mode 100644 drivers/cpufreq/dt_device.c

diff --git a/drivers/cpufreq/Makefile b/drivers/cpufreq/Makefile
index b3ca7b0..d6feb0b 100644
--- a/drivers/cpufreq/Makefile
+++ b/drivers/cpufreq/Makefile
@@ -1,6 +1,6 @@
 # CPUfreq core
 obj-$(CONFIG_CPU_FREQ)			+= cpufreq.o freq_table.o
-obj-$(CONFIG_PM_OPP)			+= cpufreq_opp.o
+obj-$(CONFIG_PM_OPP)			+= cpufreq_opp.o dt_device.o
 
 # CPUfreq stats
 obj-$(CONFIG_CPU_FREQ_STAT)             += cpufreq_stats.o
diff --git a/drivers/cpufreq/dt_device.c b/drivers/cpufreq/dt_device.c
new file mode 100644
index 0000000..7800968
--- /dev/null
+++ b/drivers/cpufreq/dt_device.c
@@ -0,0 +1,52 @@
+/*
+ * Creates platform device for probing cpufreq driver
+ *
+ * Copyright (C) 2014 Linaro.
+ * Viresh Kumar <viresh.kumar@linaro.org>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * This program is distributed "as is" WITHOUT ANY WARRANTY of any
+ * kind, whether express or implied; without even the implied warranty
+ * of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
+ * GNU General Public License for more details.
+ */
+
+#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
+
+#include <linux/of_device.h>
+
+static const struct of_device_id compatible_machine_match[] = {
+	/* All new machines must have the below compatible to use this driver */
+	{ .compatible = "cpufreq-dt",		.data = "cpufreq-dt" },
+	{ .compatible = "arm-bL-cpufreq-dt",	.data = "arm-bL-cpufreq-dt" },
+
+	/* BLACKLIST of existing users of cpufreq-dt below */
+
+	/* BLACKLIST of existing users of arm-bL-cpufreq-dt below */
+
+	/* BLACKLIST of existing users of other drivers below */
+
+	{},
+};
+
+static int cpufreq_dt_create_platform_device(void)
+{
+	struct device_node *root = of_find_node_by_path("/");
+	const struct of_device_id *match;
+
+	match = of_match_node(compatible_machine_match, root);
+	if (!match) {
+		pr_debug("%s: Couldn't find a match\n", __func__);
+		return -ENODEV;
+	}
+
+	pr_debug("%s: Create device for compatible:%s, driver:%s\n", __func__,
+		 match->compatible, (char *)match->data);
+	platform_device_register_simple(match->data, -1, NULL, 0);
+
+	return 0;
+}
+late_initcall(cpufreq_dt_create_platform_device);
-- 
2.0.3.693.g996b0fd

