From: Sudeep.KarkadaNagesha-5wv7dgnIgG8@public.gmane.org
Subject: [RFC PATCH v2 07/15] cpufreq: imx6q-cpufreq: remove device tree
 parsing for cpu nodes
Date: Wed, 17 Jul 2013 15:06:16 +0100
Message-ID: <1374069984-20567-8-git-send-email-Sudeep.KarkadaNagesha@arm.com>
References: <1374069984-20567-1-git-send-email-Sudeep.KarkadaNagesha@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
In-Reply-To: <1374069984-20567-1-git-send-email-Sudeep.KarkadaNagesha-5wv7dgnIgG8@public.gmane.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/devicetree-discuss/>
List-Post: <mailto:devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
List-Help: <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=subscribe>
Errors-To: devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
Sender: "devicetree-discuss"
 <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
To: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, cpufreq-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
Cc: Lorenzo Pieralisi <lorenzo.pieralisi-5wv7dgnIgG8@public.gmane.org>, Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Rob Herring <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, "Rafael J. Wysocki" <rjw-KKrjLPT3xs0@public.gmane.org>, Grant Likely <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Viresh Kumar <viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

From: Sudeep KarkadaNagesha <sudeep.karkadanagesha-5wv7dgnIgG8@public.gmane.org>

Now that the cpu device registration initialises the of_node(if available)
appropriately for all the cpus, parsing here is redundant.

This patch removes all DT parsing and uses cpu->of_node instead.

Acked-by: Shawn Guo <shawn.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Acked-by: Viresh Kumar <viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Signed-off-by: Sudeep KarkadaNagesha <sudeep.karkadanagesha-5wv7dgnIgG8@public.gmane.org>
---
 arch/arm/mach-imx/mach-imx6q.c  | 3 +--
 drivers/cpufreq/imx6q-cpufreq.c | 4 +---
 2 files changed, 2 insertions(+), 5 deletions(-)

diff --git a/arch/arm/mach-imx/mach-imx6q.c b/arch/arm/mach-imx/mach-imx6q.c
index 7be13f8..a02f275 100644
--- a/arch/arm/mach-imx/mach-imx6q.c
+++ b/arch/arm/mach-imx/mach-imx6q.c
@@ -254,13 +254,12 @@ static void __init imx6q_opp_init(struct device *cpu_dev)
 {
 	struct device_node *np;
 
-	np = of_find_node_by_path("/cpus/cpu@0");
+	np = of_node_get(cpu_dev->of_node);
 	if (!np) {
 		pr_warn("failed to find cpu0 node\n");
 		return;
 	}
 
-	cpu_dev->of_node = np;
 	if (of_init_opp_table(cpu_dev)) {
 		pr_warn("failed to init OPP table\n");
 		goto put_node;
diff --git a/drivers/cpufreq/imx6q-cpufreq.c b/drivers/cpufreq/imx6q-cpufreq.c
index e37cdae..b16632b 100644
--- a/drivers/cpufreq/imx6q-cpufreq.c
+++ b/drivers/cpufreq/imx6q-cpufreq.c
@@ -221,14 +221,12 @@ static int imx6q_cpufreq_probe(struct platform_device *pdev)
 
 	cpu_dev = &pdev->dev;
 
-	np = of_find_node_by_path("/cpus/cpu@0");
+	np = of_node_get(cpu_dev->of_node);
 	if (!np) {
 		dev_err(cpu_dev, "failed to find cpu0 node\n");
 		return -ENOENT;
 	}
 
-	cpu_dev->of_node = np;
-
 	arm_clk = devm_clk_get(cpu_dev, "arm");
 	pll1_sys_clk = devm_clk_get(cpu_dev, "pll1_sys");
 	pll1_sw_clk = devm_clk_get(cpu_dev, "pll1_sw");
-- 
1.8.1.2
