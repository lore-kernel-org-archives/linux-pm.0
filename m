From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [1/2] cpufreq: dt-platdev: Automatically create cpufreq device with
 OPP v2
Date: Mon, 21 Aug 2017 15:13:32 +0200
Message-ID: <20170821131332.GA14662@verge.net.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from kirsty.vergenet.net ([202.4.237.240]:46272 "EHLO
        kirsty.vergenet.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753755AbdHUNNg (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 21 Aug 2017 09:13:36 -0400
Content-Disposition: inline
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>, geert@linux-m68k.org, maxime.ripard@free-electrons.com, wens@csie.org, xuwei5@hisilicon.com, kgene@kernel.org, krzk@kernel.org, yamada.masahiro@socionext.com, jun.nie@linaro.org, baoyou.xie@linaro.org, linux-kernel@vger.kernel.org

The initial idea of creating the cpufreq-dt-platdev.c file was to keep a
list of platforms that use the "operating-points" (V1) bindings and
create cpufreq device for them only, as we weren't sure which platforms
would want the device to get created automatically as some had their own
cpufreq drivers as well, or wanted to initialize cpufreq after doing
some stuff from platform code.

But that wasn't the case with platforms using "operating-points-v2"
property. We wanted the device to get created automatically without the
need of adding them to the whitelist. Though, we will still have some
exceptions where we don't want to create the device automatically.

Rename the earlier platform list as *whitelist* and create a new
*blacklist* as well.

The cpufreq-dt device will get created if:
- The platform is there in the whitelist OR
- The platform has "operating-points-v2" property in CPU0's DT node and
  isn't part of the blacklist .

Reported-by: Geert Uytterhoeven <geert@linux-m68k.org>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>

I have exercised this on the r8a7795 and r8a7795 with the following reverted:

* 034def597bb7 ("cpufreq: rcar: Add support for R8A7795 SoC")
* bea2ebca6b91 ("cpufreq: dt: Add r8a7796 support to to use generic cpufreq driver")

Tested-by: Simon Horman <horms+renesas@verge.net.au>


---
 drivers/cpufreq/cpufreq-dt-platdev.c | 45 ++++++++++++++++++++++++++++++++----
 1 file changed, 40 insertions(+), 5 deletions(-)

diff --git a/drivers/cpufreq/cpufreq-dt-platdev.c b/drivers/cpufreq/cpufreq-dt-platdev.c
index bcee384b3251..061b468512a2 100644
--- a/drivers/cpufreq/cpufreq-dt-platdev.c
+++ b/drivers/cpufreq/cpufreq-dt-platdev.c
@@ -9,11 +9,16 @@
 
 #include <linux/err.h>
 #include <linux/of.h>
+#include <linux/of_device.h>
 #include <linux/platform_device.h>
 
 #include "cpufreq-dt.h"
 
-static const struct of_device_id machines[] __initconst = {
+/*
+ * Machines for which the cpufreq device is *always* created, mostly used for
+ * platforms using "operating-points" (V1) property.
+ */
+static const struct of_device_id whitelist[] __initconst = {
 	{ .compatible = "allwinner,sun4i-a10", },
 	{ .compatible = "allwinner,sun5i-a10s", },
 	{ .compatible = "allwinner,sun5i-a13", },
@@ -101,21 +106,51 @@ static const struct of_device_id machines[] __initconst = {
 	{ }
 };
 
+/*
+ * Machines for which the cpufreq device is *not* created, mostly used for
+ * platforms using "operating-points-v2" property.
+ */
+static const struct of_device_id blacklist[] __initconst = {
+	{ }
+};
+
+static bool __init cpu0_node_has_opp_v2_prop(void)
+{
+	struct device_node *np = of_cpu_device_node_get(0);
+	bool ret = false;
+
+	if (of_get_property(np, "operating-points-v2", NULL))
+		ret = true;
+
+	of_node_put(np);
+	return ret;
+}
+
 static int __init cpufreq_dt_platdev_init(void)
 {
 	struct device_node *np = of_find_node_by_path("/");
 	const struct of_device_id *match;
+	const void *data = NULL;
 
 	if (!np)
 		return -ENODEV;
 
-	match = of_match_node(machines, np);
+	match = of_match_node(whitelist, np);
+	if (match) {
+		data = match->data;
+		goto create_pdev;
+	}
+
+	if (cpu0_node_has_opp_v2_prop() && !of_match_node(blacklist, np))
+		goto create_pdev;
+
 	of_node_put(np);
-	if (!match)
-		return -ENODEV;
+	return -ENODEV;
 
+create_pdev:
+	of_node_put(np);
 	return PTR_ERR_OR_ZERO(platform_device_register_data(NULL, "cpufreq-dt",
-			       -1, match->data,
+			       -1, data,
 			       sizeof(struct cpufreq_dt_platform_data)));
 }
 device_initcall(cpufreq_dt_platdev_init);
