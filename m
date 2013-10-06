From: Barry Song <21cnbao@gmail.com>
Subject: [PATCH] cpuidle: sirf : Add cpuidle for SiRFprimaII and SiRFatlasVI
Date: Sun,  6 Oct 2013 12:26:17 +0800
Message-ID: <1381033577-19818-1-git-send-email-Baohua.Song@csr.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pb0-f41.google.com ([209.85.160.41]:56574 "EHLO
	mail-pb0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751136Ab3JFE0b (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sun, 6 Oct 2013 00:26:31 -0400
Received: by mail-pb0-f41.google.com with SMTP id rp2so5707397pbb.0
        for <linux-pm@vger.kernel.org>; Sat, 05 Oct 2013 21:26:30 -0700 (PDT)
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: rjw@sisk.pl, daniel.lezcano@linaro.org
Cc: linux-pm@vger.kernel.org, workgroup.linux@csr.com, Rongjun Ying <Rongjun.Ying@csr.com>, Barry Song <Baohua.Song@csr.com>

From: Rongjun Ying <Rongjun.Ying@csr.com>

This patch adds support cpuidle for CSR SiRFprimaII and SiRFatlasVI unicore
ARM Cortex-A9 SoCs.

Signed-off-by: Rongjun Ying <Rongjun.Ying@csr.com>
Signed-off-by: Barry Song <Baohua.Song@csr.com>
---
 - this patch depens on  Rongjun Ying's "[PATCH] cpufreq: sirf: Add cpufreq
 for SiRFprimaII and SiRFatlasVI" at:
 http://marc.info/?l=linux-pm&m=138103042106089&w=2

 arch/arm/configs/prima2_defconfig |   2 +
 drivers/cpuidle/Kconfig.arm       |   6 ++
 drivers/cpuidle/Makefile          |   1 +
 drivers/cpuidle/cpuidle-sirf.c    | 131 ++++++++++++++++++++++++++++++++++++++
 4 files changed, 140 insertions(+)
 create mode 100644 drivers/cpuidle/cpuidle-sirf.c

diff --git a/arch/arm/configs/prima2_defconfig b/arch/arm/configs/prima2_defconfig
index 513d75e..bc0bf1f 100644
--- a/arch/arm/configs/prima2_defconfig
+++ b/arch/arm/configs/prima2_defconfig
@@ -18,6 +18,8 @@ CONFIG_PREEMPT=y
 CONFIG_AEABI=y
 CONFIG_KEXEC=y
 CONFIG_CPU_FREQ=y
+CONFIG_CPU_IDLE=y
+CONFIG_ARM_SIRF_CPUIDLE=y
 CONFIG_BINFMT_MISC=y
 CONFIG_PM_RUNTIME=y
 CONFIG_UEVENT_HELPER_PATH="/sbin/hotplug"
diff --git a/drivers/cpuidle/Kconfig.arm b/drivers/cpuidle/Kconfig.arm
index 8e36603..c1f5fbf 100644
--- a/drivers/cpuidle/Kconfig.arm
+++ b/drivers/cpuidle/Kconfig.arm
@@ -15,6 +15,12 @@ config ARM_KIRKWOOD_CPUIDLE
 	help
 	  This adds the CPU Idle driver for Marvell Kirkwood SoCs.
 
+config ARM_SIRF_CPUIDLE
+	bool "CPU Idle Driver for CSR SiRFprimaII and CSRatlasVI SoCs"
+	depends on ARCH_SIRF
+	help
+	  This adds the CPU Idle driver for CSR SiRF SoCs.
+
 config ARM_ZYNQ_CPUIDLE
 	bool "CPU Idle Driver for Xilinx Zynq processors"
 	depends on ARCH_ZYNQ
diff --git a/drivers/cpuidle/Makefile b/drivers/cpuidle/Makefile
index cea5ef5..f8cce16 100644
--- a/drivers/cpuidle/Makefile
+++ b/drivers/cpuidle/Makefile
@@ -9,6 +9,7 @@ obj-$(CONFIG_ARCH_NEEDS_CPU_IDLE_COUPLED) += coupled.o
 # ARM SoC drivers
 obj-$(CONFIG_ARM_HIGHBANK_CPUIDLE)	+= cpuidle-calxeda.o
 obj-$(CONFIG_ARM_KIRKWOOD_CPUIDLE)	+= cpuidle-kirkwood.o
+obj-$(CONFIG_ARM_SIRF_CPUIDLE)		+= cpuidle-sirf.o
 obj-$(CONFIG_ARM_ZYNQ_CPUIDLE)		+= cpuidle-zynq.o
 obj-$(CONFIG_ARM_U8500_CPUIDLE)         += cpuidle-ux500.o
 obj-$(CONFIG_CPU_IDLE_BIG_LITTLE)	+= cpuidle-big_little.o
diff --git a/drivers/cpuidle/cpuidle-sirf.c b/drivers/cpuidle/cpuidle-sirf.c
new file mode 100644
index 0000000..fc1f71e
--- /dev/null
+++ b/drivers/cpuidle/cpuidle-sirf.c
@@ -0,0 +1,131 @@
+/*
+ * CPU idle drivers for CSR SiRFprimaII
+ *
+ * Copyright (c) 2011 Cambridge Silicon Radio Limited, a CSR plc group company.
+ *
+ * Licensed under GPLv2 or later.
+ */
+
+#include <linux/kernel.h>
+#include <linux/init.h>
+#include <linux/cpuidle.h>
+#include <linux/io.h>
+#include <linux/time.h>
+#include <asm/proc-fns.h>
+#include <linux/clk.h>
+#include <linux/err.h>
+#include <asm/cpuidle.h>
+#include <linux/regulator/consumer.h>
+#include <linux/cpu.h>
+#include <linux/opp.h>
+
+#define SIRFSOC_MAX_VOLTAGE	1200000
+
+/*
+ * now we have only 2 C state WFI
+ * 1. ARM WFI
+ * 2. WFI + switch to 26Mhz clock source + lower volatge
+ */
+
+static struct {
+	struct clk		*cpu_clk;
+	struct clk		*osc_clk;
+	struct regulator	*vcore_regulator;
+	struct device		*cpu_dev;
+} sirf_cpuidle;
+
+static int sirf_enter_idle(struct cpuidle_device *dev,
+				struct cpuidle_driver *drv,
+				int index)
+{
+	struct clk *parent_clk;
+	unsigned long volt_old = 0, volt_new, freq;
+	struct opp *opp;
+
+	local_irq_disable();
+	parent_clk = clk_get_parent(sirf_cpuidle.cpu_clk);
+	clk_set_parent(sirf_cpuidle.cpu_clk, sirf_cpuidle.osc_clk);
+
+	if (sirf_cpuidle.vcore_regulator) {
+		volt_old = regulator_get_voltage(sirf_cpuidle.vcore_regulator);
+
+		freq = clk_get_rate(sirf_cpuidle.osc_clk);
+		rcu_read_lock();
+		opp = opp_find_freq_ceil(sirf_cpuidle.cpu_dev, &freq);
+		if (IS_ERR(opp)) {
+			rcu_read_unlock();
+			return -EINVAL;
+		}
+
+		volt_new = opp_get_voltage(opp);
+		rcu_read_unlock();
+
+		regulator_set_voltage(sirf_cpuidle.vcore_regulator, volt_new,
+				SIRFSOC_MAX_VOLTAGE);
+	}
+	/* Wait for interrupt state */
+	cpu_do_idle();
+
+	if (sirf_cpuidle.vcore_regulator)
+		regulator_set_voltage(sirf_cpuidle.vcore_regulator, volt_old,
+				SIRFSOC_MAX_VOLTAGE);
+
+	clk_set_parent(sirf_cpuidle.cpu_clk, parent_clk);
+	/* Todo: other C states */
+
+	local_irq_enable();
+	return index;
+}
+
+static struct cpuidle_driver sirf_cpuidle_driver = {
+	.name = "sirf_cpuidle",
+	.states = {
+		ARM_CPUIDLE_WFI_STATE,
+		{
+			.name = "WFI-LP",
+			.desc = "WFI low power",
+			.flags = CPUIDLE_FLAG_TIME_VALID,
+			.exit_latency = 10,
+			.target_residency = 10000,
+			.enter = sirf_enter_idle,
+		},
+	},
+	.state_count = 2,
+};
+
+/* Initialize CPU idle by registering the idle states */
+static int sirfsoc_init_cpuidle(void)
+{
+	int ret = 0;
+
+	sirf_cpuidle.cpu_clk = clk_get_sys("cpu", NULL);
+	if (IS_ERR(sirf_cpuidle.cpu_clk))
+		return PTR_ERR(sirf_cpuidle.cpu_clk);
+
+	sirf_cpuidle.osc_clk = clk_get_sys("osc", NULL);
+	if (IS_ERR(sirf_cpuidle.osc_clk)) {
+		ret = PTR_ERR(sirf_cpuidle.osc_clk);
+		goto out_put_osc_clk;
+	}
+
+	sirf_cpuidle.vcore_regulator = regulator_get(NULL, "vcore");
+	if (IS_ERR(sirf_cpuidle.vcore_regulator))
+		sirf_cpuidle.vcore_regulator = NULL;
+
+	sirf_cpuidle.cpu_dev = get_cpu_device(0);
+	if (IS_ERR(sirf_cpuidle.cpu_dev)) {
+		ret = PTR_ERR(sirf_cpuidle.cpu_dev);
+		goto out_put_clk;
+	}
+
+	ret = cpuidle_register(&sirf_cpuidle_driver, NULL);
+	if (!ret)
+		return ret;
+
+out_put_clk:
+	clk_put(sirf_cpuidle.cpu_clk);
+out_put_osc_clk:
+	clk_put(sirf_cpuidle.osc_clk);
+	return ret;
+}
+late_initcall(sirfsoc_init_cpuidle);
-- 
1.8.2.3

