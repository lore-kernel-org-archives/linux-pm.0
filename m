From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH] PM / Domain: remove conditional from error case
Date: Fri, 17 Mar 2017 11:19:21 +0530
Message-ID: <4e38240a7a65b5a7de90d4a0feb2dac277024aa6.1489729740.git.viresh.kumar@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>, Kevin Hilman <khilman@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>, Viresh Kumar <viresh.kumar@linaro.org>
List-Id: linux-pm@vger.kernel.org

There is no point running the conditional 'if' statement if the genpd
isn't present.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/base/power/domain.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
index 202effbebfd1..03dd7a61f08a 100644
--- a/drivers/base/power/domain.c
+++ b/drivers/base/power/domain.c
@@ -1789,12 +1789,12 @@ int of_genpd_add_provider_simple(struct device_node *np,
 
 	mutex_lock(&gpd_list_lock);
 
-	if (pm_genpd_present(genpd))
+	if (pm_genpd_present(genpd)) {
 		ret = genpd_add_provider(np, genpd_xlate_simple, genpd);
-
-	if (!ret) {
-		genpd->provider = &np->fwnode;
-		genpd->has_provider = true;
+		if (!ret) {
+			genpd->provider = &np->fwnode;
+			genpd->has_provider = true;
+		}
 	}
 
 	mutex_unlock(&gpd_list_lock);
-- 
2.12.0.432.g71c3a4f4ba37
