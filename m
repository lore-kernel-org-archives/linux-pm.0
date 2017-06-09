From: Krzysztof Kozlowski <krzk@kernel.org>
Subject: [PATCH 4/8] PM / domains: Fix unsafe iteration over modified list of device links
Date: Fri,  9 Jun 2017 18:08:49 +0200
Message-ID: <20170609160853.31789-5-krzk@kernel.org>
References: <20170609160853.31789-1-krzk@kernel.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:57354 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751783AbdFIQJ2 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 9 Jun 2017 12:09:28 -0400
In-Reply-To: <20170609160853.31789-1-krzk@kernel.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Kevin Hilman <khilman@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzk@kernel.org>, stable@vger.kernel.org

pm_genpd_remove_subdomain() iterates over domain's master_links list and
removes matching element thus it has to use safe version of list
iteration.

Fixes: f721889ff65a ("PM / Domains: Support for generic I/O PM domains (v8)")
Cc: <stable@vger.kernel.org>
Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 drivers/base/power/domain.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
index 0f416563479b..325962702bc8 100644
--- a/drivers/base/power/domain.c
+++ b/drivers/base/power/domain.c
@@ -1405,7 +1405,7 @@ EXPORT_SYMBOL_GPL(pm_genpd_add_subdomain);
 int pm_genpd_remove_subdomain(struct generic_pm_domain *genpd,
 			      struct generic_pm_domain *subdomain)
 {
-	struct gpd_link *link;
+	struct gpd_link *l, *link;
 	int ret = -EINVAL;
 
 	if (IS_ERR_OR_NULL(genpd) || IS_ERR_OR_NULL(subdomain))
@@ -1421,7 +1421,7 @@ int pm_genpd_remove_subdomain(struct generic_pm_domain *genpd,
 		goto out;
 	}
 
-	list_for_each_entry(link, &genpd->master_links, master_node) {
+	list_for_each_entry_safe(link, l, &genpd->master_links, master_node) {
 		if (link->slave != subdomain)
 			continue;
 
-- 
2.9.3
