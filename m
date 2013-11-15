From: Lan Tianyu <tianyu.lan@intel.com>
Subject: [PATCH] Cpufreq: Remove fossil comment in the cpufreq_governor_dbs()
Date: Fri, 15 Nov 2013 13:54:01 +0800
Message-ID: <1384494841-28581-1-git-send-email-tianyu.lan@intel.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:16089 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750998Ab3KOGFV (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Fri, 15 Nov 2013 01:05:21 -0500
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: rjw@rjwysocki.net, viresh.kumar@linaro.org
Cc: Lan Tianyu <tianyu.lan@intel.com>, cpufreq@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org

The related code has been changed and the comment is out of data.
So remove it.

Signed-off-by: Lan Tianyu <tianyu.lan@intel.com>
---
 drivers/cpufreq/cpufreq_governor.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/cpufreq/cpufreq_governor.c b/drivers/cpufreq/cpufreq_governor.c
index 0806c31..e6be635 100644
--- a/drivers/cpufreq/cpufreq_governor.c
+++ b/drivers/cpufreq/cpufreq_governor.c
@@ -328,10 +328,6 @@ int cpufreq_governor_dbs(struct cpufreq_policy *policy,
 					     dbs_data->cdata->gov_dbs_timer);
 		}
 
-		/*
-		 * conservative does not implement micro like ondemand
-		 * governor, thus we are bound to jiffes/HZ
-		 */
 		if (dbs_data->cdata->governor == GOV_CONSERVATIVE) {
 			cs_dbs_info->down_skip = 0;
 			cs_dbs_info->enable = 1;
-- 
1.8.4.rc0.1.g8f6a3e5.dirty

