From: Krzysztof Kozlowski <krzk@kernel.org>
Subject: [PATCH v3 7/8] PM / Domains: Add lockdep asserts for domains list mutex
Date: Wed, 28 Jun 2017 16:56:22 +0200
Message-ID: <20170628145623.20716-8-krzk@kernel.org>
References: <20170628145623.20716-1-krzk@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170628145623.20716-1-krzk@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Kevin Hilman <khilman@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzk@kernel.org>
List-Id: linux-pm@vger.kernel.org

Add lockdep checks for holding mutex protecting the list of domains.
This might expose misuse even though only file-scope functions use it
for now.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 drivers/base/power/domain.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
index be34cbf3793e..1a47c5ff6a2f 100644
--- a/drivers/base/power/domain.c
+++ b/drivers/base/power/domain.c
@@ -726,6 +726,8 @@ static bool pm_genpd_present(const struct generic_pm_domain *genpd)
 {
 	const struct generic_pm_domain *gpd;
 
+	lockdep_assert_held(&gpd_list_lock);
+
 	if (IS_ERR_OR_NULL(genpd))
 		return false;
 
@@ -1321,6 +1323,8 @@ static int genpd_add_subdomain(struct generic_pm_domain *genpd,
 	struct gpd_link *link, *itr;
 	int ret = 0;
 
+	lockdep_assert_held(&gpd_list_lock);
+
 	if (IS_ERR_OR_NULL(genpd) || IS_ERR_OR_NULL(subdomain)
 	    || genpd == subdomain)
 		return -EINVAL;
@@ -1528,6 +1532,8 @@ static int genpd_remove(struct generic_pm_domain *genpd)
 {
 	struct gpd_link *l, *link;
 
+	lockdep_assert_held(&gpd_list_lock);
+
 	if (IS_ERR_OR_NULL(genpd))
 		return -EINVAL;
 
-- 
2.11.0
