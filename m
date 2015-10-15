From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH V2 2/4] PM / OPP: Rename routines specific to old bindings with _v1
Date: Thu, 15 Oct 2015 21:42:44 +0530
Message-ID: <3d59c93aa8107f96b659dd5e774596c5a396a9d8.1444925400.git.viresh.kumar@linaro.org>
References: <cover.1444925400.git.viresh.kumar@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f52.google.com ([209.85.220.52]:32978 "EHLO
	mail-pa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753320AbbJOQNW (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 15 Oct 2015 12:13:22 -0400
Received: by pabrc13 with SMTP id rc13so91894040pab.0
        for <linux-pm@vger.kernel.org>; Thu, 15 Oct 2015 09:13:22 -0700 (PDT)
In-Reply-To: <cover.1444925400.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1444925400.git.viresh.kumar@linaro.org>
References: <cover.1444925400.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, sboyd@codeaurora.org, nm@ti.com, Viresh Kumar <viresh.kumar@linaro.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Dmitry Torokhov <dtor@chromium.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Len Brown <len.brown@intel.com>, open list <linux-kernel@vger.kernel.org>, Pavel Machek <pavel@ucw.cz>

Clearly distinguish routines based on what version of bindings they
parse. We have already postfixed routines properly with _v2 for new
bindings. Postfix the older ones now with _v1.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/base/power/opp/core.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/base/power/opp/core.c b/drivers/base/power/opp/core.c
index a422ebf2501f..63b0f57601b8 100644
--- a/drivers/base/power/opp/core.c
+++ b/drivers/base/power/opp/core.c
@@ -703,7 +703,7 @@ static int _opp_add(struct device *dev, struct dev_pm_opp *new_opp,
 }
 
 /**
- * _opp_add_dynamic() - Allocate a dynamic OPP.
+ * _opp_add_v1() - Allocate a OPP based on v1 bindings.
  * @dev:	device for which we do this operation
  * @freq:	Frequency in Hz for this OPP
  * @u_volt:	Voltage in uVolts for this OPP
@@ -729,8 +729,8 @@ static int _opp_add(struct device *dev, struct dev_pm_opp *new_opp,
  *		Duplicate OPPs (both freq and volt are same) and !opp->available
  * -ENOMEM	Memory allocation failure
  */
-static int _opp_add_dynamic(struct device *dev, unsigned long freq,
-			    long u_volt, bool dynamic)
+static int _opp_add_v1(struct device *dev, unsigned long freq, long u_volt,
+		       bool dynamic)
 {
 	struct device_opp *dev_opp;
 	struct dev_pm_opp *new_opp;
@@ -941,7 +941,7 @@ static int _opp_add_static_v2(struct device *dev, struct device_node *np)
  */
 int dev_pm_opp_add(struct device *dev, unsigned long freq, unsigned long u_volt)
 {
-	return _opp_add_dynamic(dev, freq, u_volt, true);
+	return _opp_add_v1(dev, freq, u_volt, true);
 }
 EXPORT_SYMBOL_GPL(dev_pm_opp_add);
 
@@ -1243,7 +1243,7 @@ static int _of_add_opp_table_v1(struct device *dev)
 		unsigned long freq = be32_to_cpup(val++) * 1000;
 		unsigned long volt = be32_to_cpup(val++);
 
-		if (_opp_add_dynamic(dev, freq, volt, false))
+		if (_opp_add_v1(dev, freq, volt, false))
 			dev_warn(dev, "%s: Failed to add OPP %ld\n",
 				 __func__, freq);
 		nr -= 2;
-- 
2.4.0

