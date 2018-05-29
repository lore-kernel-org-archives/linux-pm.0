From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH v2 4/9] PM / Domains: Drop unused parameter in genpd_allocate_dev_data()
Date: Tue, 29 May 2018 12:04:16 +0200
Message-ID: <20180529100421.31022-5-ulf.hansson@linaro.org>
References: <20180529100421.31022-1-ulf.hansson@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180529100421.31022-1-ulf.hansson@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J . Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jon Hunter <jonathanh@nvidia.com>, Geert Uytterhoeven <geert+renesas@glider.be>, Todor Tomov <todor.tomov@linaro.org>, Rajendra Nayak <rnayak@codeaurora.org>, Viresh Kumar <viresh.kumar@linaro.org>, Vincent Guittot <vincent.guittot@linaro.org>, Kevin Hilman <khilman@kernel.org>, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-tegra@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

The in-parameter struct generic_pm_domain *genpd to
genpd_allocate_dev_data() is unused, so let's drop it.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/base/power/domain.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
index c89b0ad068b7..7ebf7993273a 100644
--- a/drivers/base/power/domain.c
+++ b/drivers/base/power/domain.c
@@ -1316,7 +1316,6 @@ EXPORT_SYMBOL_GPL(pm_genpd_syscore_poweron);
 #endif /* CONFIG_PM_SLEEP */
 
 static struct generic_pm_domain_data *genpd_alloc_dev_data(struct device *dev,
-					struct generic_pm_domain *genpd,
 					struct gpd_timing_data *td)
 {
 	struct generic_pm_domain_data *gpd_data;
@@ -1385,7 +1384,7 @@ static int genpd_add_device(struct generic_pm_domain *genpd, struct device *dev,
 	if (IS_ERR_OR_NULL(genpd) || IS_ERR_OR_NULL(dev))
 		return -EINVAL;
 
-	gpd_data = genpd_alloc_dev_data(dev, genpd, td);
+	gpd_data = genpd_alloc_dev_data(dev, td);
 	if (IS_ERR(gpd_data))
 		return PTR_ERR(gpd_data);
 
-- 
2.17.0
