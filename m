From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH 14/18] drivers: firmware: psci: Manage runtime PM in the idle
 path for CPUs
Date: Mon, 13 May 2019 21:22:56 +0200
Message-ID: <20190513192300.653-15-ulf.hansson@linaro.org>
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

When the hierarchical CPU topology layout is used in DT, let's allow the
CPU to be power managed through its PM domain, via deploying runtime PM
support.

To know for which idle states runtime PM reference counting is needed,
let's store the index of deepest idle state for the CPU, in a per CPU
variable. This allows psci_cpu_suspend_enter() to compare this index with
the requested idle state index and then act accordingly.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---

Changes:
	- Simplify the code by using the new per CPU struct, that stores the
	  needed struct device*.

---
 drivers/firmware/psci/psci.c | 22 ++++++++++++++++++++--
 1 file changed, 20 insertions(+), 2 deletions(-)

diff --git a/drivers/firmware/psci/psci.c b/drivers/firmware/psci/psci.c
index 54e23d4ed0ea..2c4157d3a616 100644
--- a/drivers/firmware/psci/psci.c
+++ b/drivers/firmware/psci/psci.c
@@ -20,6 +20,7 @@
 #include <linux/linkage.h>
 #include <linux/of.h>
 #include <linux/pm.h>
+#include <linux/pm_runtime.h>
 #include <linux/printk.h>
 #include <linux/psci.h>
 #include <linux/reboot.h>
@@ -298,6 +299,7 @@ static int __init psci_features(u32 psci_func_id)
 
 struct psci_cpuidle_data {
 	u32 *psci_states;
+	u32 rpm_state_id;
 	struct device *dev;
 };
 
@@ -385,6 +387,7 @@ static int psci_dt_cpu_init_idle(struct cpuidle_driver *drv,
 			goto free_mem;
 
 		data->dev = dev;
+		data->rpm_state_id = drv->state_count - 1;
 	}
 
 	/* Idle states parsed correctly, store them in the per-cpu struct. */
@@ -481,8 +484,11 @@ static int psci_suspend_finisher(unsigned long index)
 int psci_cpu_suspend_enter(unsigned long index)
 {
 	int ret;
-	u32 *state = __this_cpu_read(psci_cpuidle_data.psci_states);
-	u32 composite_state = state[index - 1] | psci_get_domain_state();
+	struct psci_cpuidle_data *data = this_cpu_ptr(&psci_cpuidle_data);
+	u32 *states = data->psci_states;
+	struct device *dev = data->dev;
+	bool runtime_pm = (dev && data->rpm_state_id == index);
+	u32 composite_state;
 
 	/*
 	 * idle state index 0 corresponds to wfi, should never be called
@@ -491,11 +497,23 @@ int psci_cpu_suspend_enter(unsigned long index)
 	if (WARN_ON_ONCE(!index))
 		return -EINVAL;
 
+	/*
+	 * Do runtime PM if we are using the hierarchical CPU toplogy, but only
+	 * when cpuidle have selected the deepest idle state for the CPU.
+	 */
+	if (runtime_pm)
+		pm_runtime_put_sync_suspend(dev);
+
+	composite_state = states[index - 1] | psci_get_domain_state();
+
 	if (!psci_power_state_loses_context(composite_state))
 		ret = psci_ops.cpu_suspend(composite_state, 0);
 	else
 		ret = cpu_suspend(index, psci_suspend_finisher);
 
+	if (runtime_pm)
+		pm_runtime_get_sync(dev);
+
 	/* Clear the domain state to start fresh when back from idle. */
 	psci_set_domain_state(0);
 
-- 
2.17.1
