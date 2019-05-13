From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH 11/18] drivers: firmware: psci: Introduce psci_dt_topology_init()
Date: Mon, 13 May 2019 21:22:53 +0200
Message-ID: <20190513192300.653-12-ulf.hansson@linaro.org>
References: <20190513192300.653-1-ulf.hansson@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190513192300.653-1-ulf.hansson@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Sudeep Holla <sudeep.holla@arm.com>, Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>, Mark Rutland <mark.rutland@arm.com>, linux-arm-kernel@lists.infradead.org
Cc: "Rafael J . Wysocki" <rjw@rjwysocki.net>, Daniel Lezcano <daniel.lezcano@linaro.org>, "Raju P . L . S . S . S . N" <rplsssn@codeaurora.org>, Amit Kucheria <amit.kucheria@linaro.org>, Bjorn Andersson <bjorn.andersson@linaro.org>, Stephen Boyd <sboyd@kernel.org>, Niklas Cassel <niklas.cassel@linaro.org>, Tony Lindgren <tony@atomide.com>, Kevin Hilman <khilman@kernel.org>, Lina Iyer <ilina@codeaurora.org>, Viresh Kumar <viresh.kumar@linaro.org>, Vincent Guittot <vincent.guittot@linaro.org>, Geert Uytterhoeven <geert+renesas@glider.be>, Souvik Chakravarty <souvik.chakravarty@arm.com>, linux-pm@vger.kernel.org, linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>, Lina Iyer <lina.iyer@linaro.org>
List-Id: linux-pm@vger.kernel.org

To be able to initiate the PM domain data structures for PSCI at a specific
point during boot, let's export a new init function,
psci_dt_topology_init(). If CONFIG_CPU_IDLE is set, it calls
psci_dt_init_pm_domains(), which performs the actual initialization.

Note that, it may seem like feasible idea to hook into the existing
psci_dt_init() function, rather than adding a new separate init function.
However, this doesn't work because psci_dt_init() is called early in the
boot sequence, when allocating dynamic data structures isn't yet possible.

Subsequent changes calls this new init function.

Finally, following changes on top needs to know whether the hierarchical PM
domain topology is used or not. Therefore, let's store this information in
an internal PSCI flag.

Co-developed-by: Lina Iyer <lina.iyer@linaro.org>
Signed-off-by: Lina Iyer <lina.iyer@linaro.org>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---

Changes:
	- Moved some code inside "#ifdef CONFIG_CPU_IDLE".
	- Updated changelog.

---
 drivers/firmware/psci/psci.c | 30 ++++++++++++++++++++++++++++++
 include/linux/psci.h         |  2 ++
 2 files changed, 32 insertions(+)

diff --git a/drivers/firmware/psci/psci.c b/drivers/firmware/psci/psci.c
index bfef300b7ebe..28745234b53f 100644
--- a/drivers/firmware/psci/psci.c
+++ b/drivers/firmware/psci/psci.c
@@ -297,6 +297,7 @@ static int __init psci_features(u32 psci_func_id)
 #ifdef CONFIG_CPU_IDLE
 static DEFINE_PER_CPU_READ_MOSTLY(u32 *, psci_power_state);
 static DEFINE_PER_CPU(u32, domain_state);
+static bool psci_dt_topology;
 
 static inline u32 psci_get_domain_state(void)
 {
@@ -480,6 +481,19 @@ static const struct cpuidle_ops psci_cpuidle_ops __initconst = {
 
 CPUIDLE_METHOD_OF_DECLARE(psci, "psci", &psci_cpuidle_ops);
 #endif
+
+static int __init _psci_dt_topology_init(struct device_node *np)
+{
+	int ret;
+
+	/* Initialize the CPU PM domains based on topology described in DT. */
+	ret = psci_dt_init_pm_domains(np);
+	psci_dt_topology = ret > 0;
+
+	return ret;
+}
+#else
+static inline int _psci_dt_topology_init(struct device_node *np) { return 0; }
 #endif
 
 static int psci_system_suspend(unsigned long unused)
@@ -758,6 +772,22 @@ int __init psci_dt_init(void)
 	return ret;
 }
 
+int __init psci_dt_topology_init(void)
+{
+	struct device_node *np;
+	int ret;
+
+	np = of_find_matching_node_and_match(NULL, psci_of_match, NULL);
+	if (!np)
+		return -ENODEV;
+
+	/* Initialize the topology described in DT. */
+	ret = _psci_dt_topology_init(np);
+
+	of_node_put(np);
+	return ret;
+}
+
 #ifdef CONFIG_ACPI
 /*
  * We use PSCI 0.2+ when ACPI is deployed on ARM64 and it's
diff --git a/include/linux/psci.h b/include/linux/psci.h
index 4f29a3bff379..16beccccbbcc 100644
--- a/include/linux/psci.h
+++ b/include/linux/psci.h
@@ -55,8 +55,10 @@ extern struct psci_operations psci_ops;
 
 #if defined(CONFIG_ARM_PSCI_FW)
 int __init psci_dt_init(void);
+int __init psci_dt_topology_init(void);
 #else
 static inline int psci_dt_init(void) { return 0; }
+static inline int psci_dt_topology_init(void) { return 0; }
 #endif
 
 #if defined(CONFIG_ARM_PSCI_FW) && defined(CONFIG_ACPI)
-- 
2.17.1
