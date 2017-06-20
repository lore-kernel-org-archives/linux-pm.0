From: Mikko Perttunen <mperttunen@nvidia.com>
Subject: [PATCH] PM / Domains: Call driver's noirq callbacks
Date: Tue, 20 Jun 2017 15:05:27 +0300
Message-ID: <1497960327-22832-1-git-send-email-mperttunen@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: rjw@rjwysocki.net, khilman@kernel.org, ulf.hansson@linaro.org
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Mikko Perttunen <mperttunen@nvidia.com>
List-Id: linux-pm@vger.kernel.org

Currently genpd installs its own suspend_noirq and resume_noirq
callbacks, but never calls down to the driver's corresponding
callbacks. Add these calls.

Signed-off-by: Mikko Perttunen <mperttunen@nvidia.com>
---

 drivers/base/power/domain.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
index d3f1d96f75e9..c3b6e6018c02 100644
--- a/drivers/base/power/domain.c
+++ b/drivers/base/power/domain.c
@@ -925,6 +925,10 @@ static int pm_genpd_suspend_noirq(struct device *dev)
 			return ret;
 	}
 
+	ret = pm_generic_suspend_noirq(dev);
+	if (ret)
+		return ret;
+
 	genpd_lock(genpd);
 	genpd->suspended_count++;
 	genpd_sync_power_off(genpd, true, 0);
@@ -958,6 +962,10 @@ static int pm_genpd_resume_noirq(struct device *dev)
 	genpd->suspended_count--;
 	genpd_unlock(genpd);
 
+	ret = pm_generic_resume_noirq(dev);
+	if (ret)
+		return ret;
+
 	if (genpd->dev_ops.stop && genpd->dev_ops.start)
 		ret = pm_runtime_force_resume(dev);
 
-- 
2.1.4
