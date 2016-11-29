From: Viresh Kumar <viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: [PATCH V5 03/10] PM / OPP: Don't use OPP structure outside of rcu protected section
Date: Tue, 29 Nov 2016 12:06:50 +0530
Message-ID: <89ceffa4d881492bb6f79b4260468e3fb5c794d6.1480401041.git.viresh.kumar@linaro.org>
References: <cover.1480401041.git.viresh.kumar@linaro.org>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <cover.1480401041.git.viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
In-Reply-To: <cover.1480401041.git.viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
References: <cover.1480401041.git.viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Rafael Wysocki <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>, nm-l0cyMroinI0@public.gmane.org, sboyd-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, Viresh Kumar <vireshk-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: linaro-kernel-cunTk1MwBs8s++Sfvej+rw@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Vincent Guittot <vincent.guittot-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, d-gerlach-l0cyMroinI0@public.gmane.org, broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Viresh Kumar <viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, "# v4 . 6+" <stable-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

The OPP structure must not be used out of the rcu protected section.
Cache the values to be used in separate variables instead.

Cc:  # v4.6+ <stable-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Signed-off-by: Viresh Kumar <viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Reviewed-by: Stephen Boyd <sboyd-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Tested-by: Dave Gerlach <d-gerlach-l0cyMroinI0@public.gmane.org>
---
 drivers/base/power/opp/core.c | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/drivers/base/power/opp/core.c b/drivers/base/power/opp/core.c
index 4c7c6da7a989..056527a3fb4e 100644
--- a/drivers/base/power/opp/core.c
+++ b/drivers/base/power/opp/core.c
@@ -584,6 +584,7 @@ int dev_pm_opp_set_rate(struct device *dev, unsigned long target_freq)
 	struct clk *clk;
 	unsigned long freq, old_freq;
 	unsigned long u_volt, u_volt_min, u_volt_max;
+	unsigned long old_u_volt, old_u_volt_min, old_u_volt_max;
 	int ret;
 
 	if (unlikely(!target_freq)) {
@@ -633,6 +634,14 @@ int dev_pm_opp_set_rate(struct device *dev, unsigned long target_freq)
 		return ret;
 	}
 
+	if (IS_ERR(old_opp)) {
+		old_u_volt = 0;
+	} else {
+		old_u_volt = old_opp->u_volt;
+		old_u_volt_min = old_opp->u_volt_min;
+		old_u_volt_max = old_opp->u_volt_max;
+	}
+
 	u_volt = opp->u_volt;
 	u_volt_min = opp->u_volt_min;
 	u_volt_max = opp->u_volt_max;
@@ -677,9 +686,10 @@ int dev_pm_opp_set_rate(struct device *dev, unsigned long target_freq)
 			__func__, old_freq);
 restore_voltage:
 	/* This shouldn't harm even if the voltages weren't updated earlier */
-	if (!IS_ERR(old_opp))
-		_set_opp_voltage(dev, reg, old_opp->u_volt,
-				 old_opp->u_volt_min, old_opp->u_volt_max);
+	if (old_u_volt) {
+		_set_opp_voltage(dev, reg, old_u_volt, old_u_volt_min,
+				 old_u_volt_max);
+	}
 
 	return ret;
 }
-- 
2.7.1.410.g6faf27b

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
