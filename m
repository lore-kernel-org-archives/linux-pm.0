From: Jon Hunter <jonathanh@nvidia.com>
Subject: [PATCH V4 08/16] soc: tegra: pmc: Fix checking of valid partitions
Date: Fri, 4 Dec 2015 14:57:09 +0000
Message-ID: <1449241037-22193-9-git-send-email-jonathanh@nvidia.com>
References: <1449241037-22193-1-git-send-email-jonathanh@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1449241037-22193-1-git-send-email-jonathanh@nvidia.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Philipp Zabel <p.zabel@pengutronix.de>, Stephen Warren <swarren@wwwdotorg.org>, Thierry Reding <thierry.reding@gmail.com>, Alexandre Courbot <gnurou@gmail.com>, Rafael Wysocki <rjw@rjwysocki.net>, Kevin Hilman <khilman@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>
Cc: Vince Hsu <vinceh@nvidia.com>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org, linux-pm@vger.kernel.org, Jon Hunter <jonathanh@nvidia.com>
List-Id: linux-pm@vger.kernel.org

The tegra power partitions are referenced by a numerical ID which are
the same values programmed into the PMC registers for controlling the
partition. For a given device, the valid partition IDs may not be
contiguous and so simply checking that an ID is not greater than the
maximum ID supported may not mean it is valid. Fix this by computing
a bit-mask of the valid partition IDs for a device and add a macro that
will test if the partition is valid based upon this mask.

Signed-off-by: Jon Hunter <jonathanh@nvidia.com>
---
 drivers/soc/tegra/pmc.c | 18 +++++++++++++-----
 1 file changed, 13 insertions(+), 5 deletions(-)

diff --git a/drivers/soc/tegra/pmc.c b/drivers/soc/tegra/pmc.c
index 28d3106d3add..0967bba13947 100644
--- a/drivers/soc/tegra/pmc.c
+++ b/drivers/soc/tegra/pmc.c
@@ -103,6 +103,7 @@
 #define GPU_RG_CNTRL			0x2d4
 
 #define PMC_PWRGATE_STATE(status, id)	((status & BIT(id)) != 0)
+#define PMC_PWRGATE_IS_VALID(id)	(pmc->powergates_mask & BIT(id))
 
 struct tegra_pmc_soc {
 	unsigned int num_powergates;
@@ -134,6 +135,7 @@ struct tegra_pmc_soc {
  * @cpu_pwr_good_en: CPU power good signal is enabled
  * @lp0_vec_phys: physical base address of the LP0 warm boot code
  * @lp0_vec_size: size of the LP0 warm boot code
+ * @powergates_mask: Bit mask of valid power gates
  * @powergates_lock: mutex for power gate register access
  */
 struct tegra_pmc {
@@ -158,6 +160,7 @@ struct tegra_pmc {
 	bool cpu_pwr_good_en;
 	u32 lp0_vec_phys;
 	u32 lp0_vec_size;
+	u32 powergates_mask;
 
 	struct mutex powergates_lock;
 };
@@ -213,7 +216,7 @@ static int tegra_powergate_set(int id, bool new_state)
  */
 int tegra_powergate_power_on(int id)
 {
-	if (!pmc->soc || id < 0 || id >= pmc->soc->num_powergates)
+	if (!PMC_PWRGATE_IS_VALID(id))
 		return -EINVAL;
 
 	return tegra_powergate_set(id, true);
@@ -225,7 +228,7 @@ int tegra_powergate_power_on(int id)
  */
 int tegra_powergate_power_off(int id)
 {
-	if (!pmc->soc || id < 0 || id >= pmc->soc->num_powergates)
+	if (!PMC_PWRGATE_IS_VALID(id))
 		return -EINVAL;
 
 	return tegra_powergate_set(id, false);
@@ -240,7 +243,7 @@ int tegra_powergate_is_powered(int id)
 {
 	u32 status;
 
-	if (!pmc->soc || id < 0 || id >= pmc->soc->num_powergates)
+	if (!PMC_PWRGATE_IS_VALID(id))
 		return -EINVAL;
 
 	status = tegra_pmc_readl(PWRGATE_STATUS);
@@ -256,7 +259,7 @@ int tegra_powergate_remove_clamping(int id)
 {
 	u32 mask;
 
-	if (!pmc->soc || id < 0 || id >= pmc->soc->num_powergates)
+	if (!PMC_PWRGATE_IS_VALID(id))
 		return -EINVAL;
 
 	/*
@@ -1084,7 +1087,7 @@ static int __init tegra_pmc_early_init(void)
 	struct device_node *np;
 	struct resource regs;
 	bool invert;
-	u32 value;
+	u32 value, i;
 
 	np = of_find_matching_node_and_match(NULL, tegra_pmc_match, &match);
 	if (!np) {
@@ -1136,6 +1139,11 @@ static int __init tegra_pmc_early_init(void)
 		return -ENXIO;
 	}
 
+	/* Create a bit-mask of the valid partitions */
+	for (i = 0; i < pmc->soc->num_powergates; i++)
+		if (pmc->soc->powergates[i])
+			pmc->powergates_mask |= BIT(i);
+
 	mutex_init(&pmc->powergates_lock);
 
 	/*
-- 
2.1.4
