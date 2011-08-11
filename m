From: Chanwoo Choi <cw00.choi@samsung.com>
Subject: [PATCH 4/4] ARM: EXYNOS4: Add power domain to use
 generic Power domain Framework
Date: Thu, 11 Aug 2011 13:55:22 +0900
Message-ID: <4E4360BA.3020208__5241.65613246641$1313038652$gmane$org@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Kukjin Kim <kgene.kim@samsung.com>, "Rafael J. Wysocki" <rjw@sisk.pl>, Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Kyungmin Park <kyungmin.park@samsung.com>, linux-samsung-soc <linux-samsung-soc@vger.kernel.org>, linux-pm@lists.linux-foundation.org, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
List-Id: linux-pm@vger.kernel.org

This patch initializes the power domain of EXYNOS4210. The devices
which suppot runtime-PM have to be added in specific power domain.

Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
---
 arch/arm/mach-exynos4/mach-nuri.c           |   18 ++++++++++++++++++
 arch/arm/mach-exynos4/mach-smdkc210.c       |   18 ++++++++++++++++++
 arch/arm/mach-exynos4/mach-smdkv310.c       |   15 +++++++++++++++
 arch/arm/mach-exynos4/mach-universal_c210.c |   18 ++++++++++++++++++
 4 files changed, 69 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-exynos4/mach-nuri.c b/arch/arm/mach-exynos4/mach-nuri.c
index 4c358cb..5844c55 100644
--- a/arch/arm/mach-exynos4/mach-nuri.c
+++ b/arch/arm/mach-exynos4/mach-nuri.c
@@ -44,6 +44,7 @@
 #include <plat/mfc.h>
 
 #include <mach/map.h>
+#include <mach/pm-exynos4210.h>
 
 /* Following are default values for UCON, ULCON and UFCON UART registers */
 #define NURI_UCON_DEFAULT	(S3C2410_UCON_TXILEVEL |	\
@@ -1125,6 +1126,21 @@ static void __init nuri_reserve(void)
 	s5p_mfc_reserve_mem(0x43000000, 8 << 20, 0x51000000, 8 << 20);
 }
 
+static void __init nuri_power_domain_init(void)
+{
+	/* Initialize Power domain */
+	exynos4210_init_pm_domain(&exynos4210_pd_mfc);
+	exynos4210_init_pm_domain(&exynos4210_pd_g3d);
+	exynos4210_init_pm_domain(&exynos4210_pd_lcd0);
+	exynos4210_init_pm_domain(&exynos4210_pd_lcd1);
+	exynos4210_init_pm_domain(&exynos4210_pd_tv);
+	exynos4210_init_pm_domain(&exynos4210_pd_cam);
+	exynos4210_init_pm_domain(&exynos4210_pd_gps);
+
+	/* Add device to MFC power domain */
+	exynos4210_add_device_to_domain(&exynos4210_pd_mfc, &s5p_device_mfc);
+}
+
 static void __init nuri_machine_init(void)
 {
 	nuri_sdhci_init();
@@ -1145,6 +1161,8 @@ static void __init nuri_machine_init(void)
 
 	/* Last */
 	platform_add_devices(nuri_devices, ARRAY_SIZE(nuri_devices));
+
+	nuri_power_domain_init();
 }
 
 MACHINE_START(NURI, "NURI")
diff --git a/arch/arm/mach-exynos4/mach-smdkc210.c b/arch/arm/mach-exynos4/mach-smdkc210.c
index 4d1976c..0a3b2a9 100644
--- a/arch/arm/mach-exynos4/mach-smdkc210.c
+++ b/arch/arm/mach-exynos4/mach-smdkc210.c
@@ -37,6 +37,7 @@
 #include <plat/backlight.h>
 
 #include <mach/map.h>
+#include <mach/pm-exynos4210.h>
 
 /* Following are default values for UCON, ULCON and UFCON UART registers */
 #define SMDKC210_UCON_DEFAULT	(S3C2410_UCON_TXILEVEL |	\
@@ -273,6 +274,21 @@ static void __init smdkc210_map_io(void)
 	s3c24xx_init_uarts(smdkc210_uartcfgs, ARRAY_SIZE(smdkc210_uartcfgs));
 }
 
