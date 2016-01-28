From: Jon Hunter <jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH V5 06/14] soc: tegra: pmc: Fix checking of valid partitions
Date: Thu, 28 Jan 2016 16:33:44 +0000
Message-ID: <1453998832-27383-7-git-send-email-jonathanh@nvidia.com>
References: <1453998832-27383-1-git-send-email-jonathanh@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1453998832-27383-1-git-send-email-jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Alexandre Courbot <gnurou-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "Rafael J. Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>, Kevin Hilman <khilman-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Cc: linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Jon Hunter <jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

The tegra power partitions are referenced by a numerical ID which are
the same values programmed into the PMC registers for controlling the
partition. For a given device, the valid partition IDs may not be
contiguous and so simply checking that an ID is not greater than the
maximum ID supported may not mean it is valid. Fix this by adding a
bitmap for representing the valid partitions of a device and add a
helper function will test if the partition is valid.

Signed-off-by: Jon Hunter <jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
---
 drivers/soc/tegra/pmc.c | 21 +++++++++++++++++----
 include/soc/tegra/pmc.h |  1 +
 2 files changed, 18 insertions(+), 4 deletions(-)

diff --git a/drivers/soc/tegra/pmc.c b/drivers/soc/tegra/pmc.c
index 35ee60fd17be..032dd5c17130 100644
--- a/drivers/soc/tegra/pmc.c
+++ b/drivers/soc/tegra/pmc.c
@@ -132,6 +132,7 @@ struct tegra_pmc_soc {
  * @cpu_pwr_good_en: CPU power good signal is enabled
  * @lp0_vec_phys: physical base address of the LP0 warm boot code
  * @lp0_vec_size: size of the LP0 warm boot code
+ * @powergates_valid: Bitmap of valid power gates
  * @powergates_lock: mutex for power gate register access
  */
 struct tegra_pmc {
@@ -156,6 +157,7 @@ struct tegra_pmc {
 	bool cpu_pwr_good_en;
 	u32 lp0_vec_phys;
 	u32 lp0_vec_size;
+	DECLARE_BITMAP(powergates_valid, TEGRA_POWERGATE_MAX);
 
 	struct mutex powergates_lock;
 };
@@ -180,6 +182,11 @@ static inline bool tegra_powergate_state(int id)
 	return (tegra_pmc_readl(PWRGATE_STATUS) & BIT(id)) != 0;
 }
 
+static inline bool tegra_powergate_is_valid(int id)
+{
+	return test_bit(id, pmc->powergates_valid);
+}
+
 /**
  * tegra_powergate_set() - set the state of a partition
  * @id: partition ID
@@ -213,7 +220,7 @@ static int tegra_powergate_set(unsigned int id, bool new_state)
  */
 int tegra_powergate_power_on(unsigned int id)
 {
-	if (!pmc->soc || id >= pmc->soc->num_powergates)
+	if (!tegra_powergate_is_valid(id))
 		return -EINVAL;
 
 	return tegra_powergate_set(id, true);
@@ -225,7 +232,7 @@ int tegra_powergate_power_on(unsigned int id)
  */
 int tegra_powergate_power_off(unsigned int id)
 {
-	if (!pmc->soc || id >= pmc->soc->num_powergates)
+	if (!tegra_powergate_is_valid(id))
 		return -EINVAL;
 
 	return tegra_powergate_set(id, false);
@@ -240,7 +247,7 @@ int tegra_powergate_is_powered(unsigned int id)
 {
 	int status;
 
-	if (!pmc->soc || id >= pmc->soc->num_powergates)
+	if (!tegra_powergate_is_valid(id))
 		return -EINVAL;
 
 	mutex_lock(&pmc->powergates_lock);
@@ -258,7 +265,7 @@ int tegra_powergate_remove_clamping(unsigned int id)
 {
 	u32 mask;
 
-	if (!pmc->soc || id >= pmc->soc->num_powergates)
+	if (!tegra_powergate_is_valid(id))
 		return -EINVAL;
 
 	mutex_lock(&pmc->powergates_lock);
@@ -1118,6 +1125,7 @@ static int __init tegra_pmc_early_init(void)
 	const struct of_device_id *match;
 	struct device_node *np;
 	struct resource regs;
+	unsigned int i;
 	bool invert;
 	u32 value;
 
@@ -1167,6 +1175,11 @@ static int __init tegra_pmc_early_init(void)
 		return -ENXIO;
 	}
 
+	/* Create a bit-mask of the valid partitions */
+	for (i = 0; i < pmc->soc->num_powergates; i++)
+		if (pmc->soc->powergates[i])
+			set_bit(i, pmc->powergates_valid);
+
 	mutex_init(&pmc->powergates_lock);
 
 	/*
diff --git a/include/soc/tegra/pmc.h b/include/soc/tegra/pmc.h
index 07e332dd44fb..e9e53473a63e 100644
--- a/include/soc/tegra/pmc.h
+++ b/include/soc/tegra/pmc.h
@@ -72,6 +72,7 @@ int tegra_pmc_cpu_remove_clamping(unsigned int cpuid);
 #define TEGRA_POWERGATE_AUD	27
 #define TEGRA_POWERGATE_DFD	28
 #define TEGRA_POWERGATE_VE2	29
+#define TEGRA_POWERGATE_MAX	TEGRA_POWERGATE_VE2
 
 #define TEGRA_POWERGATE_3D0	TEGRA_POWERGATE_3D
 
-- 
2.1.4
