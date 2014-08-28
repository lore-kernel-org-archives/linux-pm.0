From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH V3 03/10] cpufreq: cpu0: don't validate clock on clk_put()
Date: Thu, 28 Aug 2014 11:22:25 +0530
Message-ID: <4f6f0b21db83466aef5569fddcef76a3c9b7dc5a.1409201048.git.viresh.kumar@linaro.org>
References: <cover.1409201048.git.viresh.kumar@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f47.google.com ([209.85.220.47]:38137 "EHLO
	mail-pa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934070AbaH1FxB (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 28 Aug 2014 01:53:01 -0400
Received: by mail-pa0-f47.google.com with SMTP id hz1so1115842pad.34
        for <linux-pm@vger.kernel.org>; Wed, 27 Aug 2014 22:53:00 -0700 (PDT)
In-Reply-To: <cover.1409201048.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1409201048.git.viresh.kumar@linaro.org>
References: <cover.1409201048.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, shawn.guo@linaro.org, sboyd@codeaurora.org, linux-arm-msm@vger.kernel.org, spk.linux@gmail.com, thomas.ab@samsung.com, t.figa@samsung.com, santosh.shilimkar@ti.com, thomas.petazzoni@free-electrons.com, pramod.gurav@smartplayin.com, Viresh Kumar <viresh.kumar@linaro.org>

CPU clk is not optional for this driver and probe would fail if it couldn't find
a suitable clock.

And so, while calling clk_put() we don't need to validate clocks.

Acked-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
Tested-by: Stephen Boyd <sboyd@codeaurora.org>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/cpufreq-cpu0.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/cpufreq/cpufreq-cpu0.c b/drivers/cpufreq/cpufreq-cpu0.c
index 4cfde63..d2dc921 100644
--- a/drivers/cpufreq/cpufreq-cpu0.c
+++ b/drivers/cpufreq/cpufreq-cpu0.c
@@ -217,8 +217,7 @@ static int cpu0_cpufreq_probe(struct platform_device *pdev)
 out_free_table:
 	dev_pm_opp_free_cpufreq_table(cpu_dev, &freq_table);
 out_put_clk:
-	if (!IS_ERR(cpu_clk))
-		clk_put(cpu_clk);
+	clk_put(cpu_clk);
 out_put_reg:
 	if (!IS_ERR(cpu_reg))
 		regulator_put(cpu_reg);
-- 
2.0.3.693.g996b0fd

