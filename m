From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH V3 02/10] PM / OPP: Remove useless TODO
Date: Mon,  2 Jan 2017 14:40:56 +0530
Message-ID: <2648e94b6660d45e8beab558a8611d70342a46fd.1483348138.git.viresh.kumar@linaro.org>
References: <cover.1483348138.git.viresh.kumar@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1483348138.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1483348138.git.viresh.kumar@linaro.org>
References: <cover.1483348138.git.viresh.kumar@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>, Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@codeaurora.org>
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>, Viresh Kumar <viresh.kumar@linaro.org>
List-Id: linux-pm@vger.kernel.org

This TODO doesn't make sense anymore as we have all the information in a
single OPP table. Remove it.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
Reviewed-by: Stephen Boyd <sboyd@codeaurora.org>
---
 drivers/base/power/opp/of.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/base/power/opp/of.c b/drivers/base/power/opp/of.c
index 356c75edd656..996ca3b42f47 100644
--- a/drivers/base/power/opp/of.c
+++ b/drivers/base/power/opp/of.c
@@ -246,8 +246,6 @@ EXPORT_SYMBOL_GPL(dev_pm_opp_of_remove_table);
 static struct device_node *_of_get_opp_desc_node(struct device *dev)
 {
 	/*
-	 * TODO: Support for multiple OPP tables.
-	 *
 	 * There should be only ONE phandle present in "operating-points-v2"
 	 * property.
 	 */
-- 
2.7.1.410.g6faf27b
