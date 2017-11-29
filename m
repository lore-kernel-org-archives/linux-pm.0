From: Mark Brown <broonie@kernel.org>
Subject: [PATCH] PM: Provide a config snippet for disabling PM
Date: Wed, 29 Nov 2017 11:12:27 +0000
Message-ID: <20171129111227.26798-1-broonie@kernel.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:38402 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752270AbdK2LMk (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 29 Nov 2017 06:12:40 -0500
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J . Wysocki" <rjw@rjwysocki.net>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Kevin Hilman <khilman@baylibre.com>, Fengguang Wu <fengguang.wu@intel.com>, Mark Brown <broonie@kernel.org>

A frequent source of build problems is poor handling of optional PM
support, almost all development is done with the PM options enabled
but they can be turned off.  Currently few if any of the build test
services do this as standard as there is no standard config for it and
the use of selects and def_bool means that simply setting CONFIG_PM=n
doesn't do what is expected.  To make this easier provide a fragement
that can be used with KCONFIG_ALLCONFIG to force PM off.

CONFIG_XEN is disabled as Xen uses hibernation callbacks which end up
turning on power management on architectures with Xen.  Some cpuidle
implementations on ARM select PM so CONFIG_CPU_IDLE is disabled, and
some ARM architectures unconditionally enable PM so they are also
disabled.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 MAINTAINERS                |  1 +
 kernel/configs/nopm.config | 15 +++++++++++++++
 2 files changed, 16 insertions(+)
 create mode 100644 kernel/configs/nopm.config

diff --git a/MAINTAINERS b/MAINTAINERS
index 07d9067f68fd..539808dc7928 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -10895,6 +10895,7 @@ F:	include/linux/pm.h
 F:	include/linux/pm_*
 F:	include/linux/powercap.h
 F:	drivers/powercap/
+F:	kernel/configs/nopm.config
 
 POWER STATE COORDINATION INTERFACE (PSCI)
 M:	Mark Rutland <mark.rutland@arm.com>
diff --git a/kernel/configs/nopm.config b/kernel/configs/nopm.config
new file mode 100644
index 000000000000..81ff07863576
--- /dev/null
+++ b/kernel/configs/nopm.config
@@ -0,0 +1,15 @@
+CONFIG_PM=n
+CONFIG_SUSPEND=n
+CONFIG_HIBERNATION=n
+
+# Triggers PM on OMAP
+CONFIG_CPU_IDLE=n
+
+# Triggers enablement via hibernate callbacks
+CONFIG_XEN=n
+
+# ARM/ARM64 architectures that select PM unconditionally
+CONFIG_ARCH_OMAP2PLUS_TYPICAL=n
+CONFIG_ARCH_RENESAS=n
+CONFIG_ARCH_TEGRA=n
+CONFIG_ARCH_VEXPRESS=n
-- 
2.15.0
