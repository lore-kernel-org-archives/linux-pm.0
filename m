From: Pramod Gurav <pramod.gurav@smartplayin.com>
Subject: [PATCH 2/3] cpufreq: cpu0: Removes unnecessary IS_ERR check on clk
Date: Thu, 28 Aug 2014 00:00:11 -0700
Message-ID: <1409209212-18730-2-git-send-email-pramod.gurav@smartplayin.com>
References: <1409209212-18730-1-git-send-email-pramod.gurav@smartplayin.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1409209212-18730-1-git-send-email-pramod.gurav@smartplayin.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org
Cc: Pramod Gurav <pramod.gurav@smartplayin.com>, Shawn Guo <shawn.guo@linaro.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>
List-Id: linux-pm@vger.kernel.org

This removes unnecessary IS_ERR check on clk when in failure path
as execution wont reach till there with clk being a err.

CC: Shawn Guo <shawn.guo@linaro.org>
CC: "Rafael J. Wysocki" <rjw@rjwysocki.net>
CC: Viresh Kumar <viresh.kumar@linaro.org>
Signed-off-by: Pramod Gurav <pramod.gurav@smartplayin.com>
---
 drivers/cpufreq/cpufreq-cpu0.c |    3 +--
 1 files changed, 1 insertions(+), 2 deletions(-)

diff --git a/drivers/cpufreq/cpufreq-cpu0.c b/drivers/cpufreq/cpufreq-cpu0.c
index e1574f8..0652cea 100644
--- a/drivers/cpufreq/cpufreq-cpu0.c
+++ b/drivers/cpufreq/cpufreq-cpu0.c
@@ -214,8 +214,7 @@ static int cpu0_cpufreq_probe(struct platform_device *pdev)
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
1.7.0.4
