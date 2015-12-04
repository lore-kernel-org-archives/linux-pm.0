From: Jon Hunter <jonathanh@nvidia.com>
Subject: [PATCH V4 06/16] soc: tegra: pmc: Wait for powergate state to change
Date: Fri, 4 Dec 2015 14:57:07 +0000
Message-ID: <1449241037-22193-7-git-send-email-jonathanh@nvidia.com>
References: <1449241037-22193-1-git-send-email-jonathanh@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1449241037-22193-1-git-send-email-jonathanh@nvidia.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Philipp Zabel <p.zabel@pengutronix.de>, Stephen Warren <swarren@wwwdotorg.org>, Thierry Reding <thierry.reding@gmail.com>, Alexandre Courbot <gnurou@gmail.com>, Rafael Wysocki <rjw@rjwysocki.net>, Kevin Hilman <khilman@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>
Cc: Vince Hsu <vinceh@nvidia.com>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org, linux-pm@vger.kernel.org, Jon Hunter <jonathanh@nvidia.com>
List-Id: linux-pm@vger.kernel.org

Currently, the function tegra_powergate_set() simply sets the desired
powergate state but does not wait for the state to change. In most cases
we should wait for the state to change before proceeding. Currently, there
is a case for tegra114 and tegra124 devices where we do not wait when
starting the secondary CPU as this is not necessary. However, this is only
done at boot time and so waiting here will only have a small impact on boot
time. Therefore, update tegra_powergate_set() to wait when setting the
powergate.

By adding this feature, we can also eliminate the polling loop from
tegra30_boot_secondary().

A macro has also been adding for checking the status of the powergate and
so update the tegra_powergate_is_powered() to use this macro as well.

Signed-off-by: Jon Hunter <jonathanh@nvidia.com>
---
 arch/arm/mach-tegra/platsmp.c | 16 +++-------------
 drivers/soc/tegra/pmc.c       | 21 +++++++++++++++------
 2 files changed, 18 insertions(+), 19 deletions(-)

diff --git a/arch/arm/mach-tegra/platsmp.c b/arch/arm/mach-tegra/platsmp.c
index b45086666648..40cb761e7c95 100644
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
+	ret = tegra_pmc_cpu_power_on(cpu);
+	if (ret)
+		return ret;
 
 remove_clamps:
 	/* CPU partition is powered. Enable the CPU clock. */
diff --git a/drivers/soc/tegra/pmc.c b/drivers/soc/tegra/pmc.c
index fdd1a8d0940f..f94d970089ce 100644
--- a/drivers/soc/tegra/pmc.c
+++ b/drivers/soc/tegra/pmc.c
@@ -28,6 +28,7 @@
 #include <linux/export.h>
 #include <linux/init.h>
 #include <linux/io.h>
+#include <linux/iopoll.h>
 #include <linux/of.h>
 #include <linux/of_address.h>
 #include <linux/platform_device.h>
@@ -101,6 +102,8 @@
 
 #define GPU_RG_CNTRL			0x2d4
 
+#define PMC_PWRGATE_STATE(status, id)	((status & BIT(id)) != 0)
+
 struct tegra_pmc_soc {
 	unsigned int num_powergates;
 	const char *const *powergates;
@@ -181,22 +184,27 @@ static void tegra_pmc_writel(u32 value, unsigned long offset)
  */
 static int tegra_powergate_set(int id, bool new_state)
 {
-	bool status;
+	u32 status;
+	int err = 0;
 
 	mutex_lock(&pmc->powergates_lock);
 
-	status = tegra_pmc_readl(PWRGATE_STATUS) & (1 << id);
+	status = tegra_pmc_readl(PWRGATE_STATUS);
 
-	if (status == new_state) {
+	if (PMC_PWRGATE_STATE(status, id) == new_state) {
 		mutex_unlock(&pmc->powergates_lock);
 		return 0;
 	}
 
 	tegra_pmc_writel(PWRGATE_TOGGLE_START | id, PWRGATE_TOGGLE);
 
+	err = readx_poll_timeout(tegra_pmc_readl, PWRGATE_STATUS, status,
+				 PMC_PWRGATE_STATE(status, id) == new_state,
+				 10, 100000);
+
 	mutex_unlock(&pmc->powergates_lock);
 
-	return 0;
+	return err;
 }
 
 /**
@@ -235,8 +243,9 @@ int tegra_powergate_is_powered(int id)
 	if (!pmc->soc || id < 0 || id >= pmc->soc->num_powergates)
 		return -EINVAL;
 
-	status = tegra_pmc_readl(PWRGATE_STATUS) & (1 << id);
-	return !!status;
+	status = tegra_pmc_readl(PWRGATE_STATUS);
+
+	return PMC_PWRGATE_STATE(status, id);
 }
 
 /**
-- 
2.1.4
