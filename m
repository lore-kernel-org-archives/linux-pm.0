From: Jon Hunter <jonathanh@nvidia.com>
Subject: [PATCH V5 07/14] soc: tegra: pmc: Ensure partitions can be toggled on/off by PMC
Date: Thu, 28 Jan 2016 16:33:45 +0000
Message-ID: <1453998832-27383-8-git-send-email-jonathanh@nvidia.com>
References: <1453998832-27383-1-git-send-email-jonathanh@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from hqemgate16.nvidia.com ([216.228.121.65]:19852 "EHLO
	hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1945947AbcA1Qef (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 28 Jan 2016 11:34:35 -0500
In-Reply-To: <1453998832-27383-1-git-send-email-jonathanh@nvidia.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Stephen Warren <swarren@wwwdotorg.org>, Thierry Reding <thierry.reding@gmail.com>, Alexandre Courbot <gnurou@gmail.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Kevin Hilman <khilman@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>
Cc: linux-tegra@vger.kernel.org, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Jon Hunter <jonathanh@nvidia.com>

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
index 032dd5c17130..ecb4f66819fd 100644
--- a/drivers/soc/tegra/pmc.c
+++ b/drivers/soc/tegra/pmc.c
@@ -110,6 +110,7 @@ struct tegra_pmc_soc {
 
 	bool has_tsense_reset;
 	bool has_gpu_clamps;
+	bool has_gpu_toggle;
 };
 
 /**
@@ -197,6 +198,9 @@ static int tegra_powergate_set(unsigned int id, bool new_state)
 	bool status;
 	int err;
 
+	if (id == TEGRA_POWERGATE_3D && !pmc->soc->has_gpu_toggle)
+		return -EINVAL;
+
 	mutex_lock(&pmc->powergates_lock);
 
 	if (tegra_powergate_state(id) == new_state) {
@@ -250,6 +254,9 @@ int tegra_powergate_is_powered(unsigned int id)
 	if (!tegra_powergate_is_valid(id))
 		return -EINVAL;
 
+	if (id == TEGRA_POWERGATE_3D && !pmc->soc->has_gpu_toggle)
+		return -EINVAL;
+
 	mutex_lock(&pmc->powergates_lock);
 	status = tegra_powergate_state(id);
 	mutex_unlock(&pmc->powergates_lock);
@@ -968,6 +975,7 @@ static const struct tegra_pmc_soc tegra30_pmc_soc = {
 	.cpu_powergates = tegra30_cpu_powergates,
 	.has_tsense_reset = true,
 	.has_gpu_clamps = false,
+	.has_gpu_toggle = true,
 };
 
 static const char * const tegra114_powergates[] = {
@@ -1005,6 +1013,7 @@ static const struct tegra_pmc_soc tegra114_pmc_soc = {
 	.cpu_powergates = tegra114_cpu_powergates,
 	.has_tsense_reset = true,
 	.has_gpu_clamps = false,
+	.has_gpu_toggle = true,
 };
 
 static const char * const tegra124_powergates[] = {
@@ -1048,6 +1057,7 @@ static const struct tegra_pmc_soc tegra124_pmc_soc = {
 	.cpu_powergates = tegra124_cpu_powergates,
 	.has_tsense_reset = true,
 	.has_gpu_clamps = true,
+	.has_gpu_toggle = false,
 };
 
 static const char * const tegra210_powergates[] = {
@@ -1091,6 +1101,7 @@ static const struct tegra_pmc_soc tegra210_pmc_soc = {
 	.cpu_powergates = tegra210_cpu_powergates,
 	.has_tsense_reset = true,
 	.has_gpu_clamps = true,
+	.has_gpu_toggle = false,
 };
 
 static const struct of_device_id tegra_pmc_match[] = {
-- 
2.1.4

