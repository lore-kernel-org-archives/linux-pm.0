From: Juri Lelli <juri.lelli@arm.com>
Subject: [RFC PATCH 11/19] cpufreq: assert policy->rwsem is held in __cpufreq_governor
Date: Mon, 11 Jan 2016 17:35:52 +0000
Message-ID: <1452533760-13787-12-git-send-email-juri.lelli@arm.com>
References: <1452533760-13787-1-git-send-email-juri.lelli@arm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1452533760-13787-1-git-send-email-juri.lelli@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: linux-pm@vger.kernel.org, peterz@infradead.org, rjw@rjwysocki.net, viresh.kumar@linaro.org, mturquette@baylibre.com, steve.muckle@linaro.org, vincent.guittot@linaro.org, morten.rasmussen@arm.com, dietmar.eggemann@arm.com, juri.lelli@arm.com
List-Id: linux-pm@vger.kernel.org

__cpufreq_governor works on policy, so policy->rwsem has to be held.
Add assertion for such condition.

Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Viresh Kumar <viresh.kumar@linaro.org>
Signed-off-by: Juri Lelli <juri.lelli@arm.com>
---
 drivers/cpufreq/cpufreq.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index f1f9fbc..e7fc5c9 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -1950,6 +1950,9 @@ static int __cpufreq_governor(struct cpufreq_policy *policy,
 	/* Don't start any governor operations if we are entering suspend */
 	if (cpufreq_suspended)
 		return 0;
+
+	lockdep_assert_held(&policy->rwsem);
+
 	/*
 	 * Governor might not be initiated here if ACPI _PPC changed
 	 * notification happened, so check it.
-- 
2.2.2
