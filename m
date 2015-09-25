From: Marc Titinger <mtitinger@baylibre.com>
Subject: [RFC 1/7] arm64: pm/domains: try mutualize CPU domains init between arm/arm64
Date: Fri, 25 Sep 2015 15:04:03 +0200
Message-ID: <1443186249-14596-2-git-send-email-mtitinger+renesas@baylibre.com>
References: <1443186249-14596-1-git-send-email-mtitinger+renesas@baylibre.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1443186249-14596-1-git-send-email-mtitinger+renesas@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
To: khilman@kernel.org, rjw@rjwysocki.net
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, ahaslam@baylibre.com, bcousson@baylibre.com, lina.iyer@linaro.org, Marc Titinger <mtitinger@baylibre.com>
List-Id: linux-pm@vger.kernel.org

From: Marc Titinger <mtitinger@baylibre.com>

fake path to start testing, eventually move this out of /arch/.
incidently enable PM_GENERIC_DOMAINS for VExpress.

Signed-off-by: Marc Titinger <mtitinger@baylibre.com>
---
 arch/arm/common/domains.c       | 4 ++--
 arch/arm64/Kconfig              | 1 +
 arch/arm64/include/asm/arm-pd.h | 1 +
 arch/arm64/kernel/Makefile      | 6 ++++++
 arch/arm64/kernel/domains.c     | 1 +
 5 files changed, 11 insertions(+), 2 deletions(-)
 create mode 120000 arch/arm64/include/asm/arm-pd.h
 create mode 120000 arch/arm64/kernel/domains.c

diff --git a/arch/arm/common/domains.c b/arch/arm/common/domains.c
index d3207da..68908d4 100644
--- a/arch/arm/common/domains.c
+++ b/arch/arm/common/domains.c
@@ -20,7 +20,7 @@
 
 #include <asm/arm-pd.h>
 
-#define NAME_MAX 36
+#define GENPD_NAME_MAX 36
 
 struct arm_pm_domain {
 	struct generic_pm_domain genpd;
@@ -182,7 +182,7 @@ static int __init arm_domain_init(void)
 		}
 
 		/* Initialize rest of CPU PM domain specifics */
-		pd->genpd.name = kstrndup(np->name, NAME_MAX, GFP_KERNEL);
+		pd->genpd.name = kstrndup(np->name, GENPD_NAME_MAX, GFP_KERNEL);
 		pd->genpd.power_off = arm_pd_power_down;
 		pd->genpd.power_on = arm_pd_power_up;
 		pd->genpd.flags |= GENPD_FLAG_IRQ_SAFE;
diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 7c55a63..d35f213 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -250,6 +250,7 @@ config ARCH_VEXPRESS
 	select COMMON_CLK_VERSATILE
 	select POWER_RESET_VEXPRESS
 	select VEXPRESS_CONFIG
+	select PM_GENERIC_DOMAINS if PM
 	help
 	  This enables support for the ARMv8 software model (Versatile
 	  Express).
diff --git a/arch/arm64/include/asm/arm-pd.h b/arch/arm64/include/asm/arm-pd.h
new file mode 120000
index 0000000..ecc5437
--- /dev/null
+++ b/arch/arm64/include/asm/arm-pd.h
@@ -0,0 +1 @@
+../../../arm/include/asm/arm-pd.h
\ No newline at end of file
diff --git a/arch/arm64/kernel/Makefile b/arch/arm64/kernel/Makefile
index 426d076..4689565 100644
--- a/arch/arm64/kernel/Makefile
+++ b/arch/arm64/kernel/Makefile
@@ -30,6 +30,12 @@ arm64-obj-$(CONFIG_HW_PERF_EVENTS)	+= perf_event.o
 arm64-obj-$(CONFIG_HAVE_HW_BREAKPOINT)	+= hw_breakpoint.o
 arm64-obj-$(CONFIG_CPU_PM)		+= sleep.o suspend.o
 arm64-obj-$(CONFIG_CPU_IDLE)		+= cpuidle.o
+
+# CPU domains: try mutualize for arm/arm64 in a first step.
+# Eventually make this more generic.
+#
+arm64-obj-$(CONFIG_PM_GENERIC_DOMAINS)	+= domains.o
+
 arm64-obj-$(CONFIG_JUMP_LABEL)		+= jump_label.o
 arm64-obj-$(CONFIG_KGDB)		+= kgdb.o
 arm64-obj-$(CONFIG_EFI)			+= efi.o efi-stub.o efi-entry.o
diff --git a/arch/arm64/kernel/domains.c b/arch/arm64/kernel/domains.c
new file mode 120000
index 0000000..bf17c69
--- /dev/null
+++ b/arch/arm64/kernel/domains.c
@@ -0,0 +1 @@
+../../arm/common/domains.c
\ No newline at end of file
-- 
1.9.1
