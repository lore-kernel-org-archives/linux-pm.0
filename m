From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH Resend] cpufreq_opp: Fixed the order of argument for kcalloc.
Date: Fri,  5 Sep 2014 08:38:30 +0530
Message-ID: <79b874a04ead23dc710c30edbe0eec4c5cff9be7.1409886422.git.viresh.kumar@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f48.google.com ([209.85.220.48]:43159 "EHLO
	mail-pa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751299AbaIEDIk (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 4 Sep 2014 23:08:40 -0400
Received: by mail-pa0-f48.google.com with SMTP id hz1so478301pad.21
        for <linux-pm@vger.kernel.org>; Thu, 04 Sep 2014 20:08:39 -0700 (PDT)
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>
Cc: linux-pm@vger.kernel.org, sboyd@codeaurora.org, moon.linux@yahoo.com

From: Anand Moon <moon.linux@yahoo.com>

These changes fix the argument to the kcalloc
        @n: number of elements.
        @size: element size.
        @flags: the type of memory to allocate (see kmalloc).

        void *kcalloc(size_t n, size_t size, gfp_t flags)

Signed-off-by: Anand Moon <moon.linux@yahoo.com>
Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
Reviewed-by: Stephen Boyd <sboyd@codeaurora.org>
---
 drivers/cpufreq/cpufreq_opp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/cpufreq/cpufreq_opp.c b/drivers/cpufreq/cpufreq_opp.c
index f7a32d2..773bcde 100644
--- a/drivers/cpufreq/cpufreq_opp.c
+++ b/drivers/cpufreq/cpufreq_opp.c
@@ -60,7 +60,7 @@ int dev_pm_opp_init_cpufreq_table(struct device *dev,
 		goto out;
 	}
 
-	freq_table = kcalloc(sizeof(*freq_table), (max_opps + 1), GFP_ATOMIC);
+	freq_table = kcalloc((max_opps + 1), sizeof(*freq_table), GFP_ATOMIC);
 	if (!freq_table) {
 		ret = -ENOMEM;
 		goto out;
-- 
2.0.3.693.g996b0fd

