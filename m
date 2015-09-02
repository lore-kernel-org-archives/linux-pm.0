From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH 2/3] cpufreq: dt: Print error on failing to mark OPPs as shared
Date: Wed,  2 Sep 2015 14:36:49 +0530
Message-ID: <d6445556b82fc23728295b064e1711823c33eec2.1441184706.git.viresh.kumar@linaro.org>
References: <cover.1441184706.git.viresh.kumar@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1441184706.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1441184706.git.viresh.kumar@linaro.org>
References: <cover.1441184706.git.viresh.kumar@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, Viresh Kumar <viresh.kumar@linaro.org>, open list <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

We need to explicitly mark OPPs as shared, when they are not defined
with OPP-v2 bindings. This operation can potentially fail, and in that
case we should at least print an error message.

Fixes: 2e02d8723edf ("cpufreq: dt: Add support for operating-points-v2 bindings")
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/cpufreq-dt.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/cpufreq/cpufreq-dt.c b/drivers/cpufreq/cpufreq-dt.c
index 8c38b5192baa..b1131cf89757 100644
--- a/drivers/cpufreq/cpufreq-dt.c
+++ b/drivers/cpufreq/cpufreq-dt.c
@@ -260,7 +260,10 @@ static int cpufreq_init(struct cpufreq_policy *policy)
 		 * OPP tables are initialized only for policy->cpu, do it for
 		 * others as well.
 		 */
-		set_cpus_sharing_opps(cpu_dev, policy->cpus);
+		ret = set_cpus_sharing_opps(cpu_dev, policy->cpus);
+		if (ret)
+			dev_err(cpu_dev, "%s: failed to mark OPPs as shared: %d\n",
+				__func__, ret);
 
 		of_property_read_u32(np, "clock-latency", &transition_latency);
 	} else {
-- 
2.4.0
