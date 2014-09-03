From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH 08/15] PM / Domains: Remove pm_genpd_syscore_switch() API
Date: Wed,  3 Sep 2014 12:52:24 +0200
Message-ID: <1409741551-16437-9-git-send-email-ulf.hansson@linaro.org>
References: <1409741551-16437-1-git-send-email-ulf.hansson@linaro.org>
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <1409741551-16437-1-git-send-email-ulf.hansson@linaro.org>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, linux-pm@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, linux-sh@vger.kernel.org, linux-samsung-soc@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>, Kevin Hilman <khilman@linaro.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, Tomasz Figa <tomasz.figa@gmail.com>, Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>, Ben Dooks <ben-linux@fluff.org>, Kukjin Kim <kgene.kim@samsung.com>, Stephen Boyd <sboyd@codeaurora.org>, Philipp Zabel <philipp.zabel@gmail.com>, Mark Brown <broonie@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>
List-Id: linux-pm@vger.kernel.org

The pm_genpd_syscore_poweroff() API and pm_genpd_syscore_poweron() API
makes the pm_genpd_syscore_switch() API redundant.

Moreover, since there are no active users, let's just remove it.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/base/power/domain.c | 17 ++++++++++++++---
 include/linux/pm_domain.h   | 16 ++++------------
 2 files changed, 18 insertions(+), 15 deletions(-)

diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
index b910d0f..601e35b 100644
--- a/drivers/base/power/domain.c
+++ b/drivers/base/power/domain.c
@@ -1292,13 +1292,13 @@ static void pm_genpd_complete(struct device *dev)
 }
 
 /**
- * pm_genpd_syscore_switch - Switch power during system core suspend or resume.
+ * genpd_syscore_switch - Switch power during system core suspend or resume.
  * @dev: Device that normally is marked as "always on" to switch power for.
  *
  * This routine may only be called during the system core (syscore) suspend or
  * resume phase for devices whose "always on" flags are set.
  */
-void pm_genpd_syscore_switch(struct device *dev, bool suspend)
+static void genpd_syscore_switch(struct device *dev, bool suspend)
 {
 	struct generic_pm_domain *genpd;
 
@@ -1314,7 +1314,18 @@ void pm_genpd_syscore_switch(struct device *dev, bool suspend)
 		genpd->suspended_count--;
 	}
 }
-EXPORT_SYMBOL_GPL(pm_genpd_syscore_switch);
+
+void pm_genpd_syscore_poweroff(struct device *dev)
+{
+	genpd_syscore_switch(dev, true);
+}
+EXPORT_SYMBOL_GPL(pm_genpd_syscore_poweroff);
+
+void pm_genpd_syscore_poweron(struct device *dev)
+{
+	genpd_syscore_switch(dev, false);
+}
+EXPORT_SYMBOL_GPL(pm_genpd_syscore_poweron);
 
 #else
 
diff --git a/include/linux/pm_domain.h b/include/linux/pm_domain.h
index f2545a8..eeba1a4 100644
--- a/include/linux/pm_domain.h
+++ b/include/linux/pm_domain.h
@@ -266,19 +266,11 @@ static inline void pm_genpd_poweroff_unused(void) {}
 #endif
 
 #ifdef CONFIG_PM_GENERIC_DOMAINS_SLEEP
-extern void pm_genpd_syscore_switch(struct device *dev, bool suspend);
+extern void pm_genpd_syscore_poweroff(struct device *dev);
+extern void pm_genpd_syscore_poweron(struct device *dev);
 #else
-static inline void pm_genpd_syscore_switch(struct device *dev, bool suspend) {}
+static inline void pm_genpd_syscore_poweroff(struct device *dev) {}
+static inline void pm_genpd_syscore_poweron(struct device *dev) {}
 #endif
 
-static inline void pm_genpd_syscore_poweroff(struct device *dev)
-{
-	pm_genpd_syscore_switch(dev, true);
-}
-
-static inline void pm_genpd_syscore_poweron(struct device *dev)
-{
-	pm_genpd_syscore_switch(dev, false);
-}
-
 #endif /* _LINUX_PM_DOMAIN_H */
-- 
1.9.1
