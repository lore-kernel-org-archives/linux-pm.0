From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH 15/15] PM / Domains: Keep declaration of dev_power_governors together
Date: Wed,  3 Sep 2014 12:52:31 +0200
Message-ID: <1409741551-16437-16-git-send-email-ulf.hansson@linaro.org>
References: <1409741551-16437-1-git-send-email-ulf.hansson@linaro.org>
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <1409741551-16437-1-git-send-email-ulf.hansson@linaro.org>
Sender: linux-sh-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, linux-pm@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, linux-sh@vger.kernel.org, linux-samsung-soc@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>, Kevin Hilman <khilman@linaro.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, Tomasz Figa <tomasz.figa@gmail.com>, Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>, Ben Dooks <ben-linux@fluff.org>, Kukjin Kim <kgene.kim@samsung.com>, Stephen Boyd <sboyd@codeaurora.org>, Philipp Zabel <philipp.zabel@gmail.com>, Mark Brown <broonie@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>
List-Id: linux-pm@vger.kernel.org

This is a pure code cleanup in the header file for the PM domain. No
functional change.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 include/linux/pm_domain.h | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/include/linux/pm_domain.h b/include/linux/pm_domain.h
index ebf52ae..324b927 100644
--- a/include/linux/pm_domain.h
+++ b/include/linux/pm_domain.h
@@ -117,8 +117,6 @@ static inline struct generic_pm_domain_data *dev_gpd_data(struct device *dev)
 	return to_gpd_data(dev->power.subsys_data->domain_data);
 }
 
-extern struct dev_power_governor simple_qos_governor;
-
 extern struct generic_pm_domain *dev_to_genpd(struct device *dev);
 extern int __pm_genpd_add_device(struct generic_pm_domain *genpd,
 				 struct device *dev,
@@ -151,6 +149,7 @@ extern void pm_genpd_init(struct generic_pm_domain *genpd,
 extern int pm_genpd_poweron(struct generic_pm_domain *genpd);
 extern int pm_genpd_name_poweron(const char *domain_name);
 
+extern struct dev_power_governor simple_qos_governor;
 extern struct dev_power_governor pm_domain_always_on_gov;
 #else
 
-- 
1.9.1

