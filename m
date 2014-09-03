From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH 14/15] PM / Domains: Remove default_stop_ok() API
Date: Wed,  3 Sep 2014 12:52:30 +0200
Message-ID: <1409741551-16437-15-git-send-email-ulf.hansson@linaro.org>
References: <1409741551-16437-1-git-send-email-ulf.hansson@linaro.org>
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <1409741551-16437-1-git-send-email-ulf.hansson@linaro.org>
Sender: linux-sh-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, linux-pm@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, linux-sh@vger.kernel.org, linux-samsung-soc@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>, Kevin Hilman <khilman@linaro.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, Tomasz Figa <tomasz.figa@gmail.com>, Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>, Ben Dooks <ben-linux@fluff.org>, Kukjin Kim <kgene.kim@samsung.com>, Stephen Boyd <sboyd@codeaurora.org>, Philipp Zabel <philipp.zabel@gmail.com>, Mark Brown <broonie@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>
List-Id: linux-pm@vger.kernel.org

There are currently no need to export default_stop_ok() as an API,
instead let's keep it local to the PM domain governor.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/base/power/domain_governor.c | 7 ++-----
 include/linux/pm_domain.h            | 6 ------
 2 files changed, 2 insertions(+), 11 deletions(-)

diff --git a/drivers/base/power/domain_governor.c b/drivers/base/power/domain_governor.c
index a089e3b..d88a62e 100644
--- a/drivers/base/power/domain_governor.c
+++ b/drivers/base/power/domain_governor.c
@@ -42,7 +42,7 @@ static int dev_update_qos_constraint(struct device *dev, void *data)
  * default_stop_ok - Default PM domain governor routine for stopping devices.
  * @dev: Device to check.
  */
-bool default_stop_ok(struct device *dev)
+static bool default_stop_ok(struct device *dev)
 {
 	struct gpd_timing_data *td = &dev_gpd_data(dev)->td;
 	unsigned long flags;
@@ -229,10 +229,7 @@ static bool always_on_power_down_ok(struct dev_pm_domain *domain)
 
 #else /* !CONFIG_PM_RUNTIME */
 
-bool default_stop_ok(struct device *dev)
-{
-	return false;
-}
+static inline bool default_stop_ok(struct device *dev) { return false; }
 
 #define default_power_down_ok	NULL
 #define always_on_power_down_ok	NULL
diff --git a/include/linux/pm_domain.h b/include/linux/pm_domain.h
index abeb5dc..ebf52ae 100644
--- a/include/linux/pm_domain.h
+++ b/include/linux/pm_domain.h
@@ -151,8 +151,6 @@ extern void pm_genpd_init(struct generic_pm_domain *genpd,
 extern int pm_genpd_poweron(struct generic_pm_domain *genpd);
 extern int pm_genpd_name_poweron(const char *domain_name);
 
-extern bool default_stop_ok(struct device *dev);
-
 extern struct dev_power_governor pm_domain_always_on_gov;
 #else
 
@@ -231,10 +229,6 @@ static inline int pm_genpd_name_poweron(const char *domain_name)
 {
 	return -ENOSYS;
 }
-static inline bool default_stop_ok(struct device *dev)
-{
-	return false;
-}
 #define simple_qos_governor NULL
 #define pm_domain_always_on_gov NULL
 #endif
-- 
1.9.1

