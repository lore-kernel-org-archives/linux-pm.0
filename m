From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH v6 18/25] drivers: firmware: psci: Share a few internal PSCI functions
Date: Wed, 14 Mar 2018 17:58:28 +0100
Message-ID: <1521046715-30683-19-git-send-email-ulf.hansson@linaro.org>
References: <1521046715-30683-1-git-send-email-ulf.hansson@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1521046715-30683-1-git-send-email-ulf.hansson@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J . Wysocki" <rjw@rjwysocki.net>, Sudeep Holla <sudeep.holla@arm.com>, Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>, linux-pm@vger.kernel.org
Cc: Kevin Hilman <khilman@kernel.org>, Lina Iyer <ilina@codeaurora.org>, Lina Iyer <lina.iyer@linaro.org>, Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh+dt@kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, Thomas Gleixner <tglx@linutronix.de>, Vincent Guittot <vincent.guittot@linaro.org>, Stephen Boyd <sboyd@kernel.org>, Juri Lelli <juri.lelli@arm.com>, Geert Uytterhoeven <geert+renesas@glider.be>, linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Following changes needs to be able to call psci_get|set_domain_state() and
psci_dt_parse_state_node(), but from a separate file. Let's make that
possible by sharing them via a new internal PSCI header file.

Cc: Lina Iyer <ilina@codeaurora.org>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/firmware/psci.c | 14 ++++++++------
 drivers/firmware/psci.h | 13 +++++++++++++
 2 files changed, 21 insertions(+), 6 deletions(-)
 create mode 100644 drivers/firmware/psci.h

diff --git a/drivers/firmware/psci.c b/drivers/firmware/psci.c
index 40b2b89..463f78c 100644
--- a/drivers/firmware/psci.c
+++ b/drivers/firmware/psci.c
@@ -34,6 +34,8 @@
 #include <asm/smp_plat.h>
 #include <asm/suspend.h>
 
+#include "psci.h"
+
 /*
  * While a 64-bit OS can make calls with SMC32 calling conventions, for some
  * calls it is necessary to use SMC64 to pass or return 64-bit values.
@@ -90,12 +92,12 @@ static u32 psci_function_id[PSCI_FN_MAX];
 static DEFINE_PER_CPU(u32, domain_state);
 static u32 psci_cpu_suspend_feature;
 
-static inline u32 psci_get_domain_state(void)
+u32 psci_get_domain_state(void)
 {
 	return this_cpu_read(domain_state);
 }
 
-static inline void psci_set_domain_state(u32 state)
+void psci_set_domain_state(u32 state)
 {
 	this_cpu_write(domain_state, state);
 }
@@ -285,10 +287,7 @@ static int __init psci_features(u32 psci_func_id)
 			      psci_func_id, 0, 0);
 }
 
-#ifdef CONFIG_CPU_IDLE
-static DEFINE_PER_CPU_READ_MOSTLY(u32 *, psci_power_state);
-
-static int psci_dt_parse_state_node(struct device_node *np, u32 *state)
+int psci_dt_parse_state_node(struct device_node *np, u32 *state)
 {
 	int err = of_property_read_u32(np, "arm,psci-suspend-param", state);
 
@@ -305,6 +304,9 @@ static int psci_dt_parse_state_node(struct device_node *np, u32 *state)
 	return 0;
 }
 
+#ifdef CONFIG_CPU_IDLE
+static DEFINE_PER_CPU_READ_MOSTLY(u32 *, psci_power_state);
+
 static int psci_dt_cpu_init_idle(struct device_node *cpu_node, int cpu)
 {
 	int i, ret = 0, count = 0;
diff --git a/drivers/firmware/psci.h b/drivers/firmware/psci.h
new file mode 100644
index 0000000..a2b4be5
--- /dev/null
+++ b/drivers/firmware/psci.h
@@ -0,0 +1,13 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#ifndef __PSCI_H
+#define __PSCI_H
+
+struct device_node;
+
+u32 psci_get_domain_state(void);
+void psci_set_domain_state(u32 state);
+
+int psci_dt_parse_state_node(struct device_node *np, u32 *state);
+
+#endif /* __PSCI_H */
-- 
2.7.4
