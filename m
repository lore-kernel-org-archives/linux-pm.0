From: Marc Gonzalez <marc_gonzalez@sigmadesigns.com>
Subject: [RFC PATCH v2] ARM: tango: add Suspend-to-RAM support
Date: Thu, 30 Jun 2016 10:44:14 +0200
Message-ID: <5774DBDE.1070605@sigmadesigns.com>
References: <5773D3FB.4030101@sigmadesigns.com> <577409E2.7020106@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from a.mx.sdesigns.eu ([78.31.43.6]:57551 "EHLO a.mx.sdesigns.eu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752171AbcF3IoS (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Thu, 30 Jun 2016 04:44:18 -0400
In-Reply-To: <577409E2.7020106@arm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Sudeep Holla <sudeep.holla@arm.com>, linux-pm <linux-pm@vger.kernel.org>, Linux ARM <linux-arm-kernel@lists.infradead.org>
Cc: Mark Rutland <mark.rutland@arm.com>, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, Kevin Hilman <khilman@kernel.org>, Thibaud Cornic <thibaud_cornic@sigmadesigns.com>, Mason <slash.tmp@free.fr>, Sebastian Frias <sf84@laposte.net>, Robin Murphy <robin.murphy@arm.com>

Ask firmware to put RAM in self-refresh mode and power system down.

    echo mem > /sys/power/state

See Documentation/power/states.txt

Signed-off-by: Marc Gonzalez <marc_gonzalez@sigmadesigns.com>
---

This is a RFC because I have a few doubts:

1) return value when tango_suspend() fails and unexpectedly returns (I used -EIO)
Is there a better error to return?

2) conditionally building pm.c (using CONFIG_SUSPEND? CONFIG_PM_SLEEP? other?)
Is there a better config knob to use?

3) .valid is required, right?
AFAICS, the answer is "yes", .valid is indeed required:
("no valid callback implies that none are valid")

static bool valid_state(suspend_state_t state)
{
	/*
	 * PM_SUSPEND_STANDBY and PM_SUSPEND_MEM states need low level
	 * support and need to be valid to the low level
	 * implementation, no valid callback implies that none are valid.
	 */
	return suspend_ops && suspend_ops->valid && suspend_ops->valid(state);
}

---
 arch/arm/mach-tango/Makefile |  1 +
 arch/arm/mach-tango/pm.c     | 32 ++++++++++++++++++++++++++++++++
 arch/arm/mach-tango/smc.h    |  1 +
 3 files changed, 34 insertions(+)
 create mode 100644 arch/arm/mach-tango/pm.c

diff --git a/arch/arm/mach-tango/Makefile b/arch/arm/mach-tango/Makefile
index 7ca753aa9fb6..822b7ca803c6 100644
--- a/arch/arm/mach-tango/Makefile
+++ b/arch/arm/mach-tango/Makefile
@@ -3,3 +3,4 @@ AFLAGS_smc.o := -Wa,-march=armv7-a$(plus_sec)
 
 obj-y += setup.o smc.o xenv.o
 obj-$(CONFIG_SMP) += platsmp.o
+obj-$(CONFIG_SUSPEND) += pm.o
diff --git a/arch/arm/mach-tango/pm.c b/arch/arm/mach-tango/pm.c
new file mode 100644
index 000000000000..b05c6d6f99d0
--- /dev/null
+++ b/arch/arm/mach-tango/pm.c
@@ -0,0 +1,32 @@
+#include <linux/init.h>
+#include <linux/suspend.h>
+#include <asm/suspend.h>
+#include "smc.h"
+
+static int tango_pm_powerdown(unsigned long arg)
+{
+	tango_suspend(virt_to_phys(cpu_resume));
+
+	return -EIO; /* tango_suspend has failed */
+}
+
+static int tango_pm_enter(suspend_state_t state)
+{
+	if (state == PM_SUSPEND_MEM)
+		return cpu_suspend(0, tango_pm_powerdown);
+
+	return -EINVAL;
+}
+
+static const struct platform_suspend_ops tango_pm_ops = {
+	.enter = tango_pm_enter,
+	.valid = suspend_valid_only_mem,
+};
+
+static int __init tango_pm_init(void)
+{
+	suspend_set_ops(&tango_pm_ops);
+	return 0;
+}
+
+late_initcall(tango_pm_init);
diff --git a/arch/arm/mach-tango/smc.h b/arch/arm/mach-tango/smc.h
index 3d31f984f44c..57919539da1b 100644
--- a/arch/arm/mach-tango/smc.h
+++ b/arch/arm/mach-tango/smc.h
@@ -3,5 +3,6 @@ extern int tango_smc(unsigned int val, unsigned int service);
 #define tango_set_l2_control(val)	tango_smc(val, 0x102)
 #define tango_start_aux_core(val)	tango_smc(val, 0x104)
 #define tango_set_aux_boot_addr(val)	tango_smc(val, 0x105)
+#define tango_suspend(val)		tango_smc(val, 0x120)
 #define tango_aux_core_die(val)		tango_smc(val, 0x121)
 #define tango_aux_core_kill(val)	tango_smc(val, 0x122)
-- 
2.9.0
