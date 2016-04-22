From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH V2 2/9] cpufreq: berlin: Use generic platdev driver
Date: Fri, 22 Apr 2016 16:58:40 +0530
Message-ID: <64733ec5d702497b80c8f5a96baaa86aa5281efa.1461324267.git.viresh.kumar@linaro.org>
References: <cover.1461324267.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <cover.1461324267.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1461324267.git.viresh.kumar@linaro.org>
References: <cover.1461324267.git.viresh.kumar@linaro.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Rafael Wysocki <rjw@rjwysocki.net>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Viresh Kumar <viresh.kumar@linaro.org>
Cc: linaro-kernel@lists.linaro.org, Arnd Bergmann <arnd@arndb.de>, linux-pm@vger.kernel.org, Antoine Tenart <antoine.tenart@free-electrons.com>, linux-kernel@vger.kernel.org, geert@linux-m68k.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-pm@vger.kernel.org

The cpufreq-dt-platdev driver supports creation of cpufreq-dt platform
device now, reuse that and remove similar code from platform code.

Cc: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
Acked-by: Antoine Tenart <antoine.tenart@free-electrons.com>
Acked-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm/mach-berlin/berlin.c        | 6 ------
 drivers/cpufreq/cpufreq-dt-platdev.c | 2 ++
 2 files changed, 2 insertions(+), 6 deletions(-)

diff --git a/arch/arm/mach-berlin/berlin.c b/arch/arm/mach-berlin/berlin.c
index 25d73870ccca..ac181c6797ee 100644
--- a/arch/arm/mach-berlin/berlin.c
+++ b/arch/arm/mach-berlin/berlin.c
@@ -18,11 +18,6 @@
 #include <asm/hardware/cache-l2x0.h>
 #include <asm/mach/arch.h>
 
-static void __init berlin_init_late(void)
-{
-	platform_device_register_simple("cpufreq-dt", -1, NULL, 0);
-}
-
 static const char * const berlin_dt_compat[] = {
 	"marvell,berlin",
 	NULL,
@@ -30,7 +25,6 @@ static const char * const berlin_dt_compat[] = {
 
 DT_MACHINE_START(BERLIN_DT, "Marvell Berlin")
 	.dt_compat	= berlin_dt_compat,
-	.init_late	= berlin_init_late,
 	/*
 	 * with DT probing for L2CCs, berlin_init_machine can be removed.
 	 * Note: 88DE3005 (Armada 1500-mini) uses pl310 l2cc
diff --git a/drivers/cpufreq/cpufreq-dt-platdev.c b/drivers/cpufreq/cpufreq-dt-platdev.c
index 00da8c8bee6c..3e1c8211c213 100644
--- a/drivers/cpufreq/cpufreq-dt-platdev.c
+++ b/drivers/cpufreq/cpufreq-dt-platdev.c
@@ -12,6 +12,8 @@
 #include <linux/platform_device.h>
 
 static const struct of_device_id machines[] __initconst = {
+	{ .compatible = "marvell,berlin", },
+
 	{ .compatible = "samsung,exynos3250", },
 	{ .compatible = "samsung,exynos4210", },
 	{ .compatible = "samsung,exynos4212", },
-- 
2.7.1.410.g6faf27b
