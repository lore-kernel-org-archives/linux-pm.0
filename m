From: John Tobias <john.tobias.ph@gmail.com>
Subject: [PATCH v4 1/2] ARM: imx: add select on ARCH_MXC for cpufreq support
Date: Thu,  9 Jan 2014 18:39:51 -0800
Message-ID: <1389321592-33220-1-git-send-email-john.tobias.ph@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: rjw@rjwysocki.net, viresh.kumar@linaro.org, cpufreq@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, kernel@pengutronix.de, linux@arm.linux.org.uk, linux-arm-kernel@lists.infradead.org, shawn.guo@linaro.org, festevam@gmail.com
Cc: John Tobias <john.tobias.ph@gmail.com>
List-Id: linux-pm@vger.kernel.org

Moved ARCH_HAS_CPUFREQ, HAVE_IMX_ANATOP and PM_OPP on ARCH_MXC so that
the user can enable the cpufreq support for iMX6Q and/or iMX6SL.

Signed-off-by: John Tobias <john.tobias.ph@gmail.com>
---
 arch/arm/mach-imx/Kconfig | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/arch/arm/mach-imx/Kconfig b/arch/arm/mach-imx/Kconfig
index 7a6e6f7..d6aa34d 100644
--- a/arch/arm/mach-imx/Kconfig
+++ b/arch/arm/mach-imx/Kconfig
@@ -1,5 +1,6 @@
 config ARCH_MXC
 	bool "Freescale i.MX family" if ARCH_MULTI_V4_V5 || ARCH_MULTI_V6_V7
+	select ARCH_HAS_CPUFREQ
 	select ARCH_REQUIRE_GPIOLIB
 	select ARM_CPU_SUSPEND if PM
 	select ARM_PATCH_PHYS_VIRT
@@ -9,8 +10,10 @@ config ARCH_MXC
 	select GENERIC_ALLOCATOR
 	select GENERIC_CLOCKEVENTS
 	select GENERIC_IRQ_CHIP
+	select HAVE_IMX_ANATOP if SOC_IMX6Q || SOC_IMX6SL
 	select MIGHT_HAVE_CACHE_L2X0 if ARCH_MULTI_V6_V7
 	select MULTI_IRQ_HANDLER
+	select PM_OPP if PM
 	select SOC_BUS
 	select SPARSE_IRQ
 	select USE_OF
@@ -779,16 +782,14 @@ config	SOC_IMX53
 
 config SOC_IMX6Q
 	bool "i.MX6 Quad/DualLite support"
-	select ARCH_HAS_CPUFREQ
-	select ARCH_HAS_OPP
+	select ARCH_HAS_OPP	
 	select ARM_ERRATA_754322
 	select ARM_ERRATA_764369 if SMP
 	select ARM_ERRATA_775420
 	select ARM_GIC
 	select CPU_V7
 	select HAVE_ARM_SCU if SMP
-	select HAVE_ARM_TWD if SMP
-	select HAVE_IMX_ANATOP
+	select HAVE_ARM_TWD if SMP	
 	select HAVE_IMX_GPC
 	select HAVE_IMX_MMDC
 	select HAVE_IMX_SRC
@@ -800,8 +801,7 @@ config SOC_IMX6Q
 	select PINCTRL_IMX6Q
 	select PL310_ERRATA_588369 if CACHE_PL310
 	select PL310_ERRATA_727915 if CACHE_PL310
-	select PL310_ERRATA_769419 if CACHE_PL310
-	select PM_OPP if PM
+	select PL310_ERRATA_769419 if CACHE_PL310	
 
 	help
 	  This enables support for Freescale i.MX6 Quad processor.
@@ -812,7 +812,6 @@ config SOC_IMX6SL
 	select ARM_ERRATA_775420
 	select ARM_GIC
 	select CPU_V7
-	select HAVE_IMX_ANATOP
 	select HAVE_IMX_GPC
 	select HAVE_IMX_MMDC
 	select HAVE_IMX_SRC
-- 
1.8.3.2
