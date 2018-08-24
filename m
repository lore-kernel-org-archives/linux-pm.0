From: "Raju P.L.S.S.S.N" <rplsssn@codeaurora.org>
Subject: [PATCH RFC 1/6] drivers: qcom: system_pm: add system PM client for RPMH based SoCs
Date: Sat, 25 Aug 2018 01:36:23 +0530
Message-ID: <1535141188-29731-2-git-send-email-rplsssn@codeaurora.org>
References: <1535141188-29731-1-git-send-email-rplsssn@codeaurora.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1535141188-29731-1-git-send-email-rplsssn@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
To: andy.gross@linaro.org, david.brown@linaro.org, linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org, linux-pm@vger.kernel.org
Cc: rnayak@codeaurora.org, bjorn.andersson@linaro.org, linux-kernel@vger.kernel.org, lorenzo.pieralisi@arm.com, rafael@kernel.org, drake@endlessm.com, sboyd@kernel.org, evgreen@chromium.org, dianders@chromium.org, mka@chromium.org, ilina@codeaurora.org, "Raju P.L.S.S.S.N" <rplsssn@codeaurora.org>
List-Id: linux-pm@vger.kernel.org

RPMH based targets require that the sleep and wake state request votes
be sent during system low power mode entry. The votes help reduce the
power consumption when the AP is not using them. The votes sent by the
clients are cached in RPMH controller and needs to be flushed by a sleep
manager. So add system power manager client for RPMH client and invoke
RPMH flush when last core is being powered off by listening to
cpu_pm_notifications.

Signed-off-by: Raju P.L.S.S.S.N <rplsssn@codeaurora.org>
---
 drivers/soc/qcom/Kconfig     | 11 ++++++
 drivers/soc/qcom/Makefile    |  1 +
 drivers/soc/qcom/system_pm.c | 82 ++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 94 insertions(+)
 create mode 100644 drivers/soc/qcom/system_pm.c

diff --git a/drivers/soc/qcom/Kconfig b/drivers/soc/qcom/Kconfig
index 3223084..a52abe9 100644
--- a/drivers/soc/qcom/Kconfig
+++ b/drivers/soc/qcom/Kconfig
@@ -78,6 +78,7 @@ config QCOM_RMTFS_MEM
 config QCOM_RPMH
 	bool "Qualcomm RPM-Hardened (RPMH) Communication"
 	depends on ARCH_QCOM && ARM64 && OF || COMPILE_TEST
+	select QCOM_SYSTEM_PM
 	help
 	  Support for communication with the hardened-RPM blocks in
 	  Qualcomm Technologies Inc (QTI) SoCs. RPMH communication uses an
@@ -85,6 +86,16 @@ config QCOM_RPMH
 	  of hardware components aggregate requests for these resources and
 	  help apply the aggregated state on the resource.
 
+config QCOM_SYSTEM_PM
+	bool "Qualcomm System PM"
+	depends on CPU_PM && QCOM_RPMH
+	help
+	  Support for QCOM platform system power management to perform tasks
+	  necessary while application processor votes for deeper modes so that
+	  the firmware can enter SoC level low power modes to save power.
+	  Deeper low power modes can be voted during idle power management or
+	  pm suspend state.
+
 config QCOM_SMEM
 	tristate "Qualcomm Shared Memory Manager (SMEM)"
 	depends on ARCH_QCOM
diff --git a/drivers/soc/qcom/Makefile b/drivers/soc/qcom/Makefile
index 03d4c83..27d79d2 100644
--- a/drivers/soc/qcom/Makefile
+++ b/drivers/soc/qcom/Makefile
@@ -12,6 +12,7 @@ obj-$(CONFIG_QCOM_RMTFS_MEM)	+= rmtfs_mem.o
 obj-$(CONFIG_QCOM_RPMH)		+= qcom_rpmh.o
 qcom_rpmh-y			+= rpmh-rsc.o
 qcom_rpmh-y			+= rpmh.o
+obj-$(CONFIG_QCOM_SYSTEM_PM) += system_pm.o
 obj-$(CONFIG_QCOM_SMD_RPM)	+= smd-rpm.o
 obj-$(CONFIG_QCOM_SMEM) +=	smem.o
 obj-$(CONFIG_QCOM_SMEM_STATE) += smem_state.o
diff --git a/drivers/soc/qcom/system_pm.c b/drivers/soc/qcom/system_pm.c
new file mode 100644
index 0000000..40e5aa7
--- /dev/null
+++ b/drivers/soc/qcom/system_pm.c
@@ -0,0 +1,82 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2018, The Linux Foundation. All rights reserved.
+ */
+
+#include <linux/cpu_pm.h>
+#include <linux/kernel.h>
+#include <linux/platform_device.h>
+
+#include <soc/qcom/rpmh.h>
+
+static struct cpumask cpu_pm_state_mask;
+static raw_spinlock_t cpu_pm_state_lock;
+
+static struct device *sys_pm_dev;
+
+static int sys_pm_notifier(struct notifier_block *b,
+			       unsigned long cmd, void *v)
+{
+	switch (cmd) {
+	case CPU_PM_ENTER:
+		raw_spin_lock(&cpu_pm_state_lock);
+		cpumask_set_cpu(smp_processor_id(), &cpu_pm_state_mask);
+		if (cpumask_equal(&cpu_pm_state_mask, cpu_possible_mask)) {
+			if (rpmh_ctrlr_idle(sys_pm_dev)) {
+				/* Flush the sleep/wake sets */
+				rpmh_flush(sys_pm_dev);
+			} else {
+				pr_err("%s:rpmh controller is busy\n",
+						__func__);
+				raw_spin_unlock(&cpu_pm_state_lock);
+				return NOTIFY_BAD;
+			}
+		}
+		raw_spin_unlock(&cpu_pm_state_lock);
+		break;
+	case CPU_PM_EXIT:
+	case CPU_PM_ENTER_FAILED:
+		raw_spin_lock(&cpu_pm_state_lock);
+		cpumask_clear_cpu(smp_processor_id(), &cpu_pm_state_mask);
+		raw_spin_unlock(&cpu_pm_state_lock);
+		break;
+	default:
+		return NOTIFY_DONE;
+	}
+
+	return NOTIFY_OK;
+}
+
+static struct notifier_block sys_pm_notifier_block = {
+	.notifier_call = sys_pm_notifier,
+	.priority = -1, /* Should be last in the order of notifications */
+};
+
+static int sys_pm_probe(struct platform_device *pdev)
+{
+	sys_pm_dev = &pdev->dev;
+
+	if (IS_ERR_OR_NULL(sys_pm_dev)) {
+		pr_err("%s fail\n", __func__);
+		return PTR_ERR(sys_pm_dev);
+	}
+
+	raw_spin_lock_init(&cpu_pm_state_lock);
+	cpu_pm_register_notifier(&sys_pm_notifier_block);
+
+	return 0;
+}
+
+static const struct of_device_id sys_pm_drv_match[] = {
+	{ .compatible = "qcom,system-pm", },
+	{ }
+};
+
+static struct platform_driver sys_pm_driver = {
+	.probe = sys_pm_probe,
+	.driver = {
+		.name = KBUILD_MODNAME,
+		.of_match_table = sys_pm_drv_match,
+	},
+};
+builtin_platform_driver(sys_pm_driver);
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum, hosted by The Linux Foundation.
