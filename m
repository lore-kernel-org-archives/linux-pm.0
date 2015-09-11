From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH 04/16] PM / OPP: Rename routines specific to old bindings with _v1
Date: Fri, 11 Sep 2015 17:32:00 +0530
Message-ID: <eadf49f87f771f65292c393c455a457a2f976a65.1441972771.git.viresh.kumar@linaro.org>
References: <cover.1441972771.git.viresh.kumar@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1441972771.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1441972771.git.viresh.kumar@linaro.org>
References: <cover.1441972771.git.viresh.kumar@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>, nm@ti.com, sboyd@codeaurora.org
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, rob.herring@linaro.org, lee.jones@linaro.org, Viresh Kumar <viresh.kumar@linaro.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Dmitry Torokhov <dtor@chromium.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Len Brown <len.brown@intel.com>, open list <linux-kernel@vger.kernel.org>, Pavel Machek <pavel@ucw.cz>
List-Id: linux-pm@vger.kernel.org

Clearly distinguish routines based on what version of bindings they
parse. We have already postfixed routines properly with _v2 for new
bindings. Postfix the older ones now with _v1.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/base/power/opp/core.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/base/power/opp/core.c b/drivers/base/power/opp/core.c
index 113fdd0ce6d9..6bebc503d727 100644
--- a/drivers/base/power/opp/core.c
+++ b/drivers/base/power/opp/core.c
@@ -718,7 +718,7 @@ static int _opp_add(struct device *dev, struct dev_pm_opp *new_opp,
 }
 
 /**
- * _opp_add_dynamic() - Allocate a dynamic OPP.
+ * _opp_add_v1() - Allocate a OPP based on v1 bindings.
  * @dev:	device for which we do this operation
  * @freq:	Frequency in Hz for this OPP
  * @u_volt:	Voltage in uVolts for this OPP
@@ -744,8 +744,8 @@ static int _opp_add(struct device *dev, struct dev_pm_opp *new_opp,
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
@@ -949,7 +949,7 @@ static int _opp_add_static_v2(struct device *dev, struct device_node *np)
  */
 int dev_pm_opp_add(struct device *dev, unsigned long freq, unsigned long u_volt)
 {
-	return _opp_add_dynamic(dev, freq, u_volt, true);
+	return _opp_add_v1(dev, freq, u_volt, true);
 }
 EXPORT_SYMBOL_GPL(dev_pm_opp_add);
 
@@ -1251,7 +1251,7 @@ static int _of_add_opp_table_v1(struct device *dev)
 		unsigned long freq = be32_to_cpup(val++) * 1000;
 		unsigned long volt = be32_to_cpup(val++);
 
-		if (_opp_add_dynamic(dev, freq, volt, false))
+		if (_opp_add_v1(dev, freq, volt, false))
 			dev_warn(dev, "%s: Failed to add OPP %ld\n",
 				 __func__, freq);
 		nr -= 2;
-- 
2.4.0
