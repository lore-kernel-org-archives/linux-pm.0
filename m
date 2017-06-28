From: Krzysztof Kozlowski <krzk@kernel.org>
Subject: [PATCH v3 6/8] PM / Domains: Fix missing default_power_down_ok comment
Date: Wed, 28 Jun 2017 16:56:21 +0200
Message-ID: <20170628145623.20716-7-krzk@kernel.org>
References: <20170628145623.20716-1-krzk@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170628145623.20716-1-krzk@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Kevin Hilman <khilman@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzk@kernel.org>
List-Id: linux-pm@vger.kernel.org

Commit fc5cbf0c94b6 ("PM / Domains: Support for multiple states") split
out some code out of default_power_down_ok() function so the
documentation has to be moved to appropriate place.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
Acked-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/base/power/domain_governor.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/base/power/domain_governor.c b/drivers/base/power/domain_governor.c
index 2e0fce711135..281f949c5ffe 100644
--- a/drivers/base/power/domain_governor.c
+++ b/drivers/base/power/domain_governor.c
@@ -92,12 +92,6 @@ static bool default_suspend_ok(struct device *dev)
 	return td->cached_suspend_ok;
 }
 
-/**
- * default_power_down_ok - Default generic PM domain power off governor routine.
- * @pd: PM domain to check.
- *
- * This routine must be executed under the PM domain's lock.
- */
 static bool __default_power_down_ok(struct dev_pm_domain *pd,
 				     unsigned int state)
 {
@@ -187,6 +181,12 @@ static bool __default_power_down_ok(struct dev_pm_domain *pd,
 	return true;
 }
 
+/**
+ * default_power_down_ok - Default generic PM domain power off governor routine.
+ * @pd: PM domain to check.
+ *
+ * This routine must be executed under the PM domain's lock.
+ */
 static bool default_power_down_ok(struct dev_pm_domain *pd)
 {
 	struct generic_pm_domain *genpd = pd_to_genpd(pd);
-- 
2.11.0
