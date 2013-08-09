From: Jingoo Han <jg1.han@samsung.com>
Subject: [PATCH] cpufreq: unicore2: Staticize local symbol
Date: Fri, 09 Aug 2013 16:14:51 +0900
Message-ID: <000701ce94d0$240949e0$6c1bdda0$@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <cpufreq-owner@vger.kernel.org>
Content-language: ko
Sender: cpufreq-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, cpufreq@vger.kernel.org, linux-pm@vger.kernel.org, Guan Xuetao <gxt@mprc.pku.edu.cn>, Jingoo Han <jg1.han@samsung.com>
List-Id: linux-pm@vger.kernel.org

This local symbol is used only in this file.
Fix the following sparse warnings:

drivers/cpufreq/unicore2-cpufreq.c:27:5: warning: symbol 'ucv2_verify_speed' was not declared. Should it be static?

Signed-off-by: Jingoo Han <jg1.han@samsung.com>
---
 drivers/cpufreq/unicore2-cpufreq.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/cpufreq/unicore2-cpufreq.c b/drivers/cpufreq/unicore2-cpufreq.c
index 12fc904..b225f04 100644
--- a/drivers/cpufreq/unicore2-cpufreq.c
+++ b/drivers/cpufreq/unicore2-cpufreq.c
@@ -24,7 +24,7 @@ static struct cpufreq_driver ucv2_driver;
 /* make sure that only the "userspace" governor is run
  * -- anything else wouldn't make sense on this platform, anyway.
  */
-int ucv2_verify_speed(struct cpufreq_policy *policy)
+static int ucv2_verify_speed(struct cpufreq_policy *policy)
 {
 	if (policy->cpu)
 		return -EINVAL;
-- 
1.7.10.4


