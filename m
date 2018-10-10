From: "Raju P.L.S.S.S.N" <rplsssn@codeaurora.org>
Subject: [PATCH RFC v1 4/8] drivers: qcom: cpu_pd: add cpu power domain support using genpd
Date: Thu, 11 Oct 2018 02:50:51 +0530
Message-ID: <1539206455-29342-5-git-send-email-rplsssn@codeaurora.org>
References: <1539206455-29342-1-git-send-email-rplsssn@codeaurora.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1539206455-29342-1-git-send-email-rplsssn@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
To: andy.gross@linaro.org, david.brown@linaro.org, rjw@rjwysocki.net, ulf.hansson@linaro.org, khilman@kernel.org, linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org
Cc: rnayak@codeaurora.org, bjorn.andersson@linaro.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, sboyd@kernel.org, evgreen@chromium.org, dianders@chromium.org, mka@chromium.org, ilina@codeaurora.org, "Raju P.L.S.S.S.N" <rplsssn@codeaurora.org>
List-Id: linux-pm@vger.kernel.org

RPMH based targets require that the sleep and wake state request votes
be sent during system low power mode entry. The votes help reduce the
power consumption when the AP is not using them. The votes sent by the
clients are cached in RPMH controller and needs to be flushed when the
last cpu enters low power mode. So add cpu power domain using Linux
generic power domain infrastructure to perform necessary tasks as part
of domain power down.

Suggested-by: Lina Iyer <ilina@codeaurora.org>
Signed-off-by: Raju P.L.S.S.S.N <rplsssn@codeaurora.org>
---
 drivers/soc/qcom/Kconfig  |   9 ++++
 drivers/soc/qcom/Makefile |   1 +
 drivers/soc/qcom/cpu_pd.c | 104 ++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 114 insertions(+)
 create mode 100644 drivers/soc/qcom/cpu_pd.c

diff --git a/drivers/soc/qcom/Kconfig b/drivers/soc/qcom/Kconfig
index ba79b60..91e8b3b 100644
--- a/drivers/soc/qcom/Kconfig
+++ b/drivers/soc/qcom/Kconfig
@@ -95,6 +95,7 @@ config QCOM_RMTFS_MEM
 config QCOM_RPMH
 	bool "Qualcomm RPM-Hardened (RPMH) Communication"
 	depends on ARCH_QCOM && ARM64 && OF || COMPILE_TEST
+	select QCOM_CPU_PD
 	help
 	  Support for communication with the hardened-RPM blocks in
 	  Qualcomm Technologies Inc (QTI) SoCs. RPMH communication uses an
@@ -102,6 +103,14 @@ config QCOM_RPMH
 	  of hardware components aggregate requests for these resources and
 	  help apply the aggregated state on the resource.
 
+config QCOM_CPU_PD
+    bool "Qualcomm cpu power domain driver"
+    depends on QCOM_RPMH && PM_GENERIC_DOMAINS || COMPILE_TEST
+    help
+	  Support for QCOM platform cpu power management to perform tasks
+	  necessary while application processor votes for deeper modes so that
+	  the firmware can enter SoC level low power modes to save power.
+
 config QCOM_SMEM
 	tristate "Qualcomm Shared Memory Manager (SMEM)"
 	depends on ARCH_QCOM
diff --git a/drivers/soc/qcom/Makefile b/drivers/soc/qcom/Makefile
index f25b54c..57a1b0e 100644
--- a/drivers/soc/qcom/Makefile
+++ b/drivers/soc/qcom/Makefile
@@ -12,6 +12,7 @@ obj-$(CONFIG_QCOM_RMTFS_MEM)	+= rmtfs_mem.o
 obj-$(CONFIG_QCOM_RPMH)		+= qcom_rpmh.o
 qcom_rpmh-y			+= rpmh-rsc.o
 qcom_rpmh-y			+= rpmh.o
