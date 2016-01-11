From: Juri Lelli <juri.lelli@arm.com>
Subject: [RFC PATCH 01/19] cpufreq: do not expose cpufreq_governor_lock
Date: Mon, 11 Jan 2016 17:35:42 +0000
Message-ID: <1452533760-13787-2-git-send-email-juri.lelli@arm.com>
References: <1452533760-13787-1-git-send-email-juri.lelli@arm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1452533760-13787-1-git-send-email-juri.lelli@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: linux-pm@vger.kernel.org, peterz@infradead.org, rjw@rjwysocki.net, viresh.kumar@linaro.org, mturquette@baylibre.com, steve.muckle@linaro.org, vincent.guittot@linaro.org, morten.rasmussen@arm.com, dietmar.eggemann@arm.com, juri.lelli@arm.com
List-Id: linux-pm@vger.kernel.org

From: Michael Turquette <mturquette@baylibre.com>

Since commit 3a91b069eabf ("cpufreq: governor: Quit work-handlers early if
governor is stopped") cpufreq_governor_lock is not used anywhere outside
cpufreq.c. Make it static again.

Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Viresh Kumar <viresh.kumar@linaro.org>
Signed-off-by: Juri Lelli <juri.lelli@arm.com>
Signed-off-by: Michael Turquette <mturquette@baylibre.com>
---
 drivers/cpufreq/cpufreq.c          | 2 +-
 drivers/cpufreq/cpufreq_governor.h | 2 --
 2 files changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index c35e7da..7bdd845 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -102,7 +102,7 @@ static LIST_HEAD(cpufreq_governor_list);
 static struct cpufreq_driver *cpufreq_driver;
 static DEFINE_PER_CPU(struct cpufreq_policy *, cpufreq_cpu_data);
 static DEFINE_RWLOCK(cpufreq_driver_lock);
-DEFINE_MUTEX(cpufreq_governor_lock);
+static DEFINE_MUTEX(cpufreq_governor_lock);
 
 /* Flag to suspend/resume CPUFreq governors */
 static bool cpufreq_suspended;
diff --git a/drivers/cpufreq/cpufreq_governor.h b/drivers/cpufreq/cpufreq_governor.h
index 91e767a..65b2893 100644
--- a/drivers/cpufreq/cpufreq_governor.h
+++ b/drivers/cpufreq/cpufreq_governor.h
@@ -269,8 +269,6 @@ static ssize_t show_sampling_rate_min_gov_pol				\
 	return sprintf(buf, "%u\n", dbs_data->min_sampling_rate);	\
 }
 
-extern struct mutex cpufreq_governor_lock;
-
 void gov_add_timers(struct cpufreq_policy *policy, unsigned int delay);
 void gov_cancel_work(struct cpu_common_dbs_info *shared);
 void dbs_check_cpu(struct dbs_data *dbs_data, int cpu);
-- 
2.2.2
