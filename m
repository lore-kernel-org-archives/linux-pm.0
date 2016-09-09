From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH 1/3] cpufreq: dt: Remove unused code
Date: Fri,  9 Sep 2016 16:48:06 +0530
Message-ID: <1f5ea403f4a540a0187586e60b4f3a934fa0fc7d.1473419844.git.viresh.kumar@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Juri.Lelli@arm.com, arnd.bergmann@linaro.org
List-Id: linux-pm@vger.kernel.org

This is leftover from an earlier patch which removed the usage of
platform data but forgot to remove this line. Remove it now.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/cpufreq-dt.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/cpufreq/cpufreq-dt.c b/drivers/cpufreq/cpufreq-dt.c
index 3957de801ae8..2bd20534155d 100644
--- a/drivers/cpufreq/cpufreq-dt.c
+++ b/drivers/cpufreq/cpufreq-dt.c
@@ -366,8 +366,6 @@ static int dt_cpufreq_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
-	dt_cpufreq_driver.driver_data = dev_get_platdata(&pdev->dev);
-
 	ret = cpufreq_register_driver(&dt_cpufreq_driver);
 	if (ret)
 		dev_err(&pdev->dev, "failed register driver: %d\n", ret);
-- 
2.7.1.410.g6faf27b
