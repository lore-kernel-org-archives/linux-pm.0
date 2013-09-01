From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH 1/2] cpufreq: don't allow governor limits to be changed when it is disabled
Date: Sun,  1 Sep 2013 10:56:01 +0530
Message-ID: <085013f4e584e3fef97187bcb349c3fa76942e19.1378012620.git.viresh.kumar@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pb0-f45.google.com ([209.85.160.45]:39384 "EHLO
	mail-pb0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754859Ab3IAF0O (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sun, 1 Sep 2013 01:26:14 -0400
Received: by mail-pb0-f45.google.com with SMTP id mc17so3463068pbc.32
        for <linux-pm@vger.kernel.org>; Sat, 31 Aug 2013 22:26:12 -0700 (PDT)
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: rjw@sisk.pl, sboyd@codeaurora.org
Cc: linaro-kernel@lists.linaro.org, patches@linaro.org, cpufreq@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Viresh Kumar <viresh.kumar@linaro.org>

__cpufreq_governor() returns with -EBUSY when governor is already stopped and we
try to stop it again, but when it is stopped we must not allow calls to
CPUFREQ_GOV_LIMITS event as well.

This patch adds this check in __cpufreq_governor().

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
Hi Rafael,

Its better if we can get these in for 3.11, otherwise we need to get them in the
stable tree..

Anyway, we will get these in 3.10 stable tree but that requires us to identify
few more patches that will go with these. I will do that later.

This must fix the issues reported by Stephen.

Tested on my thinkpad over your linux-next branch.

 drivers/cpufreq/cpufreq.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index 5c75e31..f320a20 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -1692,8 +1692,9 @@ static int __cpufreq_governor(struct cpufreq_policy *policy,
 						policy->cpu, event);
 
 	mutex_lock(&cpufreq_governor_lock);
-	if ((!policy->governor_enabled && (event == CPUFREQ_GOV_STOP)) ||
-	    (policy->governor_enabled && (event == CPUFREQ_GOV_START))) {
+	if ((policy->governor_enabled && (event == CPUFREQ_GOV_START)) ||
+		(!policy->governor_enabled && ((event == CPUFREQ_GOV_LIMITS) ||
+					       (event == CPUFREQ_GOV_STOP)))) {
 		mutex_unlock(&cpufreq_governor_lock);
 		return -EBUSY;
 	}
-- 
1.7.12.rc2.18.g61b472e

