From: Keita Kobayashi <keita.kobayashi.ym@renesas.com>
Subject: [RFC/PATCH v2 1/5] ARM: cpuidle: Add cpuidle support for R-Car Gen2 series
Date: Thu, 16 Apr 2015 19:35:36 +0900
Message-ID: <1429180540-5692-2-git-send-email-keita.kobayashi.ym@renesas.com>
References: <1429180540-5692-1-git-send-email-keita.kobayashi.ym@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from relmlor3.renesas.com ([210.160.252.173]:55696 "EHLO
	relmlie2.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751787AbbDPKyy (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 16 Apr 2015 06:54:54 -0400
In-Reply-To: <1429180540-5692-1-git-send-email-keita.kobayashi.ym@renesas.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: horms@verge.net.au, rjw@rjwysocki.net, daniel.lezcano@linaro.org
Cc: linux-sh@vger.kernel.org, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, magnus.damm@gmail.com, Keita Kobayashi <keita.kobayashi.ym@renesas.com>

Define ARM_RCAR_CPUIDLE config item to enable cpuidle
support for Renesas R-Car Gen2 SoCs.

Signed-off-by: Keita Kobayashi <keita.kobayashi.ym@renesas.com>
---
 drivers/cpuidle/Kconfig.arm | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/cpuidle/Kconfig.arm b/drivers/cpuidle/Kconfig.arm
index 21340e0..1bff62e 100644
--- a/drivers/cpuidle/Kconfig.arm
+++ b/drivers/cpuidle/Kconfig.arm
@@ -74,3 +74,11 @@ config ARM_MVEBU_V7_CPUIDLE
 	depends on ARCH_MVEBU && !ARM64
 	help
 	  Select this to enable cpuidle on Armada 370, 38x and XP processors.
+
+config ARM_RCAR_CPUIDLE
+	bool "CPU Idle Driver for the R-Car SoCs"
+	depends on ARCH_RCAR_GEN2
+	depends on ARM_CPUIDLE
+	select ARM_CPU_SUSPEND
+	help
+	  Select this to enable cpuidle for R-Car SoCs
-- 
1.9.1

