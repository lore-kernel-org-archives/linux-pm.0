From: Krzysztof Kozlowski <krzk@kernel.org>
Subject: [RFT v2 2/8] PM / Domains: Handle safely genpd_syscore_switch() call on non-genpd device
Date: Mon, 12 Jun 2017 17:17:42 +0200
Message-ID: <20170612151748.7380-3-krzk@kernel.org>
References: <20170612151748.7380-1-krzk@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170612151748.7380-1-krzk@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Kevin Hilman <khilman@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzk@kernel.org>
List-Id: linux-pm@vger.kernel.org

genpd_syscore_switch() had two problems:
1. It silently assumed that device, it is being called for, belongs to
   generic power domain and used container_of() on its power domain
   pointer.  Such assumption might not be true always.

2. It iterated over list of generic power domains without holding
   gpd_list_lock mutex thus list could have been modified in the same
   time.

Usage of genpd_lookup_dev() solves both problems as it is safe a call
for non-generic power domains and uses mutex when iterating.

Reported-by: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>

---

Not tested on real hardware.
---
 drivers/base/power/domain.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
index 2e8d0f423507..983f086ab235 100644
--- a/drivers/base/power/domain.c
+++ b/drivers/base/power/domain.c
@@ -1098,8 +1098,8 @@ static void genpd_syscore_switch(struct device *dev, bool suspend)
 {
 	struct generic_pm_domain *genpd;
 
-	genpd = dev_to_genpd(dev);
-	if (!pm_genpd_present(genpd))
+	genpd = genpd_lookup_dev(dev);
+	if (!genpd)
 		return;
 
 	if (suspend) {
-- 
2.9.3
