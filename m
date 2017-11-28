From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH v4.9] PM / OPP: Add missing of_node_put(np)
Date: Tue, 28 Nov 2017 12:21:38 +0530
Message-ID: <ae2651dc6a3e347122f4736eb3a682185508cbc7.1511851887.git.viresh.kumar@linaro.org>
Return-path: <stable-owner@vger.kernel.org>
Sender: stable-owner@vger.kernel.org
To: stable@vger.kernel.org
Cc: Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

From: Tobias Jordan <Tobias.Jordan@elektrobit.com>

commit 7978db344719dab1e56d05e6fc04aaaddcde0a5e upstream.

The for_each_available_child_of_node() loop in _of_add_opp_table_v2()
doesn't drop the reference to "np" on errors. Fix that.

Fixes: 274659029c9d (PM / OPP: Add support to parse "operating-points-v2" bindings)
Cc: 4.9 <stable@vger.kernel.org> # 4.9
Signed-off-by: Tobias Jordan <Tobias.Jordan@elektrobit.com>
[ VK: Improved commit log. ]
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
Reviewed-by: Stephen Boyd <sboyd@codeaurora.org>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/base/power/opp/of.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/base/power/opp/of.c b/drivers/base/power/opp/of.c
index 5552211e6fcd..af208884bbed 100644
--- a/drivers/base/power/opp/of.c
+++ b/drivers/base/power/opp/of.c
@@ -348,6 +348,7 @@ static int _of_add_opp_table_v2(struct device *dev, struct device_node *opp_np)
 		if (ret) {
 			dev_err(dev, "%s: Failed to add OPP, %d\n", __func__,
 				ret);
+			of_node_put(np);
 			goto free_table;
 		}
 	}
-- 
2.15.0.194.g9af6a3dea062
