From: Vince Hsu <vinceh@nvidia.com>
Subject: [PATCH v2 17/17] soc/tegra: remove lagacy powergate APIs
Date: Thu, 12 Mar 2015 20:15:18 +0800
Message-ID: <1426162518-7405-18-git-send-email-vinceh@nvidia.com>
References: <1426162518-7405-1-git-send-email-vinceh@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1426162518-7405-1-git-send-email-vinceh@nvidia.com>
Sender: linux-kernel-owner@vger.kernel.org
To: thierry.reding@gmail.com, pdeschrijver@nvidia.com, swarren@wwwdotorg.org, gnurou@gmail.com, jroedel@suse.de, p.zabel@pengutronix.de, mturquette@linaro.org, pgaikwad@nvidia.com, sboyd@codeaurora.org, robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org, linux@arm.linux.org.uk, tbergstrom@nvidia.com, airlied@linux.ie, bhelgaas@google.com, tj@kernel.org, arnd@arndb.de, robh@kernel.org, will.deacon@arm.com
Cc: linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org, rjw@rjwysocki.net, viresh.kumar@linaro.org, Vince Hsu <vinceh@nvidia.com>
List-Id: linux-pm@vger.kernel.org

We switch to generic power domain now. So remove the legacy functions.

Signed-off-by: Vince Hsu <vinceh@nvidia.com>
---
 drivers/soc/tegra/pmc.c | 68 -------------------------------------------------
 include/soc/tegra/pmc.h | 22 ----------------
 2 files changed, 90 deletions(-)

diff --git a/drivers/soc/tegra/pmc.c b/drivers/soc/tegra/pmc.c
index ed1ce06e3635..2fc32f688493 100644
--- a/drivers/soc/tegra/pmc.c
+++ b/drivers/soc/tegra/pmc.c
@@ -233,31 +233,6 @@ static int tegra_powergate_set(int id, bool new_state)
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
-	return tegra_powergate_set(id, true);
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
-	return tegra_powergate_set(id, false);
-}
-EXPORT_SYMBOL(tegra_powergate_power_off);
-
-/**
  * tegra_powergate_is_powered() - check if partition is powered
  * @id: partition ID
  */
@@ -313,49 +288,6 @@ int tegra_powergate_remove_clamping(int id)
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
 #ifdef CONFIG_SMP
 /**
  * tegra_get_cpu_powergate_id() - convert from CPU ID to partition ID
diff --git a/include/soc/tegra/pmc.h b/include/soc/tegra/pmc.h
index 65a93273e72f..8a4092d1d818 100644
--- a/include/soc/tegra/pmc.h
+++ b/include/soc/tegra/pmc.h
@@ -106,14 +106,8 @@ int tegra_pmc_cpu_remove_clamping(int cpuid);
 
 #ifdef CONFIG_ARCH_TEGRA
 int tegra_powergate_is_powered(int id);
-int tegra_powergate_power_on(int id);
-int tegra_powergate_power_off(int id);
 int tegra_powergate_remove_clamping(int id);
 
-/* Must be called with clk disabled, and returns with clk enabled */
-int tegra_powergate_sequence_power_up(int id, struct clk *clk,
-				      struct reset_control *rst);
-
 int tegra_io_rail_power_on(int id);
 int tegra_io_rail_power_off(int id);
 #else
@@ -122,27 +116,11 @@ static inline int tegra_powergate_is_powered(int id)
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