+obj-$(CONFIG_QCOM_CPU_PD) += cpu_pd.o
 obj-$(CONFIG_QCOM_SMD_RPM)	+= smd-rpm.o
 obj-$(CONFIG_QCOM_SMEM) +=	smem.o
 obj-$(CONFIG_QCOM_SMEM_STATE) += smem_state.o
diff --git a/drivers/soc/qcom/cpu_pd.c b/drivers/soc/qcom/cpu_pd.c
new file mode 100644
index 0000000..565c510
--- /dev/null
+++ b/drivers/soc/qcom/cpu_pd.c
@@ -0,0 +1,104 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2018, The Linux Foundation. All rights reserved.
+ */
+
+#include <linux/of_platform.h>
+#include <linux/pm_domain.h>
+#include <linux/slab.h>
+
+#include <soc/qcom/rpmh.h>
+
+static struct device *cpu_pd_dev;
+
+static int cpu_pd_power_off(struct generic_pm_domain *domain)
+{
+	if (rpmh_ctrlr_idle(cpu_pd_dev)) {
+		/* Flush the sleep/wake sets */
+		rpmh_flush(cpu_pd_dev);
+	} else {
+		pr_debug("rpmh controller is busy\n");
+		return -EBUSY;
+	}
+
+	return 0;
+}
+
+static int cpu_pm_domain_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct device_node *np = dev->of_node;
+	struct generic_pm_domain *cpu_pd;
+	int ret = -EINVAL, cpu;
+
+	if (!np) {
+		dev_err(dev, "device tree node not found\n");
+		return -ENODEV;
+	}
+
+	if (!of_find_property(np, "#power-domain-cells", NULL)) {
+		pr_err("power-domain-cells not found\n");
+		return -ENODEV;
+	}
+
+	cpu_pd_dev = &pdev->dev;
+	if (IS_ERR_OR_NULL(cpu_pd_dev))
+		return PTR_ERR(cpu_pd_dev);
+
+	cpu_pd = devm_kzalloc(dev, sizeof(*cpu_pd), GFP_KERNEL);
+	if (!cpu_pd)
+		return -ENOMEM;
+
+	cpu_pd->name = kasprintf(GFP_KERNEL, "%s", np->name);
+	if (!cpu_pd->name)
+		goto free_cpu_pd;
+	cpu_pd->name = kbasename(cpu_pd->name);
+	cpu_pd->power_off = cpu_pd_power_off;
+	cpu_pd->flags |= GENPD_FLAG_IRQ_SAFE;
+
+	ret = pm_genpd_init(cpu_pd, NULL, false);
+	if (ret)
+		goto free_name;
+
+	ret = of_genpd_add_provider_simple(np, cpu_pd);
+	if (ret)
+		goto remove_pd;
+
+	pr_info("init PM domain %s\n", cpu_pd->name);
+
+	for_each_present_cpu(cpu) {
+		ret = of_genpd_attach_cpu(cpu);
+		if (ret)
+			goto detach_cpu;
+	}
+	return 0;
+
+detach_cpu:
+	of_genpd_detach_cpu(cpu);
+
+remove_pd:
+	pm_genpd_remove(cpu_pd);
+
+free_name:
+	kfree(cpu_pd->name);
+
+free_cpu_pd:
+	kfree(cpu_pd);
+	cpu_pd_dev = NULL;
+	pr_err("failed to init PM domain ret=%d %pOF\n", ret, np);
+	return ret;
+}
+
+static const struct of_device_id cpu_pd_drv_match[] = {
+	{ .compatible = "qcom,cpu-pm-domain", },
+	{ }
+};
+
+static struct platform_driver cpu_pm_domain_driver = {
+	.probe = cpu_pm_domain_probe,
+	.driver	= {
+		.name = "cpu_pm_domain",
+		.of_match_table = cpu_pd_drv_match,
+	},
+};
+builtin_platform_driver(cpu_pm_domain_driver);
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of the Code Aurora Forum, hosted by The Linux Foundation.
