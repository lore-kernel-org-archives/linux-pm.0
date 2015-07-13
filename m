From: Jon Hunter <jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH V3 07/19] soc: tegra: pmc: Wait for powergate state to change
Date: Mon, 13 Jul 2015 13:39:45 +0100
Message-ID: <1436791197-32358-8-git-send-email-jonathanh@nvidia.com>
References: <1436791197-32358-1-git-send-email-jonathanh@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1436791197-32358-1-git-send-email-jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Alexandre Courbot <gnurou-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Philipp Zabel <p.zabel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Peter De Schrijver <pdeschrijver-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Prashant Gaikwad <pgaikwad-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, =?UTF-8?q?Terje=20Bergstr=C3=B6m?= <tbergstrom-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Tejun Heo <tj-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: Vince Hsu <vinceh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, "Rafael J. Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>, Kevin Hilman <khilman-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Jon Hunter <jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

Currently, the function tegra_powergate_set() simply sets the desired
powergate state but does not wait for the state to change. In some
circumstances this can be desirable. However, in most cases we should
wait for the state to change before proceeding. Therefore, add a
parameter to tegra_powergate_set() to indicate whether we should wait
for the state to change.

By adding this feature, we can also eliminate the polling loop from
tegra30_boot_secondary().

Signed-off-by: Jon Hunter <jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
---
 arch/arm/mach-tegra/platsmp.c | 18 ++++--------------
 drivers/soc/tegra/pmc.c       | 29 +++++++++++++++++++++++------
 include/soc/tegra/pmc.h       |  2 +-
 3 files changed, 28 insertions(+), 21 deletions(-)

diff --git a/arch/arm/mach-tegra/platsmp.c b/arch/arm/mach-tegra/platsmp.c
index b45086666648..13982b5936c0 100644
--- a/arch/arm/mach-tegra/platsmp.c
+++ b/arch/arm/mach-tegra/platsmp.c
@@ -108,19 +108,9 @@ static int tegra30_boot_secondary(unsigned int cpu, struct task_struct *idle)
 	 * be un-gated by un-toggling the power gate register
 	 * manually.
 	 */
-	if (!tegra_pmc_cpu_is_powered(cpu)) {
-		ret = tegra_pmc_cpu_power_on(cpu);
-		if (ret)
-			return ret;
-
-		/* Wait for the power to come up. */
-		timeout = jiffies + msecs_to_jiffies(100);
-		while (!tegra_pmc_cpu_is_powered(cpu)) {
-			if (time_after(jiffies, timeout))
-				return -ETIMEDOUT;
-			udelay(10);
-		}
-	}
+	ret = tegra_pmc_cpu_power_on(cpu, true);
+	if (ret)
+		return ret;
 
 remove_clamps:
 	/* CPU partition is powered. Enable the CPU clock. */
@@ -162,7 +152,7 @@ static int tegra114_boot_secondary(unsigned int cpu, struct task_struct *idle)
 		 * also initial power state in flow controller. After that,
 		 * the CPU's power state is maintained by flow controller.
 		 */
-		ret = tegra_pmc_cpu_power_on(cpu);
+		ret = tegra_pmc_cpu_power_on(cpu, false);
 	}
 
 	return ret;
diff --git a/drivers/soc/tegra/pmc.c b/drivers/soc/tegra/pmc.c
index 300f11e0c3bb..c0635bdd4ee3 100644
--- a/drivers/soc/tegra/pmc.c
+++ b/drivers/soc/tegra/pmc.c
@@ -175,9 +175,11 @@ static void tegra_pmc_writel(u32 value, unsigned long offset)
  * @id: partition ID
  * @new_state: new state of the partition
  */
-static int tegra_powergate_set(int id, bool new_state)
+static int tegra_powergate_set(int id, bool new_state, bool wait)
 {
+	unsigned long timeout;
 	bool status;
+	int ret = 0;
 
 	mutex_lock(&pmc->powergates_lock);
 
@@ -190,9 +192,23 @@ static int tegra_powergate_set(int id, bool new_state)
 
 	tegra_pmc_writel(PWRGATE_TOGGLE_START | id, PWRGATE_TOGGLE);
 
+	if (wait) {
+		timeout = jiffies + msecs_to_jiffies(100);
+		ret = -ETIMEDOUT;
+
+		while (time_before(jiffies, timeout)) {
+			status = !!(tegra_pmc_readl(PWRGATE_STATUS) & BIT(id));
+			if (status == new_state) {
+				ret = 0;
+				break;
+			}
+			udelay(10);
+		}
+	}
+
 	mutex_unlock(&pmc->powergates_lock);
 
-	return 0;
+	return ret;
 }
 
 /**
@@ -204,7 +220,7 @@ int tegra_powergate_power_on(int id)
 	if (!pmc->soc || id < 0 || id >= pmc->soc->num_powergates)
 		return -EINVAL;
 
-	return tegra_powergate_set(id, true);
+	return tegra_powergate_set(id, true, true);
 }
 
 /**
@@ -216,7 +232,7 @@ int tegra_powergate_power_off(int id)
 	if (!pmc->soc || id < 0 || id >= pmc->soc->num_powergates)
 		return -EINVAL;
 
-	return tegra_powergate_set(id, false);
+	return tegra_powergate_set(id, false, true);
 }
 EXPORT_SYMBOL(tegra_powergate_power_off);
 
@@ -351,8 +367,9 @@ bool tegra_pmc_cpu_is_powered(int cpuid)
 /**
  * tegra_pmc_cpu_power_on() - power on CPU partition
  * @cpuid: CPU partition ID
+ * @wait:  Wait for CPU state to transition
  */
-int tegra_pmc_cpu_power_on(int cpuid)
+int tegra_pmc_cpu_power_on(int cpuid, bool wait)
 {
 	int id;
 
@@ -360,7 +377,7 @@ int tegra_pmc_cpu_power_on(int cpuid)
 	if (id < 0)
 		return id;
 
-	return tegra_powergate_set(id, true);
+	return tegra_powergate_set(id, true, wait);
 }
 
 /**
diff --git a/include/soc/tegra/pmc.h b/include/soc/tegra/pmc.h
index d18efe402ff1..3a014c121399 100644
--- a/include/soc/tegra/pmc.h
+++ b/include/soc/tegra/pmc.h
@@ -34,7 +34,7 @@ void tegra_pmc_enter_suspend_mode(enum tegra_suspend_mode mode);
 
 #ifdef CONFIG_SMP
 bool tegra_pmc_cpu_is_powered(int cpuid);
-int tegra_pmc_cpu_power_on(int cpuid);
+int tegra_pmc_cpu_power_on(int cpuid, bool wait);
 int tegra_pmc_cpu_remove_clamping(int cpuid);
 #endif /* CONFIG_SMP */
 
-- 
2.1.4
