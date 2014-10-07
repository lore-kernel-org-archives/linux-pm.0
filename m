From: Lina Iyer <lina.iyer@linaro.org>
Subject: [PATCH v8 4/7] qcom: pm: Add cpu low power mode functions
Date: Tue,  7 Oct 2014 15:41:43 -0600
Message-ID: <1412718106-17049-5-git-send-email-lina.iyer@linaro.org>
References: <1412718106-17049-1-git-send-email-lina.iyer@linaro.org>
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <1412718106-17049-1-git-send-email-lina.iyer@linaro.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: daniel.lezcano@linaro.org, khilman@linaro.org, sboyd@codeaurora.org, galak@codeaurora.org, linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: lorenzo.pieralisi@arm.com, msivasub@codeaurora.org, devicetree@vger.kernel.org, Lina Iyer <lina.iyer@linaro.org>
List-Id: linux-pm@vger.kernel.org

Add interface layer to abstract and handle hardware specific
functionality for executing various cpu low power modes in QCOM
chipsets.

QCOM cpus support multiple low power modes. The C-States are defined as -

    * Standby
    * Retention (clock gating at lower power)
    * Standalone Power Collapse (Standalone PC or SPC) - The power to
    	the cpu is removed and core is reset upon resume.
    * Power Collapse (PC) - Same as SPC, but is a cognizant of the fact
    	that the SoC may do deeper sleep modes.

Support Standby and SPC for the currently available QCOM SoCs.

Based on work by: Mahesh Sivasubramanian <msivasub@codeaurora.org>,
Praveen Chidambaram <pchidamb@codeaurora.org>, Murali Nalajala
<mnalajal@codeaurora.org>
Original tree available at -
git://codeaurora.org/quic/la/kernel/msm-3.10.git

Signed-off-by: Lina Iyer <lina.iyer@linaro.org>
---
 drivers/soc/qcom/Makefile |   2 +-
 drivers/soc/qcom/pm.c     | 115 ++++++++++++++++++++++++++++++++++++++++++++++
 include/soc/qcom/pm.h     |  28 +++++++++++
 3 files changed, 144 insertions(+), 1 deletion(-)
 create mode 100644 drivers/soc/qcom/pm.c
 create mode 100644 include/soc/qcom/pm.h

diff --git a/drivers/soc/qcom/Makefile b/drivers/soc/qcom/Makefile
index 20b329f..19900ed 100644
--- a/drivers/soc/qcom/Makefile
+++ b/drivers/soc/qcom/Makefile
@@ -1,4 +1,4 @@
 obj-$(CONFIG_QCOM_GSBI)	+=	qcom_gsbi.o
-obj-$(CONFIG_QCOM_PM)	+=	spm.o
+obj-$(CONFIG_QCOM_PM)	+=	spm.o pm.o
 CFLAGS_scm.o :=$(call as-instr,.arch_extension sec,-DREQUIRES_SEC=1)
 obj-$(CONFIG_QCOM_SCM) += scm.o scm-boot.o
diff --git a/drivers/soc/qcom/pm.c b/drivers/soc/qcom/pm.c
new file mode 100644
index 0000000..1cb622e
--- /dev/null
+++ b/drivers/soc/qcom/pm.c
@@ -0,0 +1,115 @@
+/* Copyright (c) 2010-2014, The Linux Foundation. All rights reserved.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 and
+ * only version 2 as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ */
+
+#include <linux/kernel.h>
+#include <linux/init.h>
+#include <linux/platform_device.h>
+
+#include <asm/proc-fns.h>
+#include <asm/suspend.h>
+
+#include <soc/qcom/pm.h>
+#include <soc/qcom/scm.h>
+#include <soc/qcom/scm-boot.h>
+
+#define SCM_CMD_TERMINATE_PC	(0x2)
+#define SCM_FLUSH_FLAG_MASK	(0x3)
+#define SCM_L2_ON		(0x0)
+#define SCM_L2_OFF		(0x1)
+
+static int set_up_boot_address(void *entry, int cpu)
+{
+	static int flags[NR_CPUS] = {
+		SCM_FLAG_WARMBOOT_CPU0,
+		SCM_FLAG_WARMBOOT_CPU1,
+		SCM_FLAG_WARMBOOT_CPU2,
+		SCM_FLAG_WARMBOOT_CPU3,
+	};
+	static DEFINE_PER_CPU(void *, last_known_entry);
+	int ret;
+
+	if (entry == per_cpu(last_known_entry, cpu))
+		return 0;
+
+	ret = scm_set_boot_addr(virt_to_phys(entry), flags[cpu]);
+	if (!ret)
+		per_cpu(last_known_entry, cpu) = entry;
+
+	return ret;
+}
+
+static int qcom_pm_collapse(unsigned long int unused)
+{
+	int ret;
+	u32 flag;
+	int cpu = smp_processor_id();
+
+	ret = set_up_boot_address(cpu_resume, cpu);
+	if (ret) {
+		pr_err("Failed to set warm boot address for cpu %d\n", cpu);
+		return ret;
+	}
+
+	flag = SCM_L2_ON & SCM_FLUSH_FLAG_MASK;
+	scm_call_atomic1(SCM_SVC_BOOT, SCM_CMD_TERMINATE_PC, flag);
+
+	/**
+	 *  Returns here only if there was a pending interrupt and we did not
+	 *  power down as a result.
+	 */
+	return 0;
+}
+
+/**
+ * qcom_cpu_pm_enter_sleep(): Enter a low power mode on current cpu
+ *
+ * @mode - sleep mode to enter
+ *
+ * The code should be called with interrupts disabled and on the core on
+ * which the low power mode is to be executed.
+ *
+ */
+static int qcom_cpu_pm_enter_sleep(enum pm_sleep_mode mode)
+{
+	int ret;
+
+	ret = qcom_spm_set_low_power_mode(mode);
+	if (ret)
+		return ret;
+
+	switch (mode) {
+	case PM_SLEEP_MODE_SPC:
+		cpu_suspend(0, qcom_pm_collapse);
+		break;
+	default:
+	case PM_SLEEP_MODE_STBY:
+		cpu_do_idle();
+		break;
+	}
+
+	return 0;
+}
+
+static struct platform_device qcom_cpuidle_device = {
+	.name              = "qcom_cpuidle",
+	.id                = -1,
+	.dev.platform_data = qcom_cpu_pm_enter_sleep,
+};
+
+static int __init qcom_pm_device_init(void)
+{
+	platform_device_register(&qcom_cpuidle_device);
+
+	return 0;
+}
+module_init(qcom_pm_device_init);
diff --git a/include/soc/qcom/pm.h b/include/soc/qcom/pm.h
new file mode 100644
index 0000000..e63dc1c
--- /dev/null
+++ b/include/soc/qcom/pm.h
@@ -0,0 +1,28 @@
+/*
+ * Copyright (c) 2009-2014, The Linux Foundation. All rights reserved.
+ *
+ * This software is licensed under the terms of the GNU General Public
+ * License version 2, as published by the Free Software Foundation, and
+ * may be copied, distributed, and modified under those terms.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ */
+
+#ifndef __QCOM_PM_H
+#define __QCOM_PM_H
+
+enum pm_sleep_mode {
+	PM_SLEEP_MODE_STBY,
+	PM_SLEEP_MODE_RET,
+	PM_SLEEP_MODE_SPC,
+	PM_SLEEP_MODE_PC,
+	PM_SLEEP_MODE_NR,
+};
+
+int qcom_spm_set_low_power_mode(enum pm_sleep_mode mode);
+
+#endif  /* __QCOM_PM_H */
-- 
1.9.1
