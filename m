From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH v8 08/26] PM / Domains: Extend genpd CPU governor to cope with QoS constraints
Date: Wed, 20 Jun 2018 19:22:08 +0200
Message-ID: <20180620172226.15012-9-ulf.hansson@linaro.org>
References: <20180620172226.15012-1-ulf.hansson@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180620172226.15012-1-ulf.hansson@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J . Wysocki" <rjw@rjwysocki.net>, Sudeep Holla <sudeep.holla@arm.com>, Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>, Mark Rutland <mark.rutland@arm.com>, linux-pm@vger.kernel.org
Cc: Kevin Hilman <khilman@kernel.org>, Lina Iyer <ilina@codeaurora.org>, Lina Iyer <lina.iyer@linaro.org>, Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh+dt@kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, Thomas Gleixner <tglx@linutronix.de>, Vincent Guittot <vincent.guittot@linaro.org>, Stephen Boyd <sboyd@kernel.org>, Juri Lelli <juri.lelli@arm.com>, Geert Uytterhoeven <geert+renesas@glider.be>, linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

CPU devices and other regular devices may share the same PM domain and may
also be hierarchically related via subdomains. In either case, all devices
including CPUs, may be attached to a PM domain managed by genpd, that has
an idle state with an enter/exit latency.

Let's take these latencies into account in the state selection process by
genpd's governor for CPUs. This means the governor, pm_domain_cpu_gov,
becomes extended to satisfy both a state's residency and a potential dev PM
QoS constraint.

Cc: Lina Iyer <ilina@codeaurora.org>
Co-developed-by: Lina Iyer <lina.iyer@linaro.org>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/base/power/domain_governor.c | 15 +++++++++++----
 include/linux/pm_domain.h            |  1 +
 2 files changed, 12 insertions(+), 4 deletions(-)

diff --git a/drivers/base/power/domain_governor.c b/drivers/base/power/domain_governor.c
index 1aad55719537..03d4e9454ce9 100644
--- a/drivers/base/power/domain_governor.c
+++ b/drivers/base/power/domain_governor.c
@@ -214,8 +214,10 @@ static bool default_power_down_ok(struct dev_pm_domain *pd)
 	struct generic_pm_domain *genpd = pd_to_genpd(pd);
 	struct gpd_link *link;
 
-	if (!genpd->max_off_time_changed)
+	if (!genpd->max_off_time_changed) {
+		genpd->state_idx = genpd->cached_power_down_state_idx;
 		return genpd->cached_power_down_ok;
+	}
 
 	/*
 	 * We have to invalidate the cached results for the masters, so
@@ -240,6 +242,7 @@ static bool default_power_down_ok(struct dev_pm_domain *pd)
 		genpd->state_idx--;
 	}
 
+	genpd->cached_power_down_state_idx = genpd->state_idx;
 	return genpd->cached_power_down_ok;
 }
 
@@ -255,6 +258,10 @@ static bool cpu_power_down_ok(struct dev_pm_domain *pd)
 	s64 idle_duration_ns;
 	int cpu, i;
 
+	/* Validate dev PM QoS constraints. */
+	if (!default_power_down_ok(pd))
+		return false;
+
 	if (!(genpd->flags & GENPD_FLAG_CPU_DOMAIN))
 		return true;
 
@@ -276,9 +283,9 @@ static bool cpu_power_down_ok(struct dev_pm_domain *pd)
 	/*
 	 * Find the deepest idle state that has its residency value satisfied
 	 * and by also taking into account the power off latency for the state.
-	 * Start at the deepest supported state.
+	 * Start at the state picked by the dev PM QoS constraint validation.
 	 */
-	i = genpd->state_count - 1;
+	i = genpd->state_idx;
 	do {
 		if (!genpd->states[i].residency_ns)
 			break;
@@ -312,6 +319,6 @@ struct dev_power_governor pm_domain_always_on_gov = {
 };
 
 struct dev_power_governor pm_domain_cpu_gov = {
-	.suspend_ok = NULL,
+	.suspend_ok = default_suspend_ok,
 	.power_down_ok = cpu_power_down_ok,
 };
diff --git a/include/linux/pm_domain.h b/include/linux/pm_domain.h
index 97901c833108..dbc69721cad8 100644
--- a/include/linux/pm_domain.h
+++ b/include/linux/pm_domain.h
@@ -81,6 +81,7 @@ struct generic_pm_domain {
 	s64 max_off_time_ns;	/* Maximum allowed "suspended" time. */
 	bool max_off_time_changed;
 	bool cached_power_down_ok;
+	bool cached_power_down_state_idx;
 	int (*attach_dev)(struct generic_pm_domain *domain,
 			  struct device *dev);
 	void (*detach_dev)(struct generic_pm_domain *domain,
-- 
2.17.1
