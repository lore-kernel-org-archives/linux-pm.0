From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH 15/18] drivers: firmware: psci: Support CPU hotplug for the
 hierarchical model
Date: Mon, 13 May 2019 21:22:57 +0200
Message-ID: <20190513192300.653-16-ulf.hansson@linaro.org>
References: <20190513192300.653-1-ulf.hansson@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20190513192300.653-1-ulf.hansson@linaro.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Sudeep Holla <sudeep.holla@arm.com>, Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>, Mark Rutland <mark.rutland@arm.com>, linux-arm-kernel@lists.infradead.org
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Vincent Guittot <vincent.guittot@linaro.org>, Geert Uytterhoeven <geert+renesas@glider.be>, Kevin Hilman <khilman@kernel.org>, Stephen Boyd <sboyd@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org, Daniel Lezcano <daniel.lezcano@linaro.org>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, linux-kernel@vger.kernel.org, Amit Kucheria <amit.kucheria@linaro.org>, Bjorn Andersson <bjorn.andersson@linaro.org>, Tony Lindgren <tony@atomide.com>, Lina Iyer <ilina@codeaurora.org>, linux-arm-msm@vger.kernel.org, Niklas Cassel <niklas.cassel@linaro.org>, Souvik Chakravarty <souvik.chakravarty@arm.com>, "Raju P . L . S . S . S . N" <rplsssn@codeaurora.org>
List-Id: linux-pm@vger.kernel.org

When the hierarchical CPU topology is used and when a CPU has been put
offline (hotplug), that same CPU prevents its PM domain and thus also
potential master PM domains, from being powered off. This is because genpd
observes the CPU's attached device as being active from a runtime PM point
of view.

To deal with this, let's decrease the runtime PM usage count by calling
pm_runtime_put_sync_suspend() of the attached struct device when putting
the CPU offline. Consequentially, we must then increase the runtime PM
usage count, while putting the CPU online again.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---

Changes:
	- Use get_logical_index() to find the CPU number.
	- Verify that a corresponding struct device* has been attached to the
	  PM domain before doing runtime PM refrence counting.
	- Clear the domain state when the CPU goes offline, to start fresh.
	- Move code to internal helper functions and move them inside
	  "ifdef CONFIG_CPU_IDLE.

---
 drivers/firmware/psci/psci.c | 47 +++++++++++++++++++++++++++++++++++-
 1 file changed, 46 insertions(+), 1 deletion(-)

diff --git a/drivers/firmware/psci/psci.c b/drivers/firmware/psci/psci.c
index 2c4157d3a616..5ad93c3694b5 100644
--- a/drivers/firmware/psci/psci.c
+++ b/drivers/firmware/psci/psci.c
@@ -15,6 +15,7 @@
 
 #include <linux/acpi.h>
 #include <linux/arm-smccc.h>
+#include <linux/cpu.h>
 #include <linux/cpuidle.h>
 #include <linux/errno.h>
 #include <linux/linkage.h>
@@ -93,6 +94,9 @@ static u32 psci_function_id[PSCI_FN_MAX];
 static u32 psci_cpu_suspend_feature;
 static bool psci_system_reset2_supported;
 
+static void psci_cpuidle_cpu_off(void);
+static void psci_cpuidle_cpu_on(unsigned long cpuid);
+
 static inline bool psci_has_ext_power_state(void)
 {
 	return psci_cpu_suspend_feature &
@@ -188,6 +192,8 @@ static int psci_cpu_off(u32 state)
 	int err;
 	u32 fn;
 
+	psci_cpuidle_cpu_off();
+
 	fn = psci_function_id[PSCI_FN_CPU_OFF];
 	err = invoke_psci_fn(fn, state, 0, 0);
 	return psci_to_linux_errno(err);
@@ -200,7 +206,13 @@ static int psci_cpu_on(unsigned long cpuid, unsigned long entry_point)
 
 	fn = psci_function_id[PSCI_FN_CPU_ON];
 	err = invoke_psci_fn(fn, cpuid, entry_point, 0);
-	return psci_to_linux_errno(err);
+	err = psci_to_linux_errno(err);
+	if (err)
+		return err;
+
+	psci_cpuidle_cpu_on(cpuid);
+
+	return 0;
 }
 
 static int psci_migrate(unsigned long cpuid)
@@ -540,8 +552,41 @@ static int __init _psci_dt_topology_init(struct device_node *np)
 
 	return ret;
 }
+
+static void psci_cpuidle_cpu_off(void)
+{
+	struct device *dev = __this_cpu_read(psci_cpuidle_data.dev);
+
+	/*
+	 * Drop the runtime PM usage count if the CPU has been attached to a
+	 * CPU PM domain. This is needed to, for example, not prevent other
+	 * master domains in the hierarchy to remain powered on.
+	 */
+	if (dev)
+		pm_runtime_put_sync_suspend(dev);
+}
+
+static void psci_cpuidle_cpu_on(unsigned long cpuid)
+{
+	struct device *dev;
+	int cpu;
+
+	if (!psci_dt_topology)
+		return;
+
+	cpu = get_logical_index(cpuid);
+	if (cpu < 0)
+		return;
+
+	dev = per_cpu(psci_cpuidle_data.dev, cpu);
+	if (dev)
+		pm_runtime_get_sync(dev);
+}
+
 #else
 static inline int _psci_dt_topology_init(struct device_node *np) { return 0; }
+static void psci_cpuidle_cpu_off(void) {}
+static void psci_cpuidle_cpu_on(unsigned long cpuid) {}
 #endif
 
 static int psci_system_suspend(unsigned long unused)
-- 
2.17.1
