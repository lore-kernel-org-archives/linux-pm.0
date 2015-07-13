From: Jon Hunter <jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH V3 16/19] soc: tegra: pmc: Remove the deprecated powergate APIs
Date: Mon, 13 Jul 2015 13:39:54 +0100
Message-ID: <1436791197-32358-17-git-send-email-jonathanh@nvidia.com>
References: <1436791197-32358-1-git-send-email-jonathanh@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1436791197-32358-1-git-send-email-jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Alexandre Courbot <gnurou-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Philipp Zabel <p.zabel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Peter De Schrijver <pdeschrijver-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Prashant Gaikwad <pgaikwad-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, =?UTF-8?q?Terje=20Bergstr=C3=B6m?= <tbergstrom-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Tejun Heo <tj-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: Vince Hsu <vinceh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, "Rafael J. Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>, Kevin Hilman <khilman-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Jon Hunter <jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

Drivers using the deprecated tegra powergate APIs have been updated and
so now we can remove these unused deprecated APIs.

Signed-off-by: Jon Hunter <jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
---
 drivers/soc/tegra/pmc.c | 68 -------------------------------------------------
 include/soc/tegra/pmc.h | 22 ----------------
 2 files changed, 90 deletions(-)

diff --git a/drivers/soc/tegra/pmc.c b/drivers/soc/tegra/pmc.c
index 4de92a9dae65..402f13727e75 100644
--- a/drivers/soc/tegra/pmc.c
+++ b/drivers/soc/tegra/pmc.c
@@ -484,31 +484,6 @@ static int tegra_genpd_power_off(struct generic_pm_domain *domain)
 }
 
 /**
- * tegra_powergate_power_on() - power on partition
- * @id: partition ID
- */
-int tegra_powergate_power_on(int id)
-{
-	if (!pmc->soc || id < 0 || id >= pmc->soc->num_powergates)
-		return -EINVAL;
-
-	return tegra_powergate_set(id, true, true);
-}
-
-/**
- * tegra_powergate_power_off() - power off partition
- * @id: partition ID
- */
-int tegra_powergate_power_off(int id)
-{
-	if (!pmc->soc || id < 0 || id >= pmc->soc->num_powergates)
-		return -EINVAL;
-
-	return tegra_powergate_set(id, false, true);
-}
-EXPORT_SYMBOL(tegra_powergate_power_off);
-
-/**
  * tegra_powergate_is_powered() - check if partition is powered
  * @id: partition ID
  */
@@ -566,49 +541,6 @@ int tegra_powergate_remove_clamping(int id)
 }
 EXPORT_SYMBOL(tegra_powergate_remove_clamping);
 
-/**
- * tegra_powergate_sequence_power_up() - power up partition
- * @id: partition ID
- * @clk: clock for partition
- * @rst: reset for partition
- *
- * Must be called with clk disabled, and returns with clk enabled.
- */
-int tegra_powergate_sequence_power_up(int id, struct clk *clk,
-				      struct reset_control *rst)
-{
-	int ret;
-
-	reset_control_assert(rst);
-
-	ret = tegra_powergate_power_on(id);
-	if (ret)
-		goto err_power;
-
-	ret = clk_prepare_enable(clk);
-	if (ret)
-		goto err_clk;
-
-	usleep_range(10, 20);
-
-	ret = tegra_powergate_remove_clamping(id);
-	if (ret)
-		goto err_clamp;
-
-	usleep_range(10, 20);
-	reset_control_deassert(rst);
-
-	return 0;
-
-err_clamp:
-	clk_disable_unprepare(clk);
-err_clk:
-	tegra_powergate_power_off(id);
-err_power:
-	return ret;
-}
-EXPORT_SYMBOL(tegra_powergate_sequence_power_up);
-
 int tegra_powergate_power_on_legacy(int id, struct clk *clk,
 				    struct reset_control *rst)
 {
diff --git a/include/soc/tegra/pmc.h b/include/soc/tegra/pmc.h
index 67b75d82edc7..509c1a3ca879 100644
--- a/include/soc/tegra/pmc.h
+++ b/include/soc/tegra/pmc.h
@@ -79,14 +79,8 @@ int tegra_pmc_cpu_remove_clamping(int cpuid);
 
 #ifdef CONFIG_ARCH_TEGRA
 int tegra_powergate_is_powered(int id);
-int tegra_powergate_power_on(int id);
-int tegra_powergate_power_off(int id);
 int tegra_powergate_remove_clamping(int id);
 
-/* Must be called with clk disabled, and returns with clk enabled */
-int tegra_powergate_sequence_power_up(int id, struct clk *clk,
-				      struct reset_control *rst);
-
 int tegra_powergate_power_on_legacy(int id, struct clk *clk,
 				    struct reset_control *rst);
 
@@ -101,27 +95,11 @@ static inline int tegra_powergate_is_powered(int id)
 	return -ENOSYS;
 }
 
-static inline int tegra_powergate_power_on(int id)
-{
-	return -ENOSYS;
-}
-
-static inline int tegra_powergate_power_off(int id)
-{
-	return -ENOSYS;
-}
-
 static inline int tegra_powergate_remove_clamping(int id)
 {
 	return -ENOSYS;
 }
 
-static inline int tegra_powergate_sequence_power_up(int id, struct clk *clk,
-						    struct reset_control *rst)
-{
-	return -ENOSYS;
-}
-
 static inline int tegra_io_rail_power_on(int id)
 {
 	return -ENOSYS;
-- 
2.1.4

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
