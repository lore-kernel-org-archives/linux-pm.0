From: Jon Hunter <jonathanh@nvidia.com>
Subject: [PATCH V4 09/16] soc: tegra: pmc: Ensure partitions can be toggled on/off by PMC
Date: Fri, 4 Dec 2015 14:57:10 +0000
Message-ID: <1449241037-22193-10-git-send-email-jonathanh@nvidia.com>
References: <1449241037-22193-1-git-send-email-jonathanh@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1449241037-22193-1-git-send-email-jonathanh@nvidia.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Philipp Zabel <p.zabel@pengutronix.de>, Stephen Warren <swarren@wwwdotorg.org>, Thierry Reding <thierry.reding@gmail.com>, Alexandre Courbot <gnurou@gmail.com>, Rafael Wysocki <rjw@rjwysocki.net>, Kevin Hilman <khilman@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>
Cc: Vince Hsu <vinceh@nvidia.com>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org, linux-pm@vger.kernel.org, Jon Hunter <jonathanh@nvidia.com>
List-Id: linux-pm@vger.kernel.org

For Tegra124 and Tegra210, the GPU partition cannot be toggled on and off
via the APBDEV_PMC_PWRGATE_TOGGLE_0 register. For these devices, the
partition is simply powered up and down via an external regulator.
Describe in the PMC SoC data in which devices the GPU partition can be
controlled via the APBDEV_PMC_PWRGATE_TOGGLE_0 register and ensure that
no one can incorrectly try to toggle the GPU partition via the
APBDEV_PMC_PWRGATE_TOGGLE_0 register.

Signed-off-by: Jon Hunter <jonathanh@nvidia.com>
---
 drivers/soc/tegra/pmc.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/soc/tegra/pmc.c b/drivers/soc/tegra/pmc.c
index 0967bba13947..b412098b8197 100644
--- a/drivers/soc/tegra/pmc.c
+++ b/drivers/soc/tegra/pmc.c
@@ -113,6 +113,7 @@ struct tegra_pmc_soc {
 
 	bool has_tsense_reset;
 	bool has_gpu_clamps;
+	bool has_gpu_toggle;
 };
 
 /**
@@ -190,6 +191,9 @@ static int tegra_powergate_set(int id, bool new_state)
 	u32 status;
 	int err = 0;
 
+	if (id == TEGRA_POWERGATE_3D && !pmc->soc->has_gpu_toggle)
+		return -EINVAL;
+
 	mutex_lock(&pmc->powergates_lock);
 
 	status = tegra_pmc_readl(PWRGATE_STATUS);
@@ -246,6 +250,9 @@ int tegra_powergate_is_powered(int id)
 	if (!PMC_PWRGATE_IS_VALID(id))
 		return -EINVAL;
 
+	if (id == TEGRA_POWERGATE_3D && !pmc->soc->has_gpu_toggle)
+		return -EINVAL;
+
 	status = tegra_pmc_readl(PWRGATE_STATUS);
 
 	return PMC_PWRGATE_STATE(status, id);
@@ -929,6 +936,7 @@ static const struct tegra_pmc_soc tegra30_pmc_soc = {
 	.cpu_powergates = tegra30_cpu_powergates,
 	.has_tsense_reset = true,
 	.has_gpu_clamps = false,
+	.has_gpu_toggle = true,
 };
 
 static const char * const tegra114_powergates[] = {
@@ -966,6 +974,7 @@ static const struct tegra_pmc_soc tegra114_pmc_soc = {
 	.cpu_powergates = tegra114_cpu_powergates,
 	.has_tsense_reset = true,
 	.has_gpu_clamps = false,
+	.has_gpu_toggle = true,
 };
 
 static const char * const tegra124_powergates[] = {
@@ -1009,6 +1018,7 @@ static const struct tegra_pmc_soc tegra124_pmc_soc = {
 	.cpu_powergates = tegra124_cpu_powergates,
 	.has_tsense_reset = true,
 	.has_gpu_clamps = true,
+	.has_gpu_toggle = false,
 };
 
 static const char * const tegra210_powergates[] = {
@@ -1052,6 +1062,7 @@ static const struct tegra_pmc_soc tegra210_pmc_soc = {
 	.cpu_powergates = tegra210_cpu_powergates,
 	.has_tsense_reset = true,
 	.has_gpu_clamps = true,
+	.has_gpu_toggle = false,
 };
 
 static const struct of_device_id tegra_pmc_match[] = {
-- 
2.1.4
