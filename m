From: Krzysztof Kozlowski <krzk@kernel.org>
Subject: [PATCH 5/8] PM / domains: Fix unsafe iteration over modified list of domain providers
Date: Fri,  9 Jun 2017 18:08:50 +0200
Message-ID: <20170609160853.31789-6-krzk@kernel.org>
References: <20170609160853.31789-1-krzk@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170609160853.31789-1-krzk@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Kevin Hilman <khilman@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzk@kernel.org>, stable@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

of_genpd_del_provider() iterates over list of domain provides and
removes matching element thus it has to use safe version of list
iteration.

Fixes: aa42240ab254 ("PM / Domains: Add generic OF-based PM domain look-up")
Cc: <stable@vger.kernel.org>
Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 drivers/base/power/domain.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
index 325962702bc8..e426ceff1a59 100644
--- a/drivers/base/power/domain.c
+++ b/drivers/base/power/domain.c
@@ -1794,12 +1794,12 @@ EXPORT_SYMBOL_GPL(of_genpd_add_provider_onecell);
  */
 void of_genpd_del_provider(struct device_node *np)
 {
-	struct of_genpd_provider *cp;
+	struct of_genpd_provider *cp, *tmp;
 	struct generic_pm_domain *gpd;
 
 	mutex_lock(&gpd_list_lock);
 	mutex_lock(&of_genpd_mutex);
-	list_for_each_entry(cp, &of_genpd_providers, link) {
+	list_for_each_entry_safe(cp, tmp, &of_genpd_providers, link) {
 		if (cp->node == np) {
 			/*
 			 * For each PM domain associated with the
-- 
2.9.3
