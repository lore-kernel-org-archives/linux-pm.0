From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH V3 3/3] cpufreq: governor: Process remote callback for shared policies
Date: Thu, 13 Jul 2017 12:14:39 +0530
Message-ID: <93a9001437dac267e083f4df55f68bd2e2455d47.1499927699.git.viresh.kumar@linaro.org>
References: <cover.1499927699.git.viresh.kumar@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1499927699.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1499927699.git.viresh.kumar@linaro.org>
References: <cover.1499927699.git.viresh.kumar@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>
Cc: linux-pm@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>, smuckle.linux@gmail.com, juri.lelli@arm.com, Morten.Rasmussen@arm.com, patrick.bellasi@arm.com, eas-dev@lists.linaro.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

This patch updates the legacy governors (ondemand/conservative) to
process cpufreq utilization update hooks to be called for remote CPUs.

Proper locking is already in place for shared policies and nothing extra
is required to be done.

Based on initial work from Steve Muckle.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/cpufreq_governor.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/cpufreq/cpufreq_governor.c b/drivers/cpufreq/cpufreq_governor.c
index 606b1a37a1af..0b49fc8bb91d 100644
--- a/drivers/cpufreq/cpufreq_governor.c
+++ b/drivers/cpufreq/cpufreq_governor.c
@@ -275,8 +275,8 @@ static void dbs_update_util_handler(struct update_util_data *data, u64 time,
 	struct policy_dbs_info *policy_dbs = cdbs->policy_dbs;
 	u64 delta_ns, lst;
 
-	/* Don't allow remote callbacks */
-	if (smp_processor_id() != data->cpu)
+	/* Allow remote callbacks only on the CPUs sharing cpufreq policy */
+	if (!cpumask_test_cpu(smp_processor_id(), policy_dbs->policy->cpus))
 		return;
 
 	/*
-- 
2.13.0.71.gd7076ec9c9cb
