From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH 4/4] cpufreq: dt: Add support for turbo/boost mode
Date: Tue, 28 Jul 2015 16:50:03 +0530
Message-ID: <d5d8ae28200fff13ac04cfc46d47d1e609ce3158.1438081962.git.viresh.kumar@linaro.org>
References: <cover.1438081962.git.viresh.kumar@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1438081962.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1438081962.git.viresh.kumar@linaro.org>
References: <cover.1438081962.git.viresh.kumar@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, b.zolnierkie@samsung.com, nm@ti.com, sboyd@codeaurora.org, Viresh Kumar <viresh.kumar@linaro.org>, open list <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

With opp-v2 DT bindings, few OPPs can be used only for the boost mode.
But using such OPPs require the boost mode to be supported by cpufreq
driver.

We will parse DT bindings only during ->init() and so can enable boost
support only after registering cpufreq driver.

This enables boost support as soon as any policy has boost/turbo OPPs
for its CPUs.

We don't need to disable boost support as that is done by the core, when
the driver is unregistered.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/cpufreq-dt.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/cpufreq/cpufreq-dt.c b/drivers/cpufreq/cpufreq-dt.c
index c6e7033076de..b9259abd25d4 100644
--- a/drivers/cpufreq/cpufreq-dt.c
+++ b/drivers/cpufreq/cpufreq-dt.c
@@ -330,6 +330,14 @@ static int cpufreq_init(struct cpufreq_policy *policy)
 		goto out_free_cpufreq_table;
 	}
 
+	/* Support turbo/boost mode */
+	if (policy_has_boost_freq(policy)) {
+		/* This gets disabled by core on driver unregister */
+		ret = cpufreq_enable_boost_support();
+		if (ret)
+			goto out_free_cpufreq_table;
+	}
+
 	policy->cpuinfo.transition_latency = transition_latency;
 
 	of_node_put(np);
-- 
2.4.0
