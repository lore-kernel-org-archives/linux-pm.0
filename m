From: Mark Brown <broonie@kernel.org>
Subject: [PATCH] PM: Provide a config snippet for disabling PM
Date: Sun, 12 Nov 2017 13:26:06 +0000
Message-ID: <20171112132606.29910-1-broonie@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J . Wysocki" <rjw@rjwysocki.net>
Cc: linux-pm@vger.kernel.org, Kevin Hilman <khilman@baylibre.com>, linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
List-Id: linux-pm@vger.kernel.org

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
index 0630482e701b..81851e3d6cbe 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -10805,6 +10805,7 @@ F:	include/linux/pm.h
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
2.14.1
