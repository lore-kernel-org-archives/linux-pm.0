From: Lina Iyer <lina.iyer@linaro.org>
Subject: [RFC v3 09/12] drivers: firmware: psci: Allow OS Initiated suspend mode
Date: Tue,  1 Mar 2016 14:15:28 -0700
Message-ID: <1456866931-37851-11-git-send-email-lina.iyer@linaro.org>
References: <1456866931-37851-1-git-send-email-lina.iyer@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f179.google.com ([209.85.192.179]:33152 "EHLO
	mail-pf0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753711AbcCAVQY (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 1 Mar 2016 16:16:24 -0500
Received: by mail-pf0-f179.google.com with SMTP id 124so58014711pfg.0
        for <linux-pm@vger.kernel.org>; Tue, 01 Mar 2016 13:16:24 -0800 (PST)
In-Reply-To: <1456866931-37851-1-git-send-email-lina.iyer@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: ulf.hansson@linaro.org, khilman@kernel.org, rjw@rjwysocki.net, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: geert@linux-m68k.org, k.kozlowski@samsung.com, msivasub@codeaurora.org, agross@codeaurora.org, sboyd@codeaurora.org, linux-arm-msm@vger.kernel.org, lorenzo.pieralisi@arm.com, ahaslam@baylibre.com, mtitinger@baylibre.com, Lina Iyer <lina.iyer@linaro.org>, Mark Rutland <mark.rutland@arm.com>

PSCI firmware v1.0 onwards may support 2 different modes for
CPU_SUSPEND. Platform coordinated mode is the default and every firmware
should support it. The firmware shall also be the default mode.

With the kernel capable of deciding the state for CPU cluster and
coherency domains, the OS Initiated mode may now be used by the kernel,
provided the firmware supports it. SET_SUSPEND_MODE is a PSCI function
available on v1.0 onwards and can be used to set the mode in the
firmware.

Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Signed-off-by: Lina Iyer <lina.iyer@linaro.org>
---
 drivers/firmware/psci.c   | 45 ++++++++++++++++++++++++++++++++++++++++++++-
 include/linux/psci.h      |  2 ++
 include/uapi/linux/psci.h |  5 +++++
 3 files changed, 51 insertions(+), 1 deletion(-)

diff --git a/drivers/firmware/psci.c b/drivers/firmware/psci.c
index f25cd79..03c084e 100644
--- a/drivers/firmware/psci.c
+++ b/drivers/firmware/psci.c
@@ -49,12 +49,19 @@
  * require cooperation with a Trusted OS driver.
  */
 static int resident_cpu = -1;
+static bool has_osi_pd;
+static bool psci_suspend_mode_is_osi;
 
 bool psci_tos_resident_on(int cpu)
 {
 	return cpu == resident_cpu;
 }
 
+bool psci_has_osi_pd_support(void)
+{
+	return has_osi_pd;
+}
+
 struct psci_operations psci_ops;
 
 typedef unsigned long (psci_fn)(unsigned long, unsigned long,
@@ -250,6 +257,26 @@ static int psci_system_suspend(unsigned long unused)
 			      virt_to_phys(cpu_resume), 0, 0);
 }
 
+int psci_set_suspend_mode_osi(bool enable)
+{
+	int ret;
+	int mode;
+
+	if (enable && !psci_has_osi_pd_support())
+		return -ENODEV;
+
+	if (enable == psci_suspend_mode_is_osi)
+		return 0;
+
+	mode = enable ? PSCI_1_0_SUSPEND_MODE_OSI : PSCI_1_0_SUSPEND_MODE_PC;
+	ret = invoke_psci_fn(PSCI_FN_NATIVE(1_0, SET_SUSPEND_MODE),
+			     mode, 0, 0);
+	if (!ret)
+		psci_suspend_mode_is_osi = enable;
+
+	return psci_to_linux_errno(ret);
+}
+
 static int psci_system_suspend_enter(suspend_state_t state)
 {
 	return cpu_suspend(0, psci_system_suspend);
@@ -443,10 +470,26 @@ out_put_node:
 	return err;
 }
 
+static int __init psci_1_0_init(struct device_node *np)
+{
+	int ret;
+
+	ret = psci_0_2_init(np);
+	if (ret)
+		return ret;
+
+	/* Check if PSCI OSI mode is available */
+	ret = psci_features(PSCI_FN_NATIVE(0_2, CPU_SUSPEND));
+	if (ret & PSCI_1_0_OS_INITIATED)
+		has_osi_pd = true;
+
+	return 0;
+}
+
 static const struct of_device_id const psci_of_match[] __initconst = {
 	{ .compatible = "arm,psci",	.data = psci_0_1_init},
 	{ .compatible = "arm,psci-0.2",	.data = psci_0_2_init},
-	{ .compatible = "arm,psci-1.0",	.data = psci_0_2_init},
+	{ .compatible = "arm,psci-1.0",	.data = psci_1_0_init},
 	{},
 };
 
diff --git a/include/linux/psci.h b/include/linux/psci.h
index 12c4865..deae633 100644
--- a/include/linux/psci.h
+++ b/include/linux/psci.h
@@ -23,6 +23,8 @@
 bool psci_tos_resident_on(int cpu);
 bool psci_power_state_loses_context(u32 state);
 bool psci_power_state_is_valid(u32 state);
+bool psci_has_osi_pd_support(void);
+int psci_set_suspend_mode_osi(bool enable);
 
 struct psci_operations {
 	int (*cpu_suspend)(u32 state, unsigned long entry_point);
diff --git a/include/uapi/linux/psci.h b/include/uapi/linux/psci.h
index 3d7a0fc..eaab6e3 100644
--- a/include/uapi/linux/psci.h
+++ b/include/uapi/linux/psci.h
@@ -50,6 +50,7 @@
 #define PSCI_1_0_FN_SYSTEM_SUSPEND		PSCI_0_2_FN(14)
 
 #define PSCI_1_0_FN64_SYSTEM_SUSPEND		PSCI_0_2_FN64(14)
+#define PSCI_1_0_FN64_SET_SUSPEND_MODE		PSCI_0_2_FN64(15)
 
 /* PSCI v0.2 power state encoding for CPU_SUSPEND function */
 #define PSCI_0_2_POWER_STATE_ID_MASK		0xffff
@@ -93,6 +94,10 @@
 #define PSCI_1_0_FEATURES_CPU_SUSPEND_PF_MASK	\
 			(0x1 << PSCI_1_0_FEATURES_CPU_SUSPEND_PF_SHIFT)
 
+#define PSCI_1_0_OS_INITIATED			BIT(0)
+#define PSCI_1_0_SUSPEND_MODE_PC		0
+#define PSCI_1_0_SUSPEND_MODE_OSI		1
+
 /* PSCI return values (inclusive of all PSCI versions) */
 #define PSCI_RET_SUCCESS			0
 #define PSCI_RET_NOT_SUPPORTED			-1
-- 
2.1.4

