From: Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH 2/4] arm64: renesas: Enable PM and PM_GENERIC_DOMAINS for SoCs with PM Domains
Date: Tue, 16 Feb 2016 16:31:50 +0100
Message-ID: <1455636712-3040-3-git-send-email-geert+renesas@glider.be>
References: <1455636712-3040-1-git-send-email-geert+renesas@glider.be>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from xavier.telenet-ops.be ([195.130.132.52]:58503 "EHLO
	xavier.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755334AbcBPPcD (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 16 Feb 2016 10:32:03 -0500
In-Reply-To: <1455636712-3040-1-git-send-email-geert+renesas@glider.be>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>
Cc: linux-renesas-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-sh@vger.kernel.org, linux-pm@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>

All supported Renesas ARM64 SoCs have clock and power domains. To ensure
proper operation of on-SoC modules, module clocks must be ungated, and
power domains must be powered up when needed.

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
CONFIG_PM_GENERIC_DOMAINS unconditionally.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 arch/arm64/Kconfig.platforms | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/Kconfig.platforms b/arch/arm64/Kconfig.platforms
index 21074f674bdeb707..2c0caac053e8c12a 100644
--- a/arch/arm64/Kconfig.platforms
+++ b/arch/arm64/Kconfig.platforms
@@ -76,7 +76,8 @@ config ARCH_RENESAS
 	bool "Renesas SoC Platforms"
 	select ARCH_SHMOBILE
 	select PINCTRL
-	select PM_GENERIC_DOMAINS if PM
+	select PM
+	select PM_GENERIC_DOMAINS
 	help
 	  This enables support for the ARMv8 based Renesas SoCs.
 
-- 
1.9.1

