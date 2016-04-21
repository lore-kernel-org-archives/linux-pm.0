From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH 6/8] cpufreq: sunxi: Use generic platdev driver
Date: Thu, 21 Apr 2016 14:13:52 +0530
Message-ID: <e82bf5994897cc979a67c72f09229b8b295bb69a.1461228081.git.viresh.kumar@linaro.org>
References: <cover.1461228081.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <cover.1461228081.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1461228081.git.viresh.kumar@linaro.org>
References: <cover.1461228081.git.viresh.kumar@linaro.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Rafael Wysocki <rjw@rjwysocki.net>, Maxime Ripard <maxime.ripard@free-electrons.com>, Chen-Yu Tsai <wens@csie.org>, Viresh Kumar <viresh.kumar@linaro.org>
Cc: arnd.bergmann@linaro.org, linaro-kernel@lists.linaro.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

The cpufreq-dt-platdev driver supports creation of cpufreq-dt platform
device now, reuse that and remove similar code from platform code.

Cc: Maxime Ripard <maxime.ripard@free-electrons.com>
Cc: Chen-Yu Tsai <wens@csie.org>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 arch/arm/mach-sunxi/sunxi.c          |  9 ---------
 drivers/cpufreq/cpufreq-dt-platdev.c | 12 ++++++++++++
 2 files changed, 12 insertions(+), 9 deletions(-)

diff --git a/arch/arm/mach-sunxi/sunxi.c b/arch/arm/mach-sunxi/sunxi.c
index 3c156190a1d4..95dca8c2c9ed 100644
--- a/arch/arm/mach-sunxi/sunxi.c
+++ b/arch/arm/mach-sunxi/sunxi.c
@@ -17,11 +17,6 @@
 
 #include <asm/mach/arch.h>
 
-static void __init sunxi_dt_cpufreq_init(void)
-{
-	platform_device_register_simple("cpufreq-dt", -1, NULL, 0);
-}
-
 static const char * const sunxi_board_dt_compat[] = {
 	"allwinner,sun4i-a10",
 	"allwinner,sun5i-a10s",
@@ -32,7 +27,6 @@ static const char * const sunxi_board_dt_compat[] = {
 
 DT_MACHINE_START(SUNXI_DT, "Allwinner sun4i/sun5i Families")
 	.dt_compat	= sunxi_board_dt_compat,
-	.init_late	= sunxi_dt_cpufreq_init,
 MACHINE_END
 
 static const char * const sun6i_board_dt_compat[] = {
@@ -53,7 +47,6 @@ static void __init sun6i_timer_init(void)
 DT_MACHINE_START(SUN6I_DT, "Allwinner sun6i (A31) Family")
 	.init_time	= sun6i_timer_init,
 	.dt_compat	= sun6i_board_dt_compat,
-	.init_late	= sunxi_dt_cpufreq_init,
 MACHINE_END
 
 static const char * const sun7i_board_dt_compat[] = {
@@ -63,7 +56,6 @@ static const char * const sun7i_board_dt_compat[] = {
 
 DT_MACHINE_START(SUN7I_DT, "Allwinner sun7i (A20) Family")
 	.dt_compat	= sun7i_board_dt_compat,
-	.init_late	= sunxi_dt_cpufreq_init,
 MACHINE_END
 
 static const char * const sun8i_board_dt_compat[] = {
@@ -77,7 +69,6 @@ static const char * const sun8i_board_dt_compat[] = {
 DT_MACHINE_START(SUN8I_DT, "Allwinner sun8i Family")
 	.init_time	= sun6i_timer_init,
 	.dt_compat	= sun8i_board_dt_compat,
-	.init_late	= sunxi_dt_cpufreq_init,
 MACHINE_END
 
 static const char * const sun9i_board_dt_compat[] = {
diff --git a/drivers/cpufreq/cpufreq-dt-platdev.c b/drivers/cpufreq/cpufreq-dt-platdev.c
index 05ac0ea25c49..db6767a1f975 100644
--- a/drivers/cpufreq/cpufreq-dt-platdev.c
+++ b/drivers/cpufreq/cpufreq-dt-platdev.c
@@ -12,6 +12,18 @@
 #include <linux/platform_device.h>
 
 static const struct of_device_id machines[] = {
+	{ .compatible = "allwinner,sun4i-a10", },
+	{ .compatible = "allwinner,sun5i-a10s", },
+	{ .compatible = "allwinner,sun5i-a13", },
+	{ .compatible = "allwinner,sun5i-r8", },
+	{ .compatible = "allwinner,sun6i-a31", },
+	{ .compatible = "allwinner,sun6i-a31s", },
+	{ .compatible = "allwinner,sun7i-a20", },
+	{ .compatible = "allwinner,sun8i-a23", },
+	{ .compatible = "allwinner,sun8i-a33", },
+	{ .compatible = "allwinner,sun8i-a83t", },
+	{ .compatible = "allwinner,sun8i-h3", },
+
 	{ .compatible = "fsl,imx27", },
 	{ .compatible = "fsl,imx51", },
 	{ .compatible = "fsl,imx53", },
-- 
2.7.1.410.g6faf27b
