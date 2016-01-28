From: Jon Hunter <jonathanh@nvidia.com>
Subject: [PATCH V5 03/14] soc: tegra: pmc: Change powergate and rail IDs to be an unsigned type
Date: Thu, 28 Jan 2016 16:33:41 +0000
Message-ID: <1453998832-27383-4-git-send-email-jonathanh@nvidia.com>
References: <1453998832-27383-1-git-send-email-jonathanh@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from hqemgate15.nvidia.com ([216.228.121.64]:9378 "EHLO
	hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965584AbcA1QeT (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 28 Jan 2016 11:34:19 -0500
In-Reply-To: <1453998832-27383-1-git-send-email-jonathanh@nvidia.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Stephen Warren <swarren@wwwdotorg.org>, Thierry Reding <thierry.reding@gmail.com>, Alexandre Courbot <gnurou@gmail.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Kevin Hilman <khilman@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>
Cc: linux-tegra@vger.kernel.org, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Jon Hunter <jonathanh@nvidia.com>

The tegra powergate and rail IDs are always positive values and so change
the type to be unsigned and remove the tests to see if the ID is less
than zero. Update the Tegra DC powergate type to be an unsigned as well.

Signed-off-by: Jon Hunter <jonathanh@nvidia.com>
---
 drivers/gpu/drm/tegra/drm.h |  2 +-
 drivers/soc/tegra/pmc.c     | 36 ++++++++++++++++++------------------
 include/soc/tegra/pmc.h     | 35 ++++++++++++++++++-----------------
 3 files changed, 37 insertions(+), 36 deletions(-)

diff --git a/drivers/gpu/drm/tegra/drm.h b/drivers/gpu/drm/tegra/drm.h
index c088f2f67eda..6431fe2397c1 100644
--- a/drivers/gpu/drm/tegra/drm.h
+++ b/drivers/gpu/drm/tegra/drm.h
@@ -121,7 +121,7 @@ struct tegra_dc {
 	spinlock_t lock;
 
 	struct drm_crtc base;
-	int powergate;
+	unsigned int powergate;
 	int pipe;
 
 	struct clk *clk;
diff --git a/drivers/soc/tegra/pmc.c b/drivers/soc/tegra/pmc.c
index f8cdb7ce9755..1dbdcf06a9ad 100644
--- a/drivers/soc/tegra/pmc.c
+++ b/drivers/soc/tegra/pmc.c
@@ -179,7 +179,7 @@ static void tegra_pmc_writel(u32 value, unsigned long offset)
  * @id: partition ID
  * @new_state: new state of the partition
  */
-static int tegra_powergate_set(int id, bool new_state)
+static int tegra_powergate_set(unsigned int id, bool new_state)
 {
 	bool status;
 
@@ -203,9 +203,9 @@ static int tegra_powergate_set(int id, bool new_state)
  * tegra_powergate_power_on() - power on partition
  * @id: partition ID
  */
-int tegra_powergate_power_on(int id)
+int tegra_powergate_power_on(unsigned int id)
 {
-	if (!pmc->soc || id < 0 || id >= pmc->soc->num_powergates)
+	if (!pmc->soc || id >= pmc->soc->num_powergates)
 		return -EINVAL;
 
 	return tegra_powergate_set(id, true);
@@ -215,9 +215,9 @@ int tegra_powergate_power_on(int id)
  * tegra_powergate_power_off() - power off partition
  * @id: partition ID
  */
-int tegra_powergate_power_off(int id)
+int tegra_powergate_power_off(unsigned int id)
 {
-	if (!pmc->soc || id < 0 || id >= pmc->soc->num_powergates)
+	if (!pmc->soc || id >= pmc->soc->num_powergates)
 		return -EINVAL;
 
 	return tegra_powergate_set(id, false);
@@ -228,11 +228,11 @@ EXPORT_SYMBOL(tegra_powergate_power_off);
  * tegra_powergate_is_powered() - check if partition is powered
  * @id: partition ID
  */
-int tegra_powergate_is_powered(int id)
+int tegra_powergate_is_powered(unsigned int id)
 {
 	u32 status;
 
-	if (!pmc->soc || id < 0 || id >= pmc->soc->num_powergates)
+	if (!pmc->soc || id >= pmc->soc->num_powergates)
 		return -EINVAL;
 
 	mutex_lock(&pmc->powergates_lock);
@@ -246,11 +246,11 @@ int tegra_powergate_is_powered(int id)
  * tegra_powergate_remove_clamping() - remove power clamps for partition
  * @id: partition ID
  */
-int tegra_powergate_remove_clamping(int id)
+int tegra_powergate_remove_clamping(unsigned int id)
 {
 	u32 mask;
 
-	if (!pmc->soc || id < 0 || id >= pmc->soc->num_powergates)
+	if (!pmc->soc || id >= pmc->soc->num_powergates)
 		return -EINVAL;
 
 	mutex_lock(&pmc->powergates_lock);
@@ -294,7 +294,7 @@ EXPORT_SYMBOL(tegra_powergate_remove_clamping);
  *
  * Must be called with clk disabled, and returns with clk enabled.
  */
-int tegra_powergate_sequence_power_up(int id, struct clk *clk,
+int tegra_powergate_sequence_power_up(unsigned int id, struct clk *clk,
 				      struct reset_control *rst)
 {
 	int ret;
@@ -337,9 +337,9 @@ EXPORT_SYMBOL(tegra_powergate_sequence_power_up);
  * Returns the partition ID corresponding to the CPU partition ID or a
  * negative error code on failure.
  */
-static int tegra_get_cpu_powergate_id(int cpuid)
+static int tegra_get_cpu_powergate_id(unsigned int cpuid)
 {
-	if (pmc->soc && cpuid > 0 && cpuid < pmc->soc->num_cpu_powergates)
+	if (pmc->soc && cpuid < pmc->soc->num_cpu_powergates)
 		return pmc->soc->cpu_powergates[cpuid];
 
 	return -EINVAL;
@@ -349,7 +349,7 @@ static int tegra_get_cpu_powergate_id(int cpuid)
  * tegra_pmc_cpu_is_powered() - check if CPU partition is powered
  * @cpuid: CPU partition ID
  */
-bool tegra_pmc_cpu_is_powered(int cpuid)
+bool tegra_pmc_cpu_is_powered(unsigned int cpuid)
 {
 	int id;
 
@@ -364,7 +364,7 @@ bool tegra_pmc_cpu_is_powered(int cpuid)
  * tegra_pmc_cpu_power_on() - power on CPU partition
  * @cpuid: CPU partition ID
  */
-int tegra_pmc_cpu_power_on(int cpuid)
+int tegra_pmc_cpu_power_on(unsigned int cpuid)
 {
 	int id;
 
@@ -379,7 +379,7 @@ int tegra_pmc_cpu_power_on(int cpuid)
  * tegra_pmc_cpu_remove_clamping() - remove power clamps for CPU partition
  * @cpuid: CPU partition ID
  */
-int tegra_pmc_cpu_remove_clamping(int cpuid)
+int tegra_pmc_cpu_remove_clamping(unsigned int cpuid)
 {
 	int id;
 
@@ -465,7 +465,7 @@ static int tegra_powergate_debugfs_init(void)
 	return 0;
 }
 
-static int tegra_io_rail_prepare(int id, unsigned long *request,
+static int tegra_io_rail_prepare(unsigned int id, unsigned long *request,
 				 unsigned long *status, unsigned int *bit)
 {
 	unsigned long rate, value;
@@ -522,7 +522,7 @@ static void tegra_io_rail_unprepare(void)
 	tegra_pmc_writel(DPD_SAMPLE_DISABLE, DPD_SAMPLE);
 }
 
-int tegra_io_rail_power_on(int id)
+int tegra_io_rail_power_on(unsigned int id)
 {
 	unsigned long request, status, value;
 	unsigned int bit, mask;
@@ -557,7 +557,7 @@ error:
 }
 EXPORT_SYMBOL(tegra_io_rail_power_on);
 
-int tegra_io_rail_power_off(int id)
+int tegra_io_rail_power_off(unsigned int id)
 {
 	unsigned long request, status, value;
 	unsigned int bit, mask;
diff --git a/include/soc/tegra/pmc.h b/include/soc/tegra/pmc.h
index d18efe402ff1..07e332dd44fb 100644
--- a/include/soc/tegra/pmc.h
+++ b/include/soc/tegra/pmc.h
@@ -33,9 +33,9 @@ void tegra_pmc_enter_suspend_mode(enum tegra_suspend_mode mode);
 #endif /* CONFIG_PM_SLEEP */
 
 #ifdef CONFIG_SMP
-bool tegra_pmc_cpu_is_powered(int cpuid);
-int tegra_pmc_cpu_power_on(int cpuid);
-int tegra_pmc_cpu_remove_clamping(int cpuid);
+bool tegra_pmc_cpu_is_powered(unsigned int cpuid);
+int tegra_pmc_cpu_power_on(unsigned int cpuid);
+int tegra_pmc_cpu_remove_clamping(unsigned int cpuid);
 #endif /* CONFIG_SMP */
 
 /*
@@ -108,50 +108,51 @@ int tegra_pmc_cpu_remove_clamping(int cpuid);
 #define TEGRA_IO_RAIL_SYS_DDC	58
 
 #ifdef CONFIG_ARCH_TEGRA
-int tegra_powergate_is_powered(int id);
-int tegra_powergate_power_on(int id);
-int tegra_powergate_power_off(int id);
-int tegra_powergate_remove_clamping(int id);
+int tegra_powergate_is_powered(unsigned int id);
+int tegra_powergate_power_on(unsigned int id);
+int tegra_powergate_power_off(unsigned int id);
+int tegra_powergate_remove_clamping(unsigned int id);
 
 /* Must be called with clk disabled, and returns with clk enabled */
-int tegra_powergate_sequence_power_up(int id, struct clk *clk,
+int tegra_powergate_sequence_power_up(unsigned int id, struct clk *clk,
 				      struct reset_control *rst);
 
-int tegra_io_rail_power_on(int id);
-int tegra_io_rail_power_off(int id);
+int tegra_io_rail_power_on(unsigned int id);
+int tegra_io_rail_power_off(unsigned int id);
 #else
-static inline int tegra_powergate_is_powered(int id)
+static inline int tegra_powergate_is_powered(unsigned int id)
 {
 	return -ENOSYS;
 }
 
-static inline int tegra_powergate_power_on(int id)
+static inline int tegra_powergate_power_on(unsigned int id)
 {
 	return -ENOSYS;
 }
 
-static inline int tegra_powergate_power_off(int id)
+static inline int tegra_powergate_power_off(unsigned int id)
 {
 	return -ENOSYS;
 }
 
-static inline int tegra_powergate_remove_clamping(int id)
+static inline int tegra_powergate_remove_clamping(unsigned int id)
 {
 	return -ENOSYS;
 }
 
-static inline int tegra_powergate_sequence_power_up(int id, struct clk *clk,
+static inline int tegra_powergate_sequence_power_up(unsigned int id,
+						    struct clk *clk,
 						    struct reset_control *rst)
 {
 	return -ENOSYS;
 }
 
-static inline int tegra_io_rail_power_on(int id)
+static inline int tegra_io_rail_power_on(unsigned int id)
 {
 	return -ENOSYS;
 }
 
-static inline int tegra_io_rail_power_off(int id)
+static inline int tegra_io_rail_power_off(unsigned int id)
 {
 	return -ENOSYS;
 }
-- 
2.1.4

