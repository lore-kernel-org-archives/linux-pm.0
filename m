From: Krzysztof Kozlowski <krzk@kernel.org>
Subject: [PATCH v2 5/8] PM / Domains: Fix unsafe iteration over modified list of domain providers
Date: Mon, 12 Jun 2017 17:17:45 +0200
Message-ID: <20170612151748.7380-6-krzk@kernel.org>
References: <20170612151748.7380-1-krzk@kernel.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:55290 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752461AbdFLPSO (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 12 Jun 2017 11:18:14 -0400
In-Reply-To: <20170612151748.7380-1-krzk@kernel.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Kevin Hilman <khilman@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzk@kernel.org>, stable@vger.kernel.org

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
index d1e438024e46..b74b5111957a 100644
--- a/drivers/base/power/domain.c
+++ b/drivers/base/power/domain.c
@@ -1789,12 +1789,12 @@ EXPORT_SYMBOL_GPL(of_genpd_add_provider_onecell);
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
