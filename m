From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: [PATCH 2/2] cpuidle / calxeda: remove redundant Kconfig option
Date: Tue, 12 Mar 2013 10:27:56 +0100
Message-ID: <1363080476-26555-2-git-send-email-daniel.lezcano@linaro.org>
References: <1363080476-26555-1-git-send-email-daniel.lezcano@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-we0-f182.google.com ([74.125.82.182]:51007 "EHLO
	mail-we0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755236Ab3CLJ2C (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 12 Mar 2013 05:28:02 -0400
Received: by mail-we0-f182.google.com with SMTP id t57so4563062wey.13
        for <linux-pm@vger.kernel.org>; Tue, 12 Mar 2013 02:28:00 -0700 (PDT)
In-Reply-To: <1363080476-26555-1-git-send-email-daniel.lezcano@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: rjw@sisk.pl
Cc: linux-pm@vger.kernel.org, patches@linaro.org, linaro-kernel@lists.linaro.org, linux-arm-kernel@lists.infradead.org

When the CPU_IDLE and the ARCH_HIGHBANK options are set it is
pointless to define a new option CPU_IDLE_CALXEDA because it
is redundant.

The Makefile drivers directory contains a condition to compile
the cpuidle drivers:

obj-$(CONFIG_CPU_IDLE)          += cpuidle/

Hence, if CPU_IDLE is not set we won't enter this directory.

This patch removes the useless Kconfig option and replaces the
condition in the Makefile by CONFIG_ARCH_HIGHBANK.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/cpuidle/Kconfig  |   10 ----------
 drivers/cpuidle/Makefile |    2 +-
 2 files changed, 1 insertion(+), 11 deletions(-)

diff --git a/drivers/cpuidle/Kconfig b/drivers/cpuidle/Kconfig
index c4cc27e..234ae65 100644
--- a/drivers/cpuidle/Kconfig
+++ b/drivers/cpuidle/Kconfig
@@ -30,13 +30,3 @@ config CPU_IDLE_GOV_MENU
 
 config ARCH_NEEDS_CPU_IDLE_COUPLED
 	def_bool n
-
-if CPU_IDLE
-
-config CPU_IDLE_CALXEDA
-	bool "CPU Idle Driver for Calxeda processors"
-	depends on ARCH_HIGHBANK
-	help
-	  Select this to enable cpuidle on Calxeda processors.
-
-endif
diff --git a/drivers/cpuidle/Makefile b/drivers/cpuidle/Makefile
index 0d8bd55..d1aba71 100644
--- a/drivers/cpuidle/Makefile
+++ b/drivers/cpuidle/Makefile
@@ -5,5 +5,5 @@
 obj-y += cpuidle.o driver.o governor.o sysfs.o governors/
 obj-$(CONFIG_ARCH_NEEDS_CPU_IDLE_COUPLED) += coupled.o
 
-obj-$(CONFIG_CPU_IDLE_CALXEDA) += cpuidle-calxeda.o
+obj-$(CONFIG_ARCH_HIGHBANK) += cpuidle-calxeda.o
 obj-$(CONFIG_ARCH_KIRKWOOD) += cpuidle-kirkwood.o
-- 
1.7.9.5

