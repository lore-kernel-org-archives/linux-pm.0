From: Yuantian Tang <andy.tang@nxp.com>
Subject: [PATCH v2] cpufreq: qoriq: enhance bus frequency calculation
Date: Fri, 10 Mar 2017 09:28:43 +0800
Message-ID: <1489109323-11424-1-git-send-email-andy.tang@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: rjw@rjwysocki.net, viresh.kumar@linaro.org
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Yuantian Tang <andy.tang@nxp.com>
List-Id: linux-pm@vger.kernel.org

On some platforms, property device-type may be missed in soc node
in dts which caused the bus-frequency can not be obtained correctly.

This patch enhanced the bus-frequency calculation. When property
device-type is missed in dts, bus-frequency will be obtained by
looking up clock table to get platform clock and hence get its
frequency.

Signed-off-by: Tang Yuantian <andy.tang@nxp.com>
---
v2: -- fix alignment issue

 drivers/cpufreq/qoriq-cpufreq.c | 24 +++++++++++++++++-------
 1 file changed, 17 insertions(+), 7 deletions(-)

diff --git a/drivers/cpufreq/qoriq-cpufreq.c b/drivers/cpufreq/qoriq-cpufreq.c
index bfec1bc..e2ea433 100644
--- a/drivers/cpufreq/qoriq-cpufreq.c
+++ b/drivers/cpufreq/qoriq-cpufreq.c
@@ -52,17 +52,27 @@ static u32 get_bus_freq(void)
 {
 	struct device_node *soc;
 	u32 sysfreq;
+	struct clk *pltclk;
+	int ret;
 
+	/* get platform freq by searching bus-frequency property */
 	soc = of_find_node_by_type(NULL, "soc");
-	if (!soc)
-		return 0;
-
-	if (of_property_read_u32(soc, "bus-frequency", &sysfreq))
-		sysfreq = 0;
+	if (soc) {
+		ret = of_property_read_u32(soc, "bus-frequency", &sysfreq);
+		of_node_put(soc);
+		if (!ret)
+			return sysfreq;
+	}
 
-	of_node_put(soc);
+	/* get platform freq by its clock name */
+	pltclk = clk_get(NULL, "cg-pll0-div1");
+	if (IS_ERR(pltclk)) {
+		pr_err("%s: can't get bus frequency %ld\n",
+		       __func__, PTR_ERR(pltclk));
+		return PTR_ERR(pltclk);
+	}
 
-	return sysfreq;
+	return clk_get_rate(pltclk);
 }
 
 static struct clk *cpu_to_clk(int cpu)
-- 
2.1.0.27.g96db324
