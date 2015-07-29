From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH V3 16/16] cpufreq: dt: Add support for turbo/boost mode
Date: Wed, 29 Jul 2015 16:23:11 +0530
Message-ID: <5dba664d47ca399e0ad7a55f2d74688d1300a703.1438166099.git.viresh.kumar@linaro.org>
References: <cover.1438166099.git.viresh.kumar@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1438166099.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1438166099.git.viresh.kumar@linaro.org>
References: <cover.1438166099.git.viresh.kumar@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>, sboyd@codeaurora.org
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, rob.herring@linaro.org, arnd.bergmann@linaro.org, nm@ti.com, broonie@kernel.org, mturquette@baylibre.com, Sudeep.Holla@arm.com, viswanath.puttagunta@linaro.org, l.stach@pengutronix.de, thomas.petazzoni@free-electrons.com, linux-arm-kernel@lists.infradead.org, ta.omasab@gmail.com, kesavan.abhilash@gmail.com, khilman@linaro.org, santosh.shilimkar@oracle.com, b.zolnierkie@samsung.com, Viresh Kumar <viresh.kumar@linaro.org>, open list <linux-kernel@vger.kernel.org>
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
