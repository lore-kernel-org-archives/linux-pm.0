From: Arvind Yadav <arvind.yadav.cs@gmail.com>
Subject: [PATCH v1] cpufreq: kirkwood-cpufreq:- Handle return value of clk_prepare_enable
Date: Tue, 16 May 2017 12:41:57 +0530
Message-ID: <1494918717-16434-1-git-send-email-arvind.yadav.cs@gmail.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pg0-f68.google.com ([74.125.83.68]:36826 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751052AbdEPHNS (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 16 May 2017 03:13:18 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: rjw@rjwysocki.net, viresh.kumar@linaro.org
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org

Here, Clock enable can failed. So adding an error check for
clk_prepare_enable.

Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
---
 drivers/cpufreq/kirkwood-cpufreq.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/drivers/cpufreq/kirkwood-cpufreq.c b/drivers/cpufreq/kirkwood-cpufreq.c
index 1b9bcd7..4c30103 100644
--- a/drivers/cpufreq/kirkwood-cpufreq.c
+++ b/drivers/cpufreq/kirkwood-cpufreq.c
@@ -127,7 +127,12 @@ static int kirkwood_cpufreq_probe(struct platform_device *pdev)
 		return PTR_ERR(priv.cpu_clk);
 	}
 
-	clk_prepare_enable(priv.cpu_clk);
+	err = clk_prepare_enable(priv.cpu_clk);
+	if (err) {
+		dev_err(priv.dev, "Unable to prepare cpuclk\n");
+		return err;
+	}
+
 	kirkwood_freq_table[0].frequency = clk_get_rate(priv.cpu_clk) / 1000;
 
 	priv.ddr_clk = of_clk_get_by_name(np, "ddrclk");
@@ -137,7 +142,11 @@ static int kirkwood_cpufreq_probe(struct platform_device *pdev)
 		goto out_cpu;
 	}
 
-	clk_prepare_enable(priv.ddr_clk);
+	err = clk_prepare_enable(priv.ddr_clk);
+	if (err) {
+		dev_err(priv.dev, "Unable to prepare ddrclk\n");
+		goto out_cpu;
+	}
 	kirkwood_freq_table[1].frequency = clk_get_rate(priv.ddr_clk) / 1000;
 
 	priv.powersave_clk = of_clk_get_by_name(np, "powersave");
-- 
1.9.1
