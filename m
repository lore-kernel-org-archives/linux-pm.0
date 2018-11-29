From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH v10 20/27] drivers: firmware: psci: Introduce psci_dt_topology_init()
Date: Thu, 29 Nov 2018 18:46:53 +0100
Message-ID: <20181129174700.16585-21-ulf.hansson@linaro.org>
References: <20181129174700.16585-1-ulf.hansson@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181129174700.16585-1-ulf.hansson@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J . Wysocki" <rjw@rjwysocki.net>, Sudeep Holla <sudeep.holla@arm.com>, Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>, Mark Rutland <mark.rutland@arm.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, linux-pm@vger.kernel.org
Cc: "Raju P . L . S . S . S . N" <rplsssn@codeaurora.org>, Stephen Boyd <sboyd@kernel.org>, Tony Lindgren <tony@atomide.com>, Kevin Hilman <khilman@kernel.org>, Lina Iyer <ilina@codeaurora.org>, Ulf Hansson <ulf.hansson@linaro.org>, Viresh Kumar <viresh.kumar@linaro.org>, Vincent Guittot <vincent.guittot@linaro.org>, Geert Uytterhoeven <geert+renesas@glider.be>, linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

To be able to initiate the PM domain data structures, let's export a new
init function, psci_dt_topology_init() and make it call
psci_dt_init_pm_domains(). Following changes to the ARM64 code, invokes
this new init function.

At first glance, it may seem like feasible idea to hook into the existing
psci_dt_init() function, instead of adding yet another init function for
PSCI. However, this doesn't work because psci_dt_init() is called early in
the boot sequence, which means allocating dynamic data structures isn't yet
possible.

Moreover, additional following changes need to understand whether the
hierarchical PM domain topology has been successfully initialized,
therefore let's store the result from the initialization attempt into an
internal PSCI flag.

Cc: Lina Iyer <ilina@codeaurora.org>
Co-developed-by: Lina Iyer <lina.iyer@linaro.org>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---

Changes in v10:
	- Simplified patch, by moving PSCI OSI related changes out into other
	  more appropriate patches.
	- Add a flag to store the result of the PM domain initialization.
	- Updated and clarified changelog.

---
 drivers/firmware/psci/psci.c | 18 ++++++++++++++++++
 include/linux/psci.h         |  2 ++
 2 files changed, 20 insertions(+)

diff --git a/drivers/firmware/psci/psci.c b/drivers/firmware/psci/psci.c
index 19af2093151b..5b481e91ccab 100644
--- a/drivers/firmware/psci/psci.c
+++ b/drivers/firmware/psci/psci.c
@@ -91,6 +91,7 @@ static u32 psci_function_id[PSCI_FN_MAX];
 
 static DEFINE_PER_CPU(u32, domain_state);
 static u32 psci_cpu_suspend_feature;
+static bool psci_dt_topology;
 
 u32 psci_get_domain_state(void)
 {
@@ -741,6 +742,23 @@ int __init psci_dt_init(void)
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
+	/* Initialize the CPU PM domains based on topology described in DT. */
+	ret = psci_dt_init_pm_domains(np);
+	psci_dt_topology = ret > 0;
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
