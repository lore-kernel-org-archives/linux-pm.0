From: Krzysztof Kozlowski <krzk@kernel.org>
Subject: [PATCH 6/8] PM / domains: Fix unsafe iteration over modified list of domains
Date: Fri,  9 Jun 2017 18:08:51 +0200
Message-ID: <20170609160853.31789-7-krzk@kernel.org>
References: <20170609160853.31789-1-krzk@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170609160853.31789-1-krzk@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Kevin Hilman <khilman@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzk@kernel.org>, stable@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

of_genpd_remove_last() iterates over list of domains and removes
matching element thus it has to use safe version of list iteration.

Fixes: 17926551c98a ("PM / Domains: Add support for removing nested PM domains by provider")
Cc: <stable@vger.kernel.org>
Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 drivers/base/power/domain.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
index e426ceff1a59..c1e22b613287 100644
--- a/drivers/base/power/domain.c
+++ b/drivers/base/power/domain.c
@@ -1939,14 +1939,14 @@ EXPORT_SYMBOL_GPL(of_genpd_add_subdomain);
  */
 struct generic_pm_domain *of_genpd_remove_last(struct device_node *np)
 {
-	struct generic_pm_domain *gpd, *genpd = ERR_PTR(-ENOENT);
+	struct generic_pm_domain *gpd, *tmp, *genpd = ERR_PTR(-ENOENT);
 	int ret;
 
 	if (IS_ERR_OR_NULL(np))
 		return ERR_PTR(-EINVAL);
 
 	mutex_lock(&gpd_list_lock);
-	list_for_each_entry(gpd, &gpd_list, gpd_list_node) {
+	list_for_each_entry_safe(gpd, tmp, &gpd_list, gpd_list_node) {
 		if (gpd->provider == &np->fwnode) {
 			ret = genpd_remove(gpd);
 			genpd = ret ? ERR_PTR(ret) : gpd;
-- 
2.9.3
