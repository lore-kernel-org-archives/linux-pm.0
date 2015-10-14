From: Luis de Bethencourt <luisbg@osg.samsung.com>
Subject: [PATCH v2] thermal: db8500_cpufreq_cooling: Compile with COMPILE_TEST
Date: Wed, 14 Oct 2015 19:43:29 +0100
Message-ID: <1444848209-17552-1-git-send-email-luisbg@osg.samsung.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from lists.s-osg.org ([54.187.51.154]:53922 "EHLO lists.s-osg.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751919AbbJNSnp (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Wed, 14 Oct 2015 14:43:45 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: rui.zhang@intel.com, edubezval@gmail.com, linux-pm@vger.kernel.org, javier@osg.samsung.com, Luis de Bethencourt <luisbg@osg.samsung.com>

This driver only has runtime but no build time dependencies, so it can be
built for testing purposes if the Kconfig COMPILE_TEST option is enabled.

This is useful to have more build coverage and make sure that drivers are
not affected by changes that could cause build regressions.

Signed-off-by: Luis de Bethencourt <luisbg@osg.samsung.com>
---

Hi,

This is the second version of:
https://lkml.org/lkml/2015/10/14/691

After removing COMPILE_TEST for INTEL_QUARK_DTS_THERMAL, only
DB8500_CPUFREQ_COOLING remains. Which is why I have changed the subject line
of the commit message.

Sorry for the kbuild test robot failure in the first version.

Thanks,
Luis

 drivers/thermal/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/thermal/Kconfig b/drivers/thermal/Kconfig
index a94ebb5..cdaf469 100644
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
-- 
2.5.1

