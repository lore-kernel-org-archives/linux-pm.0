From: Wolfram Sang <wsa@the-dreams.de>
Subject: [PATCH 05/28] cpufreq: drop owner assignment from platform_drivers
Date: Sun, 21 Dec 2014 22:14:26 +0100
Message-ID: <1419196495-9626-6-git-send-email-wsa@the-dreams.de>
References: <1419196495-9626-1-git-send-email-wsa@the-dreams.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1419196495-9626-1-git-send-email-wsa@the-dreams.de>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Wolfram Sang <wsa@the-dreams.de>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

This platform_driver does not need to set an owner, it will be populated by the
driver core.

Signed-off-by: Wolfram Sang <wsa@the-dreams.de>
---
Generated with coccinelle. SmPL file is in the introductory msg. The big
cleanup was pulled in this merge window. This series catches the bits fallen
through. The patches shall go in via the subsystem trees.

 drivers/cpufreq/ls1x-cpufreq.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/cpufreq/ls1x-cpufreq.c b/drivers/cpufreq/ls1x-cpufreq.c
index 25fbd6a1374f..f0913eee2f50 100644
--- a/drivers/cpufreq/ls1x-cpufreq.c
+++ b/drivers/cpufreq/ls1x-cpufreq.c
@@ -210,7 +210,6 @@ out:
 static struct platform_driver ls1x_cpufreq_platdrv = {
 	.driver = {
 		.name	= "ls1x-cpufreq",
-		.owner	= THIS_MODULE,
 	},
 	.probe		= ls1x_cpufreq_probe,
 	.remove		= ls1x_cpufreq_remove,
-- 
2.1.3
