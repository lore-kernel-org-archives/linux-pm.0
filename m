From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH] cpufreq: SPEAr: Fix sparse warning for cpufreq driver
Date: Sat, 12 Jan 2013 10:42:09 +0530
Message-ID: <6d76f8457b4eb42bcbab8e0221f90168a8fbc328.1357967480.git.viresh.kumar@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:41899 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750732Ab3ALFMU (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sat, 12 Jan 2013 00:12:20 -0500
Received: by mail-pb0-f46.google.com with SMTP id wy7so1297189pbc.19
        for <linux-pm@vger.kernel.org>; Fri, 11 Jan 2013 21:12:20 -0800 (PST)
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: rjw@sisk.pl
Cc: cpufreq@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Viresh Kumar <viresh.kumar@linaro.org>

This patch fixes following sparse warning:

drivers/cpufreq/spear-cpufreq.c:33:5: warning: symbol 'spear_cpufreq_verify' was
not declared. Should it be static?

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/spear-cpufreq.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/cpufreq/spear-cpufreq.c b/drivers/cpufreq/spear-cpufreq.c
index 4575cfe..8ff26af 100644
--- a/drivers/cpufreq/spear-cpufreq.c
+++ b/drivers/cpufreq/spear-cpufreq.c
@@ -30,7 +30,7 @@ static struct {
 	u32 cnt;
 } spear_cpufreq;
 
-int spear_cpufreq_verify(struct cpufreq_policy *policy)
+static int spear_cpufreq_verify(struct cpufreq_policy *policy)
 {
 	return cpufreq_frequency_table_verify(policy, spear_cpufreq.freq_tbl);
 }
-- 
1.7.12.rc2.18.g61b472e

