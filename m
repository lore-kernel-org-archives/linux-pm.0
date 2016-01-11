From: Juri Lelli <juri.lelli@arm.com>
Subject: [RFC PATCH 14/19] cpufreq: fix locking of policy->rwsem in cpufreq_offline_finish
Date: Mon, 11 Jan 2016 17:35:55 +0000
Message-ID: <1452533760-13787-15-git-send-email-juri.lelli@arm.com>
References: <1452533760-13787-1-git-send-email-juri.lelli@arm.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:57283 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1761245AbcAKRhl (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Mon, 11 Jan 2016 12:37:41 -0500
In-Reply-To: <1452533760-13787-1-git-send-email-juri.lelli@arm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: linux-pm@vger.kernel.org, peterz@infradead.org, rjw@rjwysocki.net, viresh.kumar@linaro.org, mturquette@baylibre.com, steve.muckle@linaro.org, vincent.guittot@linaro.org, morten.rasmussen@arm.com, dietmar.eggemann@arm.com, juri.lelli@arm.com

There are paths in cpufreq_offline_prepare where policy is used, but its
rwsem is not held.

Fix it.

Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Viresh Kumar <viresh.kumar@linaro.org>
Signed-off-by: Juri Lelli <juri.lelli@arm.com>
---
 drivers/cpufreq/cpufreq.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index 91158b0..ba452c3 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -1381,9 +1381,13 @@ static void cpufreq_offline_finish(unsigned int cpu)
 		return;
 	}
 
+	down_write(&policy->rwsem);
+
 	/* Only proceed for inactive policies */
-	if (!policy_is_inactive(policy))
+	if (!policy_is_inactive(policy)) {
+		up_write(&policy->rwsem);
 		return;
+	}
 
 	/* If cpu is last user of policy, free policy */
 	if (has_target()) {
@@ -1392,6 +1396,8 @@ static void cpufreq_offline_finish(unsigned int cpu)
 			pr_err("%s: Failed to exit governor\n", __func__);
 	}
 
+	up_write(&policy->rwsem);
+
 	/*
 	 * Perform the ->exit() even during light-weight tear-down,
 	 * since this is a core component, and is essential for the
-- 
2.2.2

