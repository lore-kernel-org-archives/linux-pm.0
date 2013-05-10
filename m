From: Wolfram Sang <wsa@the-dreams.de>
Subject: [RFC 03/42] drivers/cpufreq: don't check resource with devm_ioremap_resource
Date: Fri, 10 May 2013 10:16:48 +0200
Message-ID: <1368173847-5661-4-git-send-email-wsa@the-dreams.de>
References: <1368173847-5661-1-git-send-email-wsa@the-dreams.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1368173847-5661-1-git-send-email-wsa@the-dreams.de>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Wolfram Sang <wsa@the-dreams.de>, "Rafael J. Wysocki" <rjw@sisk.pl>, Viresh Kumar <viresh.kumar@linaro.org>, cpufreq@vger.kernel.org, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

devm_ioremap_resource does sanity checks on the given resource. No need to
duplicate this in the driver.

Signed-off-by: Wolfram Sang <wsa@the-dreams.de>
---
 drivers/cpufreq/kirkwood-cpufreq.c |    4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/cpufreq/kirkwood-cpufreq.c b/drivers/cpufreq/kirkwood-cpufreq.c
index d36ea8d..b2644af 100644
--- a/drivers/cpufreq/kirkwood-cpufreq.c
+++ b/drivers/cpufreq/kirkwood-cpufreq.c
@@ -171,10 +171,6 @@ static int kirkwood_cpufreq_probe(struct platform_device *pdev)
 	priv.dev = &pdev->dev;
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	if (!res) {
-		dev_err(&pdev->dev, "Cannot get memory resource\n");
-		return -ENODEV;
-	}
 	priv.base = devm_ioremap_resource(&pdev->dev, res);
 	if (IS_ERR(priv.base))
 		return PTR_ERR(priv.base);
-- 
1.7.10.4
