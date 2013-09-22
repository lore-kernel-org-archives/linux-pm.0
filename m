From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH 01/21] cpuidle: fix indentation of cpumask
Date: Sun, 22 Sep 2013 06:50:53 +0530
Message-ID: <eaff05d5201fc70c52aec578a35e265a65b0711b.1379779777.git.viresh.kumar@linaro.org>
References: <cover.1379779777.git.viresh.kumar@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1379779777.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1379779777.git.viresh.kumar@linaro.org>
References: <cover.1379779777.git.viresh.kumar@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: rjw@sisk.pl, daniel.lezcano@linaro.org
Cc: linaro-kernel@lists.linaro.org, patches@linaro.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Viresh Kumar <viresh.kumar@linaro.org>
List-Id: linux-pm@vger.kernel.org

cpumask is indented using spaces instead of tabs. Fix it.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 include/linux/cpuidle.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/cpuidle.h b/include/linux/cpuidle.h
index 781addc..c082425 100644
--- a/include/linux/cpuidle.h
+++ b/include/linux/cpuidle.h
@@ -114,7 +114,7 @@ struct cpuidle_driver {
 	int			safe_state_index;
 
 	/* the driver handles the cpus in cpumask */
-	struct cpumask       *cpumask;
+	struct cpumask		*cpumask;
 };
 
 #ifdef CONFIG_CPU_IDLE
-- 
1.7.12.rc2.18.g61b472e
