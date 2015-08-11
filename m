From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH V2 1/6] PM / OPP: Free resources and properly return error on failure
Date: Tue, 11 Aug 2015 16:04:34 +0530
Message-ID: <334a9052264630b9157fa9bfc3d4efe945054c34.1439288881.git.viresh.kumar@linaro.org>
References: <cover.1439288881.git.viresh.kumar@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f47.google.com ([209.85.220.47]:35665 "EHLO
	mail-pa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934095AbbHKKeu (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 11 Aug 2015 06:34:50 -0400
Received: by pacgr6 with SMTP id gr6so48250228pac.2
        for <linux-pm@vger.kernel.org>; Tue, 11 Aug 2015 03:34:49 -0700 (PDT)
In-Reply-To: <cover.1439288881.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1439288881.git.viresh.kumar@linaro.org>
References: <cover.1439288881.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>, nm@ti.com, sboyd@codeaurora.org
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, khilman@linaro.org, Viresh Kumar <viresh.kumar@linaro.org>, Dan Carpenter <dan.carpenter@oracle.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Len Brown <len.brown@intel.com>, open list <linux-kernel@vger.kernel.org>, Pavel Machek <pavel@ucw.cz>

_of_init_opp_table_v2() isn't freeing up resources on some errors and
the error values returned are also not correct always.

This fixes following problems:
- Return -ENOENT, if no entries are found in the table.
- Use IS_ERR() to properly check return value of _find_device_opp().
- Return error value with PTR_ERR() in above case.
- Free table if _find_device_opp() fails.

Fixes: 274659029c9d ("PM / OPP: Add support to parse operating-points-v2" bindings")
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/base/power/opp.c | 29 +++++++++++++++--------------
 1 file changed, 15 insertions(+), 14 deletions(-)

diff --git a/drivers/base/power/opp.c b/drivers/base/power/opp.c
index 204c6c945168..bcbd92c3b717 100644
--- a/drivers/base/power/opp.c
+++ b/drivers/base/power/opp.c
@@ -1323,28 +1323,29 @@ static int _of_init_opp_table_v2(struct device *dev,
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
+	goto put_opp_np;
+
+free_table:
+	of_free_opp_table(dev);
 put_opp_np:
 	of_node_put(opp_np);
 
-- 
2.4.0

