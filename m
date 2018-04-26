From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH 03/11] PM / Domains: Drop redundant code in genpd while attaching devices
Date: Thu, 26 Apr 2018 10:53:02 +0200
Message-ID: <1524732790-2234-4-git-send-email-ulf.hansson@linaro.org>
References: <1524732790-2234-1-git-send-email-ulf.hansson@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1524732790-2234-1-git-send-email-ulf.hansson@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J . Wysocki" <rjw@rjwysocki.net>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-pm@vger.kernel.org
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Kevin Hilman <khilman@kernel.org>, Geert Uytterhoeven <geert+renesas@glider.be>, Viresh Kumar <viresh.kumar@linaro.org>, Vincent Guittot <vincent.guittot@linaro.org>, Mark Brown <broonie@kernel.org>, Vinod Koul <vinod.koul@intel.com>, Sanyog Kale <sanyog.r.kale@intel.com>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, Wolfram Sang <wsa@the-dreams.de>, Russell King <linux@armlinux.org.uk>, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-pm@vger.kernel.org

The driver core together with the PM core, nowadays deals with deferring
all probes during the device system sleep phases. Therefore genpd no longer
need to care about this situation, so let's drop the corresponding code.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/base/power/domain.c | 17 ++---------------
 1 file changed, 2 insertions(+), 15 deletions(-)

diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
index d3703a1..d4b96ed 100644
--- a/drivers/base/power/domain.c
+++ b/drivers/base/power/domain.c
@@ -1377,7 +1377,7 @@ static int genpd_add_device(struct generic_pm_domain *genpd, struct device *dev,
 			    struct gpd_timing_data *td)
 {
 	struct generic_pm_domain_data *gpd_data;
-	int ret = 0;
+	int ret;
 
 	dev_dbg(dev, "%s()\n", __func__);
 
@@ -1390,11 +1390,6 @@ static int genpd_add_device(struct generic_pm_domain *genpd, struct device *dev,
 
 	genpd_lock(genpd);
 
-	if (genpd->prepared_count > 0) {
-		ret = -EAGAIN;
-		goto out;
-	}
-
 	ret = genpd->attach_dev ? genpd->attach_dev(genpd, dev) : 0;
 	if (ret)
 		goto out;
@@ -2194,7 +2189,6 @@ int genpd_dev_pm_attach(struct device *dev)
 {
 	struct of_phandle_args pd_args;
 	struct generic_pm_domain *pd;
-	unsigned int i;
 	int ret;
 
 	if (!dev->of_node)
@@ -2220,14 +2214,7 @@ int genpd_dev_pm_attach(struct device *dev)
 
 	dev_dbg(dev, "adding to PM domain %s\n", pd->name);
 
-	for (i = 1; i < GENPD_RETRY_MAX_MS; i <<= 1) {
-		ret = genpd_add_device(pd, dev, NULL);
-		if (ret != -EAGAIN)
-			break;
-
-		mdelay(i);
-		cond_resched();
-	}
+	ret = genpd_add_device(pd, dev, NULL);
 	mutex_unlock(&gpd_list_lock);
 
 	if (ret < 0) {
-- 
2.7.4
