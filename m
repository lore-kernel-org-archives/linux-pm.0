From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH V3 2/8] cpufreq: s3c24xx: Remove useless checks
Date: Fri,  3 Jun 2016 10:58:46 +0530
Message-ID: <8520e7ab2698399b47dbf8c53accd48a01a89bd7.1464931080.git.viresh.kumar@linaro.org>
References: <cover.1464931080.git.viresh.kumar@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1464931080.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1464931080.git.viresh.kumar@linaro.org>
References: <cover.1464931080.git.viresh.kumar@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Krzysztof Kozlowski <k.kozlowski@samsung.com>
List-Id: linux-pm@vger.kernel.org

These aren't required at all, remove them.

Reviewed-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/s3c24xx-cpufreq.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/cpufreq/s3c24xx-cpufreq.c b/drivers/cpufreq/s3c24xx-cpufreq.c
index ae8eaed77b70..4567c3cab095 100644
--- a/drivers/cpufreq/s3c24xx-cpufreq.c
+++ b/drivers/cpufreq/s3c24xx-cpufreq.c
@@ -571,11 +571,7 @@ static int s3c_cpufreq_build_freq(void)
 {
 	int size, ret;
 
-	if (!cpu_cur.info->calc_freqtable)
-		return -EINVAL;
-
 	kfree(ftab);
-	ftab = NULL;
 
 	size = cpu_cur.info->calc_freqtable(&cpu_cur, NULL, 0);
 	size++;
-- 
2.7.1.410.g6faf27b
