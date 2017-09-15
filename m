From: Bo Yan <byan@nvidia.com>
Subject: [PATCH] cpufreq: cpufreq_stats: make last_index signed int
Date: Fri, 15 Sep 2017 13:13:22 -0700
Message-ID: <1505506402-11497-1-git-send-email-byan@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from hqemgate15.nvidia.com ([216.228.121.64]:7086 "EHLO
        hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751593AbdIOUPj (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 15 Sep 2017 16:15:39 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: viresh.kumar@linaro.org, rjw@rjwysocki.net, linux-pm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Bo Yan <byan@nvidia.com>

It is possible for last_index to get a -1 if current frequency
is not found in the freq table when stats is created. If the
function "cpufreq_stats_update" is called before last_index is
updated with a valid value, the "-1" will be used as index to
update stats->time_in_state, triggering an exception.

Change the type of last_index of cpufreq_stats from unsigned int
to signed int.

Move last_time to location right before time_in_state. This helps
save 4 bytes in a LP64 programming model.

Signed-off-by: Bo Yan <byan@nvidia.com>
---
 drivers/cpufreq/cpufreq_stats.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/cpufreq/cpufreq_stats.c b/drivers/cpufreq/cpufreq_stats.c
index e75880eb037d..a6838f5a2004 100644
--- a/drivers/cpufreq/cpufreq_stats.c
+++ b/drivers/cpufreq/cpufreq_stats.c
@@ -18,10 +18,10 @@ static DEFINE_SPINLOCK(cpufreq_stats_lock);
 
 struct cpufreq_stats {
 	unsigned int total_trans;
-	unsigned long long last_time;
 	unsigned int max_state;
 	unsigned int state_num;
-	unsigned int last_index;
+	int last_index;
+	unsigned long long last_time;
 	u64 *time_in_state;
 	unsigned int *freq_table;
 	unsigned int *trans_table;
-- 
2.7.4
