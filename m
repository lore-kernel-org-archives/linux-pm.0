From: Juri Lelli <juri.lelli@arm.com>
Subject: [RFC PATCH 07/19] cpufreq: assert locking when accessing cpufreq_governor_list
Date: Mon, 11 Jan 2016 17:35:48 +0000
Message-ID: <1452533760-13787-8-git-send-email-juri.lelli@arm.com>
References: <1452533760-13787-1-git-send-email-juri.lelli@arm.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:57238 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760496AbcAKRh0 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Mon, 11 Jan 2016 12:37:26 -0500
In-Reply-To: <1452533760-13787-1-git-send-email-juri.lelli@arm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: linux-pm@vger.kernel.org, peterz@infradead.org, rjw@rjwysocki.net, viresh.kumar@linaro.org, mturquette@baylibre.com, steve.muckle@linaro.org, vincent.guittot@linaro.org, morten.rasmussen@arm.com, dietmar.eggemann@arm.com, juri.lelli@arm.com

cpufreq_governor_list is guarded by cpufreq_governor_mutex. Add
appropriate locking assertions to check that we always access the list
while holding the lock protecting it.

Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Viresh Kumar <viresh.kumar@linaro.org>
Signed-off-by: Juri Lelli <juri.lelli@arm.com>
---
 drivers/cpufreq/cpufreq.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index 98adbc2..7dae7f3 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -506,6 +506,7 @@ static struct cpufreq_governor *find_governor(const char *str_governor)
 {
 	struct cpufreq_governor *t;
 
+	lockdep_assert_held(&cpufreq_governor_mutex);
 	for_each_governor(t)
 		if (!strncasecmp(str_governor, t->name, CPUFREQ_NAME_LEN))
 			return t;
@@ -693,6 +694,7 @@ static ssize_t show_scaling_available_governors(struct cpufreq_policy *policy,
 		goto out;
 	}
 
+	lockdep_assert_held(&cpufreq_governor_mutex);
 	for_each_governor(t) {
 		if (i >= (ssize_t) ((PAGE_SIZE / sizeof(char))
 		    - (CPUFREQ_NAME_LEN + 2)))
@@ -2025,6 +2027,7 @@ int cpufreq_register_governor(struct cpufreq_governor *governor)
 	err = -EBUSY;
 	if (!find_governor(governor->name)) {
 		err = 0;
+		lockdep_assert_held(&cpufreq_governor_mutex);
 		list_add(&governor->governor_list, &cpufreq_governor_list);
 	}
 
-- 
2.2.2

