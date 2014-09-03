From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH 07/15] PM / Domains: Remove redundant check for CONFIG_PM
Date: Wed,  3 Sep 2014 12:52:23 +0200
Message-ID: <1409741551-16437-8-git-send-email-ulf.hansson@linaro.org>
References: <1409741551-16437-1-git-send-email-ulf.hansson@linaro.org>
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <1409741551-16437-1-git-send-email-ulf.hansson@linaro.org>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, linux-pm@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, linux-sh@vger.kernel.org, linux-samsung-soc@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>, Kevin Hilman <khilman@linaro.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, Tomasz Figa <tomasz.figa@gmail.com>, Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>, Ben Dooks <ben-linux@fluff.org>, Kukjin Kim <kgene.kim@samsung.com>, Stephen Boyd <sboyd@codeaurora.org>, Philipp Zabel <philipp.zabel@gmail.com>, Mark Brown <broonie@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>
List-Id: linux-pm@vger.kernel.org

CONFIG_PM_GENERIC_DOMAINS depends on CONFIG_PM, thus there are no need
to check explicity for it.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/base/power/domain.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
index 4298a2b..b910d0f 100644
--- a/drivers/base/power/domain.c
+++ b/drivers/base/power/domain.c
@@ -66,8 +66,6 @@ static struct generic_pm_domain *pm_genpd_lookup_name(const char *domain_name)
 	return genpd;
 }
 
-#ifdef CONFIG_PM
-
 struct generic_pm_domain *dev_to_genpd(struct device *dev)
 {
 	if (IS_ERR_OR_NULL(dev->pm_domain))
@@ -281,8 +279,6 @@ int pm_genpd_name_poweron(const char *domain_name)
 	return genpd ? pm_genpd_poweron(genpd) : -EINVAL;
 }
 
-#endif /* CONFIG_PM */
-
 #ifdef CONFIG_PM_RUNTIME
 
 static int genpd_start_dev_no_timing(struct generic_pm_domain *genpd,
-- 
1.9.1
