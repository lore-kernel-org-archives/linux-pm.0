From: Colin King <colin.king@canonical.com>
Subject: [PATCH] cpufreq: kirkwood: add missing \n to end of dev_err messages
Date: Sun, 25 Sep 2016 14:35:43 -0700
Message-ID: <20160925213543.12267-1-colin.king@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from youngberry.canonical.com ([91.189.89.112]:41741 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933339AbcIYVfs (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 25 Sep 2016 17:35:48 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: trivial@kernel.org, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

Trival fix, dev_err messages are missing a \n, so add it.

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/cpufreq/kirkwood-cpufreq.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/cpufreq/kirkwood-cpufreq.c b/drivers/cpufreq/kirkwood-cpufreq.c
index be42f10..1b9bcd7 100644
--- a/drivers/cpufreq/kirkwood-cpufreq.c
+++ b/drivers/cpufreq/kirkwood-cpufreq.c
@@ -123,7 +123,7 @@ static int kirkwood_cpufreq_probe(struct platform_device *pdev)
 
 	priv.cpu_clk = of_clk_get_by_name(np, "cpu_clk");
 	if (IS_ERR(priv.cpu_clk)) {
-		dev_err(priv.dev, "Unable to get cpuclk");
+		dev_err(priv.dev, "Unable to get cpuclk\n");
 		return PTR_ERR(priv.cpu_clk);
 	}
 
@@ -132,7 +132,7 @@ static int kirkwood_cpufreq_probe(struct platform_device *pdev)
 
 	priv.ddr_clk = of_clk_get_by_name(np, "ddrclk");
 	if (IS_ERR(priv.ddr_clk)) {
-		dev_err(priv.dev, "Unable to get ddrclk");
+		dev_err(priv.dev, "Unable to get ddrclk\n");
 		err = PTR_ERR(priv.ddr_clk);
 		goto out_cpu;
 	}
@@ -142,7 +142,7 @@ static int kirkwood_cpufreq_probe(struct platform_device *pdev)
 
 	priv.powersave_clk = of_clk_get_by_name(np, "powersave");
 	if (IS_ERR(priv.powersave_clk)) {
-		dev_err(priv.dev, "Unable to get powersave");
+		dev_err(priv.dev, "Unable to get powersave\n");
 		err = PTR_ERR(priv.powersave_clk);
 		goto out_ddr;
 	}
@@ -155,7 +155,7 @@ static int kirkwood_cpufreq_probe(struct platform_device *pdev)
 	if (!err)
 		return 0;
 
-	dev_err(priv.dev, "Failed to register cpufreq driver");
+	dev_err(priv.dev, "Failed to register cpufreq driver\n");
 
 	clk_disable_unprepare(priv.powersave_clk);
 out_ddr:
-- 
2.9.3

