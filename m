From: Geliang Tang <geliangtang@gmail.com>
Subject: [PATCH] cpufreq: dbx500: use builtin_platform_driver
Date: Wed, 23 Nov 2016 22:42:52 +0800
Message-ID: <3e21f3c9748b18f97d3b7e2e534b31a64601177c.1479912098.git.geliangtang@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>
Cc: Geliang Tang <geliangtang@gmail.com>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Use builtin_platform_driver() helper to simplify the code.

Signed-off-by: Geliang Tang <geliangtang@gmail.com>
---
 drivers/cpufreq/dbx500-cpufreq.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/cpufreq/dbx500-cpufreq.c b/drivers/cpufreq/dbx500-cpufreq.c
index 5c3ec1d..d257a75 100644
--- a/drivers/cpufreq/dbx500-cpufreq.c
+++ b/drivers/cpufreq/dbx500-cpufreq.c
@@ -73,11 +73,7 @@ static struct platform_driver dbx500_cpufreq_plat_driver = {
 	.probe = dbx500_cpufreq_probe,
 };
 
-static int __init dbx500_cpufreq_register(void)
-{
-	return platform_driver_register(&dbx500_cpufreq_plat_driver);
-}
-device_initcall(dbx500_cpufreq_register);
+builtin_platform_driver(dbx500_cpufreq_plat_driver);
 
 MODULE_LICENSE("GPL v2");
 MODULE_DESCRIPTION("cpufreq driver for DBX500");
-- 
2.9.3
