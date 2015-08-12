From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH V3 1/2] PM / OPP: Free resources and properly return error on failure
Date: Wed, 12 Aug 2015 16:30:18 +0530
Message-ID: <e2412c33aa6923767b394adffee9d3f7be1ee27f.1439376998.git.viresh.kumar@linaro.org>
References: <cover.1439376998.git.viresh.kumar@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1439376998.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1439376998.git.viresh.kumar@linaro.org>
References: <cover.1439376998.git.viresh.kumar@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, dan.carpenter@oracle.com, nm@ti.com, sboyd@codeaurora.org, Viresh Kumar <viresh.kumar@linaro.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Len Brown <len.brown@intel.com>, open list <linux-kernel@vger.kernel.org>, Pavel Machek <pavel@ucw.cz>
List-Id: linux-pm@vger.kernel.org

_of_init_opp_table_v2() isn't freeing up resources on some errors and
the error values returned are also not correct always.

This fixes following problems:
- Return -ENOENT, if no entries are found in the table.
- Use IS_ERR() to properly check return value of _find_device_opp().
- Return error value with PTR_ERR() in above case.
- Free table if _find_device_opp() fails.

Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/base/power/opp.c | 30 ++++++++++++++++--------------
 1 file changed, 16 insertions(+), 14 deletions(-)

diff --git a/drivers/base/power/opp.c b/drivers/base/power/opp.c
index 204c6c945168..4d6c4576f7ae 100644
--- a/drivers/base/power/opp.c
+++ b/drivers/base/power/opp.c
@@ -1323,28 +1323,30 @@ static int _of_init_opp_table_v2(struct device *dev,
 		if (ret) {
 			dev_err(dev, "%s: Failed to add OPP, %d\n", __func__,
 				ret);
-			break;
+			goto free_table;
 		}
 	}
 
 	/* There should be one of more OPP defined */
-	if (WARN_ON(!count))
+	if (WARN_ON(!count)) {
+		ret = -ENOENT;
 		goto put_opp_np;
+	}
 
-	if (!ret) {
-		if (!dev_opp) {
-			dev_opp = _find_device_opp(dev);
-			if (WARN_ON(!dev_opp))
-				goto put_opp_np;
-		}
-
-		dev_opp->np = opp_np;
-		dev_opp->shared_opp = of_property_read_bool(opp_np,
-							    "opp-shared");
-	} else {
-		of_free_opp_table(dev);
+	dev_opp = _find_device_opp(dev);
+	if (WARN_ON(IS_ERR(dev_opp))) {
+		ret = PTR_ERR(dev_opp);
+		goto free_table;
 	}
 
+	dev_opp->np = opp_np;
+	dev_opp->shared_opp = of_property_read_bool(opp_np, "opp-shared");
+
+	of_node_put(opp_np);
+	return 0;
+
+free_table:
+	of_free_opp_table(dev);
 put_opp_np:
 	of_node_put(opp_np);
 
-- 
2.4.0
