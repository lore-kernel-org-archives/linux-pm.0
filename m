From: Lina Iyer <lina.iyer@linaro.org>
Subject: [PATCH v3 11/15] drivers: firmware: psci: Allow OS Initiated suspend mode
Date: Thu,  4 Aug 2016 17:04:58 -0600
Message-ID: <1470351902-43103-12-git-send-email-lina.iyer@linaro.org>
References: <1470351902-43103-1-git-send-email-lina.iyer@linaro.org>
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <1470351902-43103-1-git-send-email-lina.iyer@linaro.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: ulf.hansson@linaro.org, khilman@kernel.org, rjw@rjwysocki.net, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: andy.gross@linaro.org, sboyd@codeaurora.org, linux-arm-msm@vger.kernel.org, Lina Iyer <lina.iyer@linaro.org>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Mark Rutland <mark.rutland@arm.com>
List-Id: linux-pm@vger.kernel.org

PSCI firmware v1.0 onwards may support 2 different modes for
CPU_SUSPEND. Platform coordinated mode is the default and every firmware
should support it. OS Initiated mode is optional for the firmware to
implement and allow Linux to make an better decision on the state of
the CPU cluster heirarchy.

With the kernel capable of deciding the state for CPU cluster and
coherency domains, the OS Initiated mode may now be used by the kernel,
provided the firmware supports it. SET_SUSPEND_MODE is a PSCI function
available on v1.0 onwards and can be used to set the mode in the
firmware.

Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Signed-off-by: Lina Iyer <lina.iyer@linaro.org>
[Ulf: Rebased on 4.7 rc1]
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/firmware/psci.c   | 22 +++++++++++++++++++++-
 include/uapi/linux/psci.h |  5 +++++
 2 files changed, 26 insertions(+), 1 deletion(-)

diff --git a/drivers/firmware/psci.c b/drivers/firmware/psci.c
index 03e0458..3920aba 100644
--- a/drivers/firmware/psci.c
+++ b/drivers/firmware/psci.c
@@ -52,6 +52,7 @@
  * require cooperation with a Trusted OS driver.
  */
 static int resident_cpu = -1;
+static bool psci_has_osi_pd;
 
 bool psci_tos_resident_on(int cpu)
 {
@@ -563,10 +564,29 @@ out_put_node:
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
+	ret = psci_features(psci_function_id[PSCI_FN_CPU_SUSPEND]);
+	if (ret & PSCI_1_0_OS_INITIATED) {
+		ret = psci_features(PSCI_1_0_FN_SET_SUSPEND_MODE);
+		if (!ret)
+			psci_has_osi_pd = true;
+	}
+
+	return 0;
+}
+
 static const struct of_device_id psci_of_match[] __initconst = {
 	{ .compatible = "arm,psci",	.data = psci_0_1_init},
 	{ .compatible = "arm,psci-0.2",	.data = psci_0_2_init},
-	{ .compatible = "arm,psci-1.0",	.data = psci_0_2_init},
+	{ .compatible = "arm,psci-1.0",	.data = psci_1_0_init},
 	{},
 };
 
diff --git a/include/uapi/linux/psci.h b/include/uapi/linux/psci.h
index 3d7a0fc..7dd778e 100644
--- a/include/uapi/linux/psci.h
+++ b/include/uapi/linux/psci.h
@@ -48,6 +48,7 @@
 
 #define PSCI_1_0_FN_PSCI_FEATURES		PSCI_0_2_FN(10)
 #define PSCI_1_0_FN_SYSTEM_SUSPEND		PSCI_0_2_FN(14)
+#define PSCI_1_0_FN_SET_SUSPEND_MODE		PSCI_0_2_FN(15)
 
 #define PSCI_1_0_FN64_SYSTEM_SUSPEND		PSCI_0_2_FN64(14)
 
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
2.7.4
