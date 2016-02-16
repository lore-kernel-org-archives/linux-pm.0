From: Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH 1/4] ARM: shmobile: Enable PM and PM_GENERIC_DOMAINS for SoCs with PM Domains
Date: Tue, 16 Feb 2016 16:31:49 +0100
Message-ID: <1455636712-3040-2-git-send-email-geert+renesas@glider.be>
References: <1455636712-3040-1-git-send-email-geert+renesas@glider.be>
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <1455636712-3040-1-git-send-email-geert+renesas@glider.be>
Sender: linux-sh-owner@vger.kernel.org
To: Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>
Cc: linux-renesas-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-sh@vger.kernel.org, linux-pm@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>
List-Id: linux-pm@vger.kernel.org

All supported Renesas ARM SoCs (except for Emma Mobile EV2) have clock
domains. Some SoCs also have power domains. To ensure proper operation
of on-SoC modules, module clocks must be ungated, and power domains must
be powered up when needed.

Currently the user can choose to build a kernel with power management
enabled or disabled:
  - If CONFIG_PM=y, power domains and/or module clocks are handled
    dynamically by Runtime PM and the generic power domain.
  - If CONFIG_PM=n, power domains are assumed to be powered up by reset
    state or by the boot loader, and module clocks are handled by the
    legacy clock domain on driver (un)bind.
    The latter is implemented using a platform bus notifier, which
    applies not only to all on-SoC devices, but to all platform devices
    present in the system.

To remove the dependency on implicit assumptions, and to get rid of the
peculiarities of the legacy clock domain, enable CONFIG_PM and
CONFIG_PM_GENERIC_DOMAINS unconditionally, for all Renesas ARM SoCs with
clock and/or power domains.

This does cause an increase in kernel size.  Given bloat-o-meter reports
a modest increase of 26 KiB for an RZ/A1H kernel, this should not be a
problem, even when used on RZ/A1H with XIP and internal RAM only.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 arch/arm/mach-shmobile/Kconfig | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/arch/arm/mach-shmobile/Kconfig b/arch/arm/mach-shmobile/Kconfig
index cd5f171f83ce6420..2824b81f1a392d87 100644
--- a/arch/arm/mach-shmobile/Kconfig
+++ b/arch/arm/mach-shmobile/Kconfig
@@ -6,28 +6,30 @@ config ARCH_SHMOBILE_MULTI
 
 config PM_RCAR
 	bool
-	select PM_GENERIC_DOMAINS if PM
+	select PM
+	select PM_GENERIC_DOMAINS
 
 config PM_RMOBILE
 	bool
+	select PM
 	select PM_GENERIC_DOMAINS
 
 config ARCH_RCAR_GEN1
 	bool
-	select PM_RCAR if PM || SMP
+	select PM_RCAR
 	select RENESAS_INTC_IRQPIN
 	select SYS_SUPPORTS_SH_TMU
 
 config ARCH_RCAR_GEN2
 	bool
-	select PM_RCAR if PM || SMP
+	select PM_RCAR
 	select RENESAS_IRQC
 	select SYS_SUPPORTS_SH_CMT
 	select PCI_DOMAINS if PCI
 
 config ARCH_RMOBILE
 	bool
-	select PM_RMOBILE if PM
+	select PM_RMOBILE
 	select SYS_SUPPORTS_SH_CMT
 	select SYS_SUPPORTS_SH_TMU
 
@@ -55,7 +57,8 @@ config ARCH_EMEV2
 
 config ARCH_R7S72100
 	bool "RZ/A1H (R7S72100)"
-	select PM_GENERIC_DOMAINS if PM
+	select PM
+	select PM_GENERIC_DOMAINS
 	select SYS_SUPPORTS_SH_MTU2
 
 config ARCH_R8A73A4
-- 
1.9.1

