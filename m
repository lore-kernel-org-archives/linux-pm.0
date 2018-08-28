From: Rob Herring <robh@kernel.org>
Subject: [PATCH] cpufreq: Convert to using %pOFn instead of device_node.name
Date: Mon, 27 Aug 2018 20:52:15 -0500
Message-ID: <20180828015252.28511-14-robh@kernel.org>
References: <20180828015252.28511-1-robh@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180828015252.28511-1-robh@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>, linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

In preparation to remove the node name pointer from struct device_node,
convert printf users to use the %pOFn format specifier.

Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Viresh Kumar <viresh.kumar@linaro.org>
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-samsung-soc@vger.kernel.org
Cc: linux-pm@vger.kernel.org
Signed-off-by: Rob Herring <robh@kernel.org>
---
 drivers/cpufreq/s5pv210-cpufreq.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/cpufreq/s5pv210-cpufreq.c b/drivers/cpufreq/s5pv210-cpufreq.c
index 5d31c2db12a3..dbecd7667db2 100644
--- a/drivers/cpufreq/s5pv210-cpufreq.c
+++ b/drivers/cpufreq/s5pv210-cpufreq.c
@@ -611,8 +611,8 @@ static int s5pv210_cpufreq_probe(struct platform_device *pdev)
 	for_each_compatible_node(np, NULL, "samsung,s5pv210-dmc") {
 		id = of_alias_get_id(np, "dmc");
 		if (id < 0 || id >= ARRAY_SIZE(dmc_base)) {
-			pr_err("%s: failed to get alias of dmc node '%s'\n",
-				__func__, np->name);
+			pr_err("%s: failed to get alias of dmc node '%pOFn'\n",
+				__func__, np);
 			of_node_put(np);
 			return id;
 		}
-- 
2.17.1
