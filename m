From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH v10 24/27] drivers: firmware: psci: Support CPU hotplug for the hierarchical model
Date: Thu, 29 Nov 2018 18:46:57 +0100
Message-ID: <20181129174700.16585-25-ulf.hansson@linaro.org>
References: <20181129174700.16585-1-ulf.hansson@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181129174700.16585-1-ulf.hansson@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J . Wysocki" <rjw@rjwysocki.net>, Sudeep Holla <sudeep.holla@arm.com>, Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>, Mark Rutland <mark.rutland@arm.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, linux-pm@vger.kernel.org
Cc: "Raju P . L . S . S . S . N" <rplsssn@codeaurora.org>, Stephen Boyd <sboyd@kernel.org>, Tony Lindgren <tony@atomide.com>, Kevin Hilman <khilman@kernel.org>, Lina Iyer <ilina@codeaurora.org>, Ulf Hansson <ulf.hansson@linaro.org>, Viresh Kumar <viresh.kumar@linaro.org>, Vincent Guittot <vincent.guittot@linaro.org>, Geert Uytterhoeven <geert+renesas@glider.be>, linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

When the hierarchical CPU topology is used and when a CPU has been put
offline (hotplug), that same CPU prevents its PM domain and thus also
potential master PM domains, from being powered off. This is because genpd
observes the CPU's struct device to remain being active from a runtime PM
point of view.

To deal with this, let's decrease the runtime PM usage count by calling
pm_runtime_put_sync_suspend() of the CPU's struct device when putting it
offline. Consequentially, we must then increase the runtime PM usage for
the CPU, while putting it online again.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---

Changes in v10:
	- Make it work when the hierarchical CPU topology is used, which may be
	  used both for OSI and PC mode.
	- Rework the code to prevent "BUG: sleeping function called from
	  invalid context".
---
 drivers/firmware/psci/psci.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/drivers/firmware/psci/psci.c b/drivers/firmware/psci/psci.c
index b03bccce0a5d..f62c4963eb62 100644
--- a/drivers/firmware/psci/psci.c
+++ b/drivers/firmware/psci/psci.c
@@ -15,6 +15,7 @@
 
 #include <linux/acpi.h>
 #include <linux/arm-smccc.h>
+#include <linux/cpu.h>
 #include <linux/cpuidle.h>
 #include <linux/errno.h>
 #include <linux/linkage.h>
@@ -199,9 +200,20 @@ static int psci_cpu_suspend(u32 state, unsigned long entry_point)
 
 static int psci_cpu_off(u32 state)
 {
+	struct device *dev;
 	int err;
 	u32 fn;
 
+	/*
+	 * When the hierarchical CPU topology is used, decrease the runtime PM
+	 * usage count for the current CPU, as to allow other parts in the
+	 * topology to enter low power states.
+	 */
+	if (psci_dt_topology) {
+		dev = get_cpu_device(smp_processor_id());
+		pm_runtime_put_sync_suspend(dev);
+	}
+
 	fn = psci_function_id[PSCI_FN_CPU_OFF];
 	err = invoke_psci_fn(fn, state, 0, 0);
 	return psci_to_linux_errno(err);
@@ -209,6 +221,7 @@ static int psci_cpu_off(u32 state)
 
 static int psci_cpu_on(unsigned long cpuid, unsigned long entry_point)
 {
+	struct device *dev;
 	int err;
 	u32 fn;
 
@@ -216,6 +229,13 @@ static int psci_cpu_on(unsigned long cpuid, unsigned long entry_point)
 	err = invoke_psci_fn(fn, cpuid, entry_point, 0);
 	/* Clear the domain state to start fresh. */
 	psci_set_domain_state(0);
+
+	/* Increase runtime PM usage count if the hierarchical CPU toplogy. */
+	if (!err && psci_dt_topology) {
+		dev = get_cpu_device(cpuid);
+		pm_runtime_get_sync(dev);
+	}
+
 	return psci_to_linux_errno(err);
 }
 
-- 
2.17.1
