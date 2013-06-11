From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: [PATCH] cpuidle: Fix ARCH_NEEDS_CPU_IDLE_COUPLED dependency warning
Date: Tue, 11 Jun 2013 10:09:45 +0200
Message-ID: <1370938185-5019-1-git-send-email-daniel.lezcano@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-we0-f180.google.com ([74.125.82.180]:43317 "EHLO
	mail-we0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752380Ab3FKIJr (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 11 Jun 2013 04:09:47 -0400
Received: by mail-we0-f180.google.com with SMTP id w56so5465876wes.25
        for <linux-pm@vger.kernel.org>; Tue, 11 Jun 2013 01:09:45 -0700 (PDT)
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: rjw@rjwysocki.net
Cc: linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, arnd@arndb.de, ccross@android.com

Before the commit d6f346f2d2bf511c2c59176121a6e42ce60173a0, the
ARCH_NEEDS_CPU_IDLE_COUPLED option was not depending on the CPU_IDLE but now
it has been moved under the CPU_IDLE menuconfig option.

That raises the following warnings:

warning: (ARCH_OMAP4 && ARCH_TEGRA_2x_SOC) selects ARCH_NEEDS_CPU_IDLE_COUPLED
which has unmet direct dependencies (CPU_IDLE)
warning: (ARCH_OMAP4 && ARCH_TEGRA_2x_SOC) selects ARCH_NEEDS_CPU_IDLE_COUPLED
which has unmet direct dependencies (CPU_IDLE)

The tegra2 and omap4 Kconfig files select this option but without checking
CPU_IDLE is set.

Fix that by moving the option out of the CPU_IDLE option.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/cpuidle/Kconfig |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/cpuidle/Kconfig b/drivers/cpuidle/Kconfig
index a7d2e83..81de5d9 100644
--- a/drivers/cpuidle/Kconfig
+++ b/drivers/cpuidle/Kconfig
@@ -29,9 +29,6 @@ config CPU_IDLE_GOV_MENU
 	bool "Menu governor (for tickless system)"
 	default y
 
-config ARCH_NEEDS_CPU_IDLE_COUPLED
-	def_bool n
-
 config CPU_IDLE_CALXEDA
 	bool "CPU Idle Driver for Calxeda processors"
 	depends on ARCH_HIGHBANK
@@ -45,3 +42,6 @@ config CPU_IDLE_ZYNQ
 	  Select this to enable cpuidle on Xilinx Zynq processors.
 
 endif
+
+config ARCH_NEEDS_CPU_IDLE_COUPLED
+	def_bool n
-- 
1.7.9.5

