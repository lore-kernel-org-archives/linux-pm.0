From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH V2 1/4] cpufreq: schedutil: Avoid indented labels
Date: Tue, 15 Nov 2016 13:53:20 +0530
Message-ID: <ac70c5f48b070bb9050705c6defc76f13a492702.1479197311.git.viresh.kumar@linaro.org>
References: <cover.1479197311.git.viresh.kumar@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1479197311.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1479197311.git.viresh.kumar@linaro.org>
References: <cover.1479197311.git.viresh.kumar@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>, Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>, Juri Lelli <Juri.Lelli@arm.com>, Robin Randhawa <robin.randhawa@arm.com>, Steve Muckle <smuckle.linux@gmail.com>, Viresh Kumar <viresh.kumar@linaro.org>
List-Id: linux-pm@vger.kernel.org

Switch to the more common practice of writing labels.

Suggested-by: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 kernel/sched/cpufreq_schedutil.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_schedutil.c
index 69e06898997d..8c4e1652e895 100644
--- a/kernel/sched/cpufreq_schedutil.c
+++ b/kernel/sched/cpufreq_schedutil.c
@@ -454,17 +454,17 @@ static int sugov_init(struct cpufreq_policy *policy)
 	if (ret)
 		goto fail;
 
- out:
+out:
 	mutex_unlock(&global_tunables_lock);
 
 	cpufreq_enable_fast_switch(policy);
 	return 0;
 
- fail:
+fail:
 	policy->governor_data = NULL;
 	sugov_tunables_free(tunables);
 
- free_sg_policy:
+free_sg_policy:
 	mutex_unlock(&global_tunables_lock);
 
 	sugov_policy_free(sg_policy);
-- 
2.7.1.410.g6faf27b
