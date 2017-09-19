From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH] cpufreq: dt-platdev: Add few platforms to the blacklist
Date: Tue, 19 Sep 2017 08:23:22 -0700
Message-ID: <964fa4ba4c7d579af28bfc3468a451ba2786ae1a.1505834584.git.viresh.kumar@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Commit edeec420de24 ("cpufreq: dt-platdev: Automatically create cpufreq
device with OPP v2") missed adding few platforms to the blacklist which
create the cpufreq-dt device from their own drivers, after some
dependencies are sorted out. And for those platforms, both the platform
specific driver and the cpufreq-dt-platdev driver try to create the
cpufreq-dt device now. Fix that by including those platforms in the
blacklist. This doesn't include the TI platforms, for which a separate
patch is getting merged.

Fixes: edeec420de24 ("cpufreq: dt-cpufreq: platdev Automatically create device with OPP v2")
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/cpufreq-dt-platdev.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/cpufreq/cpufreq-dt-platdev.c b/drivers/cpufreq/cpufreq-dt-platdev.c
index a020da7940d6..430edadca527 100644
--- a/drivers/cpufreq/cpufreq-dt-platdev.c
+++ b/drivers/cpufreq/cpufreq-dt-platdev.c
@@ -106,6 +106,18 @@ static const struct of_device_id whitelist[] __initconst = {
  * platforms using "operating-points-v2" property.
  */
 static const struct of_device_id blacklist[] __initconst = {
+	{ .compatible = "calxeda,highbank", },
+	{ .compatible = "calxeda,ecx-2000", },
+
+	{ .compatible = "marvell,armadaxp", },
+
+	{ .compatible = "nvidia,tegra124", },
+
+	{ .compatible = "st,stih407", },
+	{ .compatible = "st,stih410", },
+
+	{ .compatible = "sigma,tango4", },
+
 	{ }
 };
 
-- 
2.7.4
