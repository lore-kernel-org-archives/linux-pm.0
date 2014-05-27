From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH V4 2/8] opp: call of_node_{get|put}() from of_init_opp_table()
Date: Tue, 27 May 2014 17:20:51 +0530
Message-ID: <4139797fe7501ba99adf63ec8e5cf9fa9b24c197.1401191054.git.viresh.kumar@linaro.org>
References: <cover.1401191054.git.viresh.kumar@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1401191054.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1401191054.git.viresh.kumar@linaro.org>
References: <cover.1401191054.git.viresh.kumar@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: rjw@rjwysocki.net
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, arvind.chauhan@arm.com, inderpal.s@samsung.com, nm@ti.com, chander.kashyap@linaro.org, pavel@ucw.cz, len.brown@intel.com, sudeep.holla@arm.com, Viresh Kumar <viresh.kumar@linaro.org>
List-Id: linux-pm@vger.kernel.org

All callers of of_init_opp_table() are required to take reference of
dev->of_node, by initiating calls to of_node_{get|put}(), before and after
calling of_init_opp_table().

Its better to call these from within of_init_opp_table(), no fun adding
redundant code to every caller.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/base/power/opp.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/base/power/opp.c b/drivers/base/power/opp.c
index faae9cf..2b615b9 100644
--- a/drivers/base/power/opp.c
+++ b/drivers/base/power/opp.c
@@ -622,6 +622,9 @@ int of_init_opp_table(struct device *dev)
 	const __be32 *val;
 	int nr;
 
+	if (!of_node_get(dev->of_node))
+		return -ENODEV;
+
 	prop = of_find_property(dev->of_node, "operating-points", NULL);
 	if (!prop)
 		return -ENODEV;
@@ -649,6 +652,7 @@ int of_init_opp_table(struct device *dev)
 		nr -= 2;
 	}
 
+	of_node_put(dev->of_node);
 	return 0;
 }
 EXPORT_SYMBOL_GPL(of_init_opp_table);
-- 
2.0.0.rc2
