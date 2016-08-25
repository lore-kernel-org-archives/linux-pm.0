From: Lina Iyer <lina.iyer@linaro.org>
Subject: [PATCH v4 12/16] drivers: firmware: psci: Allow OS Initiated suspend mode
Date: Thu, 25 Aug 2016 14:03:21 -0600
Message-ID: <1472155405-41841-13-git-send-email-lina.iyer@linaro.org>
References: <1472155405-41841-1-git-send-email-lina.iyer@linaro.org>
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <1472155405-41841-1-git-send-email-lina.iyer@linaro.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: ulf.hansson@linaro.org, khilman@kernel.org, rjw@rjwysocki.net, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: andy.gross@linaro.org, sboyd@codeaurora.org, linux-arm-msm@vger.kernel.org, brendan.jackman@arm.com, lorenzo.pieralisi@arm.com, sudeep.holla@arm.com, Juri.Lelli@arm.com, Lina Iyer <lina.iyer@linaro.org>, Mark Rutland <mark.rutland@arm.com>
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
 drivers/firmware/psci.c   | 42 +++++++++++++++++++++++++++++-------------
 include/uapi/linux/psci.h |  5 +++++
 2 files changed, 34 insertions(+), 13 deletions(-)

diff --git a/drivers/firmware/psci.c b/drivers/firmware/psci.c
index 03e0458..759b134 100644
--- a/drivers/firmware/psci.c
+++ b/drivers/firmware/psci.c
@@ -52,6 +52,7 @@
  * require cooperation with a Trusted OS driver.
  */
 static int resident_cpu = -1;
+static bool psci_has_osi;
 
 bool psci_tos_resident_on(int cpu)
 {
@@ -506,9 +507,8 @@ static int __init psci_0_2_init(struct device_node *np)
 	int err;
 
 	err = get_set_conduit_method(np);
-
 	if (err)
-		goto out_put_node;
+		return err;
 	/*
 	 * Starting with v0.2, the PSCI specification introduced a call
 	 * (PSCI_VERSION) that allows probing the firmware version, so
@@ -516,11 +516,7 @@ static int __init psci_0_2_init(struct device_node *np)
 	 * can be carried out according to the specific version reported
 	 * by firmware
 	 */
-	err = psci_probe();
-
-out_put_node:
-	of_node_put(np);
-	return err;
+	return psci_probe();
 }
 
 /*
@@ -532,9 +528,8 @@ static int __init psci_0_1_init(struct device_node *np)
 	int err;
 
 	err = get_set_conduit_method(np);
-
 	if (err)
-		goto out_put_node;
+		return err;
 
 	pr_info("Using PSCI v0.1 Function IDs from DT\n");
 
@@ -558,15 +553,31 @@ static int __init psci_0_1_init(struct device_node *np)
 		psci_ops.migrate = psci_migrate;
 	}
 
-out_put_node:
-	of_node_put(np);
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
+		if (!psci_features(PSCI_1_0_FN_SET_SUSPEND_MODE))
+			psci_has_osi = true;
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
 
@@ -575,6 +586,7 @@ int __init psci_dt_init(void)
 	struct device_node *np;
 	const struct of_device_id *matched_np;
 	psci_initcall_t init_fn;
+	int ret;
 
 	np = of_find_matching_node_and_match(NULL, psci_of_match, &matched_np);
 
@@ -582,7 +594,11 @@ int __init psci_dt_init(void)
 		return -ENODEV;
 
 	init_fn = (psci_initcall_t)matched_np->data;
-	return init_fn(np);
+	ret = init_fn(np);
+
+	of_node_put(np);
+
+	return ret;
 }
 
 #ifdef CONFIG_ACPI
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
