From: weiyj_lk@163.com
Subject: [PATCH -next] CPUFREQ: Loongson1: Fix return value check in ls1x_cpufreq_probe()
Date: Wed,  6 Jul 2016 12:20:55 +0000
Message-ID: <1467807655-31952-1-git-send-email-weiyj_lk@163.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from m12-15.163.com ([220.181.12.15]:49627 "EHLO m12-15.163.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751757AbcGFMVY (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Wed, 6 Jul 2016 08:21:24 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Keguang Zhang <keguang.zhang@gmail.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>
Cc: Wei Yongjun <yongjun_wei@trendmicro.com.cn>, linux-mips@linux-mips.org, linux-pm@vger.kernel.org

From: Wei Yongjun <yongjun_wei@trendmicro.com.cn>

In case of error, the function clk_get_parent() returns NULL pointer
not ERR_PTR(). The IS_ERR() test in the return value check should be
replaced with NULL test.

Signed-off-by: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
---
 drivers/cpufreq/loongson1-cpufreq.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/cpufreq/loongson1-cpufreq.c b/drivers/cpufreq/loongson1-cpufreq.c
index be89416..b3a62d0 100644
--- a/drivers/cpufreq/loongson1-cpufreq.c
+++ b/drivers/cpufreq/loongson1-cpufreq.c
@@ -162,18 +162,18 @@ static int ls1x_cpufreq_probe(struct platform_device *pdev)
 	cpufreq->clk = clk;
 
 	clk = clk_get_parent(clk);
-	if (IS_ERR(clk)) {
+	if (!clk) {
 		dev_err(&pdev->dev, "unable to get parent of %s clock\n",
 			__clk_get_name(cpufreq->clk));
-		return PTR_ERR(clk);
+		return -ENODEV;
 	}
 	cpufreq->mux_clk = clk;
 
 	clk = clk_get_parent(clk);
-	if (IS_ERR(clk)) {
+	if (!clk) {
 		dev_err(&pdev->dev, "unable to get parent of %s clock\n",
 			__clk_get_name(cpufreq->mux_clk));
-		return PTR_ERR(clk);
+		return -ENODEV;
 	}
 	cpufreq->pll_clk = clk;


