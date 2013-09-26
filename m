From: Sachin Kamat <sachin.kamat@linaro.org>
Subject: [PATCH 1/1] cpufreq: SPEAr: Fix incorrect variable type
Date: Thu, 26 Sep 2013 10:56:42 +0530
Message-ID: <1380173202-12624-1-git-send-email-sachin.kamat@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pb0-f42.google.com ([209.85.160.42]:60423 "EHLO
	mail-pb0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750805Ab3IZF0q (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 26 Sep 2013 01:26:46 -0400
Received: by mail-pb0-f42.google.com with SMTP id un15so638972pbc.15
        for <linux-pm@vger.kernel.org>; Wed, 25 Sep 2013 22:26:45 -0700 (PDT)
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: cpufreq@vger.kernel.org, viresh.kumar@linaro.org, rjw@sisk.pl, sachin.kamat@linaro.org

'clk_round_rate' returns a negative error code upon failure. This
will never get detected by unsigned 'newfreq'. Make it signed.

Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
---
 drivers/cpufreq/spear-cpufreq.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/cpufreq/spear-cpufreq.c b/drivers/cpufreq/spear-cpufreq.c
index 19e364fa..3f41816 100644
--- a/drivers/cpufreq/spear-cpufreq.c
+++ b/drivers/cpufreq/spear-cpufreq.c
@@ -113,7 +113,7 @@ static int spear_cpufreq_target(struct cpufreq_policy *policy,
 		unsigned int target_freq, unsigned int relation)
 {
 	struct cpufreq_freqs freqs;
-	unsigned long newfreq;
+	long newfreq;
 	struct clk *srcclk;
 	int index, ret, mult = 1;
 
-- 
1.7.9.5

