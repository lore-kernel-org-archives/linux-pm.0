From: Viresh Kumar <viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: [PATCH V5 10/10] PM / OPP: Don't assume platform doesn't have regulators
Date: Tue, 29 Nov 2016 12:06:57 +0530
Message-ID: <1b5cac826c60d6fe06146acf8f9377de8729fb1d.1480401041.git.viresh.kumar@linaro.org>
References: <cover.1480401041.git.viresh.kumar@linaro.org>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <cover.1480401041.git.viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
In-Reply-To: <cover.1480401041.git.viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
References: <cover.1480401041.git.viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Rafael Wysocki <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>, nm-l0cyMroinI0@public.gmane.org, sboyd-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, Viresh Kumar <vireshk-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: linaro-kernel-cunTk1MwBs8s++Sfvej+rw@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Vincent Guittot <vincent.guittot-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, d-gerlach-l0cyMroinI0@public.gmane.org, broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Viresh Kumar <viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

If the regulators aren't set explicitly by the platform, the OPP core
assumes that the platform doesn't have any regulator and uses the
clk-only callback.

If the platform failed to register a regulator with the core, then this
can turn out to be a dangerous assumption as the OPP core will try to
change clk without changing regulators.

Handle that properly by making sure that the DT didn't have any entries
for supply voltages as well.

Signed-off-by: Viresh Kumar <viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Reviewed-by: Stephen Boyd <sboyd-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
---
 drivers/base/power/opp/core.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/base/power/opp/core.c b/drivers/base/power/opp/core.c
index 3c9f223709ab..f7a5fb4dbf11 100644
--- a/drivers/base/power/opp/core.c
+++ b/drivers/base/power/opp/core.c
@@ -748,7 +748,20 @@ int dev_pm_opp_set_rate(struct device *dev, unsigned long target_freq)
 
 	/* Only frequency scaling */
 	if (!regulators) {
+		unsigned long u_volt = opp->supplies[0].u_volt;
+
 		rcu_read_unlock();
+
+		/*
+		 * DT contained supply ratings? Consider platform failed to set
+		 * regulators.
+		 */
+		if (unlikely(u_volt)) {
+			dev_err(dev, "%s: Regulator not registered with OPP core\n",
+				__func__);
+			return -EINVAL;
+		}
+
 		return _generic_set_opp_clk_only(dev, clk, old_freq, freq);
 	}
 
-- 
2.7.1.410.g6faf27b

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
