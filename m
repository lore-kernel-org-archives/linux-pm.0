From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH V4 3/8] opp: Enhance debug messages in of_init_opp_table()
Date: Tue, 27 May 2014 17:20:52 +0530
Message-ID: <2a9d8e2954166e47d7cdcf9c540dea572b080e7b.1401191054.git.viresh.kumar@linaro.org>
References: <cover.1401191054.git.viresh.kumar@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1401191054.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1401191054.git.viresh.kumar@linaro.org>
References: <cover.1401191054.git.viresh.kumar@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: rjw@rjwysocki.net
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, arvind.chauhan@arm.com, inderpal.s@samsung.com, nm@ti.com, chander.kashyap@linaro.org, pavel@ucw.cz, len.brown@intel.com, sudeep.holla@arm.com, Viresh Kumar <viresh.kumar@linaro.org>
List-Id: linux-pm@vger.kernel.org

Enhance print messages for debugging purposes. Add a dev_err() whenever we fail
to initialize OPP table due to some error in the table present in dts and add a
dev_dbg() for success case.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/base/power/opp.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/base/power/opp.c b/drivers/base/power/opp.c
index 2b615b9..ed5d580 100644
--- a/drivers/base/power/opp.c
+++ b/drivers/base/power/opp.c
@@ -628,8 +628,11 @@ int of_init_opp_table(struct device *dev)
 	prop = of_find_property(dev->of_node, "operating-points", NULL);
 	if (!prop)
 		return -ENODEV;
-	if (!prop->value)
+	if (!prop->value) {
+		dev_err(dev, "%s: failed to init OPP: prop->value is NULL\n",
+			__func__);
 		return -ENODATA;
+	}
 
 	/*
 	 * Each OPP is a set of tuples consisting of frequency and
@@ -653,6 +656,8 @@ int of_init_opp_table(struct device *dev)
 	}
 
 	of_node_put(dev->of_node);
+
+	dev_dbg(dev, "%s: successfully created OPP table\n", __func__);
 	return 0;
 }
 EXPORT_SYMBOL_GPL(of_init_opp_table);
-- 
2.0.0.rc2
