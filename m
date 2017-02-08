From: Lina Iyer <lina.iyer@linaro.org>
Subject: [PATCH 2/2] PM / Domains: Support in context powering off parent domain
Date: Wed,  8 Feb 2017 08:34:52 -0800
Message-ID: <1486571692-33212-4-git-send-email-lina.iyer@linaro.org>
References: <1486571692-33212-1-git-send-email-lina.iyer@linaro.org>
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <1486571692-33212-1-git-send-email-lina.iyer@linaro.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: ulf.hansson@linaro.org, khilman@kernel.org, rjw@rjwysocki.net, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: andy.gross@linaro.org, sboyd@codeaurora.org, linux-arm-msm@vger.kernel.org, brendan.jackman@arm.com, lorenzo.pieralisi@arm.com, sudeep.holla@arm.com, Juri.Lelli@arm.com, Lina Iyer <lina.iyer@linaro.org>
List-Id: linux-pm@vger.kernel.org

Powering off a domain schedules a work to opportunistically power off
the parent domains. Domains that are IRQ safe may have parents that are
also IRQ safe. It would be beneficial to power off such IRQ safe parents
in the same context as well.

Signed-off-by: Lina Iyer <lina.iyer@linaro.org>
---
 drivers/base/power/domain.c | 21 ++++++++++++++++-----
 1 file changed, 16 insertions(+), 5 deletions(-)

diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
index 3825bb9..51e2254 100644
--- a/drivers/base/power/domain.c
+++ b/drivers/base/power/domain.c
@@ -375,7 +375,8 @@ static int genpd_dev_pm_qos_notifier(struct notifier_block *nb,
  * If all of the @genpd's devices have been suspended and all of its subdomains
  * have been powered down, remove power from @genpd.
  */
-static int genpd_power_off(struct generic_pm_domain *genpd, bool is_async)
+static int genpd_power_off(struct generic_pm_domain *genpd, bool is_async,
+					unsigned int depth)
 {
 	struct pm_domain_data *pdd;
 	struct gpd_link *link;
@@ -442,7 +443,17 @@ static int genpd_power_off(struct generic_pm_domain *genpd, bool is_async)
 
 	list_for_each_entry(link, &genpd->slave_links, slave_node) {
 		genpd_sd_counter_dec(link->master);
-		genpd_queue_power_off_work(link->master);
+		/*
+		 * Power off the parent in the same context if the parent
+		 * domain is also IRQ safe.
+		 */
+		if (genpd_is_irq_safe(genpd) &&
+				genpd_is_irq_safe(link->master)) {
+			genpd_lock_nested(link->master, depth + 1);
+			genpd_power_off(link->master, false, depth + 1);
+			genpd_unlock(link->master);
+		} else
+			genpd_queue_power_off_work(link->master);
 	}
 
 	return 0;
@@ -459,7 +470,7 @@ static void genpd_power_off_work_fn(struct work_struct *work)
 	genpd = container_of(work, struct generic_pm_domain, power_off_work);
 
 	genpd_lock(genpd);
-	genpd_power_off(genpd, true);
+	genpd_power_off(genpd, true, 0);
 	genpd_unlock(genpd);
 }
 
@@ -578,7 +589,7 @@ static int genpd_runtime_suspend(struct device *dev)
 		return 0;
 
 	genpd_lock(genpd);
-	genpd_power_off(genpd, false);
+	genpd_power_off(genpd, false, 0);
 	genpd_unlock(genpd);
 
 	return 0;
@@ -658,7 +669,7 @@ static int genpd_runtime_resume(struct device *dev)
 	if (!pm_runtime_is_irq_safe(dev) ||
 		(pm_runtime_is_irq_safe(dev) && genpd_is_irq_safe(genpd))) {
 		genpd_lock(genpd);
-		genpd_power_off(genpd, 0);
+		genpd_power_off(genpd, 0, 0);
 		genpd_unlock(genpd);
 	}
 
-- 
2.7.4
