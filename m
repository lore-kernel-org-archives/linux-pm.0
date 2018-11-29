From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH v10 17/27] drivers: firmware: psci: Prepare to support PM domains
Date: Thu, 29 Nov 2018 18:46:50 +0100
Message-ID: <20181129174700.16585-18-ulf.hansson@linaro.org>
References: <20181129174700.16585-1-ulf.hansson@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181129174700.16585-1-ulf.hansson@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J . Wysocki" <rjw@rjwysocki.net>, Sudeep Holla <sudeep.holla@arm.com>, Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>, Mark Rutland <mark.rutland@arm.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, linux-pm@vger.kernel.org
Cc: "Raju P . L . S . S . S . N" <rplsssn@codeaurora.org>, Stephen Boyd <sboyd@kernel.org>, Tony Lindgren <tony@atomide.com>, Kevin Hilman <khilman@kernel.org>, Lina Iyer <ilina@codeaurora.org>, Ulf Hansson <ulf.hansson@linaro.org>, Viresh Kumar <viresh.kumar@linaro.org>, Vincent Guittot <vincent.guittot@linaro.org>, Geert Uytterhoeven <geert+renesas@glider.be>, linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Following changes are about to implement support for PM domains to PSCI.
Those changes are mainly going to be implemented in a new separate file,
hence a couple of the internal PSCI functions needs to be shared to be
accessible. So, let's do that via adding new PSCI header file.

Moreover, the changes deploying support for PM domains, needs to be able to
switch the PSCI FW into the OS initiated mode. For that reason, let's add a
new function that deals with this and share it via the new PSCI header
file.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---

Changes in v10:
	- New patch. Re-places the earlier patch: "drivers: firmware: psci:
	  Share a few internal PSCI functions".

---
 drivers/firmware/psci/psci.c | 28 +++++++++++++++++++++-------
 drivers/firmware/psci/psci.h | 14 ++++++++++++++
 2 files changed, 35 insertions(+), 7 deletions(-)
 create mode 100644 drivers/firmware/psci/psci.h

diff --git a/drivers/firmware/psci/psci.c b/drivers/firmware/psci/psci.c
index 8dbcdecc2ae4..623591b541a4 100644
--- a/drivers/firmware/psci/psci.c
+++ b/drivers/firmware/psci/psci.c
@@ -34,6 +34,8 @@
 #include <asm/smp_plat.h>
 #include <asm/suspend.h>
 
+#include "psci.h"
+
 /*
  * While a 64-bit OS can make calls with SMC32 calling conventions, for some
  * calls it is necessary to use SMC64 to pass or return 64-bit values.
@@ -90,23 +92,35 @@ static u32 psci_function_id[PSCI_FN_MAX];
 static DEFINE_PER_CPU(u32, domain_state);
 static u32 psci_cpu_suspend_feature;
 
-static inline u32 psci_get_domain_state(void)
+u32 psci_get_domain_state(void)
 {
 	return __this_cpu_read(domain_state);
 }
 
-static inline void psci_set_domain_state(u32 state)
+void psci_set_domain_state(u32 state)
 {
 	__this_cpu_write(domain_state, state);
 }
 
+bool psci_set_osi_mode(void)
+{
+	int ret;
+
+	ret = invoke_psci_fn(PSCI_1_0_FN_SET_SUSPEND_MODE,
+			PSCI_1_0_SUSPEND_MODE_OSI, 0, 0);
+	if (ret)
+		pr_warn("failed to enable OSI mode: %d\n", ret);
+
+	return !ret;
+}
+
 static inline bool psci_has_ext_power_state(void)
 {
 	return psci_cpu_suspend_feature &
 				PSCI_1_0_FEATURES_CPU_SUSPEND_PF_MASK;
 }
 
-static inline bool psci_has_osi_support(void)
+bool psci_has_osi_support(void)
 {
 	return psci_cpu_suspend_feature & PSCI_1_0_OS_INITIATED;
 }
@@ -285,10 +299,7 @@ static int __init psci_features(u32 psci_func_id)
 			      psci_func_id, 0, 0);
 }
 
-#ifdef CONFIG_CPU_IDLE
-static DEFINE_PER_CPU_READ_MOSTLY(u32 *, psci_power_state);
-
-static int psci_dt_parse_state_node(struct device_node *np, u32 *state)
+int psci_dt_parse_state_node(struct device_node *np, u32 *state)
 {
 	int err = of_property_read_u32(np, "arm,psci-suspend-param", state);
 
@@ -305,6 +316,9 @@ static int psci_dt_parse_state_node(struct device_node *np, u32 *state)
 	return 0;
 }
 
+#ifdef CONFIG_CPU_IDLE
+static DEFINE_PER_CPU_READ_MOSTLY(u32 *, psci_power_state);
+
 static int psci_dt_cpu_init_idle(struct cpuidle_driver *drv,
 			struct device_node *cpu_node, int cpu)
 {
diff --git a/drivers/firmware/psci/psci.h b/drivers/firmware/psci/psci.h
new file mode 100644
index 000000000000..7d9d38fd57e1
--- /dev/null
+++ b/drivers/firmware/psci/psci.h
@@ -0,0 +1,14 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+#ifndef __PSCI_H
+#define __PSCI_H
+
+struct device_node;
+
+bool psci_set_osi_mode(void);
+u32 psci_get_domain_state(void);
+void psci_set_domain_state(u32 state);
+bool psci_has_osi_support(void);
+int psci_dt_parse_state_node(struct device_node *np, u32 *state);
+
+#endif /* __PSCI_H */
-- 
2.17.1
