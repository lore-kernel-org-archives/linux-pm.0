From: Luis de Bethencourt <luisbg@osg.samsung.com>
Subject: [PATCH] thermal: kconfig: When possible, compile drivers with COMPILE_TEST
Date: Wed, 14 Oct 2015 17:16:20 +0100
Message-ID: <1444839380-29236-1-git-send-email-luisbg@osg.samsung.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from lists.s-osg.org ([54.187.51.154]:53305 "EHLO lists.s-osg.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754284AbbJNQQc (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Wed, 14 Oct 2015 12:16:32 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: rui.zhang@intel.com, edubezval@gmail.com, linux-pm@vger.kernel.org, javier@osg.samsung.com, Luis de Bethencourt <luisbg@osg.samsung.com>

These drivers only have runtime but no build time dependencies, so they can
be built for testing purposes if the Kconfig COMPILE_TEST option is enabled.

This is useful to have more build coverage and make sure that drivers are
not affected by changes that could cause build regressions.

Signed-off-by: Luis de Bethencourt <luisbg@osg.samsung.com>
---
 drivers/thermal/Kconfig | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/thermal/Kconfig b/drivers/thermal/Kconfig
index a94ebb5..844c219 100644
--- a/drivers/thermal/Kconfig
+++ b/drivers/thermal/Kconfig
@@ -252,7 +252,7 @@ config TEGRA_SOCTHERM
 
 config DB8500_CPUFREQ_COOLING
 	tristate "DB8500 cpufreq cooling"
-	depends on ARCH_U8500
+	depends on ARCH_U8500 || COMPILE_TEST
 	depends on CPU_THERMAL
 	default y
 	help
@@ -309,7 +309,7 @@ config INTEL_SOC_DTS_THERMAL
 
 config INTEL_QUARK_DTS_THERMAL
 	tristate "Intel Quark DTS thermal driver"
-	depends on X86_INTEL_QUARK
+	depends on X86_INTEL_QUARK || COMPILE_TEST
 	help
 	  Enable this to register Intel Quark SoC (e.g. X1000) platform digital
 	  temperature sensor (DTS). For X1000 SoC, it has one on-die DTS.
-- 
2.5.1

