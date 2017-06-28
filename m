From: Krzysztof Kozlowski <krzk@kernel.org>
Subject: [PATCH v3 4/8] PM / Domains: Fix unsafe iteration over modified list of domain providers
Date: Wed, 28 Jun 2017 16:56:19 +0200
Message-ID: <20170628145623.20716-5-krzk@kernel.org>
References: <20170628145623.20716-1-krzk@kernel.org>
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <20170628145623.20716-1-krzk@kernel.org>
Sender: stable-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Kevin Hilman <khilman@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzk@kernel.org>, stable@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

of_genpd_del_provider() iterates over list of domain provides and
removes matching element thus it has to use safe version of list
iteration.

Fixes: aa42240ab254 ("PM / Domains: Add generic OF-based PM domain look-up")
Cc: <stable@vger.kernel.org>
Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
Acked-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/base/power/domain.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
index ebbce6ef0850..793f9f7f3f2d 100644
--- a/drivers/base/power/domain.c
+++ b/drivers/base/power/domain.c
@@ -1783,12 +1783,12 @@ EXPORT_SYMBOL_GPL(of_genpd_add_provider_onecell);
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
2.11.0
