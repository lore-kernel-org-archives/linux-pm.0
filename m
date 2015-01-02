From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH 06/17] cpufreq: No need to check for has_target()
Date: Fri,  2 Jan 2015 12:34:27 +0530
Message-ID: <7e7b61d27f62f46398a247542cbcaf5c782414fb.1420181916.git.viresh.kumar@linaro.org>
References: <cover.1420181916.git.viresh.kumar@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pd0-f172.google.com ([209.85.192.172]:49865 "EHLO
	mail-pd0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750744AbbABHFR (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 2 Jan 2015 02:05:17 -0500
Received: by mail-pd0-f172.google.com with SMTP id y13so23262794pdi.17
        for <linux-pm@vger.kernel.org>; Thu, 01 Jan 2015 23:05:17 -0800 (PST)
In-Reply-To: <cover.1420181916.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1420181916.git.viresh.kumar@linaro.org>
References: <cover.1420181916.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, prarit@redhat.com, skannan@codeaurora.org, Viresh Kumar <viresh.kumar@linaro.org>

Either we can be setpolicy or target type, nothing else. And so the else part of
setpolicy will automatically be of has_target() type. And so we don't need to
check it again.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/cpufreq.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index c9ba1d64015c..5e60b3259cf5 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -463,7 +463,7 @@ static int cpufreq_parse_governor(char *str_governor, unsigned int *policy,
 			*policy = CPUFREQ_POLICY_POWERSAVE;
 			err = 0;
 		}
-	} else if (has_target()) {
+	} else {
 		struct cpufreq_governor *t;
 
 		mutex_lock(&cpufreq_governor_mutex);
-- 
2.2.0

