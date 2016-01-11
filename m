From: Juri Lelli <juri.lelli@arm.com>
Subject: [RFC PATCH 03/19] cpufreq: kill for_each_policy
Date: Mon, 11 Jan 2016 17:35:44 +0000
Message-ID: <1452533760-13787-4-git-send-email-juri.lelli@arm.com>
References: <1452533760-13787-1-git-send-email-juri.lelli@arm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1452533760-13787-1-git-send-email-juri.lelli@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: linux-pm@vger.kernel.org, peterz@infradead.org, rjw@rjwysocki.net, viresh.kumar@linaro.org, mturquette@baylibre.com, steve.muckle@linaro.org, vincent.guittot@linaro.org, morten.rasmussen@arm.com, dietmar.eggemann@arm.com, juri.lelli@arm.com
List-Id: linux-pm@vger.kernel.org

for_each_policy() macro is not used anywhere. Kill it.

Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Viresh Kumar <viresh.kumar@linaro.org>
Signed-off-by: Juri Lelli <juri.lelli@arm.com>
---
 drivers/cpufreq/cpufreq.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index 0802705..2e41356 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -86,9 +86,6 @@ static struct cpufreq_policy *first_policy(bool active)
 #define for_each_inactive_policy(__policy)		\
 	for_each_suitable_policy(__policy, false)
 
-#define for_each_policy(__policy)			\
-	list_for_each_entry(__policy, &cpufreq_policy_list, policy_list)
-
 /* Iterate over governors */
 static LIST_HEAD(cpufreq_governor_list);
 #define for_each_governor(__governor)				\
-- 
2.2.2
