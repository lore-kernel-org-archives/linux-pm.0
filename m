From: Juri Lelli <juri.lelli@arm.com>
Subject: [RFC PATCH 10/19] cpufreq: assert policy->rwsem is held in cpufreq_set_policy
Date: Mon, 11 Jan 2016 17:35:51 +0000
Message-ID: <1452533760-13787-11-git-send-email-juri.lelli@arm.com>
References: <1452533760-13787-1-git-send-email-juri.lelli@arm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1452533760-13787-1-git-send-email-juri.lelli@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: linux-pm@vger.kernel.org, peterz@infradead.org, rjw@rjwysocki.net, viresh.kumar@linaro.org, mturquette@baylibre.com, steve.muckle@linaro.org, vincent.guittot@linaro.org, morten.rasmussen@arm.com, dietmar.eggemann@arm.com, juri.lelli@arm.com
List-Id: linux-pm@vger.kernel.org

Since cpufreq_set_policy is modifying policy, it has to work under policy->
rwsem protection.

Assert such condition.

Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Viresh Kumar <viresh.kumar@linaro.org>
Signed-off-by: Juri Lelli <juri.lelli@arm.com>
---
 drivers/cpufreq/cpufreq.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index d91fdb8..f1f9fbc 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -2109,6 +2109,8 @@ static int cpufreq_set_policy(struct cpufreq_policy *policy,
 	pr_debug("setting new policy for CPU %u: %u - %u kHz\n",
 		 new_policy->cpu, new_policy->min, new_policy->max);
 
+	lockdep_assert_held(&policy->rwsem);
+
 	memcpy(&new_policy->cpuinfo, &policy->cpuinfo, sizeof(policy->cpuinfo));
 
 	/*
-- 
2.2.2
