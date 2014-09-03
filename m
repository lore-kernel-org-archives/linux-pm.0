From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH 09/15] PM / Domains: Remove genpd_queue_power_off_work() API
Date: Wed,  3 Sep 2014 12:52:25 +0200
Message-ID: <1409741551-16437-10-git-send-email-ulf.hansson@linaro.org>
References: <1409741551-16437-1-git-send-email-ulf.hansson@linaro.org>
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <1409741551-16437-1-git-send-email-ulf.hansson@linaro.org>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, linux-pm@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, linux-sh@vger.kernel.org, linux-samsung-soc@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>, Kevin Hilman <khilman@linaro.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, Tomasz Figa <tomasz.figa@gmail.com>, Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>, Ben Dooks <ben-linux@fluff.org>, Kukjin Kim <kgene.kim@samsung.com>, Stephen Boyd <sboyd@codeaurora.org>, Philipp Zabel <philipp.zabel@gmail.com>, Mark Brown <broonie@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>
List-Id: linux-pm@vger.kernel.org

There are no active users of this API. Let's remove it and if future
needs shows up we could consider to have a get/put API instead.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/base/power/domain.c | 5 ++++-
 include/linux/pm_domain.h   | 2 --
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
index 601e35b..d71d045 100644
--- a/drivers/base/power/domain.c
+++ b/drivers/base/power/domain.c
@@ -422,7 +422,7 @@ static bool genpd_abort_poweroff(struct generic_pm_domain *genpd)
  * Queue up the execution of pm_genpd_poweroff() unless it's already been done
  * before.
  */
-void genpd_queue_power_off_work(struct generic_pm_domain *genpd)
+static void genpd_queue_power_off_work(struct generic_pm_domain *genpd)
 {
 	queue_work(pm_wq, &genpd->power_off_work);
 }
@@ -729,6 +729,9 @@ static inline int genpd_dev_pm_qos_notifier(struct notifier_block *nb,
 	return NOTIFY_DONE;
 }
 
+static inline void
+genpd_queue_power_off_work(struct generic_pm_domain *genpd) {}
+
 static inline void genpd_power_off_work_fn(struct work_struct *work) {}
 
 #define pm_genpd_runtime_suspend	NULL
diff --git a/include/linux/pm_domain.h b/include/linux/pm_domain.h
index eeba1a4..abeb5dc 100644
--- a/include/linux/pm_domain.h
+++ b/include/linux/pm_domain.h
@@ -258,10 +258,8 @@ static inline int pm_genpd_name_add_device(const char *domain_name,
 }
 
 #ifdef CONFIG_PM_GENERIC_DOMAINS_RUNTIME
-extern void genpd_queue_power_off_work(struct generic_pm_domain *genpd);
 extern void pm_genpd_poweroff_unused(void);
 #else
-static inline void genpd_queue_power_off_work(struct generic_pm_domain *gpd) {}
 static inline void pm_genpd_poweroff_unused(void) {}
 #endif
 
-- 
1.9.1
