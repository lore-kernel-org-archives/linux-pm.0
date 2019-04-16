From: Yangtao Li <tiny.windzz@gmail.com>
Subject: [PATCH] PM / Domains: remove unnecessary unlikely()
Date: Tue, 16 Apr 2019 12:23:05 -0400
Message-ID: <20190416162305.24375-1-tiny.windzz@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: rjw@rjwysocki.net, khilman@kernel.org, ulf.hansson@linaro.org, pavel@ucw.cz, len.brown@intel.com, gregkh@linuxfoundation.org
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Yangtao Li <tiny.windzz@gmail.com>
List-Id: linux-pm@vger.kernel.org

WARN_ON() already contains an unlikely(), so it's not necessary to use
unlikely.

Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
---
 drivers/base/power/domain.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
index 96a6dc9d305c..598a4e02aee1 100644
--- a/drivers/base/power/domain.c
+++ b/drivers/base/power/domain.c
@@ -391,11 +391,9 @@ int dev_pm_genpd_set_performance_state(struct device *dev, unsigned int state)
 	if (unlikely(!genpd->set_performance_state))
 		return -EINVAL;
 
-	if (unlikely(!dev->power.subsys_data ||
-		     !dev->power.subsys_data->domain_data)) {
-		WARN_ON(1);
+	if (WARN_ON(!dev->power.subsys_data ||
+		     !dev->power.subsys_data->domain_data))
 		return -EINVAL;
-	}
 
 	genpd_lock(genpd);
 
-- 
2.17.0
