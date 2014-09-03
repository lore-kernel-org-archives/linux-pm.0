From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH 06/15] PM / Domains: Remove dev_irq_safe from genpd config
Date: Wed,  3 Sep 2014 12:52:22 +0200
Message-ID: <1409741551-16437-7-git-send-email-ulf.hansson@linaro.org>
References: <1409741551-16437-1-git-send-email-ulf.hansson@linaro.org>
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <1409741551-16437-1-git-send-email-ulf.hansson@linaro.org>
Sender: linux-sh-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, linux-pm@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, linux-sh@vger.kernel.org, linux-samsung-soc@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>, Kevin Hilman <khilman@linaro.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, Tomasz Figa <tomasz.figa@gmail.com>, Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>, Ben Dooks <ben-linux@fluff.org>, Kukjin Kim <kgene.kim@samsung.com>, Stephen Boyd <sboyd@codeaurora.org>, Philipp Zabel <philipp.zabel@gmail.com>, Mark Brown <broonie@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>
List-Id: linux-pm@vger.kernel.org

The genpd dev_irq_safe configuration somewhat overlaps with the runtime
PM pm_runtime_irq_safe() option. Also, currently genpd don't have a
good way to deal with these device. So, until we figured out if and how
to support this in genpd, let's remove the option to configure it.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/base/power/domain.c | 4 ----
 include/linux/pm_domain.h   | 1 -
 2 files changed, 5 deletions(-)

diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
index e777609..4298a2b 100644
--- a/drivers/base/power/domain.c
+++ b/drivers/base/power/domain.c
@@ -615,8 +615,6 @@ static int pm_genpd_runtime_suspend(struct device *dev)
 	if (IS_ERR(genpd))
 		return -EINVAL;
 
-	might_sleep_if(!genpd->dev_irq_safe);
-
 	stop_ok = genpd->gov ? genpd->gov->stop_ok : NULL;
 	if (stop_ok && !stop_ok(dev))
 		return -EBUSY;
@@ -661,8 +659,6 @@ static int pm_genpd_runtime_resume(struct device *dev)
 	if (IS_ERR(genpd))
 		return -EINVAL;
 
-	might_sleep_if(!genpd->dev_irq_safe);
-
 	/* If power.irq_safe, the PM domain is never powered off. */
 	if (dev->power.irq_safe)
 		return genpd_start_dev_no_timing(genpd, dev);
diff --git a/include/linux/pm_domain.h b/include/linux/pm_domain.h
index fd5efc8..f2545a8 100644
--- a/include/linux/pm_domain.h
+++ b/include/linux/pm_domain.h
@@ -63,7 +63,6 @@ struct generic_pm_domain {
 	unsigned int suspended_count;	/* System suspend device counter */
 	unsigned int prepared_count;	/* Suspend counter of prepared devices */
 	bool suspend_power_off;	/* Power status before system suspend */
-	bool dev_irq_safe;	/* Device callbacks are IRQ-safe */
 	int (*power_off)(struct generic_pm_domain *domain);
 	s64 power_off_latency_ns;
 	int (*power_on)(struct generic_pm_domain *domain);
-- 
1.9.1