+static void __init smdkc210_power_domain_init(void)
+{
+	/* Initialize Power domain */
+	exynos4210_init_pm_domain(&exynos4210_pd_mfc);
+	exynos4210_init_pm_domain(&exynos4210_pd_g3d);
+	exynos4210_init_pm_domain(&exynos4210_pd_lcd0);
+	exynos4210_init_pm_domain(&exynos4210_pd_lcd1);
+	exynos4210_init_pm_domain(&exynos4210_pd_tv);
+	exynos4210_init_pm_domain(&exynos4210_pd_cam);
+	exynos4210_init_pm_domain(&exynos4210_pd_gps);
+
+	/* Add device to LCD0 power domain */
+	exynos4210_add_device_to_domain(&exynos4210_pd_lcd0, &s5p_device_fimd0);
+}
+
 static void __init smdkc210_machine_init(void)
 {
 	s3c_i2c1_set_platdata(NULL);
@@ -289,6 +305,8 @@ static void __init smdkc210_machine_init(void)
 	s5p_fimd0_set_platdata(&smdkc210_lcd0_pdata);
 
 	platform_add_devices(smdkc210_devices, ARRAY_SIZE(smdkc210_devices));
+
+	smdkc210_power_domain_init();
 }
 
 MACHINE_START(SMDKC210, "SMDKC210")
diff --git a/arch/arm/mach-exynos4/mach-smdkv310.c b/arch/arm/mach-exynos4/mach-smdkv310.c
index 8c2819b..320c7f3 100644
--- a/arch/arm/mach-exynos4/mach-smdkv310.c
+++ b/arch/arm/mach-exynos4/mach-smdkv310.c
@@ -33,6 +33,7 @@
 #include <plat/backlight.h>
 
 #include <mach/map.h>
+#include <mach/pm-exynos4210.h>
 
 /* Following are default values for UCON, ULCON and UFCON UART registers */
 #define SMDKV310_UCON_DEFAULT	(S3C2410_UCON_TXILEVEL |	\
@@ -225,6 +226,18 @@ static void __init smdkv310_map_io(void)
 	s3c24xx_init_uarts(smdkv310_uartcfgs, ARRAY_SIZE(smdkv310_uartcfgs));
 }
 
+static void __init smdkv310_power_domain_init(void)
+{
+	/* Initialize Power domain */
+	exynos4210_init_pm_domain(&exynos4210_pd_mfc);
+	exynos4210_init_pm_domain(&exynos4210_pd_g3d);
+	exynos4210_init_pm_domain(&exynos4210_pd_lcd0);
+	exynos4210_init_pm_domain(&exynos4210_pd_lcd1);
+	exynos4210_init_pm_domain(&exynos4210_pd_tv);
+	exynos4210_init_pm_domain(&exynos4210_pd_cam);
+	exynos4210_init_pm_domain(&exynos4210_pd_gps);
+}
+
 static void __init smdkv310_machine_init(void)
 {
 	s3c_i2c1_set_platdata(NULL);
@@ -242,6 +255,8 @@ static void __init smdkv310_machine_init(void)
 	samsung_bl_set(&smdkv310_bl_gpio_info, &smdkv310_bl_data);
 
 	platform_add_devices(smdkv310_devices, ARRAY_SIZE(smdkv310_devices));
+
+	smdkv310_power_domain_init();
 }
 
 MACHINE_START(SMDKV310, "SMDKV310")
diff --git a/arch/arm/mach-exynos4/mach-universal_c210.c b/arch/arm/mach-exynos4/mach-universal_c210.c
index 43998f0..1ebc907 100644
--- a/arch/arm/mach-exynos4/mach-universal_c210.c
+++ b/arch/arm/mach-exynos4/mach-universal_c210.c
@@ -36,6 +36,7 @@
 #include <plat/s5p-time.h>
 
 #include <mach/map.h>
+#include <mach/pm-exynos4210.h>
 
 /* Following are default values for UCON, ULCON and UFCON UART registers */
 #define UNIVERSAL_UCON_DEFAULT	(S3C2410_UCON_TXILEVEL |	\
@@ -737,6 +738,21 @@ static void __init universal_reserve(void)
 	s5p_mfc_reserve_mem(0x43000000, 8 << 20, 0x51000000, 8 << 20);
 }
 
+static void __init universal_power_domain_init(void)
+{
+	/* Initialize Power domain */
+	exynos4210_init_pm_domain(&exynos4210_pd_mfc);
+	exynos4210_init_pm_domain(&exynos4210_pd_g3d);
+	exynos4210_init_pm_domain(&exynos4210_pd_lcd0);
+	exynos4210_init_pm_domain(&exynos4210_pd_lcd1);
+	exynos4210_init_pm_domain(&exynos4210_pd_tv);
+	exynos4210_init_pm_domain(&exynos4210_pd_cam);
+	exynos4210_init_pm_domain(&exynos4210_pd_gps);
+
+	/* Add device to MFC power domain */
+	exynos4210_add_device_to_domain(&exynos4210_pd_mfc, &s5p_device_mfc);
+}
+
 static void __init universal_machine_init(void)
 {
 	universal_sdhci_init();
@@ -757,6 +773,8 @@ static void __init universal_machine_init(void)
 
 	/* Last */
 	platform_add_devices(universal_devices, ARRAY_SIZE(universal_devices));
+
+	universal_power_domain_init();
 }
 
 MACHINE_START(UNIVERSAL_C210, "UNIVERSAL_C210")
-- 
1.7.0.4
