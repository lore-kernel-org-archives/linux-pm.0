From: Hanjun Guo <hanjun.guo@linaro.org>
Subject: [PATCH 3/3] cpufreq / s3c24xx: Fix __init attribute locations
Date: Tue, 13 Aug 2013 18:20:10 +0800
Message-ID: <1376389210-11470-3-git-send-email-hanjun.guo@linaro.org>
References: <1376389210-11470-1-git-send-email-hanjun.guo@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pb0-f52.google.com ([209.85.160.52]:37368 "EHLO
	mail-pb0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752756Ab3HMKXr (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 13 Aug 2013 06:23:47 -0400
Received: by mail-pb0-f52.google.com with SMTP id wz12so4505813pbc.11
        for <linux-pm@vger.kernel.org>; Tue, 13 Aug 2013 03:23:46 -0700 (PDT)
In-Reply-To: <1376389210-11470-1-git-send-email-hanjun.guo@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, cpufreq@vger.kernel.org, linux-pm@vger.kernel.org, patches@linaro.org, linaro-kernel@lists.linaro.org, linaro-acpi@lists.linaro.org, Hanjun Guo <hanjun.guo@linaro.org>

__init belongs after the return type on functions, not before it.

Signed-off-by: Hanjun Guo <hanjun.guo@linaro.org>
---
 drivers/cpufreq/s3c24xx-cpufreq.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/cpufreq/s3c24xx-cpufreq.c b/drivers/cpufreq/s3c24xx-cpufreq.c
index 87781eb..3d927d6 100644
--- a/drivers/cpufreq/s3c24xx-cpufreq.c
+++ b/drivers/cpufreq/s3c24xx-cpufreq.c
@@ -392,7 +392,7 @@ static int s3c_cpufreq_init(struct cpufreq_policy *policy)
 	return 0;
 }
 
-static __init int s3c_cpufreq_initclks(void)
+static int __init s3c_cpufreq_initclks(void)
 {
 	_clk_mpll = s3c_cpufreq_clk_get(NULL, "mpll");
 	_clk_xtal = s3c_cpufreq_clk_get(NULL, "xtal");
-- 
1.7.9.5

