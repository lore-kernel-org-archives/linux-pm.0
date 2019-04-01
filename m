From: Wen Yang <wen.yang99@zte.com.cn>
Subject: [PATCH 3/7] cpufreq: kirkwood: fix possible object reference leak
Date: Mon, 1 Apr 2019 09:37:50 +0800
Message-ID: <1554082674-2049-4-git-send-email-wen.yang99@zte.com.cn>
References: <1554082674-2049-1-git-send-email-wen.yang99@zte.com.cn>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1554082674-2049-1-git-send-email-wen.yang99@zte.com.cn>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: wang.yi59@zte.com.cn, Wen Yang <wen.yang99@zte.com.cn>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

The call to of_get_child_by_name returns a node pointer with refcount
incremented thus it must be explicitly decremented after the last
usage.

Detected by coccinelle with the following warnings:
./drivers/cpufreq/kirkwood-cpufreq.c:127:2-8: ERROR: missing of_node_put; acquired a node pointer with refcount incremented on line 118, but without a corresponding object release within this function.
./drivers/cpufreq/kirkwood-cpufreq.c:133:2-8: ERROR: missing of_node_put; acquired a node pointer with refcount incremented on line 118, but without a corresponding object release within this function.

and also do some cleanup:
- of_node_put(np);
- np = NULL;
...
of_node_put(np);

Signed-off-by: Wen Yang <wen.yang99@zte.com.cn>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Viresh Kumar <viresh.kumar@linaro.org>
Cc: linux-pm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
---
 drivers/cpufreq/kirkwood-cpufreq.c | 19 +++++++++++--------
 1 file changed, 11 insertions(+), 8 deletions(-)

diff --git a/drivers/cpufreq/kirkwood-cpufreq.c b/drivers/cpufreq/kirkwood-cpufreq.c
index c2dd43f..8d63a6dc 100644
--- a/drivers/cpufreq/kirkwood-cpufreq.c
+++ b/drivers/cpufreq/kirkwood-cpufreq.c
@@ -124,13 +124,14 @@ static int kirkwood_cpufreq_probe(struct platform_device *pdev)
 	priv.cpu_clk = of_clk_get_by_name(np, "cpu_clk");
 	if (IS_ERR(priv.cpu_clk)) {
 		dev_err(priv.dev, "Unable to get cpuclk\n");
-		return PTR_ERR(priv.cpu_clk);
+		err = PTR_ERR(priv.cpu_clk);
+		goto out_node;
 	}
 
 	err = clk_prepare_enable(priv.cpu_clk);
 	if (err) {
 		dev_err(priv.dev, "Unable to prepare cpuclk\n");
-		return err;
+		goto out_node;
 	}
 
 	kirkwood_freq_table[0].frequency = clk_get_rate(priv.cpu_clk) / 1000;
@@ -161,20 +162,22 @@ static int kirkwood_cpufreq_probe(struct platform_device *pdev)
 		goto out_ddr;
 	}
 
-	of_node_put(np);
-	np = NULL;
-
 	err = cpufreq_register_driver(&kirkwood_cpufreq_driver);
-	if (!err)
-		return 0;
+	if (err) {
+		dev_err(priv.dev, "Failed to register cpufreq driver\n");
+		goto out_powersave;
+	}
 
-	dev_err(priv.dev, "Failed to register cpufreq driver\n");
+	of_node_put(np);
+	return 0;
 
+out_powersave:
 	clk_disable_unprepare(priv.powersave_clk);
 out_ddr:
 	clk_disable_unprepare(priv.ddr_clk);
 out_cpu:
 	clk_disable_unprepare(priv.cpu_clk);
+out_node:
 	of_node_put(np);
 
 	return err;
-- 
2.9.5
