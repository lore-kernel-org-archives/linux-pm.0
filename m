From: Sachin Kamat <sachin.kamat@linaro.org>
Subject: [PATCH 3/3] cpufreq: s3c24xx: Staticize local variable
Date: Fri,  3 Jan 2014 14:57:37 +0530
Message-ID: <1388741257-26438-3-git-send-email-sachin.kamat@linaro.org>
References: <1388741257-26438-1-git-send-email-sachin.kamat@linaro.org>
Return-path: <cpufreq-owner@vger.kernel.org>
In-Reply-To: <1388741257-26438-1-git-send-email-sachin.kamat@linaro.org>
Sender: cpufreq-owner@vger.kernel.org
To: cpufreq@vger.kernel.org
Cc: linux-pm@vger.kernel.org, rjw@rjwysocki.net, viresh.kumar@linaro.org, sachin.kamat@linaro.org, patches@linaro.org
List-Id: linux-pm@vger.kernel.org

Local variable used only in this file is made static.

Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
---
 drivers/cpufreq/s3c24xx-cpufreq.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/cpufreq/s3c24xx-cpufreq.c b/drivers/cpufreq/s3c24xx-cpufreq.c
index 485088253358..35fa697e615a 100644
--- a/drivers/cpufreq/s3c24xx-cpufreq.c
+++ b/drivers/cpufreq/s3c24xx-cpufreq.c
@@ -509,7 +509,7 @@ int __init s3c_cpufreq_setboard(struct s3c_cpufreq_board *board)
 	return 0;
 }
 
-int __init s3c_cpufreq_auto_io(void)
+static int __init s3c_cpufreq_auto_io(void)
 {
 	int ret;
 
-- 
1.7.9.5

