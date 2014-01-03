From: Sachin Kamat <sachin.kamat@linaro.org>
Subject: [PATCH 2/3] cpufreq: s3c2440: Staticize local variables
Date: Fri,  3 Jan 2014 14:57:36 +0530
Message-ID: <1388741257-26438-2-git-send-email-sachin.kamat@linaro.org>
References: <1388741257-26438-1-git-send-email-sachin.kamat@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f46.google.com ([209.85.220.46]:62357 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751061AbaACJb1 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 3 Jan 2014 04:31:27 -0500
Received: by mail-pa0-f46.google.com with SMTP id kp14so13598726pab.19
        for <linux-pm@vger.kernel.org>; Fri, 03 Jan 2014 01:31:27 -0800 (PST)
In-Reply-To: <1388741257-26438-1-git-send-email-sachin.kamat@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: cpufreq@vger.kernel.org
Cc: linux-pm@vger.kernel.org, rjw@rjwysocki.net, viresh.kumar@linaro.org, sachin.kamat@linaro.org, patches@linaro.org

Local variables used only in this file are made static.

Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
---
 drivers/cpufreq/s3c2440-cpufreq.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/cpufreq/s3c2440-cpufreq.c b/drivers/cpufreq/s3c2440-cpufreq.c
index 717ef04ec90e..f84ed10755b5 100644
--- a/drivers/cpufreq/s3c2440-cpufreq.c
+++ b/drivers/cpufreq/s3c2440-cpufreq.c
@@ -53,7 +53,7 @@ static inline int within_khz(unsigned long a, unsigned long b)
  * specified in @cfg. The values are stored in @cfg for later use
  * by the relevant set routine if the request settings can be reached.
  */
-int s3c2440_cpufreq_calcdivs(struct s3c_cpufreq_config *cfg)
+static int s3c2440_cpufreq_calcdivs(struct s3c_cpufreq_config *cfg)
 {
 	unsigned int hdiv, pdiv;
 	unsigned long hclk, fclk, armclk;
@@ -240,7 +240,7 @@ static int s3c2440_cpufreq_calctable(struct s3c_cpufreq_config *cfg,
 	return ret;
 }
 
-struct s3c_cpufreq_info s3c2440_cpufreq_info = {
+static struct s3c_cpufreq_info s3c2440_cpufreq_info = {
 	.max		= {
 		.fclk	= 400000000,
 		.hclk	= 133333333,
-- 
1.7.9.5

