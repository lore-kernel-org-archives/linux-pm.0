From: Krzysztof Kozlowski <krzk@kernel.org>
Subject: [PATCH v3 3/8] PM / Domains: Fix unsafe iteration over modified list of device links
Date: Wed, 28 Jun 2017 16:56:18 +0200
Message-ID: <20170628145623.20716-4-krzk@kernel.org>
References: <20170628145623.20716-1-krzk@kernel.org>
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <20170628145623.20716-1-krzk@kernel.org>
Sender: stable-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Kevin Hilman <khilman@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzk@kernel.org>, stable@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

pm_genpd_remove_subdomain() iterates over domain's master_links list and
removes matching element thus it has to use safe version of list
iteration.

Fixes: f721889ff65a ("PM / Domains: Support for generic I/O PM domains (v8)")
Cc: <stable@vger.kernel.org>
Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
Acked-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/base/power/domain.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
index d31a4434b8b3..ebbce6ef0850 100644
--- a/drivers/base/power/domain.c
+++ b/drivers/base/power/domain.c
@@ -1396,7 +1396,7 @@ EXPORT_SYMBOL_GPL(pm_genpd_add_subdomain);
 int pm_genpd_remove_subdomain(struct generic_pm_domain *genpd,
 			      struct generic_pm_domain *subdomain)
 {
-	struct gpd_link *link;
+	struct gpd_link *l, *link;
 	int ret = -EINVAL;
 
 	if (IS_ERR_OR_NULL(genpd) || IS_ERR_OR_NULL(subdomain))
@@ -1412,7 +1412,7 @@ int pm_genpd_remove_subdomain(struct generic_pm_domain *genpd,
 		goto out;
 	}
 
-	list_for_each_entry(link, &genpd->master_links, master_node) {
+	list_for_each_entry_safe(link, l, &genpd->master_links, master_node) {
 		if (link->slave != subdomain)
 			continue;
 
-- 
2.11.0
